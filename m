Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F7078FDAD
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 14:47:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc3XL-0004Ar-Hm; Fri, 01 Sep 2023 08:46:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <belmouss@redhat.com>)
 id 1qc3XI-0004AC-3w
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 08:46:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <belmouss@redhat.com>)
 id 1qc3XE-0004E0-KD
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 08:46:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693572359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A6yVvBA0Fl7mQ/6uiaLMfvmegHqGvn7fBP/4cVScsEA=;
 b=MD2M8CmgO1/yBx5Yvw30q5KYGx9ZEfXWcQf1U8smglq1tQTrSGhicURPm84S9HHvCpVnaS
 GB4R2IKOuhWtHZ9uyzw2RH7o770Xvn1p2PTMBWrTLrzCh8KaH7oCJSx70HHz8khGi2iKGR
 YSDraTJ2HiriBsUsEWHJr5hjcnJTVDA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-otDRu-csMzCFE35bu1uDfQ-1; Fri, 01 Sep 2023 08:45:57 -0400
X-MC-Unique: otDRu-csMzCFE35bu1uDfQ-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-521a38098faso1456328a12.2
 for <qemu-devel@nongnu.org>; Fri, 01 Sep 2023 05:45:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693572356; x=1694177156;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=A6yVvBA0Fl7mQ/6uiaLMfvmegHqGvn7fBP/4cVScsEA=;
 b=PSw6WBsQkEIYySzJZ9LuddqiMnN1JP9Rbk69WheHB7pA3iYXPsMzmQcUBs9+uVrxe5
 zUXmaaF7kLq/YLPZrJjzYv18TjfQIKkltBWlxV4sZz5sKqzHYitqzKq3wzwZ3D7i90Nd
 gtGNBw032VYDWbclIJ8DM1CisOTRo23gf3GA6tXF3WS/Fn0I8/vGsOR75NHVKsZ9L7MH
 a1FJqVq9o3Zhci21iHEDYH9rCDlELRQPKlR1z8EtF5ayyms0DcQ359Zplw6ng0ixnUU/
 OEZMnKK3NZ8wUIOwD229MghYu6zYosoUaERs7jQirfxP60HojVcwCFtMdtsOWSrYB2eO
 K5aA==
X-Gm-Message-State: AOJu0Yy7pZ27m5nkTKdoevnBZjD8R9rNN5n0Z7+3w2t6j1hXCbDcmCC+
 ieBXX9LVH+5Q37rig3I4tGvjI5JNNpoDwg5NZP9hEgEJvUzI4U4lzq2QfRQDuHyKDR/ZfjuTQuc
 l6liilRlLpfBykGJUDS11y6RUfXvsN34=
X-Received: by 2002:a05:6402:8c3:b0:523:37ff:1170 with SMTP id
 d3-20020a05640208c300b0052337ff1170mr1866530edz.16.1693572356667; 
 Fri, 01 Sep 2023 05:45:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQE0Z9G6R62kjsViyWIppdgWa0jUFDFaKfHDuxntUfVS84nPLjIvMA1FzrXcn9BnMN2jNCx2yevGQ2JYjNoTg=
X-Received: by 2002:a05:6402:8c3:b0:523:37ff:1170 with SMTP id
 d3-20020a05640208c300b0052337ff1170mr1866516edz.16.1693572356378; Fri, 01 Sep
 2023 05:45:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230901103020.86915-1-belmouss@redhat.com>
 <adbb7fc5-1e25-131b-b6dd-da782d46528c@linaro.org>
In-Reply-To: <adbb7fc5-1e25-131b-b6dd-da782d46528c@linaro.org>
From: Bilal Elmoussaoui <belmouss@redhat.com>
Date: Fri, 1 Sep 2023 14:45:45 +0200
Message-ID: <CALz9Gza-=sxx8bsddL4f-bUzAkhXvF2a=y8sZMkDo+SQ_jZ01w@mail.gmail.com>
Subject: Re: [PATCH] dbus: Properly dispose touch/mouse dbus objects
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000b4237306044b8a82"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=belmouss@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000b4237306044b8a82
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

Sorry, I forgot that again. Sent a v2

On Fri, Sep 1, 2023 at 12:48=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd=
@linaro.org>
wrote:

