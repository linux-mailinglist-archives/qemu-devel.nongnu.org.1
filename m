Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1229C823098
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 16:32:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rL3EM-00030s-BE; Wed, 03 Jan 2024 10:32:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rL3EK-00030i-7a
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 10:32:28 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rL3EI-00022y-H8
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 10:32:27 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-554909ac877so8604330a12.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jan 2024 07:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704295945; x=1704900745; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w/S5bj5+oUxcxmJPbb2PURP5ha2cCCIkAYwrjg9IWf8=;
 b=wx2Aw+TSWWHv5Zv3LbyALbsvTsH/P9j+HbE/fhLHjeImUNDvGWO5OMnacC0UjlARaS
 hCJCxmeqO2dXJtntNrBvhW8DHl3kzhgPnBSsmD0QhlrGOnYGk677DYEamQAJX3KnNxQq
 SyiBuqGnjuH6Dg122+ySB2PWG3hAm8TYqyun6SOTezBoZ6zpYh7Vt0kszG5NDaT68txb
 f5iBYCdGPO3H/xf5ioL4trdIjKxNpYd2nFHrzV3i0kPMnHd1kyjRSf+UQwD9cKxHiPHf
 RQrYOAsAGSJQQ+ei/Z4nQ6Yo405k6aWrVXZdsFDM9c7zT079xfnrs+MrXQ2Km2hMJCZk
 S0ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704295945; x=1704900745;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w/S5bj5+oUxcxmJPbb2PURP5ha2cCCIkAYwrjg9IWf8=;
 b=Ju5NPCBCA+25i1pt+twmywzgzbpTyxiuZFclnNBaqywfJpappeCzS47IOfc9izk5QP
 q+DmSkwRP0YzGEXAqPPkqSWkgmxkDsEpRBo2FzadNP0ax0QQWFiDmYPFZaUUS2NyhlMm
 QlNeuT+PHv6U+zkeFudMsYSUiq704g74Lw2wqFuN49fIbS8CtzbNPBdbBc84QYAgTOpX
 GLpciYowU4FFVgrXmrTeRYKzwLHy9rbry0cAFQOQYAwfdyHmvMMs29nHnL65lupaIiOx
 EYytHTtK7BJ453CaSF9MLdF2WnHdoEgvj42aP21blFKGwE7xUlUTWa73sFeYeRQlRg0r
 2LxQ==
X-Gm-Message-State: AOJu0YwbmatZBPiYZuAb1uab2LUfkI4/4Op3NuN6FMXqyAJdymTZMb+x
 GaQvl3m2uEuKn18qbA6HUuWdilTs7ImrJ0nCspQVbYeSLRs=
X-Google-Smtp-Source: AGHT+IF652UU0stkV7+3FTDtjejNy2tgFqVQIOFsJ71xfnXGzho5dM8myr3pQ8A6wNPy//x8RyTmRw==
X-Received: by 2002:a50:d65b:0:b0:553:73c4:87db with SMTP id
 c27-20020a50d65b000000b0055373c487dbmr10994660edj.15.1704295945016; 
 Wed, 03 Jan 2024 07:32:25 -0800 (PST)
Received: from [192.168.69.100] (tre93-h02-176-184-7-144.dsl.sta.abo.bbox.fr.
 [176.184.7.144]) by smtp.gmail.com with ESMTPSA id
 o20-20020aa7c7d4000000b0055537e76e94sm10524871eds.57.2024.01.03.07.32.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jan 2024 07:32:24 -0800 (PST)
Message-ID: <07409e42-ae18-40cb-af9e-93c504936e10@linaro.org>
Date: Wed, 3 Jan 2024 16:32:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 31/33] linux-user: Bound mmap_min_addr by host page size
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240102015808.132373-1-richard.henderson@linaro.org>
 <20240102015808.132373-32-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240102015808.132373-32-richard.henderson@linaro.org>
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

On 2/1/24 02:58, Richard Henderson wrote:
> Bizzarely, it is possible to set /proc/sys/vm/mmap_min_addr
> to a value below the host page size.  Fix that.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/main.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



