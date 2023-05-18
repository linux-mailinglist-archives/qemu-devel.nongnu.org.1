Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B73708860
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 21:36:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzjOh-0007H4-Jb; Thu, 18 May 2023 15:34:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chaosdefinition@hotmail.com>)
 id 1pzjOd-0007Gd-6c; Thu, 18 May 2023 15:34:43 -0400
Received: from mail-dm6nam10olkn2081b.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::81b]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chaosdefinition@hotmail.com>)
 id 1pzjOb-00080p-Fz; Thu, 18 May 2023 15:34:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ggI1cUxDKXwKRlEIloT5RL8lzc1ZzlSRMH6yGvpbH1d4FAzibSFkGnYkFjAdJCBUspWsArxxqlvWGfxNoTARfPUOWXRK94t726miHdp2T3PFkiGGGzcfzX1MAmFy+0q3kzwqLlQEsrK21iwLYDCVol2MPWOIkTz9PRWec4jSPfrVB3bwkHXUl7lx054YYu3z/SZprLqIsonZhYDJIRESniEUilP1r88zxrHNT+1Sb8ZDFXBD3UiGwJM6QkStyBKAPPsI/6fXW/gbL+ojXQhtkPE+kaWbrjMNljlH9aOgoFlMZkRPShG/fiqBNW+DQbbgmXGkTqT3+52FN9cvindHPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tCXqGvdsm/o9zsYpTHfGeRXPFgyuKD9aLiHI6IONEpw=;
 b=W5IP6B6rHu1eSWbR15b0hN2SUq2hJeyvUEdcH3cioBd2juaw/ecwX4bqNPCJwiRT4e3qoYfD2PB+NdG/mjm6urITi2Xnj9BOvqc2iXhMvu4P18bFSdr+/sMnAJiLI4l4yVzbx46TD3Z/Krm4cLAPNotY2o3dC+cxhxZiQm4o62QvIryhmOCcI3EesROSzmIrf64OjqazeXgscV9+G93wK/mtXhN5gRuUANqEZEqq910DUUyvPG/ZvPjO4M4Y2KPMo9mAr/AO1IN9n3GHxJuX4lhhvrJb6oed060LYpTDfTp9PLb0CAshjwVcRFxgE3MI1g6juEYnpIKBSUkK8NP5bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tCXqGvdsm/o9zsYpTHfGeRXPFgyuKD9aLiHI6IONEpw=;
 b=UuIrogePljZ2yIZ97GyqtQEQVnS9ArIgQ9a0aEG9WD6xup29ALAKtKVGQSTSJP6xUD0DKkx+RHZ6JRt0eHx6tDnNHLTWUR9slGxWNUV2ygTnQkgYI/AlSfqWl1uEcdRJ01FIBVKvAk34V2hJwPFBIpWoRyEdJ0chgyDhnwVjFRa1P7wWfCyscem1En4psF7BA+y1Xl8GMyCaI1vSS72o2cAULVMQnDqcTnUWtq+lsuhfdapywI/Fx3yRiuiavWhMXUWgbix3ckqDCFEyxaX911yhUS2Vx2caLWG5ntKIM3CFh+BLEcTd64PnoZJFSDJSKhkYkkNTgF7SAgIkopIn7Q==
Received: from DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) by
 MW3PR12MB4460.namprd12.prod.outlook.com (2603:10b6:303:2f::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.33; Thu, 18 May 2023 19:34:38 +0000
Received: from DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::bf6e:1dc2:10ea:cc04]) by DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::bf6e:1dc2:10ea:cc04%3]) with mapi id 15.20.6387.033; Thu, 18 May 2023
 19:34:37 +0000
