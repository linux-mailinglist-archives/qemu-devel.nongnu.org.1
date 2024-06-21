Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0B2912B2E
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jun 2024 18:18:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKgxm-0008L7-IM; Fri, 21 Jun 2024 12:18:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=9ak7=NX=kaod.org=clg@ozlabs.org>)
 id 1sKgxj-0008JF-CF; Fri, 21 Jun 2024 12:18:07 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=9ak7=NX=kaod.org=clg@ozlabs.org>)
 id 1sKgxh-00030y-Jw; Fri, 21 Jun 2024 12:18:07 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4W5MwC2Gp2z4wcJ;
 Sat, 22 Jun 2024 02:18:03 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4W5Mw9001Yz4wc5;
 Sat, 22 Jun 2024 02:18:00 +1000 (AEST)
Message-ID: <57817b5d-1565-4163-b3bd-bf57132b219b@kaod.org>
Date: Fri, 21 Jun 2024 18:17:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/23] hw/sd/sdcard: Remove ACMD6 handler for SPI mode
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Bin Meng <bmeng.cn@gmail.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, qemu-block@nongnu.org
References: <20240621080554.18986-1-philmd@linaro.org>
 <20240621080554.18986-8-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240621080554.18986-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=9ak7=NX=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
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

On 6/21/24 10:05 AM, Philippe Mathieu-Daudé wrote:
> There is no ACMD6 command in SPI mode, remove the pointless
> handler introduced in commit 946897ce18 ("sdcard: handles
> more commands in SPI mode"). Keep sd_cmd_unimplemented()
> since we'll reuse it later.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/sd/sd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index b0cd30c657..e9af834a8c 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -1012,6 +1012,7 @@ static sd_rsp_type_t sd_cmd_illegal(SDState *sd, SDRequest req)
>   }
>   
>   /* Commands that are recognised but not yet implemented. */
> +__attribute__((unused))
>   static sd_rsp_type_t sd_cmd_unimplemented(SDState *sd, SDRequest req)
>   {
>       qemu_log_mask(LOG_UNIMP, "%s: CMD%i not implemented\n",
> @@ -2153,7 +2154,6 @@ static const SDProto sd_proto_spi = {
>           [52 ... 54] = sd_cmd_illegal,
>       },
>       .acmd = {
> -        [6]         = sd_cmd_unimplemented,
>           [41]        = spi_cmd_SEND_OP_COND,
>       },
>   };


