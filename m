Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C327655CD
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 16:20:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP0xJ-000743-5F; Thu, 27 Jul 2023 09:23:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=csIm=DN=kaod.org=clg@ozlabs.org>)
 id 1qP0x5-00072f-Ox; Thu, 27 Jul 2023 09:22:48 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=csIm=DN=kaod.org=clg@ozlabs.org>)
 id 1qP0x1-0002EU-29; Thu, 27 Jul 2023 09:22:47 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4RBWf44D0cz4wbj;
 Thu, 27 Jul 2023 23:22:36 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4RBWf22lFNz4wbP;
 Thu, 27 Jul 2023 23:22:34 +1000 (AEST)
Message-ID: <f3a7f1d8-4f4a-e45d-4b9f-aebc44dd08b7@kaod.org>
Date: Thu, 27 Jul 2023 15:22:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/6] target/ppc: Implement ASDR register for ISA v3.0 for
 HPT
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
References: <20230726182230.433945-1-npiggin@gmail.com>
 <20230726182230.433945-2-npiggin@gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230726182230.433945-2-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=csIm=DN=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
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

On 7/26/23 20:22, Nicholas Piggin wrote:
> The ASDR register was introduced in ISA v3.0. It has not been
> implemented for HPT. With HPT, ASDR is the format of the slbmte RS
> operand (containing VSID), which matches the ppc_slb_t field.
> 
> Fixes: 3367c62f522b ("target/ppc: Support for POWER9 native hash")
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

According to the ISA, the Address Access Segment Descriptor Register (ASDR)
can also be set with an MCE. Anyway,

Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


> ---
>   target/ppc/mmu-hash64.c | 27 ++++++++++++++++-----------
>   1 file changed, 16 insertions(+), 11 deletions(-)
> 
> diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> index 900f906990..a0c90df3ce 100644
> --- a/target/ppc/mmu-hash64.c
> +++ b/target/ppc/mmu-hash64.c
> @@ -770,7 +770,8 @@ static bool ppc_hash64_use_vrma(CPUPPCState *env)
>       }
>   }
>   
> -static void ppc_hash64_set_isi(CPUState *cs, int mmu_idx, uint64_t error_code)
> +static void ppc_hash64_set_isi(CPUState *cs, int mmu_idx, uint64_t slb_vsid,
> +                               uint64_t error_code)
>   {
>       CPUPPCState *env = &POWERPC_CPU(cs)->env;
>       bool vpm;
> @@ -782,13 +783,15 @@ static void ppc_hash64_set_isi(CPUState *cs, int mmu_idx, uint64_t error_code)
>       }
>       if (vpm && !mmuidx_hv(mmu_idx)) {
>           cs->exception_index = POWERPC_EXCP_HISI;
> +        env->spr[SPR_ASDR] = slb_vsid;
>       } else {
>           cs->exception_index = POWERPC_EXCP_ISI;
>       }
>       env->error_code = error_code;
>   }
>   
> -static void ppc_hash64_set_dsi(CPUState *cs, int mmu_idx, uint64_t dar, uint64_t dsisr)
> +static void ppc_hash64_set_dsi(CPUState *cs, int mmu_idx, uint64_t slb_vsid,
> +                               uint64_t dar, uint64_t dsisr)
>   {
>       CPUPPCState *env = &POWERPC_CPU(cs)->env;
>       bool vpm;
> @@ -802,6 +805,7 @@ static void ppc_hash64_set_dsi(CPUState *cs, int mmu_idx, uint64_t dar, uint64_t
>           cs->exception_index = POWERPC_EXCP_HDSI;
>           env->spr[SPR_HDAR] = dar;
>           env->spr[SPR_HDSISR] = dsisr;
> +        env->spr[SPR_ASDR] = slb_vsid;
>       } else {
>           cs->exception_index = POWERPC_EXCP_DSI;
>           env->spr[SPR_DAR] = dar;
> @@ -963,13 +967,13 @@ bool ppc_hash64_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
>                   }
>                   switch (access_type) {
>                   case MMU_INST_FETCH:
> -                    ppc_hash64_set_isi(cs, mmu_idx, SRR1_PROTFAULT);
> +                    ppc_hash64_set_isi(cs, mmu_idx, 0, SRR1_PROTFAULT);
>                       break;
>                   case MMU_DATA_LOAD:
> -                    ppc_hash64_set_dsi(cs, mmu_idx, eaddr, DSISR_PROTFAULT);
> +                    ppc_hash64_set_dsi(cs, mmu_idx, 0, eaddr, DSISR_PROTFAULT);
>                       break;
>                   case MMU_DATA_STORE:
> -                    ppc_hash64_set_dsi(cs, mmu_idx, eaddr,
> +                    ppc_hash64_set_dsi(cs, mmu_idx, 0, eaddr,
>                                          DSISR_PROTFAULT | DSISR_ISSTORE);
>                       break;
>                   default:
> @@ -1022,7 +1026,7 @@ bool ppc_hash64_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
>       /* 3. Check for segment level no-execute violation */
>       if (access_type == MMU_INST_FETCH && (slb->vsid & SLB_VSID_N)) {
>           if (guest_visible) {
> -            ppc_hash64_set_isi(cs, mmu_idx, SRR1_NOEXEC_GUARD);
> +            ppc_hash64_set_isi(cs, mmu_idx, slb->vsid, SRR1_NOEXEC_GUARD);
>           }
>           return false;
>       }
> @@ -1035,13 +1039,14 @@ bool ppc_hash64_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
>           }
>           switch (access_type) {
>           case MMU_INST_FETCH:
> -            ppc_hash64_set_isi(cs, mmu_idx, SRR1_NOPTE);
> +            ppc_hash64_set_isi(cs, mmu_idx, slb->vsid, SRR1_NOPTE);
>               break;
>           case MMU_DATA_LOAD:
> -            ppc_hash64_set_dsi(cs, mmu_idx, eaddr, DSISR_NOPTE);
> +            ppc_hash64_set_dsi(cs, mmu_idx, slb->vsid, eaddr, DSISR_NOPTE);
>               break;
>           case MMU_DATA_STORE:
> -            ppc_hash64_set_dsi(cs, mmu_idx, eaddr, DSISR_NOPTE | DSISR_ISSTORE);
> +            ppc_hash64_set_dsi(cs, mmu_idx, slb->vsid, eaddr,
> +                               DSISR_NOPTE | DSISR_ISSTORE);
>               break;
>           default:
>               g_assert_not_reached();
> @@ -1075,7 +1080,7 @@ bool ppc_hash64_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
>               if (PAGE_EXEC & ~amr_prot) {
>                   srr1 |= SRR1_IAMR; /* Access violates virt pg class key prot */
>               }
> -            ppc_hash64_set_isi(cs, mmu_idx, srr1);
> +            ppc_hash64_set_isi(cs, mmu_idx, slb->vsid, srr1);
>           } else {
>               int dsisr = 0;
>               if (need_prot & ~pp_prot) {
> @@ -1087,7 +1092,7 @@ bool ppc_hash64_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
>               if (need_prot & ~amr_prot) {
>                   dsisr |= DSISR_AMR;
>               }
> -            ppc_hash64_set_dsi(cs, mmu_idx, eaddr, dsisr);
> +            ppc_hash64_set_dsi(cs, mmu_idx, slb->vsid, eaddr, dsisr);
>           }
>           return false;
>       }


