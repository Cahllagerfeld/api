import { Injectable, HttpException, HttpStatus } from '@nestjs/common';
import { ReadDiscordDto } from './dto/read-discord.dto';
import { UpdateDiscordDto } from './dto/update-discord.dto';
import { CreateDiscordDto } from './dto/create-discord.dto';
import { InjectModel } from '@nestjs/mongoose';
import {
  Discorduser,
  DiscorduserDocument,
  Socials,
} from './schemas/discorduser.schema';
import { Model } from 'mongoose';

@Injectable()
export class DiscordService {
  constructor(
    @InjectModel(Discorduser.name)
    private DiscorduserModel: Model<DiscorduserDocument>,
  ) {}

  private discord: ReadDiscordDto[] = [];

  async create(createDiscordDto: CreateDiscordDto): Promise<Discorduser> {
    if (!createDiscordDto.username) {
      throw new HttpException('Incomplete Data', HttpStatus.BAD_REQUEST);
    }
    const createdDiscorduser = new this.DiscorduserModel(createDiscordDto);
    return createdDiscorduser.save();
  }

  async findAll(): Promise<DiscorduserDocument[]> {
    return this.DiscorduserModel.find().exec();
  }

  async findOne(id: string): Promise<DiscorduserDocument> {
    const discordUser = await this.DiscorduserModel.findById(id).exec();
    if (!discordUser) {
      throw new HttpException('User Not Found', HttpStatus.NOT_FOUND);
    }
    return discordUser;
  }

  async update(id: string, updateDiscordDto: UpdateDiscordDto) {
    const { username, bio, socials } = updateDiscordDto;

    const updateObject = new Discorduser();
    const updateSocials = new Socials();

    if (username) {
      updateObject.username = username;
    }
    if (bio) {
      updateObject.bio = bio;
    }

    if (socials && socials.discord) {
      updateSocials.discord = socials.discord;
    }
    if (socials && socials.twitter) {
      updateSocials.twitter = socials.twitter;
    }
    if (socials && socials.linkedin) {
      updateSocials.linkedin = socials.linkedin;
    }
    if (socials && socials.github) {
      updateSocials.github = socials.github;
    }
    updateObject.socials = updateSocials;

    const updated = await this.DiscorduserModel.findByIdAndUpdate(
      id,
      updateObject,
      { new: true, useFindAndModify: false },
    );
    if (!updated) {
      throw new HttpException('User Not Found', HttpStatus.NOT_FOUND);
    }

    return updated;
  }

  async remove(id: string) {
    // const updatedDiscord = this.discord.filter((user) => user.id !== id);
    const deleteItem = await this.DiscorduserModel.findByIdAndRemove(id, {
      useFindAndModify: false,
    });

    if (!deleteItem) {
      throw new HttpException('User Not Found', HttpStatus.NOT_FOUND);
    }
    // this.discord = [...updatedDiscord];
    return { message: 'Item deleted successfully' };
  }
}
