Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1907D75EF
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 22:44:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvkhv-0002Pg-WE; Wed, 25 Oct 2023 16:42:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvkht-0002PS-3F
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 16:42:25 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvkhr-0002yb-FL
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 16:42:24 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6b709048f32so161453b3a.0
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 13:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698266541; x=1698871341; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9+RRDmz7MiHRK9YxCLGz/w1NIcpWjLBjyDMemP2Z4ek=;
 b=ObKL3IQ8EpkZltLHreAkVtuhLFJJX58oeFKsR6vRZuOpeQkObqWz+Krzdud3179WPj
 ZpMkMc2GaFawf+kTyLkkEt/Ly5FrOUasNkgredc+aXdEF683XRH3AsBZzqXJ9VCfMebP
 k1hDyrK6guoLNZStzwTOA5W1WdSf0ewJIvcNnF6peLNfxJT8s1cUpjtxbyXtk9M9dBmK
 GYPfRioJZPNTDt1ahIx9Q7+0IITWmxKvHpTGe0HD22mGxbYogzvGRLKSGN0lx//x3PxM
 jXdklI66nETizYz2bdISyaBkomEa2zLziGGwWksVSqrE2VHFp4RbCACLoYgA47VydOxo
 apog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698266541; x=1698871341;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9+RRDmz7MiHRK9YxCLGz/w1NIcpWjLBjyDMemP2Z4ek=;
 b=FDqsz9NWKggNMPfXia0Bq+yp/GTvEjDLPM4f0PkJLdz0sAR/iYzx5NT0DxLNvKQpb3
 xZr2UCxgQasHAmv9/Om/p6FSGevAU6sRUOGKrGjlsgkyNkXX/RgHJb7X0D6PBw8DLR6Y
 Hd4ZbyP9X5Gbd+vvrgzo0EEbjtCtb13W8bnUh6SRJBq7ObuY+TxZMaF6SaXEqC7s72+x
 Uf8P/selA4L/jP/jkY7t3H4YWv7WEm7GAgLP7VGreocYm37Z28c6w4SaXYH8dTfeQc8c
 R1qwwJvIM8DRv5FmrTLOIcOTLUa3kKWNSnLPdHPU8KGJy4rjGN0MmqjC91z02LR9UXvc
 /ONQ==
X-Gm-Message-State: AOJu0YwhqcbcN+X9daXntPGnd+ELD7Kc1ebTTNPyV1rAyUKv/yTNtFXx
 kk2oof7OPpsi/3Q9woHNIHHxlQ==
X-Google-Smtp-Source: AGHT+IGZ/DbbNXe3+0bvYoVNJa+gAkL3GnfR4w3Vt3Im4Picnbe7bewp4u4a7QYQvUFaBElUU0fQWw==
X-Received: by 2002:a05:6a20:8f1e:b0:15d:9ee7:180a with SMTP id
 b30-20020a056a208f1e00b0015d9ee7180amr8072760pzk.4.1698266541066; 
 Wed, 25 Oct 2023 13:42:21 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 n38-20020a056a000d6600b006c031c6c200sm1718146pfv.88.2023.10.25.13.42.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Oct 2023 13:42:20 -0700 (PDT)
Message-ID: <a03cebdc-5659-4f62-819f-74ee9633e4ed@linaro.org>
Date: Wed, 25 Oct 2023 13:42:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] tcg: allow a target to request canonicalization of
 SUBI to ADDI
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20231025185956.72677-1-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231025185956.72677-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

On 10/25/23 11:59, Paolo Bonzini wrote:
> On x86, this is more efficient because it enables generation of
> more LEA instructions.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   include/tcg/tcg.h     |  4 ++++
>   tcg/i386/tcg-target.h |  2 ++
>   tcg/tcg-op.c          | 20 ++++++++++++++++----
>   3 files changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
> index a9282cdcc60..48e5aeef173 100644
> --- a/include/tcg/tcg.h
> +++ b/include/tcg/tcg.h
> @@ -109,6 +109,10 @@ typedef uint64_t TCGRegSet;
>   #define TCG_TARGET_HAS_sub2_i32         1
>   #endif
>   
> +#ifndef TCG_TARGET_PREFERS_addi
> +#define TCG_TARGET_PREFERS_addi         0
> +#endif

I would rather do this unconditionally.

Many of the tcg backends do this manually, e.g. s390x:

     case INDEX_op_sub_i64:
         a0 = args[0], a1 = args[1], a2 = args[2];
         if (const_args[2]) {
             a2 = -a2;
             goto do_addi_64;
         } else {
             tcg_out_insn(s, RRFa, SGRK, a0, a1, a2);
         }
         break;

While we could do something similar for i386, it would be better to not require such hoops 
in each backend.

We would also want to perform this transformation in optimize.c.


r~


