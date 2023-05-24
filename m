Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA3770F94B
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 16:54:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1pqq-000798-C2; Wed, 24 May 2023 10:52:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1pqo-00078g-Cb
 for qemu-devel@nongnu.org; Wed, 24 May 2023 10:52:30 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1pqm-00039O-Bi
 for qemu-devel@nongnu.org; Wed, 24 May 2023 10:52:30 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-64d44b198baso725713b3a.0
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 07:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684939946; x=1687531946;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DGp93xQy0Nyt16jgwOStM88xX4q4N32qdWohG+u5zMQ=;
 b=kI8sZu4y/ApaoWnxcpAUcM1ntU4kpN9Dxitqcb/uyGl+yW0MGSTniSFgNWyLZYM7zl
 9uX1egTYRnPg51MdifxMrUsLnU5j4H5OZYC4KopRmQlsShUnJBBTZSn69ARfLZuQEJMa
 fJcS/RxqWDegAPEdEjqCGizOzumz2lGPd+qfFHDguR6xlQcJ0biHZLJhQ9HAksO2xQM6
 umh1GBS83sbck6IYa+0dG2kCihKTK3mJAzqmkESbo+Greoxh4hbZ3vT1IuHXMLaA3pcB
 V4fsCSGdkYmMPrAB3SFbvBpv7gwYPy/AVo7uzdvCgG1ao8tzqE6jBbkQ9KlkhAWRCr3z
 TPvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684939946; x=1687531946;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DGp93xQy0Nyt16jgwOStM88xX4q4N32qdWohG+u5zMQ=;
 b=eZXo4pijxwZ0wExX/srzuT4tEMeLijXeZ9xI0tsz/IVjmABhmwJR7pQ9RhXFmPuOzl
 J/ePEhRx8EIsv9rp3Ho6Sm00Uz/NaDOTInQEK2D7Vk1Rg0zv9nNEuNjN17Pb/c6+2xoW
 wWJOLqKvyHg95NgCBBmDZxU3CXTHJ+5+Zp2M/nkb5Kq+ZKqgezYDIUiK2KSahdKa9o9g
 R4Vobup9u7e1Nh1HDeHjuDkMlRUKBUog4P7K20Ojox320RVobJKOaNlwx646HS8DcBoK
 vtxg1bbHONuWBIrB78I6FoByIC3fFFxUIgQj5YurAQl7LVKRyH+RPUa4I4+RxbVwWqji
 YxPw==
X-Gm-Message-State: AC+VfDwCs1Q6tmHJFWNFh8gqqL8faq8JdpmGlSKu67a5K8ysYsT9lcLS
 4HtP1DHOfrnQh24wuxCFJS+srQ==
X-Google-Smtp-Source: ACHHUZ6fv2CHpPdmgOkirWxMe+VEGWF0sie6rNExVB8P+CRHum0hOgR5yl8TSVuhFC6V5PikpKIbew==
X-Received: by 2002:a05:6a00:24cc:b0:64d:40e0:5580 with SMTP id
 d12-20020a056a0024cc00b0064d40e05580mr2975751pfv.3.1684939946472; 
 Wed, 24 May 2023 07:52:26 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:6b03:9af2:33c1:3d6b?
 ([2602:ae:1598:4c01:6b03:9af2:33c1:3d6b])
 by smtp.gmail.com with ESMTPSA id
 d26-20020aa7869a000000b00640ddad2e0dsm7570555pfo.47.2023.05.24.07.52.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 May 2023 07:52:25 -0700 (PDT)
Message-ID: <87904ed2-d83f-52ef-e22e-7c9ff715a6b5@linaro.org>
Date: Wed, 24 May 2023 07:52:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 01/10] softmmu: Introduce qemu_target_page_mask() helper
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20230524093744.88442-1-philmd@linaro.org>
 <20230524093744.88442-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230524093744.88442-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.107,
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

On 5/24/23 02:37, Philippe Mathieu-Daudé wrote:
> Since TARGET_PAGE_MASK is poisoned in target-agnostic code,
> introduce the qemu_target_page_mask() helper to get this
> value from target-agnostic code at runtime.
> 
> Reviewed-by: Thomas Huth<thuth@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/exec/target_page.h | 1 +
>   softmmu/physmem.c          | 5 +++++
>   2 files changed, 6 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

