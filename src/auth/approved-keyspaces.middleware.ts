import {
  HttpException,
  HttpStatus,
  Injectable,
  NestMiddleware,
} from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { Request, Response } from 'express';

@Injectable()
export class ApprovedKeyspacesMiddleware implements NestMiddleware {
  constructor(private readonly config: ConfigService) {}
  use(req: Request, res: Response, next: () => void) {
    const approvedKeyspaces: Array<string> = this.config
      .get('APPROVED_KEYSPACES')
      .split(',');
    const requestedKeyspace = req.headers.keyspace;

    if (!requestedKeyspace) {
      throw new HttpException('No Keyspace provided', HttpStatus.BAD_REQUEST);
    }

    if (!approvedKeyspaces.includes(requestedKeyspace.toString())) {
      throw new HttpException(
        'Requested Keyspace is not approved',
        HttpStatus.BAD_REQUEST,
      );
    }
    next();
  }
}
