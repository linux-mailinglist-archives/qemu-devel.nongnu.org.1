Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4E4744562
	for <lists+qemu-devel@lfdr.de>; Sat,  1 Jul 2023 01:52:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFNty-00065u-6S; Fri, 30 Jun 2023 19:51:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qFNtw-00065l-PD
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 19:51:44 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qFNtu-0001ff-L7
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 19:51:44 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3fbc59de0e2so17541285e9.3
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 16:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688169101; x=1690761101;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pXDsI34i1451EU6nTfNWaPZVMsVpFnvzuESuTFWIR3A=;
 b=GO6cbt5ruWJ3PBRPy12jdvKsHH//F/BcVTG5hmv9om9CbcfQIfOn2YA3WUaYNwCK+0
 Wb4ooCS3rBWBe8OT5fYMbGldvBGF5oxQHIF7pfgNidLd3ZkUC/HJhNQYW5vdpCP7SSDF
 36GExXFc7L5CKYVXzr7pVqYGFlU6PNQhDNLGf+nO3GlRdIZbs+HaxEf8ZtmdyvZONKMr
 GK5eEWVyLcoB3v1pyETR8UlmiokDte2TO3uMy9ZqexXN4LIKmhxPOAmTq1KtjI8qUyVf
 feYRLl9tAsq8yI6++PBL+6jmJkPauBnD9wMvqZjd8QqZ9828Agffc6siUuoVMbT8cCUf
 8PfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688169101; x=1690761101;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pXDsI34i1451EU6nTfNWaPZVMsVpFnvzuESuTFWIR3A=;
 b=OkFfluk2HM5kcMPe00Xua8HKj+iVcDSBBLgGqpgsu7spzwYHSyp4qfSx2tPUETmu28
 9noUC3TLp+yZSlrOHO8WBnjmfLe7u7zcM7uaITnwZCElcLEQg2xiz0sDmvr8fZZnOt/s
 VoNKqxUqGPMicTib2JP1LCQ8KtGorqOmpr0AwpHHelJ0XjEZq77yFFImMCnLKuimW9PA
 p/GR21DodhHB1tJPhZlHAx4MhVAKRD6pSVtILj4HWX6pR9iYhNUp47j4WKepPAHJ2rUk
 SvPXvkmECQnbRi6k3mMJJkLiLLFd0SLjz4peKFegXn1q0mMaa4qXQ22B3cplEOvwqwme
 ySJA==
X-Gm-Message-State: AC+VfDz/S8jXIBHFDLUhQmNTXLsv2ie4vQGmmsblvGXsVovrwDAyfR+8
 BLORonsNfKoa9+iq2XnLmyc6uA==
X-Google-Smtp-Source: ACHHUZ5iz/jTpzCCfjH1gHm4EVOTCL7FKCR8XvBTL8ULVxhIA3DZViIEsgZQsxb1E7FTMpig8IY3JQ==
X-Received: by 2002:a7b:cd8f:0:b0:3fb:a1d0:a872 with SMTP id
 y15-20020a7bcd8f000000b003fba1d0a872mr3143013wmj.20.1688169101006; 
 Fri, 30 Jun 2023 16:51:41 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.211.104])
 by smtp.gmail.com with ESMTPSA id
 v14-20020a1cf70e000000b003f9b2c602c0sm23325322wmh.37.2023.06.30.16.51.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Jun 2023 16:51:40 -0700 (PDT)
Message-ID: <ded8a8b6-d09a-810f-e4f9-e9a4fb7e35b3@linaro.org>
Date: Sat, 1 Jul 2023 01:51:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PULL 17/33] ui/dbus: win32 support
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
References: <20230627130231.1614896-1-marcandre.lureau@redhat.com>
 <20230627130231.1614896-18-marcandre.lureau@redhat.com>
 <BCD39302-3C86-483C-A5FC-424F88CF791A@gmail.com>
 <CAMxuvayCrjNH5QnbWNWtiP1HrMNnnGYOdY142KzpTGj6hf9F8A@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <CAMxuvayCrjNH5QnbWNWtiP1HrMNnnGYOdY142KzpTGj6hf9F8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
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

