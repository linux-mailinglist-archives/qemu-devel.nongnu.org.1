Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE6D744405
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 23:43:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFLs8-0003Ii-KA; Fri, 30 Jun 2023 17:41:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qFLs6-0003IT-Ir
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 17:41:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qFLs4-0000Ql-6D
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 17:41:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688161298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Lrumyym5LBiUwyNLvDDXDp5xYFJUkx/nUvoEv5UCWeM=;
 b=NBbAsw4JnUv8qpETgspcKn7Gkyfk9q2YSywfBALwEDKLL8xtgXjetbOvzyJTvoK7ocA/Q2
 SxX8/lKWS8HG/Kf8QoB+dDzI+tLcpMEQhei2BUKRp+GGYBykg96dabjlX9npcNxGUxke5j
 BwCxgmrScsjTzT5jBaVg3KNooyfHiqQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-5Fk_lFhYO6-c0AVSwE6nWw-1; Fri, 30 Jun 2023 17:41:36 -0400
X-MC-Unique: 5Fk_lFhYO6-c0AVSwE6nWw-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-51daef984f5so1453286a12.2
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 14:41:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688161295; x=1690753295;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Lrumyym5LBiUwyNLvDDXDp5xYFJUkx/nUvoEv5UCWeM=;
 b=EF7FFyMqNiyWVhmFCkfUFeqMDmrgwUOZCO79lLe8AN3fAlk3iywwkH04dBoN1MdBb1
 LgsZDrcN+5zcmIsHlaWTVI/L5jq+cbAGf0ZDv5i1TXFsPkgGSWyEZydw2K1PBoPBc3Ct
 cYjKcjOZuZygL0D3mKZWxZAyVh8271jB0JJtBYOUPnkkofdZS8Ka6Yn3l9ZvawMUeny5
 vVddMPwtQRcSPtl6G096Kl7klGX+g2zILCmQJHQ/4BcwrB7MP8szaQInxAfIxCgGiEtZ
 1+basAr3Fvzwij6qDPppVFVLCg8AKH6D48c92QlwKPYrbKmPU8epEphwPQ68Ng3MmJ1a
 j7Xw==
X-Gm-Message-State: ABy/qLZAe/q/3iZOWNQlPfleOD8nabaU4/HmECwUlwCpAEVjDMDB0qps
 S50F/zTS9kxoMTKAXlPLkjgDaAV1sthflVUyZREDJR9UwA738nPVhN4bBDEwkudPSstcpUNUtSD
 TXMPyyGRXxPvNpICoH0vEpl4IG8G2oZw=
X-Received: by 2002:a05:6402:559:b0:51d:e17c:e1 with SMTP id
 i25-20020a056402055900b0051de17c00e1mr2291737edx.17.1688161295170; 
 Fri, 30 Jun 2023 14:41:35 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFvjWY6yQdLj2GFImnGfMqmh9/CK8yROF7loYOPeGQbticjmujTcKnX4fQzkIexDQADpcK9+CI/CaQuAqjtYAw=
X-Received: by 2002:a05:6402:559:b0:51d:e17c:e1 with SMTP id
 i25-20020a056402055900b0051de17c00e1mr2291724edx.17.1688161294719; Fri, 30
 Jun 2023 14:41:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230627130231.1614896-1-marcandre.lureau@redhat.com>
 <20230627130231.1614896-18-marcandre.lureau@redhat.com>
 <BCD39302-3C86-483C-A5FC-424F88CF791A@gmail.com>
In-Reply-To: <BCD39302-3C86-483C-A5FC-424F88CF791A@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 30 Jun 2023 23:41:23 +0200
Message-ID: <CAMxuvayCrjNH5QnbWNWtiP1HrMNnnGYOdY142KzpTGj6hf9F8A@mail.gmail.com>
Subject: Re: [PULL 17/33] ui/dbus: win32 support
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, 
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000004bb66e05ff5fae22"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--0000000000004bb66e05ff5fae22
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Thu, Jun 29, 2023 at 7:55=E2=80=AFPM Bernhard Beschow <shentey@gmail.com=
> wrote:

