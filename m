Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A47D774B472
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 17:38:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHnVx-0007O0-GA; Fri, 07 Jul 2023 11:36:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qHnVv-0007KW-82
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 11:36:55 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qHnVt-00044e-AY
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 11:36:55 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-9922d6f003cso265713266b.0
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 08:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688744210; x=1691336210;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ibOdgAOdoZn2hvTsqFBAGP7hHtWJkh62FldR6WP6f44=;
 b=rTE4LJpxtWm817JkYvAAXjRPacZVtvjoiOKEG9km8boEwIErgKFTxvKSLFQNqCxdxR
 RgOayAJjC6IZC3jCzG2txKPL8bWqB9/aySBOY6iENVNf3nHpeLCV9A3ZloEvBu49M1it
 VtAWIKqR9jZ8hYXrwm2Kf7P5M59xQXG78rSdNd82cITtf6EUT0sEv6+c/aOfJcLKLy/V
 hDXceUGwrv9Ou+tZji33ZH0qUn9ThAM9sc3AQwr11B5DHd+iCKiB9zVAWcumEz49XZX7
 XCgnZYGgDKlytzt8o6GQC6S3KDCTFQcYo4XrJ60k3hjyOPhZ513R75Q/j/oEfiPhhglU
 D0Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688744210; x=1691336210;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ibOdgAOdoZn2hvTsqFBAGP7hHtWJkh62FldR6WP6f44=;
 b=Zfl07vhM49/uXk5ZK3ZVXJ3jtwPELhkTGCXG6ykpJomqx+tkjUuFGuTLaFzhVpaosC
 EdBHI2gtRDsZkMP+lIZOaPolxQ3Ke35ASHtYSKg4G2UlLwt0J/VrO4vMfIkFWvC+iCO1
 UTGi5XePlQmOLf+I0erJzpsbvypRz5cb/RaNhHVDXgh7P3WYnOLyC7LB7TKkvlVc9RFD
 dpOyCI8phju9ClBhMf3f4lGWlwiMOhwPDdOcsxIL5lWZlQ7Nwd1BzAY7hm7XtYLCuhE2
 Z/JPpZhf673AaKIZYmRxqi7SMSBMdmAI6d4F7sEgzx7MJiJh3xO1vltJhazvh3CicYAP
 c34g==
X-Gm-Message-State: ABy/qLaO0zRw5lHtcmSvgq+4jvoRIxLPSkjZ8OjujcXMnQ9mXWjlXASc
 jNXblNubPRsPxcE9R1rSu9zIig==
X-Google-Smtp-Source: APBJJlHVtFFljtCNFFrY46qKd/wc5OaJcVsd9bqh531DKZJp1rXHkZsF7Cqyu4FfNMmacerYGQ1trg==
X-Received: by 2002:a17:906:208c:b0:993:d7fe:7f1d with SMTP id
 12-20020a170906208c00b00993d7fe7f1dmr992943ejq.28.1688744210592; 
 Fri, 07 Jul 2023 08:36:50 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.215.192])
 by smtp.gmail.com with ESMTPSA id
 qu14-20020a170907110e00b00977ca5de275sm2382057ejb.13.2023.07.07.08.36.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Jul 2023 08:36:50 -0700 (PDT)
Message-ID: <20f5fded-a486-c184-9ee0-1e91c178d5fd@linaro.org>
Date: Fri, 7 Jul 2023 17:36:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v3 1/4] QGA VSS: Add wrapper to send log to debugger and
 stderr
Content-Language: en-US
To: Konstantin Kostiuk <kkostiuk@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?=
 <marcandre.lureau@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Eric Blake <eblake@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>
References: <20230707092258.768420-1-kkostiuk@redhat.com>
 <20230707092258.768420-2-kkostiuk@redhat.com>
 <c540330e-0adb-52a2-ab12-ba098212ce6f@linaro.org>
 <CAPMcbCrr6DxbNYRxm1uztaA7GG2A_MDb49VHuy26Cs7XA3bAuw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <CAPMcbCrr6DxbNYRxm1uztaA7GG2A_MDb49VHuy26Cs7XA3bAuw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.092,
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

