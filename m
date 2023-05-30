Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A750715D35
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 13:29:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3xXH-0004dS-28; Tue, 30 May 2023 07:29:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1q3xXF-0004Zj-K2
 for qemu-devel@nongnu.org; Tue, 30 May 2023 07:29:05 -0400
Received: from mout.kundenserver.de ([217.72.192.75])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1q3xXD-0000Wq-DU
 for qemu-devel@nongnu.org; Tue, 30 May 2023 07:29:04 -0400
Received: from [192.168.100.1] ([82.142.8.70]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1Mf0FY-1qbLTL36de-00gV5j; Tue, 30 May 2023 13:29:01 +0200
Message-ID: <54965f14-a57b-046f-6765-079ec9829b71@vivier.eu>
Date: Tue, 30 May 2023 13:29:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 18/30] swim: add trace events for IWM and ISM registers
Content-Language: fr
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
References: <20230524211104.686087-1-mark.cave-ayland@ilande.co.uk>
 <20230524211104.686087-19-mark.cave-ayland@ilande.co.uk>
From: Laurent Vivier <laurent@vivier.eu>
In-Reply-To: <20230524211104.686087-19-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:/ImjHv/PS0B3yTs6kgK6fgnSmWXJXbCdQIFu5diKv+aVbGAX+lt
 paOQvy6r1d0vVvlwSdeFtyB578+FuhfdF7pNdExTpHPKOhsbp9sgrmC5rOIzwAy/CuJcns5
 ojfX67cF0iH/Piw2CFf8tLlIQDkcDY1n11BxV53YX6EXmaBz9EvLzHmmP6pbXMay7N/9D8t
 PlnvgVqfCelruLzb2RscQ==
UI-OutboundReport: notjunk:1;M01:P0:b/vXaS/IPZI=;AMDgH74LzqII3ZDL1zd4cVQR3tH
 9xg6cvNAjlECMrLtycDq/B19yLeWI4dDZC6WR6POlJ1umTwF2FVaqlXk+W9PqbRmYrgQocnpJ
 6fKx02lU5Tla6YuyIwS31xWqsZH4pPLt69QxUx5EK7OfFwzsWZBauhRp7774IcyU6Ip/D+3rf
 nkEvMSG5HV/Hwrr0QnDIgA/IVD6U86if4zerkQHWEePo8PFwWU6mgn+CVFu/LllLJn4K9/xty
 DEfF0oSq/+F4xIjKPM0NjeBVgPhr8Fej5JC/wXouqozm3EisjG5r/W9ymiV9ZOPpJ+OCxZg4G
 lFH1BrNw//dHRXHDGrAWl54iL8qr710GQKlIswLJmXbE9j+v/Zx2rfaDFgoCnT2Oo2xg81PH9
 CAMTsnkxwssG19LgKR1r3zpR6BcZNoxpYMQCtW5UcedvnLDvXdK0RnFvlBkYpFE92EMizGQhR
 cVlsu0tjfDoiialmIb7ElNd+SKoxtPeXsrqVUHJD/vMMtEsTRMrGoEPcxnMZq717dnhOudPbN
 m6ov91pbU9zA3XqWkd2SDL4gALrCHo8zQ6dX1e1AxVpxRAXbPv+gK2+0H74rjlCxOE3iCzKI0
 BKBlS9Q5hd5GsUHJCw2IaCJgbO4caYmRKGGyA6M69jO96jbPURp123YEPQkLbmOU1Vy7V45aD
 bj41bIS92q/0qQSnpnjwvXcBFKpCcp/x23fAflXYuQ==
