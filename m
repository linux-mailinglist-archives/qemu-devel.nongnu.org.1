Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 786707AE730
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 09:56:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql2ug-0003S4-8y; Tue, 26 Sep 2023 03:55:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1ql2uc-0003R7-Rz
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 03:55:18 -0400
Received: from mout.kundenserver.de ([212.227.17.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1ql2ub-0006FA-77
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 03:55:18 -0400
Received: from [192.168.100.1] ([82.142.8.70]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MHoVE-1qq2aL16oA-00Esd6; Tue, 26 Sep 2023 09:55:15 +0200
Message-ID: <67253ae2-d582-a164-632c-e28d63986521@vivier.eu>
Date: Tue, 26 Sep 2023 09:55:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 11/20] swim: add trace events for IWM and ISM registers
Content-Language: fr
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
References: <20230909094827.33871-1-mark.cave-ayland@ilande.co.uk>
 <20230909094827.33871-12-mark.cave-ayland@ilande.co.uk>
From: Laurent Vivier <laurent@vivier.eu>
In-Reply-To: <20230909094827.33871-12-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:89EEkjKNF+AM65L83XmK0d2C9x9f70+PDwzO6kZYigMRt80FwW9
 ph1f0URlh4kQ9ctbHnE+B4f8qJ/SXAhzDhsK+qF8oK8XOhiI2KRbgqYBE30yk6UUQgYRmTY
 dKXiwaeQmn0FCFms9ZEqAbkNhhyq/Eo+LJMQLfKqiEuoHn/Rp2QX7Vy5Jml99B8K0EKoT7P
 eWoGQEarXcjmgUULLZWAw==
UI-OutboundReport: notjunk:1;M01:P0:Xr0xGG4LLH4=;/XdUu8k0tNNJSPStgbLs48QbSe7
 61vMNM1wJJtySuy7ZDpSsbs1JHgMu6YwnSsdlhb9/kCGFpjC7JDa6KdacoOe1DYLKNefjZWUg
 mAIcoeMYXOv/jCRHCZyTG39fTVVgCtXf5Xca2r7V2GTX9a5OvvRNQsxvjqXG5NMBqGCOWPj6D
 zvA5YQgyvdF8USiDXT3egT/e7Td5Em2VyLt294y06OLs/e65iCh0T1LxtxAdzkfHrLbnB5odw
 tpMlYny9Wh1K+V0Poxw4UzboiMt4G+ZNOEKj5O+tOJCXmoea9HzqGzEwH6F7tCxbPlXtEm8oV
 Cpmssig4yAN4r7MPB43BtZE7xAuGa80ffvZaYYAk+KvfiS4LFgogyLHZg3ow8DtEfAfKByBfS
 IlPosa6Tv++x+zk7+tpRC+9sqHuriGd0x1TdmKg99K1opyQfnQ86nLY+ufn+iSFUSdMZwnt/q
 wkCXrdhSsBQ8ZaRdNSas241VDbUvyPXgiD5W+5cFGNYhYiPdv8C2pcZ7MBab0EWO8GGOm3dqi
 jWTfHob3Sniiu2UFWPZRUNY6Z0plLtzJ3X81l01obI72yeZbnGkPLWD23W86w+v8qdLEkJnn8
 ymiQ//ouIZOc0GXuYkaLldln7d+/rq7rvjkxki/Jtvg7WNG1j2rHEzMJ37tust231v6uVi/pX
 0EaPGLNsMHcGMSnlKOIbvUqCsofZ+9WYBUxDolXb6xHieEHBc+WnVSlDxldc6/Sf3WfPozD4B
 N4EZk5J/Ze8805M0Uksoa1+/YSsiKot9hSeICjvBp2WabprPDAbTkl7k9+AAbmla2so7THOAw
 CAcGp9cK3nrRaLzfhkxAADQP6O0NMEtEgIUT8VxLsPur2EyNLwb0UuG7cf/GouMegLdGBK/yG
 jRvyqPrVa1M3uUg==
Received-SPF: none client-ip=212.227.17.13; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Le 09/09/2023 à 11:48, Mark Cave-Ayland a écrit :
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


