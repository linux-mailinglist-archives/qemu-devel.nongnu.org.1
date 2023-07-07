Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F4074B7D1
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 22:24:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHrz4-0005ym-UE; Fri, 07 Jul 2023 16:23:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qHrz2-0005yI-Ge
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 16:23:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qHryz-0001JM-1M
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 16:23:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688761390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JDJ9ne9feNzIW3Wt7j6c8KuXI69NFBJoLnPXs02zqrM=;
 b=AIJOWBKsSzEP3p4nHiOWkinoqEzFRl75sHZFDxSvEf8ThCn1mksNYPisJpxAQQ+mh2E7C0
 UBBfF0SSOZbMbjn24QfoZTqWWdQ0rxDmjaWRbwNo5gHdp6VZ4829+T+UvAUnh0dGAEO18W
 uaM1wYQwFwnVmYrvWPK1kKzzXLJA+9w=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-4mQs3H0dPVi_BZ4XEt3Dlg-1; Fri, 07 Jul 2023 16:23:07 -0400
X-MC-Unique: 4mQs3H0dPVi_BZ4XEt3Dlg-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2b6fdb7eeafso22059811fa.2
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 13:23:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688761386; x=1691353386;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JDJ9ne9feNzIW3Wt7j6c8KuXI69NFBJoLnPXs02zqrM=;
 b=UZz4K5u9alKJZm9JCrrGqoKbzWiLCqY3wNp+CSOPdTzsvULhMlHYlLWFKTVCq/86jf
 /uCaTpQzxoqg9RdkQkV1c9FF7VG+kwKnHoxU3a49x9v28r81oaqv87n1lZLPibVkKXtn
 EWsh4w+wQaaxSngahIz9NzI6kRuYeaXi4wsyCw/0L1qNerANz4qJMobsCXVPEwabVJh5
 8Le/d6UPfUL2IyiHuJOJGH2JLLJpHrrJDxRWk1ic1H/Zj+s2lahyHFRNqJWRGClgsvcq
 m3FxeS43221lQzLEFn9GHh9g6NmcHUcYgZ4v2JMNrCf8hwtlDn+Uz7UeqsZpV/rEqNqP
 /2uA==
X-Gm-Message-State: ABy/qLbFVYQGA2SRPkJ4kusE+JBtSvR2Po/qTSGMj0ADRGuJkCREcS5V
 gySYT8UDyqZTNhvfTqtmPKRIfjorL5HUEh1+MM49FbFKV+v1V3z7C/WFJ0voeXnJsbb2w3vXv5e
 fJ93JwzhhO0eog7wF7ZEo/d6XE3zw5Mo=
X-Received: by 2002:a2e:99c8:0:b0:2b6:d48a:5dc3 with SMTP id
 l8-20020a2e99c8000000b002b6d48a5dc3mr4395886ljj.39.1688761385914; 
 Fri, 07 Jul 2023 13:23:05 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEAi/eevINkT2WAW3IhwVJqiXageSbX9ItqYy8rbB9+JItg5rVZm/URzd2G9TG4o26+5kFsayEKdSymPKHdR30=
X-Received: by 2002:a2e:99c8:0:b0:2b6:d48a:5dc3 with SMTP id
 l8-20020a2e99c8000000b002b6d48a5dc3mr4395877ljj.39.1688761385608; Fri, 07 Jul
 2023 13:23:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230707092258.768420-1-kkostiuk@redhat.com>
 <20230707092258.768420-2-kkostiuk@redhat.com>
 <c540330e-0adb-52a2-ab12-ba098212ce6f@linaro.org>
 <CAPMcbCrr6DxbNYRxm1uztaA7GG2A_MDb49VHuy26Cs7XA3bAuw@mail.gmail.com>
 <20f5fded-a486-c184-9ee0-1e91c178d5fd@linaro.org>
In-Reply-To: <20f5fded-a486-c184-9ee0-1e91c178d5fd@linaro.org>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Fri, 7 Jul 2023 23:22:54 +0300
Message-ID: <CAPMcbCrnM=1P7rjp+D_ei_R+e3QYSWDwfpJg2=ooC307p_qbBQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] QGA VSS: Add wrapper to send log to debugger and
 stderr
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, Eric Blake <eblake@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000080015205ffeb663c"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
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

--00000000000080015205ffeb663c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 7, 2023 at 6:36=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org>
wrote:

