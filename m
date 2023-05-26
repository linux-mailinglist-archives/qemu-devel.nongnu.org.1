Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB638712A29
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 18:05:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2Zvn-0002PM-Pj; Fri, 26 May 2023 12:04:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2Zvk-0002NM-SG
 for qemu-devel@nongnu.org; Fri, 26 May 2023 12:04:41 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2Zvj-0001lj-97
 for qemu-devel@nongnu.org; Fri, 26 May 2023 12:04:40 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-64d2f99c8c3so897723b3a.0
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 09:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685117076; x=1687709076;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Glqg9tSg2urz+nGGTJO9lt3g9z0RvA4cf0CenA9lboU=;
 b=hoYOc97POoUyg5Q+jloQJsjTUgd6OrSd94oZ0G1WqkDMwaKmb39GYCIMQDfHo9Mls9
 9f/vsiODyGtqUFLiKe4lF7tNmGxZNEs8xZv8qJvPUStA2Xz0zW+IzVn1bB0U2g+DRwKn
 uvy8j7x8snSfjOaEGdKv7dmWuqDFxk3J+TypNovs9wcHxiYpA8WjyxN3GsMOLkQZJ5VZ
 3DX+tmMGW8jYZMiE4dQVxAJwbOvP4CPjSM8ZVg4G66lyAcrz+s4d/gc0+pGSIPpJk+Eg
 rCk8CQcy5pOLVCsMm3nlNJoUkQA70mN9VtbHylPEwz0U8At5rEZPM/ZwHjYWuAo7oz1u
 EqdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685117076; x=1687709076;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Glqg9tSg2urz+nGGTJO9lt3g9z0RvA4cf0CenA9lboU=;
 b=ZPqypaypXWPOLUdhiQDfEVjqHfO56zyXzMkNL+oBS/kZEEdKP6dr1cCGnVAJoqMFug
 M3Q2ZxgngttXDQX7W4ZQ0LknVIAI/KTgrb16aBKNXoKaeBVY6w1raOi/YPOMk2sy5Czv
 ku5E9y+1y31Bqh8A1k7Rned6rze+XiXbsvPtjgw22/wQwkCZnnH+5EM/3S4Fv8oGRwJJ
 wF2T4l1IFWByhtKBDop5CgK8xrY7OQWYPSr/Y4o08FalruCmNmS/N5d5kluJtNjpbWSI
 br+PJK3HHvpOn6NbXI0Tu/tzdEVxkWPzvcQr7XI/JaWjndCfLA7cZ1pSdsPBsVKg+LUW
 /vvg==
X-Gm-Message-State: AC+VfDwo7cCnglib68njxey4n1tGnd/Chtml4vB5+NK5M+HFx6IohWja
 WiCC0OQ5Qn1Loacygpsqn/6nlQ==
X-Google-Smtp-Source: ACHHUZ4ApcjNlAZpnKvykhin44zyrcwX9skV7DUULdpXnZLnJVKBM6Jle+tMFKLj1RCpFhvQqUVqRQ==
X-Received: by 2002:a05:6a00:b93:b0:62d:8376:3712 with SMTP id
 g19-20020a056a000b9300b0062d83763712mr4459444pfj.28.1685117076421; 
 Fri, 26 May 2023 09:04:36 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:86cc:4482:68db:2c0f?
 ([2602:ae:1598:4c01:86cc:4482:68db:2c0f])
 by smtp.gmail.com with ESMTPSA id
 s132-20020a63778a000000b00502fd70b0bdsm2977062pgc.52.2023.05.26.09.04.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 May 2023 09:04:35 -0700 (PDT)
Message-ID: <bae4ecb4-b03f-e1c4-d5cf-de3b591fe36a@linaro.org>
Date: Fri, 26 May 2023 09:04:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 5/5] gitlab: support disabling job auto-run in upstream
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20230526101934.935969-1-berrange@redhat.com>
 <20230526101934.935969-6-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230526101934.935969-6-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.092,
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

On 5/26/23 03:19, Daniel P. Berrangé wrote:
> +    # Upstream pipeline jobs start automatically unless told not to
> +    # by setting QEMU_CI=1
> +    - if: '$QEMU_CI == "1" && $CI_PROJECT_NAMESPACE == $QEMU_CI_UPSTREAM && $CI_COMMIT_BRANCH =~/staging/'
> +      when: manual
> +      variables:
> +        QEMU_CI_CONTAINER_TAG: $CI_COMMIT_REF_SLUG

So.. in this case we don't want 'latest' for 'staging' because we may not run all jobs? 
Or should this have checked staging-X.Y, since the following rule will handle 'staging'?

> +    - if: '$QEMU_CI == "1" && $CI_PROJECT_NAMESPACE == $QEMU_CI_UPSTREAM'
> +      when: manual
> +


r~

