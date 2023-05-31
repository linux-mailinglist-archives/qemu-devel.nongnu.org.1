Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8191571761B
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 07:24:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4EKB-00088R-0Z; Wed, 31 May 2023 01:24:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4EK8-00088F-N6
 for qemu-devel@nongnu.org; Wed, 31 May 2023 01:24:41 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4EK7-0005Ak-4i
 for qemu-devel@nongnu.org; Wed, 31 May 2023 01:24:40 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-30ae967ef74so2433742f8f.0
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 22:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685510677; x=1688102677;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=P059wGGnT7wLhTiMBIu155tEUjT4NKvJpwTY3hvR9GM=;
 b=Fu1zimRphUry/RxZ3z/NSX9yIFqiWPOnyrfVtLZQNZ/sS2KMSREbIZvRSm7T6rs3L9
 MJmb7JtQCUwnO1BkQ3okdWINVRM/CmvNmhfQaD7vhgxlWlDF48Ezxzf7aQWpn0r+0XuY
 SYmAG2DOvvO8/IBPsLNRuukrAQ9yjc2hCgYRfWfBw112LaM6vp/yMvVSAb4bcXrebA53
 orzuKLSZwWjaUvanv9jpmuHlitxGlq8q453zxg33CW3jfDe+qdMLGEjuhzA/cen9BqID
 qNatwoBSWXEsRC0T3bL0RP7XWj35tW15rUAkWHi7LpMDVEbRM5PfiVBa1Vhncgu7kYTa
 TAGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685510677; x=1688102677;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P059wGGnT7wLhTiMBIu155tEUjT4NKvJpwTY3hvR9GM=;
 b=Vcag9cNHEswLFOytKmCkEaIdfOU0yAQy4IFxbNvp9sUpijR5cDafqVDzEhkE01yqw7
 wsPgq5Hc5srJMDInNdPQLhg61HCjwER/BFn2SQoq9nFhhP3jW6fEl7f6TfKkp4GtTHVl
 gT9zi410NoWISyFbi6cBqHfuSugzf7Y+EHS/zaDY+eg+2sUQV1QYLffnqF0HDba/LD+k
 eeHWOHFHlxoj/ClkDcixVPt1esDc8q/C1dNNY9BSSl121oTP6507tF6fj3lv9/lpwPah
 IuslR4VHkwZj/OdZ9rV92y0/hY5k195rFq/e/yfIdPrlt+2Y904B4qHMwuAutdIF/c5k
 HVEg==
X-Gm-Message-State: AC+VfDweeEHDDG+uIv9nwziEdjmb9THOFzVVs3B5YvZ/3sFgi8o9VJd3
 UAF5zkbovrt0v8vWwxxcb6O9/g==
X-Google-Smtp-Source: ACHHUZ7jZkhj2NJlFpZyxfcseedyhP3VoS6j4NikjKfka0+so1IJpKZSoviC7lenLC7QGAVvY0xnKA==
X-Received: by 2002:a5d:5448:0:b0:30a:93ad:ab9f with SMTP id
 w8-20020a5d5448000000b0030a93adab9fmr2729926wrv.11.1685510677215; 
 Tue, 30 May 2023 22:24:37 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.146.12])
 by smtp.gmail.com with ESMTPSA id
 o11-20020a5d670b000000b0030ada01ca78sm5303647wru.10.2023.05.30.22.24.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 22:24:36 -0700 (PDT)
Message-ID: <1ba88677-8a43-c708-ea53-bf0db51d461c@linaro.org>
Date: Wed, 31 May 2023 07:24:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v3 38/48] target/mips: Tidy helpers for translation
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230531040330.8950-1-richard.henderson@linaro.org>
 <20230531040330.8950-39-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230531040330.8950-39-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 31/5/23 06:03, Richard Henderson wrote:
> Move most includes from *translate*.c to translate.h, ensuring
> that we get the ordering correct.  Ensure cpu.h is first.
> Use disas/disas.h instead of exec/log.h.
> Drop otherwise unused includes.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/mips/tcg/translate.h            |  6 ++++--
>   target/mips/tcg/msa_translate.c        |  3 ---
>   target/mips/tcg/mxu_translate.c        |  2 --
>   target/mips/tcg/octeon_translate.c     |  4 +---
>   target/mips/tcg/rel6_translate.c       |  2 --
>   target/mips/tcg/translate.c            | 18 ++++++------------
>   target/mips/tcg/translate_addr_const.c |  1 -
>   target/mips/tcg/tx79_translate.c       |  4 +---
>   target/mips/tcg/vr54xx_translate.c     |  3 ---
>   9 files changed, 12 insertions(+), 31 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


