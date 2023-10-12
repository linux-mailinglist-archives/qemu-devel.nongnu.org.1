Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3218E7C641B
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 06:34:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqnO6-0005mY-Ma; Thu, 12 Oct 2023 00:33:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqnO4-0005l1-EX
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:33:28 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqnO2-0007Nx-KD
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:33:28 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-53d9b94731aso1025081a12.1
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 21:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697085205; x=1697690005; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ykmK7ohMq+bsd07Y3RHClvJewDe3d3C6tAcWqJt2J8A=;
 b=JNUEpX3O4h0VG7np2XcDBGSqbthP+EPVzqJdPyib4V20g0nSLUCWXH0XK9hJiL3FAV
 gtw2+KWyz17eUINe3aCh2DKBwDzL1wevVyHdJx1Vv3dov37UbR37FInDxq7ZYIV6YJQS
 rEonNYupkZb70eRWCZiLtCB5PBxbV1MdvqeXgOF8CDYMsiEzz7iJ/mil/h/7gXm1ET2K
 UyA0eLxrhhQ1v0voKA8WNPiix9V+IYyJMfkyUMs4GXHjIKz26YtvxGA/Mnd/8uzLAZi6
 jo38Xilaaku51w28/iTxgLhZnI59XJfInrO9+Sr7yUqKzKlSADhhYAccpxQaI9HnreDM
 C+rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697085205; x=1697690005;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ykmK7ohMq+bsd07Y3RHClvJewDe3d3C6tAcWqJt2J8A=;
 b=YfFnwGmNQoODaoUn/T9BchFGluWJIobdfe3pSuhMokNqwcbAyDSwJjPJsiqRFiuIeH
 FNkI/0tfkDK4vIcF/AVadf3vpegJeSaYuuqC9J5avcTfo1QO7UwhpOC4dHzX9JOS8Nj3
 1XG3rt4uN2Gu1/XNOkW0oAnW7vfiU4RaknBq8udgJlrsYa4sPy6D5LAsSRACW5ZCj7bQ
 FKCeyAJvw78071M/eWbHSWdTdd4kooreCWoqHoFiuFhOdAv9auYImTHELrF2tYbltopV
 OuSFN0VeIlPsGcTcjEUjsjbeliqemqO+1JMh3X6PpC0DyolMQRjhcriGsDYYwWLviVdN
 G48w==
X-Gm-Message-State: AOJu0YyKxTS+2e1Di/PMEWRxSuEzzJE3e40N56ASm38AHZ6Qz5S7w4X8
 ienJ5T2Pyb1566TsXu8o3ySb69tCz+rVC9qG8M0=
X-Google-Smtp-Source: AGHT+IFKmQp0XKFTqDmIDwyLA84oj/3DnplzTquPg0r2ubTsYh8FGeUu27UQ9VLRgZYJeYm/QV99tg==
X-Received: by 2002:a05:6402:1641:b0:533:87c9:4a81 with SMTP id
 s1-20020a056402164100b0053387c94a81mr20229604edx.29.1697085205042; 
 Wed, 11 Oct 2023 21:33:25 -0700 (PDT)
Received: from [192.168.69.115] (dcs23-h01-176-173-173-31.dsl.sta.abo.bbox.fr.
 [176.173.173.31]) by smtp.gmail.com with ESMTPSA id
 e20-20020a056402089400b005330e1e7da0sm9520565edy.92.2023.10.11.21.33.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 21:33:23 -0700 (PDT)
Message-ID: <d4814468-3b1c-ea34-563e-9418bf1d6220@linaro.org>
Date: Thu, 12 Oct 2023 06:33:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [RFC/PATCH v0 03/12] gunyah: Basic support
Content-Language: en-US
To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>, peter.maydell@linaro.org, 
 alex.bennee@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: quic_tsoni@quicinc.com, quic_pheragu@quicinc.com,
 quic_eberman@quicinc.com, quic_yvasi@quicinc.com, quic_cvanscha@quicinc.com,
 quic_mnalajal@quicinc.com
References: <20231011165234.1323725-1-quic_svaddagi@quicinc.com>
 <20231011165234.1323725-4-quic_svaddagi@quicinc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231011165234.1323725-4-quic_svaddagi@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Srivatsa,

On 11/10/23 18:52, Srivatsa Vaddagiri wrote:
> Add a new accelerator, gunyah, with basic functionality of creating a
> VM. Subsequent patches will add support for other functions required to
> run a VM.
> 
> Signed-off-by: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
> ---
>   MAINTAINERS                     |   7 +++
>   accel/Kconfig                   |   3 +
>   accel/gunyah/gunyah-accel-ops.c | 102 ++++++++++++++++++++++++++++++++
>   accel/gunyah/gunyah-all.c       |  70 ++++++++++++++++++++++
>   accel/gunyah/meson.build        |   7 +++
>   accel/meson.build               |   1 +
>   accel/stubs/gunyah-stub.c       |  13 ++++
>   accel/stubs/meson.build         |   1 +
>   docs/about/build-platforms.rst  |   2 +-
>   hw/arm/virt.c                   |   3 +
>   include/sysemu/gunyah.h         |  43 ++++++++++++++
>   include/sysemu/gunyah_int.h     |  27 +++++++++
>   meson.build                     |   9 +++
>   meson_options.txt               |   2 +
>   scripts/meson-buildoptions.sh   |   3 +
>   target/arm/cpu64.c              |   5 +-
>   16 files changed, 295 insertions(+), 3 deletions(-)
>   create mode 100644 accel/gunyah/gunyah-accel-ops.c
>   create mode 100644 accel/gunyah/gunyah-all.c
>   create mode 100644 accel/gunyah/meson.build
>   create mode 100644 accel/stubs/gunyah-stub.c
>   create mode 100644 include/sysemu/gunyah.h
>   create mode 100644 include/sysemu/gunyah_int.h

Can we move gunyah_int.h to accel/gunyah/?

