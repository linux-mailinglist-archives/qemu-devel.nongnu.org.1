Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5846A7F6CA9
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 08:13:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6QMS-0005CH-2c; Fri, 24 Nov 2023 02:12:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=ZyQH=HF=kaod.org=clg@ozlabs.org>)
 id 1r6QML-0005A6-35; Fri, 24 Nov 2023 02:12:17 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=ZyQH=HF=kaod.org=clg@ozlabs.org>)
 id 1r6QMJ-0008GR-5j; Fri, 24 Nov 2023 02:12:16 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Sc5lC029Pz4wy1;
 Fri, 24 Nov 2023 18:12:07 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Sc5l92KW1z4wd7;
 Fri, 24 Nov 2023 18:12:05 +1100 (AEDT)
Message-ID: <dd37d99f-24be-4e26-9a90-19d3e33fd594@kaod.org>
Date: Fri, 24 Nov 2023 08:12:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] target/ppc: Improve timebase register defines
 naming
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 qemu-devel@nongnu.org
References: <20231124064001.198572-1-npiggin@gmail.com>
 <20231124064001.198572-3-npiggin@gmail.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20231124064001.198572-3-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=ZyQH=HF=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

On 11/24/23 07:39, Nicholas Piggin wrote:
> The timebase in ppc started out with the mftb instruction which is like
> mfspr but addressed timebase registers (TBRs) rather than SPRs. These
> instructions could be used to read TB and TBU at 268 and 269. Timebase
> could be written via the TBL and TBU SPRs at 284 and 285.
> 
> The ISA changed around v2.03 to bring TB and TBU reads into the SPR
> space at 268 and 269 (access via mftb TBR-space is still supported
> but will be phased out). Later, VTB was added which is an entirely
> different register.
> 
> The SPR number defines in QEMU are understandably inconsistently named.
> Change SPR 268, 269, 284, 285 to TBL, TBU, WR_TBL, WR_TBU, respectively.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>


Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


> ---
>   target/ppc/cpu.h         |  8 ++++----
>   target/ppc/helper_regs.c | 10 +++++-----
>   2 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index f8101ffa29..848e583c2d 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1750,8 +1750,8 @@ void ppc_compat_add_property(Object *obj, const char *name,
>   #define SPR_USPRG5            (0x105)
>   #define SPR_USPRG6            (0x106)
>   #define SPR_USPRG7            (0x107)
> -#define SPR_VTBL              (0x10C)
> -#define SPR_VTBU              (0x10D)
> +#define SPR_TBL               (0x10C)
> +#define SPR_TBU               (0x10D)
>   #define SPR_SPRG0             (0x110)
>   #define SPR_SPRG1             (0x111)
>   #define SPR_SPRG2             (0x112)
> @@ -1764,8 +1764,8 @@ void ppc_compat_add_property(Object *obj, const char *name,
>   #define SPR_SPRG7             (0x117)
>   #define SPR_ASR               (0x118)
>   #define SPR_EAR               (0x11A)
> -#define SPR_TBL               (0x11C)
> -#define SPR_TBU               (0x11D)
> +#define SPR_WR_TBL            (0x11C)
> +#define SPR_WR_TBU            (0x11D)
>   #define SPR_TBU40             (0x11E)
>   #define SPR_SVR               (0x11E)
>   #define SPR_BOOKE_PIR         (0x11E)
> diff --git a/target/ppc/helper_regs.c b/target/ppc/helper_regs.c
> index 8c00ed8c06..6f190ab13b 100644
> --- a/target/ppc/helper_regs.c
> +++ b/target/ppc/helper_regs.c
> @@ -461,22 +461,22 @@ void register_generic_sprs(PowerPCCPU *cpu)
>   
>       /* Time base */
>   #if defined(TARGET_PPC64)
> -    spr_register(env, SPR_VTBL,  "TB",
> +    spr_register(env, SPR_TBL, "TB",
>   #else
> -    spr_register(env, SPR_VTBL,  "TBL",
> +    spr_register(env, SPR_TBL, "TBL",
>   #endif
>                    &spr_read_tbl, SPR_NOACCESS,
>                    &spr_read_tbl, SPR_NOACCESS,
>                    0x00000000);
> -    spr_register(env, SPR_TBL,   "TBL",
> +    spr_register(env, SPR_WR_TBL, "TBL",
>                    &spr_read_tbl, SPR_NOACCESS,
>                    &spr_read_tbl, &spr_write_tbl,
>                    0x00000000);
> -    spr_register(env, SPR_VTBU,  "TBU",
> +    spr_register(env, SPR_TBU, "TBU",
>                    &spr_read_tbu, SPR_NOACCESS,
>                    &spr_read_tbu, SPR_NOACCESS,
>                    0x00000000);
> -    spr_register(env, SPR_TBU,   "TBU",
> +    spr_register(env, SPR_WR_TBU, "TBU",
>                    &spr_read_tbu, SPR_NOACCESS,
>                    &spr_read_tbu, &spr_write_tbu,
>                    0x00000000);


