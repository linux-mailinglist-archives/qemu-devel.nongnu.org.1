Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAAF749B25
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 13:51:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHNVE-0000xl-Qk; Thu, 06 Jul 2023 07:50:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qHNV7-0000vn-Bi
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 07:50:25 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qHNV5-0000aH-Kr
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 07:50:21 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6b73b839025so576841a34.1
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 04:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1688644218; x=1691236218;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ca4yaWZAtusWL2+Y6PDQe2Y+G7VzbBYOX9to+l3pppk=;
 b=BCR0aBdDPTSM8t3ifns0Aybgd9RY701A5725tmE3haTImRKxw4gpbBe9UXNATdQYXH
 DST9qVVZhpWa/w8TXCQ1U4VUcsOfgiNx+xIDS5zoYcgvAtN7R4XyiGSki6od8MQAEPdx
 zSZLp/63qnuc3BUztRJz/Bw/cpBxXPm0wdYdyqLKEXQktKVzCQe29afj2N0eZptoyS6u
 bSvA3E6bebBnX7ikaaQJxdVXEUvLfZgmGmE/Emob8LT8LxDx9O67Ct6cVvWb+4RTq3Kh
 pLXDRFcF5lePsGuQHnZE2FtbS5cVzvtL3HsxVtOk6eGycgx2uEGnoJiKtW31QNc56Lwd
 aOjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688644218; x=1691236218;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ca4yaWZAtusWL2+Y6PDQe2Y+G7VzbBYOX9to+l3pppk=;
 b=RdpaY95UMhi4JcIyjwbdva0CNs6wiImQDFkggGSRImVeHaIy30WoouQ1QMtFNXdZh3
 55DwfzP6BisrD3dCV/64gQaNjaQXrvDeHgiroibyJakUp4QvQl1wfed9VN2anP0XFMot
 63IkmbVP6j39bDmrdeNUhqD2Hwb8kle1SgCBUQSEYQRmI5ukw6kGF7vdhgVjtMZTz1vD
 rdev363TZ0rWZsJ1ED3XmTSSa+2O0KehSBdPGJwLoNH1pfDWK39FBtUC+hWK/AvdMiwO
 l+PIQtMGklvUgGXNjoxEGLVb2G+oDOsPhRAlKPLdxZBXXnofHLw7ACT7t9WEuabNn8tA
 OswQ==
X-Gm-Message-State: ABy/qLaTX2uqptVBdg0midl2Q+rEaEHpJyEO6IBmsOzwekkofaOCrRKq
 xxoiH4KK+6p9oZI+o5JVmmc7aQ==
X-Google-Smtp-Source: APBJJlHVIHgn5g5OYwmy0+b+GQ4fxpQCSGxBCY9LC0I16VOtrMZhKnfT1jVKtnlbp1U2kP1dhiFNPA==
X-Received: by 2002:a05:6830:1085:b0:6b8:8f8f:3f46 with SMTP id
 y5-20020a056830108500b006b88f8f3f46mr2235851oto.13.1688644218328; 
 Thu, 06 Jul 2023 04:50:18 -0700 (PDT)
Received: from ?IPV6:2804:7f0:bcc0:bdf2:b7ba:a476:c0e3:fb59?
 ([2804:7f0:bcc0:bdf2:b7ba:a476:c0e3:fb59])
 by smtp.gmail.com with ESMTPSA id
 h25-20020a9d6a59000000b006b8850ad193sm570404otn.56.2023.07.06.04.50.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jul 2023 04:50:17 -0700 (PDT)
Message-ID: <f77e5e6e-efff-3c2b-f7da-7155eb40586a@ventanamicro.com>
Date: Thu, 6 Jul 2023 08:50:14 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] target/riscv: Fix LMUL check to use minimum SEW
Content-Language: en-US
To: Rob Bradford <rbradford@rivosinc.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20230706104433.16264-1-rbradford@rivosinc.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20230706104433.16264-1-rbradford@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x32f.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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



On 7/6/23 07:44, Rob Bradford wrote:
> The previous check was failing with:
> 
> ELEN = 64 SEW = 16 and LMUL = 1/8 (encoded as 5) which is a valid
> combination.
> 
> Fix the check to correctly match the specification by using minimum SEW
> rather than the active SEW.
> 
>  From the specification:
> 
> "In general, the requirement is to support LMUL ≥ SEWMIN/ELEN, where
> SEWMIN is the narrowest supported SEW value and ELEN is the widest
> supported SEW value. In the standard extensions, SEWMIN=8. For standard
> vector extensions with ELEN=32, fractional LMULs of 1/2 and 1/4 must be
> supported. For standard vector extensions with ELEN=64, fractional LMULs
> of 1/2, 1/4, and 1/8 must be supported."
> 
>  From inspection this new check allows:
> 
> ELEN=64 1/2, 1/4, 1/8 (encoded as 7, 6, 5 respectfully)
> ELEN=32 1/2, 1/4 (encoded as 7 and 6 respectfully)
> 
> Fixes: d9b7609a1fb2 ("target/riscv: rvv-1.0: configure instructions")
> 
> Signed-off-by: Rob Bradford <rbradford@rivosinc.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/vector_helper.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 1e06e7447c..8dfd8fe484 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -43,9 +43,9 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
>                                               xlen - 1 - R_VTYPE_RESERVED_SHIFT);
>   
>       if (lmul & 4) {
> -        /* Fractional LMUL. */
> +        /* Fractional LMUL - check LMUL >= ELEN/SEW_MIN (8) */
>           if (lmul == 4 ||
> -            cpu->cfg.elen >> (8 - lmul) < sew) {
> +            cpu->cfg.elen >> (8 - lmul) < 8) {
>               vill = true;
>           }
>       }

