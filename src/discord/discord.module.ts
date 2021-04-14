import { Module } from '@nestjs/common';
import { DiscordService } from './discord.service';
import { DiscordController } from './discord.controller';
import { MongooseModule } from '@nestjs/mongoose';
import { ConfigModule, ConfigService } from '@nestjs/config';

@Module({
  imports: [
    MongooseModule.forRootAsync({
      imports: [ConfigModule],
      connectionName: 'firstDB',
      useFactory: async (config: ConfigService) => ({
        uri: config.get('APP_MONGO_CONNECTION_STRING'),
      }),
      inject: [ConfigService],
    }),
  ],
  controllers: [DiscordController],
  providers: [DiscordService],
})
export class DiscordModule {}