> Hi Bilal,
>
> Fixes: 142ca628a7 ("ui: add a D-Bus display backend")
> Fixes: de9f844ce2 ("ui/dbus: Expose a touch device interface")
>
> See
>
> https://www.qemu.org/docs/master/devel/submitting-a-patch.html#patch-emai=
ls-must-include-a-signed-off-by-line
>
>    Your patches must include a Signed-off-by: line. This is a
>    hard requirement because it=E2=80=99s how you say =E2=80=9CI=E2=80=99m=
 legally okay
>    to contribute this and happy for it to go into QEMU=E2=80=9D.
>
> On 1/9/23 12:30, Bilal Elmoussaoui wrote:
> > ---
> >   ui/dbus-console.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/ui/dbus-console.c b/ui/dbus-console.c
> > index e19774f985..36f7349585 100644
> > --- a/ui/dbus-console.c
> > +++ b/ui/dbus-console.c
> > @@ -150,6 +150,8 @@ dbus_display_console_dispose(GObject *object)
> >       DBusDisplayConsole *ddc =3D DBUS_DISPLAY_CONSOLE(object);
> >
> >       unregister_displaychangelistener(&ddc->dcl);
> > +    g_clear_object(&ddc->iface_touch);
> > +    g_clear_object(&ddc->iface_mouse);
> >       g_clear_object(&ddc->iface_kbd);
> >       g_clear_object(&ddc->iface);
> >       g_clear_pointer(&ddc->listeners, g_hash_table_unref);
>
>

--000000000000b4237306044b8a82
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Philippe,</div><div><br></div><div>Sorry, I forgot=
 that again. Sent a v2<br></div></div><br><div class=3D"gmail_quote"><div d=
ir=3D"ltr" class=3D"gmail_attr">On Fri, Sep 1, 2023 at 12:48=E2=80=AFPM Phi=
lippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org">philmd@li=
naro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">Hi Bilal,<br>
<br>
Fixes: 142ca628a7 (&quot;ui: add a D-Bus display backend&quot;)<br>
Fixes: de9f844ce2 (&quot;ui/dbus: Expose a touch device interface&quot;)<br=
>
<br>
See <br>
<a href=3D"https://www.qemu.org/docs/master/devel/submitting-a-patch.html#p=
atch-emails-must-include-a-signed-off-by-line" rel=3D"noreferrer" target=3D=
"_blank">https://www.qemu.org/docs/master/devel/submitting-a-patch.html#pat=
ch-emails-must-include-a-signed-off-by-line</a><br>
<br>
=C2=A0 =C2=A0Your patches must include a Signed-off-by: line. This is a<br>
=C2=A0 =C2=A0hard requirement because it=E2=80=99s how you say =E2=80=9CI=
=E2=80=99m legally okay<br>
=C2=A0 =C2=A0to contribute this and happy for it to go into QEMU=E2=80=9D.<=
br>
<br>
On 1/9/23 12:30, Bilal Elmoussaoui wrote:<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0ui/dbus-console.c | 2 ++<br>
&gt;=C2=A0 =C2=A01 file changed, 2 insertions(+)<br>
&gt; <br>
&gt; diff --git a/ui/dbus-console.c b/ui/dbus-console.c<br>
&gt; index e19774f985..36f7349585 100644<br>
&gt; --- a/ui/dbus-console.c<br>
&gt; +++ b/ui/dbus-console.c<br>
&gt; @@ -150,6 +150,8 @@ dbus_display_console_dispose(GObject *object)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0DBusDisplayConsole *ddc =3D DBUS_DISPLAY_CON=
SOLE(object);<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0unregister_displaychangelistener(&amp;ddc-&g=
t;dcl);<br>
&gt; +=C2=A0 =C2=A0 g_clear_object(&amp;ddc-&gt;iface_touch);<br>
&gt; +=C2=A0 =C2=A0 g_clear_object(&amp;ddc-&gt;iface_mouse);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0g_clear_object(&amp;ddc-&gt;iface_kbd);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0g_clear_object(&amp;ddc-&gt;iface);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0g_clear_pointer(&amp;ddc-&gt;listeners, g_ha=
sh_table_unref);<br>
<br>
</blockquote></div>

--000000000000b4237306044b8a82--


