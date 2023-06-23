Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 642B273B385
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 11:28:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCd4A-0002RB-QC; Fri, 23 Jun 2023 05:26:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Kxto=CL=kaod.org=clg@ozlabs.org>)
 id 1qCd47-0002Qf-FU; Fri, 23 Jun 2023 05:26:51 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Kxto=CL=kaod.org=clg@ozlabs.org>)
 id 1qCd44-0004ub-7G; Fri, 23 Jun 2023 05:26:50 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QnX1Z1RN2z4x1f;
 Fri, 23 Jun 2023 19:26:42 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QnX1X5sB0z4wjB;
 Fri, 23 Jun 2023 19:26:40 +1000 (AEST)
Message-ID: <3d5f364a-4b6d-be94-4e74-a0bb32b137ed@kaod.org>
Date: Fri, 23 Jun 2023 11:26:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC PATCH 1/5] target/ppc: gdbstub init spr gdb_id for all CPUs
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>
References: <20230531012313.19891-1-npiggin@gmail.com>
 <20230531012313.19891-2-npiggin@gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230531012313.19891-2-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=Kxto=CL=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_MED=-2.3,
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

On 5/31/23 03:23, Nicholas Piggin wrote:
> Make sure each CPU gets its state set up for gdb, not just the ones
> before PowerPCCPUClass has had its gdb state set up.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to ppc-next.

Thanks,

C.



> ---
>   target/ppc/gdbstub.c | 30 +++++++++++++++++++-----------
>   1 file changed, 19 insertions(+), 11 deletions(-)
> 
> diff --git a/target/ppc/gdbstub.c b/target/ppc/gdbstub.c
> index 63c9abe4f1..ca39efdc35 100644
> --- a/target/ppc/gdbstub.c
> +++ b/target/ppc/gdbstub.c
> @@ -327,6 +327,25 @@ void ppc_gdb_gen_spr_xml(PowerPCCPU *cpu)
>       unsigned int num_regs = 0;
>       int i;
>   
> +    for (i = 0; i < ARRAY_SIZE(env->spr_cb); i++) {
> +        ppc_spr_t *spr = &env->spr_cb[i];
> +
> +        if (!spr->name) {
> +            continue;
> +        }
> +
> +        /*
> +         * GDB identifies registers based on the order they are
> +         * presented in the XML. These ids will not match QEMU's
> +         * representation (which follows the PowerISA).
> +         *
> +         * Store the position of the current register description so
> +         * we can make the correspondence later.
> +         */
> +        spr->gdb_id = num_regs;
> +        num_regs++;
> +    }
> +
>       if (pcc->gdb_spr_xml) {
>           return;
>       }
> @@ -348,17 +367,6 @@ void ppc_gdb_gen_spr_xml(PowerPCCPU *cpu)
>   
>           g_string_append_printf(xml, " bitsize=\"%d\"", TARGET_LONG_BITS);
>           g_string_append(xml, " group=\"spr\"/>");
> -
> -        /*
> -         * GDB identifies registers based on the order they are
> -         * presented in the XML. These ids will not match QEMU's
> -         * representation (which follows the PowerISA).
> -         *
> -         * Store the position of the current register description so
> -         * we can make the correspondence later.
> -         */
> -        spr->gdb_id = num_regs;
> -        num_regs++;
>       }
>   
>       g_string_append(xml, "</feature>");


