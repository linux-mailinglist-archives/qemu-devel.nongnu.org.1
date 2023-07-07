Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 464FD74AEC4
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 12:33:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHilz-0007Lm-IO; Fri, 07 Jul 2023 06:33:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qHilx-0007LN-Lg
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 06:33:09 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qHilv-0002eG-Iu
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 06:33:09 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-51e362e4c61so1377560a12.0
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 03:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688725986; x=1691317986;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jXXdXbWeBnvkVQIEG7L1yNZQvKGh97tOn0tSbwLaUGo=;
 b=VHW09w2A63ZaAhxBL4vc6clp+bFA/DVsc7AHRc1lwBcqmk1ugvw7SZtGyjmTGoHVS1
 wIAMxmt0yiAuCwM2mjQ0tkqEtECCWHJNuhylj3kp1uQXUamJsPL+6LeDCqlJSUML/LP3
 UlL9z6Bn+9NZIzvZNDzphALrmV1in/RU/G2Np6Z6X+U92529CeWYKpA9EgCzn1HIm0iR
 Ws1QoWVwLKu2iKpkPOjwZLVNuL7plJizjPBbd2NtuXfIEWf889fb7VrxeNUw1sCdxskb
 MpPFG+J0R4qVBDE6ndFt1AE7GWoGwxHIe37CrfaBxj8xqBpbLs+wMcDswDYDq3w+anrv
 fXdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688725986; x=1691317986;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jXXdXbWeBnvkVQIEG7L1yNZQvKGh97tOn0tSbwLaUGo=;
 b=Wc2O3h2qejW3KBpKtpXEw7loWZFLmfk72s8McX7byWiwGfkmAvGgnKslo6d0RFvTqV
 +KYWlJp5E0YjLajpnRMnEAVD914U8qGZ9L9H7SIBoFxM6bApY6rH+VyASmTYbzNnqfEh
 gpwdXDOp+gEM/syJHmuRjgf59ZkWONQKsN2JqcHpCasvu9OtpKmtoKxF8fjrVLDYEWf1
 nsLbZEs+3bi8LFrDktaaOvAmFnmNxSG7B0x5QqbOAYB8zoKkD1eQD+ipPUXPSgPs4bP3
 pW3nxmW4iGRuZ1jP/RJxV9P20VoJJ7MJTDUCz4CwJBUE5rGlFcm3mqmpunbtzKOJQdLF
 yWkA==
X-Gm-Message-State: ABy/qLZXpaaguNttSvBnN808n2rCGrQ2EiOR/+gBuTTaUWjbGRP/Mk2g
 JumteU0QxVSs1GXppAr4hsuOaA==
X-Google-Smtp-Source: APBJJlGJ5BHznIyk/Y1F8gqUKpL/8Tf84jz7dcVXrmYfLCg6BOItcs10P+KXhAqzL0270Ei49OYZvw==
X-Received: by 2002:a17:906:5358:b0:992:6362:8866 with SMTP id
 j24-20020a170906535800b0099263628866mr4116859ejo.18.1688725985895; 
 Fri, 07 Jul 2023 03:33:05 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.215.192])
 by smtp.gmail.com with ESMTPSA id
 rh16-20020a17090720f000b00988be3c1d87sm2004129ejb.116.2023.07.07.03.33.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Jul 2023 03:33:05 -0700 (PDT)
Message-ID: <c540330e-0adb-52a2-ab12-ba098212ce6f@linaro.org>
Date: Fri, 7 Jul 2023 12:33:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v3 1/4] QGA VSS: Add wrapper to send log to debugger and
 stderr
Content-Language: en-US
To: Konstantin Kostiuk <kkostiuk@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Michael Roth <michael.roth@amd.com>
References: <20230707092258.768420-1-kkostiuk@redhat.com>
 <20230707092258.768420-2-kkostiuk@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230707092258.768420-2-kkostiuk@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 7/7/23 11:22, Konstantin Kostiuk wrote:
> Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
> ---
>   qga/vss-win32/meson.build   |  2 +-
>   qga/vss-win32/vss-debug.cpp | 31 +++++++++++++++++++++++++++++++
>   qga/vss-win32/vss-debug.h   | 25 +++++++++++++++++++++++++
>   3 files changed, 57 insertions(+), 1 deletion(-)
>   create mode 100644 qga/vss-win32/vss-debug.cpp
>   create mode 100644 qga/vss-win32/vss-debug.h


> diff --git a/qga/vss-win32/vss-debug.cpp b/qga/vss-win32/vss-debug.cpp
> new file mode 100644
> index 0000000000..5d6f37944b
> --- /dev/null
> +++ b/qga/vss-win32/vss-debug.cpp
> @@ -0,0 +1,31 @@
> +/*
> + * QEMU Guest Agent VSS debug declarations
> + *
> + * Copyright (C) 2023 Red Hat Inc
> + *
> + * Authors:
> + *  Konstantin Kostiuk <kkostiuk@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "vss-debug.h"
> +#include "vss-common.h"
> +
> +void qga_debug_internal(const char *funcname, const char *fmt, ...)  {
> +    char user_sting[512] = {0};

"user_string"

> +    char full_string[640] = {0};
> +
> +    va_list args;
> +    va_start(args, fmt);
> +    vsnprintf(user_sting, 512, fmt, args);

ARRAY_SIZE(user_string)

> +    va_end(args);
> +
> +    snprintf(full_string, 640, QGA_PROVIDER_NAME "[%lu]: %s %s\n",
> +             GetCurrentThreadId(), funcname, user_sting);

if (snprintf() <= 0) { return; }

> +
> +    OutputDebugString(full_string);
> +    fprintf(stderr, "%s", full_string);

Format unused:

fputs(full_string, stderr);

> +}

With the changes:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


