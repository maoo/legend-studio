/**
 * Copyright (c) 2020-present, Goldman Sachs
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import { LegendTaxonomy } from '@finos/legend-taxonomy';
import { WebConsole } from '@finos/legend-shared';
import { getLegendGraphExtensionCollection } from '@finos/legend-graph-extension-collection';

export class LegendTaxonomyWebApplication {
  static run(baseUrl: string): void {
    LegendTaxonomy.create()
      .setup({ baseUrl })
      .withPresets(getLegendGraphExtensionCollection())
      .withPlugins([
        // loggers
        new WebConsole(),
      ])
      .start()
      .catch((e: unknown) => {
        throw e;
      });
  }
}
