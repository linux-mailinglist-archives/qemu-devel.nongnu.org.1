Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6D0748EFD
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 22:37:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH9El-0004fg-Lf; Wed, 05 Jul 2023 16:36:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qH9Eh-0004dz-KV
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 16:36:29 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qH9Ef-0006ET-Gv
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 16:36:26 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-51d9c71fb4bso88230a12.2
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 13:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688589384; x=1691181384;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JpQ7XvcR3AhboLSM7HXS/210rJntO9OnofPq2vEjHek=;
 b=q3+KpufDrBznrLtDROOLdcJnV1HnXbfBK5e6D/dPKRBAcCO790+hCMFi3MlDPt//r3
 C7ArDTA/RP3nrsnzmnPoPRAxE8UEsBB3XcAv86tXKKQ05I3palCNR7B0OY6SBqC7M5e/
 VKVvz/jBXRTLYFtzhNytV3IZCzylpMG/IkqswyBYbin2RjnILxOdlukFw6ik9rGrEUS6
 TVX5mvFYwlfnEAbTJ5PESH/yCw6euJe+zQy/M9QIYWOxg6zo+nViPAbwuJ84Agv9v8+y
 NdHeuOH1wTtnoXgSObZDt8AUMKo7RlBVyAySZIB965CqizgFaJ7ORu98TcKj27dqOXz2
 caMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688589384; x=1691181384;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JpQ7XvcR3AhboLSM7HXS/210rJntO9OnofPq2vEjHek=;
 b=TIep9XoLWmJEjsxLGbw2R9s+r9WdJghQxNnOyCSu87wtt2DwmOxrI/y71hVH5RwcHV
 ot338PklTOP1bgGsD7smw8y2NpIxKwq3rzIRttqNiiSqRdNrpB1A696vPHg2T0GRSe7M
 FDEchG9V8MjvsGk4/VxihIPQyZV58fikHDSByXlsFHoV6tCW2lkBmPpOc36NIPWni1F1
 6NXkHJ35LTWa2G5gec/QtCwPvrA1d1ewOgmmmSDUkBmRg1sg3zKDsvz+L+vIPuP284DH
 zGX5VNKRnstHKJyHhvQ5WcCIh5K9JUM8lkJYqET2M6YOJnUg0qZr0Egn/IaLZPaPRc6W
 qrfw==
X-Gm-Message-State: ABy/qLYhfAfI7sCW7Y/k9MtcA1otJckAYnxzE7TdL1mOLWNI0Vxut/yd
 9n+1U0yRD2DLE4ydvvnTAkoQenpdSnbhfhCcJ3E=
X-Google-Smtp-Source: APBJJlG+Nm+nazu0fmc1ajGbslj47p5fJZi1WDnCmKyP++YclrdsyPURoVV4KQVYdbcO/MxH2Dz1gg==
X-Received: by 2002:a05:6402:135a:b0:51d:a124:62cb with SMTP id
 y26-20020a056402135a00b0051da12462cbmr168858edw.28.1688589383857; 
 Wed, 05 Jul 2023 13:36:23 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.199.225])
 by smtp.gmail.com with ESMTPSA id
 z15-20020aa7c64f000000b0051de52f8adesm7921443edr.32.2023.07.05.13.36.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jul 2023 13:36:23 -0700 (PDT)
Message-ID: <fe2afd5c-fc4b-f1f5-017b-a33cb9bfe894@linaro.org>
Date: Wed, 5 Jul 2023 22:36:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 2/4] QGA VSS: Replace 'fprintf(stderr' with PRINT_DEBUG
Content-Language: en-US
To: Konstantin Kostiuk <kkostiuk@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Yan Vugenfirer <yvugenfi@redhat.com>
References: <20230705141205.525776-1-kkostiuk@redhat.com>
 <20230705141205.525776-3-kkostiuk@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230705141205.525776-3-kkostiuk@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52a.google.com
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

On 5/7/23 16:12, Konstantin Kostiuk wrote:
> Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
> ---
>   qga/vss-win32/install.cpp   | 13 +++++++------
>   qga/vss-win32/requester.cpp |  9 +++++----
>   2 files changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp
> index ff93b08a9e..c10a397e51 100644
> --- a/qga/vss-win32/install.cpp
> +++ b/qga/vss-win32/install.cpp
> @@ -13,6 +13,7 @@
>   #include "qemu/osdep.h"
>   
>   #include "vss-common.h"
> +#include "vss-debug.h"
>   #ifdef HAVE_VSS_SDK
>   #include <vscoordint.h>
>   #else
> @@ -54,7 +55,7 @@ void errmsg(DWORD err, const char *text)
>                     FORMAT_MESSAGE_FROM_SYSTEM | FORMAT_MESSAGE_IGNORE_INSERTS,
>                     NULL, err, MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT),
>                     (char *)&msg, 0, NULL);
> -    fprintf(stderr, "%.*s. (Error: %lx) %s\n", len, text, err, msg);
> +    PRINT_DEBUG("%.*s. (Error: %lx) %s\n", len, text, err, msg);

PRINT_DEBUG() ends calling fprintf(stderr)...

