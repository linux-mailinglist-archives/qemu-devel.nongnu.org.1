Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D60A17839CB
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 08:16:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYKew-0004JT-So; Tue, 22 Aug 2023 02:14:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYKet-0004IU-Rr
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 02:14:31 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYKer-00065Z-CE
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 02:14:31 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-319e93a1594so3818028f8f.1
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 23:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692684867; x=1693289667;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wXF5QAlK0X9QheMsGZTjavxIg0XP+RjETdA05u48G5M=;
 b=mqeHKfw6aueacl1JADmnFlUD1yG4ZXHqtiIIY9onvtns2jq8glgXWJ4Kj72L6iBqFS
 9CuSRPPzcr8F5xwGaP1cp00xsyuFasI9qSM6nd+5MoDtmoPfEpkTsFcfqqTdcyfAC1pc
 /sFTpqAlw5zZPWH1UnIHm5nROkSBlTnogzF+nY8fIDWRbIqs2S5VIyM4lYm+XHLm18nS
 vwwq/lTTZU92f91qdbBzRh/hPhaxH9LH0UXDbb2cPrM4XMj0on64+85wTS0Jt3npS/ra
 v+atbfQ7chvf6IIA8NvKQZlBB7ATt2GPftsgtJaFVUspdmnmYWeD09CcjFBG67TlgfwL
 GyPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692684867; x=1693289667;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wXF5QAlK0X9QheMsGZTjavxIg0XP+RjETdA05u48G5M=;
 b=NJL78AkMoscgmgzPRBzkbywQwjyLPjmcd8iggLOg+nOPE3+XSgd7HVsBbpX/tRpY6S
 +hNz0Rt6V1VoGtwfwz0MvMbw1vCvkFhyxjdq5qjZh80IIu/P9PGwI8N+1RtFdErjMFKP
 y0Foryrr8agN2uVIFPP3FQ5odFcaqCl4wNLhPyycL5BpYiFoTwQwIP5qGA/k7XI8pEI1
 7EwOCW0qGXK+4siP0SgLTf7R0M8kusd5pLe19w+38RdL6rSpeAZspDgJTM2aHShbvNMF
 oIR6Z7vc/GhEsZJi5yNhWqiK3nBOwPduyyjNhRs3e5t7L3tOkpYHs7y89tVw2tjRkFu2
 bgVA==
X-Gm-Message-State: AOJu0YzmgiotWyGqNLGTO01DsIaghQ7gMM0M2TxImr3HX0crWwYJtsZf
 guQRrSMWNACiRvxhjr0iNHdkgA==
X-Google-Smtp-Source: AGHT+IH/jmYJOR9zQrXTVOn6uH/FU6Z+GM8ZBLMl4QpBGJmlaXyd6EKBe/CSsNzgo4GiJT2LIgK2ew==
X-Received: by 2002:adf:e990:0:b0:319:6d8a:75f8 with SMTP id
 h16-20020adfe990000000b003196d8a75f8mr7071791wrm.44.1692684867462; 
 Mon, 21 Aug 2023 23:14:27 -0700 (PDT)
Received: from [10.2.0.2] ([37.19.214.4]) by smtp.gmail.com with ESMTPSA id
 q16-20020a05600000d000b0031c56218984sm4840182wrx.104.2023.08.21.23.14.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Aug 2023 23:14:27 -0700 (PDT)
Message-ID: <b7f3d93a-03ce-87ce-000e-35cf8667233d@linaro.org>
Date: Tue, 22 Aug 2023 08:14:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v4 2/9] target/arm: Add ID_AA64ISAR2_EL1
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Aaron Lindsay <aaron@os.amperecomputing.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20230822042530.1026751-1-richard.henderson@linaro.org>
 <20230822042530.1026751-3-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230822042530.1026751-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -54
X-Spam_score: -5.5
X-Spam_bar: -----
X-Spam_report: (-5.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.374,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 22/8/23 06:25, Richard Henderson wrote:
> From: Aaron Lindsay <aaron@os.amperecomputing.com>
> 
> Signed-off-by: Aaron Lindsay <aaron@os.amperecomputing.com>
> [PMM: drop the HVF part of the patch and just comment that
>   we need to do something when the register appears in that API]
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/cpu.h     | 1 +
>   target/arm/helper.c  | 4 ++--
>   target/arm/hvf/hvf.c | 1 +
>   target/arm/kvm64.c   | 2 ++
>   4 files changed, 6 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


