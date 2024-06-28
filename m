Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A08B91B93C
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jun 2024 10:02:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN6Yi-0001zy-6s; Fri, 28 Jun 2024 04:02:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6Yg-0001zX-It
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 04:02:14 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6Ye-0005Fr-FP
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 04:02:14 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4W9SZn2yFsz4wcr;
 Fri, 28 Jun 2024 18:02:09 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4W9SZm2vWYz4wb7;
 Fri, 28 Jun 2024 18:02:08 +1000 (AEST)
Message-ID: <e2b17a88-3606-401a-8407-b91d7d7f677f@kaod.org>
Date: Fri, 28 Jun 2024 10:02:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v42 60/98] hw/sd/sdcard: Add sd_cmd_SEND_WRITE_PROT
 handler (CMD30)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240628070216.92609-1-philmd@linaro.org>
 <20240628070216.92609-61-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240628070216.92609-61-philmd@linaro.org>
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
>   hw/sd/sd.c | 47 +++++++++++++++++++++++++----------------------
>   1 file changed, 25 insertions(+), 22 deletions(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index a63213613b..bf9975e9b1 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -244,7 +244,6 @@ static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
>                                               [21]    = "DPS_spec",
>                                               [25]    = "WRITE_MULTIPLE_BLOCK",
>           [26]    = "MANUF_RSVD",
> -        [30]    = "SEND_WRITE_PROT",
>           [32]    = "ERASE_WR_BLK_START",     [33]    = "ERASE_WR_BLK_END",
>           [38]    = "ERASE",
>           [40]    = "DPS_spec",
> @@ -1561,11 +1560,33 @@ static sd_rsp_type_t sd_cmd_CLR_WRITE_PROT(SDState *sd, SDRequest req)
>       return sd_cmd_SET_CLR_WRITE_PROT(sd, req, false);
>   }
>   
> +/* CMD30 */
> +static sd_rsp_type_t sd_cmd_SEND_WRITE_PROT(SDState *sd, SDRequest req)
> +{
> +    uint64_t addr;
> +    uint32_t data;
> +
> +    if (sd->size > SDSC_MAX_CAPACITY) {
> +        return sd_illegal;
> +    }
> +
> +    if (sd->state != sd_transfer_state) {
> +        return sd_invalid_state_for_cmd(sd, req);
> +    }
> +
> +    addr = sd_req_get_address(sd, req);
> +    if (!address_in_range(sd, "SEND_WRITE_PROT", addr, sd->blk_len)) {
> +        return sd_r1;
> +    }
> +
> +    data = sd_wpbits(sd, req.arg);
> +    return sd_cmd_to_sendingdata(sd, req, addr, &data, sizeof(data));
> +}
> +
>   static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>   {
>       uint16_t rca;
>       uint64_t addr;
> -    uint32_t data;
>   
>       sd->last_cmd_name = sd_cmd_name(sd, req.cmd);
>       /* CMD55 precedes an ACMD, so we are not interested in tracing it.
> @@ -1650,26 +1671,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>       case 26:  /* CMD26:  PROGRAM_CID */
>           return sd_cmd_to_receivingdata(sd, req, 0, sizeof(sd->cid));
>   
> -    /* Write protection (Class 6) */
> -    case 30:  /* CMD30:  SEND_WRITE_PROT */
> -        if (sd->size > SDSC_MAX_CAPACITY) {
> -            return sd_illegal;
> -        }
> -        addr = sd_req_get_address(sd, req);
> -        switch (sd->state) {
> -        case sd_transfer_state:
> -            if (!address_in_range(sd, "SEND_WRITE_PROT",
> -                                  req.arg, sd->blk_len)) {
> -                return sd_r1;
> -            }
> -            data = sd_wpbits(sd, req.arg);
> -            return sd_cmd_to_sendingdata(sd, req, addr, &data, sizeof(data));
> -
> -        default:
> -            break;
> -        }
> -        break;
> -
>       /* Erase commands (Class 5) */
>       case 32:  /* CMD32:  ERASE_WR_BLK_START */
>           switch (sd->state) {
> @@ -2313,6 +2314,7 @@ static const SDProto sd_proto_spi = {
>           [27] = {4,  sd_spi, "PROGRAM_CSD", sd_cmd_PROGRAM_CSD},
>           [28] = {6,  sd_spi, "SET_WRITE_PROT", sd_cmd_SET_WRITE_PROT},
>           [29] = {6,  sd_spi, "CLR_WRITE_PROT", sd_cmd_CLR_WRITE_PROT},
> +        [30] = {6,  sd_spi, "SEND_WRITE_PROT", sd_cmd_SEND_WRITE_PROT},
>           [34] = {10, sd_spi, "READ_SEC_CMD", sd_cmd_optional},
>           [35] = {10, sd_spi, "WRITE_SEC_CMD", sd_cmd_optional},
>           [36] = {10, sd_spi, "SEND_PSI", sd_cmd_optional},
> @@ -2353,6 +2355,7 @@ static const SDProto sd_proto_sd = {
>           [27] = {4,  sd_adtc, "PROGRAM_CSD", sd_cmd_PROGRAM_CSD},
>           [28] = {6,  sd_ac,   "SET_WRITE_PROT", sd_cmd_SET_WRITE_PROT},
>           [29] = {6,  sd_ac,   "CLR_WRITE_PROT", sd_cmd_CLR_WRITE_PROT},
> +        [30] = {6,  sd_adtc, "SEND_WRITE_PROT", sd_cmd_SEND_WRITE_PROT},
>           [34] = {10, sd_adtc, "READ_SEC_CMD", sd_cmd_optional},
>           [35] = {10, sd_adtc, "WRITE_SEC_CMD", sd_cmd_optional},
>           [36] = {10, sd_adtc, "SEND_PSI", sd_cmd_optional},


