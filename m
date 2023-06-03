Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A5A7213C3
	for <lists+qemu-devel@lfdr.de>; Sun,  4 Jun 2023 01:20:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5aWe-0001Xx-Ec; Sat, 03 Jun 2023 19:19:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5aWc-0001XN-Mc
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 19:19:10 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5aWb-0007v2-7F
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 19:19:10 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-65540715b4bso227986b3a.0
 for <qemu-devel@nongnu.org>; Sat, 03 Jun 2023 16:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685834348; x=1688426348;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SBKJN6M0puF5S/I8Ke6O+y6jITI4KoCp2yj9arzwVE8=;
 b=VO4JzfOMNrUVGdt+V+SMK4JDi9BF24npjtLlBg9XihvXp3Y46HMkGg/2141Osvw8HD
 0K2L36e4mCmT9qVQS7BLd+CokCn6rXuz6c5zmSwZim2ZeNVbAkXXCGNAtwp9oAM0CDOV
 UHjxrhmAjPHtNq69s5769L9AVu1t8jUNdXPEguRY2XeLDZwuL7CjoHK+w9ENz9P04/TR
 e//CwjTuq2fw/8o8xYivz/41oZw0uWTagpYuIJg8mNj+cY62OCAoKWdNHsL5Fdpnb7n0
 moS3lkjX9QA7u80vhXk0djWzr0ZekJtaVjqJ8mBhiKnT5Z7OkN7AvAixCTbLKLWFDYpi
 7MPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685834348; x=1688426348;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SBKJN6M0puF5S/I8Ke6O+y6jITI4KoCp2yj9arzwVE8=;
 b=JskcNiMXNwmIq8OQVY04/zltljEPg9dLTbncOofSLOwGo9VZF7EU5fZk5VzNZZbIzI
 54qmEaYv9THh9gIN5m3T2QQI6InVDREa0mmV/sL+aXL73grYZ0boeh6Lnw1GjHi8hjP8
 LPdFqBgij82/uRkAjEv0Ryo/gE3WhMOoQhAuRHFn03OzOYQH2g5eLABfilm8BjllQKpi
 KxjaTva2BKXHWhMv9ytYgJ/LBgeMYSpsx3zK6LZfUeoQxgcoBog8pSvrqBim7M18emJA
 E1uOg9D72iHHjgmcai+esShz2gauGbTeG6eAtPwvqg8pffAy7TofG2k54Zvr2alu9+Qj
 01NA==
X-Gm-Message-State: AC+VfDzuFNo+2s0B1t5l5Fi3bSbodacEqgPF2HB1rCjOOYrk+emsnpuC
 jWKJpxcF6faLzkJ8wfYD8GizdQ==
X-Google-Smtp-Source: ACHHUZ7LwW8TkSUdUE7/GyF3Xz/RpSvLxoZ5OcwrsvOzYp/eCo4X8q1iYCfFR+tP0MCzgN8KhzaMdA==
X-Received: by 2002:a17:902:7284:b0:1aa:e938:3ddf with SMTP id
 d4-20020a170902728400b001aae9383ddfmr1495785pll.7.1685834347700; 
 Sat, 03 Jun 2023 16:19:07 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:9a37:84b6:b3f0:f301?
 ([2602:ae:1598:4c01:9a37:84b6:b3f0:f301])
 by smtp.gmail.com with ESMTPSA id
 e11-20020a170902b78b00b001afa7040a70sm3671353pls.276.2023.06.03.16.19.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Jun 2023 16:19:07 -0700 (PDT)
Message-ID: <171feaae-4442-e600-0a25-d53e639bed46@linaro.org>
Date: Sat, 3 Jun 2023 16:19:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 13/20] target/arm: Convert LDR/STR with 12-bit immediate
 to decodetree
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20230602155223.2040685-1-peter.maydell@linaro.org>
 <20230602155223.2040685-14-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230602155223.2040685-14-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
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

On 6/2/23 08:52, Peter Maydell wrote:
> Convert the LDR and STR instructions which use a 12-bit immediate
> offset to decodetree. We can reuse the existing LDR and STR
> trans functions for these.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/a64.decode      |  25 ++++++++
>   target/arm/tcg/translate-a64.c | 103 +++++----------------------------
>   2 files changed, 41 insertions(+), 87 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

