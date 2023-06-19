Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 594F0734C42
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 09:18:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qB99Q-0000C4-SA; Mon, 19 Jun 2023 03:18:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qB99E-00006C-Ut
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 03:18:01 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qB99C-0007kI-0V
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 03:18:00 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-988aefaa44eso105589366b.2
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 00:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687159076; x=1689751076;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WR/tC/1m0AazNsYkvcSNSv04d4b3YQjYuAtiX3jM6mY=;
 b=k2Nb65wb6IHoAmlXQEdvbb0GdbTV9YA+GtGxU2eCQj0SKz7xa/VduPPWhuho44k47g
 m1GT8ojwm2PwNXI0rqjwYaOl+WQ2av9H2TcCTTs6M0r2gbx2dT1VSilJdMibHrBqUmxW
 DNw4FwDkgWW+Lbt3xAmUSEV92OLqqs/KRhmlAyh438zbQepRmXUPmg/5awXmz3ckKoJa
 HIX1nlvOsvpxTUWeUqTBq/4DoB/sSrFQmBTGf06xc2d2rI78359I4Me6S83C56CJSgKs
 mW3by4exoMUAZYtmVRBxCuev7JRuJYDtUflhc172pQ93EiMWpVk4MhVml91mgv4kGFu5
 UWoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687159076; x=1689751076;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WR/tC/1m0AazNsYkvcSNSv04d4b3YQjYuAtiX3jM6mY=;
 b=AjnL7ASz3jB14RyshjaWTmQJifWc61BkMOTzOe6sYTOkMp2U03KFsS9YM1MiwkEP+m
 XFm2EJwJfkwqNxP228r5aXNK5zYk6+ftr39Mmkl7vPUbF8RnPk2fyjCW5SbzGympdznV
 H5gw9BHX8xNsp8/KqZonWldl6iwOs+IiG4xjB/C31RQuCXIR3YJJOIq4WxRNZCwDLz2+
 atMPB9l3tsZG+jLvxvSyivq+xZVQr8x5bS55zFmWmx7SIRsNVj3gKTp4V18Nyu+j3lLH
 H4iTbsdgvvmC0BnDlsJvp8Hw2PDfMO08QHCx0akjHVplGG8h32Co3pynzjYAhTuO4uGr
 vAzw==
X-Gm-Message-State: AC+VfDyA1mPilnyLU0Bc/Vuwt1+LXCaNA2KZAYnKCN8rtfFXMyjKsUps
 ddL8w+uySp9+7e891y5sz/Lk4PmZd8F/qz8W0dlz2B6y
X-Google-Smtp-Source: ACHHUZ4mLbENEKcw2Zvk1axqbS3Sx7nocGcwoqTT0FZs7GhToJk7+/nLxIhaG6nUU05mIGlxF5/74g==
X-Received: by 2002:a17:907:d0c:b0:96f:4225:9009 with SMTP id
 gn12-20020a1709070d0c00b0096f42259009mr10888355ejc.0.1687159076391; 
 Mon, 19 Jun 2023 00:17:56 -0700 (PDT)
Received: from [192.168.69.129] (sar95-h02-176-184-10-225.dsl.sta.abo.bbox.fr.
 [176.184.10.225]) by smtp.gmail.com with ESMTPSA id
 r16-20020a1709067fd000b00988e699d07fsm136965ejs.112.2023.06.19.00.17.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jun 2023 00:17:56 -0700 (PDT)
Message-ID: <c8ac1bea-7ea5-c5bc-60bf-8d762c753d61@linaro.org>
Date: Mon, 19 Jun 2023 09:17:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/7] target/i386: fix INVD vmexit
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20230618215114.107337-1-pbonzini@redhat.com>
 <20230618215114.107337-2-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230618215114.107337-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62a.google.com
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

On 6/18/23 23:51, Paolo Bonzini wrote:
> Due to a typo or perhaps a brain fart, the INVD vmexit was never generated.
> Fix it (but not that fixing just the typo would break both INVD and WBINVD,
> due to a case of two wrongs making a right).
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 2 +-
>   1 file changed, 1 insertions(+), 1 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

