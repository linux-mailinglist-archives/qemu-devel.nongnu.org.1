Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C66E838805
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 08:35:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSBJI-00082v-D1; Tue, 23 Jan 2024 02:35:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=9HdW=JB=kaod.org=clg@ozlabs.org>)
 id 1rSBJ9-0007zu-IF; Tue, 23 Jan 2024 02:34:56 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=9HdW=JB=kaod.org=clg@ozlabs.org>)
 id 1rSBJ6-0000ju-KG; Tue, 23 Jan 2024 02:34:54 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TJzPh0gmPz4wcc;
 Tue, 23 Jan 2024 18:34:48 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TJzPf5p9Xz4wcX;
 Tue, 23 Jan 2024 18:34:46 +1100 (AEDT)
Message-ID: <22d81980-80a3-4b19-b0e8-bf022c6db832@kaod.org>
Date: Tue, 23 Jan 2024 08:34:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/ppc: Re-name registers to match ISA
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org
References: <20231201122455.143936-1-npiggin@gmail.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20231201122455.143936-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=9HdW=JB=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 12/1/23 13:24, Nicholas Piggin wrote:
> Several registers have names that don't match the ISA (or convention
> with other QEMU PPC registers), making them unintuitive to use with
> GDB.
> 
> Fortunately most of these registers are obscure and/or have not been
> correctly implemented in the gdb server (e.g., DEC, TB, CFAR), so risk
> of breaking users should be low.
> 
> QEMU should follow the ISA for register name convention (where there is
> no established GDB name).
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>


Acked-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


