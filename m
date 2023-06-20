Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC74E73698C
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 12:40:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBYmo-0005dq-Rb; Tue, 20 Jun 2023 06:40:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBYmk-0005SP-VT
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 06:40:32 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBYmf-0004iJ-En
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 06:40:26 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-51a21185130so4723943a12.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 03:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687257624; x=1689849624;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ka3CMzCB+5HrtaMK79lnHyi0S0NQSXryjFCdnDk80RY=;
 b=atFtFX4ZNnPXPPl+jZ6j5cJ7A2ccxXSWHYHbYs3ROwW5dwuEsoMuSXHkFQGo66am3L
 ct3om/DFszK3D6AY/iCferQuMSW+twMOdcYovdup6AU+L3cAFYuUTg0GZHIcbvsgVNt6
 jdqI1xu4MLGjVJ4jWiO73TmMwrhmkYThXvoXkJNn8Lj2krwY1KIqu8Mwei35GNVgysbm
 rLuqIVH8cyg8ugL0XkqRl3rWGtp1/6eu5obEuj/D+Dc2pIRBk+TsXAAnncQvwFLzaZe/
 Aioz5ixOnFfdjreXZ0ivuqvTrM0S6+bAPQhPPGSrKs74G9exkH7MYRbokEI05ZxwLzQa
 qjbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687257624; x=1689849624;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ka3CMzCB+5HrtaMK79lnHyi0S0NQSXryjFCdnDk80RY=;
 b=FlgsVXdFdQDKOEEG/LpgujfnfVpRUx8T2Ff7J47TEALw/ik9YDyMR5LAbvswpOdghl
 czhVLyUSFOHFlPlmFyQ6dOjhOri3mAin90bnriFnCtcshy/oi9wvtACF6iIMbCDpbgOi
 PRzWg7ymX7Uht8duoStr+o0msGtgK+8ENikq6q6reVFA1ptkg+XTOLvq9LcosS6lxuZ2
 u3zCam3osJsVdqd1GasHzF/S9UXuauodiOfaJni5E7S1mznuZJjxlNpmFaCv9FzFrBw1
 WCgdb/9coboUeV2vrS6I+4CbTwm01dGSk5F55cA+RGydm4yfjTJbjPua44Me/Sfug9Cl
 uC/w==
X-Gm-Message-State: AC+VfDzPY0DbhK50eQAy1mje35UjbDN/9oimPx29Q3gIgcuZLfR9tvVF
 wNpjutobYKXwZgWA/XsEeTdLFA==
X-Google-Smtp-Source: ACHHUZ7oY5J9q3Jncnx6LWZgspMNtd/gXpRKDHDVJFnC/W734Zc5YwjuOxt0rIXnhCQF7yAPuJPsug==
X-Received: by 2002:aa7:cf19:0:b0:518:7bab:b8f7 with SMTP id
 a25-20020aa7cf19000000b005187babb8f7mr7995551edy.16.1687257624074; 
 Tue, 20 Jun 2023 03:40:24 -0700 (PDT)
Received: from [192.168.69.129] ([176.176.183.29])
 by smtp.gmail.com with ESMTPSA id
 y19-20020aa7c253000000b005148e981bd3sm954062edo.12.2023.06.20.03.40.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jun 2023 03:40:23 -0700 (PDT)
Message-ID: <2f722452-b835-e341-19cd-4bb14e0bcd31@linaro.org>
Date: Tue, 20 Jun 2023 12:40:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 25/34] target/arm/tcg: Extract PAuth definitions to
 'helper-pauth.h.inc'
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20230619154302.80350-1-philmd@linaro.org>
 <20230619155510.80991-1-philmd@linaro.org>
 <20230619155510.80991-13-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230619155510.80991-13-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x536.google.com
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

On 6/19/23 17:55, Philippe Mathieu-Daudé wrote:
> helper.h is used by all units, but not all require the crypto
> definitions. Move them to a new header, which we only include
> where necessary, removing the need for "exec/helper-proto.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/arm/tcg/helper-a64.h.inc   | 12 ------------
>   target/arm/tcg/helper-pauth.h.inc | 19 +++++++++++++++++++
>   target/arm/tcg/pauth_helper.c     |  4 +++-
>   target/arm/tcg/translate-a64.c    |  6 ++++++
>   4 files changed, 28 insertions(+), 13 deletions(-)
>   create mode 100644 target/arm/tcg/helper-pauth.h.inc

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

