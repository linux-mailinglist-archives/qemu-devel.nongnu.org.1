Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FDE78115C8
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 16:06:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDQoN-0001Ud-KM; Wed, 13 Dec 2023 10:06:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rDQoK-0001T7-W5
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 10:06:09 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rDQoJ-0002mm-AN
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 10:06:08 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40b5155e154so80438915e9.3
 for <qemu-devel@nongnu.org>; Wed, 13 Dec 2023 07:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702479965; x=1703084765; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WOhuCuuvKIRy5eqdHlTo6jJ2mFM3jNjzaQz4R7320uk=;
 b=Kd6QACTOx9kklDAKtPCasnjdOZ/Te0xTAjeyu7jUoEz26YXFwk2AH7fHsrVqTavU0w
 Sy0zECI7AkKycQzFcK+NNlvMIO5Ld/qwnxYLrAJZijbz/8HXexIMrDZgBG2JnyRVtcBy
 9XHxf4WrBmcerPXVI+Jf4qxpii7DpNoRRwjZws+YipuKZAfaB476Bnu8y2ql8UixM3CS
 2Us9uTohh/WDlW7hC/YJf620WnKK2w9L59qG9JvNX+ebh7LSte8DF/M2t5O+rSN7JaPf
 O0K7Jh6rfyzg7AeR3LwGdSYndD8MO5wLIV1O6LakscIG2PMdzIhT5EDDMpcYMKWkluGM
 H/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702479965; x=1703084765;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WOhuCuuvKIRy5eqdHlTo6jJ2mFM3jNjzaQz4R7320uk=;
 b=WAUoNB5McaWi3AvAL0H65hj/BjXbtmL6QK8yI92goGxay33IRWRP598nLPWUQeoZTi
 qXsZgCTlUkyXA4Y0LVGIUr47ME3bHy4BMSvoeb0yO6QUUbv84pyI/6ix6rb5JvCfV+AY
 WzFYN6abQbK6PP83Cmro4WS4ff8wvyXmEWEmVn55huZmhGnYWCze5kekscpP39v5n7eG
 qoX1eUKhvdvsxWaJ4mT04SinTmkJsH+/KwrLHjg6DZNY3SSTIdoSJhmYtIxngjhGWXpi
 Z8F+MWf4zkASVV6V1YXp8YUwPfbu/Vd37imht9NDZ1KBPK+wEeaw6eE+UwA59ScyoRLO
 hxWA==
X-Gm-Message-State: AOJu0YwBrDbDFcDHzW4oqzOLnbbUgB7vWsSpGvZ/WHpPk/C+mwSzEOQR
 yZfrBS3X35tG4D1bqJIyo2T25g==
X-Google-Smtp-Source: AGHT+IETZX3JqG6vg+9MrijlgfyJDLBCvgLwHBGdt97UKMyQVK/85Kb6/AIy1svmLn1Ak0jX0jvJ8A==
X-Received: by 2002:a05:600c:524e:b0:40c:18e9:d610 with SMTP id
 fc14-20020a05600c524e00b0040c18e9d610mr3781652wmb.71.1702479965467; 
 Wed, 13 Dec 2023 07:06:05 -0800 (PST)
Received: from [192.168.71.175] (76.red-88-28-19.dynamicip.rima-tde.net.
 [88.28.19.76]) by smtp.gmail.com with ESMTPSA id
 e17-20020a05600c4e5100b0040c34cb896asm19587207wmq.41.2023.12.13.07.06.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Dec 2023 07:06:05 -0800 (PST)
Message-ID: <b6c46d4e-2a95-4d4b-8010-7b4cb485b1b4@linaro.org>
Date: Wed, 13 Dec 2023 15:23:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] tcg: Move 32-bit expanders out of line
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20231029210848.78234-1-richard.henderson@linaro.org>
 <20231029210848.78234-5-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231029210848.78234-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 29/10/23 22:08, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-op-common.h | 140 ++++++------------------------------
>   tcg/tcg-op.c                | 116 ++++++++++++++++++++++++++++++
>   2 files changed, 137 insertions(+), 119 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


