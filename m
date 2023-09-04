Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F73F7919E0
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 16:43:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdAn6-00058q-9K; Mon, 04 Sep 2023 10:43:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qdAn2-00057I-Ej
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 10:42:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qdAn0-0003NN-2q
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 10:42:56 -0400
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695--UTEYvABM6CE0TAVTGdmgg-1; Mon, 04 Sep 2023 10:42:51 -0400
X-MC-Unique: -UTEYvABM6CE0TAVTGdmgg-1
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-799c287fdd7so456074241.3
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 07:42:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693838570; x=1694443370;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6bzFypeUddhQa6A8u23hOkHTL01j0p9lb7PFW5eDikw=;
 b=Xo3tIgRioJu9gsHWw/O20aF1FHUpeiHlcs4Jkqyw59knSXG5/3C3Ryq9F9NHMVxvdl
 YBgSPRk5Nzcwj3zKCo5OjlKhXRFtA0d164zsnohLuoAP4SFcK6pN8dcSiit6iDAatFYE
 fy+PRytri8x+13mk2EplG55iuXx/0QwB+VbZG2ZYtHQHUiUsNTP6a9ct1QI9EPLohJHa
 6rZCrwWv0NkqC9Fp7O76aagm0AYjwMlRmglYvXNs2Cm/ROZ51okkNFmCRXVLO/6jlOyC
 dUv4dReTnufX3rN6u0SPgnhAXAiRUQZfTdq+USLIgqg1CaZw0nPFGNcdUFdrhsTlfpjP
 kiBw==
X-Gm-Message-State: AOJu0YxS+Tf3qa+w6S/Nm6nMmf/KKzZf9yIbtcXfQtbNOeqBPCOYFasj
 5jlkqL64E27brCRfyrs4oEBljd82MZubAWRkzSzQaxXO6SA3b1sZ95QGKMTRegyLYEOHNpaLzK0
 gF0E0N8xAtrAJuqxNONiR1c914SlnSpo=
X-Received: by 2002:a67:e24c:0:b0:44d:482a:5443 with SMTP id
 w12-20020a67e24c000000b0044d482a5443mr9566403vse.11.1693838570747; 
 Mon, 04 Sep 2023 07:42:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbsmi7yKw8Wrq05+wbqy+V8siZHIqI6IRYWLvx5OZM7WcS9aBOUfWw7VAAYreFBELL06nZVhJUADn/w1KLKXg=
X-Received: by 2002:a67:e24c:0:b0:44d:482a:5443 with SMTP id
 w12-20020a67e24c000000b0044d482a5443mr9566393vse.11.1693838570493; Mon, 04
 Sep 2023 07:42:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
 <20230830093843.3531473-62-marcandre.lureau@redhat.com>
 <10228ad3-2eb8-7f0e-58e2-93024af81950@linaro.org>
In-Reply-To: <10228ad3-2eb8-7f0e-58e2-93024af81950@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 4 Sep 2023 16:42:38 +0200
Message-ID: <CABgObfbv0fyXAxbck5mBP6YyXg+5+Vonr3Jer5zy_sQ8tk=s=A@mail.gmail.com>
Subject: Re: [PATCH 61/67] ui/spice: SPICE/QXL requires PIXMAN
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 qemu-devel <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000004d29c80604898666"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--0000000000004d29c80604898666
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il mer 30 ago 2023, 17:21 Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> h=
a
scritto:

> On 30/8/23 11:38, marcandre.lureau@redhat.com wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   hw/display/Kconfig |  2 +-
> >   ui/meson.build     | 12 ++++++------
> >   2 files changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/hw/display/Kconfig b/hw/display/Kconfig
> > index 7b3da68d1c..4d8b0cec40 100644
> > --- a/hw/display/Kconfig
> > +++ b/hw/display/Kconfig
> > @@ -93,7 +93,7 @@ config VGA
> >
> >   config QXL
> >       bool
> > -    depends on SPICE && PCI
> > +    depends on SPICE && PCI && PIXMAN
>
> Shouldn't this be:
>
> --- a/Kconfig.host
> +++ b/Kconfig.host
> @@ -14,4 +14,5 @@ config X11
>   config SPICE
>       bool
> +    depends on PIXMAN
>

No, all that would do is fail the build if SPICE=3Dy and PIXMAN=3Dn, but ri=
ght
now chardev/ has code that needs Spice but not pixman.

Paolo


