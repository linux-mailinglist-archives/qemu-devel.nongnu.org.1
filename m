Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE67072535F
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 07:33:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6lm7-0000dD-Dy; Wed, 07 Jun 2023 01:32:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=5JAy=B3=kaod.org=clg@ozlabs.org>)
 id 1q6lm4-0000cc-9S; Wed, 07 Jun 2023 01:32:01 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=5JAy=B3=kaod.org=clg@ozlabs.org>)
 id 1q6lm2-0004Bl-Fw; Wed, 07 Jun 2023 01:32:00 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QbbZ03n8hz4x42;
 Wed,  7 Jun 2023 15:31:52 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QbbYy5zx4z4x3k;
 Wed,  7 Jun 2023 15:31:50 +1000 (AEST)
Message-ID: <429ff1f9-a25f-6f5e-b18b-810185313168@kaod.org>
Date: Wed, 7 Jun 2023 07:31:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/4] target/ppc: Add support for SMT CTRL register
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>
References: <20230605112323.179259-1-npiggin@gmail.com>
 <20230605112323.179259-3-npiggin@gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230605112323.179259-3-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=5JAy=B3=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.094, SPF_HELO_PASS=-0.001,
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

Hello Nick,


> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -443,7 +443,7 @@ void spr_write_generic32(DisasContext *ctx, int sprn, int gprn)
>   #endif
>   }
>   
> -void spr_write_CTRL(DisasContext *ctx, int sprn, int gprn)
> +static void spr_write_CTRL_ST(DisasContext *ctx, int sprn, int gprn)
>   {
>       /* This does not implement >1 thread */
>       TCGv t0 = tcg_temp_new();
> @@ -452,6 +452,22 @@ void spr_write_CTRL(DisasContext *ctx, int sprn, int gprn)
>       tcg_gen_shli_tl(t1, t0, 8); /* Duplicate the bit in TS */
>       tcg_gen_or_tl(t1, t1, t0);
>       gen_store_spr(sprn, t1);

The hunk above doesn't apply cleanly. Am I missing some patch you would
have sent previously ?

Thanks,

C.



> +}
> +
> +void spr_write_CTRL(DisasContext *ctx, int sprn, int gprn)
> +{
> +    if (!(ctx->flags & POWERPC_FLAG_SMT)) {
> +        spr_write_CTRL_ST(ctx, sprn, gprn);
> +        goto out;
> +    }
> +
> +    if (!gen_serialize(ctx)) {
> +        return;
> +    }
> +
> +    gen_helper_spr_write_CTRL(cpu_env, tcg_constant_i32(sprn),
> +                              cpu_gpr[gprn]);
> +out:
>       spr_store_dump_spr(sprn);
>   
>       /*


