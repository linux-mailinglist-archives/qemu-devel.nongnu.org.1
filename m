Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A74722A14
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 16:58:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6BfL-0002R9-3l; Mon, 05 Jun 2023 10:58:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=6mOa=BZ=kaod.org=clg@ozlabs.org>)
 id 1q6BfH-0002Jb-35; Mon, 05 Jun 2023 10:58:35 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=6mOa=BZ=kaod.org=clg@ozlabs.org>)
 id 1q6BfE-0007K1-9H; Mon, 05 Jun 2023 10:58:34 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QZcDj5Bmsz4x1f;
 Tue,  6 Jun 2023 00:58:29 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QZcDg1qVzz4x4B;
 Tue,  6 Jun 2023 00:58:26 +1000 (AEST)
Message-ID: <6e5da157-8969-b5e3-5a07-465a4828f40d@kaod.org>
Date: Mon, 5 Jun 2023 16:58:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/4] target/ppc: Tidy POWER book4 SPR registration
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>
References: <20230603233612.125879-1-npiggin@gmail.com>
 <20230603233612.125879-3-npiggin@gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230603233612.125879-3-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=6mOa=BZ=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.09, SPF_HELO_PASS=-0.001,
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

On 6/4/23 01:36, Nicholas Piggin wrote:
> POWER book4 (implementation-specific) SPRs are sometimes in their own
> functions, but in other cases are mixed with architected SPRs. Do some
> spring cleaning on these.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


