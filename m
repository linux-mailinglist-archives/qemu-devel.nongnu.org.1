Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBF2721885
	for <lists+qemu-devel@lfdr.de>; Sun,  4 Jun 2023 18:18:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5qQY-0006ip-6e; Sun, 04 Jun 2023 12:17:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1q5qQW-0006ie-60
 for qemu-devel@nongnu.org; Sun, 04 Jun 2023 12:17:56 -0400
Received: from mout.kundenserver.de ([212.227.126.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1q5qQS-0004rC-OD
 for qemu-devel@nongnu.org; Sun, 04 Jun 2023 12:17:54 -0400
Received: from [192.168.100.1] ([82.142.8.70]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1N9cDF-1q9IqW32Or-015YxN; Sun, 04 Jun 2023 18:17:49 +0200
Message-ID: <ada65226-f41c-7bc2-eec9-d880efef9455@vivier.eu>
Date: Sun, 4 Jun 2023 18:17:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 13/23] hw/net/dp8393x.c: move TYPE_DP8393X and
 dp8393xState into dp8393x.h
Content-Language: fr
To: Jason Wang <jasowang@redhat.com>
References: <20230604131450.428797-1-mark.cave-ayland@ilande.co.uk>
 <20230604131450.428797-14-mark.cave-ayland@ilande.co.uk>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
From: Laurent Vivier <laurent@vivier.eu>
In-Reply-To: <20230604131450.428797-14-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:sxhNXZLh851fhtKg+dTVYyzOXeldEK20iDeX4ph86T1Rh2oaGaM
 MoMYwl5yh34hr7s3lfTEz7Yg7QAHIrYRJViFHLtJkXv/zcPgGQENftYyuPTwYeqYchtsTX8
 FO6kbnyl1a9rfB5F1efcwTwrkS1/mwgyaSEi67KAWCpKID7sPvuWZ6cOVfRxac+mD/iLuAN
 BNulQq21dzWnYlesw78dQ==
UI-OutboundReport: notjunk:1;M01:P0:MOdC2NFKClI=;4sbn2Qm0AFpzHLGtLmpSuEJ78fI
 iXKvX2S4JuYfz+XjaYkvh6Hl1LyB3lwhYAZdLWf1d9HH3TsXsrh08WDaZW3sR59HfggoT6IiL
 jq9re89FfR3nIu7uM+SnruFClJy+bcLGPhMAFc5gTbs31BVA9gyvXSiU9GYM8hqPlokO2oZU2
 VEwkNj6ugd34cWPVh6wu/laVEuYMt6viIU7+7TZF+bO/Q4EoPAL4xvDqmtAdrV9bM6gmkzTtJ
 jfQIAjPTZMA9qj8AHFNLeA+hFejPeNBiksGPHNOrVsHTQxBTtcJN7rfY9hxyGarUpBAEvfgGx
 X0uCCy9jqq8Dh1UvEN3fF+sXbwkY3fgl0qCrrE0UL5NDEV4c5xbS7GCoP5HascIMvDP+jqMEE
 VzVkDNTR+IpQa8uvw7xTLc9THXFNXT2RppsrO8Zsvm2JB71TAidIRFeDhEqYHEr+4shd9vn2l
 RCeYKRGhQ7IzfdEHIx4OkUOFbRjQp+KpmSWMWerjaWfZYx01NuLkm5ISDJS8j1GUSyp+8jNB3
 MC/1LmPSWgelc4UjyCfqbuXzww4e2aL6kZzlKg1P0CXHuzdlOVO6G6S3csXyBwZyaOLKly7+A
 QYND7jacOOZaUooO/wngTq+lFlTGzFd9xkD9j0PCB5ywkYRl82H7Ti5L4QBhWeVatoVF42wCm
 r9Zls1N/NZAkwiwUsDdnpjIBbnBtsQVXxZJdfhCsnw==
Received-SPF: none client-ip=212.227.126.131; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.091,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

Jason,

if you agree with the changes I will merge them via the m68k branch.

Thanks,
Laurent

Le 04/06/2023 à 15:14, Mark Cave-Ayland a écrit :
> This is to enable them to be used outside of dp8393x.c.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> CC: Jason Wang <jasowang@redhat.com>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> ---
>   hw/net/dp8393x.c         | 32 +--------------------
>   include/hw/net/dp8393x.h | 60 ++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 61 insertions(+), 31 deletions(-)
>   create mode 100644 include/hw/net/dp8393x.h
> 
> diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
> index 45b954e46c..a596f7fbc6 100644
> --- a/hw/net/dp8393x.c
> +++ b/hw/net/dp8393x.c
> @@ -20,6 +20,7 @@
>   #include "qemu/osdep.h"
>   #include "hw/irq.h"
>   #include "hw/qdev-properties.h"
> +#include "hw/net/dp8393x.h"
>   #include "hw/sysbus.h"
>   #include "migration/vmstate.h"
>   #include "net/net.h"
> @@ -85,7 +86,6 @@ static const char *reg_names[] = {
>   #define SONIC_MPT    0x2e
>   #define SONIC_MDT    0x2f
>   #define SONIC_DCR2   0x3f
> -#define SONIC_REG_COUNT  0x40
>   
>   #define SONIC_CR_HTX     0x0001
>   #define SONIC_CR_TXP     0x0002
> @@ -139,36 +139,6 @@ static const char *reg_names[] = {
>   #define SONIC_DESC_EOL   0x0001
>   #define SONIC_DESC_ADDR  0xFFFE
>   
> -#define TYPE_DP8393X "dp8393x"
> -OBJECT_DECLARE_SIMPLE_TYPE(dp8393xState, DP8393X)
> -
> -struct dp8393xState {
> -    SysBusDevice parent_obj;
> -
> -    /* Hardware */
> -    uint8_t it_shift;
> -    bool big_endian;
> -    bool last_rba_is_full;
> -    qemu_irq irq;
> -    int irq_level;
> -    QEMUTimer *watchdog;
> -    int64_t wt_last_update;
> -    NICConf conf;
> -    NICState *nic;
> -    MemoryRegion mmio;
> -
> -    /* Registers */
> -    uint16_t cam[16][3];
> -    uint16_t regs[SONIC_REG_COUNT];
> -
> -    /* Temporaries */
> -    uint8_t tx_buffer[0x10000];
> -    int loopback_packet;
> -
> -    /* Memory access */
> -    MemoryRegion *dma_mr;
> -    AddressSpace as;
> -};
>   
>   /*
>    * Accessor functions for values which are formed by
> diff --git a/include/hw/net/dp8393x.h b/include/hw/net/dp8393x.h
> new file mode 100644
> index 0000000000..4a3f7478be
> --- /dev/null
> +++ b/include/hw/net/dp8393x.h
> @@ -0,0 +1,60 @@
> +/*
> + * QEMU NS SONIC DP8393x netcard
> + *
> + * Copyright (c) 2008-2009 Herve Poussineau
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef HW_NET_DP8393X_H
> +#define HW_NET_DP8393X_H
> +
> +#include "hw/sysbus.h"
> +#include "net/net.h"
> +#include "exec/memory.h"
> +
> +#define SONIC_REG_COUNT  0x40
> +
> +#define TYPE_DP8393X "dp8393x"
> +OBJECT_DECLARE_SIMPLE_TYPE(dp8393xState, DP8393X)
> +
> +struct dp8393xState {
> +    SysBusDevice parent_obj;
> +
> +    /* Hardware */
> +    uint8_t it_shift;
> +    bool big_endian;
> +    bool last_rba_is_full;
> +    qemu_irq irq;
> +    int irq_level;
> +    QEMUTimer *watchdog;
> +    int64_t wt_last_update;
> +    NICConf conf;
> +    NICState *nic;
> +    MemoryRegion mmio;
> +
> +    /* Registers */
> +    uint16_t cam[16][3];
> +    uint16_t regs[SONIC_REG_COUNT];
> +
> +    /* Temporaries */
> +    uint8_t tx_buffer[0x10000];
> +    int loopback_packet;
> +
> +    /* Memory access */
> +    MemoryRegion *dma_mr;
> +    AddressSpace as;
> +};
> +
> +#endif


