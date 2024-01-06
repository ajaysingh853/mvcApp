
FROM mcr.microsoft.com/dotnet/sdk:7.0 as build

WORKDIR /app

COPY *.csproj ./

RUN dotnet restore

COPY . ./

RUN dotnet publish -c Release -o publish

FROM mcr.microsoft.com/dotnet/sdk:7.0 as final

WORKDIR /app

COPY --from=build /app/publish .

EXPOSE 8000

ENTRYPOINT ["dotnet", "mvcApp.dll"]