Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF167F6CA7
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 08:13:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6QMN-0005BJ-Cp; Fri, 24 Nov 2023 02:12:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=ZyQH=HF=kaod.org=clg@ozlabs.org>)
 id 1r6QML-0005A5-1M; Fri, 24 Nov 2023 02:12:17 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=ZyQH=HF=kaod.org=clg@ozlabs.org>)
 id 1r6QMJ-0008GO-8o; Fri, 24 Nov 2023 02:12:16 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Sc5l84LLkz4wdC;
 Fri, 24 Nov 2023 18:12:04 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Sc5l65T8wz4wd7;
 Fri, 24 Nov 2023 18:12:02 +1100 (AEDT)
Message-ID: <068eb9ca-876f-4688-b677-e4a75d0c5f08@kaod.org>
Date: Fri, 24 Nov 2023 08:11:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] target/ppc: Rename TBL to TB on 64-bit
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 qemu-devel@nongnu.org
References: <20231124064001.198572-1-npiggin@gmail.com>
 <20231124064001.198572-2-npiggin@gmail.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20231124064001.198572-2-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=ZyQH=HF=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

On 11/24/23 07:39, Nicholas Piggin wrote:
>  From the earliest PowerPC ISA, TBR (later SPR) 268 has been called TB
> and accessed with mftb instruction. The problem is that TB is the name
> of the 64-bit register, and 32-bit implementations can only read the
> lower half with one instruction, so 268 has also been called TBL and
> it does only read TBL on 32-bit.
> 
> Change SPR 268 to be called TB on 64-bit implementations.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   target/ppc/helper_regs.c  | 4 ++++
>   target/ppc/ppc-qmp-cmds.c | 4 ++++
>   2 files changed, 8 insertions(+)
> 
> diff --git a/target/ppc/helper_regs.c b/target/ppc/helper_regs.c
> index f380342d4d..8c00ed8c06 100644
> --- a/target/ppc/helper_regs.c
> +++ b/target/ppc/helper_regs.c
> @@ -460,7 +460,11 @@ void register_generic_sprs(PowerPCCPU *cpu)
>       }
>   
>       /* Time base */
> +#if defined(TARGET_PPC64)
> +    spr_register(env, SPR_VTBL,  "TB",
> +#else
>       spr_register(env, SPR_VTBL,  "TBL",
> +#endif
>                    &spr_read_tbl, SPR_NOACCESS,
>                    &spr_read_tbl, SPR_NOACCESS,
>                    0x00000000);
> diff --git a/target/ppc/ppc-qmp-cmds.c b/target/ppc/ppc-qmp-cmds.c
> index f9acc21056..ffaff59e78 100644
> --- a/target/ppc/ppc-qmp-cmds.c
> +++ b/target/ppc/ppc-qmp-cmds.c
> @@ -103,7 +103,11 @@ const MonitorDef monitor_defs[] = {
>       { "xer", 0, &monitor_get_xer },
>       { "msr", offsetof(CPUPPCState, msr) },
>       { "tbu", 0, &monitor_get_tbu, },
> +#if defined(TARGET_PPC64)
> +    { "tb", 0, &monitor_get_tbl, },
> +#else
>       { "tbl", 0, &monitor_get_tbl, },
> +#endif
>       { NULL },
>   };
>   


