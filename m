Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2510974ACF5
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 10:34:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHgug-0003Fu-2Z; Fri, 07 Jul 2023 04:34:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qHgud-0003FU-4f
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 04:33:59 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qHguX-0004Jk-OZ
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 04:33:55 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-992b27e1c55so198269166b.2
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 01:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688718832; x=1691310832;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GT2yk6kxYqHPwYutqCZ+uYL9TgjnU0zlEWYIJMaAZyM=;
 b=a+fCgejEcZ8GrtWyo1eSI3fhmMEniQkK6rgq/QzOz4rdqzgfjq8Q5th9AHmbf2EubQ
 A5b4zKVWCBWqE72m2eFhdh9/P6uuygmk1V1StgeHgksXFoKDKrpyAcwOU4kKm+2AceVw
 T0/JKFY3qGzNfC4r1bRNdXTYK5u0CSNgv0cmkVl4/ufqS2VadqzQTk+Ip7dAID6ywoYW
 soghbAZbC6JdqCBX8IvKcczTP6BfQ3mQoQll3rPt9yqzly/vdcWNE1tMhgV7uTDBnqWX
 YD//XWtE2IdDz2miQcYFHU0S31pKL69yijxRxqVbyZmKXyh/en3dvNiFlQf7JlWAAXM2
 uhCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688718832; x=1691310832;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GT2yk6kxYqHPwYutqCZ+uYL9TgjnU0zlEWYIJMaAZyM=;
 b=W5Lc+XKHP1FHJ3yRWNn85/lWQMuGu55tQsLDmxSfmsMDdK8+z0UoLcm+Twt/BPZ1zQ
 KJ+KNz5bNz4k5U/DOJZahHfo1lpFrUVlfCx2emlUq0t8hwORgWdYuaJJDE3zKYPAtGkD
 8VRc8eAhxBskQBVoj7PJpHTa1318qSgqWNG7RbbGkiz6i+eEyE7aKdmuY+cqmTdt9ee0
 DnptJTqCt5F0lQWv+P2bXYz+MRDsZ23iFO0Wx+c1OZPUBx66An/mFL+dXu4VLDdnnJe0
 RnxxOZSxRsY0QkmSypBy+h2F+Co3rmi0mqx4iG5f2nrnV/mQQ7fYM7pgiuCE+O1INMWA
 KzDA==
X-Gm-Message-State: ABy/qLaev8scmlbZdoQQbwrQwNcTNc5EPYSb9Nx6lHooTYgD5cLcuiV/
 Nd5l+U+tX2RwXC6tbsC5wmfgww==
X-Google-Smtp-Source: APBJJlG5GdC7ECZN/s0W2mh/uGtl/4GdS+iz082jmGQ5L/afE3kJM9Dj67w99RJUjf79UxAVFc/3cQ==
X-Received: by 2002:a17:907:8d11:b0:96f:8439:6143 with SMTP id
 tc17-20020a1709078d1100b0096f84396143mr3752092ejc.40.1688718831981; 
 Fri, 07 Jul 2023 01:33:51 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.215.192])
 by smtp.gmail.com with ESMTPSA id
 v26-20020a17090690da00b0098e4aef0791sm1877567ejw.66.2023.07.07.01.33.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Jul 2023 01:33:51 -0700 (PDT)
Message-ID: <a2f05a31-676a-a1d2-270e-56c525a22291@linaro.org>
Date: Fri, 7 Jul 2023 10:33:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 1/4] QGA VSS: Add wrapper to send log to debugger and
 stderr
Content-Language: en-US
To: Konstantin Kostiuk <kkostiuk@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Michael Roth <michael.roth@amd.com>
References: <20230707083105.746811-1-kkostiuk@redhat.com>
 <20230707083105.746811-2-kkostiuk@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230707083105.746811-2-kkostiuk@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
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

On 7/7/23 10:31, Konstantin Kostiuk wrote:
> Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
> ---
>   qga/vss-win32/meson.build   |  2 +-
>   qga/vss-win32/vss-debug.cpp | 31 +++++++++++++++++++++++++++++++
>   qga/vss-win32/vss-debug.h   | 24 ++++++++++++++++++++++++
>   3 files changed, 56 insertions(+), 1 deletion(-)
>   create mode 100644 qga/vss-win32/vss-debug.cpp
>   create mode 100644 qga/vss-win32/vss-debug.h
> 
> diff --git a/qga/vss-win32/meson.build b/qga/vss-win32/meson.build
> index 9483ccd3b8..0ac918910b 100644
> --- a/qga/vss-win32/meson.build
> +++ b/qga/vss-win32/meson.build
> @@ -7,7 +7,7 @@ link_args = cc.get_supported_link_arguments([
>   
>   qga_vss = shared_module(
>     'qga-vss',
> -  ['requester.cpp', 'provider.cpp', 'install.cpp', genh],
> +  ['requester.cpp', 'provider.cpp', 'install.cpp', 'vss-debug.cpp', genh],
>     name_prefix: '',
>     cpp_args: ['-Wno-unknown-pragmas', '-Wno-delete-non-virtual-dtor', '-Wno-non-virtual-dtor'],
>     link_args: link_args,
> diff --git a/qga/vss-win32/vss-debug.cpp b/qga/vss-win32/vss-debug.cpp
> new file mode 100644
> index 0000000000..de190a53f4
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
> +#include "vss-common.h"
> +
> +void G_GNUC_PRINTF(2, 3)

"G_GNUC_PRINTF(2, 3)" attribute goes with the declaration,
not the definition ...

> +qga_debug_internal(const char *funcname, const char *fmt, ...)  {
> +    char user_sting[512] = {0};
> +    char full_string[640] = {0};
> +
> +    va_list args;
> +    va_start(args, fmt);
> +    vsnprintf(user_sting, 512, fmt, args);
> +    va_end(args);
> +
> +    snprintf(full_string, 640, QGA_PROVIDER_NAME "[%lu]: %s %s\n",
> +             GetCurrentThreadId(), funcname, user_sting);
> +
> +    OutputDebugString(full_string);
> +    fprintf(stderr, "%s", full_string);
> +}
> diff --git a/qga/vss-win32/vss-debug.h b/qga/vss-win32/vss-debug.h
> new file mode 100644
> index 0000000000..4a15049a62
> --- /dev/null
> +++ b/qga/vss-win32/vss-debug.h
> @@ -0,0 +1,24 @@
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
> +#include <vss-handles.h>
> +
> +#ifndef VSS_DEBUG_H
> +#define VSS_DEBUG_H
> +

... here: "G_GNUC_PRINTF(2, 3)".

> +void qga_debug_internal(const char *funcname, const char *fmt, ...);
> +
> +#define qga_debug(fmt, ...) qga_debug_internal(__func__, fmt, ## __VA_ARGS__)
> +#define qga_debug_begin qga_debug("begin")
> +#define qga_debug_end qga_debug("end")
> +
> +#endif

Otherwise LGTM, thanks for the rework.


