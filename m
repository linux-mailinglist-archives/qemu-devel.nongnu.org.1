Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FA6744408
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 23:44:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFLuo-0006Fn-SF; Fri, 30 Jun 2023 17:44:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qFLug-000692-CA
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 17:44:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qFLue-0001Yy-H5
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 17:44:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688161459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HSeXSTijN04lMBU4Io8EFL7xkmVl5arZ28yqkgTYJ8g=;
 b=V693rQJdCw2alSEefDt4UhpxpN0RRF/7HwCIVhYPh4we3LeFimMfaTKr01pDh4MHm5qLkv
 J6JtzvR60ZYfbtuz/KnZEONJ6yN6TtV/y8n8LFPaZf+UYWh1H6ECaeZCUeh2fp2K2d4ftL
 Er0Eq4IiuvtI1HcMdo2+IkSvIJnA2/4=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-_a2dRtzLPDC_NyCe-ZGLFg-1; Fri, 30 Jun 2023 17:44:16 -0400
X-MC-Unique: _a2dRtzLPDC_NyCe-ZGLFg-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-4ecb00906d0so2314118e87.1
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 14:44:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688161455; x=1690753455;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HSeXSTijN04lMBU4Io8EFL7xkmVl5arZ28yqkgTYJ8g=;
 b=Gn6byjITWneSplL7N0+XrGnX+X53hqFev4V6d0VA2RPB4/bk5vjtUrDzdEeeFqv8QQ
 jXwT5ISuegpSzX/wI/SnUkktusKotT4cZH29nuREC3Mu9yxYNin7ZKpeiH6Zo3ZxpObX
 wqzHUPT7+yj0MFeLFJjdB1i8f/M2yXdkGhHuBqB2v/MJuteJu9GHBLEoXCcu6zgCXrkE
 5oP9lO61bhMokvGz3vKXjsbrB2oyn0sJ3UV9SPre+DJduWVegkpU7DcSdTyPC3kXoL7W
 qg0NqKRgwYjuaV1GUer840GqD7A5j7qeJ2jwl23Eg3NttSQRxRZVAazLxIKsAhUh0P6m
 nFxA==
X-Gm-Message-State: ABy/qLb+tV6Uo4qbbaBKWSiAkz4sRQCl8FVOMuF8QiItRF7JoFH/FDym
 SLrxWKz41Mu5GTpY1CowTCEYpcj/WG0b2visi77ssxjKSnkfmRmap2EV+WorjXydmX1oe7hkvjf
 H23T/zoRVwGrqiqmOtHHAv4uL8nKS9AA=
X-Received: by 2002:ac2:5f52:0:b0:4fb:8574:a9c6 with SMTP id
 18-20020ac25f52000000b004fb8574a9c6mr2962794lfz.10.1688161455060; 
 Fri, 30 Jun 2023 14:44:15 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGA07KYp011kmRddj2psec5hFObCREwBw8ZZy+HXNCvKrAXO36oyf9HbfF8lVmEijoIaeaONPTI2MfxVBjCiSw=
X-Received: by 2002:ac2:5f52:0:b0:4fb:8574:a9c6 with SMTP id
 18-20020ac25f52000000b004fb8574a9c6mr2962786lfz.10.1688161454758; Fri, 30 Jun
 2023 14:44:14 -0700 (PDT)
MIME-Version: 1.0
References: <156d2af2-5e64-39f1-fdbd-54f6c299515a@eik.bme.hu>
 <336f7697-bcfa-1f5f-e411-6859815aa26c@eik.bme.hu>
 <66b37cc9-4f48-3ba5-8f3e-39f7e715970e@linaro.org>
In-Reply-To: <66b37cc9-4f48-3ba5-8f3e-39f7e715970e@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 30 Jun 2023 23:44:02 +0200
Message-ID: <CAMxuvawjA-44aeJcXYLmdE8VRPrCOrzmBVC9AfgDqSnGXJqS7w@mail.gmail.com>
Subject: Re: Unused variables in dbus_call_update_gl
To: Richard Henderson <richard.henderson@linaro.org>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000d5b46a05ff5fb7e0"
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

--000000000000d5b46a05ff5fb7e0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Richard

