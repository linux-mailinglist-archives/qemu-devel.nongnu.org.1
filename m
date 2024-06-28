Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD5891B87F
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jun 2024 09:34:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN66s-00010e-74; Fri, 28 Jun 2024 03:33:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN66L-0000j0-81
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:33:03 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN66J-0007mt-5a
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:32:56 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4W9Rx042Xjz4wcC;
 Fri, 28 Jun 2024 17:32:52 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4W9Rwz41Pkz4wc8;
 Fri, 28 Jun 2024 17:32:51 +1000 (AEST)
Message-ID: <4ff45a19-fa6e-4cae-8c9a-f88fedadc232@kaod.org>
Date: Fri, 28 Jun 2024 09:32:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v42 16/98] hw/sd/sdcard: Generate random RCA value
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240628070216.92609-1-philmd@linaro.org>
 <20240628070216.92609-17-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240628070216.92609-17-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=GU6n=N6=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 6/28/24 9:00 AM, Philippe Mathieu-Daudé wrote:
> Rather than using the obscure 0x4567 magic value,
> use a real random one.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Tested-by: Cédric Le Goater <clg@redhat.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/sd/sd.c         | 11 ++++++++---
>   hw/sd/trace-events |  1 +
>   2 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 5997e13107..d85b2906f4 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -46,6 +46,7 @@
>   #include "qemu/error-report.h"
>   #include "qemu/timer.h"
>   #include "qemu/log.h"
> +#include "qemu/guest-random.h"
>   #include "qemu/module.h"
>   #include "sdmmc-internal.h"
>   #include "trace.h"
> @@ -488,9 +489,10 @@ static void sd_set_csd(SDState *sd, uint64_t size)
>   
>   /* Relative Card Address register */
>   
> -static void sd_set_rca(SDState *sd)
> +static void sd_set_rca(SDState *sd, uint16_t value)
>   {
> -    sd->rca += 0x4567;
> +    trace_sdcard_set_rca(value);
> +    sd->rca = value;
>   }
>   
>   static uint16_t sd_req_get_rca(SDState *s, SDRequest req)
> @@ -1113,11 +1115,14 @@ static sd_rsp_type_t sd_cmd_ALL_SEND_CID(SDState *sd, SDRequest req)
>   /* CMD3 */
>   static sd_rsp_type_t sd_cmd_SEND_RELATIVE_ADDR(SDState *sd, SDRequest req)
>   {
> +    uint16_t random_rca;
> +
>       switch (sd->state) {
>       case sd_identification_state:
>       case sd_standby_state:
>           sd->state = sd_standby_state;
> -        sd_set_rca(sd);
> +        qemu_guest_getrandom_nofail(&random_rca, sizeof(random_rca));
> +        sd_set_rca(sd, random_rca);
>           return sd_r6;
>   
>       default:
> diff --git a/hw/sd/trace-events b/hw/sd/trace-events
> index 43eaeba149..6a51b0e906 100644
> --- a/hw/sd/trace-events
> +++ b/hw/sd/trace-events
> @@ -43,6 +43,7 @@ sdcard_response(const char *rspdesc, int rsplen) "%s (sz:%d)"
>   sdcard_powerup(void) ""
>   sdcard_inquiry_cmd41(void) ""
>   sdcard_reset(void) ""
> +sdcard_set_rca(uint16_t value) "new RCA: 0x%04x"
>   sdcard_set_blocklen(uint16_t length) "block len 0x%03x"
>   sdcard_set_block_count(uint32_t cnt) "block cnt 0x%"PRIx32
>   sdcard_inserted(bool readonly) "read_only: %u"


