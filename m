Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D340A7195CD
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 10:41:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4dqT-0002y2-Si; Thu, 01 Jun 2023 04:39:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=vOrz=BV=kaod.org=clg@ozlabs.org>)
 id 1q4dqS-0002vs-9B; Thu, 01 Jun 2023 04:39:44 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=vOrz=BV=kaod.org=clg@ozlabs.org>)
 id 1q4dqP-00043N-7u; Thu, 01 Jun 2023 04:39:44 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QX01Q5jztz4x4R;
 Thu,  1 Jun 2023 18:39:38 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QX01N6DN3z4x3g;
 Thu,  1 Jun 2023 18:39:36 +1000 (AEST)
Message-ID: <32301038-65a7-3169-0582-3738360e43be@kaod.org>
Date: Thu, 1 Jun 2023 10:39:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 4/7] target/ppc: Remove some unneded line breaks
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Daniel Henrique Barboza <danielhb413@gmail.com>
References: <cover.1685448535.git.balaton@eik.bme.hu>
 <70952ba2d82141db1cf5cfcf4b227402be575874.1685448535.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <70952ba2d82141db1cf5cfcf4b227402be575874.1685448535.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=vOrz=BV=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.091,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 5/30/23 15:28, BALATON Zoltan wrote:
> Make lines shorter and fix indentation in some functions prototypes.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>


Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.

> ---
>   target/ppc/cpu.h        | 8 +++-----
>   target/ppc/mmu_common.c | 8 +++-----
>   2 files changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 77eb5edea2..4545f74fdd 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1425,12 +1425,10 @@ void store_booke_tsr(CPUPPCState *env, target_ulong val);
>   void ppc_tlb_invalidate_all(CPUPPCState *env);
>   void ppc_tlb_invalidate_one(CPUPPCState *env, target_ulong addr);
>   void cpu_ppc_set_vhyp(PowerPCCPU *cpu, PPCVirtualHypervisor *vhyp);
> -int ppcmas_tlb_check(CPUPPCState *env, ppcmas_tlb_t *tlb,
> -                            hwaddr *raddrp, target_ulong address,
> -                            uint32_t pid);
> +int ppcmas_tlb_check(CPUPPCState *env, ppcmas_tlb_t *tlb, hwaddr *raddrp,
> +                     target_ulong address, uint32_t pid);
>   int ppcemb_tlb_search(CPUPPCState *env, target_ulong address, uint32_t pid);
> -hwaddr booke206_tlb_to_page_size(CPUPPCState *env,
> -                                        ppcmas_tlb_t *tlb);
> +hwaddr booke206_tlb_to_page_size(CPUPPCState *env, ppcmas_tlb_t *tlb);
>   #endif
>   #endif
>   
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index 845eee4c6f..a84bc7de88 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -694,8 +694,7 @@ static int mmubooke_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
>       return ret;
>   }
>   
> -hwaddr booke206_tlb_to_page_size(CPUPPCState *env,
> -                                        ppcmas_tlb_t *tlb)
> +hwaddr booke206_tlb_to_page_size(CPUPPCState *env, ppcmas_tlb_t *tlb)
>   {
>       int tlbm_size;
>   
> @@ -705,9 +704,8 @@ hwaddr booke206_tlb_to_page_size(CPUPPCState *env,
>   }
>   
>   /* TLB check function for MAS based SoftTLBs */
> -int ppcmas_tlb_check(CPUPPCState *env, ppcmas_tlb_t *tlb,
> -                            hwaddr *raddrp, target_ulong address,
> -                            uint32_t pid)
> +int ppcmas_tlb_check(CPUPPCState *env, ppcmas_tlb_t *tlb, hwaddr *raddrp,
> +                     target_ulong address, uint32_t pid)
>   {
>       hwaddr mask;
>       uint32_t tlb_pid;