On Fri, Jun 30, 2023 at 4:31=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 6/29/23 15:15, BALATON Zoltan wrote:
> > On Thu, 29 Jun 2023, BALATON Zoltan wrote:
> >> Hello,
> >>
> >> After recent commits I'm now getting:
> >>
> >> ../ui/dbus-listener.c: In function =E2=80=98dbus_call_update_gl=E2=80=
=99:
> >> ../ui/dbus-listener.c:210:26: error: unused variable =E2=80=98ddl=E2=
=80=99
> >> [-Werror=3Dunused-variable]
> >>   210 |     DBusDisplayListener *ddl =3D container_of(dcl,
> DBusDisplayListener,
> >> dcl);
> >>       |                          ^~~
> >> At top level:
> >> ../ui/dbus-listener.c:180:13: error: =E2=80=98dbus_update_gl_cb=E2=80=
=99 defined but
> not used
> >> [-Werror=3Dunused-function]
> >>   180 | static void dbus_update_gl_cb(GObject *source_object,
> >>       |             ^~~~~~~~~~~~~~~~~
> >> cc1: all warnings being treated as errors
> >>
> >> when compiling on Linux with gcc.
> >
> > The patch below seems to fix compilation for me but not sure what else
> > would it break.
> >
> > Regards,
> > BALATON Zoltan
> >
> > diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
> > index e10162b279..601c134e09 100644
> > --- a/ui/dbus-listener.c
> > +++ b/ui/dbus-listener.c
> > @@ -177,6 +177,7 @@ fail:
> >   }
> >   #endif /* WIN32 */
> >
> > +#if defined (CONFIG_GBM) || defined (WIN32)
> >   static void dbus_update_gl_cb(GObject *source_object,
> >                                 GAsyncResult *res,
> >                                 gpointer user_data)
> > @@ -203,12 +204,14 @@ static void dbus_update_gl_cb(GObject
> *source_object,
> >       graphic_hw_gl_block(ddl->dcl.con, false);
> >       g_object_unref(ddl);
> >   }
> > +#endif
> >
> >   static void dbus_call_update_gl(DisplayChangeListener *dcl,
> >                                   int x, int y, int w, int h)
> >   {
> > +#if defined (CONFIG_GBM) || defined (WIN32)
> >       DBusDisplayListener *ddl =3D container_of(dcl, DBusDisplayListene=
r,
> dcl);
> > -
> > +#endif
> >       trace_dbus_update_gl(x, y, w, h);
> >
> >       glFlush();
>
> I'm going to commit this later today unless Marc can immediately suggest
> something better,
> to un-break the tree.  I really should have done more thorough testing
> earlier, and not
> allowed the merge to proceed...  Ho hum.
>
>
>
Please commit, along with "[PATCH] audio: dbus requires pixman"

thanks

--000000000000d5b46a05ff5fb7e0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Richard<br></div><br><div class=3D"gma=
il_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jun 30, 2023 at 4:3=
1=E2=80=AFPM Richard Henderson &lt;<a href=3D"mailto:richard.henderson@lina=
ro.org">richard.henderson@linaro.org</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">On 6/29/23 15:15, BALATON Zoltan wrote:=
<br>
&gt; On Thu, 29 Jun 2023, BALATON Zoltan wrote:<br>
&gt;&gt; Hello,<br>
&gt;&gt;<br>
&gt;&gt; After recent commits I&#39;m now getting:<br>
&gt;&gt;<br>
&gt;&gt; ../ui/dbus-listener.c: In function =E2=80=98dbus_call_update_gl=E2=
=80=99:<br>
&gt;&gt; ../ui/dbus-listener.c:210:26: error: unused variable =E2=80=98ddl=
=E2=80=99<br>
&gt;&gt; [-Werror=3Dunused-variable]<br>
&gt;&gt;=C2=A0 =C2=A0210 |=C2=A0 =C2=A0 =C2=A0DBusDisplayListener *ddl =3D =
container_of(dcl, DBusDisplayListener,<br>
&gt;&gt; dcl);<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~<br>
&gt;&gt; At top level:<br>
&gt;&gt; ../ui/dbus-listener.c:180:13: error: =E2=80=98dbus_update_gl_cb=E2=
=80=99 defined but not used<br>
&gt;&gt; [-Werror=3Dunused-function]<br>
&gt;&gt;=C2=A0 =C2=A0180 | static void dbus_update_gl_cb(GObject *source_ob=
ject,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0^~~~~~~~~~~~~~~~~<br>
&gt;&gt; cc1: all warnings being treated as errors<br>
&gt;&gt;<br>
&gt;&gt; when compiling on Linux with gcc.<br>
&gt; <br>
&gt; The patch below seems to fix compilation for me but not sure what else=
<br>
&gt; would it break.<br>
&gt; <br>
&gt; Regards,<br>
&gt; BALATON Zoltan<br>
&gt; <br>
&gt; diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c<br>
&gt; index e10162b279..601c134e09 100644<br>
&gt; --- a/ui/dbus-listener.c<br>
&gt; +++ b/ui/dbus-listener.c<br>
&gt; @@ -177,6 +177,7 @@ fail:<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0#endif /* WIN32 */<br>
&gt; <br>
&gt; +#if defined (CONFIG_GBM) || defined (WIN32)<br>
&gt;=C2=A0 =C2=A0static void dbus_update_gl_cb(GObject *source_object,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0GAsyncResult *res,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gpointer user_data)<br>
&gt; @@ -203,12 +204,14 @@ static void dbus_update_gl_cb(GObject *source_ob=
ject,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0graphic_hw_gl_block(ddl-&gt;dcl.con, false);=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0g_object_unref(ddl);<br>
&gt;=C2=A0 =C2=A0}<br>
&gt; +#endif<br>
&gt; <br>
&gt;=C2=A0 =C2=A0static void dbus_call_update_gl(DisplayChangeListener *dcl=
,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int x, int y, int w,=
 int h)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt; +#if defined (CONFIG_GBM) || defined (WIN32)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0DBusDisplayListener *ddl =3D container_of(dc=
l, DBusDisplayListener, dcl);<br>
&gt; -<br>
&gt; +#endif<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0trace_dbus_update_gl(x, y, w, h);<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0glFlush();<br>
<br>
I&#39;m going to commit this later today unless Marc can immediately sugges=
t something better, <br>
to un-break the tree.=C2=A0 I really should have done more thorough testing=
 earlier, and not <br>
allowed the merge to proceed...=C2=A0 Ho hum.<br>
<br>
<br></blockquote><div><br></div><div>Please commit, along with &quot;[PATCH=
] audio: dbus requires pixman&quot;</div><div><br></div>thanks<br></div></d=
iv>

--000000000000d5b46a05ff5fb7e0--