Received-SPF: none client-ip=217.72.192.75; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Le 24/05/2023 à 23:10, Mark Cave-Ayland a écrit :
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/block/swim.c       | 14 ++++++++++++++
>   hw/block/trace-events |  7 +++++++
>   2 files changed, 21 insertions(+)
> 
> diff --git a/hw/block/swim.c b/hw/block/swim.c
> index 333da08ce0..7df36ea139 100644
> --- a/hw/block/swim.c
> +++ b/hw/block/swim.c
> @@ -19,6 +19,7 @@
>   #include "hw/block/block.h"
>   #include "hw/block/swim.h"
>   #include "hw/qdev-properties.h"
> +#include "trace.h"
>   
>   /* IWM registers */
>   
> @@ -125,6 +126,13 @@
>   #define SWIM_HEDSEL          0x20
>   #define SWIM_MOTON           0x80
>   
> +static const char *swim_reg_names[] = {
> +    "WRITE_DATA", "WRITE_MARK", "WRITE_CRC", "WRITE_PARAMETER",
> +    "WRITE_PHASE", "WRITE_SETUP", "WRITE_MODE0", "WRITE_MODE1",
> +    "READ_DATA", "READ_MARK", "READ_ERROR", "READ_PARAMETER",
> +    "READ_PHASE", "READ_SETUP", "READ_STATUS", "READ_HANDSHAKE"
> +};
> +
>   static void fd_recalibrate(FDrive *drive)
>   {
>   }
> @@ -267,6 +275,7 @@ static void iwmctrl_write(void *opaque, hwaddr reg, uint64_t value,
>       reg >>= REG_SHIFT;
>   
>       swimctrl->regs[reg >> 1] = reg & 1;
> +    trace_swim_iwmctrl_write((reg >> 1), size, (reg & 1));
>   
>       if (swimctrl->regs[IWM_Q6] &&
>           swimctrl->regs[IWM_Q7]) {
> @@ -297,6 +306,7 @@ static void iwmctrl_write(void *opaque, hwaddr reg, uint64_t value,
>                   if (value == 0x57) {
>                       swimctrl->mode = SWIM_MODE_SWIM;
>                       swimctrl->iwm_switch = 0;
> +                    trace_swim_iwm_switch();
>                   }
>                   break;
>               }
> @@ -312,6 +322,7 @@ static uint64_t iwmctrl_read(void *opaque, hwaddr reg, unsigned size)
>   
>       swimctrl->regs[reg >> 1] = reg & 1;
>   
> +    trace_swim_iwmctrl_read((reg >> 1), size, (reg & 1));
>       return 0;
>   }
>   
> @@ -327,6 +338,8 @@ static void swimctrl_write(void *opaque, hwaddr reg, uint64_t value,
>   
>       reg >>= REG_SHIFT;
>   
> +    trace_swim_swimctrl_write(reg, swim_reg_names[reg], size, value);
> +
>       switch (reg) {
>       case SWIM_WRITE_PHASE:
>           swimctrl->swim_phase = value;
> @@ -376,6 +389,7 @@ static uint64_t swimctrl_read(void *opaque, hwaddr reg, unsigned size)
>           break;
>       }
>   
> +    trace_swim_swimctrl_read(reg, swim_reg_names[reg], size, value);
>       return value;
>   }
>   
> diff --git a/hw/block/trace-events b/hw/block/trace-events
> index 34be8b9135..c041ec45e3 100644
> --- a/hw/block/trace-events
> +++ b/hw/block/trace-events
> @@ -90,3 +90,10 @@ m25p80_read_data(void *s, uint32_t pos, uint8_t v) "[%p] Read data 0x%"PRIx32"=0
>   m25p80_read_sfdp(void *s, uint32_t addr, uint8_t v) "[%p] Read SFDP 0x%"PRIx32"=0x%"PRIx8
>   m25p80_binding(void *s) "[%p] Binding to IF_MTD drive"
>   m25p80_binding_no_bdrv(void *s) "[%p] No BDRV - binding to RAM"
> +
> +# swim.c
> +swim_swimctrl_read(int reg, const char *name, unsigned size, uint64_t value) "reg=%d [%s] size=%u value=0x%"PRIx64
> +swim_swimctrl_write(int reg, const char *name, unsigned size, uint64_t value) "reg=%d [%s] size=%u value=0x%"PRIx64
> +swim_iwmctrl_read(int reg, unsigned size, uint64_t value) "reg=%d size=%u value=0x%"PRIx64
> +swim_iwmctrl_write(int reg, unsigned size, uint64_t value) "reg=%d size=%u value=0x%"PRIx64
> +swim_iwm_switch(void) "switch from IWM to SWIM mode"

Reviewed-by: Laurent Vivier <laurent@vivier.eu>


