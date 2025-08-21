import { v4 as uuidv4 } from 'uuid';
import Anthropic from '@anthropic-ai/sdk';

export abstract class BaseAgent {
  public readonly id: string;
  protected client: Anthropic;
  
  constructor(protected config: AgentConfig) {
    this.id = uuidv4();
    this.client = new Anthropic({
      apiKey: process.env.ANTHROPIC_API_KEY!
    });
  }
  
  abstract execute(input: AgentInput): Promise<AgentOutput>;
}