Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22172718355
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 15:49:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4MCY-00039O-9M; Wed, 31 May 2023 09:49:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4MCW-00038c-Dj
 for qemu-devel@nongnu.org; Wed, 31 May 2023 09:49:20 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4MCR-0001Ke-Fb
 for qemu-devel@nongnu.org; Wed, 31 May 2023 09:49:20 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3078a3f3b5fso5763600f8f.0
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 06:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685540954; x=1688132954;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7iST/P0tIr/7deKG12o2YG2lBkv6GZ9p7jQLuVViniw=;
 b=sTmm19NszBC2MXpx0mvygS3bFKLCqttpUeHbD8SeAh32IU05OhekHujHZRpnYTNvR1
 CR0O68X4tQOVUSMcePo3xY8ykcfTSUprMfDMhkskCvy31MK0vQlubVZHgLRax3PHYChU
 0Pkzu1ReSm87LASj+x3wts0bH+PhkC8hz146SwBuhAhTMpX3UZZhNE9R6mJoqfkkcrGJ
 sC4sC6yf797fL4fbYvbiu7qSaDsbBRnP1GQSntO8LpgFupDB5EHhKeV6lUr/9AkU8gl1
 zGygRf2s3ayeRe/X9pHIgOTxofPZCmIo8K3im5fCEKtub5qfyS/rdzcRjQPbEXi92jhm
 l4fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685540954; x=1688132954;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7iST/P0tIr/7deKG12o2YG2lBkv6GZ9p7jQLuVViniw=;
 b=DejCsrVsCJwzZdVNNRRTcwo25ORra0Mz7Ff24180UFqc562CDUk4vaOMej8W9a2bPT
 oRBcA1J6MTKj2a3wyH5y9WgfxE29KGABvlxg22nyQcjSsJDitnruefTAHh43x5Sb4m2R
 d+w6KjpM7JUIinsI4GXYrEjjefEdpOO1SotOKUY7kDWJ18Q+iEcgdK69kmb6DXG//Box
 7clln2hnzOkpziQ7WGRqgETGiuwABrgkB5e+Gl7r6YtcRnBjx19I42XBQXdyYN8chJw4
 EarZkfoaAkDGHilpr2WqCvCd62VhRz1KA9P0RKLto8kF0nNl5lhPnZdQASSfHN6wBUWj
 r0Ew==
X-Gm-Message-State: AC+VfDz+Icu7F0+dOb0CR+t3lTWmwyWenaHAjga3YfYfeLsdm4ro0Ako
 Ux/OsYS7MGiwBFcxkgt3AWgMhJhMOENRkWFjw4E=
X-Google-Smtp-Source: ACHHUZ7uQtSBgszsfRcOo/fv38x2TkjvveQXpLIbPIt62Chkk2TrtQWsmeEXgC+YvU8mhyEUYgN0cg==
X-Received: by 2002:a5d:5903:0:b0:307:8cf6:c2f1 with SMTP id
 v3-20020a5d5903000000b003078cf6c2f1mr3954247wrd.34.1685540953798; 
 Wed, 31 May 2023 06:49:13 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.146.12])
 by smtp.gmail.com with ESMTPSA id
 r12-20020a056000014c00b0030ae5a0516csm6802341wrx.17.2023.05.31.06.49.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 06:49:13 -0700 (PDT)
Message-ID: <886c4186-3024-7c17-ac0e-9394859a9ce4@linaro.org>
Date: Wed, 31 May 2023 15:49:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v2 13/23] hw/net/dp8393x.c: move TYPE_DP8393X and
 dp8393xState into dp8393x.h
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, laurent@vivier.eu,
 qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>
References: <20230531125400.288917-1-mark.cave-ayland@ilande.co.uk>
 <20230531125400.288917-14-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230531125400.288917-14-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 31/5/23 14:53, Mark Cave-Ayland wrote:
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

No "osdep.h" in headers please (anti-pattern).

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

Missing "exec/memory.h" #include.

> +};
> +
> +#endif


