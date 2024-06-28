Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A57B391B934
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jun 2024 10:01:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN6XI-0005gj-KB; Fri, 28 Jun 2024 04:00:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6XA-0005Z3-R6
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 04:00:41 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6X6-0004Yz-HS
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 04:00:39 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4W9SXw6VFKz4wb7;
 Fri, 28 Jun 2024 18:00:32 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4W9SXv6M34z4w2Q;
 Fri, 28 Jun 2024 18:00:31 +1000 (AEST)
Message-ID: <521b4b19-2cdf-4c2e-bccb-455932dee326@kaod.org>
Date: Fri, 28 Jun 2024 10:00:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v42 53/98] hw/sd/sdcard: Add sd_cmd_SEND_STATUS handler
 (CMD13)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240628070216.92609-1-philmd@linaro.org>
 <20240628070216.92609-54-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240628070216.92609-54-philmd@linaro.org>
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
>   hw/sd/sd.c | 40 ++++++++++++++++++++++++++++------------
>   1 file changed, 28 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 1c092ab43c..bb80d11f87 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -240,7 +240,6 @@ static const char *sd_response_name(sd_rsp_type_t rsp)
>   static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
>   {
>       static const char *cmd_abbrev[SDMMC_CMD_MAX] = {
> -                                            [13]    = "SEND_STATUS",
>                                               [15]    = "GO_INACTIVE_STATE",
>           [16]    = "SET_BLOCKLEN",           [17]    = "READ_SINGLE_BLOCK",
>           [18]    = "READ_MULTIPLE_BLOCK",
> @@ -1377,6 +1376,32 @@ static sd_rsp_type_t sd_cmd_STOP_TRANSMISSION(SDState *sd, SDRequest req)
>       }
>   }
>   
> +/* CMD13 */
> +static sd_rsp_type_t sd_cmd_SEND_STATUS(SDState *sd, SDRequest req)
> +{
> +    if (sd->mode != sd_data_transfer_mode) {
> +        return sd_invalid_mode_for_cmd(sd, req);
> +    }
> +
> +    switch (sd->state) {
> +    case sd_standby_state:
> +    case sd_transfer_state:
> +    case sd_sendingdata_state:
> +    case sd_receivingdata_state:
> +    case sd_programming_state:
> +    case sd_disconnect_state:
> +        break;
> +    default:
> +        return sd_invalid_state_for_cmd(sd, req);
> +    }
> +
> +    if (sd_is_spi(sd)) {
> +        return sd_r2_s;
> +    }
> +
> +    return sd_req_rca_same(sd, req) ? sd_r1 : sd_r0;
> +}
> +
>   /* CMD19 */
>   static sd_rsp_type_t sd_cmd_SEND_TUNING_BLOCK(SDState *sd, SDRequest req)
>   {
> @@ -1443,17 +1468,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>   
>       switch (req.cmd) {
>       /* Basic commands (Class 0 and Class 1) */
> -    case 13:  /* CMD13:  SEND_STATUS */
> -        rca = sd_req_get_rca(sd, req);
> -        if (sd->mode != sd_data_transfer_mode) {
> -            return sd_invalid_mode_for_cmd(sd, req);
> -        }
> -        if (!sd_is_spi(sd) && sd->rca != rca) {
> -            return sd_r0;
> -        }
> -
> -        return sd_r1;
> -
>       case 15:  /* CMD15:  GO_INACTIVE_STATE */
>           if (sd->mode != sd_data_transfer_mode) {
>               return sd_invalid_mode_for_cmd(sd, req);
> @@ -2279,6 +2293,7 @@ static const SDProto sd_proto_spi = {
>           [9]  = {0,  sd_spi, "SEND_CSD", spi_cmd_SEND_CSD},
>           [10] = {0,  sd_spi, "SEND_CID", spi_cmd_SEND_CID},
>           [12] = {0,  sd_spi, "STOP_TRANSMISSION", sd_cmd_STOP_TRANSMISSION},
> +        [13] = {0,  sd_spi, "SEND_STATUS", sd_cmd_SEND_STATUS},
>           [34] = {10, sd_spi, "READ_SEC_CMD", sd_cmd_optional},
>           [35] = {10, sd_spi, "WRITE_SEC_CMD", sd_cmd_optional},
>           [36] = {10, sd_spi, "SEND_PSI", sd_cmd_optional},
> @@ -2308,6 +2323,7 @@ static const SDProto sd_proto_sd = {
>           [10] = {0,  sd_ac,   "SEND_CID", sd_cmd_SEND_CID},
>           [11] = {0,  sd_ac,   "VOLTAGE_SWITCH", sd_cmd_optional},
>           [12] = {0,  sd_ac,   "STOP_TRANSMISSION", sd_cmd_STOP_TRANSMISSION},
> +        [13] = {0,  sd_ac,   "SEND_STATUS", sd_cmd_SEND_STATUS},
>           [19] = {2,  sd_adtc, "SEND_TUNING_BLOCK", sd_cmd_SEND_TUNING_BLOCK},
>           [20] = {2,  sd_ac,   "SPEED_CLASS_CONTROL", sd_cmd_optional},
>           [23] = {2,  sd_ac,   "SET_BLOCK_COUNT", sd_cmd_SET_BLOCK_COUNT},


