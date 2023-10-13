Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 515057C877A
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 16:07:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrInf-0001dn-R2; Fri, 13 Oct 2023 10:05:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=fS+4=F3=kaod.org=clg@ozlabs.org>)
 id 1qrInb-0001Oa-MA; Fri, 13 Oct 2023 10:05:55 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=fS+4=F3=kaod.org=clg@ozlabs.org>)
 id 1qrInZ-0003GU-OF; Fri, 13 Oct 2023 10:05:55 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4S6Svz1wpqz4xWn;
 Sat, 14 Oct 2023 01:05:51 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4S6Svx19J4z4xZX;
 Sat, 14 Oct 2023 01:05:48 +1100 (AEDT)
Message-ID: <0defc3fe-7dc3-461f-bb17-8277a381b3a9@kaod.org>
Date: Fri, 13 Oct 2023 16:05:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] target/ppc: Move powerpc_input_t definition to 'cpu.h'
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
References: <20231013125630.95116-1-philmd@linaro.org>
 <20231013125630.95116-8-philmd@linaro.org>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20231013125630.95116-8-philmd@linaro.org>
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
> The powerpc_input_t definition is only used by target/ppc/, no need
> to expose it. Restrict it by moving it to "target/ppc/cpu.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>


Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


> ---
>   target/ppc/cpu-qom.h | 21 ---------------------
>   target/ppc/cpu.h     | 20 ++++++++++++++++++++
>   2 files changed, 20 insertions(+), 21 deletions(-)
> 
> diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
> index 5bdca472be..6d39ad451c 100644
> --- a/target/ppc/cpu-qom.h
> +++ b/target/ppc/cpu-qom.h
> @@ -36,25 +36,4 @@ OBJECT_DECLARE_CPU_TYPE(PowerPCCPU, PowerPCCPUClass, POWERPC_CPU)
>   
>   #define TYPE_HOST_POWERPC_CPU POWERPC_CPU_TYPE_NAME("host")
>   
> -/*****************************************************************************/
> -/* Input pins model                                                          */
> -typedef enum powerpc_input_t powerpc_input_t;
> -enum powerpc_input_t {
> -    PPC_FLAGS_INPUT_UNKNOWN = 0,
> -    /* PowerPC 6xx bus                  */
> -    PPC_FLAGS_INPUT_6xx,
> -    /* BookE bus                        */
> -    PPC_FLAGS_INPUT_BookE,
> -    /* PowerPC 405 bus                  */
> -    PPC_FLAGS_INPUT_405,
> -    /* PowerPC 970 bus                  */
> -    PPC_FLAGS_INPUT_970,
> -    /* PowerPC POWER7 bus               */
> -    PPC_FLAGS_INPUT_POWER7,
> -    /* PowerPC POWER9 bus               */
> -    PPC_FLAGS_INPUT_POWER9,
> -    /* Freescale RCPU bus               */
> -    PPC_FLAGS_INPUT_RCPU,
> -};
> -
>   #endif
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index c2cd069095..4b8b5d3d3e 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -259,6 +259,26 @@ static inline bool mmu_is_64bit(powerpc_mmu_t mmu_model)
>       return mmu_model & POWERPC_MMU_64;
>   }
>   
> +/*****************************************************************************/
> +/* Input pins model                                                          */
> +typedef enum powerpc_input_t {
> +    PPC_FLAGS_INPUT_UNKNOWN = 0,
> +    /* PowerPC 6xx bus                  */
> +    PPC_FLAGS_INPUT_6xx,
> +    /* BookE bus                        */
> +    PPC_FLAGS_INPUT_BookE,
> +    /* PowerPC 405 bus                  */
> +    PPC_FLAGS_INPUT_405,
> +    /* PowerPC 970 bus                  */
> +    PPC_FLAGS_INPUT_970,
> +    /* PowerPC POWER7 bus               */
> +    PPC_FLAGS_INPUT_POWER7,
> +    /* PowerPC POWER9 bus               */
> +    PPC_FLAGS_INPUT_POWER9,
> +    /* Freescale RCPU bus               */
> +    PPC_FLAGS_INPUT_RCPU,
> +} powerpc_input_t;
> +
>   #define PPC_INPUT(env) ((env)->bus_model)
>   
>   /*****************************************************************************/


