import { Module } from '@nestjs/common';
import { DiscordService } from './discord.service';
import { DiscordController } from './discord.controller';
import { MongooseModule } from '@nestjs/mongoose';
import { Discorduser, DiscorduserSchema } from './schemas/discorduser.schema';

@Module({
  imports: [
    MongooseModule.forFeature([
      { name: Discorduser.name, schema: DiscorduserSchema },
    ]),
  ],
  controllers: [DiscordController],
  providers: [DiscordService],
})
export class DiscordModule {}
