

FROM mcr.microsoft.com/dotnet/core/sdk:2.2 AS build
WORKDIR /aspnet
COPY ["DevopsWorld.Client/DevopsWorld.Client.csproj", "DevopsWorld.Client/"]
RUN dotnet restore "DevopsWorld.Client/DevopsWorld.Client.csproj"
COPY . .
WORKDIR /aspnet/DevopsWorld.Client
RUN dotnet build "DevopsWorld.Client.csproj"


FROM build AS publish
RUN dotnet publish "DevopsWorld.Client.csproj" --no-restore -c Release -o /app

FROM mcr.microsoft.com/dotnet/core/aspnet:2.2 
WORKDIR /deploy
COPY --from=publish /app .
CMD [ "dotnet", "DevopsWorld.Client.dll" ]

# FROM base AS final
# WORKDIR /app
# COPY --from=publish /app .
# ENTRYPOINT ["dotnet", "DevopsWorld.Client.dll"]
