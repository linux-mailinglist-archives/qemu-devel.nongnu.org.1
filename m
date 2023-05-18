Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D269B7081EE
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 14:57:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzdCJ-0006ud-2s; Thu, 18 May 2023 08:57:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pzdCG-0006u5-Up
 for qemu-devel@nongnu.org; Thu, 18 May 2023 08:57:32 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pzdCF-0000St-CT
 for qemu-devel@nongnu.org; Thu, 18 May 2023 08:57:32 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1ae50da739dso14057665ad.1
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 05:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684414650; x=1687006650;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7yrb92E2E0ni2NkxO+F08N7UMGdVWtem3dfy8mn8oUo=;
 b=KN0YkEUWuVOHR1za8WyYfWmcpgdkNYebTpSFY7GnwTO4lBdgkQ90RHjgnog/DBMWef
 GZZb78pLx1znrmFpxIszZAw+WFWMdqG+7KJwuKTZ4pgzEAp59xnlIV1gGD8vbfl1Qq5X
 Lr6H/HAtCKYA6c8ZVyV2x2hjUywM1ZNkv1ZugKMeiWtSkeo6QDWdIf+XxLsp4DFfBU8D
 ossfweHaAag498XBWkDWsFckmcVkOfU92IcsmOhOOhKjyRqJdKx8vp+3JAchZ8NH5yhh
 FJ3cQBYAjPYGe5WZPzE7qrEiYg9J1WDUmlzi11UFLtSwXlhepgkcdfalRc/ASMw2OxS6
 P5uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684414650; x=1687006650;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7yrb92E2E0ni2NkxO+F08N7UMGdVWtem3dfy8mn8oUo=;
 b=c28vRVYPZ++DKRt73jGE09B7qSrp+5jogiSwmXPIlgxEpxGP2SZOYYkUHkXnZmo1sm
 8aFA5QUfokgNMdxDbmhOW4Kc2XmWrzpuheMAAm/GulUUHwX92jkr0NeN/HlMsO6B7tUA
 onVuBIJUHU1uFs7vg1owD+12pMjN0C5DHCgUbCg0hIKXCAxlKCzmG8EZb8gW2Xr8Bfh8
 zyo5VO1qX8apBPhQHlD3dDCmkpL9gd/cdZRlGOYZxYscFO23Ce2hDyBJm+URBeKkW/hU
 utDL0oOfSSAl98FERm0G7XNY0HGdIoQ7SAtpPyAShgzyoQzD7/igYizmZCxW4A65AfwX
 E5gg==
X-Gm-Message-State: AC+VfDx2in3yES/OBTlbB28mkhHpljXjcO9VGip94+MqBAXlx6i/u3cB
 jWUgjnS3CClG1CMOMGBBZV5tAw==
X-Google-Smtp-Source: ACHHUZ6la/ucAR6BB0xurK4GCiTEtqOi6ow5ID72uHAD40Vd8W+iGwhNj3vyeXim23SLmNOPFoVNIw==
X-Received: by 2002:a17:903:2309:b0:1ad:164:74ee with SMTP id
 d9-20020a170903230900b001ad016474eemr3157156plh.15.1684414649990; 
 Thu, 18 May 2023 05:57:29 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:5dd2:c230:399b:cdc1?
 ([2602:ae:1598:4c01:5dd2:c230:399b:cdc1])
 by smtp.gmail.com with ESMTPSA id
 k2-20020a170902e90200b001ae12378732sm1331351pld.300.2023.05.18.05.57.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 May 2023 05:57:29 -0700 (PDT)
Message-ID: <5b3618ca-3b50-1765-6968-159937efcc40@linaro.org>
Date: Thu, 18 May 2023 05:57:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] gitlab: custom-runners: preserve more artifacts for
 debugging
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20230518065206.951902-1-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230518065206.951902-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.544,
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

On 5/17/23 23:52, Paolo Bonzini wrote:
> Since custom runners are not generally available, make it possible to
> debug the differences between a successful and a failing build by
> comparing the logs and the build.ninja rules.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   .gitlab-ci.d/custom-runners.yml | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/.gitlab-ci.d/custom-runners.yml b/.gitlab-ci.d/custom-runners.yml
> index 34a1e6f32735..8e5b9500f401 100644
> --- a/.gitlab-ci.d/custom-runners.yml
> +++ b/.gitlab-ci.d/custom-runners.yml
> @@ -20,8 +20,10 @@ variables:
>     artifacts:
>       name: "$CI_JOB_NAME-$CI_COMMIT_REF_SLUG"
>       expire_in: 7 days
> +    when: always
>       paths:
> -      - build/meson-logs/testlog.txt
> +      - build/build.ninja
> +      - build/meson-logs
>       reports:
>         junit: build/meson-logs/testlog.junit.xml
>   

Acked-by: Richard Henderson <richard.henderson@linaro.org>

r~

