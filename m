Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E33273D9A0
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 10:27:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDhZD-0007wS-Ca; Mon, 26 Jun 2023 04:27:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDhZB-0007vk-6h
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 04:27:21 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDhZ9-0003bx-Hz
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 04:27:20 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3fb10fd9ad3so1940905e9.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 01:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687768037; x=1690360037;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=s4Gi/P13f8x0efH4UYeHoIJu+dKOXm4FXE6sIjkH4ZA=;
 b=nzSdkq5CwLijsQkLiN5FTHhLDWQLF6giOLA/Wcz4WVPfNdYnDZXDgEQVIRC0ReBhz7
 WxH5fX9zjwtZE4pTChZJTsfQMtfxuGE5mSkyvVo/CvtQaLMmVgrav9wJWBRRkopAA/Vb
 zEJ9olKLyn3shovMqKR+EEySHXmBi4UHvrMQ10XLyaP8vj836yRdyeSEnwDSfNHDPsN1
 aDcLheJlgcaMZmtdPfdq5CuaxK4mcyObrB9OvMYxq1b8ZPOrudYKQzq//F0UXNZwh+ca
 8QuZXrd9pNbgcv02o30KPWyELUK6QoDMhSkreuvdh0RxooIRI3PO/yTgFxe/RFes6nFX
 r1GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687768037; x=1690360037;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s4Gi/P13f8x0efH4UYeHoIJu+dKOXm4FXE6sIjkH4ZA=;
 b=X3ICzPALyLEehX8wwBGSgRTmGn8KZ7qBoz+WKbvKaTdvAxGIUmVuvr73i9ZDQqV8IX
 9QKLuaNH1tb9qnQ9/Qtsf/Px8FiS13EQSqeB1BbE/EJsUYo48txQ1bTTEeicv2Z8nH7B
 Ey8dTHW26ogHmg0g8P5dF5FnfWL3kV/uWdmI3Y0YiDhIyx1WrhvPDglhDAFMLR33Gtbu
 12DBZsaBIERczdYA2pggA6Z2t9XLAFKW7PG337Ou+xZGN28z87u4sL140V99VIzJBXqW
 SqykkM7ceELLb9vNGVJQN+P9KJ3fw49Fnc3NKO4g/PwoFXUFknptV5z/F7mNLVYg7RWJ
 TWKA==
X-Gm-Message-State: AC+VfDyFidksVxpYbKHy86EyDJpzHyK2kf7rcMAqP/7kXIOTciiO0jKS
 Q1TRu/uLVJbjy5rLvKjKU9W4kA==
X-Google-Smtp-Source: ACHHUZ4CrblxHuYUvQRqg8vjAp9O5Tktp1fPFedxuZYPz4rToF7zm5BIca7HZe/nByhoBl2lYLurdQ==
X-Received: by 2002:a05:600c:2212:b0:3fa:7b20:6193 with SMTP id
 z18-20020a05600c221200b003fa7b206193mr7566409wml.38.1687768036975; 
 Mon, 26 Jun 2023 01:27:16 -0700 (PDT)
Received: from [192.168.1.208] ([139.47.42.170])
 by smtp.gmail.com with ESMTPSA id
 y19-20020a05600c365300b003fa8dbb7b5dsm3207014wmq.25.2023.06.26.01.27.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jun 2023 01:27:16 -0700 (PDT)
Message-ID: <4a403eb8-cfb2-c18e-50fe-28ce78529812@linaro.org>
Date: Mon, 26 Jun 2023 10:27:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] linux-user: Remove pointless NULL check in clock_adjtime
 handling
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
References: <20230623144410.1837261-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230623144410.1837261-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 6/23/23 16:44, Peter Maydell wrote:
> In the code for TARGET_NR_clock_adjtime, we set the pointer phtx to
> the address of the local variable htx.  This means it can never be
> NULL, but later in the code we check it for NULL anyway.  Coverity
> complains about this (CID 1507683) because the NULL check comes after
> a call to clock_adjtime() that assumes it is non-NULL.
> 
> Since phtx is always &htx, and is used only in three places, it's not
> really necessary.  Remove it, bringing the code structure in to line
> with that for TARGET_NR_clock_adjtime64, which already uses a simple
> '&htx' when it wants a pointer to 'htx'.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   linux-user/syscall.c | 12 +++++-------
>   1 file changed, 5 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

