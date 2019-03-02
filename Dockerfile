FROM microsoft/dotnet:2.2-aspnetcore-runtime AS base
WORKDIR /app

FROM microsoft/dotnet:2.2-sdk AS build
WORKDIR /src
COPY calcService.csproj calcService/
RUN dotnet restore calcService/calcService.csproj
WORKDIR /src/calcService
COPY . .
RUN dotnet build calcService.csproj -c Release -o /app

FROM build AS publish
RUN dotnet publish calcService.csproj -c Release -o /app

FROM base AS final
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "calcService.dll"]
