import {
  Controller,
  Get,
  Post,
  Body,
  Put,
  Param,
  Delete,
} from '@nestjs/common';
import { ApiTags } from '@nestjs/swagger';
import { DiscordService } from './discord.service';
import { CreateDiscordDto } from './dto/create-discord.dto';
import { UpdateDiscordDto } from './dto/update-discord.dto';

@ApiTags('Discord')
@Controller('discord')
export class DiscordController {
  constructor(private readonly discordService: DiscordService) {}

  @Post()
  async create(@Body() createDiscordDto: CreateDiscordDto) {
    return await this.discordService.create(createDiscordDto);
  }

  @Get()
  async findAll() {
    return await this.discordService.findAll();
  }

  @Get(':id')
  async findOne(@Param('id') id: string) {
    return await this.discordService.findOne(id);
  }

  @Put(':id')
  async update(
    @Param('id') id: string,
    @Body() updateDiscordDto: UpdateDiscordDto,
  ) {
    return await this.discordService.update(id, updateDiscordDto);
  }

  @Delete(':id')
  async remove(@Param('id') id: string) {
    return await this.discordService.remove(id);
  }
}