> ---
> There is never a great time to change user interface, but I'd like to
> make this change for 9.0.
> 
> Thanks,
> Nick
> 
>   target/ppc/cpu_init.c    | 20 ++++++++++----------
>   target/ppc/helper_regs.c |  2 +-
>   2 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index 40fe14a6c2..15c1f2fdc8 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -5062,7 +5062,7 @@ static void register_970_hid_sprs(CPUPPCState *env)
>   
>   static void register_970_hior_sprs(CPUPPCState *env)
>   {
> -    spr_register(env, SPR_HIOR, "SPR_HIOR",
> +    spr_register(env, SPR_HIOR, "HIOR",
>                    SPR_NOACCESS, SPR_NOACCESS,
>                    &spr_read_hior, &spr_write_hior,
>                    0x00000000);
> @@ -5070,11 +5070,11 @@ static void register_970_hior_sprs(CPUPPCState *env)
>   
>   static void register_book3s_ctrl_sprs(CPUPPCState *env)
>   {
> -    spr_register(env, SPR_CTRL, "SPR_CTRL",
> +    spr_register(env, SPR_CTRL, "CTRL",
>                    SPR_NOACCESS, SPR_NOACCESS,
>                    SPR_NOACCESS, &spr_write_CTRL,
>                    0x00000000);
> -    spr_register(env, SPR_UCTRL, "SPR_UCTRL",
> +    spr_register(env, SPR_UCTRL, "UCTRL",
>                    &spr_read_ureg, SPR_NOACCESS,
>                    &spr_read_ureg, SPR_NOACCESS,
>                    0x00000000);
> @@ -5465,7 +5465,7 @@ static void register_book3s_purr_sprs(CPUPPCState *env)
>   static void register_power6_dbg_sprs(CPUPPCState *env)
>   {
>   #if !defined(CONFIG_USER_ONLY)
> -    spr_register(env, SPR_CFAR, "SPR_CFAR",
> +    spr_register(env, SPR_CFAR, "CFAR",
>                    SPR_NOACCESS, SPR_NOACCESS,
>                    &spr_read_cfar, &spr_write_cfar,
>                    0x00000000);
> @@ -5483,7 +5483,7 @@ static void register_power5p_common_sprs(CPUPPCState *env)
>   static void register_power6_common_sprs(CPUPPCState *env)
>   {
>   #if !defined(CONFIG_USER_ONLY)
> -    spr_register_kvm(env, SPR_DSCR, "SPR_DSCR",
> +    spr_register_kvm(env, SPR_DSCR, "DSCR",
>                        SPR_NOACCESS, SPR_NOACCESS,
>                        &spr_read_generic, &spr_write_generic,
>                        KVM_REG_PPC_DSCR, 0x00000000);
> @@ -5695,7 +5695,7 @@ static void register_power8_book4_sprs(CPUPPCState *env)
>                        &spr_read_generic, &spr_write_generic,
>                        KVM_REG_PPC_ACOP, 0);
>       /* PID is only in BookE in ISA v2.07 */
> -    spr_register_kvm(env, SPR_BOOKS_PID, "PID",
> +    spr_register_kvm(env, SPR_BOOKS_PID, "PIDR",
>                        SPR_NOACCESS, SPR_NOACCESS,
>                        &spr_read_generic, &spr_write_pidr,
>                        KVM_REG_PPC_PID, 0);
> @@ -5716,7 +5716,7 @@ static void register_power7_book4_sprs(CPUPPCState *env)
>                        &spr_read_generic, &spr_write_generic,
>                        KVM_REG_PPC_ACOP, 0);
>       /* PID is only in BookE in ISA v2.06 */
> -    spr_register_kvm(env, SPR_BOOKS_PID, "PID",
> +    spr_register_kvm(env, SPR_BOOKS_PID, "PIDR",
>                        SPR_NOACCESS, SPR_NOACCESS,
>                        &spr_read_generic, &spr_write_generic32,
>                        KVM_REG_PPC_PID, 0);
> @@ -5750,7 +5750,7 @@ static void register_power9_mmu_sprs(CPUPPCState *env)
>                       &spr_read_generic, &spr_write_generic,
>                       0x0000000000000000);
>       /* PID is part of the BookS ISA from v3.0 */
> -    spr_register_kvm(env, SPR_BOOKS_PID, "PID",
> +    spr_register_kvm(env, SPR_BOOKS_PID, "PIDR",
>                        SPR_NOACCESS, SPR_NOACCESS,
>                        &spr_read_generic, &spr_write_pidr,
>                        KVM_REG_PPC_PID, 0);
> @@ -5791,7 +5791,7 @@ static void register_power10_dexcr_sprs(CPUPPCState *env)
>               &spr_read_generic, &spr_write_generic32,
>               0);
>   
> -    spr_register(env, SPR_UDEXCR, "DEXCR",
> +    spr_register(env, SPR_UDEXCR, "UDEXCR",
>               &spr_read_dexcr_ureg, SPR_NOACCESS,
>               &spr_read_dexcr_ureg, SPR_NOACCESS,
>               0);
> @@ -5802,7 +5802,7 @@ static void register_power10_dexcr_sprs(CPUPPCState *env)
>               &spr_read_generic, &spr_write_generic32,
>               0);
>   
> -    spr_register(env, SPR_UHDEXCR, "HDEXCR",
> +    spr_register(env, SPR_UHDEXCR, "UHDEXCR",
>               &spr_read_dexcr_ureg, SPR_NOACCESS,
>               &spr_read_dexcr_ureg, SPR_NOACCESS,
>               0);
> diff --git a/target/ppc/helper_regs.c b/target/ppc/helper_regs.c
> index f1493ddca0..59cf3dfaae 100644
> --- a/target/ppc/helper_regs.c
> +++ b/target/ppc/helper_regs.c
> @@ -509,7 +509,7 @@ void register_non_embedded_sprs(CPUPPCState *env)
>                        &spr_read_generic, &spr_write_generic,
>                        KVM_REG_PPC_DAR, 0x00000000);
>       /* Timer */
> -    spr_register(env, SPR_DECR, "DECR",
> +    spr_register(env, SPR_DECR, "DEC",
>                    SPR_NOACCESS, SPR_NOACCESS,
>                    &spr_read_decr, &spr_write_decr,
>                    0x00000000);


