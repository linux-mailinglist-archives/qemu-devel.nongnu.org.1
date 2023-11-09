Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2937E6C29
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 15:09:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r15ib-0005bu-Rx; Thu, 09 Nov 2023 09:09:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r15i9-0005Sy-Js
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 09:08:45 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r15i6-0000Q4-Cu
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 09:08:45 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-9d2e6c8b542so150525866b.0
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 06:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699538918; x=1700143718; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XRGa/S12mFx0PkhT/OhMnZlP1ytmMdRCH2bmRlo84Qo=;
 b=cSAEe3PQG7H38Oxex4w/9rJVCYMuN8Kwak5qJPqAYH437Gfz706zabIQQEhYwhphN9
 xulcENGlni1RIWwAD9WFvP1UPEH7UcOsN33Pbi+DJag/RHdtYUA8fOgHXHwucXMGcxqI
 ANniuSHvJVpPBNaLACxsrQsMoBqV2FeDT9gupAk4kJSWukRDyMuFe1XASFz2EUhyJ/mV
 Yai3N9oxjNkhWqs83znkffEZMwih5klab+Iqm7p0LNvIbZiiblAr1MdD7pVJaR6N1Rwj
 XXqDDTHnp9ExEC6RobKLVopUcpq2uDjKQ0VLgXJGYpqUVMNlO7bkA6k2CpmZIALDAB8r
 JHAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699538918; x=1700143718;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XRGa/S12mFx0PkhT/OhMnZlP1ytmMdRCH2bmRlo84Qo=;
 b=TMWdXBb1MeKtNt0Q8tt+AvM80QbRk31KzgOog722GcyRT3aM/Df8hgoHy/te/7Volm
 t/oOElyzzey4Srr89z9Fb5ymzkNd3puyRY2Y4BcGrEtLy+jr67P6X+O7ZKP1cL5R7fD5
 Wm86KiYpUNIcVgPKWZ7DUKRD9cIXMCBqcucylvzcgz1ieNq5ifK9h1ws5y9S0MC+g2df
 hWIuyK3Jra7YoeVQY/zRv9slhWKf8VnXAyZgeeW3ImjlFIrH9cNOG0ABovEXblrDHccB
 Yur5s/ThRIkHGoxIDhE0X4UI4QOHzRRsPNtQOUNhWIw+zw+wTgq71eB+/ZbBeHITBING
 o/+w==
X-Gm-Message-State: AOJu0YzPoyHrrRxOzJD5TdTvqqluAqh/CFOCOHcwory0HQXzXSmC3taB
 uuWD8+q6gUDeSF1RDQjy1UtnbA==
X-Google-Smtp-Source: AGHT+IEzCGSetFEuIIEtU4qxbPuOkkjm/oMZjkVH0mbeTiEi6BLJnRMQfcgwCBy8VWLjJy1LjflW8w==
X-Received: by 2002:a17:907:9287:b0:9be:6ff7:128a with SMTP id
 bw7-20020a170907928700b009be6ff7128amr3935744ejc.67.1699538918364; 
 Thu, 09 Nov 2023 06:08:38 -0800 (PST)
Received: from [192.168.69.115] ([176.187.199.161])
 by smtp.gmail.com with ESMTPSA id
 fy23-20020a170906b7d700b0099b7276235esm2608206ejb.93.2023.11.09.06.08.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Nov 2023 06:08:37 -0800 (PST)
Message-ID: <92b72189-2271-4f3c-81a6-e064dacf1754@linaro.org>
Date: Thu, 9 Nov 2023 15:08:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] plugins: fix win plugin tests on cross compile
Content-Language: en-US
To: Greg Manning <gmanning@rapitasystems.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20231109124326.21106-1-gmanning@rapitasystems.com>
 <20231109124326.21106-2-gmanning@rapitasystems.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231109124326.21106-2-gmanning@rapitasystems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
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

On 9/11/23 13:43, Greg Manning wrote:
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1972
> 
> Cross compile gcc is more picky about argument order than msys. Changed
> the meson command to take the (now renamed) libqemu_plugin_api.a as a
> lib, rather than an object. This puts it in the right place on both
> native and cross compile gcc commands
> 
> Reenable plugins on crossbuilds
> 
> Signed-off-by: Greg Manning <gmanning@rapitasystems.com>
> ---
>   .gitlab-ci.d/crossbuilds.yml | 2 +-
>   contrib/plugins/Makefile     | 2 +-
>   plugins/meson.build          | 2 +-
>   tests/plugin/meson.build     | 3 ++-
>   4 files changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