Date: Thu, 18 May 2023 12:34:34 -0700
From: Zhuojia Shen <chaosdefinition@hotmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Beata Michalska <beata.michalska@linaro.org>, qemu-arm@nongnu.org
Subject: Re: [PATCH v2] target/arm: allow DC CVA[D]P in user mode emulation
Message-ID: <DS7PR12MB630932847E7D525E12D517DFAC7F9@DS7PR12MB6309.namprd12.prod.outlook.com>
References: <DS7PR12MB6309A0F097FA4FB9D7CACB5BAC7E9@DS7PR12MB6309.namprd12.prod.outlook.com>
 <6051fefc-a5b0-0c45-b1a9-ebdf2717caa7@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6051fefc-a5b0-0c45-b1a9-ebdf2717caa7@linaro.org>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-TMN: [tNXU17A8hUjvTFRrYGEM+0qirGKrI7or]
X-ClientProxiedBy: SJ0PR13CA0199.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::24) To DS7PR12MB6309.namprd12.prod.outlook.com
 (2603:10b6:8:96::19)
X-Microsoft-Original-Message-ID: <ZGZ9yvcOqbGjjk8z@manjaro-vmryzen>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6309:EE_|MW3PR12MB4460:EE_
X-MS-Office365-Filtering-Correlation-Id: 039f597a-aac9-416e-1cfd-08db57d6ea9a
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IdnLQhj19o6zv9kQeRRJ4yk4UzLVaO7wz6UHk1l4+hbf+DOuCIhgMg9fYJQqkf4WWHShFgstZyPkYNtoTHpyw8YvtBOOmQBEdv9ejQD9Yur7ngJcVunAXoG/XGieWcxBinfT3IHoMdSChmGZAUT1YuXfMTX5iG8SS29TyooHBvS60TMZvYka8yCjAJxf9DId6uOn1nKfx9vouOZuH/1BoviNo4jUPCy1P58cul6Dpxd3eIOROs8xu+Q7lZ8RA3MH9W1ohJ+nXhrspHigxoqmhU60VreZnXVL+F2/TsU+N+2Ik6LkSNaahDqfGLLdw4ZfyrPzM7T8Mx+k/jKPyE5apHOBaQGjMomAjAtXwfXwla1/R/qxmkO0yYTe/m7HLfgj+cKaVK468AqMz2CIiWV6OSoCw+jSPboqBr3Dg7/A76B9xKzwR4RwnVzypIxAEJywTN2c98KFs4+jfu+r3PUxQXGJYF8K+9tkvwaWt69etJ4F1+tS1cUehtMFgLOXtR61PZOloIa/jYipwbeYgYmVYOKiBKB2L+M60gQKD+5U/W/8p61moQt0Q4IKO7IM1qxCtJB1pZH5NCcrqtUT1Va4Oq6+uqj8Tl4NiYSs5r4mb14=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3hCUGVESlRjUUJRb0w1a0lCbGR4a2lWRGc5czdQV0FUeXljeE5hNitxYnl6?=
 =?utf-8?B?YTdwclpjeU5oMXh2bGFMNjMyWW9IeVB5T2ZUYlh3aXBlSzhPc3IrQytKbGxV?=
 =?utf-8?B?c3o3dUNBdVFaWFQ2OUR0aGtHYk0ySHNkTmt1YW1RdEx3eWtJUXYvNmRHZ0pJ?=
 =?utf-8?B?bzdORDNUcCs0MFNkaFlkRmNjeUx6Qk9ENlZ1ZFlWTTZtTUsyNnZLNHJicmpG?=
 =?utf-8?B?TU04V0RNbHdydUFMeFB2Rk52S3FZck1CRzl4VlpSL3JSZnJEWlN5eHdSOEN1?=
 =?utf-8?B?TWlNNHNYQnFvNjJlZ2hCZUlGTVNuQnJ0clhtRnFBSkhDbUJkU0krSThTenNX?=
 =?utf-8?B?M01vakhiUlMrbGNwV28yN3VkYmUya3VrZVU2QzB5V0lLd3dINXZOZWU3d3o1?=
 =?utf-8?B?WkVxZE9ycmFJSU43QlFkb1NKcVJ2OG00eGJaczh3Nmt1NXUwR29WdkxHL2ZM?=
 =?utf-8?B?OUxIMzZrdjN6ek9lcnFBdlV4cE1ZeWc1amIvUzFKbm9CdklnZStSazh3VzBZ?=
 =?utf-8?B?K3UrUlJqQ01YNnRSMGgyL2xoV2EzTEZYSjNuWkpFWTkvMnIweVBkdE5OV1hL?=
 =?utf-8?B?NFlXb0xISTFacCtkNVp2aG1XbC92ZWdpVmcrcWExQzJFdnVYb2NrTmF0YkNt?=
 =?utf-8?B?ZHo3UHZxMXJWdUpmc1k3a2NaWDdmRUlScVVSQXVqT2ZOOWFKNzVPTmhyQVAv?=
 =?utf-8?B?Y2QxY29mNmdHb3czL1ZncXRGWFBJRWFZU1hQY280WC9XajhtVnc2bU5vaWRu?=
 =?utf-8?B?TTRDUFhsRVFPTVVnTHBhQ050eEVtTXNJRUVNWWFXMDZUNkdRdDA3TmdvY1V5?=
 =?utf-8?B?REpYM01saGl5M0hVZ2tIQjY0N09DWEpmRUpTNHJ5SmlCcDBUVnJaMGduT3Qv?=
 =?utf-8?B?M1JQU29RNWFJVnBScXhld0pveHZYdnY3VU9RT2M2aUoxSTVNQ3I0V3lEM1c0?=
 =?utf-8?B?cm9xUWY1TXl2M0ROaVI3Y3orWXBja1FPMk5vQU8vdmIrQTNXQTRVTmwyeHhO?=
 =?utf-8?B?T0k1ZmxnazR2dTFIM0NpMVJKU0tiaU1GR1FaTDBqSnVxSldncXRvZC81dVU2?=
 =?utf-8?B?dkdqVGVpWDlzanhhcC9xeTloaGh1YVRJQ1lqR2NTUFhmT24zTW9LMXBkWVhX?=
 =?utf-8?B?YUVXcE1XVUUyWlRjU05UcTRBajZ1eFZkei9OUTE3V2NTZ1RZVnkrWWM2ODhJ?=
 =?utf-8?B?eGZCaDRueTlSckxIVkFuZkdHSFV6ZjI5OUt1RDZ3LzEyQXIrWFhnUGMzb0dQ?=
 =?utf-8?B?SkVtYmM4RDgwTXZDdUhYcmlUSnBUSm5NREd5TWViSmpjWmI1Y1BaYzRmcjMz?=
 =?utf-8?B?STFqRzhBWEkrOVd0Nk9vY1Uwc1ZRNE8xbVdIWmF4RlBmdXIydkpXaEY3MTli?=
 =?utf-8?B?YU5iWDhiUEtiVzZlNFhKeGJDU2w2YUVZWXA5VzVjWkwzOTR3Slc3bGk5T3lB?=
 =?utf-8?B?aHdEY1dTU2ZWVXl6M01HZzdhRXNzNFh4aGFPcUozV2x2dzB6eWxBV0FFRTFQ?=
 =?utf-8?B?WHUzc2kzT3VabkhNQjhJL0pkN0YzS25mVVRVV21nazR5ZUJxd1VpdXlnV1Br?=
 =?utf-8?B?cjJYT2JLUGE0b25waFppSHB6NCtLOEpYeVZZVWhGSkRiMmVjcDc1WGFUcTMx?=
 =?utf-8?Q?yL8grngItk7T8Z86weWzFteqdDVXAyJhs4D1ltl9o774=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-71ea3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 039f597a-aac9-416e-1cfd-08db57d6ea9a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 19:34:37.9406 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4460
