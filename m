Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D312C78D721
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 17:39:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbNHB-0008U7-MZ; Wed, 30 Aug 2023 11:38:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbNGs-0008AD-IC
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 11:38:20 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbNGo-0002wa-NL
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 11:38:17 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1c1e3a4a06fso22034455ad.3
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 08:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693409892; x=1694014692; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LHJVm1p6+gILOEgkcy2yx9tB3DNyh3ZZ8aaqP+PyVcw=;
 b=oDYzPFu+wNqIdK0HFP4S7yENfBVzhNVOchsA4aXAdhFZY7b7QXiCw2NmDY0stpINvF
 XiulzMLZ9sbu/BomIBeRL1+SnuCvkIXGDI2P2vM3nQhPBQ3kv4SkiIHzxqEqenz7ZC7I
 eLicJuq7d6NRuFLMXxcJfgWZndb0k1tWrux93EqmVbWpz6oJGDoc6WSvCnq/39JjxOyN
 TxOsW/GByL3cEW9ZxaFy9G7/3+ZzG9VCwgwTEcHaOf/ZcLaGZaLjLACmkGx4Mwj1PcRQ
 f9/y617K9rzwbUSTG7de1XwvYMdZsvJXczaHWN3gAff6wFQcr9HjI/FuJv5ZPE1Z2T7w
 LimQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693409892; x=1694014692;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LHJVm1p6+gILOEgkcy2yx9tB3DNyh3ZZ8aaqP+PyVcw=;
 b=fH7G+lMmSMKwhY93jSx2os5eSSs79MedmHGg1Z6nuxEkE3lATmZtulwATA21VgANjP
 5mqWqN//wLXpX+oSb8mdDNVYc8ag9RU7Y1/Y9ggthh4GZktITW6/UlCeqN/zWybXX9KX
 bO7dZ/8o2XerkB7niXHUDjEgug+eMRQhQE2uQYElQjJGsvcn77xzDzPIpC2FIXuq9gJF
 QSoN+Yhgz46Z0KryqqItDqfBFkXXRru8tqeAMewLMdy20F7XfyjuYVTAx9MwVeXM4+Eo
 y1W0dL95eWmtR7va5w7CsmnGZSai4G6MueeAaaBgfgQ3J2PqqLeZKU70nH1iNZWXxzmx
 jmvg==
X-Gm-Message-State: AOJu0YyGyC2h0XGwGU3h3jgvMYYm8uaL6yufbeTQvBBLnnBclRBBUiwf
 eqVbFHakonAMHVKqBo3CdYZ1hzAqbLSrYUZCi0o=
X-Google-Smtp-Source: AGHT+IF4w3zOdNHAcSHkpTRyEbZ/91ll2Qv9O3dAx6YN12qwJxyRc5X7N1pEgtygVeD86VQwB4FtOA==
X-Received: by 2002:a17:902:d2cd:b0:1bb:994c:bc43 with SMTP id
 n13-20020a170902d2cd00b001bb994cbc43mr3136769plc.18.1693409892233; 
 Wed, 30 Aug 2023 08:38:12 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 k18-20020a170902c41200b001b9d7c8f44dsm1521498plk.182.2023.08.30.08.38.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 08:38:11 -0700 (PDT)
Message-ID: <c63ca74a-71ac-3fea-56d2-f8f53b0e7d8a@linaro.org>
Date: Wed, 30 Aug 2023 08:38:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 05/48] target/loongarch: Implement xvadd/xvsub
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
References: <20230830084902.2113960-1-gaosong@loongson.cn>
 <20230830084902.2113960-6-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230830084902.2113960-6-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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

On 8/30/23 01:48, Song Gao wrote:
> +#ifndef CONFIG_USER_ONLY
> + #define CHECK_VEC do { \
> +     if ((ctx->vl == LSX_LEN) && \
> +         (ctx->base.tb->flags & HW_FLAGS_EUEN_SXE) == 0) { \
> +         generate_exception(ctx, EXCCODE_SXD); \
> +         return true; \
> +     } \
> +     if ((ctx->vl == LASX_LEN) && \
> +         (ctx->base.tb->flags & HW_FLAGS_EUEN_ASXE) == 0) { \
> +         generate_exception(ctx, EXCCODE_ASXD); \
> +         return true; \
> +     } \
> + } while (0)
> +#else
> + #define CHECK_VEC
> +#endif /*!CONFIG_USER_ONLY */

