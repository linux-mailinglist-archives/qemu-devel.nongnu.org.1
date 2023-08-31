Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A59578E7C0
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 10:18:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbcsF-0008Bn-2Q; Thu, 31 Aug 2023 04:17:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbcsB-00087I-AA
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 04:17:51 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbcs8-0006pX-9F
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 04:17:51 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-4fe27849e6aso1088527e87.1
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 01:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693469865; x=1694074665; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=afYWtHr3+mjB/u7pMAgIJK40tVxHVJJUHVzRTRI1NW0=;
 b=Yjj9R5J/wVC/9ARGoMCOFQ/uxYnPU/67JK0l/qEYmPe+cVbMlIHkKz5Ty2CR7Pn2We
 UO43pPI4pTpJnmpVRY1ykKopLNqNMYj+7D1+BzYOn7p8A/E1zNptPgmhjQufKcrhgyND
 fHCsBux/HX3cF+TeOWMILBe38kiVHXMvGAtBxSqfWlKxsc2BwJo9xNptFkHjFK58Ox6F
 JHmjUYsGR4amXWHHrdBpDatFXM5DmZTKt5ULLDsKInb12T8VKOnt7v/GrfF5A793qUY/
 0EKnwUnj0b7b2x5FIwefoHCcM/8/KCgVq7qoyss+RTFR4E9xQdWddU8ha0NG+OUBoyfH
 DnJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693469865; x=1694074665;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=afYWtHr3+mjB/u7pMAgIJK40tVxHVJJUHVzRTRI1NW0=;
 b=UGNoBlYrb1TgX0rWic02jlLslS/hvTXaP3hQ5P3Gw7Rk9MI6OVKOod0jMAYFH6msyp
 ck1GCADTtOF1UJT+7x22t+FcT6Po2jtGVhWbXtPdi/0xWwRvKa6QxcPT9FyOYba84/AF
 cKVAhpNTSZJXkSlpY7SRVG25paBKYjerhHhD8fHoZkCwdlADJKgyNoAgdIB7UGt8x23k
 nqCNrs2v5YEP4dVwZNW622rsLDGxC0Opx1gRJTmo55u6hjMKcwYsEopcuhCC0BzRWXHP
 l8oPfuqtsVCtCo9189DmYxVFYG170YXjyc3BY5LzmdpLgZa1AZj8UIj8r9+b4FC73TFd
 mCyQ==
X-Gm-Message-State: AOJu0YychVgNGqccJPgat3xNonn+x2mOIdwB8frZuBRdo4naxEh7/hbz
 JL+jGQ2LjrAvb06prCrDQUmylg==
X-Google-Smtp-Source: AGHT+IGdpSY+jUCImkCfNJiiBgvW5fOfCWGLAU41eFSsxXNmL3xJHr5+BmY7AFOrXp/jo6VMAbzmiw==
X-Received: by 2002:a05:6512:214c:b0:500:b964:37e0 with SMTP id
 s12-20020a056512214c00b00500b96437e0mr2994265lfr.6.1693469864744; 
 Thu, 31 Aug 2023 01:17:44 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.199.245])
 by smtp.gmail.com with ESMTPSA id
 x2-20020aa7dac2000000b005272523b162sm498344eds.69.2023.08.31.01.17.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Aug 2023 01:17:44 -0700 (PDT)
Message-ID: <84c180db-ab99-a8ab-8e75-bd1fa09c785f@linaro.org>
Date: Thu, 31 Aug 2023 10:17:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 10/10] configure: move --enable-debug-tcg to meson
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20230829082931.67601-1-pbonzini@redhat.com>
 <20230829082931.67601-11-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230829082931.67601-11-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x130.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 29/8/23 10:29, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   configure                     | 11 +----------
>   meson.build                   |  3 ++-
>   meson_options.txt             |  2 ++
>   scripts/meson-buildoptions.sh |  3 +++
>   4 files changed, 8 insertions(+), 11 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


