Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A53391B8CA
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jun 2024 09:46:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN6Jb-0001Jh-Kj; Fri, 28 Jun 2024 03:46:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6JZ-00015H-KP
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:46:37 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6JX-0004qm-PV
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:46:37 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4W9SDn5GQYz4w2N;
 Fri, 28 Jun 2024 17:46:33 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4W9SDm588wz4w2K;
 Fri, 28 Jun 2024 17:46:32 +1000 (AEST)
Message-ID: <a00dc8c6-5016-4f8c-888b-6760fec5ecd2@kaod.org>
Date: Fri, 28 Jun 2024 09:46:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v42 22/98] hw/sd/sdcard: Convert READ_SINGLE_BLOCK to
 generic_read_byte (CMD17)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240628070216.92609-1-philmd@linaro.org>
 <20240628070216.92609-23-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240628070216.92609-23-philmd@linaro.org>
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
> From: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/sd/sd.c | 18 +++---------------
>   1 file changed, 3 insertions(+), 15 deletions(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index dfcb213aa9..605269163d 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -1405,11 +1405,8 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>               if (!address_in_range(sd, "READ_SINGLE_BLOCK", addr, sd->blk_len)) {
>                   return sd_r1;
>               }
> -
> -            sd->state = sd_sendingdata_state;
> -            sd->data_start = addr;
> -            sd->data_offset = 0;
> -            return sd_r1;
> +            sd_blk_read(sd, addr, sd->blk_len);
> +            return sd_cmd_to_sendingdata(sd, req, addr, NULL, sd->blk_len);
>   
>           default:
>               break;
> @@ -2144,6 +2141,7 @@ uint8_t sd_read_byte(SDState *sd)
>       case 6:  /* CMD6:   SWITCH_FUNCTION */
>       case 9:  /* CMD9:   SEND_CSD */
>       case 10: /* CMD10:  SEND_CID */
> +    case 17: /* CMD17:  READ_SINGLE_BLOCK */
>           sd_generic_read_byte(sd, &ret);
>           break;
>   
> @@ -2154,16 +2152,6 @@ uint8_t sd_read_byte(SDState *sd)
>               sd->state = sd_transfer_state;
>           break;
>   
> -    case 17:  /* CMD17:  READ_SINGLE_BLOCK */
> -        if (sd->data_offset == 0) {
> -            sd_blk_read(sd, sd->data_start, io_len);
> -        }
> -        ret = sd->data[sd->data_offset ++];
> -
> -        if (sd->data_offset >= io_len)
> -            sd->state = sd_transfer_state;
> -        break;
> -
>       case 18:  /* CMD18:  READ_MULTIPLE_BLOCK */
>           if (sd->data_offset == 0) {
>               if (!address_in_range(sd, "READ_MULTIPLE_BLOCK",


