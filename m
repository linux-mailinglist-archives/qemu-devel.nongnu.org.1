Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 464077F6CA8
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 08:13:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6QMS-0005E6-Dz; Fri, 24 Nov 2023 02:12:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=ZyQH=HF=kaod.org=clg@ozlabs.org>)
 id 1r6QMM-0005As-AK; Fri, 24 Nov 2023 02:12:18 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=ZyQH=HF=kaod.org=clg@ozlabs.org>)
 id 1r6QMK-0008HI-O3; Fri, 24 Nov 2023 02:12:18 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Sc5lL2G7zz4wbn;
 Fri, 24 Nov 2023 18:12:14 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Sc5lJ4QzNz4wd7;
 Fri, 24 Nov 2023 18:12:12 +1100 (AEDT)
Message-ID: <90cb310d-b5c4-47db-891e-3777b793c532@kaod.org>
Date: Fri, 24 Nov 2023 08:12:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] target/ppc: Fix move-to timebase SPR access
 permissions
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 qemu-devel@nongnu.org
References: <20231124064001.198572-1-npiggin@gmail.com>
 <20231124064001.198572-4-npiggin@gmail.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20231124064001.198572-4-npiggin@gmail.com>
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
> The move-to timebase registers TBU and TBL can not be read, and they
> can not be written in supervisor mode on hypervisor-capable CPUs.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>


Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


> ---
>   target/ppc/helper_regs.c | 31 +++++++++++++++++++++++--------
>   1 file changed, 23 insertions(+), 8 deletions(-)
> 
> diff --git a/target/ppc/helper_regs.c b/target/ppc/helper_regs.c
> index 6f190ab13b..f1493ddca0 100644
> --- a/target/ppc/helper_regs.c
> +++ b/target/ppc/helper_regs.c
> @@ -468,18 +468,33 @@ void register_generic_sprs(PowerPCCPU *cpu)
>                    &spr_read_tbl, SPR_NOACCESS,
>                    &spr_read_tbl, SPR_NOACCESS,
>                    0x00000000);
> -    spr_register(env, SPR_WR_TBL, "TBL",
> -                 &spr_read_tbl, SPR_NOACCESS,
> -                 &spr_read_tbl, &spr_write_tbl,
> -                 0x00000000);
>       spr_register(env, SPR_TBU, "TBU",
>                    &spr_read_tbu, SPR_NOACCESS,
>                    &spr_read_tbu, SPR_NOACCESS,
>                    0x00000000);
> -    spr_register(env, SPR_WR_TBU, "TBU",
> -                 &spr_read_tbu, SPR_NOACCESS,
> -                 &spr_read_tbu, &spr_write_tbu,
> -                 0x00000000);
> +#ifndef CONFIG_USER_ONLY
> +    if (env->has_hv_mode) {
> +        spr_register_hv(env, SPR_WR_TBL, "TBL",
> +                        SPR_NOACCESS, SPR_NOACCESS,
> +                        SPR_NOACCESS, SPR_NOACCESS,
> +                        SPR_NOACCESS, &spr_write_tbl,
> +                        0x00000000);
> +        spr_register_hv(env, SPR_WR_TBU, "TBU",
> +                        SPR_NOACCESS, SPR_NOACCESS,
> +                        SPR_NOACCESS, SPR_NOACCESS,
> +                        SPR_NOACCESS, &spr_write_tbu,
> +                        0x00000000);
> +    } else {
> +        spr_register(env, SPR_WR_TBL, "TBL",
> +                     SPR_NOACCESS, SPR_NOACCESS,
> +                     SPR_NOACCESS, &spr_write_tbl,
> +                     0x00000000);
> +        spr_register(env, SPR_WR_TBU, "TBU",
> +                     SPR_NOACCESS, SPR_NOACCESS,
> +                     SPR_NOACCESS, &spr_write_tbu,
> +                     0x00000000);
> +    }
> +#endif
>   }
>   
>   void register_non_embedded_sprs(CPUPPCState *env)


