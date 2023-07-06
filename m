Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8F1749A19
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 12:59:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHMgv-0003eI-Dj; Thu, 06 Jul 2023 06:58:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qHMgo-0003d5-Ip
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 06:58:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qHMgm-0007qh-Ki
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 06:58:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688641099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wlyUL9rlgFz+9AULvsiFCp9QJR3Kc3bEsoWwLTdQrPQ=;
 b=g95WkadGnJ71XFXQAIPOIKpYVN+HMlS55E0MQuOK6MMyhgiDz+bPxiE83QXcNEwBPMFsnM
 y+HXKf6Y9u1xSmR1EDGNbCn9xnJj2X1EVMhsQ2vJX9Eh68kH8p1GjUeRXzSqDSQOBIpLXi
 xyDNZIKIp+aPsvCo+rtaWkfuI21ZVqo=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-hMUGRuXKP0OTEUX8lTesiw-1; Thu, 06 Jul 2023 06:58:17 -0400
X-MC-Unique: hMUGRuXKP0OTEUX8lTesiw-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2b6ce2f2960so9681941fa.0
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 03:58:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688641096; x=1691233096;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wlyUL9rlgFz+9AULvsiFCp9QJR3Kc3bEsoWwLTdQrPQ=;
 b=hqgHcaXty2+9PjvP+8Irf7+vW40XzARChCTK4zdx0tBbF4eyUKnqwVZZiAfumHgLjW
 7YAy2rggU5F3tFElwOCUZjBHGlp0UYJFYWgpeft/1qbuNyrgP/tk0aI3+sMO7uGgUy8q
 JSdi29jL0pDtVTG0S0WnWYS+0Va2NRsFEN4/YmJWH/X48tAjhCM7YKN0FKzVXAfwtjva
 yYKVB7N1fLPB6TWw304Wuk5RUQ2VCp48Pxr4PpEQD6nv+ymVDhQBI8T968Apc/t0YSxK
 hocsj1MZQfQLhLM8yu5exVFaSgA80VCy3cklmBFS1hTGVJoqftFdyxL4Lc6hbWmEjqX/
 WrFg==
X-Gm-Message-State: ABy/qLbJ7Nea1JmzB8pvknXaoYeTiZbFizUF5MV9iPcwLfJHuTyTNVep
 Cp4wEW7uAbIYLKBrnjXtKgecLYGYO8O0TeNUqsM5W0tjsc+jGGcmlf84EoXKjezvwoSmYSsSYqT
 NJgwRWLzTXz9HNiqnbslUn97Gmh2xcuc=
X-Received: by 2002:a05:651c:107b:b0:2b6:d7d2:1a65 with SMTP id
 y27-20020a05651c107b00b002b6d7d21a65mr1944432ljm.18.1688641095872; 
 Thu, 06 Jul 2023 03:58:15 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF1uHrMWDJW4PM1BBNRtWX4pYT99WdSf7bWDoqn3HKRKL6t3Qwsw2zPuFNGnprbJBQyfhU+RR8sljp1yGmZ9kg=
X-Received: by 2002:a05:651c:107b:b0:2b6:d7d2:1a65 with SMTP id
 y27-20020a05651c107b00b002b6d7d21a65mr1944423ljm.18.1688641095593; Thu, 06
 Jul 2023 03:58:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230705141205.525776-1-kkostiuk@redhat.com>
 <20230705141205.525776-2-kkostiuk@redhat.com>
 <413a30a2-c050-7587-8c0e-a6d89c8b7ab3@linaro.org>
 <CAPMcbCp2Rx4jz3S9R8VbaeRZrkakn4HE7e-GZtubv5b29Km1OA@mail.gmail.com>
 <d5f8bc76-7cd5-a389-338d-53687ad76cdc@linaro.org>
In-Reply-To: <d5f8bc76-7cd5-a389-338d-53687ad76cdc@linaro.org>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Thu, 6 Jul 2023 13:58:04 +0300
Message-ID: <CAPMcbCpwWj3YOnxzofnirvDi1V1oJvds+CDjpb+ib5_SCawvTw@mail.gmail.com>
Subject: Re: [PATCH 1/4] QGA VSS: Add wrapper to send log to debugger and
 stderr
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, Yan Vugenfirer <yvugenfi@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000a80ae705ffcf6420"
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

--000000000000a80ae705ffcf6420
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 6, 2023 at 1:01=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org>
wrote:

