Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEF391B8DE
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jun 2024 09:48:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN6LT-0004ZZ-Lx; Fri, 28 Jun 2024 03:48:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6LG-0004NY-8h
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:48:25 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6LC-0005wB-VL
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:48:20 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4W9SGm6r6Yz4wcS;
 Fri, 28 Jun 2024 17:48:16 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4W9SGl6lHpz4wb7;
 Fri, 28 Jun 2024 17:48:15 +1000 (AEST)
Message-ID: <f7e5f865-c15d-4c7e-ac33-12cce59664a4@kaod.org>
Date: Fri, 28 Jun 2024 09:48:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v42 27/98] hw/sd/sdcard: Convert SEND_NUM_WR_BLOCKS to
 generic_read_byte (ACMD22)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240628070216.92609-1-philmd@linaro.org>
 <20240628070216.92609-28-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240628070216.92609-28-philmd@linaro.org>
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

On 6/28/24 9:01 AM, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/sd/sd.c | 16 ++++------------
>   1 file changed, 4 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 1c4811f410..8d02cd9a26 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -1715,11 +1715,9 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
>       case 22:  /* ACMD22: SEND_NUM_WR_BLOCKS */
>           switch (sd->state) {
>           case sd_transfer_state:
> -            stl_be_p(sd->data, sd->blk_written);
> -            sd->state = sd_sendingdata_state;
> -            sd->data_start = 0;
> -            sd->data_offset = 0;
> -            return sd_r1;
> +            return sd_cmd_to_sendingdata(sd, req, 0,
> +                                         &sd->blk_written,
> +                                         sizeof(sd->blk_written));
>   
>           default:
>               break;
> @@ -2138,6 +2136,7 @@ uint8_t sd_read_byte(SDState *sd)
>       case 13: /* ACMD13: SD_STATUS */
>       case 17: /* CMD17:  READ_SINGLE_BLOCK */
>       case 19: /* CMD19:  SEND_TUNING_BLOCK (SD) */
> +    case 22: /* ACMD22: SEND_NUM_WR_BLOCKS */
>       case 30: /* CMD30:  SEND_WRITE_PROT */
>       case 56: /* CMD56:  GEN_CMD */
>           sd_generic_read_byte(sd, &ret);
> @@ -2167,13 +2166,6 @@ uint8_t sd_read_byte(SDState *sd)
>           }
>           break;
>   
> -    case 22:  /* ACMD22: SEND_NUM_WR_BLOCKS */
> -        ret = sd->data[sd->data_offset ++];
> -
> -        if (sd->data_offset >= 4)
> -            sd->state = sd_transfer_state;
> -        break;
> -
>       case 51:  /* ACMD51: SEND_SCR */
>           ret = sd->scr[sd->data_offset ++];
>   


