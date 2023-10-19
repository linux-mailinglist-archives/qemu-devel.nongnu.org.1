Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D64427CF604
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 13:01:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtQlG-00022X-3V; Thu, 19 Oct 2023 07:00:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtQl5-00022E-CG
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 07:00:07 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtQl1-0004vX-8U
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 07:00:06 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-408002b5b9fso21048395e9.3
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 04:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697713200; x=1698318000; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=phWrgdNLL7Ofuhp1opCzg0RflDDjtru3n9ZugYbbMs4=;
 b=UqNFb+9TtNBjnDp3Rfpo5Wf7OD7WKsaImJqUbrB8pzXTqRvsv7kU6Oi1prv5CI+lGb
 sdJ/pLLo71r/FdYE8A9R2K/wIazjgXjCagqKeJE11jPTlAVrLzc18iXsl37hBn2RZZ7o
 8u1HIILVu1JOKqYkwt+IWn4XnvgAI8mDamEhKfZRJ24yK4jXJWWMYxfHS05UiojbpWeC
 +qNMrZ0uCbq4rVeE5pHS/Uh/9otOoAu51RoQQ3FpHY2dQYL0vczL/T3BPHPbzV4I8rLM
 WZqQhoo2lS3HMBVgQBLLleXHkcU71GueyocPgRCxcnFP5oERX7pyUk84u0gCWlqHvNTS
 UomQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697713200; x=1698318000;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=phWrgdNLL7Ofuhp1opCzg0RflDDjtru3n9ZugYbbMs4=;
 b=kLDTYCZT84t7eLLIHydPtH+r0hyVW5mfVmkZwrpkywO2n5N0iYEnZzLDg43ihyR4Xv
 FFQcSd7cdn6vvBIm6tAU741kzapBShsHDY7hi4TrGxa8p3cQ0X931U/atIjx1jcSG99s
 AtCP5Y+f7xyhyxfHp+qF8AyqIa9tvj4xUyYdjs7QF+g2FfQbEvy0aVwDnMCEaI7EHbgi
 TlN/xExp1RDa4YR6WqTA35OsE/RLxOllM87ydPkfTzuXyT3ShtDsjuScQIq+pTRDmKv0
 4lx0Q1ip+NMdtWC9Iyt0wF/x71eFS1y/ZWflFNpGj4WTTHKhN/7KPTU36fZgHNsm1mxd
 i5Lg==
X-Gm-Message-State: AOJu0YzQT+DbY83ypLjhhDiOOO0vc2AYoOJLNgzogdlsihpPdeX3eCEp
 q2csdR0F5TDc9l11s9aUTv9oaQ==
X-Google-Smtp-Source: AGHT+IGAFX5t9tNb9pDRNDT6VwmrqE16kRnA8WvS93iEFrxZ2MiAJqVNEFUZlpZ/L0ON1FJBlYXndA==
X-Received: by 2002:a05:600c:46d1:b0:405:3e9a:f1e3 with SMTP id
 q17-20020a05600c46d100b004053e9af1e3mr1562115wmo.11.1697713200254; 
 Thu, 19 Oct 2023 04:00:00 -0700 (PDT)
Received: from [192.168.69.115] (176-131-216-177.abo.bbox.fr.
 [176.131.216.177]) by smtp.gmail.com with ESMTPSA id
 l16-20020a7bc450000000b003fee6e170f9sm4072288wmi.45.2023.10.19.03.59.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Oct 2023 03:59:59 -0700 (PDT)
Message-ID: <1261e3b2-fc10-c37b-c19d-ac78f5912fc2@linaro.org>
Date: Thu, 19 Oct 2023 12:59:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2 03/19] target/i386: implement SHA instructions
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
References: <20231019104648.389942-1-pbonzini@redhat.com>
 <20231019104648.389942-4-pbonzini@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Ard Biesheuvel <ardb@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231019104648.389942-4-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

Hi Paolo,

