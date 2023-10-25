Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3151F7D78A3
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 01:36:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvnPz-0003iM-U0; Wed, 25 Oct 2023 19:36:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvnPv-0003a0-BH
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 19:36:04 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvnPq-0007Oc-Gw
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 19:36:03 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-27e0c1222d1so214459a91.0
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 16:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698276957; x=1698881757; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xfHbIuIE65s6lXL7VEVSAZ6Re7Ym0Jcxl+hqAzCqwEc=;
 b=gCQk84rIFdYZsMM9TkISZuHekzUu4FzoOf1Oz/gNo5AbXGkHYkNzq9BX1MdB6lJIIz
 Gd2fMUSnpnqPY7d5xFeHlO9YcmB8EbP/wFjF2n5vEVF1/TcKhfY5JKQp+7hAFxLD3Api
 1XVQXGnzT111fm0gla8b32ZbnBu0zOGH4w+bTtikRBAGpDiXN4J7gsgOeb18maUzUvAY
 jMIKOQXqL9ZiXZECqlSuJEZLCpUdPjwJsmVlHsnhbQGMOVvhV+0xOnoGVAvSHpDAXF/T
 m+1r0otOfG/wioC/FDcVHO3nIACs1vpptbb77XWERmhXbd3mhFDMRYSf2AWo4rdKh9Jz
 Jyew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698276957; x=1698881757;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xfHbIuIE65s6lXL7VEVSAZ6Re7Ym0Jcxl+hqAzCqwEc=;
 b=pj2sDQzSla2PViXBhHWZ9wc2hT2simsYXKBz8Is8DePiA5MQRy6x0WUSgsMeqI67r7
 gHdot70U0K0DN0r9KVXLKoBYS6t82RbCEfmcWT/ZadAY/efH0hx3fJv6jPTUs03fu4kp
 eb/qhlNEdA972af0OtgKd4Wwlymr4FXbqb/KWOWUaV32i0CxQIqWQa5rE8RBhax3oOtJ
 4TQAkvbtd9plfVdvpIVkW6ZWaG2poZkOgns1y+U4nOcG2czPNqkR/9tzt1w3fMpYUxle
 d/lb6e3LJwaO2D7Rsg2g8J5Ubhs+kVzPwIlqn8IGdhy3kteW6aqjXJDHS5L1UIPAHxJS
 OI8w==
X-Gm-Message-State: AOJu0Yw9DSqmTzUlNJduvmr0xzsej9UvZJziwlcz/WhAeQHs6/Q1JABw
 d3NBBE3X+qsymZVOyjcoH1h9qH4TVbYsNJgZwjU=
X-Google-Smtp-Source: AGHT+IENLJMR0jrbbvEgiE00z+URJvHWyEQ0YySfyK9gDAwz8BnSCvOg5OHqwy3MBQ2L9mTVHyxc5w==
X-Received: by 2002:a17:90b:4a8f:b0:27d:b885:17f2 with SMTP id
 lp15-20020a17090b4a8f00b0027db88517f2mr13440817pjb.30.1698276957093; 
 Wed, 25 Oct 2023 16:35:57 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 w5-20020a17090a6b8500b00277371fd346sm475304pjj.30.2023.10.25.16.35.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Oct 2023 16:35:56 -0700 (PDT)
Message-ID: <155d6f56-ebcf-4dba-81e6-23cd182fe517@linaro.org>
Date: Wed, 25 Oct 2023 16:35:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] target/arm: Move ID_AA64ISAR* test functions together
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20231024163510.2972081-1-peter.maydell@linaro.org>
 <20231024163510.2972081-5-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231024163510.2972081-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 10/24/23 09:35, Peter Maydell wrote:
> Move the feature test functions that test ID_AA64ISAR* fields
> together.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/cpu-features.h | 70 +++++++++++++++++++--------------------
>   1 file changed, 35 insertions(+), 35 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

