Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C711778CA2B
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 19:06:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb28m-0003z1-Eq; Tue, 29 Aug 2023 13:04:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb28X-0003o2-Aa
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 13:04:21 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb28R-0005LZ-V8
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 13:04:13 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-68bed2c786eso3220632b3a.0
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 10:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693328648; x=1693933448;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2C4kv/XC66CsYR3g7xIMxzmcYJIxg/OjU+sR3431jI0=;
 b=j/Rifg7MHfMsJEEO5QhDHdvy8TJ9i8qelkXH4kru3WgMQmCg3sCQDaFqUuBcf95D2G
 1dFgcpEks+WW2vYaPHH9evU7AUmpUi1iHwMoR8vFhYIH/R+HJ607wYX1jT0fplnNFLJD
 3zrG1lyeKnY7Q/OSyA5UJ8f24G3qGbVO8geohDOZ/dK8LMX+5s5Q5d95FpZ7gBwBAaGu
 Hr0wDiSmRdUQhvmh5JcXlgnW60CEIaodwhy0qhQWDjqeufSz5ECxUIzexvAU01de+tLy
 4jABkdKLtzFcVLQbjcGbf3m/p/8Gs2DpCl+oqLsjGD8kkPC3RzuP1qQ4VQBPM7+i9gjU
 dYeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693328648; x=1693933448;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2C4kv/XC66CsYR3g7xIMxzmcYJIxg/OjU+sR3431jI0=;
 b=lHIAZc3017AGssI8WGIfkvpPs6s1HszNloElg38XPC1kMxHk5G91Ce9rXFrt/YiFoz
 h82atw+Og2cyz2YtsHj5eCd5k07fcjpzhK2YNL+GY/X2Coferio3Y4ee+fBBXTSwZMJz
 v3/imuiv+lCD8uT49MJTn94CreuQIUfHRnOgqqJrQFbtDsg78QXbNZHhrDui8PA6PI2R
 eei2yQw8/GOHkxXQLv8ifCzEs3OWgjolMcYAMRzwSJdjqjSQCYQGf/HU1sCMMCzVu2+D
 zhkbGxLBiOohB5uDs6HEOli2F53xchEYVoXtVPrxNQW9OwlagKyXxInyGggiHSPpJjJn
 lzcQ==
X-Gm-Message-State: AOJu0YwyqNFLFYf1lGa+fR0RJfEQt7NzCBTtu2E6cTcrG639DCTQdrpO
 dpqq4iHl7Tf7jtdhKLvqBKRZJs/RCp29zSYCCAI=
X-Google-Smtp-Source: AGHT+IG0GrscatSQRy0FBBSBP5gEp2iQXHv/wqk7RNkgcruyAORHL8Cddh8ghufImTWiF84tR7D3Rw==
X-Received: by 2002:a05:6a20:1596:b0:115:5ed5:34d3 with SMTP id
 h22-20020a056a20159600b001155ed534d3mr28107554pzj.20.1693328648611; 
 Tue, 29 Aug 2023 10:04:08 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 s17-20020a62e711000000b00682b299b6besm8695113pfh.70.2023.08.29.10.04.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 10:04:08 -0700 (PDT)
Message-ID: <8158f004-e182-53cd-3da3-62a7144ae938@linaro.org>
Date: Tue, 29 Aug 2023 10:04:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 01/11] target/ppc/pmu: Include missing 'qemu/timer.h'
 header
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org
References: <20230828221314.18435-1-philmd@linaro.org>
 <20230828221314.18435-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230828221314.18435-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

On 8/28/23 15:13, Philippe Mathieu-Daudé wrote:
> Since commit c2eff582a3 ("target/ppc: PMU basic cycle count for
> pseries TCG") pmu_update_cycles() uses QEMU_CLOCK_VIRTUAL and
> calls qemu_clock_get_ns(), both defined in "qemu/timer.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/ppc/power8-pmu.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