>
>
> Am 27. Juni 2023 13:02:14 UTC schrieb marcandre.lureau@redhat.com:
> >From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> >D-Bus doesn't support fd-passing on Windows (AF_UNIX doesn't have
> >SCM_RIGHTS yet, but there are other means to share objects. I have
> >proposed various solutions upstream, but none seem fitting enough atm).
> >
> >To make the "-display dbus" work on Windows, implement an alternative
> >D-Bus interface where all the 'h' (FDs) arguments are replaced with
> >'ay' (WSASocketW data), and sockets are passed to the other end via
> >WSADuplicateSocket().
> >
> >Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >Message-Id: <20230606115658.677673-6-marcandre.lureau@redhat.com>
> >---
> > meson.build          |  4 +--
> > ui/dbus.h            |  6 +++++
> > audio/dbusaudio.c    | 44 +++++++++++++++++++++++++++------
> > ui/dbus-chardev.c    | 22 +++++++++++++----
> > ui/dbus-console.c    | 59 ++++++++++++++++++++++++++++++++++++++------
> > ui/dbus-display1.xml | 28 +++++++++++++++++++++
> > ui/meson.build       |  9 ++++++-
> > 7 files changed, 149 insertions(+), 23 deletions(-)
> >
> >diff --git a/meson.build b/meson.build
> >index b409788832..9a1ce43471 100644
> >--- a/meson.build
> >+++ b/meson.build
> >@@ -838,6 +838,8 @@ if gdbus_codegen.found() and get_option('cfi')
> >   gdbus_codegen_error =3D '@0@ uses gdbus-codegen, which does not suppo=
rt
> control flow integrity'
> > endif
> >
> >+xml_pp =3D find_program('scripts/xml-preprocess.py')
> >+
> > lttng =3D not_found
> > if 'ust' in get_option('trace_backends')
> >   lttng =3D dependency('lttng-ust', required: true, version: '>=3D 2.1'=
,
> >@@ -1985,8 +1987,6 @@ dbus_display =3D get_option('dbus_display') \
> >            error_message: '-display dbus requires glib>=3D2.64') \
> >   .require(gdbus_codegen.found(),
> >            error_message: gdbus_codegen_error.format('-display dbus')) =
\
> >-  .require(targetos !=3D 'windows',
> >-           error_message: '-display dbus is not available on Windows') =
\
> >   .allowed()
> >
> > have_virtfs =3D get_option('virtfs') \
> >diff --git a/ui/dbus.h b/ui/dbus.h
> >index 9c149e7b41..1e8c24a48e 100644
> >--- a/ui/dbus.h
> >+++ b/ui/dbus.h
> >@@ -62,6 +62,12 @@ struct DBusDisplay {
> >     Notifier notifier;
> > };
> >
> >+#ifdef WIN32
> >+bool
> >+dbus_win32_import_socket(GDBusMethodInvocation *invocation,
> >+                         GVariant *arg_listener, int *socket);
> >+#endif
> >+
> > #define TYPE_DBUS_DISPLAY "dbus-display"
> > OBJECT_DECLARE_SIMPLE_TYPE(DBusDisplay, DBUS_DISPLAY)
> >
> >diff --git a/audio/dbusaudio.c b/audio/dbusaudio.c
> >index de59467d9e..7a11fbfb42 100644
> >--- a/audio/dbusaudio.c
> >+++ b/audio/dbusaudio.c
> >@@ -33,6 +33,7 @@
> > #include <gio/gunixfdlist.h>
> > #endif
> >
> >+#include "ui/dbus.h"
>
> This patch causes below compile error since pixman.h isn't found. It seem=
s
> as if the pixman include path is missing. Since pixman.h is found elsewhe=
re
> in the same build I suspect that the DBUS audio module now needs a pixman
> dependency -- which sounds a little bit weired.
>
> FAILED: libaudio-dbus.a.p/audio_dbusaudio.c.o
> cc -m64 -mcx16 -Ilibaudio-dbus.a.p -I. -I../src -Iqapi -Itrace -Iui
> -Iui/shader -I/usr/include/glib-2.0 -I/usr/lib/glib-2.0/include
> -I/usr/include/sysprof-4 -I/usr/include/libmount -I/usr/include/blkid
> -I/usr/include/gio-unix-2.0 -fdiagnostics-color=3Dauto -Wall -Winvalid-pc=
h
> -Werror -std=3Dgnu11 -O0 -g -fstack-protector-strong -Wundef -Wwrite-stri=
ngs
> -Wmissing-prototypes -Wstrict-prototypes -Wredundant-decls
> -Wold-style-declaration -Wold-style-definition -Wtype-limits
> -Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers
> -Wempty-body -Wnested-externs -Wendif-labels -Wexpansion-to-defined
> -Wimplicit-fallthrough=3D2 -Wmissing-format-attribute
> -Wno-missing-include-dirs -Wno-shift-negative-value -Wno-psabi -isystem
> qemu/src/linux-headers -isystem linux-headers -iquote . -iquote qemu/src
> -iquote qemu/src/include -iquote qemu/src/host/include/x86_64 -iquote
> qemu/src/host/include/generic -iquote qemu/src/tcg/i386
> -Wno-unused-function -pthread -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64
> -D_LARGEFILE_SOURCE -fno-strict-aliasing -fno-common -fwrapv -march=3Dx86=
-64
> -mtune=3Dgeneric -O2 -pipe -fno-plt -fexceptions -Wp,-D_FORTIFY_SOURCE=3D=
2
> -Wformat -Werror=3Dformat-security -fstack-clash-protection -fcf-protecti=
on
> -fPIC -DBUILD_DSO -MD -MQ libaudio-dbus.a.p/audio_dbusaudio.c.o -MF
> libaudio-dbus.a.p/audio_dbusaudio.c.o.d -o
> libaudio-dbus.a.p/audio_dbusaudio.c.o -c ../src/audio/dbusaudio.c
> In file included from qemu/src/include/ui/console.h:4,
>                  from qemu/src/ui/dbus.h:31,
>                  from ../src/audio/dbusaudio.c:36:
> qemu/src/include/ui/qemu-pixman.h:12:10: fatal error: pixman.h: No such
> file or directory
>    12 | #include <pixman.h>
>       |          ^~~~~~~~~~
>
>
This is reported here:
https://gitlab.com/qemu-project/qemu/-/issues/1739

