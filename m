Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D270881145F
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 15:12:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDPy7-0004Qx-CC; Wed, 13 Dec 2023 09:12:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rDPy4-0004Qi-S6
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 09:12:08 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rDPy2-0004Fm-Qk
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 09:12:08 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40c46d6784eso31436295e9.3
 for <qemu-devel@nongnu.org>; Wed, 13 Dec 2023 06:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702476724; x=1703081524; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yPkrZVKvC+85lmFtbhNKgeMirYYKfrkykftQ/25MEa8=;
 b=Xg+y/8AN1E2f2AY/ClH3XhDLLTGKFIzjlbikBjjShsdorXsUCnn4e+ak5m5S6kSt3a
 dOZvHZ77rE021RpzoFZJ9biJt60Bc9To4KdCudHi0jU9mszqsUd6PLAQKnRSP3aBbbeV
 RsJPsRngHhfV8G0BUi3TI9uAjpnOd1KLOp7MO/gVu3thiBiDQ/kCRa/P9Ur48VzrLmuR
 Bo2/LYA+D6y6cXol2rFOR+1lOaNDeHitpbg07vqEpdOfsd7BkcEqUv0SLXQYz1gj0ai1
 XI72Wp3uA3hzVqfffTVXaPhiRsAsE0NKdftA/BplLp3VIb8AX+Tmo4MIk6Fj18QMLxaJ
 l2ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702476724; x=1703081524;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yPkrZVKvC+85lmFtbhNKgeMirYYKfrkykftQ/25MEa8=;
 b=stHS8CD49JbZX8P4mZ8/V7o7itWb/rRBmnbNQ32V+ywoMwqeFGDIneIBmjWc/Z61Xe
 HJFMp36Z0usvcwYw2zPPRKoHuoIjgYRdcxvxaDmmlSQtvU09xE99gjlAmt0DEvA9cIos
 aN3WxQUnEpy7Gv/q4qF+KvpgHYgyxMQseR39pxUJL72mWvKStrHWoxnYhlWWt39lNQz8
 r5SGKS1/8wtNaO5k7Y4zVm+qY5ikpMeeoA8hO8eXiiR0/rRaq2EpVmFZFgV6UqiOSS0Q
 im8qehOynqgUlA4oGSOy/Il5cWb4b1yzoKnaiHJdTrSrB7WzKGvzDq/prblNbRok2pye
 vBag==
X-Gm-Message-State: AOJu0YwQlTlpPvpTtaPiRrZT2iFoBJ6FwMjluxPmSK2gyNlTEZsFRGd3
 +W3QDBYBuu4j22x0w+x3OKQX9aNI902LVljprlDyEg==
X-Google-Smtp-Source: AGHT+IFn1gCziTqlyzI5AezayWAtPOYXgInGX7cgRd/VJMGyZcNJ2pmKM4R2qxmOktH7gMUur9sNTg==
X-Received: by 2002:a05:600c:3790:b0:40b:5e21:ec3c with SMTP id
 o16-20020a05600c379000b0040b5e21ec3cmr4410144wmr.110.1702476724572; 
 Wed, 13 Dec 2023 06:12:04 -0800 (PST)
Received: from [10.123.141.145] (sncfv6-vip-ucpctl.hotspot.hub-one.net.
 [213.174.99.133]) by smtp.gmail.com with ESMTPSA id
 z14-20020a05600c0a0e00b0040b3867a297sm20967361wmp.36.2023.12.13.06.12.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Dec 2023 06:12:04 -0800 (PST)
Message-ID: <69164cbb-59c3-4cee-bb14-c27dea1a6c4b@linaro.org>
Date: Wed, 13 Dec 2023 15:12:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] tcg: Move tcg_gen_op* out of line
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20231029210848.78234-1-richard.henderson@linaro.org>
 <20231029210848.78234-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231029210848.78234-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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
> In addition to moving out of line, with CONFIG_DEBUG_TCG
> mark them all noinline.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-op-common.h | 252 +++++++-----------------------------
>   tcg/tcg-op.c                | 208 +++++++++++++++++++++++++++++
>   2 files changed, 252 insertions(+), 208 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


