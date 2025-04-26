using Microsoft.Azure.Functions.Worker.Builder;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;

var builder = FunctionsApplication.CreateBuilder(args);

builder.ConfigureFunctionsWebApplication();

var services = builder.Services;

services.AddLogging();
services.AddApplicationInsightsTelemetryWorkerService();
services.AddMemoryCache();
services.AddHealthChecks();

builder.Build().Run();
