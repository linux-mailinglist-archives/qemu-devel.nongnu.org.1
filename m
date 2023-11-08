Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DAD7E57DE
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 14:15:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0iOI-0007nc-5N; Wed, 08 Nov 2023 08:14:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0iOC-0007mz-9S
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 08:14:37 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0iO6-0006G2-Ho
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 08:14:36 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40836ea8cbaso48032425e9.0
 for <qemu-devel@nongnu.org>; Wed, 08 Nov 2023 05:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699449269; x=1700054069; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HrS1or6CZ13RNB10oi2qeD3/+zUHHOOfEA9zw3LA93g=;
 b=aoNPvg98LyBGl+X0/6M4LBFPvn2ya9huyRd137+WT5n+Rc7W1GJjppRF310IhoydoO
 lRvbD2Sd6g2inHVhlEm1MoGP896up7G3vyWk+02KB3nw1uSXTbdApoT7+oS7vBQUx609
 6UaUEuMk7qD4Rivuq/C04cQDq8CsEpPp4FFpHSBL6YK+luyHy5GzACE4pGE1nzWl10Mq
 EHEol1z+3pcxmN1+6nKfQuHhllv0pK1mFzMcp2BOYDdjmqhpBFurxr3jS/CwgfwKUvxb
 B3kbXolJt7xOve4HWHH0xVOGSALjyrCh9K0TwfPkGwCUoIjUckDUiuTbX9YyxtaUA5UI
 Nxdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699449269; x=1700054069;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HrS1or6CZ13RNB10oi2qeD3/+zUHHOOfEA9zw3LA93g=;
 b=pVK+jT9ivHtBeeeKbHtkJ1RO0DhUUUJtaPMY0Z7HLz/uHKtjDSPhVCt8v3Ulu/qJa+
 fEyW5ij/lH25WkXCqhCniigwwE3chzMkgnbd2O9L5UokVGj5JJ6EPYkOxuRYfEDi0VKp
 oPjxaWCaB9nna7uB/kQVTkAjfA3gWKkgH/jrgPu6so6isZKEn4wKuqipPpZ2XzfaCJU4
 TK9wSbecXYsjurt/KbfhiTHO/y9EjSRf8yMZR1cEqC3lGibjCfG12vaK9nfMbDQW0qZo
 BcvkgRNoqriPVMhyIgHp8o+GRGiepzA4Qqraw9bHjgve1JqtZ181c0CpvCx7jyIcT3it
 bARg==
X-Gm-Message-State: AOJu0YyTgjfvhPfTxVvJDkvLPZc0yZJsQTVvuEfaAWTi/HHOlzSHkguQ
 1gJOSHug1MedddrsFv0hgbIX1A==
X-Google-Smtp-Source: AGHT+IFJMYqXmIgy0yQisYxvRE9QLGMjKa+45CMMRsgdabWi244dsKsJ3MEgNMJ2q0XTqf45lv1XRw==
X-Received: by 2002:adf:cd86:0:b0:32f:b3a2:c2eb with SMTP id
 q6-20020adfcd86000000b0032fb3a2c2ebmr1384275wrj.65.1699449268242; 
 Wed, 08 Nov 2023 05:14:28 -0800 (PST)
Received: from [192.168.69.115] ([176.187.199.60])
 by smtp.gmail.com with ESMTPSA id
 x8-20020adff0c8000000b0032d9a1f2ec3sm4966183wro.27.2023.11.08.05.14.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Nov 2023 05:14:27 -0800 (PST)
Message-ID: <ce02825c-8446-49b8-aee4-50d0314f0c68@linaro.org>
Date: Wed, 8 Nov 2023 14:14:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tracetool: avoid invalid escape in Python string
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, qemu-stable@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>
References: <20231108105649.60453-1-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231108105649.60453-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 8/11/23 11:56, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> This is an error in Python 3.12; fix it by using a raw string literal.
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   scripts/tracetool/__init__.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


