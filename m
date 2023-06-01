Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 04772719AC7
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 13:14:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4gFw-00070N-TI; Thu, 01 Jun 2023 07:14:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4gFr-0006zg-R5
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 07:14:08 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4gFm-0007rj-W2
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 07:14:04 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2af177f12d1so9870161fa.0
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 04:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685618040; x=1688210040;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xoMrYcj+6HQPghKiLIeu7iaUB/mGHNS2Kp1bQXB+iw0=;
 b=Z88YXOehdR6ueDjHzFtYbafm75AVRB+000Q70+mDep9tT7nxIDJfWEANAnmQ2BIvR8
 yewShj3l2Na5/aXmHGVZDRpOmxdwBNGs8iGr8KKfr39tbui78Pu/LYb9/x+k3UteZgST
 dPATuR/ZcKaP36uS5LC2b4W6jjehUEH3Az8l5mDOsCYeT8lruTEch8gUk/b7jZ6VjB1i
 2KuAEHXGGGtTNU8pvJ5J7bDhNJnHyXLYF/qYQZT10kUJS8UXDwF3JR+OB9ie7B/+Rxsm
 Cr1If+VBIWqCUMWEIIsXtXgJ3N5yTHrnGdZuAScr/3774sOiCd0pFHo4eeglLVNZpwvl
 hHbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685618040; x=1688210040;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xoMrYcj+6HQPghKiLIeu7iaUB/mGHNS2Kp1bQXB+iw0=;
 b=AlspJH7cjsfY4/X2oF2cevsmpzjeMpww72wt3QtrkZmiw9VKPGDFmqb0Cu3o4sEaM+
 zXdBuAY+7/Ouoqs10OQHdfCNBD1lPqo4yR30hGv9Zlega+80ylV9D7Seqzy0W2e3rFXV
 gVXjLNQpyzp9h2pKJLOkEa/lMk3llp26i71n4JquBMdV1dvgYgZU3Rnq+WsjbgqsGmKt
 +9Ttr+s+EzvCkYNTDwP1rHlzJl1H9RiIWUVBe+pV38YRJo83yaUOGQ32t90Ps5nosMrN
 vHU5/sTp36EmqiLBXuSdNWpqJrL6fqdmczmGO781HSbcdJQjvtowFmH2+x3U3yLDYN5u
 TArA==
X-Gm-Message-State: AC+VfDwnsH8l0acsCMXP9r5cEv+NQZOneiRMTvz6cw5XMqusWYJEnTQ4
 HurnxuBxY5WaXyIrLFV6tSJNJhHwqzXjNp89AVM=
X-Google-Smtp-Source: ACHHUZ6adPwxubRxZWycr6TMGYDExn8OSCsxe1K5mcGnQjJJiAvHbj+F0RQADyYSrFAaR04EJ7Mf9Q==
X-Received: by 2002:a2e:9d0e:0:b0:2ac:8283:b67d with SMTP id
 t14-20020a2e9d0e000000b002ac8283b67dmr4214515lji.25.1685618040661; 
 Thu, 01 Jun 2023 04:14:00 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.141.224])
 by smtp.gmail.com with ESMTPSA id
 d24-20020a1c7318000000b003f6129d2e30sm2048450wmb.1.2023.06.01.04.13.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Jun 2023 04:14:00 -0700 (PDT)
Message-ID: <00c96866-7578-3131-1e8e-6f421d0d744e@linaro.org>
Date: Thu, 1 Jun 2023 13:13:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v3 14/48] tcg: Move TCGv, dup_const_tl definitions to
 tcg-op.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230531040330.8950-1-richard.henderson@linaro.org>
 <20230531040330.8950-15-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230531040330.8950-15-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.1,
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

On 31/5/23 06:02, Richard Henderson wrote:
> These two items are the last uses of TARGET_LONG_BITS within tcg.h,
> and are more in common with the other "_tl" definitions within that file.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-op.h        | 15 ++++++++++++++-
>   include/tcg/tcg.h           | 19 -------------------
>   target/mips/tcg/translate.h |  1 +
>   3 files changed, 15 insertions(+), 20 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



