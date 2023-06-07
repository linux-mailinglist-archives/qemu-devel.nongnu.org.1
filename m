Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F33F725B9C
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 12:29:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6qPp-0001XP-Ho; Wed, 07 Jun 2023 06:29:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1q6qPo-0001XC-IM
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 06:29:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1q6qPn-0005c4-4Z
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 06:29:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686133758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7pXQM7RqjiTfisDXQmJcJ/60zkwWO4+E5tYeIlKfaGU=;
 b=K6HOlOvmwN6FImYLpqUqi9jnn5DwOpetaYbOXc5RZ4XliD0XCWXcOtRWezeDMgwGLhK4hA
 ebBJ+s1JfkEnudpC8gAbT2BFbe7TjJuymhdYILqtXpua78Ud2XFBjSmtebHDaMEVl0PZOP
 rikQ9Uz0F5/wnYNTxe2g2oY89rhEsSs=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-LQfXrqvuMe-XVbqO9AfSHQ-1; Wed, 07 Jun 2023 06:29:17 -0400
X-MC-Unique: LQfXrqvuMe-XVbqO9AfSHQ-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-513f5318ff2so654265a12.3
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 03:29:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686133754; x=1688725754;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7pXQM7RqjiTfisDXQmJcJ/60zkwWO4+E5tYeIlKfaGU=;
 b=WSVhIDTo0Nxdm2L4p38t3Q4Mbdpc+b0tddn9jBFrngkj9vBFe04aN7AoP1dvqeV/zN
 c8FqTnHHbsFsFO29c/RzvTX6/ypXU2z2kJapPgl7qKt71Ir1mcywx9VhpE6pa81R3DLO
 MnSipniF9WXYK0qAkj5gRj0t9JybbMIENESinZalNMQgVfRy5DMfeUggy7SwXiZ+buGw
 NVibMz4zo14Um8iN8w5rGWnm7R5YCie9olYVtSJcUFGVSu5bECrCJpgRdpuAijcNiZuN
 PWSL6KHED7KRKiC1jgifwZHQMmI1Kt0NU2DmhxaoFswGlEHbdquqKIZEaOcEBt/jkqfJ
 cEQg==
X-Gm-Message-State: AC+VfDyalqMWgy0ddXBDcVlXsQAEAQQIMQXnglX2xgxqzCEynas539Dk
 oXYAnBPaqqZSUdxgsDx19pvSVmD9Caq9jSUbx3Av940hORsvsBiclxrG1Jq7DOaGSWqUDV5spe3
 vRtg/Sqs6Q/mJz9rKNzlQ6GyxhQ9Md3S0+Rw+wgqovQ==
X-Received: by 2002:aa7:d1d4:0:b0:514:945c:6cea with SMTP id
 g20-20020aa7d1d4000000b00514945c6ceamr3873235edp.37.1686133754487; 
 Wed, 07 Jun 2023 03:29:14 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4BfGp4e616PjqEc5gvlPG6JDL6vEmxWXKzp1rzyRmYwUBgOUHv6/PwoIoJqg86axisbpE4kBGceeU1yq+7HkQ=
X-Received: by 2002:aa7:d1d4:0:b0:514:945c:6cea with SMTP id
 g20-20020aa7d1d4000000b00514945c6ceamr3873220edp.37.1686133754238; Wed, 07
 Jun 2023 03:29:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230607091244.55270-1-quic_acaggian@quicinc.com>
In-Reply-To: <20230607091244.55270-1-quic_acaggian@quicinc.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 7 Jun 2023 14:29:02 +0400
Message-ID: <CAMxuvaw88g9RPp_Om2Z9dJSmsrFMZ9ieKx8uJmSNgfsOYyQvSQ@mail.gmail.com>
Subject: Re: [PATCH] ui/sdl2: Support multiple OpenGL-enabled windows
To: Antonio Caggiano <quic_acaggian@quicinc.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Akihiko Odaki <akihiko.odaki@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000772e5005fd879b2d"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000772e5005fd879b2d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Antonio

On Wed, Jun 7, 2023 at 1:13=E2=80=AFPM Antonio Caggiano <quic_acaggian@quic=
inc.com>
wrote:

> Multiple graphics devices can be defined with an associated OpenGL
> enabled SDL console, hence make sure to not destroy their shaders and
> windows.
>
>
Signed-off-by: Antonio Caggiano <quic_acaggian@quicinc.com>
> ---
>  ui/sdl2-gl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/ui/sdl2-gl.c b/ui/sdl2-gl.c
> index bbfa70eac3..795fb1afc9 100644
> --- a/ui/sdl2-gl.c
> +++ b/ui/sdl2-gl.c
> @@ -89,7 +89,7 @@ void sdl2_gl_switch(DisplayChangeListener *dcl,
>
>      scon->surface =3D new_surface;
>
> -    if (is_placeholder(new_surface) && qemu_console_get_index(dcl->con))=
 {
> +    if (is_placeholder(new_surface) && !scon->opengl) {
>          qemu_gl_fini_shader(scon->gls);
>          scon->gls =3D NULL;
>          sdl2_window_destroy(scon);
>

This was introduced in commit c821a58ee7003c2a0567dddaee33c2a5ae71c404 by
Akihiko.

Why should the window visibility behaviour be different whether it uses
opengl or not ?

If you are fixing a GL/shader crash, maybe it needs to be done differently.

thanks

--000000000000772e5005fd879b2d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Antonio<br></div><br><div class=3D"gma=
il_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jun 7, 2023 at 1:13=
=E2=80=AFPM Antonio Caggiano &lt;<a href=3D"mailto:quic_acaggian@quicinc.co=
m">quic_acaggian@quicinc.com</a>&gt; wrote:<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">Multiple graphics devices can be defined with a=
n associated OpenGL<br>
enabled SDL console, hence make sure to not destroy their shaders and<br>
windows.<br>=C2=A0 <br></blockquote><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
Signed-off-by: Antonio Caggiano &lt;<a href=3D"mailto:quic_acaggian@quicinc=
.com" target=3D"_blank">quic_acaggian@quicinc.com</a>&gt;<br>
---<br>
=C2=A0ui/sdl2-gl.c | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/ui/sdl2-gl.c b/ui/sdl2-gl.c<br>
index bbfa70eac3..795fb1afc9 100644<br>
--- a/ui/sdl2-gl.c<br>
+++ b/ui/sdl2-gl.c<br>
@@ -89,7 +89,7 @@ void sdl2_gl_switch(DisplayChangeListener *dcl,<br>
<br>
=C2=A0 =C2=A0 =C2=A0scon-&gt;surface =3D new_surface;<br>
<br>
-=C2=A0 =C2=A0 if (is_placeholder(new_surface) &amp;&amp; qemu_console_get_=
index(dcl-&gt;con)) {<br>
+=C2=A0 =C2=A0 if (is_placeholder(new_surface) &amp;&amp; !scon-&gt;opengl)=
 {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_gl_fini_shader(scon-&gt;gls);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0scon-&gt;gls =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sdl2_window_destroy(scon);<br></blockquot=
e><div><br></div><div><div>This was introduced in commit c821a58ee7003c2a05=
67dddaee33c2a5ae71c404 by Akihiko.</div><div><br></div>Why should the windo=
w visibility behaviour be different whether it uses opengl or not ?</div><d=
iv><br></div>If you are fixing a GL/shader crash, maybe it needs to be done=
 differently.</div><div class=3D"gmail_quote"><br></div><div class=3D"gmail=
_quote">thanks<br></div><div class=3D"gmail_quote"><div><br></div></div></d=
iv>

--000000000000772e5005fd879b2d--


