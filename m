Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7862A7E6834
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 11:33:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r12Lb-0007ic-Dk; Thu, 09 Nov 2023 05:33:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu-daude@linaro.org>)
 id 1r12LY-0007iQ-A6
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 05:33:12 -0500
Received: from mail-qk1-x731.google.com ([2607:f8b0:4864:20::731])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu-daude@linaro.org>)
 id 1r12LJ-00008W-TN
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 05:33:10 -0500
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7789cc5c8ccso60604485a.0
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 02:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699525976; x=1700130776; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WRHV41HjbqwkytpjP7R0wen4xj42WGhuct82a0bgmFs=;
 b=UgSf9LSlWPXD56vykLPeHRUE+8H2VpJUqdixDQCccqzULBuaX0c68K+o6X5+t2fz6w
 PlWVpJAAp30WPPtt61G+SU1+nhLQr97y5avWjwGhPtB5JGIZdaidtLm0GuR8NgbZtjNi
 qHQ0NDVfdQZYwTkIkbn+WZR44Aitje+3uV7fGbaa3anGhTwXGA4IXKHzj7dlVBthcXdA
 yPnvucgIqvoucYpoerm5yzo82XxHq5jDmge6d4HUCJ7i5JU36zjbd9QiKE+qwyK8dumg
 LIyLhZfdRrwieAwMD04U95i8txvD7xIj/L7oLC+NcFEJ3b0Jjka9+UkIt9cRQGLxJY65
 Wg+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699525976; x=1700130776;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WRHV41HjbqwkytpjP7R0wen4xj42WGhuct82a0bgmFs=;
 b=OWhSg0Zlv3S3XoKR9UUFu2P/fWXKNJeLM1TQ2PE6twtr8Y5nZKr/dFUlykBwKmMNj4
 IdwJrU3seuaO0I3zao1x5RDG2DcXjNkNhy8xsKAl6T0fwF8qEi6oSn1NusJB69oVTFZf
 Rf0EJUE0DcF87TRPiIBgsCDfxihb/912sNNARfYKhuu8SHN0ACUiLz9x9m/DRWa/Ui9i
 4EEuEw/VNCTEGHNtcDGWVDUidODTfone150iaD6K8zNv3vA49p2Ysp+Zge+1Ve93KF1O
 UrOopgYKqJun6DGK4y6bX9WpOHsSEFTeD713fCsd8LqUsX0n7D7FJVl9c+eg0j9SNE+P
 DVOw==
X-Gm-Message-State: AOJu0YzQ9xD45VCje2aGbfheALChOnKyMw7oI3cxuWkX0m2DoEbyzlm6
 UP8DgE0pHJNlZj5VxxRWuMzj3uKQu1DO62ueObfL2Q==
X-Google-Smtp-Source: AGHT+IEboDMQdxtksnWJMatZecpWnSiOV/P7sVHciyIwmpDtgPkVtMn0ae7/k71FMC0ZZjsx6Mmz5zXUjdXHPVURXjk=
X-Received: by 2002:a05:620a:2907:b0:778:b30b:9839 with SMTP id
 m7-20020a05620a290700b00778b30b9839mr10907570qkp.23.1699525976160; Thu, 09
 Nov 2023 02:32:56 -0800 (PST)
MIME-Version: 1.0
References: <20231109091337.415-1-gmanning@rapitasystems.com>
In-Reply-To: <20231109091337.415-1-gmanning@rapitasystems.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Date: Thu, 9 Nov 2023 11:32:44 +0100
Message-ID: <CAPMQPEJozXXPGWTPPbRxUEWZsdEVrVrwuuqQJehwYN41PfL8rQ@mail.gmail.com>
Subject: Re: [PATCH] plugins: fix win plugin tests on cross compile
To: Greg Manning <gmanning@rapitasystems.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::731;
 envelope-from=philippe.mathieu-daude@linaro.org; helo=mail-qk1-x731.google.com
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

Does this match the GitLab pattern? See
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
>       $(CC) $(CFLAGS) $(PLUGIN_CFLAGS) -c -o $@ $<
>
>   ifeq ($(CONFIG_WIN32),y)
> -lib%$(SO_SUFFIX): %.o win32_linker.o ../../plugins/qemu_plugin_api.lib
> +lib%$(SO_SUFFIX): %.o win32_linker.o ../../plugins/libqemu_plugin_api.a
>       $(CC) -shared -o $@ $^ $(LDLIBS)
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

