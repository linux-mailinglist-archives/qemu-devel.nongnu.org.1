Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C1FCF736909
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 12:20:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBYTC-0006Qb-4g; Tue, 20 Jun 2023 06:20:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBYT7-0006Ps-Kn
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 06:20:13 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBYT5-0008Nm-M7
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 06:20:12 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-51878f8e541so5310166a12.3
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 03:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687256410; x=1689848410;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cZ4Lf7PYLzHFbYI/Bcp8whIN6D9flP1VF3TTHkr7mJM=;
 b=dQ3mijDBRU7WQa3rn1ol0yKk0u1tTKwT/RS3nQC3Ur4dVVzCzGRuVoaFbcVzfXo7N2
 4tZq7sku2Su5Ni9zOG5pu6tVW7w3YLnjer5fNeImdHytB3ED8Z50oux5KgAJYKhQArvV
 U5jQIXO0sjPvXcYKkiwa2/eOxFnwHv/KnMGUTC5VI+g+F9W/A2STj81Rn/c53Fy4GRxP
 HJqdm/MiCYXfDmgYES8KdoNZ7dmdnlFW8l0nwNeIaTHP7IGlGufJBWLsCGfuDw/asezz
 ulsv8zFjzPgiBr1oFJr+bEGFKFrTs3zhHGo2iJCsWvvXu1Zby+HoFDrlp8EcJWQIP7rp
 IeMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687256410; x=1689848410;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cZ4Lf7PYLzHFbYI/Bcp8whIN6D9flP1VF3TTHkr7mJM=;
 b=CP8etgXcXMVlgpPrEXnezzzPpJ2OoYRr7+UsZgtXgKlibPn6M9WhuQWn4HNPBEjgI+
 k/ecDy4HuJTrs2F+5WutQRwrHsA45Q96yp2ZLa5Iicwm0dCHJJHUse4cRpW7l0xWwyzC
 PsDcHSbl8CO7Di6isWJS5ItsjboITFIEuAcfrJ7pOHmwpTbEogWW6ALc2qeYjG7Kx7Zy
 SsHYOLHNsswFJhJe7mOZitsq93zcZY4ZvtY5t3xm1KY2IxHDXJ+4aBYe33d392cPYwAo
 McQsl5ud4DifxqJSgAMQpV9JfIdx+Z1UdhO7e47YAUerW2O9F+mGcsjOfQlgFtuNENBI
 UwCQ==
X-Gm-Message-State: AC+VfDwJb6HWfWJC0EA39ZEXk5nxS97psX3184Ch3akcaFx5+ZLuODpX
 4I5T2YZ17i/brORGLz0H0TCT7A==
X-Google-Smtp-Source: ACHHUZ5vQNLtEGLPvzEEvmAAy8S762g9r0OLK22KtzJciozH8/RgcbSVXmeN/rkJ6NuAuXvcOlOMFg==
X-Received: by 2002:a05:6402:2cd:b0:51a:2d8a:a656 with SMTP id
 b13-20020a05640202cd00b0051a2d8aa656mr7803728edx.27.1687256410023; 
 Tue, 20 Jun 2023 03:20:10 -0700 (PDT)
Received: from [192.168.69.129] ([176.176.183.29])
 by smtp.gmail.com with ESMTPSA id
 c8-20020aa7c748000000b0050bc4eb9846sm933288eds.1.2023.06.20.03.20.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jun 2023 03:20:09 -0700 (PDT)
Message-ID: <ae1120d9-6ce1-13de-3a7d-90f8b2f4a215@linaro.org>
Date: Tue, 20 Jun 2023 12:20:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 09/34] target/arm/tcg: Move VFP helpers from
 helper-a64.c to vfp_helper.c
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20230619154302.80350-1-philmd@linaro.org>
 <20230619154302.80350-10-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230619154302.80350-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x52f.google.com
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

On 6/19/23 17:42, Philippe Mathieu-Daudé wrote:
> Keep the VFP helpers in the same file, guarding them with #ifdef'ry.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/arm/tcg/helper-a64.c | 87 ----------------------------------
>   target/arm/vfp_helper.c     | 93 ++++++++++++++++++++++++++++++++++++-
>   2 files changed, 92 insertions(+), 88 deletions(-)

I'm not keen on this.  First, because we have not yet disentangled vfp_helper.c from the 
bits required by KVM, so to move the rest into tcg/.  Second because large ifdef blocks 
are a sign that something wants splitting anyway.

Perhaps tcg/vfp_a64_helper.c?  There's probably a better name we could use...


r~

