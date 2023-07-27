Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B73776551E
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 15:34:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP0Yv-0008Vh-8p; Thu, 27 Jul 2023 08:57:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=csIm=DN=kaod.org=clg@ozlabs.org>)
 id 1qP0Ys-0008US-Na; Thu, 27 Jul 2023 08:57:46 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=csIm=DN=kaod.org=clg@ozlabs.org>)
 id 1qP0Yq-0002OI-GG; Thu, 27 Jul 2023 08:57:46 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4RBW5G6Fpfz4wxK;
 Thu, 27 Jul 2023 22:57:38 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4RBW5D5H3Lz4wqW;
 Thu, 27 Jul 2023 22:57:36 +1000 (AEST)
Message-ID: <8429260a-e169-2e4f-b1ea-4d832be2e99b@kaod.org>
Date: Thu, 27 Jul 2023 14:57:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/6] target/ppc: Fix pending HDEC when entering PM state
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
References: <20230726182230.433945-1-npiggin@gmail.com>
 <20230726182230.433945-4-npiggin@gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230726182230.433945-4-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=csIm=DN=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.091, SPF_HELO_PASS=-0.001,
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

On 7/26/23 20:22, Nicholas Piggin wrote:
> HDEC is defined to not wake from PM state. There is a check in the HDEC
> timer to avoid setting the interrupt if we are in a PM state, but no
> check on PM entry to lower HDEC if it already fired. This can cause a
> HDECR wake up and  QEMU abort with unsupported exception in Power Save
> mode.
> 
> Fixes: 4b236b621bf ("ppc: Initial HDEC support")
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>


Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


> ---
>   target/ppc/excp_helper.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 003805b202..9aa8e46566 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -2685,6 +2685,12 @@ void helper_pminsn(CPUPPCState *env, uint32_t insn)
>       env->resume_as_sreset = (insn != PPC_PM_STOP) ||
>           (env->spr[SPR_PSSCR] & PSSCR_EC);
>   
> +    /* HDECR is not to wake from PM state, it may have already fired */
> +    if (env->resume_as_sreset) {
> +        PowerPCCPU *cpu = env_archcpu(env);
> +        ppc_set_irq(cpu, PPC_INTERRUPT_HDECR, 0);
> +    }
> +
>       ppc_maybe_interrupt(env);
>   }
>   #endif /* defined(TARGET_PPC64) */


