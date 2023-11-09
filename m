Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 254AD7E6828
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 11:32:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r12Iu-0006T5-4A; Thu, 09 Nov 2023 05:30:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r12Is-0006Sr-9S
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 05:30:26 -0500
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r12Ic-00087H-IW
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 05:30:26 -0500
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-507a98517f3so823801e87.0
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 02:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699525808; x=1700130608; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OR1GuzH1VpTmRsIa5M2Y3InV8XhPPUiU/2+QIdT+z8Q=;
 b=RkOIH+5eyP/FtzEStTvPQBa2XeMiDRFrYdt8AxY4TeYsNJ5yBE0jPoJAAut9rSv+3g
 AqT4/z3ZgPI0fL6WgYcHheU1vdwpGuXOMJIY6xfugX27NXeaUxRFXMZ1QhN7ZzoagNRL
 P3PDcSF15lwHi4fPBHPPhUvkOtSsYBbbAWTzRlWPuVRpqZvNQ7Lf6SwLqM1jqcgbpqf4
 +a2ImfwoJ+5aPoUbbJYz2cH/OF0jcr/VDLGcVWvdDdluklUSY6dpw1nHqj0ObuPlf3rw
 DidT/7Lt4Tgmh0N33xtme6urtubRUTeI8wousLNHfPIHd/mIzTRUdpERwODQwpFMpLL5
 4GEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699525808; x=1700130608;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OR1GuzH1VpTmRsIa5M2Y3InV8XhPPUiU/2+QIdT+z8Q=;
 b=BDStEn115Ba9ZJhq8Bx+IT2LQO2BXcYvxlSIV52bi9pn/jFRZGMddwSSa+bk+Fhf+H
 zMQb3qTHijLdkr6e5Oz5zeONInFsliWe2jIh7y5QnOIAWYCqrRbK3V0EMi5OCcqo57No
 HOTPqL7prB6AsfisN5QNHeCl35ONstL4bcWl3XXKFDK6Q7GNAhAOHzIn1PqTOkSRJg03
 ECjGs2QG6PYkWUc3at4yRomIeszziKWqdpSOf6XV7bancJiffJ4psE2nIBhpYFwJ1YF+
 oXWfYxYUkmRrctEqYlb+uZ2AAzMQvICS0FQje+CDdoX0SX2fGUyjQ42gAnKBqW50/WzL
 BbgA==
X-Gm-Message-State: AOJu0YzyC1gEVr8GKvV+O7f2piSXPwSl/rN3IrdSl9rQJZPs4QD5p3dH
 4O3eGlXOHolx/H4a1FERqv9Cig==
X-Google-Smtp-Source: AGHT+IHNhDg0c+Kh6Dgprz7OPwtddsJKp8w/F1fmsiRFWSd+mNzdCProNW2MNtStSLhXvbLfZ5c9Xg==
X-Received: by 2002:a19:8c0e:0:b0:503:a82:b371 with SMTP id
 o14-20020a198c0e000000b005030a82b371mr977582lfd.4.1699525807758; 
 Thu, 09 Nov 2023 02:30:07 -0800 (PST)
Received: from [192.168.16.175] (226.red-88-28-2.dynamicip.rima-tde.net.
 [88.28.2.226]) by smtp.gmail.com with ESMTPSA id
 20-20020a05600c025400b004065e235417sm1625235wmj.21.2023.11.09.02.30.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Nov 2023 02:30:07 -0800 (PST)
Message-ID: <bec71964-3c8a-4419-b96d-71db48b5b24b@linaro.org>
Date: Thu, 9 Nov 2023 11:30:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] plugins: fix win plugin tests on cross compile
Content-Language: en-US
To: Greg Manning <gmanning@rapitasystems.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20231109091337.415-1-gmanning@rapitasystems.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231109091337.415-1-gmanning@rapitasystems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Greg,

On 9/11/23 10:13, Greg Manning wrote:
> fixes #1927.

Does this match GitLab pattern? See
https://docs.gitlab.com/ee/user/project/issues/managing_issues.html#default-closing-pattern

We usually write:
"Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1927"

