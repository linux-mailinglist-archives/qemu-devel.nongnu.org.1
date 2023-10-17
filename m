Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E57E97CC563
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 15:59:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qskbR-0007ln-CU; Tue, 17 Oct 2023 09:59:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qskbO-0007dJ-Rk
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 09:59:18 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qskbN-0007hb-5k
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 09:59:18 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-68fb85afef4so4581616b3a.1
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 06:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697551155; x=1698155955; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rY95sNDrK5KHGda3VYHekc/+o8a/W5i3CBLg2DO7qxI=;
 b=tkzglJBQi7tZukV68+qeVwUpulpavpCwrPUv01WJ8lRHDsYzYzcyS9+cl63/J/Hp/d
 dNKmY9i57VIUceOFKMJN+IRvqyhRwrh6ylMILdCH6Z90YCdqxlfn6ndr4m6gLrPtyJ9y
 ABDsfxj+iZBBfgij7QOVUegtSRMbvdW2iXtNAIW/mAhowqV+YkJe+CnkuZRiWN6fc2WY
 lHTa9nAsiQi1DXvNh+0Sql6UMAt6ONl0tDLrLdZNrbpLE99mUeF6vM0pnZGXgzST7MaB
 LNhZjgpxKp/D5OSOBLs7MIFKd0uCl4nR8OLyUm3sgsXrnM3+WutBEVGkWn+bh8pq/v82
 9pJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697551155; x=1698155955;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rY95sNDrK5KHGda3VYHekc/+o8a/W5i3CBLg2DO7qxI=;
 b=UklThxYtfXbu3sehVEQGhPQZHySwDJw9ng4ZoJGeuX11ZKscmSLCtACJDRe6wlMXyi
 2Uk3vCC7t1kMWWImAkg0AmXMCZmqrzwFOjMY76bPr5TsYXRfyUPjhCnjQOEhuT8kcyXw
 234o40qe0xiBr/wphp9a8GYZINvDTM+bf2f8qmb3J0usyrufMAB4H48hJBAPjOOHCbTL
 cQ3NI3+Z/OQKJPbGcSuMO62KDIbsh+wu30dpLUr3OQiQeqhAuf+VniM+hv3jhDnA24Ll
 GdxoNfx7TdPNnA1OfI4hD9+n9bYL+AF9b3Fp6dZwjZwDjCOweQG86lWhQGe4wGUxp4wn
 VN2Q==
X-Gm-Message-State: AOJu0YxXmtW7mFnYYN9oRO/SDWrqplTRM63yIWr75XGKrCVz5y5o6HUa
 +LTh/JZMR01OMn+5ULB5DT2IuA==
X-Google-Smtp-Source: AGHT+IHgcptoosYKAUGb+mm0D7hSRyhAOyEWFJjA1cyoOchjeTEM/K/DFUfVikzdSXmMoH9VYKsa8g==
X-Received: by 2002:a05:6a20:8f12:b0:125:517c:4f18 with SMTP id
 b18-20020a056a208f1200b00125517c4f18mr2345404pzk.8.1697551154708; 
 Tue, 17 Oct 2023 06:59:14 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 gj16-20020a17090b109000b00263b9e75aecsm1339174pjb.41.2023.10.17.06.59.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Oct 2023 06:59:14 -0700 (PDT)
Message-ID: <5e75813a-3084-454c-9c72-31773e0e0d77@linaro.org>
Date: Tue, 17 Oct 2023 06:59:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] target/loongarch: Use i128 for 128-bit load/store
 in XVLD
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>
References: <20231017123849.40834-1-philmd@linaro.org>
 <20231017123849.40834-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231017123849.40834-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/17/23 05:38, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/loongarch/translate.c                |  6 ++++++
>   target/loongarch/insn_trans/trans_vec.c.inc | 16 +++++++---------
>   2 files changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/target/loongarch/translate.c b/target/loongarch/translate.c
> index c6edfc800f..89e35770b7 100644
> --- a/target/loongarch/translate.c
> +++ b/target/loongarch/translate.c
> @@ -67,6 +67,12 @@ static inline void get_vreg128(TCGv_i128 dest, int regno, int index)
>                       offsetof(CPULoongArchState, fpr[regno].vreg.Q(index)));
>   }
>   
> +static inline void set_vreg128(TCGv_i128 src, int regno, int index)
> +{
> +    tcg_gen_st_i128(src, tcg_env,
> +                    offsetof(CPULoongArchState, fpr[regno].vreg.Q(index)));
> +}
> +
>   static inline int plus_1(DisasContext *ctx, int x)
>   {
>       return x + 1;
> diff --git a/target/loongarch/insn_trans/trans_vec.c.inc b/target/loongarch/insn_trans/trans_vec.c.inc
> index dd41f5e48e..c8b7bfa67f 100644
> --- a/target/loongarch/insn_trans/trans_vec.c.inc
> +++ b/target/loongarch/insn_trans/trans_vec.c.inc
> @@ -5458,18 +5458,16 @@ static bool gen_lasx_memory(DisasContext *ctx, arg_vr_i *a,
>   
>   static void gen_xvld(DisasContext *ctx, int vreg, TCGv addr)
>   {
> -    int i;
> +    MemOp mop = MO_128 | MO_TE;
>       TCGv temp = tcg_temp_new();
> -    TCGv dest = tcg_temp_new();
> +    TCGv_i128 dest = tcg_temp_new_i128();
>   
> -    tcg_gen_qemu_ld_i64(dest, addr, ctx->mem_idx, MO_TEUQ);
> -    set_vreg64(dest, vreg, 0);
> +    tcg_gen_qemu_ld_i128(dest, addr, ctx->mem_idx, mop);
> +    set_vreg128(dest, vreg, 0);
>   
> -    for (i = 1; i < 4; i++) {
> -        tcg_gen_addi_tl(temp, addr, 8 * i);
> -        tcg_gen_qemu_ld_i64(dest, temp, ctx->mem_idx, MO_TEUQ);
> -        set_vreg64(dest, vreg, i);
> -    }
> +    tcg_gen_addi_tl(temp, addr, 16);
> +    tcg_gen_qemu_ld_i128(dest, temp, ctx->mem_idx, mop);
> +    set_vreg128(dest, vreg, 1);
>   }
>   
>   static void gen_xvst(DisasContext * ctx, int vreg, TCGv addr)

Missing the matching change to trans_vld.


r~

