Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E99D370AD7C
	for <lists+qemu-devel@lfdr.de>; Sun, 21 May 2023 12:46:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0gYM-00011J-N0; Sun, 21 May 2023 06:44:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q0gYI-00010u-9x
 for qemu-devel@nongnu.org; Sun, 21 May 2023 06:44:38 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q0gYG-0007Ax-PK
 for qemu-devel@nongnu.org; Sun, 21 May 2023 06:44:38 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3f603ff9c02so701315e9.2
 for <qemu-devel@nongnu.org>; Sun, 21 May 2023 03:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684665875; x=1687257875;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nCN+5sKSFUxbOOonFCNh9PYrfwPB8kflQdSqCBv+5qU=;
 b=PPTPcF+meoDUtiGTPHpEP8KtMme08p71hEZ5dmzwMAPQSanI6OLSmft9RdiRYseLSS
 TYzPjGFuep06lFP94YbjsHwr/E4l30xPqWSI1P9TH424HLMeIq0/oGdm9FoEooUGkIem
 xXpR0/6PuRYQuGwWUT/lqdz0pdudMo3MjPcyVAj2GloomEX7CTL+fMmMFJITAfhPduwz
 /PKapB+H/7NKhU2Ba2JhfuuhIXYD28d1jET+6/TEtpCuTVKw9l6EgBeOakJm45uh2kXk
 6f+kRQeK2UKISZqena1ei4xKV0JHVAnhPRSJRX6m1JmWcHTxd3ORK90O0nY5s/GvykDX
 JjVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684665875; x=1687257875;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nCN+5sKSFUxbOOonFCNh9PYrfwPB8kflQdSqCBv+5qU=;
 b=JkgU3+FghQhdd48n054UF7RCarr3noFKWoAbd4tJLGp8HkvkCKyYess6VJ9z/aHlMq
 TqpNWi7JQoEmVFl172CzsypVPUaQK8X206rUwXsK5NnWUdJ6ubDKl+83Z6NpxK9HhxQ7
 G/VBZXarDYmZy5V4EwSD9OdUd9nzatcfbmHODlh4YjeN+qSLnXxFuHJYBlgRqHS8XaMk
 zw2Hi6As5/v3v14fMU3t7h3xYtS6+BFV6SHocdzUidvya9uCIW9mVh8kjb+wabO/KazA
 hSBRKqlO2JsIiljC/2+NTmgGxWgrQaNHcwsybTb5AeH4Wh21um9gKce82gHukjyLHm/d
 Pi9w==
X-Gm-Message-State: AC+VfDxVXO24/01Dpc9wUHJ9jzhsTPtaPGVYWP5F57kZIjJsmP2cfPPV
 JE806tPf7zVMUbmo/4Fu5wgu9w==
X-Google-Smtp-Source: ACHHUZ7+mjBRk1s3//c5TQhjVSpEGLvMbBI3jyKa9qhEJVXn3wZM+FEUw5/uenDPOt1JYZUQbLVOmA==
X-Received: by 2002:a7b:cb96:0:b0:3f4:1a97:ab09 with SMTP id
 m22-20020a7bcb96000000b003f41a97ab09mr5758272wmi.25.1684665874861; 
 Sun, 21 May 2023 03:44:34 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.152.177])
 by smtp.gmail.com with ESMTPSA id
 g3-20020a7bc4c3000000b003f427687ba7sm4779974wmk.41.2023.05.21.03.44.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 21 May 2023 03:44:34 -0700 (PDT)
Message-ID: <ca4a56fc-83b6-0892-45b5-d95406b1dab2@linaro.org>
Date: Sun, 21 May 2023 12:44:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 10/27] include/host: Split out atomic128-cas.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20230520162634.3991009-1-richard.henderson@linaro.org>
 <20230520162634.3991009-11-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230520162634.3991009-11-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.098,
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

On 20/5/23 18:26, Richard Henderson wrote:
> Separates the aarch64-specific portion into its own file.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   host/include/aarch64/host/atomic128-cas.h | 43 ++++++++++++++++++
>   host/include/generic/host/atomic128-cas.h | 43 ++++++++++++++++++
>   include/qemu/atomic128.h                  | 55 +----------------------
>   3 files changed, 87 insertions(+), 54 deletions(-)
>   create mode 100644 host/include/aarch64/host/atomic128-cas.h
>   create mode 100644 host/include/generic/host/atomic128-cas.h
> 
> diff --git a/host/include/aarch64/host/atomic128-cas.h b/host/include/aarch64/host/atomic128-cas.h
> new file mode 100644
> index 0000000000..1247995419
> --- /dev/null
> +++ b/host/include/aarch64/host/atomic128-cas.h
> @@ -0,0 +1,43 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + * Compare-and-swap for 128-bit atomic operations, generic version.

"Aarch64 specific"

> + *
> + * Copyright (C) 2018, 2023 Linaro, Ltd.
> + *
> + * See docs/devel/atomics.rst for discussion about the guarantees each
> + * atomic primitive is meant to provide.
> + */
> +
> +#ifndef AARCH64_ATOMIC128_CAS_H
> +#define AARCH64_ATOMIC128_CAS_H
> +
> +/* Through gcc 10, aarch64 has no support for 128-bit atomics.  */


