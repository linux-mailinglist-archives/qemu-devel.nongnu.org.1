Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F35C2736DDE
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 15:50:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBbjJ-00060a-Am; Tue, 20 Jun 2023 09:49:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBbjH-00060L-Sw
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 09:49:07 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBbjG-0002ho-5t
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 09:49:07 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-51878f8e541so5597744a12.3
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 06:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687268944; x=1689860944;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=l9B1kbqvGKKBlTNv1dLqyYrMZXESaFeswbBEfhWYLe4=;
 b=cOGiNHMV1BXRskSGR6Km/Ys7YrqqrYpW/hEVAIhIZ6StlsFJSA6oUb7+0Z7YXn4T5D
 zxojC2Y1EP2M+fMGkllbz98xd01uT7wFdOFFHfn7hBcQQo+LF170y+dlaDjQ7lKUlvTP
 YEMBcFHb5Jwv4rxz1yQeKDLHMD7WXLDNNPHR1XuXZfX/LrGvwWXJiXg5rajMj/r/NZyq
 jRY0rSOotBzSfR3llSaVSl3BX2TKdCUC28DoVwHt7MgG+7XyHUnpUZMM/ptbIMSEqRLx
 dpaYqrVT9qp3Du/syQ69e32we8QBIutjM3kDXCwnz7SMSiuCtb80vvJOsaMA65Pk4qEE
 x8dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687268944; x=1689860944;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l9B1kbqvGKKBlTNv1dLqyYrMZXESaFeswbBEfhWYLe4=;
 b=EYjfj7H6lArdEaIFbyVmVs1B94DMh2QqOKudXB9ZVrlwgJMfDsirKtV2FFsP8dKUbc
 T5Rr68Sm7J468SalkO512Z3IfCTX480tup+B4Pktf0urJnRouUAri+e2G7HSjKK2zZQ7
 kAnlgcCcwIKJxIauaMJyrpILT2NO3PCI6ZqLiFW47A+Kdx2LtW+d4cjOVGIbkj/Kd9EQ
 LnKpVaGwd/3nuHdZKGBPiMnf3ylClrt8TdAkRM//cogzcCl97Mc1Uh0NjI4Qt3rvJUHi
 I5nhE1eq7rHhxfQ+7vuzRedTa6yYqvnskmr8uaxhP2/bv7OBhZILz1VgqvE6QeRY3tr6
 SlWQ==
X-Gm-Message-State: AC+VfDyP0wW95uoZXvhj9gXHvhssO/LCoBseCToWHjJrIE9k6ow4YwVA
 4jjK6AyPX/4+cpXqvdPVxVxUKZMj9GFFFoi8NxCG7L8w
X-Google-Smtp-Source: ACHHUZ535sXypMsvdbW8sfX4QDQctuyITtNCJ3Uz3Ogn83OqHdBkqEJ8P3HMsqdDhfAomjwc9om8Yw==
X-Received: by 2002:a17:907:805:b0:989:450:e57d with SMTP id
 wv5-20020a170907080500b009890450e57dmr2291735ejb.73.1687268944387; 
 Tue, 20 Jun 2023 06:49:04 -0700 (PDT)
Received: from [192.168.69.129] ([176.176.183.29])
 by smtp.gmail.com with ESMTPSA id
 c13-20020a170906340d00b0096a27dbb5b2sm1404762ejb.209.2023.06.20.06.49.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jun 2023 06:49:04 -0700 (PDT)
Message-ID: <650c6208-5827-2574-499f-0d450b277964@linaro.org>
Date: Tue, 20 Jun 2023 15:49:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] target/arm: Fix sve prediate store, 8 <= VQ <= 15
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Mark Rutland <mark.rutland@arm.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20230620134659.817559-1-richard.henderson@linaro.org>
In-Reply-To: <20230620134659.817559-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x532.google.com
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

On 6/20/23 15:46, Richard Henderson wrote:
> Brown bag time: store instead of load results in uninitialized temp.
> 
> Reported-by: Mark Rutland<mark.rutland@arm.com>
> Fixes: e6dd5e782be ("target/arm: Use tcg_gen_qemu_{ld, st}_i128 in gen_sve_{ld, st}r")
> Tested-by: Alex Bennée<alex.bennee@linaro.org>
> Signed-off-by: Richard Henderson<richard.henderson@linaro.org>
> ---
>   target/arm/tcg/translate-sve.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1704


r~