Received-SPF: pass client-ip=2a01:111:f400:7e88::81b;
 envelope-from=chaosdefinition@hotmail.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 05/17/2023 12:51 PM -0700, Richard Henderson wrote:
> On 5/17/23 10:31, Zhuojia Shen wrote:
> > DC CVAP and DC CVADP instructions can be executed in EL0 on Linux,
> > either directly when SCTLR_EL1.UCI == 1 or emulated by the kernel (see
> > user_cache_maint_handler() in arch/arm64/kernel/traps.c).
> > 
> > This patch enables execution of the two instructions in user mode
> > emulation.
> > 
> > Signed-off-by: Zhuojia Shen <chaosdefinition@hotmail.com>
> > ---
> >   target/arm/helper.c               |  6 ++--
> >   tests/tcg/aarch64/Makefile.target | 11 ++++++++
> >   tests/tcg/aarch64/dcpodp-1.c      | 47 +++++++++++++++++++++++++++++++
> >   tests/tcg/aarch64/dcpodp-2.c      | 47 +++++++++++++++++++++++++++++++
> >   tests/tcg/aarch64/dcpop-1.c       | 47 +++++++++++++++++++++++++++++++
> >   tests/tcg/aarch64/dcpop-2.c       | 47 +++++++++++++++++++++++++++++++
> >   6 files changed, 201 insertions(+), 4 deletions(-)
> >   create mode 100644 tests/tcg/aarch64/dcpodp-1.c
> >   create mode 100644 tests/tcg/aarch64/dcpodp-2.c
> >   create mode 100644 tests/tcg/aarch64/dcpop-1.c
> >   create mode 100644 tests/tcg/aarch64/dcpop-2.c
> 
> I recommend splitting the tests to a second patch.

