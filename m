Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9CE74974B
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 10:18:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHKBt-0003JG-4L; Thu, 06 Jul 2023 04:18:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHKBY-00039I-Kj
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 04:18:02 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHKBT-0007o3-Ty
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 04:17:54 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3fbf1b82d9cso3946275e9.2
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 01:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688631470; x=1691223470;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6Q5l2LnRZZEGWmtGD3f+M9GWaSjANDfy9qt1iEnEliU=;
 b=GH+wV6WKPau1glbJ0/kOPNiGs40cpXv86JEHbD2VD2Jl3r2aIr1NTdwEYU0PBxLuBe
 oj5lJqeWYUza0av05jLiQOt9yXnMfcnJ26EZdpyZmcCYgBdQpGJ9JrzonIDD7QRZ1bDG
 PiGg6Xk18Amyes8gVVQtu+LZ0GARGy8rzNTAKSuq6JmC1UpB32xatVP7UnUkZ2KcJuMX
 G+YmjGkkUIscy1M87PogBq/PignBScElwUU6rx1upccNww7pcaPI30dsk4xccxvnwTjZ
 SGbbl/i6fQM9zZt5hk1sGwSNmHNV8Pklql28djPLQyTNTwejpGDJVAZbkVqQzKFZ74rS
 ME3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688631470; x=1691223470;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6Q5l2LnRZZEGWmtGD3f+M9GWaSjANDfy9qt1iEnEliU=;
 b=AG/NkQr8o6OtLvaXEzQ7Smh/HyFTn0FV/UkcQ3gG9MhqLf4NdQ1+BZp0DRBpsQkwjv
 hdFUlMx1wNLhue9+/T8CHNH3FVHDfdaAXWMhBtXZzR/Vds+e6Vok4Wav14TReJ9iKvly
 8tbSU91kEtlLTP8GJKah97BBuJ2j64qkwG4U/hXvNon1nsNcka4Z01OnF8BYDykXnDSo
 gZ6tQg5DzZtAQHAjOD4kNGtLBOA9O91IOg6LgrSWN7Ya9ImOOMoSOBvhm5LI7Ug48wjM
 Ogf5BT8zoKLyEfIw4CrHfa7y1vsDM6SJ1+S0Tgr/uf6DJQLxeQ35RY0Rx8+2s459DTpB
 A/2A==
X-Gm-Message-State: ABy/qLYTkXoogYaXynBJaYa/jo1DOn2m920dgHcidlVFWpg1Y3ugbPgs
 2NS6lK0jD62ae/grSRenCdA/wq0RIflO0cK1R9E=
X-Google-Smtp-Source: APBJJlGERN94qzer2TEUomdnGqOiPp0e+emRKGj5HtWXOd8klizDp3m9nsosPC5j0jFe3RD9CMVImA==
X-Received: by 2002:a05:600c:213:b0:3fb:b3aa:1c8e with SMTP id
 19-20020a05600c021300b003fbb3aa1c8emr672661wmi.39.1688631470190; 
 Thu, 06 Jul 2023 01:17:50 -0700 (PDT)
Received: from [192.168.82.227] ([91.209.212.17])
 by smtp.gmail.com with ESMTPSA id
 t17-20020a7bc3d1000000b003fbaa2903f4sm1333247wmj.19.2023.07.06.01.17.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jul 2023 01:17:49 -0700 (PDT)
Message-ID: <bf23cf2a-a531-d36c-0a73-52cba0f82f0c@linaro.org>
Date: Thu, 6 Jul 2023 09:17:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 10/46] target/loongarch: Implement xvaddw/xvsubw
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
References: <20230630075904.45940-1-gaosong@loongson.cn>
 <20230630075904.45940-11-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230630075904.45940-11-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x332.google.com
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

On 6/30/23 08:58, Song Gao wrote:
> -    for (i = 0; i < LSX_LEN/BIT; i++) {                                  \
> +                                                                         \
> +    len = (simd_oprsz(v) == 16) ? LSX_LEN : LASX_LEN;                    \
> +    for (i = 0; i < len / BIT; i++) {                                    \

Similarly, use i < oprsz / (BIT / 8) in the loop.

> +    Vd->Q(0) = int128_sub(int128_make64(Vj->UD(0)),
> +                          int128_make64(Vk->UD(0)));
> +    if (simd_oprsz(v) == 32) {
> +        Vd->Q(1) = int128_sub(int128_make64(Vj->UD(2)),
> +                              int128_make64(Vk->UD(2)));
> +    }

And loop for these.


r~