I am going to send the patch.

--0000000000004bb66e05ff5fae22
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jun 29, 2023 at 7:55=E2=80=
=AFPM Bernhard Beschow &lt;<a href=3D"mailto:shentey@gmail.com">shentey@gma=
il.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex"><br>
<br>
Am 27. Juni 2023 13:02:14 UTC schrieb <a href=3D"mailto:marcandre.lureau@re=
dhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>:<br>
&gt;From: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@red=
hat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
&gt;<br>
&gt;D-Bus doesn&#39;t support fd-passing on Windows (AF_UNIX doesn&#39;t ha=
ve<br>
&gt;SCM_RIGHTS yet, but there are other means to share objects. I have<br>
&gt;proposed various solutions upstream, but none seem fitting enough atm).=
<br>
&gt;<br>
&gt;To make the &quot;-display dbus&quot; work on Windows, implement an alt=
ernative<br>
&gt;D-Bus interface where all the &#39;h&#39; (FDs) arguments are replaced =
with<br>
&gt;&#39;ay&#39; (WSASocketW data), and sockets are passed to the other end=
 via<br>
&gt;WSADuplicateSocket().<br>
&gt;<br>
&gt;Signed-off-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.l=
ureau@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
&gt;Message-Id: &lt;<a href=3D"mailto:20230606115658.677673-6-marcandre.lur=
eau@redhat.com" target=3D"_blank">20230606115658.677673-6-marcandre.lureau@=
redhat.com</a>&gt;<br>
&gt;---<br>
&gt; meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 4 +--<br>
&gt; ui/dbus.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 6 +++++<br>
&gt; audio/dbusaudio.c=C2=A0 =C2=A0 | 44 +++++++++++++++++++++++++++------<=
br>
&gt; ui/dbus-chardev.c=C2=A0 =C2=A0 | 22 +++++++++++++----<br>
&gt; ui/dbus-console.c=C2=A0 =C2=A0 | 59 ++++++++++++++++++++++++++++++++++=
++++------<br>
&gt; ui/dbus-display1.xml | 28 +++++++++++++++++++++<br>
&gt; ui/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 9 ++++++-<br>
&gt; 7 files changed, 149 insertions(+), 23 deletions(-)<br>
&gt;<br>
&gt;diff --git a/meson.build b/meson.build<br>
&gt;index b409788832..9a1ce43471 100644<br>
&gt;--- a/meson.build<br>
&gt;+++ b/meson.build<br>
&gt;@@ -838,6 +838,8 @@ if gdbus_codegen.found() and get_option(&#39;cfi&#3=
9;)<br>
&gt;=C2=A0 =C2=A0gdbus_codegen_error =3D &#39;@0@ uses gdbus-codegen, which=
 does not support control flow integrity&#39;<br>
