Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F897195D1
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 10:41:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4dqZ-0003Ll-K1; Thu, 01 Jun 2023 04:39:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=vOrz=BV=kaod.org=clg@ozlabs.org>)
 id 1q4dqX-0003C6-H8; Thu, 01 Jun 2023 04:39:49 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=vOrz=BV=kaod.org=clg@ozlabs.org>)
 id 1q4dqV-00044B-St; Thu, 01 Jun 2023 04:39:49 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QX01Y4F74z4x4V;
 Thu,  1 Jun 2023 18:39:45 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QX01W47VGz4x4T;
 Thu,  1 Jun 2023 18:39:43 +1000 (AEST)
Message-ID: <aa487bd7-d558-1762-323f-c5df60942392@kaod.org>
Date: Thu, 1 Jun 2023 10:39:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 5/7] target/ppc: Simplify ppcemb_tlb_search()
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Daniel Henrique Barboza <danielhb413@gmail.com>
References: <cover.1685448535.git.balaton@eik.bme.hu>
 <d470118c3adcbd41b1a91779f6bb7cbdb2b0d346.1685448535.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <d470118c3adcbd41b1a91779f6bb7cbdb2b0d346.1685448535.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=vOrz=BV=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.091,
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

On 5/30/23 15:28, BALATON Zoltan wrote:
> No nead to store return value and break from loop when we can return
> directly.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>


Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.

> ---
>   target/ppc/mmu_common.c | 10 +++-------
>   1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index a84bc7de88..ff7f987546 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -521,19 +521,15 @@ int ppcemb_tlb_search(CPUPPCState *env, target_ulong address, uint32_t pid)
>   {
>       ppcemb_tlb_t *tlb;
>       hwaddr raddr;
> -    int i, ret;
> +    int i;
>   
> -    /* Default return value is no match */
> -    ret = -1;
>       for (i = 0; i < env->nb_tlb; i++) {
>           tlb = &env->tlb.tlbe[i];
>           if (ppcemb_tlb_check(env, tlb, &raddr, address, pid, i) == 0) {
> -            ret = i;
> -            break;
> +            return i;
>           }
>       }
> -
> -    return ret;
> +    return -1;
>   }
>   
>   static int mmu40x_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,