> ---
>
> ?
>
> >
> >   config VIRTIO_GPU
> > diff --git a/ui/meson.build b/ui/meson.build
> > index b3525ef064..08d845d43a 100644
> > --- a/ui/meson.build
> > +++ b/ui/meson.build
> > @@ -133,7 +133,7 @@ if sdl.found()
> >     ui_modules +=3D {'sdl' : sdl_ss}
> >   endif
> >
> > -if spice.found()
> > +if spice.found() and pixman.found()
> >     spice_core_ss =3D ss.source_set()
> >     spice_core_ss.add(spice, pixman, files(
> >       'spice-core.c',
> > @@ -141,12 +141,12 @@ if spice.found()
> >       'spice-display.c'
> >     ))
> >     ui_modules +=3D {'spice-core' : spice_core_ss}
> > -endif
> >
> > -if spice.found() and gio.found()
> > -  spice_ss =3D ss.source_set()
> > -  spice_ss.add(spice, gio, pixman, files('spice-app.c'))
> > -  ui_modules +=3D {'spice-app': spice_ss}
> > +  if gio.found()
> > +    spice_ss =3D ss.source_set()
> > +    spice_ss.add(spice, gio, pixman, files('spice-app.c'))
> > +    ui_modules +=3D {'spice-app': spice_ss}
> > +  endif
> >   endif
> >
> >   keymaps =3D [
>
>

--0000000000004d29c80604898666
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il mer 30 ago 2023, 17:21 Philippe Mathieu-Daud=C3=A9 =
&lt;<a href=3D"mailto:philmd@linaro.org">philmd@linaro.org</a>&gt; ha scrit=
to:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex">On 30/8/23 11:38, <a href=3D"ma=
ilto:marcandre.lureau@redhat.com" target=3D"_blank" rel=3D"noreferrer">marc=
andre.lureau@redhat.com</a> wrote:<br>
&gt; From: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@re=
dhat.com" target=3D"_blank" rel=3D"noreferrer">marcandre.lureau@redhat.com<=
/a>&gt;<br>
&gt; <br>
&gt; Signed-off-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.=
lureau@redhat.com" target=3D"_blank" rel=3D"noreferrer">marcandre.lureau@re=
dhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0hw/display/Kconfig |=C2=A0 2 +-<br>
&gt;=C2=A0 =C2=A0ui/meson.build=C2=A0 =C2=A0 =C2=A0| 12 ++++++------<br>
&gt;=C2=A0 =C2=A02 files changed, 7 insertions(+), 7 deletions(-)<br>
&gt; <br>
&gt; diff --git a/hw/display/Kconfig b/hw/display/Kconfig<br>
&gt; index 7b3da68d1c..4d8b0cec40 100644<br>
&gt; --- a/hw/display/Kconfig<br>
&gt; +++ b/hw/display/Kconfig<br>
&gt; @@ -93,7 +93,7 @@ config VGA<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0config QXL<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bool<br>
&gt; -=C2=A0 =C2=A0 depends on SPICE &amp;&amp; PCI<br>
&gt; +=C2=A0 =C2=A0 depends on SPICE &amp;&amp; PCI &amp;&amp; PIXMAN<br>
<br>
Shouldn&#39;t this be:<br>
<br>
--- a/Kconfig.host<br>
+++ b/Kconfig.host<br>
@@ -14,4 +14,5 @@ config X11<br>
=C2=A0 config SPICE<br>
=C2=A0 =C2=A0 =C2=A0 bool<br>
+=C2=A0 =C2=A0 depends on PIXMAN<br></blockquote></div></div><div dir=3D"au=
to"><br></div><div dir=3D"auto">No, all that would do is fail the build if =
SPICE=3Dy and PIXMAN=3Dn, but right now chardev/ has code that needs Spice =
but not pixman.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</d=
iv><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"=
><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1=
px #ccc solid;padding-left:1ex">
<br>
---<br>
<br>
?<br>
<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0config VIRTIO_GPU<br>
&gt; diff --git a/ui/meson.build b/ui/meson.build<br>
&gt; index b3525ef064..08d845d43a 100644<br>
&gt; --- a/ui/meson.build<br>
&gt; +++ b/ui/meson.build<br>
&gt; @@ -133,7 +133,7 @@ if sdl.found()<br>
&gt;=C2=A0 =C2=A0 =C2=A0ui_modules +=3D {&#39;sdl&#39; : sdl_ss}<br>
&gt;=C2=A0 =C2=A0endif<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -if spice.found()<br>
&gt; +if spice.found() and pixman.found()<br>
&gt;=C2=A0 =C2=A0 =C2=A0spice_core_ss =3D ss.source_set()<br>
&gt;=C2=A0 =C2=A0 =C2=A0spice_core_ss.add(spice, pixman, files(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;spice-core.c&#39;,<br>
&gt; @@ -141,12 +141,12 @@ if spice.found()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;spice-display.c&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0))<br>
&gt;=C2=A0 =C2=A0 =C2=A0ui_modules +=3D {&#39;spice-core&#39; : spice_core_=
ss}<br>
&gt; -endif<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -if spice.found() and gio.found()<br>
&gt; -=C2=A0 spice_ss =3D ss.source_set()<br>
&gt; -=C2=A0 spice_ss.add(spice, gio, pixman, files(&#39;spice-app.c&#39;))=
<br>
&gt; -=C2=A0 ui_modules +=3D {&#39;spice-app&#39;: spice_ss}<br>
&gt; +=C2=A0 if gio.found()<br>
&gt; +=C2=A0 =C2=A0 spice_ss =3D ss.source_set()<br>
&gt; +=C2=A0 =C2=A0 spice_ss.add(spice, gio, pixman, files(&#39;spice-app.c=
&#39;))<br>
&gt; +=C2=A0 =C2=A0 ui_modules +=3D {&#39;spice-app&#39;: spice_ss}<br>
&gt; +=C2=A0 endif<br>
&gt;=C2=A0 =C2=A0endif<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0keymaps =3D [<br>
<br>
</blockquote></div></div></div>

--0000000000004d29c80604898666--


