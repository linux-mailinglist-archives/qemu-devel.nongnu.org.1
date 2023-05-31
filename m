Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E622B71773F
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 08:54:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4FjF-0005gw-4Z; Wed, 31 May 2023 02:54:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=vahk=BU=kaod.org=clg@ozlabs.org>)
 id 1q4Fhl-0004sL-4T; Wed, 31 May 2023 02:53:09 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=vahk=BU=kaod.org=clg@ozlabs.org>)
 id 1q4Fhi-0006pB-Kc; Wed, 31 May 2023 02:53:08 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QWKhp0s6Sz4x2k;
 Wed, 31 May 2023 16:52:58 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QWKhm1DPbz4x42;
 Wed, 31 May 2023 16:52:55 +1000 (AEST)
Message-ID: <2968749b-2114-2890-11f8-6608671efa52@kaod.org>
Date: Wed, 31 May 2023 08:52:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1] target/ppc: Support directed privileged doorbell
 interrupt (SDOOR)
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>
References: <20230530130526.372701-1-npiggin@gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230530130526.372701-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=vahk=BU=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.09,
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

On 5/30/23 15:05, Nicholas Piggin wrote:
> BookS msgsndp instruction to self or DPDES register can cause SDOOR
> interrupts which crash QEMU with exception not implemented.
> 
> Linux does not use msgsndp in SMT1, and KVM only uses DPDES to cause
> doorbells when emulating a SMT guest (which is not the default), so
> this has gone unnoticed.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Reviewed-by: Cédric Le Goater <clg@kaod.org>


> ---
> Another stable candidate.

Cc: qemu-stable@nongnu.org

Thanks,

C.

> 
>   target/ppc/excp_helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index fea9221501..add2bc6bfe 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -1539,6 +1539,7 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
>       case POWERPC_EXCP_DSEG:      /* Data segment exception                   */
>       case POWERPC_EXCP_ISEG:      /* Instruction segment exception            */
>       case POWERPC_EXCP_TRACE:     /* Trace exception                          */
> +    case POWERPC_EXCP_SDOOR:     /* Doorbell interrupt                       */
>           break;
>       case POWERPC_EXCP_HISI:      /* Hypervisor instruction storage exception */
>           msr |= env->error_code;
> @@ -1584,7 +1585,6 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
>       case POWERPC_EXCP_PERFM:     /* Embedded performance monitor interrupt   */
>       case POWERPC_EXCP_VPUA:      /* Vector assist exception                  */
>       case POWERPC_EXCP_MAINT:     /* Maintenance exception                    */
> -    case POWERPC_EXCP_SDOOR:     /* Doorbell interrupt                       */
>       case POWERPC_EXCP_HV_MAINT:  /* Hypervisor Maintenance exception         */
>           cpu_abort(cs, "%s exception not implemented\n",
>                     powerpc_excp_name(excp));


