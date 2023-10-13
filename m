Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F5A7C876F
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 16:06:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrImL-0003dA-Cg; Fri, 13 Oct 2023 10:04:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=fS+4=F3=kaod.org=clg@ozlabs.org>)
 id 1qrIm0-0002HC-2w; Fri, 13 Oct 2023 10:04:16 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=fS+4=F3=kaod.org=clg@ozlabs.org>)
 id 1qrIlx-0002iW-Po; Fri, 13 Oct 2023 10:04:15 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4S6St03fvpz4xYP;
 Sat, 14 Oct 2023 01:04:08 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4S6Ssy29Spz4xFj;
 Sat, 14 Oct 2023 01:04:05 +1100 (AEDT)
Message-ID: <29883e5b-246f-4802-9baf-03f79729f9d4@kaod.org>
Date: Fri, 13 Oct 2023 16:04:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] target/ppc: Define powerpc_pm_insn_t in 'internal.h'
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
References: <20231013125630.95116-1-philmd@linaro.org>
 <20231013125630.95116-3-philmd@linaro.org>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20231013125630.95116-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=fS+4=F3=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 10/13/23 14:56, Philippe Mathieu-Daudé wrote:
> PM instructions are only used by TCG helpers. No need to
> expose to other hardware.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>


Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


> ---
>   target/ppc/cpu-qom.h  | 10 ----------
>   target/ppc/internal.h |  9 +++++++++
>   2 files changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
> index b5deef5ca5..b86fd46d25 100644
> --- a/target/ppc/cpu-qom.h
> +++ b/target/ppc/cpu-qom.h
> @@ -115,16 +115,6 @@ enum powerpc_excp_t {
>       POWERPC_EXCP_POWER10,
>   };
>   
> -/*****************************************************************************/
> -/* PM instructions */
> -typedef enum {
> -    PPC_PM_DOZE,
> -    PPC_PM_NAP,
> -    PPC_PM_SLEEP,
> -    PPC_PM_RVWINKLE,
> -    PPC_PM_STOP,
> -} powerpc_pm_insn_t;
> -
>   /*****************************************************************************/
>   /* Input pins model                                                          */
>   typedef enum powerpc_input_t powerpc_input_t;
> diff --git a/target/ppc/internal.h b/target/ppc/internal.h
> index c881c67a8b..5b20ecbd33 100644
> --- a/target/ppc/internal.h
> +++ b/target/ppc/internal.h
> @@ -20,6 +20,15 @@
>   
>   #include "hw/registerfields.h"
>   
> +/* PM instructions */
> +typedef enum {
> +    PPC_PM_DOZE,
> +    PPC_PM_NAP,
> +    PPC_PM_SLEEP,
> +    PPC_PM_RVWINKLE,
> +    PPC_PM_STOP,
> +} powerpc_pm_insn_t;
> +
>   #define FUNC_MASK(name, ret_type, size, max_val)                  \
>   static inline ret_type name(uint##size##_t start,                 \
>                                 uint##size##_t end)                 \


