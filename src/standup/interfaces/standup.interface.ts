import { Author } from '../../util/getAuthorFromHeaders.decorator';

export interface Standup {
  yesterdayMessage: string;
  todayMessage: string;
  author: StandupAuthor;
  createdOn: Date;
}
export interface StandupAuthor extends Author {
  platform: string;
  uid: string;
}