Will do.

> 
>  +++ b/tests/tcg/aarch64/dcpodp-1.c
> > @@ -0,0 +1,47 @@
> > +/* Test execution of DC CVADP instruction */
> > +
> > +#include <asm/hwcap.h>
> > +#include <sys/auxv.h>
> > +
> > +#include <signal.h>
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +
> > +#ifndef HWCAP2_DCPODP
> > +#define HWCAP2_DCPODP (1 << 0)
> > +#endif
> > +
> > +static void signal_handler(int sig)
> > +{
> > +    exit(EXIT_FAILURE);
> > +}
> > +
> > +static int do_dc_cvadp(void)
> > +{
> > +    struct sigaction sa = {
> > +        .sa_handler = signal_handler,
> > +    };
> > +
> > +    if (sigaction(SIGILL, &sa, NULL) < 0) {
> > +        perror("sigaction");
> > +        return EXIT_FAILURE;
> > +    }
> > +    if (sigaction(SIGSEGV, &sa, NULL) < 0) {
> > +        perror("sigaction");
> > +        return EXIT_FAILURE;
> > +    }
> > +
> > +    asm volatile("dc cvadp, %0\n\t" :: "r"(&sa));
> > +
> > +    return EXIT_SUCCESS;
> > +}
> 
> ...
> 
> > diff --git a/tests/tcg/aarch64/dcpodp-2.c b/tests/tcg/aarch64/dcpodp-2.c
> > new file mode 100644
> > index 0000000000..3245d7883d
> > --- /dev/null
> > +++ b/tests/tcg/aarch64/dcpodp-2.c
> > @@ -0,0 +1,47 @@
> > +/* Test execution of DC CVADP instruction on unmapped address */
> > +
> > +#include <asm/hwcap.h>
> > +#include <sys/auxv.h>
> > +
> > +#include <signal.h>
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +
> > +#ifndef HWCAP2_DCPODP
> > +#define HWCAP2_DCPODP (1 << 0)
> > +#endif
> > +
> > +static void signal_handler(int sig)
> > +{
> > +    exit(EXIT_SUCCESS);
> > +}
> > +
> > +static int do_dc_cvadp(void)
> > +{
> > +    struct sigaction sa = {
> > +        .sa_handler = signal_handler,
> > +    };
> > +
> > +    if (sigaction(SIGILL, &sa, NULL) < 0) {
> > +        perror("sigaction");
> > +        return EXIT_FAILURE;
> > +    }
> 
> This isn't: if SIGILL, exit with success.
> 
> You don't actually need to register anything for SIGILL, in either test,
> because SIGILL is a fine exit for failure.  So is SIGSEGV for test 1.
> 

Thanks!  Will update in the second patch.

> Also, you could merge all 4 tests and save some CI time.

Tests for CVAP and CVADP require different CFLAGS; I'll merge them into
2 tests.

> 
> 
> r~
> 

