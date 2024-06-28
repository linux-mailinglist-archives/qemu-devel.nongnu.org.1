Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5015B91B91B
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jun 2024 09:56:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN6Sv-0007MH-QI; Fri, 28 Jun 2024 03:56:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6St-0007JV-Lc
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:56:15 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6Sr-0001mB-Vc
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:56:15 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4W9SRv6x2Bz4wb7;
 Fri, 28 Jun 2024 17:56:11 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4W9SRt6kwcz4w2K;
 Fri, 28 Jun 2024 17:56:10 +1000 (AEST)
Message-ID: <09e7116c-fd50-4bb9-a23e-5283f7e6fd6f@kaod.org>
Date: Fri, 28 Jun 2024 09:56:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v42 43/98] hw/sd/sdcard: Register generic optional
 handlers (CMD11 and CMD20)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240628070216.92609-1-philmd@linaro.org>
 <20240628070216.92609-44-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240628070216.92609-44-philmd@linaro.org>
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
>   hw/sd/sd.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 097cb0f2e2..74aa38a442 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -243,12 +243,12 @@ static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
>                                                [5]    = "IO_SEND_OP_COND",
>            [6]    = "SWITCH_FUNC",             [7]    = "SELECT/DESELECT_CARD",
>            [8]    = "SEND_IF_COND",            [9]    = "SEND_CSD",
> -        [10]    = "SEND_CID",               [11]    = "VOLTAGE_SWITCH",
> +        [10]    = "SEND_CID",
>           [12]    = "STOP_TRANSMISSION",      [13]    = "SEND_STATUS",
>                                               [15]    = "GO_INACTIVE_STATE",
>           [16]    = "SET_BLOCKLEN",           [17]    = "READ_SINGLE_BLOCK",
>           [18]    = "READ_MULTIPLE_BLOCK",
> -        [20]    = "SPEED_CLASS_CONTROL",    [21]    = "DPS_spec",
> +                                            [21]    = "DPS_spec",
>           [24]    = "WRITE_BLOCK",            [25]    = "WRITE_MULTIPLE_BLOCK",
>           [26]    = "MANUF_RSVD",             [27]    = "PROGRAM_CSD",
>           [28]    = "SET_WRITE_PROT",         [29]    = "CLR_WRITE_PROT",
> @@ -1161,6 +1161,14 @@ static sd_rsp_type_t sd_cmd_unimplemented(SDState *sd, SDRequest req)
>       return sd_illegal;
>   }
>   
> +static sd_rsp_type_t sd_cmd_optional(SDState *sd, SDRequest req)
> +{
> +    qemu_log_mask(LOG_UNIMP, "%s: Optional CMD%i not implemented\n",
> +                  sd->proto->name, req.cmd);
> +
> +    return sd_illegal;
> +}
> +
>   /* Configure fields for following sd_generic_write_byte() calls */
>   static sd_rsp_type_t sd_cmd_to_receivingdata(SDState *sd, SDRequest req,
>                                                uint64_t start, size_t size)
> @@ -2279,7 +2287,9 @@ static const SDProto sd_proto_sd = {
>           [2]  = {0,  sd_bcr,  "ALL_SEND_CID", sd_cmd_ALL_SEND_CID},
>           [3]  = {0,  sd_bcr,  "SEND_RELATIVE_ADDR", sd_cmd_SEND_RELATIVE_ADDR},
>           [4]  = {0,  sd_bc,   "SEND_DSR", sd_cmd_unimplemented},
> +        [11] = {0,  sd_ac,   "VOLTAGE_SWITCH", sd_cmd_optional},
>           [19] = {2,  sd_adtc, "SEND_TUNING_BLOCK", sd_cmd_SEND_TUNING_BLOCK},
> +        [20] = {2,  sd_ac,   "SPEED_CLASS_CONTROL", sd_cmd_optional},
>           [23] = {2,  sd_ac,   "SET_BLOCK_COUNT", sd_cmd_SET_BLOCK_COUNT},
>       },
>   };


