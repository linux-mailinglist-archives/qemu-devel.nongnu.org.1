Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D85672F3C6
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 06:51:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9ITE-0003dL-9I; Wed, 14 Jun 2023 00:51:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q9ITB-0003ce-S5
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 00:50:57 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q9ITA-0004b3-9W
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 00:50:57 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-977ed383b8aso51147266b.3
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 21:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686718255; x=1689310255;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8Um/xgeQuxuGNXtqB8e9y3KfPFMZe3y8+33yunBY00Q=;
 b=v761mmNflvbFnFSHBZlr1QSgoWs5Xg0ZQvnboJFlPKfG8z2vUw0lhB2weVPQwjvD6v
 0zCqQUqmsp2s2yIoBvT2Qr9UHn/EcIFT6qVLieDvIx8ULL7nQPQtOOMfzX9U1i3mdtw7
 qwE8HWq5nX2mLii8bgoGF39SYF7SBls1OEYv6oJwz6MoGB3KaKdpg2nQUSLD9RehzWwp
 olMom3AKVwTvJcfYeZIQbbjpNc8n5QAPTipB4APXwiY1nFXHKx2EQgCGTLM9++IWdYHv
 KaUX+H97Mj7jPYtbK1BA2i67zFT6tvpjFPIPc0Cvm8Dp0pfcNtqC3hlKYW0T2E3sYkXi
 E5FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686718255; x=1689310255;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8Um/xgeQuxuGNXtqB8e9y3KfPFMZe3y8+33yunBY00Q=;
 b=dt+7DWzPc0EjBgYmyxa8HbpY7/KU46M8MJ7g2luZyUoK9WJG3w7K88lDXtTS+c4+JV
 mvcv6i7/HL9Cjx87pqTfoamx88BM6A2NglOpDGdHJ4xBFmqGySHzKI3fGclatXorz6is
 Jb/I9njm4mbOm7GB61WeTLP21XS/aYPMkvSiMjkWPrefluvviFWupfGEr44P9jiBTYfT
 93vdaFaAs8fqDerVKaro8hzfqJevUNt1yQ6Gn1XOY2raiHmz+WIpcXPHm3oC2QrjvxMC
 JjiE3ZuDOlxJkRYrcQgC2BcQ6Cc1KL13JXuVOT+pyXY+mTWNKVAgpXiVzQo001jzZOcl
 5PFQ==
X-Gm-Message-State: AC+VfDx6cxORtdaCleHwKZ3GZ1ue+RCSN0q2muGMv8n0jljlunN8wlzF
 xckVuAB5/bInaFIuMnN8voHhJQ==
X-Google-Smtp-Source: ACHHUZ5sbzu97+nHHMFeYnjAfh7xmnSn14Wwz2GdTOAZvvUnSri01U7P+irp4yHh836+zXKd6vLpsg==
X-Received: by 2002:a17:906:fd86:b0:977:ecff:3367 with SMTP id
 xa6-20020a170906fd8600b00977ecff3367mr14569634ejb.40.1686718254914; 
 Tue, 13 Jun 2023 21:50:54 -0700 (PDT)
Received: from [192.168.4.112] (90-182-62-66.rcp.o2.cz. [90.182.62.66])
 by smtp.gmail.com with ESMTPSA id
 y14-20020a5d620e000000b0030ae4350212sm17103849wru.66.2023.06.13.21.50.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jun 2023 21:50:54 -0700 (PDT)
Message-ID: <4d9a7f20-cbf9-7e89-36f0-f2360eed4744@linaro.org>
Date: Wed, 14 Jun 2023 06:50:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 18/26] target/arm/tcg: Reduce 'helper-sme.h.inc'
 inclusion
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20230611085846.21415-1-philmd@linaro.org>
 <20230611085846.21415-19-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230611085846.21415-19-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.098,
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

On 6/11/23 10:58, Philippe Mathieu-Daudé wrote:
> Instead of including helper-sme.h.inc via helper.h which
> is included by all TCG files, restrict it to the few files
> that require it.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/arm/helper.h            | 1 -
>   target/arm/tcg/sme_helper.c    | 5 ++++-
>   target/arm/tcg/translate-a64.c | 4 ++++
>   target/arm/tcg/translate-sme.c | 6 ++++++
>   4 files changed, 14 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

