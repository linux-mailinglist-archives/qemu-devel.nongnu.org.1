Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C0D7DADE6
	for <lists+qemu-devel@lfdr.de>; Sun, 29 Oct 2023 19:54:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxAu3-0002Ih-NP; Sun, 29 Oct 2023 14:52:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxAu1-0002IX-Dy
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 14:52:49 -0400
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxAtz-0001Bg-LR
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 14:52:49 -0400
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-581b6b93bd1so2250513eaf.1
 for <qemu-devel@nongnu.org>; Sun, 29 Oct 2023 11:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698605566; x=1699210366; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=S0H258fM5ju3kdmzIlRXb1CGFvxvQ+S9grK7vYNht1Q=;
 b=ZAlieTUy2qXm2MXRsvaDv10cmtBZB3pyANG9luGHOZgbTkkaITyMt1pBZ0g32ysMBM
 esEree77gW3Ybn7WQJ0xUta0dUXOt7tR+Hza0CR3L4Hh7jio3GUKDf/xwqnUwvOnJvw8
 H2MVr2Kb8OtF21Tb6hDsGDhlNZVmFaIp0u3gK1vV4QwoZZMxG/vvt1HJAkVx8Sng7twE
 GMlJfUTLMQTBpItRd0d8rhir0obW8t7amQKptCAxTXctAA7GWYPJHFLnVHz2YPwhZ0v6
 PxPdhL+hpMpFhH40HXjm7vJWZPV6CySbHXkqyq1XIvnHKGm8fZg6x2iwPz7DMDSmgKAf
 bCZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698605566; x=1699210366;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=S0H258fM5ju3kdmzIlRXb1CGFvxvQ+S9grK7vYNht1Q=;
 b=imPtRfj4nWuVI1NrLJEjmwxOQYneGZmtdnJDntc5T1tO02hr/XadA6JGrP4FO1lcWf
 nkKp+VlCsbW+37W7qWN8yse+UCcxpSowgsUrAWhaua4I/qrcnV0FjaaDTY6IOWvqG9h7
 jGJmP3KcsDaGxvWClv0ym/GtUcE9gX/wXFzWGSrdQcwgt51RCA1qjSLCORSw5ddfits0
 9yTe974fFtKJKP/gEe2+lTxwgUtFPnj8f3yDlKyb0PglKYdHe4No86oRkBokh1d9kbjj
 pZJus9tP3Dewq13DfGCxRo81dUc87GsXe3pVeIGhWjfu+ga0lhpJ1gfwzgFzU867i27b
 TzuQ==
X-Gm-Message-State: AOJu0YxbNchD8JylFfquEhA9qZbybM0VqCijgmNmk36b52gdsk9+sKlV
 VeacOC6g/6G6liWu8RhX1gVonw==
X-Google-Smtp-Source: AGHT+IHcMPFcIk0jjOWHFjbVRk8z4M5fJ6m0EZ0JIG/J8GYEi8Rb280fM3P2iI1FqLx57fDgEiHb9g==
X-Received: by 2002:a05:6358:904c:b0:168:dbac:b94e with SMTP id
 f12-20020a056358904c00b00168dbacb94emr10454126rwf.32.1698605565835; 
 Sun, 29 Oct 2023 11:52:45 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 pt11-20020a17090b3d0b00b0027d15bd9fa2sm3951159pjb.35.2023.10.29.11.52.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 Oct 2023 11:52:45 -0700 (PDT)
Message-ID: <9427da20-92c4-4d98-9073-3f7050d7f7c0@linaro.org>
Date: Sun, 29 Oct 2023 11:52:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/19] tests/docker: move sh4 to use
 debian-legacy-test-cross
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20231029145033.592566-1-alex.bennee@linaro.org>
 <20231029145033.592566-8-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231029145033.592566-8-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2b.google.com
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

On 10/29/23 07:50, Alex Bennée wrote:
> diff --git a/tests/docker/dockerfiles/debian-all-test-cross.docker b/tests/docker/dockerfiles/debian-all-test-cross.docker
> index 205173b0a5..43cc083318 100644
> --- a/tests/docker/dockerfiles/debian-all-test-cross.docker
> +++ b/tests/docker/dockerfiles/debian-all-test-cross.docker
> @@ -52,8 +52,6 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata \
>           libc6-dev-riscv64-cross \
>           gcc-s390x-linux-gnu \
>           libc6-dev-s390x-cross \
> -        gcc-sh4-linux-gnu \
> -        libc6-dev-sh4-cross \

compiler removed here...

> diff --git a/tests/docker/dockerfiles/debian-legacy-test-cross.docker b/tests/docker/dockerfiles/debian-legacy-test-cross.docker
> index 763d36dfe3..d9b37995a2 100644
> --- a/tests/docker/dockerfiles/debian-legacy-test-cross.docker
> +++ b/tests/docker/dockerfiles/debian-legacy-test-cross.docker
> @@ -4,6 +4,7 @@
>   # upgrade. Currently:
>   #
>   #   libc6.1-dev-alpha-cross: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1054412
> +#   sh4-linux-user: binaries don't run with bookworm compiler
>   #
>   # As we are targeting check-tcg here we only need minimal qemu
>   # dependencies and the relevant cross compilers.
> @@ -38,7 +39,7 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata \
>   RUN /usr/bin/pip3 install tomli
>   
>   ENV QEMU_CONFIGURE_OPTS --disable-system --disable-docs --disable-tools
> -ENV DEF_TARGET_LIST alpha-linux-user
> +ENV DEF_TARGET_LIST alpha-linux-user,sh4-linux-user

... but not added here.


r~