On 7/7/23 16:24, Konstantin Kostiuk wrote:
> 
> 
> On Fri, Jul 7, 2023 at 1:33 PM Philippe Mathieu-Daudé <philmd@linaro.org 
> <mailto:philmd@linaro.org>> wrote:
> 
>     On 7/7/23 11:22, Konstantin Kostiuk wrote:
>      > Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com
>     <mailto:kkostiuk@redhat.com>>
>      > ---
>      >   qga/vss-win32/meson.build   |  2 +-
>      >   qga/vss-win32/vss-debug.cpp | 31 +++++++++++++++++++++++++++++++
>      >   qga/vss-win32/vss-debug.h   | 25 +++++++++++++++++++++++++
>      >   3 files changed, 57 insertions(+), 1 deletion(-)
>      >   create mode 100644 qga/vss-win32/vss-debug.cpp
>      >   create mode 100644 qga/vss-win32/vss-debug.h
> 
> 
>      > diff --git a/qga/vss-win32/vss-debug.cpp
>     b/qga/vss-win32/vss-debug.cpp
>      > new file mode 100644
>      > index 0000000000..5d6f37944b
>      > --- /dev/null
>      > +++ b/qga/vss-win32/vss-debug.cpp
>      > @@ -0,0 +1,31 @@
>      > +/*
>      > + * QEMU Guest Agent VSS debug declarations
>      > + *
>      > + * Copyright (C) 2023 Red Hat Inc
>      > + *
>      > + * Authors:
>      > + *  Konstantin Kostiuk <kkostiuk@redhat.com
>     <mailto:kkostiuk@redhat.com>>
>      > + *
>      > + * This work is licensed under the terms of the GNU GPL, version
>     2 or later.
>      > + * See the COPYING file in the top-level directory.
>      > + */
>      > +
>      > +#include "qemu/osdep.h"
>      > +#include "vss-debug.h"
>      > +#include "vss-common.h"
>      > +
>      > +void qga_debug_internal(const char *funcname, const char *fmt,
>     ...)  {
>      > +    char user_sting[512] = {0};
> 
>     "user_string"
> 
>      > +    char full_string[640] = {0};
>      > +
>      > +    va_list args;
>      > +    va_start(args, fmt);
>      > +    vsnprintf(user_sting, 512, fmt, args);
> 
>     ARRAY_SIZE(user_string)
> 
> 
> I have a problem with ARRAY_SIZE define.
> 
> ../qga/vss-win32/vss-debug.cpp: In function 'void 
> qga_debug_internal(const char*, const char*, ...)':
> /src/include/qemu/compiler.h:70:12: error: types may not be defined in 
> 'sizeof' expressions
>     70 |     struct { \
>        |            ^
> /src/include/qemu/compiler.h:78:43: note: in expansion of macro 
> 'QEMU_BUILD_BUG_ON_STRUCT'
>     78 | #define QEMU_BUILD_BUG_ON_ZERO(x) 
> (sizeof(QEMU_BUILD_BUG_ON_STRUCT(x)) - \
>        |                                           ^~~~~~~~~~~~~~~~~~~~~~~~
> /src/include/qemu/osdep.h:474:24: note: in expansion of macro 
> 'QEMU_BUILD_BUG_ON_ZERO'
>    474 |                        QEMU_BUILD_BUG_ON_ZERO(!QEMU_IS_ARRAY(x)))
>        |                        ^~~~~~~~~~~~~~~~~~~~~~
> ../qga/vss-win32/vss-debug.cpp:23:32: note: in expansion of macro 
> 'ARRAY_SIZE'
>     23 |     if (vsnprintf(user_string, ARRAY_SIZE(user_string), fmt, 
> args) <= 0) {
>        |                                ^~~~~~~~~~
> /src/include/qemu/osdep.h:470:57: error: expected primary-expression 
> before 'typeof'
>    470 | #define QEMU_IS_ARRAY(x) 
> (!__builtin_types_compatible_p(typeof(x), \
>        |                                                         ^~~~~~
> /src/include/qemu/compiler.h:71:14: note: in definition of macro 
> 'QEMU_BUILD_BUG_ON_STRUCT'
>     71 |         int:(x) ? -1 : 1; \
>        |              ^
> /src/include/qemu/osdep.h:474:24: note: in expansion of macro 
> 'QEMU_BUILD_BUG_ON_ZERO'
>    474 |                        QEMU_BUILD_BUG_ON_ZERO(!QEMU_IS_ARRAY(x)))
>        |                        ^~~~~~~~~~~~~~~~~~~~~~
> /src/include/qemu/osdep.h:474:48: note: in expansion of macro 
> 'QEMU_IS_ARRAY'
>    474 |                        QEMU_BUILD_BUG_ON_ZERO(!QEMU_IS_ARRAY(x)))
> 
> Can you help with this?

Eh no clue, maybe not C++ compliant?

Fall back to sizeof() ¯\_(ツ)_/¯

> 
> 
>      > +    va_end(args);
>      > +
>      > +    snprintf(full_string, 640, QGA_PROVIDER_NAME "[%lu]: %s %s\n",
>      > +             GetCurrentThreadId(), funcname, user_sting);
> 
>     if (snprintf() <= 0) { return; }
> 
>      > +
>      > +    OutputDebugString(full_string);
>      > +    fprintf(stderr, "%s", full_string);
> 
>     Format unused:
> 
>     fputs(full_string, stderr);
> 
>      > +}
> 
>     With the changes:
>     Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org
>     <mailto:philmd@linaro.org>>
> 


