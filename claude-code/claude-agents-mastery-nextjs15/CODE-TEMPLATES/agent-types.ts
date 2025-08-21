import { z } from 'zod';

export const AgentInputSchema = z.object({
  task: z.string(),
  context: z.record(z.any()).optional(),
  priority: z.enum(['low', 'medium', 'high']).default('medium')
});

export type AgentInput = z.infer<typeof AgentInputSchema>;