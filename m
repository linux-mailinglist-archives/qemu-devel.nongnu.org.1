Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11838722401
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 12:57:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q67tf-0002Z9-E6; Mon, 05 Jun 2023 06:57:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q67tO-0002Oa-2E
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 06:56:58 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q67tH-0000mN-Ba
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 06:56:48 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3f7378a75c0so10397795e9.3
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 03:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685962606; x=1688554606;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sfSRa+WNT/kJAeeJJ5oEfzQAWbL/IrLu0RyAJXDy1sI=;
 b=CGosapgDXIzh9JfIlEkr/1ZtRhnVTCGEqkQmZVyxEnA7CZdxKGQQ/o63Xzu58Tqc1R
 TLz+8ycV6yjB/gUXYRS7S+YF9bryzhnM4DrOTRFOKkmIrM6elqE8qn+BI4qp1FjZfUf0
 B9KE0TIjKkgX11dnUJK7Yn4l42TCJHOpmftYTEF/r3+Tcf3zgFg+XscZezMtVQZl62pM
 lKbh5KEB/wYgZ9rujt+LcGLJC/jWOdW1MNgK/VvE/bEegrW0l7WryhYICuBRYRpMUHUr
 AJHsN0lqDHXMCL3yA+oP13NaUJnormMJ2zYFkMasFrGtyxPEE62ADSqOMOEKQ4ecO4+u
 lPAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685962606; x=1688554606;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sfSRa+WNT/kJAeeJJ5oEfzQAWbL/IrLu0RyAJXDy1sI=;
 b=gr03zcgY6lZuz7gXN7Dvu942cpZqC27ve1yIvg/X1/hp+iWDJoTJUFzJ5LNbZU89nP
 Kp+HMnDuEhYQ9vrUxGYNWBuqEZ63qua5h1x9UnZ1MYt78YyumOMJUfc6QDoQonQWg1sg
 XbEQBvBbyxOxw0zVVQtOBBGUP9iwwRNk+uFB5Y4Cwgb2dx3suGqHZtbRiQXPVOUJMxKT
 fdIV0Oovngx92xyAMrzagyIEK0RtPP2Xp/y3XrZfckb8PV/P68H6EAHzIUUsqEeh+RHx
 0ZOqBT2noLVn/ddGImB+z0um2vYltgjJO+X8KnF4XZxDohgDF6EGBzxS+btXrEGRFfLS
 zJgA==
X-Gm-Message-State: AC+VfDxU7ML+vWlVlQMg/UGOQ+mA83CKmcw9jFrEXe4pWSk6uIgTDLaK
 WmleNCLWCuvlBfCrWWITROMsC6k0CZ7ql50iOvA=
X-Google-Smtp-Source: ACHHUZ5irskyLPOXKNKtLsnT1bTigctYgqZ97Mpsg4opANij5CiR1Bw4UxpGSyTeoEZqMnuj5fc/RQ==
X-Received: by 2002:a05:600c:ad5:b0:3f4:23d4:e48 with SMTP id
 c21-20020a05600c0ad500b003f423d40e48mr5748978wmr.23.1685962605789; 
 Mon, 05 Jun 2023 03:56:45 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.217.157])
 by smtp.gmail.com with ESMTPSA id
 y20-20020a05600c365400b003f60fb2addbsm14008141wmq.44.2023.06.05.03.56.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jun 2023 03:56:45 -0700 (PDT)
Message-ID: <1f1f8b26-c0c9-f33d-507c-4399e3be13a8@linaro.org>
Date: Mon, 5 Jun 2023 12:56:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH 06/35] target/arm: Demultiplex AESE and AESMC
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: ardb@kernel.org, berrange@redhat.com, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com
References: <20230603023426.1064431-1-richard.henderson@linaro.org>
 <20230603023426.1064431-7-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230603023426.1064431-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 3/6/23 04:33, Richard Henderson wrote:
> Split these helpers so that we are not passing 'decrypt'
> within the simd descriptor.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/helper.h             |  2 ++
>   target/arm/tcg/sve.decode       |  4 ++--
>   target/arm/tcg/crypto_helper.c  | 37 +++++++++++++++++++++++----------
>   target/arm/tcg/translate-a64.c  | 13 ++++--------
>   target/arm/tcg/translate-neon.c |  4 ++--
>   target/arm/tcg/translate-sve.c  |  8 ++++---
>   6 files changed, 41 insertions(+), 27 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


