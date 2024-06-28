Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1D491B84B
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jun 2024 09:28:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN62H-0004wr-Ah; Fri, 28 Jun 2024 03:28:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN62F-0004wP-65
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:28:43 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN62D-0006sc-JR
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:28:42 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4W9Rr52GLTz4w2N;
 Fri, 28 Jun 2024 17:28:37 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4W9Rr42Gnwz4w2K;
 Fri, 28 Jun 2024 17:28:35 +1000 (AEST)
Message-ID: <223b208d-d5dc-471e-ba63-5641842ac025@kaod.org>
Date: Fri, 28 Jun 2024 09:28:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v42 14/98] hw/sd/sdcard: Extract sd_blk_len() helper
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240628070216.92609-1-philmd@linaro.org>
 <20240628070216.92609-15-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240628070216.92609-15-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
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
> From: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 
> Extract sd_blk_len() helper, use definitions instead
> of magic values.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/sd/sd.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index aaa50ab2c5..5997e13107 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -603,6 +603,14 @@ static void sd_response_r7_make(SDState *sd, uint8_t *response)
>       stl_be_p(response, sd->vhs);
>   }
>   
> +static uint32_t sd_blk_len(SDState *sd)
> +{
> +    if (FIELD_EX32(sd->ocr, OCR, CARD_CAPACITY)) {
> +        return 1 << HWBLOCK_SHIFT;
> +    }
> +    return sd->blk_len;
> +}
> +
>   static uint64_t sd_req_get_address(SDState *sd, SDRequest req)
>   {
>       uint64_t addr;
> @@ -2076,7 +2084,7 @@ uint8_t sd_read_byte(SDState *sd)
>       if (sd->card_status & (ADDRESS_ERROR | WP_VIOLATION))
>           return 0x00;
>   
> -    io_len = (sd->ocr & (1 << 30)) ? 512 : sd->blk_len;
> +    io_len = sd_blk_len(sd);
>   
>       trace_sdcard_read_data(sd->proto->name,
>                              sd->last_cmd_name,


