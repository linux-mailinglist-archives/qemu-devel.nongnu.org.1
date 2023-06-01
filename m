Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE0B7195D0
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 10:41:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4dq8-0002cC-Pk; Thu, 01 Jun 2023 04:39:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=vOrz=BV=kaod.org=clg@ozlabs.org>)
 id 1q4dq6-0002bp-T7; Thu, 01 Jun 2023 04:39:22 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=vOrz=BV=kaod.org=clg@ozlabs.org>)
 id 1q4dq4-00041e-RD; Thu, 01 Jun 2023 04:39:22 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QX00z1Z5fz4x4G;
 Thu,  1 Jun 2023 18:39:15 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QX00x22X7z4x3g;
 Thu,  1 Jun 2023 18:39:12 +1000 (AEST)
Message-ID: <30457ad7-0244-7ef5-2876-6245b03df28d@kaod.org>
Date: Thu, 1 Jun 2023 10:39:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/7] target/ppc: Remove single use function
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Daniel Henrique Barboza <danielhb413@gmail.com>
References: <cover.1685448535.git.balaton@eik.bme.hu>
 <302697d63d26caebefaeee1e45352145ebd0318a.1685448535.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <302697d63d26caebefaeee1e45352145ebd0318a.1685448535.git.balaton@eik.bme.hu>
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
> The get_physical_address() function is a trivial wrapper of
> get_physical_address_wtlb() that is only used once. Remove it and call
> get_physical_address_wtlb() directly instead.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


> ---
>   target/ppc/mmu_helper.c | 11 +----------
>   1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
> index 64e30435f5..c0c71a68ff 100644
> --- a/target/ppc/mmu_helper.c
> +++ b/target/ppc/mmu_helper.c
> @@ -168,15 +168,6 @@ static void booke206_flush_tlb(CPUPPCState *env, int flags,
>       tlb_flush(env_cpu(env));
>   }
>   
> -static int get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
> -                                target_ulong eaddr, MMUAccessType access_type,
> -                                int type)
> -{
> -    return get_physical_address_wtlb(env, ctx, eaddr, access_type, type, 0);
> -}
> -
> -
> -
>   /*****************************************************************************/
>   /* BATs management */
>   #if !defined(FLUSH_ALL_TLBS)
> @@ -643,7 +634,7 @@ target_ulong helper_rac(CPUPPCState *env, target_ulong addr)
>        */
>       nb_BATs = env->nb_BATs;
>       env->nb_BATs = 0;
> -    if (get_physical_address(env, &ctx, addr, 0, ACCESS_INT) == 0) {
> +    if (get_physical_address_wtlb(env, &ctx, addr, 0, ACCESS_INT, 0) == 0) {
>           ret = ctx.raddr;
>       }
>       env->nb_BATs = nb_BATs;