On 19/10/23 12:46, Paolo Bonzini wrote:
> The implementation was validated with OpenSSL and with the test vectors in
> https://github.com/rust-lang/stdarch/blob/master/crates/core_arch/src/x86/sha.rs.
> 
> The instructions provide a ~25% improvement on hashing a 64 MiB file:
> runtime goes down from 1.8 seconds to 1.4 seconds; instruction count on
> the host goes down from 5.8 billion to 4.8 billion with slightly better
> IPC too.  Good job Intel. ;)
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/cpu.c                    |   2 +-
>   target/i386/ops_sse.h                | 128 +++++++++++++++++++++++++++
>   target/i386/tcg/decode-new.c.inc     |  11 +++
>   target/i386/tcg/decode-new.h         |   1 +
>   target/i386/tcg/emit.c.inc           |  54 +++++++++++
>   target/i386/tcg/ops_sse_header.h.inc |  14 +++
>   6 files changed, 209 insertions(+), 1 deletion(-)


> diff --git a/target/i386/ops_sse.h b/target/i386/ops_sse.h
> index 33908c0691f..6a465a35fdb 100644
> --- a/target/i386/ops_sse.h
> +++ b/target/i386/ops_sse.h
> @@ -2527,6 +2527,134 @@ SSE_HELPER_FMAP(helper_fma4ps,  ZMM_S, 2 << SHIFT, float32_muladd)
>   SSE_HELPER_FMAP(helper_fma4pd,  ZMM_D, 1 << SHIFT, float64_muladd)
>   #endif
>   
> +#if SHIFT == 1
> +#define SSE_HELPER_SHA1RNDS4(name, F, K) \
> +    void name(Reg *d, Reg *a, Reg *b)                                       \
> +    {                                                                       \
> +        uint32_t A, B, C, D, E, t, i;                                       \
> +                                                                            \
> +        A = a->L(3);                                                        \
> +        B = a->L(2);                                                        \
> +        C = a->L(1);                                                        \
> +        D = a->L(0);                                                        \
> +        E = 0;                                                              \
> +                                                                            \
> +        for (i = 0; i <= 3; i++) {                                          \
> +            t = F(B, C, D) + rol32(A, 5) + b->L(3 - i) + E + K;             \
> +            E = D;                                                          \
> +            D = C;                                                          \
> +            C = rol32(B, 30);                                               \
> +            B = A;                                                          \
> +            A = t;                                                          \
> +        }                                                                   \
> +                                                                            \
> +        d->L(3) = A;                                                        \
> +        d->L(2) = B;                                                        \
> +        d->L(1) = C;                                                        \
> +        d->L(0) = D;                                                        \
> +    }
> +
> +#define SHA1_F0(b, c, d) (((b) & (c)) ^ (~(b) & (d)))
> +#define SHA1_F1(b, c, d) ((b) ^ (c) ^ (d))
> +#define SHA1_F2(b, c, d) (((b) & (c)) ^ ((b) & (d)) ^ ((c) & (d)))
> +
> +SSE_HELPER_SHA1RNDS4(helper_sha1rnds4_f0, SHA1_F0, 0x5A827999)
> +SSE_HELPER_SHA1RNDS4(helper_sha1rnds4_f1, SHA1_F1, 0x6ED9EBA1)
> +SSE_HELPER_SHA1RNDS4(helper_sha1rnds4_f2, SHA1_F2, 0x8F1BBCDC)
> +SSE_HELPER_SHA1RNDS4(helper_sha1rnds4_f3, SHA1_F1, 0xCA62C1D6)
> +
> +void helper_sha1nexte(Reg *d, Reg *a, Reg *b)
> +{
> +    d->L(3) = b->L(3) + rol32(a->L(3), 30);
> +    d->L(2) = b->L(2);
> +    d->L(1) = b->L(1);
> +    d->L(0) = b->L(0);
> +}
> +
> +void helper_sha1msg1(Reg *d, Reg *a, Reg *b)
> +{
> +    /* These could be overwritten by the first two assignments, save them.  */
> +    uint32_t b3 = b->L(3);
> +    uint32_t b2 = b->L(2);
> +
> +    d->L(3) = a->L(3) ^ a->L(1);
> +    d->L(2) = a->L(2) ^ a->L(0);
> +    d->L(1) = a->L(1) ^ b3;
> +    d->L(0) = a->L(0) ^ b2;
> +}
> +
> +void helper_sha1msg2(Reg *d, Reg *a, Reg *b)
> +{
> +    d->L(3) = rol32(a->L(3) ^ b->L(2), 1);
> +    d->L(2) = rol32(a->L(2) ^ b->L(1), 1);
> +    d->L(1) = rol32(a->L(1) ^ b->L(0), 1);
> +    d->L(0) = rol32(a->L(0) ^ d->L(3), 1);
> +}
> +
> +#define SHA256_CH(e, f, g)  (((e) & (f)) ^ (~(e) & (g)))
> +#define SHA256_MAJ(a, b, c) (((a) & (b)) ^ ((a) & (c)) ^ ((b) & (c)))
> +
> +#define SHA256_RNDS0(w) (ror32((w), 2) ^ ror32((w), 13) ^ ror32((w), 22))
> +#define SHA256_RNDS1(w) (ror32((w), 6) ^ ror32((w), 11) ^ ror32((w), 25))
> +#define SHA256_MSGS0(w) (ror32((w), 7) ^ ror32((w), 18) ^ ((w) >> 3))
> +#define SHA256_MSGS1(w) (ror32((w), 17) ^ ror32((w), 19) ^ ((w) >> 10))
> +
> +void helper_sha256rnds2(Reg *d, Reg *a, Reg *b, uint32_t wk0, uint32_t wk1)
> +{
> +    uint32_t t, AA, EE;
> +
> +    uint32_t A = b->L(3);
> +    uint32_t B = b->L(2);
> +    uint32_t C = a->L(3);
> +    uint32_t D = a->L(2);
> +    uint32_t E = b->L(1);
> +    uint32_t F = b->L(0);
> +    uint32_t G = a->L(1);
> +    uint32_t H = a->L(0);
> +
> +    /* Even round */
> +    t = SHA256_CH(E, F, G) + SHA256_RNDS1(E) + wk0 + H;
> +    AA = t + SHA256_MAJ(A, B, C) + SHA256_RNDS0(A);
> +    EE = t + D;
> +
> +    /* These will be B and F at the end of the odd round */
> +    d->L(2) = AA;
> +    d->L(0) = EE;
> +
> +    D = C, C = B, B = A, A = AA;
> +    H = G, G = F, F = E, E = EE;
> +
> +    /* Odd round */
> +    t = SHA256_CH(E, F, G) + SHA256_RNDS1(E) + wk1 + H;
> +    AA = t + SHA256_MAJ(A, B, C) + SHA256_RNDS0(A);
> +    EE = t + D;

Better would be to implement that generically, so we can reuse
host crypto accelerators when available. Can be done later...
(See commit range fb250c59aa..ff494c8e2a for example.)

> +    d->L(3) = AA;
> +    d->L(1) = EE;
> +}
> +
> +void helper_sha256msg1(Reg *d, Reg *a, Reg *b)
> +{
> +    /* b->L(0) could be overwritten by the first assignment, save it.  */
> +    uint32_t b0 = b->L(0);
> +
> +    d->L(0) = a->L(0) + SHA256_MSGS0(a->L(1));
> +    d->L(1) = a->L(1) + SHA256_MSGS0(a->L(2));
> +    d->L(2) = a->L(2) + SHA256_MSGS0(a->L(3));
> +    d->L(3) = a->L(3) + SHA256_MSGS0(b0);
> +}
> +
> +void helper_sha256msg2(Reg *d, Reg *a, Reg *b)
> +{
> +    /* Earlier assignments cannot overwrite any of the two operands.  */
> +    d->L(0) = a->L(0) + SHA256_MSGS1(b->L(2));
> +    d->L(1) = a->L(1) + SHA256_MSGS1(b->L(3));
> +    /* Yes, this reuses the previously computed values.  */
> +    d->L(2) = a->L(2) + SHA256_MSGS1(d->L(0));
> +    d->L(3) = a->L(3) + SHA256_MSGS1(d->L(1));
> +}
> +#endif


