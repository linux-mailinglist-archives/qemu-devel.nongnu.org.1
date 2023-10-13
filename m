Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 880D47C8772
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 16:06:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrInW-0000Ju-PR; Fri, 13 Oct 2023 10:05:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=fS+4=F3=kaod.org=clg@ozlabs.org>)
 id 1qrInF-0008K0-Og; Fri, 13 Oct 2023 10:05:35 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=fS+4=F3=kaod.org=clg@ozlabs.org>)
 id 1qrInA-00034X-0Q; Fri, 13 Oct 2023 10:05:31 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4S6SvT0yXgz4xbN;
 Sat, 14 Oct 2023 01:05:25 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4S6SvQ5KQjz4xZm;
 Sat, 14 Oct 2023 01:05:22 +1100 (AEDT)
Message-ID: <33d3763b-38be-4b3b-9214-c5ceb50532a1@kaod.org>
Date: Fri, 13 Oct 2023 16:05:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] target/ppc: Move powerpc_excp_t definition to 'cpu.h'
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
References: <20231013125630.95116-1-philmd@linaro.org>
 <20231013125630.95116-6-philmd@linaro.org>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20231013125630.95116-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=fS+4=F3=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
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

On 10/13/23 14:56, Philippe Mathieu-Daudé wrote:
> The powerpc_excp_t definition is only used by target/ppc/, no need
> to expose it. Restrict it by moving it to "target/ppc/cpu.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>


Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


> ---
>   target/ppc/cpu-qom.h | 29 -----------------------------
>   target/ppc/cpu.h     | 27 +++++++++++++++++++++++++++
>   2 files changed, 27 insertions(+), 29 deletions(-)
> 
> diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
> index 41e97a0ea1..b2e42c2996 100644
> --- a/target/ppc/cpu-qom.h
> +++ b/target/ppc/cpu-qom.h
> @@ -79,35 +79,6 @@ static inline bool mmu_is_64bit(powerpc_mmu_t mmu_model)
>       return mmu_model & POWERPC_MMU_64;
>   }
>   
> -/*****************************************************************************/
> -/* Exception model                                                           */
> -typedef enum powerpc_excp_t powerpc_excp_t;
> -enum powerpc_excp_t {
> -    POWERPC_EXCP_UNKNOWN   = 0,
> -    /* Standard PowerPC exception model */
> -    POWERPC_EXCP_STD,
> -    /* PowerPC 40x exception model      */
> -    POWERPC_EXCP_40x,
> -    /* PowerPC 603/604/G2 exception model */
> -    POWERPC_EXCP_6xx,
> -    /* PowerPC 7xx exception model      */
> -    POWERPC_EXCP_7xx,
> -    /* PowerPC 74xx exception model     */
> -    POWERPC_EXCP_74xx,
> -    /* BookE exception model            */
> -    POWERPC_EXCP_BOOKE,
> -    /* PowerPC 970 exception model      */
> -    POWERPC_EXCP_970,
> -    /* POWER7 exception model           */
> -    POWERPC_EXCP_POWER7,
> -    /* POWER8 exception model           */
> -    POWERPC_EXCP_POWER8,
> -    /* POWER9 exception model           */
> -    POWERPC_EXCP_POWER9,
> -    /* POWER10 exception model           */
> -    POWERPC_EXCP_POWER10,
> -};
> -
>   /*****************************************************************************/
>   /* Input pins model                                                          */
>   typedef enum powerpc_input_t powerpc_input_t;
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index d521ee97bb..d8cf4c03bf 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -190,6 +190,33 @@ enum {
>       POWERPC_EXCP_TRAP          = 0x40,
>   };
>   
> +/* Exception model                                                           */
> +typedef enum powerpc_excp_t {
> +    POWERPC_EXCP_UNKNOWN   = 0,
> +    /* Standard PowerPC exception model */
> +    POWERPC_EXCP_STD,
> +    /* PowerPC 40x exception model      */
> +    POWERPC_EXCP_40x,
> +    /* PowerPC 603/604/G2 exception model */
> +    POWERPC_EXCP_6xx,
> +    /* PowerPC 7xx exception model      */
> +    POWERPC_EXCP_7xx,
> +    /* PowerPC 74xx exception model     */
> +    POWERPC_EXCP_74xx,
> +    /* BookE exception model            */
> +    POWERPC_EXCP_BOOKE,
> +    /* PowerPC 970 exception model      */
> +    POWERPC_EXCP_970,
> +    /* POWER7 exception model           */
> +    POWERPC_EXCP_POWER7,
> +    /* POWER8 exception model           */
> +    POWERPC_EXCP_POWER8,
> +    /* POWER9 exception model           */
> +    POWERPC_EXCP_POWER9,
> +    /* POWER10 exception model           */
> +    POWERPC_EXCP_POWER10,
> +} powerpc_excp_t;
> +
>   #define PPC_INPUT(env) ((env)->bus_model)
>   
>   /*****************************************************************************/


