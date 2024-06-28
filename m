Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D26F691B95D
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jun 2024 10:04:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN6am-0008NL-5K; Fri, 28 Jun 2024 04:04:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6af-0008JT-PI
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 04:04:17 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6ad-0005y9-Pj
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 04:04:17 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4W9Sd95HM9z4wb7;
 Fri, 28 Jun 2024 18:04:13 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4W9Sd85HdGz4w2Q;
 Fri, 28 Jun 2024 18:04:12 +1000 (AEST)
Message-ID: <daf7cd0a-3839-4e52-bdb1-6c75c294fe71@kaod.org>
Date: Fri, 28 Jun 2024 10:04:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v42 74/98] hw/sd/sdcard: Add sd_acmd_SEND_SCR handler
 (ACMD51)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240628070216.92609-1-philmd@linaro.org>
 <20240628070216.92609-75-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240628070216.92609-75-philmd@linaro.org>
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

On 6/28/24 9:01 AM, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/sd/sd.c | 19 ++++++++-----------
>   1 file changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index a27a7e0f24..6a9d611429 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -263,7 +263,6 @@ static const char *sd_acmd_name(SDState *sd, uint8_t cmd)
>           [14] = "DPS_spec",                  [15] = "DPS_spec",
>           [16] = "DPS_spec",
>           [18] = "SECU_spec",
> -        [51] = "SEND_SCR",
>           [52] = "SECU_spec",                 [53] = "SECU_spec",
>           [54] = "SECU_spec",
>           [56] = "SECU_spec",                 [57] = "SECU_spec",
> @@ -1758,6 +1757,12 @@ static sd_rsp_type_t sd_acmd_SET_CLR_CARD_DETECT(SDState *sd, SDRequest req)
>       return sd_r1;
>   }
>   
> +/* ACMD51 */
> +static sd_rsp_type_t sd_acmd_SEND_SCR(SDState *sd, SDRequest req)
> +{
> +    return sd_cmd_to_sendingdata(sd, req, 0, sd->scr, sizeof(sd->scr));
> +}
> +
>   static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>   {
>       uint64_t addr;
> @@ -1866,16 +1871,6 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
>       }
>   
>       switch (req.cmd) {
> -    case 51:  /* ACMD51: SEND_SCR */
> -        switch (sd->state) {
> -        case sd_transfer_state:
> -            return sd_cmd_to_sendingdata(sd, req, 0, sd->scr, sizeof(sd->scr));
> -
> -        default:
> -            break;
> -        }
> -        break;
> -
>       case 18:    /* Reserved for SD security applications */
>       case 25:
>       case 26:
> @@ -2327,6 +2322,7 @@ static const SDProto sd_proto_spi = {
>           [23] = {8,  sd_spi, "SET_WR_BLK_ERASE_COUNT", sd_acmd_SET_WR_BLK_ERASE_COUNT},
>           [41] = {8,  sd_spi, "SEND_OP_COND", spi_cmd_SEND_OP_COND},
>           [42] = {8,  sd_spi, "SET_CLR_CARD_DETECT", sd_acmd_SET_CLR_CARD_DETECT},
> +        [51] = {8,  sd_spi, "SEND_SCR", sd_acmd_SEND_SCR},
>       },
>   };
>   
> @@ -2388,6 +2384,7 @@ static const SDProto sd_proto_sd = {
>           [23] = {8,  sd_ac,   "SET_WR_BLK_ERASE_COUNT", sd_acmd_SET_WR_BLK_ERASE_COUNT},
>           [41] = {8,  sd_bcr,  "SD_APP_OP_COND", sd_acmd_SD_APP_OP_COND},
>           [42] = {8,  sd_ac,   "SET_CLR_CARD_DETECT", sd_acmd_SET_CLR_CARD_DETECT},
> +        [51] = {8,  sd_adtc, "SEND_SCR", sd_acmd_SEND_SCR},
>       },
>   };
>   


