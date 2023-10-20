Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4E47D12F6
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 17:39:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtrZd-0003rB-6a; Fri, 20 Oct 2023 11:38:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtrZU-0003mi-7z
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 11:37:58 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtrZR-0002LN-Dj
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 11:37:55 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1c9a1762b43so7751845ad.1
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 08:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697816271; x=1698421071; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ekK3odRePrfaq/tMPgReUxm7QB0i2gSpQ/YULPVAvAI=;
 b=PQVN2rAawQF3mYy57s3t7HBru0CCJCEgupR3FOP23D7gJN0OCOla9i+/YliTaRgHc9
 Spk0lC/fefFw5B5faTpyL9+acdJwi9Nfe1A5lu94sXil8LLR2ZtXCssapo1z7+HNmWjo
 aCL6mHkFL1J4l5TrtcokFtTcx18eo6eDU5XadPRFLzz2FWgObLjIgXvqBuPG2nvsxxZd
 v1GwOEQAPu2EN6Jah0BAKVE+HTWNZetQI4+y3VEmewK8E+zcD3JMAcRFEtO2/huiUDAv
 p90Me/AiwhdB9NzXdCYJaPLfE8jSsbg/mNXMXvCO4lkN++2zlANQvHVy2MvbWzg0iFwS
 QbCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697816271; x=1698421071;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ekK3odRePrfaq/tMPgReUxm7QB0i2gSpQ/YULPVAvAI=;
 b=l2PZIc13ZfV9Vt43EF4ugp8/mvefcQqw/A+dQgRAYZhFuaPkeFtlUYZaT+qCnmUJP3
 QK2GZlhD0gB9mK1E02moeZyYH/fVGYrK6dibsLddRbQX6q1WmMH1i5B7wR0J1dKdB7iJ
 qY9GkMxnFIyr07WlW79pRjve4nq59qyeo4p/OgrcuZvr/6fparHzDE72p0+vsqtvU5Hh
 8CbM+nq+cK9CX+fBVY4FCsguUehvO2QFJFO7kEUMGO8rh5TKs0ZYX69kozwsoVOh8jEc
 kViSrK8Z4ZaPKXmxnlHzMaz3+lWJjxSwanfV+4VwDtFlaTUn1YwbzBTTCfyJSjkV1cx4
 bqow==
X-Gm-Message-State: AOJu0Yxtnj5cJyaaZm5ru+4tUbGIAchyrDSeG2pEalhk7c9xaP2TQ1e1
 cNk44qCf7WOO6WhkgVnePbmFPsJs9WXIjb5lMKY=
X-Google-Smtp-Source: AGHT+IF7m+QdEpMsxmkQlpcqwvMfczNbw6Bm8RjgmGX1dl2Mvg/ODcVnvvLAvf3idkCIePx6Qi8jfQ==
X-Received: by 2002:a17:902:e841:b0:1b6:6f12:502e with SMTP id
 t1-20020a170902e84100b001b66f12502emr2564565plg.49.1697816271599; 
 Fri, 20 Oct 2023 08:37:51 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 x4-20020a170902ea8400b001c723d6c410sm1679695plb.16.2023.10.20.08.37.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Oct 2023 08:37:50 -0700 (PDT)
Message-ID: <e615701f-f8c3-4eb3-be56-d69506a4232e@linaro.org>
Date: Fri, 20 Oct 2023 08:37:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/tcg: fix out-of-bounds access in test-avx
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20231020072135.450301-1-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231020072135.450301-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 10/20/23 00:21, Paolo Bonzini wrote:
> This can cause differences between native and QEMU execution, due
> to ASLR.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   tests/tcg/i386/test-avx.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> diff --git a/tests/tcg/i386/test-avx.c b/tests/tcg/i386/test-avx.c
> index c39c0e5bce8..910b0673535 100644
> --- a/tests/tcg/i386/test-avx.c
> +++ b/tests/tcg/i386/test-avx.c
> @@ -236,12 +236,15 @@ v4di val_i64[] = {
>   
>   v4di deadbeef = {0xa5a5a5a5deadbeefull, 0xa5a5a5a5deadbeefull,
>                    0xa5a5a5a5deadbeefull, 0xa5a5a5a5deadbeefull};
> -v4di indexq = {0x000000000000001full, 0x000000000000008full,
> -               0xffffffffffffffffull, 0xffffffffffffff5full};
> -v4di indexd = {0x00000002000000efull, 0xfffffff500000010ull,
> -               0x0000000afffffff0ull, 0x000000000000000eull};
> +/* &gather_mem[0x10] is 512 bytes from the base; indices must be >=-64, <64
> + * to account for scaling by 8 */
> +v4di indexq = {0x000000000000001full, 0x000000000000003dull,
> +               0xffffffffffffffffull, 0xffffffffffffffdfull};
> +v4di indexd = {0x00000002ffffffcdull, 0xfffffff500000010ull,
> +               0x0000003afffffff0ull, 0x000000000000000eull};
>   
>   v4di gather_mem[0x20];
> +_Static_assert(sizeof(gather_mem) == 1024);
>   
>   void init_f16reg(v4di *r)
>   {


