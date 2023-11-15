Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B007ED774
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 23:43:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3Oae-0004pb-LQ; Wed, 15 Nov 2023 17:42:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3Oac-0004pE-VA
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 17:42:30 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3Oab-0001i6-E4
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 17:42:30 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5446c9f3a77so321334a12.0
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 14:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700088146; x=1700692946; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=44wk12gWSx+VOHlf6Bx4iWBZ3gfXmmZ565tPJii52M0=;
 b=zFUemcs7Q1vHkMgwwuGy4QVCPZIXsnes5zgs79RnoJoe5k3Z1LbUqWKjQeOlMG+HZY
 KFLpQ0d+kl6yu/99U226xK4eYPZ8zZt89GNLezh1jv1ia5gSL7yY5YM54yRIKOIObCut
 J3AKD0RPFytYt8gDi8EUYZnhWhIIBvDZuSNydSZG9Ixxm5/bR+BPyQpiQwo/ud+lO0gA
 wBd50TJ2n61jDi2toMjpOn61kVTY1R6ELl1mfaBLXz6zw/F0UsyVGrZ2qyeyEqewnvu4
 TSWlVXML2QAqPa6q44aNcWKqeCBELbIP7wkEazVPKisHx1HmbOpBKKz7yYy9H0hEuMpF
 maMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700088146; x=1700692946;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=44wk12gWSx+VOHlf6Bx4iWBZ3gfXmmZ565tPJii52M0=;
 b=kKKGY16M1fV3NvTJS2KKFh2DKL6dtb5jMFKV+x2eOzAr/PQU1UNbmsYg0sVOCEDOe2
 PTI8cb53Mdbu854FytxW2Jx4QzMBTsJU49T8gZszqmx/E3FrATA6sFpmkIBlhRVIQg0L
 3/vsdyv/Yp+TJzwKpWIiI5R4ZJEZJygGwuwqStyuOKsKLdIcu/9c38yHniJSUS/wfj+G
 UB9tor/xemhQf1ySfUKLxeJwSQde03mhFjwybEeoOYu+fpxA8+4ClxqjqYTs70TY3ass
 a5OBle8gCPt3B1rNyQFi8g/UI1RkaHaV7zESTeLtmJWNEm9dtzNMtM9vtwla97L6um3W
 wYJA==
X-Gm-Message-State: AOJu0YzI3sEsLaW8WBEmzjlMcsRGxIZox4NJp1/jidUi16sqsPZuzAmN
 Mgz3jrRGzoPgd0n8yE/DT/g5pch4yYOzC57GvRY=
X-Google-Smtp-Source: AGHT+IFse9caeGquSlr2m9eSwd9C/SlEcfYReLU6l+yLtocabrZIn7zBpXT3NsC6q1UMIYahqXjjAg==
X-Received: by 2002:a17:906:711b:b0:9e5:dac6:86f9 with SMTP id
 x27-20020a170906711b00b009e5dac686f9mr10542523ejj.69.1700088145858; 
 Wed, 15 Nov 2023 14:42:25 -0800 (PST)
Received: from [192.168.69.100] ([176.176.130.62])
 by smtp.gmail.com with ESMTPSA id
 dx9-20020a170906a84900b009c3828fec06sm7550338ejb.81.2023.11.15.14.42.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Nov 2023 14:42:25 -0800 (PST)
Message-ID: <5e90da45-7d64-4e2d-b914-540b0466201a@linaro.org>
Date: Wed, 15 Nov 2023 23:42:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] testing: move arm system tests into their own folder
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Beraldo Leal <bleal@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-arm@nongnu.org,
 Alexandre Iooss <erdnaxe@crans.org>
References: <20231115205542.3092038-1-alex.bennee@linaro.org>
 <20231115205542.3092038-9-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231115205542.3092038-9-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x533.google.com
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

On 15/11/23 21:55, Alex Bennée wrote:
> Prepare for expanding the arm system tests by cleaning up the test
> directory.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   tests/tcg/arm/Makefile.softmmu-target           | 5 ++---
>   tests/tcg/arm/{ => system}/test-armv6m-undef.S  | 0
>   tests/tcg/arm/{ => system}/test-armv6m-undef.ld | 0
>   3 files changed, 2 insertions(+), 3 deletions(-)
>   rename tests/tcg/arm/{ => system}/test-armv6m-undef.S (100%)
>   rename tests/tcg/arm/{ => system}/test-armv6m-undef.ld (100%)

Thanks!

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


