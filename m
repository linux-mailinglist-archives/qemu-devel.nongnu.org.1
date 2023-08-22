Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF67784678
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 18:04:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYTqC-0002QF-MV; Tue, 22 Aug 2023 12:02:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYTo7-00018P-MF
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 12:01:01 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYTo5-0005Jw-Fz
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 12:00:39 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-68a41035828so1836593b3a.1
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 09:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692720036; x=1693324836;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cU/MxLvDfi8X0kGNA+8H1EmcZVJzsgepvRaqmfSXius=;
 b=B6x5BkD6+TUcg0lbJlvrrW/zziXNMXZafnDWzwYCcRiTySWqDvGzDpOy5cbJB+uHuu
 bZaiVA6UaYF6OcMeJw24Jkxeo+7t1E+VWBQOzt4XKoQyvE2pb8nGEgx/NY19067ophMs
 /G0q1PKKGSfBa1El755IY1Zo4Egh3ZYOEU2e/WJNRzVzyirv2tcc7MWaKdwLJrXUCAMW
 SqqAkjDivpGZJ9CSPDI3/5lpZFMw0pIfYu+6Pj2qh03YbPr5PrJ58GR51VnzABxP9IlG
 koeIgYSevjNEg6yWTEhmWSqxCgcMcDMC9HfdzLq8BAh3qwY6pQ6C2V3zbBBPI5nznKNT
 Pjlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692720036; x=1693324836;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cU/MxLvDfi8X0kGNA+8H1EmcZVJzsgepvRaqmfSXius=;
 b=l4WPzh27/HC+PECKgf1Y592ya9eWnK+dEKgvjdaX0LPKpDvxte4jebaNS9NlMXuK/t
 lK2IJ8Fl+un9JCU3CvDotMJK/GFbtmmY6WhoAD9MrAlRKXQ8Pr3CxSpGMohJzgO/vAeI
 5k2pt9vTlAh1nlKEOPf+3cTbeVAbLHT0M0n3O8gwC53k1gbC3D19HzQc7adkeTub/cPj
 6+2DpppmAisIXYZ8xeTsh/PzKbpnbvYZk7Vgu+hMq5mKKVYsjXSb9zFIzjvU5tF/uY8U
 iVDzyU2L+tVFCAt7YHtRdKYc+RNOiIq6n4D1ZBII050Aq5dnPVx0qDoMMfKVz+r/0sdX
 KVkw==
X-Gm-Message-State: AOJu0YycsX0sHQw1SvM8UgFWcG+QmNRC8f37FJku9ZW+LlIxP5BCtwdO
 PzZk6tFsvwTHqt7GRuLcTVSO4A==
X-Google-Smtp-Source: AGHT+IHZTOCi3IZUkypkSbLOpBTCw2dumnfQ4ZxwCWBlCFVpH0sAHN9d0LGZGK3S7QKk088y6yYdQg==
X-Received: by 2002:a17:90a:c292:b0:262:ceaa:1720 with SMTP id
 f18-20020a17090ac29200b00262ceaa1720mr7288351pjt.5.1692720036185; 
 Tue, 22 Aug 2023 09:00:36 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:4e3c:f4a4:b92a:b5ab?
 ([2602:47:d483:7301:4e3c:f4a4:b92a:b5ab])
 by smtp.gmail.com with ESMTPSA id
 gk10-20020a17090b118a00b00263f5ac814esm9756530pjb.38.2023.08.22.09.00.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Aug 2023 09:00:35 -0700 (PDT)
Message-ID: <fd59f5e2-c125-6d12-cbd5-a12e3aca37ce@linaro.org>
Date: Tue, 22 Aug 2023 09:00:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/7] tcg/tcg-op: Document bswap32() byte pattern
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20230822093712.38922-1-philmd@linaro.org>
 <20230822093712.38922-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230822093712.38922-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.767,
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

On 8/22/23 02:37, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   tcg/tcg-op.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
> index f164ddc95e..e6b0d74a46 100644
> --- a/tcg/tcg-op.c
> +++ b/tcg/tcg-op.c
> @@ -1061,6 +1061,11 @@ void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags)
>       }
>   }
>   
> +/*
> + * bswap32_i32: 32-bit byte swap on a 32-bit value.
> + *
> + * Byte pattern:  bswap32_i32(abcd) -> dcba
> + */

Ok.

>   void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg)
>   {
>       if (TCG_TARGET_HAS_bswap32_i32) {
> @@ -1776,6 +1781,13 @@ void tcg_gen_bswap16_i64(TCGv_i64 ret, TCGv_i64 arg, int flags)
>       }
>   }
>   
> +/*
> + * bswap32_i64: 32-bit byte swap on the low bits of a 64-bit value.
> + *
> + * Byte pattern:  bswap32_i64(xxxxabcd) -> ....dcba     (TCG_BSWAP_OZ)
> + *                bswap32_i64(xxxxabcd) -> ssssdcba     (TCG_BSWAP_OS)
> + *                bswap32_i64(xxxxabcd) -> xxxxdcba
> + */

Again, TCG_BSWAP_IZ.

r~

