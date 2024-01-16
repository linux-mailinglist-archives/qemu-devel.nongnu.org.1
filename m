Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5043182EC57
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 10:57:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPgB5-0006SG-0b; Tue, 16 Jan 2024 04:56:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rPgB3-0006Rx-J7
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 04:56:13 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rPgB2-0006kN-16
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 04:56:13 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-557ad92cabbso9506385a12.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 01:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705398970; x=1706003770; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fD8iZVx1Kb45c+iS0qDf1hucW8J3ZTTlTbKWstGEz7Y=;
 b=op/8uDuU6pmRMb8eTMyXn/eA3gJ3TdKU6W4wy6UYGQWXg8qfkCGMp83LRxDsM4cs7x
 QOvvpRfpkjLr5FtLJAh3M2AoFENn5AYzZwMEeUgIU68Wjfyx05wOHGv8X0JroBB6wygw
 jGmRQzp+RGk77UFynM+VVVtkJiZuXymeHDPWeKfKjP5k2lqjcyXAJv3ld74J99BASYZ5
 DByAZyslFYdzExTdVBQwuLri/DNMtDVyQPIyz3AqrEwtx1GtQVQ5AviwGMsIPfuN4W6I
 kX1rjDHxtCK5HXzoD3xa6p8KnVyIzMl+elWMLk/gljFKJTKBOa5CbUSGVsZgFSd9IZNH
 /vwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705398970; x=1706003770;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fD8iZVx1Kb45c+iS0qDf1hucW8J3ZTTlTbKWstGEz7Y=;
 b=s2Yf37MNVMXiIDDZRiWsO06bHW15P2oFcY1hRBsGkXVhiHC/zKz+Jc4kFeWbScMxoF
 kY5Sy8qArPQ7tyYC9VA4s/k5N0rlCibexlZ7G0zFBAo9BeZ1c2ej5tMiZAwB41tjbq0P
 Nejrwrfnox7tRWjc0TVRhUVvoEXqvRWcYyEgEAZPYKeDcMmye5SGmP6+3KPWJWPzFhhm
 9ReOUxKGJcOiRToVdsNmTjbJi3TA75r6iBhEhbGKdNO2BLzTDROdCy/aCxNV647mtBAr
 8/dlSnLm0yEsInMKyU9cxy1vGGQOlCU9MGpFFfdyKPPDMm+P7jt9Fc99puipNm4XC0MM
 kpLQ==
X-Gm-Message-State: AOJu0YxV4TwyO4fieOoNJXATXKGdvJtnq/CgOpUa+7GAj12LZPcIk3sV
 C1iUrD6HF/U2c1s/bhGA8dWCA64ojSw6og==
X-Google-Smtp-Source: AGHT+IGhGjk0UWWtjJvRAVfbVIc9gUQbkRNjgx5NVwAzDm17dOaSUQdipj4+han8Rq/W+NXI0JZC3Q==
X-Received: by 2002:aa7:c39a:0:b0:558:c105:5eb9 with SMTP id
 k26-20020aa7c39a000000b00558c1055eb9mr1767691edq.68.1705398970248; 
 Tue, 16 Jan 2024 01:56:10 -0800 (PST)
Received: from [192.168.69.100] ([176.187.209.30])
 by smtp.gmail.com with ESMTPSA id
 g3-20020aa7c843000000b00558dcec1d4dsm5151022edt.76.2024.01.16.01.56.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jan 2024 01:56:09 -0800 (PST)
Message-ID: <f21da8aa-106c-4022-8ffc-1925f977dbdd@linaro.org>
Date: Tue, 16 Jan 2024 10:56:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] hw/arm: Add EHCI/OHCI controllers to Allwinner R40
 and Bananapi board
Content-Language: en-US
To: Guenter Roeck <linux@roeck-us.net>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
References: <20240115182757.1095012-1-linux@roeck-us.net>
 <20240115182757.1095012-2-linux@roeck-us.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240115182757.1095012-2-linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52e.google.com
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

On 15/1/24 19:27, Guenter Roeck wrote:
> Allwinner R40 supports two USB host ports shared between a USB 2.0 EHCI
> host controller and a USB 1.1 OHCI host controller. Add support for both
> of them.
> 
> If machine USB support is not enabled, create unimplemented devices
> for the USB memory ranges to avoid crashes when booting Linux.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: The USB Controllers are part of the chipset, so instantiate them
>      unconditionally
> 
>   docs/system/arm/bananapi_m2u.rst |  2 +-
>   hw/arm/Kconfig                   |  2 ++
>   hw/arm/allwinner-r40.c           | 47 ++++++++++++++++++++++++++++++--
>   include/hw/arm/allwinner-r40.h   |  9 ++++++
>   4 files changed, 57 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


