Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9C291B8C0
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jun 2024 09:45:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN6Ie-0007xc-6v; Fri, 28 Jun 2024 03:45:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6IS-0007uh-Dd
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:45:28 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6IQ-0004fB-Ol
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:45:28 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4W9SCQ220tz4w2N;
 Fri, 28 Jun 2024 17:45:22 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4W9SCP1hKZz4w2K;
 Fri, 28 Jun 2024 17:45:20 +1000 (AEST)
Message-ID: <ca0121c8-d465-4922-a395-95e71ad58fc0@kaod.org>
Date: Fri, 28 Jun 2024 09:45:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v42 19/98] hw/sd/sdcard: Convert SWITCH_FUNCTION to
 generic_read_byte (CMD6)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240628070216.92609-1-philmd@linaro.org>
 <20240628070216.92609-20-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240628070216.92609-20-philmd@linaro.org>
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
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/sd/sd.c | 12 ++----------
>   1 file changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 1a8d06804d..f7735c39a8 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -1086,7 +1086,6 @@ static sd_rsp_type_t sd_cmd_unimplemented(SDState *sd, SDRequest req)
>   }
>   
>   /* Configure fields for following sd_generic_read_byte() calls */
> -__attribute__((unused))
>   static sd_rsp_type_t sd_cmd_to_sendingdata(SDState *sd, SDRequest req,
>                                              uint64_t start,
>                                              const void *data, size_t size)
> @@ -1243,10 +1242,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>           }
>   
>           sd_function_switch(sd, req.arg);
> -        sd->state = sd_sendingdata_state;
> -        sd->data_start = 0;
> -        sd->data_offset = 0;
> -        return sd_r1;
> +        return sd_cmd_to_sendingdata(sd, req, 0, NULL, 64);
>   
>       case 7:  /* CMD7:   SELECT/DESELECT_CARD */
>           rca = sd_req_get_rca(sd, req);
> @@ -1946,7 +1942,6 @@ send_response:
>   }
>   
>   /* Return true when buffer is consumed. Configured by sd_cmd_to_sendingdata() */
> -__attribute__((unused))
>   static bool sd_generic_read_byte(SDState *sd, uint8_t *value)
>   {
>       *value = sd->data[sd->data_offset];
> @@ -2135,10 +2130,7 @@ uint8_t sd_read_byte(SDState *sd)
>                              sd->current_cmd, sd->data_offset, io_len);
>       switch (sd->current_cmd) {
>       case 6:  /* CMD6:   SWITCH_FUNCTION */
> -        ret = sd->data[sd->data_offset ++];
> -
> -        if (sd->data_offset >= 64)
> -            sd->state = sd_transfer_state;
> +        sd_generic_read_byte(sd, &ret);
>           break;
>   
>       case 9:  /* CMD9:   SEND_CSD */


