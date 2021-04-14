import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document } from 'mongoose';

@Schema()
export class Socials {
  @Prop()
  discord: string;
  @Prop()
  twitter: string;
  @Prop()
  linkedin: string;
  @Prop()
  github: string;
}

@Schema()
export class Discorduser {
  @Prop()
  username: string;
  @Prop()
  bio: string;
  @Prop()
  socials: Socials;
}

export type DiscorduserDocument = Discorduser & Document;

export const DiscorduserSchema = SchemaFactory.createForClass(Discorduser);
