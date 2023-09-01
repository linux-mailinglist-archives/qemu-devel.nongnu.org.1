Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3CC78FD26
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 14:26:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc3E0-0002UW-7C; Fri, 01 Sep 2023 08:26:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=SnXb=ER=kaod.org=clg@ozlabs.org>)
 id 1qc3Dy-0002UE-7b; Fri, 01 Sep 2023 08:26:06 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=SnXb=ER=kaod.org=clg@ozlabs.org>)
 id 1qc3Dv-0007pf-RR; Fri, 01 Sep 2023 08:26:05 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Rcch64V1Tz4wy9;
 Fri,  1 Sep 2023 22:25:58 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rcch40bm9z4wy7;
 Fri,  1 Sep 2023 22:25:55 +1000 (AEST)
Message-ID: <59203654-9490-0b2c-af6d-3d52577c41ff@kaod.org>
Date: Fri, 1 Sep 2023 14:25:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 08/19] target/ppc: Sign-extend large decrementer to
 64-bits
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
References: <20230808042001.411094-1-npiggin@gmail.com>
 <20230808042001.411094-9-npiggin@gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230808042001.411094-9-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=SnXb=ER=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-3.478, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Nick,

On 8/8/23 06:19, Nicholas Piggin wrote:
> When storing a large decrementer value with the most significant
> implemented bit set, it is to be treated as a negative and sign
> extended.
> 
> This isn't hit for book3s DEC because of another bug, fixing it
> in the next patch exposes this one and can cause additional
> problems, so fix this first. It can be hit with HDECR and other
> edge triggered types.
> 
> Fixes: a8dafa52518 ("target/ppc: Implement large decrementer support for TCG")
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   hw/ppc/ppc.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
> index a397820d9c..fb4784793c 100644
> --- a/hw/ppc/ppc.c
> +++ b/hw/ppc/ppc.c
> @@ -743,7 +743,9 @@ target_ulong cpu_ppc_load_decr(CPUPPCState *env)
>        * to 64 bits, otherwise it is a 32 bit value.
>        */
>       if (env->spr[SPR_LPCR] & LPCR_LD) {
> -        return decr;
> +        PowerPCCPU *cpu = env_archcpu(env);
> +        PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
> +        return sextract64(decr, 0, pcc->lrg_decr_bits);
>       }
>       return (uint32_t) decr;
>   }
> @@ -762,7 +764,9 @@ target_ulong cpu_ppc_load_hdecr(CPUPPCState *env)
>        * extended to 64 bits, otherwise it is 32 bits.
>        */
>       if (pcc->lrg_decr_bits > 32) {
> -        return hdecr;
> +        PowerPCCPU *cpu = env_archcpu(env);
> +        PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);

Why are 'cpu' and 'ppc' duplicated ?

Thanks,

C.


> +        return sextract64(hdecr, 0, pcc->lrg_decr_bits);
>       }
>       return (uint32_t) hdecr;
>   }