> On 6/7/23 09:54, Konstantin Kostiuk wrote:
> > Hi Philippe,
> >
> > On Wed, Jul 5, 2023 at 11:35=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
> > <philmd@linaro.org <mailto:philmd@linaro.org>> wrote:
> >
> >     Hi Konstantin,
> >
> >     On 5/7/23 16:12, Konstantin Kostiuk wrote:
> >      > Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com
> >     <mailto:kkostiuk@redhat.com>>
> >      > ---
> >      >   qga/vss-win32/vss-debug.h | 31 +++++++++++++++++++++++++++++++
> >      >   1 file changed, 31 insertions(+)
> >      >   create mode 100644 qga/vss-win32/vss-debug.h
> >
> >
> >      > +#define PRINT_DEBUG(fmt, ...) {
> >                   \
> >      > +    char user_sting[512] =3D { 0 };
> >                   \
> >      > +    char full_string[640] =3D { 0 };
> >                    \
> >      > +    snprintf(user_sting, 512, fmt, ## __VA_ARGS__);
> >                   \
> >      > +    snprintf(full_string, 640, QGA_PROVIDER_NAME"[%lu]: %s
> >     %s\n",             \
> >      > +        GetCurrentThreadId(), __func__, user_sting);
> >                    \
> >      > +    OutputDebugString(full_string);
> >                   \
> >      > +    fprintf(stderr, "%s", full_string);
> >                   \
> >      > +}
> >
> >     Why not simply use a plain function?
> >
> >
> > I am not sure what you mean.
> >
> > If you mean to call OutputDebugString directly, then we need to
> > concatenate the proper string
> > for each call.
> > If you mean convert PRINT_DEBUG to function, then we can't use the
> > __func__ macro in
> > PRINT_DEBUG to get the real function name. We can convert PRINT_DEBUG t=
o
> > function
> > and a new macro that will call PRINT_DEBUG and pass a proper value of
> > __fucn__.
> >
> > What solution is better there?
>
>    void qga_debug(const char *funcname, const char *fmt, ...);
>
> and g_strdup_vprintf()?
>


I agree about the qga_debug function.
About g_strdup_vprintf I am not sure. Currently, VSS uses only one function
from GLib (g_assertion_message_expr).
In the past, we had problems with GLib due to mistakes in Windows
implementation and we thinking about
removing GLib from VSS at all. As VSS.DLL is also invoked directly from
Windows, we should use standard
C++ types in public functions. We can use GLib types/functions for the
internal part of DLL, but I think it will
be confusing.

--000000000000a80ae705ffcf6420
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jul 6, 2023 at 1:01=E2=80=AFP=
M Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org">phil=
md@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">On 6/7/23 09:54, Konstantin Kostiuk wrote:<br>
&gt; Hi Philippe,<br>
&gt; <br>
&gt; On Wed, Jul 5, 2023 at 11:35=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <b=
r>
&gt; &lt;<a href=3D"mailto:philmd@linaro.org" target=3D"_blank">philmd@lina=
ro.org</a> &lt;mailto:<a href=3D"mailto:philmd@linaro.org" target=3D"_blank=
">philmd@linaro.org</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Hi Konstantin,<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On 5/7/23 16:12, Konstantin Kostiuk wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Signed-off-by: Konstantin Kostiuk &lt;<a href=
=3D"mailto:kkostiuk@redhat.com" target=3D"_blank">kkostiuk@redhat.com</a><b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:kkostiuk@redhat.com" t=
arget=3D"_blank">kkostiuk@redhat.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; ---<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0qga/vss-win32/vss-debug.h | 31 ++=
+++++++++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A01 file changed, 31 insertions(+)<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0create mode 100644 qga/vss-win32/=
vss-debug.h<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#define PRINT_DEBUG(fmt, ...) {=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 char user_sting[512] =3D { 0 }=
;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 char full_string[640] =3D { 0 =
};=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 snprintf(user_sting, 512, fmt,=
 ## __VA_ARGS__);=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 snprintf(full_string, 640, QGA=
_PROVIDER_NAME&quot;[%lu]: %s<br>
&gt;=C2=A0 =C2=A0 =C2=A0%s\n&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0\<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 GetCurrentThread=
Id(), __func__, user_sting);=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 OutputDebugString(full_string)=
;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 fprintf(stderr, &quot;%s&quot;=
, full_string);=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Why not simply use a plain function?<br>
&gt; <br>
&gt; <br>
&gt; I am not sure what you mean.<br>
&gt; <br>
&gt; If you mean to call OutputDebugString directly, then we need to <br>
&gt; concatenate the proper string<br>
&gt; for each call.<br>
&gt; If you mean convert PRINT_DEBUG to function, then we can&#39;t use the=
 <br>
&gt; __func__ macro in<br>
&gt; PRINT_DEBUG to get the real function name. We can convert PRINT_DEBUG =
to <br>
&gt; function<br>
&gt; and a new macro that will call PRINT_DEBUG and pass a proper value of =
<br>
&gt; __fucn__.<br>
&gt; <br>
&gt; What solution is better there?<br>
<br>
=C2=A0 =C2=A0void qga_debug(const char *funcname, const char *fmt, ...);<br=
>
<br>
and g_strdup_vprintf()?<br></blockquote><div><br></div><div><br></div><div>=
I agree about the qga_debug function. <br></div><div>About g_strdup_vprintf=
 I am not sure. Currently, VSS uses only one function from GLib (g_assertio=
n_message_expr).</div><div>In the past, we had problems with GLib due to mi=
stakes in Windows implementation and we thinking about</div><div>removing G=
Lib from VSS at all. As VSS.DLL is also invoked directly from Windows, we s=
hould use standard <br></div><div>C++ types in public functions. We can use=
 GLib types/functions for the internal part of DLL, <span class=3D"gmail-Hw=
tZe" lang=3D"en"><span class=3D"gmail-jCAhz gmail-ChMk0b"><span class=3D"gm=
ail-ryNqvb">but I think it will <br></span></span></span></div><div><span c=
lass=3D"gmail-HwtZe" lang=3D"en"><span class=3D"gmail-jCAhz gmail-ChMk0b"><=
span class=3D"gmail-ryNqvb">be confusing. <br></span></span></span></div></=
div></div>

--000000000000a80ae705ffcf6420--


