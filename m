Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B4973D8E6
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 09:53:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDh2T-0006Ea-6e; Mon, 26 Jun 2023 03:53:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDh2P-00066H-GA
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 03:53:29 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDh2N-0003tP-NX
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 03:53:29 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-313e09a5b19so1386559f8f.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 00:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687766006; x=1690358006;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=b+OwqEuZSQCh1epzPZvNFCjAs5pq4CFsJoIgAGZbGZU=;
 b=PFongND+z04vB2erWS0QlhLFVIXJ0QdlhbfzBVW/hOp80EHZ8FdPXhZZuQ1h2iXktg
 +2LPRdAev190VFYEgdZAlYGE2lWabC/oniEvgO59CI5AfBt+knUCTRhb9/XKH25K4lwB
 0yBXwdeXi5y72yTmO8pjtW5lSv16BxtcLthmyCAvlSVO65GyrVJDd0VEnsum45NJfi7P
 1iuycJexcaoJE6tbAVd3BDNVrF+qpMHIh4zxdabMYBFT0PwO6RxCk1XC9X+P97xmv+PZ
 NAmhmK4IEP3diP+F8adhSc9NqWsWRqJzKGPU7QzYtT5avqxK0uwT4tMyF+hb6WqVggkT
 5Neg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687766006; x=1690358006;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b+OwqEuZSQCh1epzPZvNFCjAs5pq4CFsJoIgAGZbGZU=;
 b=IZLIOh799WuNhXO9Lj8LUzYo20gE6DwxmjoNzpN/gNtsjEn3KO8L8GckkCIWQ7fyPS
 pDxCzzlBi7S83sMNTJBcmGEqUusxCa/Of8iyQM7b+Uhs5jyGEKFCmmfnx0l7liUM6Z5+
 k9tj+O3MAoqX0bzCt0mLUUCp7rdft+ZjtZyQBSbIASNauzqvxPxkbUIqRkjpKWpKLZ6j
 mTtxtAVABuF8I5scGHghW6xD8eJxwzVZNTKA1dNC/7Ln5GSF9BV/IHsTexA16wZ/nYff
 YSR7wp/3m1kzPfIomJc7ZtvZStl1xFZ0nbSeXAaJfGDtY7yjUwXfdT4i8cR6fAfg65aX
 3LvA==
X-Gm-Message-State: AC+VfDyjnXK2k66oaQ1mB5VfEsiKBPu3wPJsp4Eg6auiHAG5vYY1E556
 EJAOnGfmBo3wFeM8MbM/4CBIPQ==
X-Google-Smtp-Source: ACHHUZ67sQuaOVfSBbnRqDuaYGTU+R6c3Jf6MSbc8P4rpPlc7vBfa6oprwbPnWzDKMJ0IT6XlP69Mw==
X-Received: by 2002:a5d:45c3:0:b0:311:1944:ad33 with SMTP id
 b3-20020a5d45c3000000b003111944ad33mr23568468wrs.12.1687766006137; 
 Mon, 26 Jun 2023 00:53:26 -0700 (PDT)
Received: from [192.168.1.208] ([139.47.42.170])
 by smtp.gmail.com with ESMTPSA id
 u13-20020a5d514d000000b0030e56a9ff25sm6480072wrt.31.2023.06.26.00.53.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jun 2023 00:53:25 -0700 (PDT)
Message-ID: <239cd146-c616-4fc7-7dfb-5052dbbb3a76@linaro.org>
Date: Mon, 26 Jun 2023 09:53:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 08/11] target/i386: AMD only supports SYSENTER/SYSEXIT
 in 32-bit mode
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20230623131711.96775-1-pbonzini@redhat.com>
 <20230623131711.96775-9-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230623131711.96775-9-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 6/23/23 15:17, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)

I guess we have no other vendors except Intel and AMD...

Acked-by: Richard Henderson <richard.henderson@linaro.org>


r~

> 
> diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
> index ed4016f554b..a20b5af71e7 100644
> --- a/target/i386/tcg/translate.c
> +++ b/target/i386/tcg/translate.c
> @@ -5669,9 +5669,10 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
>           s->base.is_jmp = DISAS_NORETURN;
>           break;
>       case 0x134: /* sysenter */
> -        /* For Intel SYSENTER is valid on 64-bit */
> -        if (CODE64(s) && env->cpuid_vendor1 != CPUID_VENDOR_INTEL_1)
> +        /* For AMD SYSENTER is not valid in long mode */
> +        if (LMA(s) && env->cpuid_vendor1 != CPUID_VENDOR_INTEL_1) {
>               goto illegal_op;
> +        }
>           if (!PE(s)) {
>               gen_exception_gpf(s);
>           } else {
> @@ -5680,9 +5681,10 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
>           }
>           break;
>       case 0x135: /* sysexit */
> -        /* For Intel SYSEXIT is valid on 64-bit */
> -        if (CODE64(s) && env->cpuid_vendor1 != CPUID_VENDOR_INTEL_1)
> +        /* For AMD SYSEXIT is not valid in long mode */
> +        if (LMA(s) && env->cpuid_vendor1 != CPUID_VENDOR_INTEL_1) {
>               goto illegal_op;
> +        }
>           if (!PE(s)) {
>               gen_exception_gpf(s);
>           } else {