> ---
>   target/ppc/cpu_init.c | 92 ++++++++++++++++++++++++++++---------------
>   1 file changed, 60 insertions(+), 32 deletions(-)
> 
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index e9717b8169..da0f7a7159 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -5374,31 +5374,6 @@ static void register_book3s_ids_sprs(CPUPPCState *env)
>                    &spr_read_generic, SPR_NOACCESS,
>                    &spr_read_generic, NULL,
>                    0x00000000);
> -    spr_register_hv(env, SPR_HID0, "HID0",
> -                 SPR_NOACCESS, SPR_NOACCESS,
> -                 SPR_NOACCESS, SPR_NOACCESS,
> -                 &spr_read_generic, &spr_core_write_generic,
> -                 0x00000000);
> -    spr_register_hv(env, SPR_TSCR, "TSCR",
> -                 SPR_NOACCESS, SPR_NOACCESS,
> -                 SPR_NOACCESS, SPR_NOACCESS,
> -                 &spr_read_generic, &spr_write_generic32,
> -                 0x00000000);
> -    spr_register_hv(env, SPR_HMER, "HMER",
> -                 SPR_NOACCESS, SPR_NOACCESS,
> -                 SPR_NOACCESS, SPR_NOACCESS,
> -                 &spr_read_generic, &spr_write_hmer,
> -                 0x00000000);
> -    spr_register_hv(env, SPR_HMEER, "HMEER",
> -                 SPR_NOACCESS, SPR_NOACCESS,
> -                 SPR_NOACCESS, SPR_NOACCESS,
> -                 &spr_read_generic, &spr_write_generic,
> -                 0x00000000);
> -    spr_register_hv(env, SPR_TFMR, "TFMR",
> -                 SPR_NOACCESS, SPR_NOACCESS,
> -                 SPR_NOACCESS, SPR_NOACCESS,
> -                 &spr_read_generic, &spr_write_generic,
> -                 0x00000000);
>       spr_register_hv(env, SPR_LPIDR, "LPIDR",
>                    SPR_NOACCESS, SPR_NOACCESS,
>                    SPR_NOACCESS, SPR_NOACCESS,
> @@ -5454,11 +5429,6 @@ static void register_book3s_ids_sprs(CPUPPCState *env)
>                    SPR_NOACCESS, SPR_NOACCESS,
>                    &spr_read_generic, &spr_write_generic,
>                    0x00000000);
> -    spr_register_hv(env, SPR_LDBAR, "LDBAR",
> -                 SPR_NOACCESS, SPR_NOACCESS,
> -                 SPR_NOACCESS, SPR_NOACCESS,
> -                 &spr_read_generic, &spr_write_generic,
> -                 0x00000000);
>   }
>   
>   static void register_rmor_sprs(CPUPPCState *env)
> @@ -5665,14 +5635,65 @@ static void register_power8_ic_sprs(CPUPPCState *env)
>   #endif
>   }
>   
> +/* SPRs specific to IBM POWER CPUs */
> +static void register_power_common_book4_sprs(CPUPPCState *env)
> +{
> +#if !defined(CONFIG_USER_ONLY)
> +    spr_register_hv(env, SPR_HID0, "HID0",
> +                 SPR_NOACCESS, SPR_NOACCESS,
> +                 SPR_NOACCESS, SPR_NOACCESS,
> +                 &spr_read_generic, &spr_core_write_generic,
> +                 0x00000000);
> +    spr_register_hv(env, SPR_TSCR, "TSCR",
> +                 SPR_NOACCESS, SPR_NOACCESS,
> +                 SPR_NOACCESS, SPR_NOACCESS,
> +                 &spr_read_generic, &spr_write_generic32,
> +                 0x00000000);
> +    spr_register_hv(env, SPR_HMER, "HMER",
> +                 SPR_NOACCESS, SPR_NOACCESS,
> +                 SPR_NOACCESS, SPR_NOACCESS,
> +                 &spr_read_generic, &spr_write_hmer,
> +                 0x00000000);
> +    spr_register_hv(env, SPR_HMEER, "HMEER",
> +                 SPR_NOACCESS, SPR_NOACCESS,
> +                 SPR_NOACCESS, SPR_NOACCESS,
> +                 &spr_read_generic, &spr_write_generic,
> +                 0x00000000);
> +    spr_register_hv(env, SPR_TFMR, "TFMR",
> +                 SPR_NOACCESS, SPR_NOACCESS,
> +                 SPR_NOACCESS, SPR_NOACCESS,
> +                 &spr_read_generic, &spr_write_generic,
> +                 0x00000000);
> +    spr_register_hv(env, SPR_LDBAR, "LDBAR",
> +                 SPR_NOACCESS, SPR_NOACCESS,
> +                 SPR_NOACCESS, SPR_NOACCESS,
> +                 &spr_read_generic, &spr_write_generic,
> +                 0x00000000);
> +#endif
> +}
> +
> +static void register_power9_book4_sprs(CPUPPCState *env)
> +{
> +    /* Add a number of P9 book4 registers */
> +    register_power_common_book4_sprs(env);
> +#if !defined(CONFIG_USER_ONLY)
> +    spr_register_kvm(env, SPR_WORT, "WORT",
> +                     SPR_NOACCESS, SPR_NOACCESS,
> +                     &spr_read_generic, &spr_write_generic,
> +                     KVM_REG_PPC_WORT, 0);
> +#endif
> +}
> +
>   static void register_power8_book4_sprs(CPUPPCState *env)
>   {
>       /* Add a number of P8 book4 registers */
> +    register_power_common_book4_sprs(env);
>   #if !defined(CONFIG_USER_ONLY)
>       spr_register_kvm(env, SPR_ACOP, "ACOP",
>                        SPR_NOACCESS, SPR_NOACCESS,
>                        &spr_read_generic, &spr_write_generic,
>                        KVM_REG_PPC_ACOP, 0);
> +    /* PID is only in BookE in ISA v2.07 */
>       spr_register_kvm(env, SPR_BOOKS_PID, "PID",
>                        SPR_NOACCESS, SPR_NOACCESS,
>                        &spr_read_generic, &spr_write_pidr,
> @@ -5688,10 +5709,12 @@ static void register_power7_book4_sprs(CPUPPCState *env)
>   {
>       /* Add a number of P7 book4 registers */
>   #if !defined(CONFIG_USER_ONLY)
> +    register_power_common_book4_sprs(env);
>       spr_register_kvm(env, SPR_ACOP, "ACOP",
>                        SPR_NOACCESS, SPR_NOACCESS,
>                        &spr_read_generic, &spr_write_generic,
>                        KVM_REG_PPC_ACOP, 0);
> +    /* PID is only in BookE in ISA v2.06 */
>       spr_register_kvm(env, SPR_BOOKS_PID, "PID",
>                        SPR_NOACCESS, SPR_NOACCESS,
>                        &spr_read_generic, &spr_write_generic32,
> @@ -5725,6 +5748,11 @@ static void register_power9_mmu_sprs(CPUPPCState *env)
>                       SPR_NOACCESS, SPR_NOACCESS,
>                       &spr_read_generic, &spr_write_generic,
>                       0x0000000000000000);
> +    /* PID is part of the BookS ISA from v3.0 */
> +    spr_register_kvm(env, SPR_BOOKS_PID, "PID",
> +                     SPR_NOACCESS, SPR_NOACCESS,
> +                     &spr_read_generic, &spr_write_pidr,
> +                     KVM_REG_PPC_PID, 0);
>   #endif
>   }
>   
> @@ -6278,7 +6306,7 @@ static void init_proc_POWER9(CPUPPCState *env)
>       register_power8_dpdes_sprs(env);
>       register_vtb_sprs(env);
>       register_power8_ic_sprs(env);
> -    register_power8_book4_sprs(env);
> +    register_power9_book4_sprs(env);
>       register_power8_rpr_sprs(env);
>       register_power9_mmu_sprs(env);
>   
> @@ -6471,7 +6499,7 @@ static void init_proc_POWER10(CPUPPCState *env)
>       register_power8_dpdes_sprs(env);
>       register_vtb_sprs(env);
>       register_power8_ic_sprs(env);
> -    register_power8_book4_sprs(env);
> +    register_power9_book4_sprs(env);
>       register_power8_rpr_sprs(env);
>       register_power9_mmu_sprs(env);
>       register_power10_hash_sprs(env);


