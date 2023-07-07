Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D66B74B303
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 16:26:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHmNp-0001e1-MH; Fri, 07 Jul 2023 10:24:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qHmNn-0001dq-J9
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 10:24:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qHmNk-0008So-NG
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 10:24:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688739863;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sFjJYqCKVhLH+QRpOK6sw1ZLf0SAM8yyiNuA7dRxReQ=;
 b=fyUfygaws860MNH5zREm9K/E4p1ZF5ShQrWTEr9yvW9sCWvRshCwAwRVsTFYaeRLiplacP
 qA3RtqYYDbrkjPfT7RswW1mOoPEZkQNEeYTxRF4/O+FnzvplKq+xVlymEObQhidB28S2Yc
 FShURoEcH09wRhXSychBEkSoU8cWmu0=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-HljivQ7rP2OQ9uI33JxjOA-1; Fri, 07 Jul 2023 10:24:22 -0400
X-MC-Unique: HljivQ7rP2OQ9uI33JxjOA-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2b703a076ceso20439801fa.1
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 07:24:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688739860; x=1691331860;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sFjJYqCKVhLH+QRpOK6sw1ZLf0SAM8yyiNuA7dRxReQ=;
 b=cxUs01m6yvejWCPuqs6glldxHWe2BSd3YhecCPid/lXyxdmj9LctNRlFTrpVd0HCaD
 RuA3CnE+nw6vZzWnfSz2O7iPkDLvInJCtxbLLqQNSx8kjRbIDV7WtL1QXjuS3OtXVuvm
 8u+Ec64kV+xO7a/d3jZjrviETDBB4ivHVI4MzHaQfZPefKNHCUNJ4yMvHk9qVhy4Jgdz
 4jsJ8igVp4wuQ5bFjVByLADCgVOGT/UrzW5h4//KLcJ9v6R48S+CQCD3eNoLCTwVziLJ
 zANIdiojZiyKpw/mHSyIvoE3B3DYsei2SXNMa2qxm5cvBTxRU/gYH//iy/4oV0uE3oil
 gMmA==
X-Gm-Message-State: ABy/qLbaOm7kRqPL4fAkY/mhoAmOd2W45wBb4luhftV/0u2gy3GZ5U9K
 HytqLHyLO7CHl/awK+/+NYW+g+GKWSrCRDUO4QXosE1ZHt6H7oeKHcD3FiYXiKjhy5rFYc8hyrh
 iXgCTJA4op0zYWZy4ND6L1/RvHrap8c++4zvav4mCOw==
X-Received: by 2002:a2e:8085:0:b0:2b6:e283:32cb with SMTP id
 i5-20020a2e8085000000b002b6e28332cbmr3815954ljg.23.1688739860259; 
 Fri, 07 Jul 2023 07:24:20 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHusAF1WoWWm/ZyzwkHo7etyhneocsF15Es24T0GE1UG2Fzf1on2H2CeR3A0/F8GC1qoNFHc9+JA/76QiuVetw=
X-Received: by 2002:a2e:8085:0:b0:2b6:e283:32cb with SMTP id
 i5-20020a2e8085000000b002b6e28332cbmr3815938ljg.23.1688739859955; Fri, 07 Jul
 2023 07:24:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230707092258.768420-1-kkostiuk@redhat.com>
 <20230707092258.768420-2-kkostiuk@redhat.com>
 <c540330e-0adb-52a2-ab12-ba098212ce6f@linaro.org>
In-Reply-To: <c540330e-0adb-52a2-ab12-ba098212ce6f@linaro.org>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Fri, 7 Jul 2023 17:24:08 +0300
Message-ID: <CAPMcbCrr6DxbNYRxm1uztaA7GG2A_MDb49VHuy26Cs7XA3bAuw@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] QGA VSS: Add wrapper to send log to debugger and
 stderr
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="00000000000078927705ffe66381"
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

--00000000000078927705ffe66381
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 7, 2023 at 1:33=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org>
wrote:

