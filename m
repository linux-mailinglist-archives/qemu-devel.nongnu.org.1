Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF26775FFD
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 14:58:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTik5-0005Ab-Jk; Wed, 09 Aug 2023 08:56:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Bozk=D2=kaod.org=clg@ozlabs.org>)
 id 1qTik4-0005AO-6r; Wed, 09 Aug 2023 08:56:48 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Bozk=D2=kaod.org=clg@ozlabs.org>)
 id 1qTik2-0008Ok-5f; Wed, 09 Aug 2023 08:56:47 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4RLVS32vJfz4wqX;
 Wed,  9 Aug 2023 22:56:35 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4RLVS02VgRz4wjG;
 Wed,  9 Aug 2023 22:56:32 +1000 (AEST)
Message-ID: <6732c873-7e53-26cf-49fe-fa42bc43b6d0@kaod.org>
Date: Wed, 9 Aug 2023 14:56:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 10/19] target/ppc: Migrate DECR SPR
To: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
References: <20230808042001.411094-1-npiggin@gmail.com>
 <20230808042001.411094-11-npiggin@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230808042001.411094-11-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=Bozk=D2=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-4.14, SPF_HELO_PASS=-0.001,
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

Hello Nick,

On 8/8/23 06:19, Nicholas Piggin wrote:
> TCG does not maintain the DEC reigster in the SPR array, so it does get
> migrated. TCG also needs to re-start the decrementer timer on the
> destination machine.
> 
> Load and store the decrementer into the SPR when migrating. This works
> for the level-triggered (book3s) decrementer, and should be compatible
> with existing KVM machines that do keep the DEC value there.
> 
> This fixes lost decrementer interrupt on migration that can cause
> hangs, as well as other problems including record-replay bugs.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   target/ppc/machine.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/target/ppc/machine.c b/target/ppc/machine.c
> index 8234e35d69..8a190c4853 100644
> --- a/target/ppc/machine.c
> +++ b/target/ppc/machine.c
> @@ -209,6 +209,14 @@ static int cpu_pre_save(void *opaque)
>       /* Used to retain migration compatibility for pre 6.0 for 601 machines. */
>       env->hflags_compat_nmsr = 0;
>   
> +    if (tcg_enabled()) {
> +        /*
> +         * TCG does not maintain the DECR spr (unlike KVM) so have to save
> +         * it here.
> +         */
> +        env->spr[SPR_DECR] = cpu_ppc_load_decr(env);
> +    }
> +
>       return 0;
>   }
>   
> @@ -319,6 +327,12 @@ static int cpu_post_load(void *opaque, int version_id)
>           ppc_update_ciabr(env);
>           ppc_update_daw0(env);
>   #endif
> +        /*
> +         * TCG needs to re-start the decrementer timer and/or raise the
> +         * interrupt. This works for level-triggered decrementer. Edge
> +         * triggered types (including HDEC) would need to carry more state.
> +         */
> +        cpu_ppc_store_decr(env, env->spr[SPR_DECR]);
>           pmu_mmcr01_updated(env);
>       }


This doesn't apply. I am missing some patch ?

Thanks,

C.


