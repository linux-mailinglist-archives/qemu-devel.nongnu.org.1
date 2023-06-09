Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E08BC7297D1
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 13:07:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7Zwn-0004fu-Sq; Fri, 09 Jun 2023 07:06:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q7Zwh-0004f5-D7
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 07:06:19 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q7Zwe-0005xR-H1
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 07:06:19 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-4f6370ddd27so2009517e87.0
 for <qemu-devel@nongnu.org>; Fri, 09 Jun 2023 04:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686308774; x=1688900774;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0x5RkekOKaQzjq74QOJJSHShIn0DszZlo1yndNssGxA=;
 b=QCTxdq0q/Qj+vWiwGVoWQKyHg7sq3gRxK6fWXUljLmkP1kGs+Q1hmX5kPcA3WSN/L/
 31zj2Y28b8rwamuWNx5sK3Vel+QxciDwVxNvgRy8+uxajDi6P318gEEebyzdSOt2PlTm
 svmlWNHS1e2yxxCS4BBLD8gr0fmMqyhS4gHZKvec9aei2QLWGPQFFf4yzseAVGY2lpW2
 B5x7qMyPy2JwGdERW2Y4eQ+rX2b8QfUpxCrL5gOmkL8YlVM22GZ5kFx60BLBNkDvz5KJ
 C+BMYGrcbN/EPRHJsgk29s9o6hWNDQ48QEdbCPojf4vNZQV683KiXc8D+bnTFSPb6Qpc
 GJVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686308774; x=1688900774;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0x5RkekOKaQzjq74QOJJSHShIn0DszZlo1yndNssGxA=;
 b=GWHen4Rpy131VGmKqfIQj6Z5kyHKT7EPhmYLTGkBAaoiUftlbsHvm2Y9ss03vpPGrw
 HcroJ9glGG6OUGaKaDRQVgBNNrYQ6Tvv4ce3P1FXMxlsYSPhYz5bhxCczoDVnvZqb9QB
 pDg3Jxokl6xHGPDImT0IJFyXDS7zP/mSYljTZUFg5o6hbsj/Ejo0fWPfA0Hh7MaKEtIM
 HNctJfEwhfi0l1hdYT1ME72ftX9YnbU5Os+lFxn54oqbfFGB4tIcYgJf0LDIyRvPMC3X
 4JrVBy7f9BmQTf99kgE8D5of+N5EOKR7difoSijISYECHFxrX735HO5CrzOX6VAy5B6F
 0OfA==
X-Gm-Message-State: AC+VfDwMx4nyRC3DUmdPJylzrhecGk1OHUjPxW0Yb+Q8pWibHLuWlgec
 EYqnqxQmR5Y7Sq8ca7Q6IEfdD0q4tkSvV9OYJ/+uhw==
X-Google-Smtp-Source: ACHHUZ52GFoS/5Vlw5pKutC08bvDAv3ol4PhRC8s/qleFVRW1kLhWghjhN7TMjgro19BIBDkkSe3Ow==
X-Received: by 2002:ac2:4db2:0:b0:4f4:d83e:4140 with SMTP id
 h18-20020ac24db2000000b004f4d83e4140mr672628lfe.34.1686308774436; 
 Fri, 09 Jun 2023 04:06:14 -0700 (PDT)
Received: from [192.168.192.175] (23.171.88.92.rev.sfr.net. [92.88.171.23])
 by smtp.gmail.com with ESMTPSA id
 u26-20020a05600c211a00b003f42314832fsm2356751wml.18.2023.06.09.04.06.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jun 2023 04:06:14 -0700 (PDT)
Message-ID: <cbfc9573-736a-2f2b-9bd3-f69c7575b171@linaro.org>
Date: Fri, 9 Jun 2023 13:06:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH 08/22] target/arm/tcg: Extract iwmmxt code to
 translate-iwmmxt.c
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
References: <20230609104717.95555-1-philmd@linaro.org>
 <20230609104717.95555-9-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230609104717.95555-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12e.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 9/6/23 12:47, Philippe Mathieu-Daudé wrote:
> Extract 1300 lines from the big enough translate.c.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/tcg/translate-iwmmxt.c | 1334 +++++++++++++++++++++++++++++
>   target/arm/tcg/translate.c        | 1312 ----------------------------
>   target/arm/tcg/meson.build        |    1 +
>   3 files changed, 1335 insertions(+), 1312 deletions(-)
>   create mode 100644 target/arm/tcg/translate-iwmmxt.c
> 
> diff --git a/target/arm/tcg/translate-iwmmxt.c b/target/arm/tcg/translate-iwmmxt.c
> new file mode 100644
> index 0000000000..a054064c98
> --- /dev/null
> +++ b/target/arm/tcg/translate-iwmmxt.c
> @@ -0,0 +1,1334 @@
> +/*
> + * AArch64 SVE translation
> + *
> + * Copyright (c) 2018 Linaro, Ltd

Argh, wrong copy/paste!

> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2.1 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/licenses/>.
> + */