> On 7/7/23 11:22, Konstantin Kostiuk wrote:
> > Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
> > ---
> >   qga/vss-win32/meson.build   |  2 +-
> >   qga/vss-win32/vss-debug.cpp | 31 +++++++++++++++++++++++++++++++
> >   qga/vss-win32/vss-debug.h   | 25 +++++++++++++++++++++++++
> >   3 files changed, 57 insertions(+), 1 deletion(-)
> >   create mode 100644 qga/vss-win32/vss-debug.cpp
> >   create mode 100644 qga/vss-win32/vss-debug.h
>
>
> > diff --git a/qga/vss-win32/vss-debug.cpp b/qga/vss-win32/vss-debug.cpp
> > new file mode 100644
> > index 0000000000..5d6f37944b
> > --- /dev/null
> > +++ b/qga/vss-win32/vss-debug.cpp
> > @@ -0,0 +1,31 @@
> > +/*
> > + * QEMU Guest Agent VSS debug declarations
> > + *
> > + * Copyright (C) 2023 Red Hat Inc
> > + *
> > + * Authors:
> > + *  Konstantin Kostiuk <kkostiuk@redhat.com>
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or
> later.
> > + * See the COPYING file in the top-level directory.
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "vss-debug.h"
> > +#include "vss-common.h"
> > +
> > +void qga_debug_internal(const char *funcname, const char *fmt, ...)  {
> > +    char user_sting[512] =3D {0};
>
> "user_string"
>
> > +    char full_string[640] =3D {0};
> > +
> > +    va_list args;
> > +    va_start(args, fmt);
> > +    vsnprintf(user_sting, 512, fmt, args);
>
> ARRAY_SIZE(user_string)
>

I have a problem with ARRAY_SIZE define.

../qga/vss-win32/vss-debug.cpp: In function 'void qga_debug_internal(const
char*, const char*, ...)':
/src/include/qemu/compiler.h:70:12: error: types may not be defined in
'sizeof' expressions
   70 |     struct { \
      |            ^
/src/include/qemu/compiler.h:78:43: note: in expansion of macro
'QEMU_BUILD_BUG_ON_STRUCT'
   78 | #define QEMU_BUILD_BUG_ON_ZERO(x)
(sizeof(QEMU_BUILD_BUG_ON_STRUCT(x)) - \
      |                                           ^~~~~~~~~~~~~~~~~~~~~~~~
/src/include/qemu/osdep.h:474:24: note: in expansion of macro
'QEMU_BUILD_BUG_ON_ZERO'
  474 |                        QEMU_BUILD_BUG_ON_ZERO(!QEMU_IS_ARRAY(x)))
      |                        ^~~~~~~~~~~~~~~~~~~~~~
../qga/vss-win32/vss-debug.cpp:23:32: note: in expansion of macro
'ARRAY_SIZE'
   23 |     if (vsnprintf(user_string, ARRAY_SIZE(user_string), fmt, args)
<=3D 0) {
      |                                ^~~~~~~~~~
/src/include/qemu/osdep.h:470:57: error: expected primary-expression before
'typeof'
  470 | #define QEMU_IS_ARRAY(x) (!__builtin_types_compatible_p(typeof(x), =
\
      |                                                         ^~~~~~
/src/include/qemu/compiler.h:71:14: note: in definition of macro
'QEMU_BUILD_BUG_ON_STRUCT'
   71 |         int:(x) ? -1 : 1; \
      |              ^
/src/include/qemu/osdep.h:474:24: note: in expansion of macro
'QEMU_BUILD_BUG_ON_ZERO'
  474 |                        QEMU_BUILD_BUG_ON_ZERO(!QEMU_IS_ARRAY(x)))
      |                        ^~~~~~~~~~~~~~~~~~~~~~
/src/include/qemu/osdep.h:474:48: note: in expansion of macro
'QEMU_IS_ARRAY'
  474 |                        QEMU_BUILD_BUG_ON_ZERO(!QEMU_IS_ARRAY(x)))


Can you help with this?


> > +    va_end(args);
> > +
> > +    snprintf(full_string, 640, QGA_PROVIDER_NAME "[%lu]: %s %s\n",
> > +             GetCurrentThreadId(), funcname, user_sting);
>
> if (snprintf() <=3D 0) { return; }
>
> > +
> > +    OutputDebugString(full_string);
> > +    fprintf(stderr, "%s", full_string);
>
> Format unused:
>
> fputs(full_string, stderr);
>
> > +}
>
> With the changes:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>
>

--00000000000078927705ffe66381
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jul 7, 2023 at 1:33=E2=80=AFP=
M Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org">phil=
md@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">On 7/7/23 11:22, Konstantin Kostiuk wrote:<br>
&gt; Signed-off-by: Konstantin Kostiuk &lt;<a href=3D"mailto:kkostiuk@redha=
t.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0qga/vss-win32/meson.build=C2=A0 =C2=A0|=C2=A0 2 +-<br>
&gt;=C2=A0 =C2=A0qga/vss-win32/vss-debug.cpp | 31 +++++++++++++++++++++++++=
++++++<br>
&gt;=C2=A0 =C2=A0qga/vss-win32/vss-debug.h=C2=A0 =C2=A0| 25 +++++++++++++++=
++++++++++<br>
&gt;=C2=A0 =C2=A03 files changed, 57 insertions(+), 1 deletion(-)<br>
&gt;=C2=A0 =C2=A0create mode 100644 qga/vss-win32/vss-debug.cpp<br>
&gt;=C2=A0 =C2=A0create mode 100644 qga/vss-win32/vss-debug.h<br>
<br>
<br>
&gt; diff --git a/qga/vss-win32/vss-debug.cpp b/qga/vss-win32/vss-debug.cpp=
<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..5d6f37944b<br>
&gt; --- /dev/null<br>
&gt; +++ b/qga/vss-win32/vss-debug.cpp<br>
&gt; @@ -0,0 +1,31 @@<br>
&gt; +/*<br>
&gt; + * QEMU Guest Agent VSS debug declarations<br>
&gt; + *<br>
&gt; + * Copyright (C) 2023 Red Hat Inc<br>
&gt; + *<br>
&gt; + * Authors:<br>
&gt; + *=C2=A0 Konstantin Kostiuk &lt;<a href=3D"mailto:kkostiuk@redhat.com=
" target=3D"_blank">kkostiuk@redhat.com</a>&gt;<br>
&gt; + *<br>
&gt; + * This work is licensed under the terms of the GNU GPL, version 2 or=
 later.<br>
&gt; + * See the COPYING file in the top-level directory.<br>
&gt; + */<br>
&gt; +<br>
&gt; +#include &quot;qemu/osdep.h&quot;<br>
&gt; +#include &quot;vss-debug.h&quot;<br>
&gt; +#include &quot;vss-common.h&quot;<br>
&gt; +<br>
&gt; +void qga_debug_internal(const char *funcname, const char *fmt, ...)=
=C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 char user_sting[512] =3D {0};<br>
<br>
&quot;user_string&quot;<br>
<br>
&gt; +=C2=A0 =C2=A0 char full_string[640] =3D {0};<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 va_list args;<br>
&gt; +=C2=A0 =C2=A0 va_start(args, fmt);<br>
&gt; +=C2=A0 =C2=A0 vsnprintf(user_sting, 512, fmt, args);<br>
<br>
ARRAY_SIZE(user_string)<br></blockquote><div><br></div><div>I have a proble=
m with ARRAY_SIZE define.<br><br>../qga/vss-win32/vss-debug.cpp: In functio=
n &#39;void qga_debug_internal(const char*, const char*, ...)&#39;:<br>/src=
/include/qemu/compiler.h:70:12: error: types may not be defined in &#39;siz=
eof&#39; expressions<br>=C2=A0 =C2=A070 | =C2=A0 =C2=A0 struct { \<br>=C2=
=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^<br>/src/incl=
ude/qemu/compiler.h:78:43: note: in expansion of macro &#39;QEMU_BUILD_BUG_=
ON_STRUCT&#39;<br>=C2=A0 =C2=A078 | #define QEMU_BUILD_BUG_ON_ZERO(x) (size=
of(QEMU_BUILD_BUG_ON_STRUCT(x)) - \<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~~~~~~=
~~~~~~~~~<br>/src/include/qemu/osdep.h:474:24: note: in expansion of macro =
&#39;QEMU_BUILD_BUG_ON_ZERO&#39;<br>=C2=A0 474 | =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0QEMU_BUILD_BUG_O=
N_ZERO(!QEMU_IS_ARRAY(x)))<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^~~~~~~~~~~~~=
~~~~~~~~~<br>../qga/vss-win32/vss-debug.cpp:23:32: note: in expansion of ma=
cro &#39;ARRAY_SIZE&#39;<br>=C2=A0 =C2=A023 | =C2=A0 =C2=A0 if (vsnprintf(u=
ser_string, ARRAY_SIZE(user_string), fmt, args) &lt;=3D 0) {<br>=C2=A0 =C2=
=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^~~~~~~~~~<br>/src/include=
/qemu/osdep.h:470:57: error: expected primary-expression before &#39;typeof=
&#39;<br>=C2=A0 470 | #define QEMU_IS_ARRAY(x) (!__builtin_types_compatible=
_p(typeof(x), \<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 ^~~~~~<br>/src/include/qemu/compiler.h:71:14: note: in de=
finition of macro &#39;QEMU_BUILD_BUG_ON_STRUCT&#39;<br>=C2=A0 =C2=A071 | =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int:(x) ? -1 : 1; \<br>=C2=A0 =C2=A0 =C2=A0 | =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^<br>/src/include/qemu/osde=
p.h:474:24: note: in expansion of macro &#39;QEMU_BUILD_BUG_ON_ZERO&#39;<br=
>=C2=A0 474 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0QEMU_BUILD_BUG_ON_ZERO(!QEMU_IS_ARRAY(x)))<br>=C2=
=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0^~~~~~~~~~~~~~~~~~~~~~<br>/src/include/qemu/osd=
ep.h:474:48: note: in expansion of macro &#39;QEMU_IS_ARRAY&#39;<br>=C2=A0 =
474 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0QEMU_BUILD_BUG_ON_ZERO(!QEMU_IS_ARRAY(x)))</div><div><br></di=
v><div>=C2=A0</div><div>Can you help with this?</div><div><br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 va_end(args);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 snprintf(full_string, 640, QGA_PROVIDER_NAME &quot;[%lu=
]: %s %s\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0GetCurrentThreadId(),=
 funcname, user_sting);<br>
<br>
if (snprintf() &lt;=3D 0) { return; }<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 OutputDebugString(full_string);<br>
&gt; +=C2=A0 =C2=A0 fprintf(stderr, &quot;%s&quot;, full_string);<br>
<br>
Format unused:<br>
<br>
fputs(full_string, stderr);<br>
<br>
&gt; +}<br>
<br>
With the changes:<br>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linar=
o.org" target=3D"_blank">philmd@linaro.org</a>&gt;<br>
<br>
</blockquote></div></div>

--00000000000078927705ffe66381--


