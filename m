Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 533927C8689
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 15:15:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrI0Q-0008Kj-1u; Fri, 13 Oct 2023 09:15:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrI0K-0008Jt-VM
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 09:15:01 -0400
Received: from mail-il1-x132.google.com ([2607:f8b0:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrI0J-0006z7-8U
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 09:15:00 -0400
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-3574297c79eso7774195ab.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 06:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697202896; x=1697807696; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fJZhZn/fuAqrLtOfejeNJ7txTkdpvsiRI178zZhnyEU=;
 b=GhA6VQ4DKicLYoND2tNZseQcbtT9UOcKIcEJl+ZgiX52cSnOul/AJJKqkJSswQCSVx
 M1wrykO0ys6Vtc2l4KCYyXcShABeXOpAmEP851m8OhppS3PjF/yapHkt4OK7CluLeOgE
 CiyYx/u9xTbiCB5xSf90J8IuorpXz7xYmJD6BwBYCHukEDtIGxmRAf05i+mjoTJmv3eV
 fW9BcbheULfBwIG4+uG1r7h++WSuB8tKk4Cy4XdDo4d4UFwLe3lRj39sfy8XO6RQAQjO
 Nlst+9hlrIt2KUppgnCFhanYUHc1bSzlqlQxPvf8dNzlaKJO9TCTM2Rej88gskHMJ4Ry
 j07w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697202896; x=1697807696;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fJZhZn/fuAqrLtOfejeNJ7txTkdpvsiRI178zZhnyEU=;
 b=TDitB1HR7VJ1fu24UKnXl4Mz1N95RkYGaOtqmI3psXF2p0tob9TSFUTB80ENMB3W9y
 pNZ6E0uvAjgOZdp93JpsMJCPmLPyzNp0FltYvqHb3pB3n4LMGn+E061cp59VmCrutqBC
 bNIee7tD25HJLaYOMJnaY+MFPPE3Gq0u8k6VtyM4sHI/EC8o63PxqQamF/eojCSHzERK
 KWZRMjvA3aGwjWWhLj4z5rxpaBvcCMdl8LJgKuWaFqUmzBa8ZAXEfYdjfntTO+cu2Sd2
 zrmJLml5bHEELsiT468beVhIWe8GImkakKCKFypgh2TNqlzT3034UBr5ZhFNvO0BIN3y
 Ntsw==
X-Gm-Message-State: AOJu0Yyy//uy4YevEh0j+AslfOSIdvRtb/4CkXHGtNgA+L26lQMCvVoc
 ywFRov8VE87xCPTM7xC+afFQ/A==
X-Google-Smtp-Source: AGHT+IEw/bEUDpkPJPpBfhHJM54B6y/wvZQ5xotMSoEcVPnjk8gOWWIUf68qdgZE7DX5QyS815P+7g==
X-Received: by 2002:a92:d992:0:b0:357:5d8b:719b with SMTP id
 r18-20020a92d992000000b003575d8b719bmr3381571iln.9.1697202896641; 
 Fri, 13 Oct 2023 06:14:56 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 b23-20020a656697000000b005acd5d7e11bsm834522pgw.35.2023.10.13.06.14.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Oct 2023 06:14:56 -0700 (PDT)
Message-ID: <74d9f5d1-0bc7-4927-8c7a-1f37c2303596@linaro.org>
Date: Fri, 13 Oct 2023 06:14:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/arm/exynos4210: Get arm_boot_info declaration from
 'hw/arm/boot.h'
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20231013130214.95742-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231013130214.95742-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/13/23 06:02, Philippe Mathieu-Daudé wrote:
> struct arm_boot_info is declared in "hw/arm/boot.h".
> By including the correct header we don't need to declare
> it again in "target/arm/cpu-qom.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/arm/exynos4210.h | 2 +-
>   target/arm/cpu-qom.h        | 2 --
>   2 files changed, 1 insertion(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

