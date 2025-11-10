# Build Stage
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /task
COPY ./ .
RUN dotnet publish -c Release src/Presentation/Nop.Web -o /app/published

# Runtime Stage
FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS runtime
WORKDIR /app
COPY --from=build /app/published ./
EXPOSE 5000
ENTRYPOINT ["dotnet", "Nop.Web.dll", "--urls", "http://0.0.0.0:5000"]