So there is no confusion between forked repositories, or when
commits are cherry-picked by stable distributions.

Are you sure this is #1927 "SPARC64 pci-bridge kernel panic"?

> Cross compile gcc is more picky about argument order than msys. Changed
> the meson command to take the (now renamed) libqemu_plugin_api.a as a
> lib, rather than an object. This puts it in the right place on both
> native and cross compile gcc commands
> 
> Reenable plugins on crossbuilds

Missing your Signed-off-by tag, see:
https://www.qemu.org/docs/master/devel/submitting-a-patch.html#patch-emails-must-include-a-signed-off-by-line

Otherwise LGTM, thanks for working on this issue!

Phil.

> ---
>   .gitlab-ci.d/crossbuilds.yml | 2 +-
>   contrib/plugins/Makefile     | 2 +-
>   plugins/meson.build          | 2 +-
>   tests/plugin/meson.build     | 3 ++-
>   4 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/.gitlab-ci.d/crossbuilds.yml b/.gitlab-ci.d/crossbuilds.yml
> index ac71a2abd3..56dd603a86 100644
> --- a/.gitlab-ci.d/crossbuilds.yml
> +++ b/.gitlab-ci.d/crossbuilds.yml
> @@ -165,7 +165,7 @@ cross-win32-system:
>       job: win32-fedora-cross-container
>     variables:
>       IMAGE: fedora-win32-cross
> -    EXTRA_CONFIGURE_OPTS: --enable-fdt=internal --disable-plugins
> +    EXTRA_CONFIGURE_OPTS: --enable-fdt=internal
>       CROSS_SKIP_TARGETS: alpha-softmmu avr-softmmu hppa-softmmu m68k-softmmu
>                           microblazeel-softmmu mips64el-softmmu nios2-softmmu
>     artifacts:
> diff --git a/contrib/plugins/Makefile b/contrib/plugins/Makefile
> index 1783750cf6..0b64d2c1e3 100644
> --- a/contrib/plugins/Makefile
> +++ b/contrib/plugins/Makefile
> @@ -49,7 +49,7 @@ all: $(SONAMES)
>   	$(CC) $(CFLAGS) $(PLUGIN_CFLAGS) -c -o $@ $<
>   
>   ifeq ($(CONFIG_WIN32),y)
> -lib%$(SO_SUFFIX): %.o win32_linker.o ../../plugins/qemu_plugin_api.lib
> +lib%$(SO_SUFFIX): %.o win32_linker.o ../../plugins/libqemu_plugin_api.a
>   	$(CC) -shared -o $@ $^ $(LDLIBS)
>   else ifeq ($(CONFIG_DARWIN),y)
>   lib%$(SO_SUFFIX): %.o
> diff --git a/plugins/meson.build b/plugins/meson.build
> index 40d24529c0..6b2d7a9292 100644
> --- a/plugins/meson.build
> +++ b/plugins/meson.build
> @@ -28,7 +28,7 @@ if get_option('plugins')
>       # then use dlltool to assemble a delaylib.
>       win32_qemu_plugin_api_lib = configure_file(
>         input: win32_plugin_def,
> -      output: 'qemu_plugin_api.lib',
> +      output: 'libqemu_plugin_api.a',
>         command: [dlltool, '--input-def', '@INPUT@',
>                   '--output-delaylib', '@OUTPUT@', '--dllname', 'qemu.exe']
>       )
> diff --git a/tests/plugin/meson.build b/tests/plugin/meson.build
> index 528bb9d86c..28a929dbcc 100644
> --- a/tests/plugin/meson.build
> +++ b/tests/plugin/meson.build
> @@ -4,7 +4,8 @@ if get_option('plugins')
>       if targetos == 'windows'
>         t += shared_module(i, files(i + '.c') + '../../contrib/plugins/win32_linker.c',
>                           include_directories: '../../include/qemu',
> -                        objects: [win32_qemu_plugin_api_lib],
> +                        link_depends: [win32_qemu_plugin_api_lib],
> +                        link_args: ['-Lplugins', '-lqemu_plugin_api'],
>                           dependencies: glib)
>   
>       else


