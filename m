Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F85741F77
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 07:05:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEjpA-0008Qy-AC; Thu, 29 Jun 2023 01:04:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=1kQ5=CR=kaod.org=clg@ozlabs.org>)
 id 1qEjp7-0008QB-OR; Thu, 29 Jun 2023 01:04:05 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=1kQ5=CR=kaod.org=clg@ozlabs.org>)
 id 1qEjp6-0004AG-5N; Thu, 29 Jun 2023 01:04:05 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Qs5vj1pC8z4wgk;
 Thu, 29 Jun 2023 15:04:01 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qs5vf2n0Rz4wp3;
 Thu, 29 Jun 2023 15:03:58 +1000 (AEST)
Message-ID: <3a1fe20e-8d6e-6de8-1a75-fb15a4910836@kaod.org>
Date: Thu, 29 Jun 2023 07:03:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 3/6] target/ppc: Move CPU QOM definitions to cpu-qom.h
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Greg Kurz <groug@kaod.org>,
 kvm@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>
References: <20230627115124.19632-1-philmd@linaro.org>
 <20230627115124.19632-4-philmd@linaro.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230627115124.19632-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=1kQ5=CR=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.089, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 6/27/23 13:51, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>




Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.



> ---
>   target/ppc/cpu-qom.h | 5 +++++
>   target/ppc/cpu.h     | 6 ------
>   2 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
> index 9666f54f65..c2bff349cc 100644
> --- a/target/ppc/cpu-qom.h
> +++ b/target/ppc/cpu-qom.h
> @@ -31,6 +31,11 @@
>   
>   OBJECT_DECLARE_CPU_TYPE(PowerPCCPU, PowerPCCPUClass, POWERPC_CPU)
>   
> +#define POWERPC_CPU_TYPE_SUFFIX "-" TYPE_POWERPC_CPU
> +#define POWERPC_CPU_TYPE_NAME(model) model POWERPC_CPU_TYPE_SUFFIX
> +#define CPU_RESOLVING_TYPE TYPE_POWERPC_CPU
> +#define cpu_list ppc_cpu_list
> +
>   ObjectClass *ppc_cpu_class_by_name(const char *name);
>   
>   typedef struct CPUArchState CPUPPCState;
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index af12c93ebc..e91e1774e5 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1468,12 +1468,6 @@ static inline uint64_t ppc_dump_gpr(CPUPPCState *env, int gprn)
>   int ppc_dcr_read(ppc_dcr_t *dcr_env, int dcrn, uint32_t *valp);
>   int ppc_dcr_write(ppc_dcr_t *dcr_env, int dcrn, uint32_t val);
>   
> -#define POWERPC_CPU_TYPE_SUFFIX "-" TYPE_POWERPC_CPU
> -#define POWERPC_CPU_TYPE_NAME(model) model POWERPC_CPU_TYPE_SUFFIX
> -#define CPU_RESOLVING_TYPE TYPE_POWERPC_CPU
> -
> -#define cpu_list ppc_cpu_list
> -
>   /* MMU modes definitions */
>   #define MMU_USER_IDX 0
>   static inline int cpu_mmu_index(CPUPPCState *env, bool ifetch)


