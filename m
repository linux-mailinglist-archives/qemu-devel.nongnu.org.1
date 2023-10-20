Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDBC7D17E8
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 23:18:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtwqc-0007sR-8p; Fri, 20 Oct 2023 17:15:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtwqT-0007qv-Gr
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 17:15:54 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtwqP-0007pd-7J
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 17:15:48 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4083f61312eso10031935e9.3
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 14:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697836540; x=1698441340; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lfO0uvg9mKbsiC1XdY3w4ZdEsw/mojB8z1/BpJV8lHc=;
 b=Rb8yJp70V+YPwNqwMFKzFGdKYqnZLRtQX8ONNGm8ZUdSLqA2KhzHoxEEa7RQQJB1R6
 wVSZFuWS8a2xCCNL6ZLaCrHWrBJUdRq2QlVKk1tXR3qsYwpYnsxqkpIkvQDfhJL5pmBv
 VjyQuAIkms3wnhdQy5M30/bsyxjY4ejPHZ1Pyw8ix/T8Uk1Q+unW4z3QoLY5dGapB64p
 koGO3PksHM2vhuimxUTvfjoQCJv632kx5yz323PstLajWFBZFNhqf7ElEkQ07wQrObzG
 vnSUSqVNBbY/99DgqLLp093n1VK5g/tO8nMgviBHQ5LxP0f5z76hJH+JRI86ax0h+Ndd
 TrrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697836540; x=1698441340;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lfO0uvg9mKbsiC1XdY3w4ZdEsw/mojB8z1/BpJV8lHc=;
 b=e0h6AZ3JVi5ESxWmk3S6SF3rnK6PGd6Hkqw1SgpQGwFCYMQbKy7R4fZLHRBn+X1L9D
 EBY3cJO0jBgLzSql768EQzMAgPRyoLnajkhAXf2ePDXo+CN8Ct+Ir0wG+bxJY1YWs5uF
 M7JYnw++bX0UHf2dDRG99t5CYegYWrqhOS20RxVA9uFr8eHYsm1zAVn4szIMIhYUMs6H
 myyKbO7gBCN7cgdIXOCON9RLhL5tSjRfNPZUtBX7lDQ0UlywYBrU6RHFj6yr7i2RC4hj
 CZRY46PL34+ZKtoH2u8YzEOUswMWuF2R3jOOCh15u/rkuXTwemyDYjttl+28O2N+ckj5
 r0Iw==
X-Gm-Message-State: AOJu0YxEXa/iQo38XPY3kRnN8i9QcoQu17duXv4jfZwMKStQ1VNDsGqM
 EoisGlwWgheSUkyDCVgfMKZNQg==
X-Google-Smtp-Source: AGHT+IFVdOwUFlgto3W2p9viSWRQOsmilJwN7Ib2AxcBNWwhBKHyVnkNaYycJh+xxaaCIk45YC4d1w==
X-Received: by 2002:a05:600c:358e:b0:408:3a67:f6f5 with SMTP id
 p14-20020a05600c358e00b004083a67f6f5mr2504424wmq.18.1697836540506; 
 Fri, 20 Oct 2023 14:15:40 -0700 (PDT)
Received: from [192.168.69.115] (tbo33-h01-176-171-212-97.dsl.sta.abo.bbox.fr.
 [176.171.212.97]) by smtp.gmail.com with ESMTPSA id
 h17-20020a05600c499100b0040772138bb7sm7705840wmp.2.2023.10.20.14.15.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Oct 2023 14:15:40 -0700 (PDT)
Message-ID: <7773ae46-02b4-2dd2-d7e0-9ae1bd39489c@linaro.org>
Date: Fri, 20 Oct 2023 23:15:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2 05/65] target/hppa: Remove load_const
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: deller@gmx.de
References: <20231020204331.139847-1-richard.henderson@linaro.org>
 <20231020204331.139847-6-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231020204331.139847-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

On 20/10/23 22:42, Richard Henderson wrote:
> Replace with tcg_constant_reg.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/hppa/translate.c | 21 +++++++--------------
>   1 file changed, 7 insertions(+), 14 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