I think this is wrong.  The check would seem to be determined by the instruction (oprsz) 
rather than a fixed configuration of the cpu (vl).

You're also replacing

> -#ifndef CONFIG_USER_ONLY
> -#define CHECK_ASXE do { \
> -    if ((ctx->base.tb->flags & HW_FLAGS_EUEN_ASXE) == 0) { \
> -        generate_exception(ctx, EXCCODE_ASXD); \
> -        return true; \
> -    } \
> -} while (0)
> -#else
> -#define CHECK_ASXE
> -#endif

this, the correct test, which you just added in patch 3.


> +TRANS(xvadd_b, LASX, gvec_vvv, 32, MO_8, tcg_gen_gvec_add)
> +TRANS(xvadd_h, LASX, gvec_vvv, 32, MO_16, tcg_gen_gvec_add)
> +TRANS(xvadd_w, LASX, gvec_vvv, 32, MO_32, tcg_gen_gvec_add)
> +TRANS(xvadd_d, LASX, gvec_vvv, 32, MO_64, tcg_gen_gvec_add)

The size of the changes required to add oprsz to gen_vvv would seem to be an poor choice. 
If you do go that way, all of the LSX changes would need to be a separate patch.

Perhaps better as

static bool gvec_vvv_vl(DisasContext *ctx, arg_vvv *a, uint32_t oprsz, MemOp mop,
                         void (*func)(unsigned, uint32_t, uint32_t,
                                      uint32_t, uint32_t, uint32_t))
{
     uint32_t vd_ofs = vec_full_offset(a->vd);
     uint32_t vj_ofs = vec_full_offset(a->vj);
     uint32_t vk_ofs = vec_full_offset(a->vk);

     func(mop, vd_ofs, vj_ofs, vk_ofs, oprsz, ctx->vl / 8);
     return true;
}

static bool gvec_vvv(DisasContext *ctx, arg_vvv *a, MemOp mop,
                      void (*func)(unsigned, uint32_t, uint32_t,
                                   uint32_t, uint32_t, uint32_t))
{
     CHECK_SXE;
     return gvec_vvv_vl(ctx, a, 16, mop, func);
}

static bool gvec_xxx(DisasContext *ctx, arg_vvv *a, MemOp mop,
                      void (*func)(unsigned, uint32_t, uint32_t,
                                   uint32_t, uint32_t, uint32_t))
{
     CHECK_ASXE;
     return gvec_vvv_vl(ctx, a, 32, mop, func);
}

so that you don't have to replicate "16" or "32" across each instruction.


> +#define XVADDSUB_Q(NAME)                                         \
> +static bool trans_xv## NAME ##_q(DisasContext *ctx, arg_vvv * a) \
> +{                                                                \
> +    TCGv_i64 rh, rl, ah, al, bh, bl;                             \
> +    int i;                                                       \
> +                                                                 \
> +    if (!avail_LASX(ctx)) {                                      \
> +        return false;                                            \
> +    }                                                            \
> +                                                                 \
> +    CHECK_VEC;                                                   \
> +                                                                 \
> +    rh = tcg_temp_new_i64();                                     \
> +    rl = tcg_temp_new_i64();                                     \
> +    ah = tcg_temp_new_i64();                                     \
> +    al = tcg_temp_new_i64();                                     \
> +    bh = tcg_temp_new_i64();                                     \
> +    bl = tcg_temp_new_i64();                                     \
> +                                                                 \
> +    for (i = 0; i < 2; i++) {                                    \
> +        get_vreg64(ah, a->vj, 1 + i * 2);                        \
> +        get_vreg64(al, a->vj, 0 + i * 2);                        \
> +        get_vreg64(bh, a->vk, 1 + i * 2);                        \
> +        get_vreg64(bl, a->vk, 0 + i * 2);                        \
> +                                                                 \
> +        tcg_gen_## NAME ##2_i64(rl, rh, al, ah, bl, bh);         \
> +                                                                 \
> +        set_vreg64(rh, a->vd, 1 + i * 2);                        \
> +        set_vreg64(rl, a->vd, 0 + i * 2);                        \
> +   }                                                             \
> +                                                                 \
> +    return true;                                                 \
> +}

This should be a function, not a macro, passing in tcg_gen_{add,sub}2_i64.

> +
> +XVADDSUB_Q(add)
> +XVADDSUB_Q(sub)

Which lets these be normal TRANS expansions.



r~