&gt; endif<br>
&gt; <br>
&gt;+xml_pp =3D find_program(&#39;scripts/xml-preprocess.py&#39;)<br>
&gt;+<br>
&gt; lttng =3D not_found<br>
&gt; if &#39;ust&#39; in get_option(&#39;trace_backends&#39;)<br>
&gt;=C2=A0 =C2=A0lttng =3D dependency(&#39;lttng-ust&#39;, required: true, =
version: &#39;&gt;=3D 2.1&#39;,<br>
&gt;@@ -1985,8 +1987,6 @@ dbus_display =3D get_option(&#39;dbus_display&#39=
;) \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_message: &#39;-display =
dbus requires glib&gt;=3D2.64&#39;) \<br>
&gt;=C2=A0 =C2=A0.require(gdbus_codegen.found(),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_message: gdbus_codegen_=
error.format(&#39;-display dbus&#39;)) \<br>
&gt;-=C2=A0 .require(targetos !=3D &#39;windows&#39;,<br>
&gt;-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_message: &#39;-display =
dbus is not available on Windows&#39;) \<br>
&gt;=C2=A0 =C2=A0.allowed()<br>
&gt; <br>
&gt; have_virtfs =3D get_option(&#39;virtfs&#39;) \<br>
&gt;diff --git a/ui/dbus.h b/ui/dbus.h<br>
&gt;index 9c149e7b41..1e8c24a48e 100644<br>
&gt;--- a/ui/dbus.h<br>
&gt;+++ b/ui/dbus.h<br>
&gt;@@ -62,6 +62,12 @@ struct DBusDisplay {<br>
&gt;=C2=A0 =C2=A0 =C2=A0Notifier notifier;<br>
&gt; };<br>
&gt; <br>
&gt;+#ifdef WIN32<br>
&gt;+bool<br>
&gt;+dbus_win32_import_socket(GDBusMethodInvocation *invocation,<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0GVariant *arg_listener, int *socket);<br>
&gt;+#endif<br>
&gt;+<br>
&gt; #define TYPE_DBUS_DISPLAY &quot;dbus-display&quot;<br>
&gt; OBJECT_DECLARE_SIMPLE_TYPE(DBusDisplay, DBUS_DISPLAY)<br>
&gt; <br>
&gt;diff --git a/audio/dbusaudio.c b/audio/dbusaudio.c<br>
&gt;index de59467d9e..7a11fbfb42 100644<br>
&gt;--- a/audio/dbusaudio.c<br>
&gt;+++ b/audio/dbusaudio.c<br>
&gt;@@ -33,6 +33,7 @@<br>
&gt; #include &lt;gio/gunixfdlist.h&gt;<br>
&gt; #endif<br>
&gt; <br>
&gt;+#include &quot;ui/dbus.h&quot;<br>
<br>
This patch causes below compile error since pixman.h isn&#39;t found. It se=
ems as if the pixman include path is missing. Since pixman.h is found elsew=
here in the same build I suspect that the DBUS audio module now needs a pix=
man dependency -- which sounds a little bit weired.<br>
<br>
FAILED: libaudio-dbus.a.p/audio_dbusaudio.c.o <br>
cc -m64 -mcx16 -Ilibaudio-dbus.a.p -I. -I../src -Iqapi -Itrace -Iui -Iui/sh=
ader -I/usr/include/glib-2.0 -I/usr/lib/glib-2.0/include -I/usr/include/sys=
prof-4 -I/usr/include/libmount -I/usr/include/blkid -I/usr/include/gio-unix=
-2.0 -fdiagnostics-color=3Dauto -Wall -Winvalid-pch -Werror -std=3Dgnu11 -O=
0 -g -fstack-protector-strong -Wundef -Wwrite-strings -Wmissing-prototypes =
-Wstrict-prototypes -Wredundant-decls -Wold-style-declaration -Wold-style-d=
efinition -Wtype-limits -Wformat-security -Wformat-y2k -Winit-self -Wignore=
d-qualifiers -Wempty-body -Wnested-externs -Wendif-labels -Wexpansion-to-de=
fined -Wimplicit-fallthrough=3D2 -Wmissing-format-attribute -Wno-missing-in=
clude-dirs -Wno-shift-negative-value -Wno-psabi -isystem qemu/src/linux-hea=
ders -isystem linux-headers -iquote . -iquote qemu/src -iquote qemu/src/inc=
lude -iquote qemu/src/host/include/x86_64 -iquote qemu/src/host/include/gen=
eric -iquote qemu/src/tcg/i386 -Wno-unused-function -pthread -D_GNU_SOURCE =
-D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -fno-strict-aliasing -fno-comm=
on -fwrapv -march=3Dx86-64 -mtune=3Dgeneric -O2 -pipe -fno-plt -fexceptions=
 -Wp,-D_FORTIFY_SOURCE=3D2 -Wformat -Werror=3Dformat-security -fstack-clash=
-protection -fcf-protection -fPIC -DBUILD_DSO -MD -MQ libaudio-dbus.a.p/aud=
io_dbusaudio.c.o -MF libaudio-dbus.a.p/audio_dbusaudio.c.o.d -o libaudio-db=
us.a.p/audio_dbusaudio.c.o -c ../src/audio/dbusaudio.c<br>
In file included from qemu/src/include/ui/console.h:4,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from qemu/src=
/ui/dbus.h:31,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from ../src/a=
udio/dbusaudio.c:36:<br>
qemu/src/include/ui/qemu-pixman.h:12:10: fatal error: pixman.h: No such fil=
e or directory<br>
=C2=A0 =C2=A012 | #include &lt;pixman.h&gt;<br>
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~<br>
<br></blockquote><div><br></div><div>This is reported here:<br></div><div><=
a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/1739">https://gitla=
b.com/qemu-project/qemu/-/issues/1739</a></div></div><div class=3D"gmail_qu=
ote"><br></div><div class=3D"gmail_quote">I am going to send the patch.<br>=
</div></div>

--0000000000004bb66e05ff5fae22--