On 30/6/23 23:41, Marc-André Lureau wrote:
> Hi
> 
> On Thu, Jun 29, 2023 at 7:55 PM Bernhard Beschow <shentey@gmail.com 
> <mailto:shentey@gmail.com>> wrote:
> 
> 
> 
>     Am 27. Juni 2023 13:02:14 UTC schrieb marcandre.lureau@redhat.com
>     <mailto:marcandre.lureau@redhat.com>:
>      >From: Marc-André Lureau <marcandre.lureau@redhat.com
>     <mailto:marcandre.lureau@redhat.com>>
>      >
>      >D-Bus doesn't support fd-passing on Windows (AF_UNIX doesn't have
>      >SCM_RIGHTS yet, but there are other means to share objects. I have
>      >proposed various solutions upstream, but none seem fitting enough
>     atm).
>      >
>      >To make the "-display dbus" work on Windows, implement an alternative
>      >D-Bus interface where all the 'h' (FDs) arguments are replaced with
>      >'ay' (WSASocketW data), and sockets are passed to the other end via
>      >WSADuplicateSocket().
>      >
>      >Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com
>     <mailto:marcandre.lureau@redhat.com>>
>      >Message-Id: <20230606115658.677673-6-marcandre.lureau@redhat.com
>     <mailto:20230606115658.677673-6-marcandre.lureau@redhat.com>>
>      >---
>      > meson.build          |  4 +--
>      > ui/dbus.h            |  6 +++++
>      > audio/dbusaudio.c    | 44 +++++++++++++++++++++++++++------
>      > ui/dbus-chardev.c    | 22 +++++++++++++----
>      > ui/dbus-console.c    | 59
>     ++++++++++++++++++++++++++++++++++++++------
>      > ui/dbus-display1.xml | 28 +++++++++++++++++++++
>      > ui/meson.build       |  9 ++++++-
>      > 7 files changed, 149 insertions(+), 23 deletions(-)
>      >
>      >diff --git a/meson.build b/meson.build
>      >index b409788832..9a1ce43471 100644
>      >--- a/meson.build
>      >+++ b/meson.build
>      >@@ -838,6 +838,8 @@ if gdbus_codegen.found() and get_option('cfi')
>      >   gdbus_codegen_error = '@0@ uses gdbus-codegen, which does not
>     support control flow integrity'
>      > endif
>      >
>      >+xml_pp = find_program('scripts/xml-preprocess.py')
>      >+
>      > lttng = not_found
>      > if 'ust' in get_option('trace_backends')
>      >   lttng = dependency('lttng-ust', required: true, version: '>= 2.1',
>      >@@ -1985,8 +1987,6 @@ dbus_display = get_option('dbus_display') \
>      >            error_message: '-display dbus requires glib>=2.64') \
>      >   .require(gdbus_codegen.found(),
>      >            error_message: gdbus_codegen_error.format('-display
>     dbus')) \
>      >-  .require(targetos != 'windows',
>      >-           error_message: '-display dbus is not available on
>     Windows') \
>      >   .allowed()
>      >
>      > have_virtfs = get_option('virtfs') \
>      >diff --git a/ui/dbus.h b/ui/dbus.h
>      >index 9c149e7b41..1e8c24a48e 100644
>      >--- a/ui/dbus.h
>      >+++ b/ui/dbus.h
>      >@@ -62,6 +62,12 @@ struct DBusDisplay {
>      >     Notifier notifier;
>      > };
>      >
>      >+#ifdef WIN32
>      >+bool
>      >+dbus_win32_import_socket(GDBusMethodInvocation *invocation,
>      >+                         GVariant *arg_listener, int *socket);
>      >+#endif
>      >+
>      > #define TYPE_DBUS_DISPLAY "dbus-display"
>      > OBJECT_DECLARE_SIMPLE_TYPE(DBusDisplay, DBUS_DISPLAY)
>      >
>      >diff --git a/audio/dbusaudio.c b/audio/dbusaudio.c
>      >index de59467d9e..7a11fbfb42 100644
>      >--- a/audio/dbusaudio.c
>      >+++ b/audio/dbusaudio.c
>      >@@ -33,6 +33,7 @@
>      > #include <gio/gunixfdlist.h>
>      > #endif
>      >
>      >+#include "ui/dbus.h"
> 
>     This patch causes below compile error since pixman.h isn't found. It
>     seems as if the pixman include path is missing. Since pixman.h is
>     found elsewhere in the same build I suspect that the DBUS audio
>     module now needs a pixman dependency -- which sounds a little bit
>     weired.
> 
>     FAILED: libaudio-dbus.a.p/audio_dbusaudio.c.o
>     cc -m64 -mcx16 -Ilibaudio-dbus.a.p -I. -I../src -Iqapi -Itrace -Iui
>     -Iui/shader -I/usr/include/glib-2.0 -I/usr/lib/glib-2.0/include
>     -I/usr/include/sysprof-4 -I/usr/include/libmount
>     -I/usr/include/blkid -I/usr/include/gio-unix-2.0
>     -fdiagnostics-color=auto -Wall -Winvalid-pch -Werror -std=gnu11 -O0
>     -g -fstack-protector-strong -Wundef -Wwrite-strings
>     -Wmissing-prototypes -Wstrict-prototypes -Wredundant-decls
>     -Wold-style-declaration -Wold-style-definition -Wtype-limits
>     -Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers
>     -Wempty-body -Wnested-externs -Wendif-labels -Wexpansion-to-defined
>     -Wimplicit-fallthrough=2 -Wmissing-format-attribute
>     -Wno-missing-include-dirs -Wno-shift-negative-value -Wno-psabi
>     -isystem qemu/src/linux-headers -isystem linux-headers -iquote .
>     -iquote qemu/src -iquote qemu/src/include -iquote
>     qemu/src/host/include/x86_64 -iquote qemu/src/host/include/generic
>     -iquote qemu/src/tcg/i386 -Wno-unused-function -pthread
>     -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE
>     -fno-strict-aliasing -fno-common -fwrapv -march=x86-64
>     -mtune=generic -O2 -pipe -fno-plt -fexceptions
>     -Wp,-D_FORTIFY_SOURCE=2 -Wformat -Werror=format-security
>     -fstack-clash-protection -fcf-protection -fPIC -DBUILD_DSO -MD -MQ
>     libaudio-dbus.a.p/audio_dbusaudio.c.o -MF
>     libaudio-dbus.a.p/audio_dbusaudio.c.o.d -o
>     libaudio-dbus.a.p/audio_dbusaudio.c.o -c ../src/audio/dbusaudio.c
>     In file included from qemu/src/include/ui/console.h:4,
>                       from qemu/src/ui/dbus.h:31,
>                       from ../src/audio/dbusaudio.c:36:
>     qemu/src/include/ui/qemu-pixman.h:12:10: fatal error: pixman.h: No
>     such file or directory
>         12 | #include <pixman.h>
>            |          ^~~~~~~~~~
> 
> 
> This is reported here:
> https://gitlab.com/qemu-project/qemu/-/issues/1739 
> <https://gitlab.com/qemu-project/qemu/-/issues/1739>
> 
> I am going to send the patch.

I just send a patch fixing this error, see:
https://lore.kernel.org/qemu-devel/20230630234839.14716-1-philmd@linaro.org/

