Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE62B72F3BB
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 06:48:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9IPw-00007B-S3; Wed, 14 Jun 2023 00:47:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q9IPu-00006g-JM
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 00:47:34 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q9IPs-0003xu-Vc
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 00:47:34 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-4f74cda5f1dso3444981e87.3
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 21:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686718051; x=1689310051;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KqoUXPLuldR0Nd43PgiNDbfsNDpw/LBh71A0E0Gu/IA=;
 b=WGl/x5R3F6jTOQPX2GhGtFArCCh9SS13lx+3DyGyfrWtJkmx5rbaAm3VPALXd+Kkdl
 9PgI5bx1hsd1jJjna6mDDRlNGANXBbqEzgrkwqsH9LWbRvIaRvvobqAji/Zo5xrxRG2s
 gSDnrXbu8PWB/z8JSc1IcJVFQON2E80s0RgJ3CfgyTnf0/X1ll/ZLY1qs+qzLtDMK0Om
 OImJanjWMvL/bLumylqpVmhWfrUt7WFLGAWTakJHXqxDMzzfRse5N1lE4s7d5DDGYpXp
 /AGWzMpIaJwUIXQiz+uoRfs4dfksk1WPKSuxiinJV5HkdmSz+pc/i/nUn9LXG7W3ntO2
 pkNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686718051; x=1689310051;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KqoUXPLuldR0Nd43PgiNDbfsNDpw/LBh71A0E0Gu/IA=;
 b=geL5zN2A3W1G6SvG9eJgnTQnaBcGOnYp1i3j4Cy3q1M6wmLPi7fkrFrxNufinHE22p
 f9ncQBSytMqwrwiJqG4s9hj/ziBw9en4W8uogyf2fuUeG3fYuT1cRJ7h+xbG9PtSuKOQ
 nyybqBWgTlu2JplyHmGfGSV3bkwCpZs4qASzX5wEsvgUAalRa3miPuY5lRQoSOiqGEnJ
 1Q+b0dBeTElHWnIPtjTueWPzlVSAszIGGD15njhwXOuv2QgSLCHYznoJMQSfXdvWykIs
 ggEHZ6B6O/ez1ww1DvYc4ZaR+ske92MV1KCPIPdKSs5YUOOA0uHaeXZIGAyD9MqdK2yv
 DxVw==
X-Gm-Message-State: AC+VfDwDsGL04i49bLcZZAza4Kufx66u1ssVDDUuyYehnbCNkhg+zlX5
 O5ynRS/Rxzo+3+CNtu5kxmxWHw==
X-Google-Smtp-Source: ACHHUZ4ADF/9F7JQZ719a3TSQVIahzjeXiZt0XN6dLOFp2MVPMIx3J9D+4SrzL00CkxwsAtDIMKs7Q==
X-Received: by 2002:a19:6752:0:b0:4f7:5e82:6de2 with SMTP id
 e18-20020a196752000000b004f75e826de2mr1547854lfj.30.1686718051093; 
 Tue, 13 Jun 2023 21:47:31 -0700 (PDT)
Received: from [192.168.4.112] (90-182-62-66.rcp.o2.cz. [90.182.62.66])
 by smtp.gmail.com with ESMTPSA id
 x19-20020a1c7c13000000b003f7aad8c160sm16128670wmc.11.2023.06.13.21.47.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jun 2023 21:47:30 -0700 (PDT)
Message-ID: <f3d7a2d3-fde7-cddb-3a81-fd889490754d@linaro.org>
Date: Wed, 14 Jun 2023 06:47:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 11/26] target/arm/tcg: Reduce 'helper-vfp.h.inc'
 inclusion
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20230611085846.21415-1-philmd@linaro.org>
 <20230611085846.21415-12-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230611085846.21415-12-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x12d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.098,
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

On 6/11/23 10:58, Philippe Mathieu-Daudé wrote:
> Instead of including helper-vfp.h.inc via helper.h which
> is included by all TCG files, restrict it to the few files
> that require it.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/arm/helper.h               | 1 -
>   target/arm/tcg/mve_helper.c       | 4 ++++
>   target/arm/tcg/sve_helper.c       | 3 +++
>   target/arm/tcg/translate-a64.c    | 4 ++++
>   target/arm/tcg/translate-m-nocp.c | 5 +++++
>   target/arm/tcg/translate-neon.c   | 4 ++++
>   target/arm/tcg/translate-vfp.c    | 6 ++++++
>   target/arm/tcg/vec_helper.c       | 4 ++++
>   target/arm/vfp_helper.c           | 4 ++++
>   9 files changed, 34 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

