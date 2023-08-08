Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CEC1774723
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 21:10:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTS4W-0003R7-2d; Tue, 08 Aug 2023 15:08:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTS4U-0003Kb-1g
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 15:08:46 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTS4S-000849-FN
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 15:08:45 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1bc0d39b52cso39706275ad.2
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 12:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691521722; x=1692126522;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=M/sGQ0RUDQCfdnMPcet5krpMk9uhab+dAgTBn3QBlVA=;
 b=GCRmkxoWQHu/4N/CkDLKVRtgznrc+QW7bS9DRLnP6+RgVUkLjC1t6h6hGQF9VEVxG4
 9a0AWSa/2OXwtVwxo/33K9UP2lyVeUBz8RupiwePNZEBgx1ECrrsJvsBP6FsA+EA4yCN
 KRoO+FIkBNp8/3ro69zzqU6S5HXWcQFFKocjXJokMDgD/0ZDwY8Q6jwn+i8MnfCT8JW+
 VhZ+hkps3FAPKtd3wtG0wnvvkT29iWOXiGik0u+pVPdv8QDzgrj0GSQ3uXh7bw/+wA+g
 ToTZE2aZr6Ctjyrr8ZAOlTECRVrPVhqHi9LnSUvZxvCJxaOSPvD3e3qSiTP63RvIIO6c
 Np2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691521722; x=1692126522;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M/sGQ0RUDQCfdnMPcet5krpMk9uhab+dAgTBn3QBlVA=;
 b=S3i5NcfdDLifHtSTpuAGvNIi3gwh4F0QbgElo4M1tABLfQiCgih81zCELXujdze1ah
 BTFSX6N4WT/kd8bLaOiSpwNglsUZsnEMxrWv2ObT+E+Sd5g6hJR50eBDGZ4/hHbrS0Zs
 uIf7fqBoqn1I/AfOga8Ouw9fW9U61TKokZBOPSGZ8Gat6wRDKXt7P4RJCwLoR4f77oj+
 pt+/a1Fhfu5OIBi4LMxysBYksSj6lxl9zxLFTg9kGKAV3hQElPdtm//xE68Bd/s4Fp/j
 8yvygehEgDQ8vtP62VYLfCMvHhZq8CvBGDhHal0+0/Q75k8Yg3WZU5ZR+iCRvjDuLnPw
 itKQ==
X-Gm-Message-State: AOJu0YxDqaI4XpNOIlJuY9IdViznXoNFWDsSyF4zodMYJh1pBisQJaV0
 M1q7vW9xksA4ioMO+LmrFqTkcQ==
X-Google-Smtp-Source: AGHT+IF7u/iKJuFRvEXSo9QG/AO+FtE+uZMAklSoAuBqNlJos1R+IOzdunLpXj/LecYm5GcuKbx18g==
X-Received: by 2002:a17:902:e551:b0:1bb:d7d4:e0d with SMTP id
 n17-20020a170902e55100b001bbd7d40e0dmr531273plf.64.1691521722467; 
 Tue, 08 Aug 2023 12:08:42 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:63dc:2a47:f4bc:4a95?
 ([2602:47:d490:6901:63dc:2a47:f4bc:4a95])
 by smtp.gmail.com with ESMTPSA id
 h4-20020a170902f7c400b001b8a3a0c928sm9418351plw.181.2023.08.08.12.08.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Aug 2023 12:08:41 -0700 (PDT)
Message-ID: <816e14d5-dded-3c97-72e3-16c500485d15@linaro.org>
Date: Tue, 8 Aug 2023 12:08:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 09/11] target/loongarch: Truncate high 32 bits of
 address in VA32 mode
Content-Language: en-US
To: Jiajie Chen <c@jia.je>, qemu-devel@nongnu.org
Cc: yijun@loongson.cn, shenjinyang@loongson.cn, gaosong@loongson.cn,
 i.qemu@xen0n.name
References: <20230808015506.1705140-1-c@jia.je>
 <20230808015506.1705140-10-c@jia.je>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230808015506.1705140-10-c@jia.je>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.14,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/7/23 18:54, Jiajie Chen wrote:
> When running in VA32 mode(LA32 or VA32L[1-3] matching PLV), virtual
> address is truncated to 32 bits before address mapping.
> 
> Signed-off-by: Jiajie Chen <c@jia.je>
> ---
>   target/loongarch/cpu.h                          |  6 +++++-
>   target/loongarch/insn_trans/trans_atomic.c.inc  |  1 +
>   target/loongarch/insn_trans/trans_fmemory.c.inc |  8 ++++++++
>   target/loongarch/insn_trans/trans_lsx.c.inc     |  6 ++++++
>   target/loongarch/insn_trans/trans_memory.c.inc  | 10 ++++++++++
>   target/loongarch/translate.c                    | 10 ++++++++++
>   6 files changed, 40 insertions(+), 1 deletion(-)
> 
> diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
> index 69589f0aef..9ad5fcc494 100644
> --- a/target/loongarch/cpu.h
> +++ b/target/loongarch/cpu.h
> @@ -457,7 +457,11 @@ static inline void cpu_get_tb_cpu_state(CPULoongArchState *env, vaddr *pc,
>           va32 = 1;
>       }
>   
> -    *pc = env->pc;
> +    if (va32) {
> +        *pc = (uint32_t)env->pc;
> +    } else {
> +        *pc = env->pc;
> +    }

This is not wrong, but it might be better to zero-extend when assigning to env->pc.  There 
are other consumers of env->pc, and we are not updating all of them.

> --- a/target/loongarch/insn_trans/trans_memory.c.inc
> +++ b/target/loongarch/insn_trans/trans_memory.c.inc
> @@ -13,6 +13,7 @@ static bool gen_load(DisasContext *ctx, arg_rr_i *a, MemOp mop)
>           tcg_gen_addi_tl(temp, addr, a->imm);
>           addr = temp;
>       }
> +    addr = va32_address(ctx, addr);

I did say that you should use a common helper and a single temp.
This is using two temps: one here and one in va32_address.

I suggest:

static TCGv make_address_x(DisasContext *ctx, TCGv base, TCGv addend)
{
     TCGv temp = NULL;

     if (addend || ctx->va32) {
         temp = tcg_temp_new();
     }
     if (addend) {
         tcg_gen_add_tl(temp, base, addend);
         base = temp;
     }
     if (ctx->va32) {
         tcg_gen_ext32u_tl(temp, base);
         base = temp;
     }
     return base;
}

static TCGv make_address_i(DisasContext *ctx, TCGv base, target_long ofs)
{
     TCGv addend = ofs ? tcg_constant_tl(ofs) : NULL;
     return make_address_x(ctx, base, addend);
}


So that gen_load uses

     addr = make_address_i(ctx, addr, a->imm);

and gen_loadx uses

     addr = make_address_x(ctx, src1, src2);

and gen_am uses

     addr = make_address_i(ctx, addr, 0);

and so on for all of the others.


r~

