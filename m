Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0DD80CA77
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 14:05:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCfxx-0005pW-UU; Mon, 11 Dec 2023 08:04:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rCfxw-0005pK-06
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 08:04:56 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rCfxu-00058b-Ho
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 08:04:55 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-336223afe64so735742f8f.0
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 05:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702299893; x=1702904693; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rVfsDHJ1pNq8aA8tMO2BOG+zyqKJN+Kf6hQsUEHtY18=;
 b=MGvFXUOF8CkvITsnFrMNnro2F3GN56a1+BgzigYLG4PT1dxotlcSHr2rvUjk5QFvbw
 2rbDtM191CaRRCHwur3hTJZG3RprNoq4UwFu6d1UH74EkDjImtD2LRRjncDWRHVDl6P5
 p37HHczEI0m2LV1WRvcgVNeU/OzZI1eb6Vrf99BWvnb2cgcrq5wN6M+qh7EZ+QjsbJRw
 uuXjfI97RIddeYLdpj0Z0VihqOg8dj0UNORdtZQY2W08+PSTWcih0MtM33QMGB4t2+sO
 4e4qYnd8XeiRIkMZjPWgEeZIqwOs4PM9IwO6KYQcr+KNyU+7MG+BFfdOXLTzQsUkGneN
 893A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702299893; x=1702904693;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rVfsDHJ1pNq8aA8tMO2BOG+zyqKJN+Kf6hQsUEHtY18=;
 b=PFwHHVBNA8nVh9rm//qJPYY91K7iuiqU5Xl4lSnvHFDO6ygVXUiArjzVwxHjzOpWbH
 ldwaezQjTIverJ7Re8Y8R/OtduyUnY61u18ItYkGUvIbmjYqCERNIF0D39y+wci7hIRW
 spByr/CYpYYx6JrQcfCCiEQtNSzGP9tG/LYF3/aKclBZ4aTwPlhiFDdQui2bBl0MooMT
 HapKAn6Kml6AgNf0MVtDq45HJES9eZwI3wvt0x09TF4HwD0TQhCeS4oVvnVuAbyC1Oiq
 47+jfOUooBebLvEHFFm+vmGymrpgh5B72dMcjk432M8ikOl4WnW3tVLIj35YuEmnJ6mi
 gd6g==
X-Gm-Message-State: AOJu0Yxi8uPY3FSUiRYuDbhf73GPA43pu+QdbUSi0DmqJhIxqtRbOVL3
 yzwLmgHnZOu2px1QpBmd9Sv/6w==
X-Google-Smtp-Source: AGHT+IFWGF1UOvlhJkzwcrdJyrgId7x3Ut2UlPMewXPFQM34gYGaZD1oXudFNrVglVoWZJ9TJpHA+g==
X-Received: by 2002:a05:6000:1b8c:b0:336:1adc:fe09 with SMTP id
 r12-20020a0560001b8c00b003361adcfe09mr1208860wru.16.1702299893001; 
 Mon, 11 Dec 2023 05:04:53 -0800 (PST)
Received: from [192.168.12.175] (61.red-88-29-188.dynamicip.rima-tde.net.
 [88.29.188.61]) by smtp.gmail.com with ESMTPSA id
 b5-20020a5d4d85000000b003333521a1cesm8536424wru.57.2023.12.11.05.04.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Dec 2023 05:04:52 -0800 (PST)
Message-ID: <0824d2e1-dbc0-435a-93ce-c2cd1d1ed055@linaro.org>
Date: Mon, 11 Dec 2023 14:04:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/16] accel/tcg: define tlb_fill as a trace point
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Beraldo Leal <bleal@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
References: <20231211091346.14616-1-alex.bennee@linaro.org>
 <20231211091346.14616-15-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231211091346.14616-15-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 11/12/23 10:13, Alex Bennée wrote:
> While we do have a bunch of debugging we can turn on in cputlb there
> is an argument for making tlb_fill a generally available trace point.
> Any fault (via probe or access) will have to be preceded by a tlb_fill
> for the address in question.
> 
> We don't bother logging the return address as that will be a host
> address associated with translation and therefor can move around with
> ASLR.
> 
> In my particular case I'm trying to track down a difference in memory
> fault exception patterns between record and replay phases.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   accel/tcg/cputlb.c     | 2 ++
>   accel/tcg/trace-events | 1 +
>   2 files changed, 3 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


