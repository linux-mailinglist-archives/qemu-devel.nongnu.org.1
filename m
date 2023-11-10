Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D2B7E8541
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 22:49:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1ZLw-0003dP-4G; Fri, 10 Nov 2023 16:47:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r1ZLu-0003dD-IL
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 16:47:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r1ZLs-0006ub-GD
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 16:47:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699652861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WpBjPQC4fWqAtmRHqryuLU9UJXarqcrl+f83Dw/3+2k=;
 b=ToQrLo8tQIJhNSbQp/PsxebAAnruNz70h7Sv+5CHC2ixDwZsPIxq7sWK1iNJQUNpOeDxjk
 sUPIwkMIAOUS3IL6XC520qzyU/s/ZdBYHp9arO2abSIdzBMxeAYzOZ+iK48BN6MJO/GAIV
 otR6soYL+uo+eE48AThts6NkMdRuibY=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-0J8llnSzNMSMF33L5kKD6A-1; Fri, 10 Nov 2023 16:47:39 -0500
X-MC-Unique: 0J8llnSzNMSMF33L5kKD6A-1
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-45ee5ccda9eso910845137.1
 for <qemu-devel@nongnu.org>; Fri, 10 Nov 2023 13:47:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699652859; x=1700257659;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WpBjPQC4fWqAtmRHqryuLU9UJXarqcrl+f83Dw/3+2k=;
 b=C5IB9CpwKMLrA0ef0PDVhDKbP+ySttvRa+wJIOAvTwZDzRCcgZYXNglB1J9dYWOEdH
 aKaUKT7pQvsDGTEAASKxejQMtvyJhmMs+yHuf1QlOUWAi24rMBcKsc5jaSuEt0JGksvN
 GzBowvE5MK1Tls6bucXDwsy6QYpS0HEHifHEvZAT4D16NDX8pYtXa/IB7TquAgF76Gbu
 EWq4LkWlidSmjrjtZuIxRznrtrkm7hQWOB7dY0T3oSNCd/EHD7WtMcqLxMqmEy2DveoQ
 /7sH6WBo93koRDXvLDOOLIy8g/d7XKjK9vGwjhTB4VFoWfxZzujq+MqlV0mB9PaEs4Yl
 W67A==
X-Gm-Message-State: AOJu0YztVnMa/ONqTf2lM+teZOwKupphuXyWPDGMc5N3TNnXWhiYs8d0
 JPsIQKa2lwpksSeifscTuy0XRzW4ikfQjAdbf5UuDwSGDI42wGmngPCafurkBA6O0v7JU5IJl3L
 mBGHicVuciAons0rDDtlMOZAMakW8h9g=
X-Received: by 2002:a67:cd17:0:b0:460:f899:da3b with SMTP id
 u23-20020a67cd17000000b00460f899da3bmr574634vsl.12.1699652859222; 
 Fri, 10 Nov 2023 13:47:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFMFin/Tuqbd1mkkT7UxCnuzN7+j9W1KJwPGzJypb/UQXg7pNyXrckDBO2HnHTL1SmqTmpRPXhAEgpXBdPP1zw=
X-Received: by 2002:a67:cd17:0:b0:460:f899:da3b with SMTP id
 u23-20020a67cd17000000b00460f899da3bmr574622vsl.12.1699652858933; Fri, 10 Nov
 2023 13:47:38 -0800 (PST)
MIME-Version: 1.0
References: <20231109092554.1253-1-gmanning@rapitasystems.com>
 <20231109092554.1253-2-gmanning@rapitasystems.com>
 <CWXP123MB43413EFD75E3292155EBAA0DD7AEA@CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM>
In-Reply-To: <CWXP123MB43413EFD75E3292155EBAA0DD7AEA@CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 10 Nov 2023 22:47:26 +0100
Message-ID: <CABgObfYrWEoR4YADU-0VbMZpCsmL=eRuFx0gz5Lp2H3c=LrDJQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] plugins: Move the windows linking function to qemu
To: Greg Manning <gmanning@rapitasystems.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Fri, Nov 10, 2023 at 6:36=E2=80=AFPM Greg Manning <gmanning@rapitasystem=
s.com> wrote:
> Then hopefully when a plugin links to this, it gets the __pfnDliFailureHo=
ok2
> symbol defined and set up and everything would work. Except gcc strips
> out any unreferenced symbols from static libs when linking. So the plugin
> would have to be linked thusly:
>
> gcc -shared -o my_plugin.dll -Wl,-u,__pfnDliFailureHook2 my_plugin.o qemu=
_plugin_api.lib
>
> But no other qemu-fiddling-with-things or extra code in plugins required.
>
> Hmm. Feels like half a solution. I wonder if there's a way to mark symbol=
s as
> "always required despite what dead code analysis says".

To be clear, I don't dislike at all the simpler solution where you
just add a macro like this:

#ifdef _WIN32
#define QEMU_PLUGIN_HOOK \
   /* contents of win32_linker.c */
#else
#define QEMU_PLUGIN_HOOK
#endif

and add QEMU_PLUGIN_HOOK to a source file of every plugin. But if you
would like to use a library, you can pass a linker script on the
command line as if it was a library, and the paths within the linker
script are resolved relative to the linker script itself. So you can
place in tests/plugins/meson.build something like:

# uses dlltool like it does now... can also use custom_target
delaylib =3D configure_file(output: 'qemu_plugin_api.lib',
   ...)
delayhook =3D static_library('qemu_delay_hook', sources: 'qemu_delay_hook.c=
')
plugin_api =3D configure_file(output : 'libqemu_plugin_api.a', input:
'libqemu_plugin_api.ld', copy: true, install_dir:
get_option('libdir'))

where the last configure_file creates a file with contents such as

INPUT(qemu_plugin_api.lib) # from dlltool
INPUT(libqemu_delay_hook.a) # compiled from qemu_delay_hook.c
EXTERN(__pfnDliNotifyHook2)  # equivalent to -Wl,-u

And then it should work to add link_depends: [delayhook, delaylib,
plugin_api], link_args: plugin_api as in your previous version.

Finally, since the hook will be built by ninja, you also need

diff --git a/Makefile b/Makefile
index 676a4a54f48..7b42d85f1dc 100644
--- a/Makefile
+++ b/Makefile
@@ -184,6 +184,7 @@ $(SUBDIR_RULES):
 ifneq ($(filter contrib/plugins, $(SUBDIRS)),)
 .PHONY: plugins
 plugins: contrib/plugins/all
+contrib/plugins/all: | run-ninja
 endif

 .PHONY: recurse-all recurse-clean

to ensure that the plugins are built after libqemu_delay_hook.a (of
course feel free to change the file names!).

The main disadvantage is that the Microsoft linker does not know
linker scripts, so that's a point in favor of the macro solution.

Paolo


