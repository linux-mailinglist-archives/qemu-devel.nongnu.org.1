Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF49182FCB2
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 23:27:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPrsw-0004LY-T9; Tue, 16 Jan 2024 17:26:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rPrsu-0004LB-E9
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 17:26:16 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rPrss-0006gM-PK
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 17:26:16 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-337984681bcso3773768f8f.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 14:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705443973; x=1706048773; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WfoOyezk3mE/XdrBhjxbwqQ9SbQDLGfUc5X/Zz5vbFM=;
 b=CHopzbbDx7gEKMeItqR8HXdPH/wnKKYlCmy7Dn0Ar4QSxzhJXRAdUOLjojfs6CN6w6
 UGw2HE12QnEYrz8G3N2wosDE3KyI9zGrpsr6qAr4YbDsGTu2zUzaAiuT1nIcj/vPca3U
 BxGodWZxGb3Tkm78gz0Vfnq0juD+2bmUk64Fzsl4vSm2QuenE4Fih3zn0vahWDXrj1iU
 Y9pVrr+6VM7GLvamIXJKz/1dARBXH/u+UIjEyxfW3k01zhptExNztPuOnpHWyTKcGzsl
 XxMANGwEY0m8FgwY2/VV3AmjxVjI/euDMSIWGBXebCdpDT35kBWEfy1ufW6/mLH/4I3T
 ZBZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705443973; x=1706048773;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WfoOyezk3mE/XdrBhjxbwqQ9SbQDLGfUc5X/Zz5vbFM=;
 b=vi5EhB4XtsvF0wayaq3kklE5molyE/belGBMbL7yEnlq3YMYWhIhOTC1nBVk30oB6V
 YHdGjH4ouSgDSr8kzL821VvTfh5RyA7zC5g9R14NpysW7SAWSsIzxr+k0NELKV9rnBt0
 ByZlMd2F10YZoIwoawZzgWLOhenQuo/9nIcIyYAY25bePHTsQcHAFV45vsAnO0C96PS5
 tJCz7iOEOX7VBY/qtiZFwxgHHFpIhPFeqbbvLTkGND9f6PcgcXT1IKnmdEDphZwdX0Fo
 ne3oDxdJI0t2nRgagHy9fQm8hNoOj9jGO6UF4uSUgzHWcRPvILeXO/2PQg+zwgJMbtp5
 hrcQ==
X-Gm-Message-State: AOJu0YzPWzV7kEyd6Y+EdDwJdymODAiwU3k7WYik4L9b1U3HqWWOKKSP
 YauiWRctFDLLEVcy6FEQuCSbPzq+RUmWBYc149YH3seU9Jw=
X-Google-Smtp-Source: AGHT+IFxKyPJqgi4Ad1zjX7XT634aSy+sQr4JywPXawv2y1pwHoSPfb/ttl8fqa6SAaet0rymUxNeA==
X-Received: by 2002:a5d:6810:0:b0:337:beb7:26fe with SMTP id
 w16-20020a5d6810000000b00337beb726femr595322wru.53.1705443973308; 
 Tue, 16 Jan 2024 14:26:13 -0800 (PST)
Received: from [192.168.69.100] ([176.176.156.199])
 by smtp.gmail.com with ESMTPSA id
 t26-20020adfa2da000000b00337c0cacf54sm146914wra.101.2024.01.16.14.26.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jan 2024 14:26:13 -0800 (PST)
Message-ID: <fbbc9ac5-18ad-457a-ae18-120a3d8cb7fe@linaro.org>
Date: Tue, 16 Jan 2024 23:26:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 21/38] tcg/arm: Support TCG_COND_TST{EQ,NE}
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20240110224408.10444-1-richard.henderson@linaro.org>
 <20240110224408.10444-22-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240110224408.10444-22-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/1/24 23:43, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Message-Id: <20231028194522.245170-12-richard.henderson@linaro.org>
> [PMD: Split from bigger patch, part 2/2]
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Message-Id: <20231108145244.72421-2-philmd@linaro.org>
> ---
>   tcg/arm/tcg-target.h     |  2 +-
>   tcg/arm/tcg-target.c.inc | 29 ++++++++++++++++++++++++++++-
>   2 files changed, 29 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


