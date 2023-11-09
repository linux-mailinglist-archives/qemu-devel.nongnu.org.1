Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 816CC7E6D89
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 16:36:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r174i-00037K-Ny; Thu, 09 Nov 2023 10:36:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r174e-0002y6-3x
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 10:36:05 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r174c-0004Ce-2E
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 10:36:03 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-54394328f65so1589981a12.3
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 07:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699544159; x=1700148959; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dxwSs5ydF6OoPK8YrMN9dZkXUws8Kx+Ie6ylkJf0Ex0=;
 b=i2MfHa6hlL7CCZ53+KacX+4DpUxKO7Y+hsv8ArhfxfukabX4DhgsqM5w/3qlDoSvOd
 46skeGeBJl/m9zSdDN6Ft1VIY+dzJEw7PhJiTm3LxqPqS6n7H3P+ynxVt++N9bHf3idc
 ZACOFxc0tMBUbaKsQXlySeJmdjkqHG/Bl7sih+110XnC9MZ7oWfNkhOQs/VfFZdJUQKU
 y7ZhVIpxIiUxYlm5pYROJOSXP6mXFi0CaViVVvnEdesdz+oIKFcQ7vs4rNiLoThL4DwZ
 F4/J4r23273B2Ku1sOz7YBgS8Yn9CLcpsNRHg1nwNwSOwR2SmO2zi4qFjtnWRZUffzDJ
 mY0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699544159; x=1700148959;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dxwSs5ydF6OoPK8YrMN9dZkXUws8Kx+Ie6ylkJf0Ex0=;
 b=bVgL7pJZtqsv1+nvYkzXkAsQ0gYMURBmtuMd2LBSJ6T//7XYF1hHqY66szV7AdkrKq
 cofeyhQdCLGDEqFRMsYD8omK237mcmwzi5ffvvXmKdIVM6fIiz1K2jOfX9yaldip/Zt9
 pNi3gtfyuZoXROv8NtqUyvfWPBZnYBN7j0fcf38HpX6qkGzvAMeeINtZD+AUK7UWgQTO
 xlQ819WyvM2Bnun3V9WFhzyhzESW6xWbQrYI/Mzvb7koTKtbJliZsyIIqRZF8WkuJIZL
 8/j3rF8fOsmvei2G7m7XGJQ0B9jHwgaxc+2G9WxR/9acR3B9epAdtpKsn5GpvvyfjK/p
 F3bQ==
X-Gm-Message-State: AOJu0YzTUesLDxBAHFImggCWbfTl3VToSX8BPtpwQpCCDYC6WcHmbrKt
 OMtJZDhE9bYlZQwYPVzwsNQw2e8pb3v7IbBKQ2QpyQ==
X-Google-Smtp-Source: AGHT+IH9WA5/KxNKwPLmGXtE161vFAWeRO/vesd2OzT9INVyXhjciqki7iEPZpD4PlPOddu45TXYvQ==
X-Received: by 2002:a50:9b14:0:b0:538:a47:89d3 with SMTP id
 o20-20020a509b14000000b005380a4789d3mr4509942edi.21.1699544158835; 
 Thu, 09 Nov 2023 07:35:58 -0800 (PST)
Received: from [192.168.69.115] ([176.187.199.161])
 by smtp.gmail.com with ESMTPSA id
 p24-20020aa7d318000000b0053f9578ec97sm8129912edq.56.2023.11.09.07.35.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Nov 2023 07:35:58 -0800 (PST)
Message-ID: <737f6fe5-cf3e-4fdd-b5d8-28f71a2fa9e6@linaro.org>
Date: Thu, 9 Nov 2023 16:35:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-8.2] .gitlab-ci.d/cirrus.yml: Promote NetBSD job
 as gating
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Reinoud Zandijk <reinoud@netbsd.org>, Ryo ONODERA <ryoon@netbsd.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Daniel P . Berrange"
 <berrange@redhat.com>, Beraldo Leal <bleal@redhat.com>
References: <20231109153510.92353-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231109153510.92353-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52d.google.com
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

On 9/11/23 16:35, Philippe Mathieu-Daudé wrote:
> This Cirrus-CI based job takes ~12min, similarly to macOS job.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Based-on: <20231109150900.91186-1-philmd@linaro.org>
>            "tests/vm/netbsd: Use Python v3.11"
> ---
>   .gitlab-ci.d/cirrus.yml | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/.gitlab-ci.d/cirrus.yml b/.gitlab-ci.d/cirrus.yml
> index e7f1f83c2c..7b01acb104 100644
> --- a/.gitlab-ci.d/cirrus.yml
> +++ b/.gitlab-ci.d/cirrus.yml
> @@ -94,8 +94,6 @@ aarch64-macos-12-base-build:
>       - cirrus-run -v --show-build-log always .gitlab-ci.d/cirrus/$NAME.yml
>     variables:
>       QEMU_JOB_CIRRUS: 1
> -    QEMU_JOB_OPTIONAL: 1
> -
>   
>   x86-netbsd:
>     extends: .cirrus_kvm_job
> @@ -110,3 +108,4 @@ x86-openbsd:
>       NAME: openbsd
>       CONFIGURE_ARGS: --target-list=i386-softmmu,riscv64-softmmu,mips64-softmmu
>       TEST_TARGETS: check
> +    QEMU_JOB_OPTIONAL: 1

BTW OpenBSD works for me, but takes ~20min (similar to the FreeBSD job).

