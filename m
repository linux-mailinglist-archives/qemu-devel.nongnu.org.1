Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B58718B34
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 22:31:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4ST1-0000Fr-00; Wed, 31 May 2023 16:30:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1q4SSw-0000Do-2a
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:30:44 -0400
Received: from mout.kundenserver.de ([217.72.192.74])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1q4SSt-00026b-Vo
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:30:41 -0400
Received: from [192.168.100.1] ([82.142.8.70]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MiJdI-1qXTpL1UwQ-00fU6M; Wed, 31 May 2023 22:30:37 +0200
Message-ID: <918c98c4-9a2a-54ee-bcaf-501b51881d36@vivier.eu>
Date: Wed, 31 May 2023 22:30:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 13/23] hw/net/dp8393x.c: move TYPE_DP8393X and
 dp8393xState into dp8393x.h
Content-Language: fr
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>
References: <20230531125400.288917-1-mark.cave-ayland@ilande.co.uk>
 <20230531125400.288917-14-mark.cave-ayland@ilande.co.uk>
From: Laurent Vivier <laurent@vivier.eu>
In-Reply-To: <20230531125400.288917-14-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:+HYSUASibkPRzap2nWmKYp2/uF6mhGUSHz8YQU0u52it8zsXwss
 nrJ2X0nLzwnfNrntV8f4LrxaZAMWVEcji1JLRROfdWj1cPAWK2Fv/7cUR01knZYJH5E8x7x
 GvW6OKZlWvEYt1pg3pqC8+kOlF77tYjhAgVF03QhHTJTWEHFTOoSMVsg7thSOVc5bjno9Vv
 zcGr8yyGN18IrW/wIIS7w==
UI-OutboundReport: notjunk:1;M01:P0:38PUvpau064=;wL0XIzIdUWVYs1Z0RJGPGqzi0fL
 bYIfsZLMrks2K/ISnwy0meF7nu2adzAFuuT+XzZ+QaT3NsexOW5XSjL2xmuiPFb9hK+41AEFk
 e3E+m2yFGx1Ey9ll11ldYwvO8Ss15Pyx473h33MJyrwTSKZxdSSFEZSuCT1WjEoaasxSN9Xb6
 hLv81sLCmEMCiNVEiEBZUhabxj+NlvNGJoJpDX7LCv8ryX9ggyekakyBDY6youLBkKkvJROy7
 Pva3cI1Yht/eZnC/PTkkDdD/RxSEe+wpoUXyzcpY1uxLhp3pvqCwYhQxvpVKEjAC2vFoXBqKo
 5uz9cRZoi8YSL8sHsuHK0A4zUXc5wP8JkXgda1viiChgmpaknUb4wQOg/s6D+6VjNvevRY1J4
 E4KS+K8lRa8QujnaP2ztkw1KNcrVQ0+B9z+1lJ5xXAgYkL6TDT4jrGYnAWpokW7HQCTYuHI0p
 xZ/0ilJx0CSTGG1/1UC68LnzouiEzxqxdE2LRRdx2lbAQPKD2FGiZYHIliJqxHopzJvl7xp39
 7jjUGvjISRdwiv5XcgdTJnZ7Gwr5A4+hDRVgybEsbqYhAEQ7/HnGwglTcRyDL7ZHABY+sC64I
 i4GCKQCwexMfGW3kEvFxB031EUrLlu1E3B4KXY80P7Q+VPSR1wQ7lwJVCFHhNzbkE8CMr6Goe
 TFHdEpMh/I2AZKTu6xTQ2PBX18lhPsp2aCT/tIZyog==
Received-SPF: none client-ip=217.72.192.74; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.091,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Le 31/05/2023 à 14:53, Mark Cave-Ayland a écrit :
> This is to enable them to be used outside of dp8393x.c.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> CC: Jason Wang <jasowang@redhat.com>
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
> index 0000000000..bb5f0ced5a
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
> +#include "qemu/osdep.h"
> +#include "hw/sysbus.h"
> +#include "net/net.h"
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

Reviewed-by: Laurent Vivier <laurent@vivier.eu>


