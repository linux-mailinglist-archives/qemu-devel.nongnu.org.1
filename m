Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE60F91B87C
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jun 2024 09:33:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN66Y-0000bS-Mt; Fri, 28 Jun 2024 03:33:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN65z-0000Sh-6c
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:32:36 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN65x-0007kX-JO
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:32:34 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4W9RwZ6VhSz4wcg;
 Fri, 28 Jun 2024 17:32:30 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4W9RwY6MQFz4wc8;
 Fri, 28 Jun 2024 17:32:29 +1000 (AEST)
Message-ID: <b1e26078-4ba0-4cd4-b6ae-3df46cdfbe10@kaod.org>
Date: Fri, 28 Jun 2024 09:32:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v42 12/98] hw/sd/sdcard: Restrict SWITCH_FUNCTION to
 sd_transfer_state (CMD6)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240628070216.92609-1-philmd@linaro.org>
 <20240628070216.92609-13-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240628070216.92609-13-philmd@linaro.org>
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
> SWITCH_FUNCTION is only allowed in TRANSFER state
> (See 4.8 "Card State Transition Table).
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Tested-by: Cédric Le Goater <clg@redhat.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/sd/sd.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 7533a78cf6..8f441e418c 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -1205,6 +1205,10 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>           if (sd->mode != sd_data_transfer_mode) {
>               return sd_invalid_mode_for_cmd(sd, req);
>           }
> +        if (sd->state != sd_transfer_state) {
> +            return sd_invalid_state_for_cmd(sd, req);
> +        }
> +
>           sd_function_switch(sd, req.arg);
>           sd->state = sd_sendingdata_state;
>           sd->data_start = 0;


