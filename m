Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 553FF79AC7F
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 01:23:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfqDy-0006lE-Nz; Mon, 11 Sep 2023 19:21:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qfqDx-0006k7-6y
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 19:21:45 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qfqDu-0008I6-JW
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 19:21:44 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1bd9b4f8e0eso33410525ad.1
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 16:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694474498; x=1695079298; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EddYxVyHWpU4rxMgzKrErg1ihVsh8H+yZp+TnRm/heE=;
 b=JGilge15QjKK49qd8te1lvk6ENQyD9ACNzcIrO+iGaXAY2LIEWJsYy2+z5p0/xPYDZ
 NgZKZ6PLg35n0ZqAailUVKfkg+TxZEZss8atVkxH/S3k7L+G/Yvw7blniqyDJwpyZ0lC
 zoaJ2KLDHo20ZGqzQbTy+txkAhVcqSoxupes4t6Larz+npcEPtZyfEnQ0LTg/4vCYPnL
 N85MhdKUV2+8iTz5e916Fsr0DJptljTd5H0Buz5RWicynAkUm2ak8UXY+Md0kbGLX7bD
 9MmBIfS6K7ACxUTwauvK2Ilhlc0tsrR5AOJEcf93J0zi9+sI/OWJp6aqWZI+uH+Yqn14
 LaVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694474498; x=1695079298;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EddYxVyHWpU4rxMgzKrErg1ihVsh8H+yZp+TnRm/heE=;
 b=SGJmx0wunnhNlPe11lWiQMcSbKWTwk/Cn00PbgCu9V1+U2u6WRIgyF1xcO79DWmdSz
 njZTVTQv8rGlIvyDw7rpJFtB5XH1N/huGKXyL6Bpo67Y+/NEQzZ9W78Sf9NPlZ/3qNeN
 p4urVd53kQ7rKrzlL/E6ht49fluGOdAD+PBR5vxdV6bbwW+YCYoHgJEL3KIIIa0YiLnM
 2yRKuJfVoZCCTf9BgOintWFYVhhUnN5eszoIpe10RhxJgNb2Xb9iGj4mp+5xQz+kfeKq
 /x2LiwjJ+Q39/DI6Lq3Y60mJJM699rKc+2/ylWvfHxuSRAIBsibHTFYMDObDw5buy6fN
 EiFA==
X-Gm-Message-State: AOJu0YzM0S/XBAUUwbHLn3C1vS068CoZFdPoujZAerHfR1t5xpugSiBP
 ePiM4AughJRRRLcn5GQDpKcIHQ==
X-Google-Smtp-Source: AGHT+IEUoIjJFrbsT4uF+aJ7u3jynwQ7dsL1HhllOt9pNZexovJZRVE+Rg1JU0+SoZU1wObUHkWtoA==
X-Received: by 2002:a17:902:c3c6:b0:1bb:ee1b:3cdf with SMTP id
 j6-20020a170902c3c600b001bbee1b3cdfmr8364898plj.67.1694474498446; 
 Mon, 11 Sep 2023 16:21:38 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 h22-20020a170902f7d600b001bf5c12e9fesm6997781plw.125.2023.09.11.16.21.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Sep 2023 16:21:38 -0700 (PDT)
Message-ID: <df3f4eda-dec1-6656-1921-4d2706d44f42@linaro.org>
Date: Mon, 11 Sep 2023 16:21:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH RESEND v5 52/57] target/loongarch: Implement xvreplve
 xvinsve0 xvpickve
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: maobibo@loongson.cn
References: <20230907083158.3975132-1-gaosong@loongson.cn>
 <20230907083158.3975132-53-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230907083158.3975132-53-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 9/7/23 01:31, Song Gao wrote:
> +static bool gen_vreplve_vl(DisasContext *ctx, arg_vvr *a,
> +                           uint32_t oprsz, int vece, int bit,
> +                           void (*func)(TCGv_i64, TCGv_ptr, tcg_target_long))
>   {
>       TCGv_i64 t0 = tcg_temp_new_i64();
>       TCGv_ptr t1 = tcg_temp_new_ptr();
>       TCGv_i64 t2 = tcg_temp_new_i64();
>   
> +    tcg_gen_andi_i64(t0, gpr_src(ctx, a->rk, EXT_NONE), (LSX_LEN / bit) - 1);
>       tcg_gen_shli_i64(t0, t0, vece);
>       if (HOST_BIG_ENDIAN) {
> +        tcg_gen_xori_i64(t0, t0, vece << ((LSX_LEN / bit) -1));
>       }
>   
>       tcg_gen_trunc_i64_ptr(t1, t0);
>       tcg_gen_add_ptr(t1, t1, cpu_env);
>       func(t2, t1, vec_full_offset(a->vj));
> +    tcg_gen_gvec_dup_i64(vece, vec_full_offset(a->vd), 16, 16, t2);
> +    if (oprsz == 32) {
> +        func(t2, t1,  offsetof(CPULoongArchState, fpr[a->vj].vreg.Q(1)));
> +        tcg_gen_gvec_dup_i64(vece,
> +                             offsetof(CPULoongArchState, fpr[a->vd].vreg.Q(1)),
> +                             16, 16, t2);
> +    }

This would be clearer as a loop:

     for (i = 0; i < oprsz; i += 16) {
         func(t2, t1, i);
         tcg_gen_gvec_dup_i64(vece, vec_full_offset(a->vd) + i, 16, 16, t2);
     }


> +static bool trans_xvrepl128vei_b(DisasContext *ctx, arg_vv_i * a)
>  {
> +    if (!avail_LASX(ctx)) {
>          return false;
>      }
>  
> +    if (!check_vec(ctx, 32)) {
>          return true;
>      }
>  
> +    tcg_gen_gvec_dup_mem(MO_8,
> +                         offsetof(CPULoongArchState, fpr[a->vd].vreg.B(0)),
> +                         offsetof(CPULoongArchState,
> +                                  fpr[a->vj].vreg.B((a->imm))),
> +                         16, 16);
> +    tcg_gen_gvec_dup_mem(MO_8,
> +                         offsetof(CPULoongArchState, fpr[a->vd].vreg.B(16)),
> +                         offsetof(CPULoongArchState,
> +                                  fpr[a->vj].vreg.B((a->imm + 16))),
> +                         16, 16);
> +    return true;
> +}

Again, a loop.  Also, I think you can easily merge all 4 of these functions using VECE.

> +#define XVREPLVE0(NAME, MOP)                                                  \
> +static bool trans_## NAME(DisasContext *ctx, arg_vv * a)                      \
> +{                                                                             \
> +    if (!avail_LASX(ctx)) {                                                   \
> +        return false;                                                         \
> +    }                                                                         \
> +                                                                              \
> +    if (!check_vec(ctx, 32)) {                                                \
> +        return true;                                                          \
> +    }                                                                         \
> +                                                                              \
> +    tcg_gen_gvec_dup_mem(MOP, vec_full_offset(a->vd), vec_full_offset(a->vj), \
> +                         32, 32);                                             \
> +    return true;                                                              \
> +}
>  
> +XVREPLVE0(xvreplve0_b, MO_8)
> +XVREPLVE0(xvreplve0_h, MO_16)
> +XVREPLVE0(xvreplve0_w, MO_32)
> +XVREPLVE0(xvreplve0_d, MO_64)
> +XVREPLVE0(xvreplve0_q, MO_128)

Should use a helper function and TRANS().

> +static bool do_vbsrl_v(DisasContext *ctx, arg_vv_i *a, uint32_t oprsz)
> +{
> +    int ofs, i, max;
> +    TCGv_i64 desthigh[2], destlow[2], high[2], low[2];
> +
> +    if (!check_vec(ctx, 32)) {
> +        return true;
> +    }
> +
> +    max = (oprsz == 16) ? 1 : 2;
> +
> +    for (i = 0; i < max; i++) {
> +        desthigh[i] = tcg_temp_new_i64();
> +        destlow[i] = tcg_temp_new_i64();
> +        high[i] = tcg_temp_new_i64();
> +        low[i] = tcg_temp_new_i64();
> +        get_vreg64(high[i], a->vj, 2 * i + 1);
> +
> +        ofs = ((a->imm) & 0xf) * 8;
> +        if (ofs < 64) {
> +            get_vreg64(low[i], a->vj, 2 * i);
> +            tcg_gen_extract2_i64(destlow[i], low[i], high[i], ofs);
> +            tcg_gen_shri_i64(desthigh[i], high[i], ofs);
> +        } else {
> +            tcg_gen_shri_i64(destlow[i], high[i], ofs - 64);
> +            desthigh[i] = tcg_constant_i64(0);
> +        }
> +        set_vreg64(desthigh[i], a->vd, 2 * i + 1);
> +        set_vreg64(destlow[i], a->vd, 2 * i);
> +    }
>  
>      return true;
>  }

Why are you using arrays?  They don't seem required.
This would seem clearer as

     for (i = 0; i < oprsz / 16; i++) {
         TCGv desthi = tcg_temp_new_i64();
         ...
     }


r~

