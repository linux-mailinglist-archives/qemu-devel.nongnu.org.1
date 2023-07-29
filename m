Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AAA767C4A
	for <lists+qemu-devel@lfdr.de>; Sat, 29 Jul 2023 07:16:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPbsp-0005sx-33; Sat, 29 Jul 2023 00:48:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=69fR=DP=kaod.org=clg@ozlabs.org>)
 id 1qPbsm-0005sk-4g; Sat, 29 Jul 2023 00:48:48 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=69fR=DP=kaod.org=clg@ozlabs.org>)
 id 1qPbsk-0006vz-7T; Sat, 29 Jul 2023 00:48:47 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4RCX826P6rz4wy6;
 Sat, 29 Jul 2023 14:48:34 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4RCX805VMpz4wxR;
 Sat, 29 Jul 2023 14:48:32 +1000 (AEST)
Message-ID: <26613c0a-6c5d-7a90-b6b2-db97e8a6e059@kaod.org>
Date: Sat, 29 Jul 2023 06:48:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] target/ppc: Disable goto_tb with architectural singlestep
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, groug@kaod.org,
 david@gibson.dropbear.id.au
References: <20230728173520.486025-1-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230728173520.486025-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=69fR=DP=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.094,
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

On 7/28/23 19:35, Richard Henderson wrote:
> The change to use translator_use_goto_tb went too far, as the
> CF_SINGLE_STEP flag managed by the translator only handles
> gdb single stepping and not the architectural single stepping
> modeled in DisasContext.singlestep_enabled.
> 
> Fixes: 6e9cc373ec5 ("target/ppc: Use translator_use_goto_tb")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1795
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>


Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


> ---
>   target/ppc/translate.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index e6a0709066..74796ec7ba 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -4175,6 +4175,9 @@ static void pmu_count_insns(DisasContext *ctx)
>   
>   static inline bool use_goto_tb(DisasContext *ctx, target_ulong dest)
>   {
> +    if (unlikely(ctx->singlestep_enabled)) {
> +        return false;
> +    }
>       return translator_use_goto_tb(&ctx->base, dest);
>   }
>   