> On 7/7/23 16:24, Konstantin Kostiuk wrote:
> >
> >
> > On Fri, Jul 7, 2023 at 1:33=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <phi=
lmd@linaro.org
> > <mailto:philmd@linaro.org>> wrote:
> >
> >     On 7/7/23 11:22, Konstantin Kostiuk wrote:
> >      > Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com
> >     <mailto:kkostiuk@redhat.com>>
> >      > ---
> >      >   qga/vss-win32/meson.build   |  2 +-
> >      >   qga/vss-win32/vss-debug.cpp | 31 +++++++++++++++++++++++++++++=
++
> >      >   qga/vss-win32/vss-debug.h   | 25 +++++++++++++++++++++++++
> >      >   3 files changed, 57 insertions(+), 1 deletion(-)
> >      >   create mode 100644 qga/vss-win32/vss-debug.cpp
> >      >   create mode 100644 qga/vss-win32/vss-debug.h
> >
> >
> >      > diff --git a/qga/vss-win32/vss-debug.cpp
> >     b/qga/vss-win32/vss-debug.cpp
> >      > new file mode 100644
> >      > index 0000000000..5d6f37944b
> >      > --- /dev/null
> >      > +++ b/qga/vss-win32/vss-debug.cpp
> >      > @@ -0,0 +1,31 @@
> >      > +/*
> >      > + * QEMU Guest Agent VSS debug declarations
> >      > + *
> >      > + * Copyright (C) 2023 Red Hat Inc
> >      > + *
> >      > + * Authors:
> >      > + *  Konstantin Kostiuk <kkostiuk@redhat.com
> >     <mailto:kkostiuk@redhat.com>>
> >      > + *
> >      > + * This work is licensed under the terms of the GNU GPL, versio=
n
> >     2 or later.
> >      > + * See the COPYING file in the top-level directory.
> >      > + */
> >      > +
> >      > +#include "qemu/osdep.h"
> >      > +#include "vss-debug.h"
> >      > +#include "vss-common.h"
> >      > +
> >      > +void qga_debug_internal(const char *funcname, const char *fmt,
> >     ...)  {
> >      > +    char user_sting[512] =3D {0};
> >
> >     "user_string"
> >
> >      > +    char full_string[640] =3D {0};
> >      > +
> >      > +    va_list args;
> >      > +    va_start(args, fmt);
> >      > +    vsnprintf(user_sting, 512, fmt, args);
> >
> >     ARRAY_SIZE(user_string)
> >
> >
> > I have a problem with ARRAY_SIZE define.
> >
> > ../qga/vss-win32/vss-debug.cpp: In function 'void
> > qga_debug_internal(const char*, const char*, ...)':
> > /src/include/qemu/compiler.h:70:12: error: types may not be defined in
> > 'sizeof' expressions
> >     70 |     struct { \
> >        |            ^
> > /src/include/qemu/compiler.h:78:43: note: in expansion of macro
> > 'QEMU_BUILD_BUG_ON_STRUCT'
> >     78 | #define QEMU_BUILD_BUG_ON_ZERO(x)
> > (sizeof(QEMU_BUILD_BUG_ON_STRUCT(x)) - \
> >        |
> ^~~~~~~~~~~~~~~~~~~~~~~~
> > /src/include/qemu/osdep.h:474:24: note: in expansion of macro
> > 'QEMU_BUILD_BUG_ON_ZERO'
> >    474 |
>  QEMU_BUILD_BUG_ON_ZERO(!QEMU_IS_ARRAY(x)))
> >        |                        ^~~~~~~~~~~~~~~~~~~~~~
> > ../qga/vss-win32/vss-debug.cpp:23:32: note: in expansion of macro
> > 'ARRAY_SIZE'
> >     23 |     if (vsnprintf(user_string, ARRAY_SIZE(user_string), fmt,
> > args) <=3D 0) {
> >        |                                ^~~~~~~~~~
> > /src/include/qemu/osdep.h:470:57: error: expected primary-expression
> > before 'typeof'
> >    470 | #define QEMU_IS_ARRAY(x)
> > (!__builtin_types_compatible_p(typeof(x), \
> >        |                                                         ^~~~~~
> > /src/include/qemu/compiler.h:71:14: note: in definition of macro
> > 'QEMU_BUILD_BUG_ON_STRUCT'
> >     71 |         int:(x) ? -1 : 1; \
> >        |              ^
> > /src/include/qemu/osdep.h:474:24: note: in expansion of macro
> > 'QEMU_BUILD_BUG_ON_ZERO'
> >    474 |
>  QEMU_BUILD_BUG_ON_ZERO(!QEMU_IS_ARRAY(x)))
> >        |                        ^~~~~~~~~~~~~~~~~~~~~~
> > /src/include/qemu/osdep.h:474:48: note: in expansion of macro
> > 'QEMU_IS_ARRAY'
> >    474 |
>  QEMU_BUILD_BUG_ON_ZERO(!QEMU_IS_ARRAY(x)))
> >
> > Can you help with this?
>
> Eh no clue, maybe not C++ compliant?
>
> Fall back to sizeof() =C2=AF\_(=E3=83=84)_/=C2=AF
>
>
You are right, When I rename the file to vss-debug.c the error disappears.
What is the better solution:
1) use vss-debug.c and extern "C" { #include "vss-debug.h" } in CPP files
2) just use sizeof() in CPP


> >
> >
> >      > +    va_end(args);
> >      > +
> >      > +    snprintf(full_string, 640, QGA_PROVIDER_NAME "[%lu]: %s
> %s\n",
> >      > +             GetCurrentThreadId(), funcname, user_sting);
> >
> >     if (snprintf() <=3D 0) { return; }
> >
> >      > +
> >      > +    OutputDebugString(full_string);
> >      > +    fprintf(stderr, "%s", full_string);
> >
> >     Format unused:
> >
> >     fputs(full_string, stderr);
> >
> >      > +}
> >
> >     With the changes:
> >     Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org
> >     <mailto:philmd@linaro.org>>
> >
>
>

--00000000000080015205ffeb663c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jul 7, 2023 at 6:36=E2=80=AFP=
M Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org">phil=
md@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">On 7/7/23 16:24, Konstantin Kostiuk wrote:<br>
&gt; <br>
&gt; <br>
&gt; On Fri, Jul 7, 2023 at 1:33=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 &lt=
;<a href=3D"mailto:philmd@linaro.org" target=3D"_blank">philmd@linaro.org</=
a> <br>
&gt; &lt;mailto:<a href=3D"mailto:philmd@linaro.org" target=3D"_blank">phil=
md@linaro.org</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On 7/7/23 11:22, Konstantin Kostiuk wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Signed-off-by: Konstantin Kostiuk &lt;<a href=
=3D"mailto:kkostiuk@redhat.com" target=3D"_blank">kkostiuk@redhat.com</a><b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:kkostiuk@redhat.com" t=
arget=3D"_blank">kkostiuk@redhat.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; ---<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0qga/vss-win32/meson.build=C2=A0 =
=C2=A0|=C2=A0 2 +-<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0qga/vss-win32/vss-debug.cpp | 31 =
+++++++++++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0qga/vss-win32/vss-debug.h=C2=A0 =
=C2=A0| 25 +++++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A03 files changed, 57 insertions(+)=
, 1 deletion(-)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0create mode 100644 qga/vss-win32/=
vss-debug.cpp<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0create mode 100644 qga/vss-win32/=
vss-debug.h<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; diff --git a/qga/vss-win32/vss-debug.cpp<br>
&gt;=C2=A0 =C2=A0 =C2=A0b/qga/vss-win32/vss-debug.cpp<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; new file mode 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; index 0000000000..5d6f37944b<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; --- /dev/null<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +++ b/qga/vss-win32/vss-debug.cpp<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -0,0 +1,31 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +/*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * QEMU Guest Agent VSS debug declarations<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + *<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * Copyright (C) 2023 Red Hat Inc<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + *<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * Authors:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + *=C2=A0 Konstantin Kostiuk &lt;<a href=3D"m=
ailto:kkostiuk@redhat.com" target=3D"_blank">kkostiuk@redhat.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:kkostiuk@redhat.com" t=
arget=3D"_blank">kkostiuk@redhat.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + *<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * This work is licensed under the terms of =
the GNU GPL, version<br>
&gt;=C2=A0 =C2=A0 =C2=A02 or later.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * See the COPYING file in the top-level dir=
ectory.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;qemu/osdep.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;vss-debug.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;vss-common.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +void qga_debug_internal(const char *funcname=
, const char *fmt,<br>
&gt;=C2=A0 =C2=A0 =C2=A0...)=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 char user_sting[512] =3D {0};<=
br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0&quot;user_string&quot;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 char full_string[640] =3D {0};=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 va_list args;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 va_start(args, fmt);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 vsnprintf(user_sting, 512, fmt=
, args);<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0ARRAY_SIZE(user_string)<br>
&gt; <br>
&gt; <br>
&gt; I have a problem with ARRAY_SIZE define.<br>
&gt; <br>
&gt; ../qga/vss-win32/vss-debug.cpp: In function &#39;void <br>
&gt; qga_debug_internal(const char*, const char*, ...)&#39;:<br>
&gt; /src/include/qemu/compiler.h:70:12: error: types may not be defined in=
 <br>
&gt; &#39;sizeof&#39; expressions<br>
&gt;=C2=A0 =C2=A0 =C2=A070 | =C2=A0 =C2=A0 struct { \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
^<br>
&gt; /src/include/qemu/compiler.h:78:43: note: in expansion of macro <br>
&gt; &#39;QEMU_BUILD_BUG_ON_STRUCT&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A078 | #define QEMU_BUILD_BUG_ON_ZERO(x) <br>
&gt; (sizeof(QEMU_BUILD_BUG_ON_STRUCT(x)) - \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~~~~~~~~~~~~~~~<br>
&gt; /src/include/qemu/osdep.h:474:24: note: in expansion of macro <br>
&gt; &#39;QEMU_BUILD_BUG_ON_ZERO&#39;<br>
&gt;=C2=A0 =C2=A0 474 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0QEMU_BUILD_BUG_ON_ZERO(!QEMU_IS_ARRAY(x))=
)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^~~~~~~~~~~~~~~~~~~~~~<br>
&gt; ../qga/vss-win32/vss-debug.cpp:23:32: note: in expansion of macro <br>
&gt; &#39;ARRAY_SIZE&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A023 | =C2=A0 =C2=A0 if (vsnprintf(user_string, ARRAY=
_SIZE(user_string), fmt, <br>
&gt; args) &lt;=3D 0) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^~~~~=
~~~~~<br>
&gt; /src/include/qemu/osdep.h:470:57: error: expected primary-expression <=
br>
&gt; before &#39;typeof&#39;<br>
&gt;=C2=A0 =C2=A0 470 | #define QEMU_IS_ARRAY(x) <br>
&gt; (!__builtin_types_compatible_p(typeof(x), \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 ^~~~~~<br>
&gt; /src/include/qemu/compiler.h:71:14: note: in definition of macro <br>
&gt; &#39;QEMU_BUILD_BUG_ON_STRUCT&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A071 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 int:(x) ? -1 : 1; =
\<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0^<br>
&gt; /src/include/qemu/osdep.h:474:24: note: in expansion of macro <br>
&gt; &#39;QEMU_BUILD_BUG_ON_ZERO&#39;<br>
&gt;=C2=A0 =C2=A0 474 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0QEMU_BUILD_BUG_ON_ZERO(!QEMU_IS_ARRAY(x))=
)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^~~~~~~~~~~~~~~~~~~~~~<br>
&gt; /src/include/qemu/osdep.h:474:48: note: in expansion of macro <br>
&gt; &#39;QEMU_IS_ARRAY&#39;<br>
&gt;=C2=A0 =C2=A0 474 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0QEMU_BUILD_BUG_ON_ZERO(!QEMU_IS_ARRAY(x))=
)<br>
&gt; <br>
&gt; Can you help with this?<br>
<br>
Eh no clue, maybe not C++ compliant?<br>
<br>
Fall back to sizeof() =C2=AF\_(=E3=83=84)_/=C2=AF<br>
<br></blockquote><div><br></div><div>You are right, When I rename the file =
to vss-debug.c the error disappears.</div><div>What is the better solution:=
<br></div><div>1) use vss-debug.c and extern &quot;C&quot; { #include &quot=
;vss-debug.h&quot; } in CPP files<br></div><div>2) just use sizeof() in CPP=
<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 va_end(args);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 snprintf(full_string, 640, QGA=
_PROVIDER_NAME &quot;[%lu]: %s %s\n&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0GetCurrentThreadId(), funcname, user_sting);<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0if (snprintf() &lt;=3D 0) { return; }<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 OutputDebugString(full_string)=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 fprintf(stderr, &quot;%s&quot;=
, full_string);<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Format unused:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0fputs(full_string, stderr);<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0With the changes:<br>
&gt;=C2=A0 =C2=A0 =C2=A0Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a hre=
f=3D"mailto:philmd@linaro.org" target=3D"_blank">philmd@linaro.org</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:philmd@linaro.org" tar=
get=3D"_blank">philmd@linaro.org</a>&gt;&gt;<br>
&gt; <br>
<br>
</blockquote></div></div>

--00000000000080015205ffeb663c--


