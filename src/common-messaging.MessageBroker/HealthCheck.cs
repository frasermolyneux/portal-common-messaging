using System.Diagnostics.CodeAnalysis;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.Functions.Worker;
using Microsoft.Azure.Functions.Worker.Http;
using Microsoft.Extensions.Diagnostics.HealthChecks;

namespace XtremeIdiots.Portal.MessageBroker
{
    /// <summary>
    /// Provides a health check endpoint for the function app.
    /// </summary>
    [ExcludeFromCodeCoverage]
    public class HealthCheck
    {
        private readonly HealthCheckService _healthCheck;

        /// <summary>
        /// Initializes a new instance of the <see cref="HealthCheck"/> class.
        /// </summary>
        /// <param name="healthCheck">The health check service.</param>
        public HealthCheck(HealthCheckService healthCheck)
        {
            _healthCheck = healthCheck ?? throw new ArgumentNullException(nameof(healthCheck));
        }

        /// <summary>
        /// Executes the health check and returns the status.
        /// </summary>
        /// <param name="req">The HTTP request data.</param>
        /// <param name="context">The function execution context.</param>
        /// <returns>An OK result with the health status.</returns>
        [Function(nameof(HealthCheck))]
        public async Task<IActionResult> Run([HttpTrigger(AuthorizationLevel.Anonymous, "get", Route = "health")] HttpRequestData req,
            FunctionContext context)
        {
            var healthStatus = await _healthCheck.CheckHealthAsync();
            return new OkObjectResult(Enum.GetName(typeof(HealthStatus), healthStatus.Status));
        }
    }
}