Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D2079D8B3
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 20:34:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg8CK-00076H-1B; Tue, 12 Sep 2023 14:33:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qg8CH-00075D-1W
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 14:33:13 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qg8CE-0008W1-RO
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 14:33:12 -0400
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3a9f88b657eso4075778b6e.3
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 11:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694543589; x=1695148389; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Yvv5pAPF0Q8GYqhUkDSkOKeTg44fnBBhzsIBvY4GnEE=;
 b=dSomGGYK0s80f4hKkJzuPcxsl7N2mPOTm8QdIIHUIrhp0VjpcxtcElktVHAH1N9f0s
 obptY/E/f6aW21xdlLRDzMyLzzfXVvR2HjOpHA6QtrnrVvIkA5xiw9WCK+uHPxccxycY
 K0A1asihRQKe4M/rORXtAWpakbkpllNnI0YkCDeYWGhMiqE5B59NFByUL/vsWm9wiYC+
 Dfo8t23SA5IvlOHM7aWhQw6r8jOA5zyZjbA65hwBq/BYyRvtaRnzIlpxu79BloMU4W/p
 Ay6JJhsdIjz/5ZbGF51Mz9auIfSOdHO5AqdfnX1uQQ51SRkYa8mNosTVT9d2rCp9UmUL
 pEcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694543589; x=1695148389;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Yvv5pAPF0Q8GYqhUkDSkOKeTg44fnBBhzsIBvY4GnEE=;
 b=phFbmVUzX/VJ0Dt6KQ+djffbun4KwACjzM7SkMj94J6A4ZsLSTZF52FcsIORAvX+ij
 5RSzQtM/tzGlyo32cmpm9bUaFz+9UH7zKC2sGe/gvmxUVofbpoF9hIeO+fnw+wUtn/1D
 25Uo4Brt1WjX1i9LeVIKjc28VFwYVV9FYqJwIzFc9AN/iyjqO9Z2nDAD9rhA+KqAgP3b
 Omvw4+7McbbxsxIjAAq26BrBY8LY6C9zOJt+PFP354wlja8CBtc1lCrirzYLdy2i6aVl
 1IiXj13N+c20OEi+zJy7mV3VdyB7toV4JppSNpy/DzeKnwb6TLSvtoZS21OHZ/W1w7dY
 R6pQ==
X-Gm-Message-State: AOJu0YzxhFp8gjB8ONKWzJVcQKnNVE3DZLcmVvL5VB5fMsn2uoyU/uCI
 SxNDCCyaIYNMCHAk58S6ArygZg==
X-Google-Smtp-Source: AGHT+IERwdSlmKqU10n/tC0GBUEifnAGGRERMOwrK8u4sckTU3BJ2WljjyUHUv49sB0ddb64LDUxTg==
X-Received: by 2002:a05:6870:b61f:b0:1d5:426c:4c13 with SMTP id
 cm31-20020a056870b61f00b001d5426c4c13mr409493oab.14.1694543589483; 
 Tue, 12 Sep 2023 11:33:09 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 x5-20020a654145000000b00565e2ad12e5sm6542198pgp.91.2023.09.12.11.33.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Sep 2023 11:33:08 -0700 (PDT)
Message-ID: <e810b42c-83f7-1ea2-a106-25004f550e42@linaro.org>
Date: Tue, 12 Sep 2023 11:33:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 11/12] target/arm: Implement the CPY* instructions
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20230912140434.1333369-1-peter.maydell@linaro.org>
 <20230912140434.1333369-12-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230912140434.1333369-12-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x232.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 9/12/23 07:04, Peter Maydell wrote:
> The FEAT_MOPS CPY* instructions implement memory copies. These
> come in both "always forwards" (memcpy-style) and "overlap OK"
> (memmove-style) flavours.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
> v2: - separate helpers for the 'forwards' and 'move' variants
>      - fix cpyfp saturation limit
>      - cpyfm/cpyfp are always forwards, not based on Xn sign
> ---
>   target/arm/tcg/helper-a64.h    |   7 +
>   target/arm/tcg/a64.decode      |  14 +
>   target/arm/tcg/helper-a64.c    | 454 +++++++++++++++++++++++++++++++++
>   target/arm/tcg/translate-a64.c |  60 +++++
>   4 files changed, 535 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

