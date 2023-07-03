Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D2458745848
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 11:22:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGFkb-0004bs-70; Mon, 03 Jul 2023 05:21:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qGFkZ-0004bk-NL
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 05:21:39 -0400
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qGFkX-0004Y5-Np
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 05:21:39 -0400
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-402532f9721so17268811cf.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 02:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688376095; x=1690968095;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=W4zuNRPn3zuxYHZkj8G6LwmoEq9e3H1PRLIsBiPI7k8=;
 b=Rht3lCGY9Rd3CLMhevhPHMT1WWIEQYHi+fkv6kOtjWGnmVklF+8B3SpRNmdnvD4FX7
 ppO7TrOj++obSdarLrrw1BapVNWcUxH65qwmOaK7PKMGYg05pAwvTzFbTe2NVYrsycUR
 kzQST53uBAoSdiqaGqylQkGawi0QTUstpY/XQardZKDqrtGNNR5KzJtloHeOb4qzKBDK
 o/UfdOS8M+Wlj34EtZvX4JSIwwJAXMU0Ok8Bv6nCx4cWtUrEL3xmnEf05WbnMtigiwnZ
 OXtb25os91YYOnffVkmqfBHw+2ZVWtgc5QiSWWeCf/6Kp2T0O2aW+65Th6BeXPJbmH8Y
 d8fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688376095; x=1690968095;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W4zuNRPn3zuxYHZkj8G6LwmoEq9e3H1PRLIsBiPI7k8=;
 b=iptjh5Y8zLOl+F7OqDy2rH7xq+mobXDhVl1sz25/sjEOVU5i1lI1xlUKnwAgChR0Of
 RB0r4gBxT9NokBKFjhvwWJYWRM7Q+Bw9p6+JNRA1IXm5FaKmTisebZa1JXvP52DbSlv0
 1Yc0x4fiSGlkSaxf5wtaf7RLftKgZcztlDLDhIZJp2GqdNVqa3s83DfqcoyUP7sQmPLT
 X+LHGDbuov4NHLSBwMlWLy60sjweGe4N1+IlWq1ocrGu7p7ydIuqW/6q0u6x0C1Fe+M9
 l98YEx1zYZEcPHHmJQhJLOeWq20mVNaCfnbJok03Gx/aYnMtGiASWmCYNTqt1TdmUeXX
 BCvw==
X-Gm-Message-State: AC+VfDxmpKMuPLuobKJ/dvmVJfcNGQmFuI2beNoO1J3K71QbyAq+dKNU
 +vFoLCzNh46EClUGAerBop2b35RBe4WeKnuz37M=
X-Google-Smtp-Source: ACHHUZ6mP3FHNG4UpIlWic7FxyXwmiLbz6gZua6/tjyARRGmdyvTq6jdhfsKE5D1DiAJ4yPu6zgQWnImd+7kpDY1KIE=
X-Received: by 2002:ac8:574a:0:b0:403:20f4:e1cf with SMTP id
 10-20020ac8574a000000b0040320f4e1cfmr17677546qtx.26.1688376095503; Mon, 03
 Jul 2023 02:21:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230630234839.14716-1-philmd@linaro.org>
In-Reply-To: <20230630234839.14716-1-philmd@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 3 Jul 2023 11:21:24 +0200
Message-ID: <CAJ+F1CKfx2i3fcikH_LujYGWmF56gyaECHqwPjwKoZqbHZsw9w@mail.gmail.com>
Subject: Re: [PATCH] ui: Link dbus-display with pixman again
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Frederic Bezies <fredbezies@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000006b795505ff91b1ca"
Received-SPF: pass client-ip=2607:f8b0:4864:20::833;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x833.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

--0000000000006b795505ff91b1ca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Sat, Jul 1, 2023 at 1:49=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org>
wrote:

> Since its introduction in commit 142ca628a7 ("ui: add a D-Bus
> display backend"), dbus_display1 depends on pixman.
> Unfortunatly the refactor commit 1222070e77 ("meson: ensure
> dbus-display generated code is built before other units")
> dropped that dependency. Recently commit 6cc5a6159a ("ui/dbus:
> win32 support") expose this problem:
>
>   In file included from include/ui/console.h:4,
>                    from ui/dbus.h:31,
>                    from ../audio/dbusaudio.c:36:
>   include/ui/qemu-pixman.h:12:10: fatal error: pixman.h: No such file or
> directory
>      12 | #include <pixman.h>
>         |          ^~~~~~~~~~
>
> Restore the missing dependency on pixman.
>

I fail to understand how this would help.  dbus-display1 unit is pure
GIO/GDBus code, no pixman involved. The derived library dependency is then
used to build and link the dbus ui/ module.

audio/dbus currently requires pixman because it compiles against units from
ui/dbus, which introduces some indirect pixman dependency from ui/console.

It would be worth working on making pixman optional altogether (
https://gitlab.com/qemu-project/qemu/-/issues/1172), I will try to look at
it.

thanks


> Reported-by: Frederic Bezies <fredbezies@gmail.com>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1739
> Fixes: 1222070e77 ("meson: ensure dbus-display generated code is built
> before other units")
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  ui/meson.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/ui/meson.build b/ui/meson.build
> index d81609fb0e..cb178dd095 100644
> --- a/ui/meson.build
> +++ b/ui/meson.build
> @@ -90,7 +90,7 @@ if dbus_display
>                                            '--interface-prefix',
> 'org.qemu.',
>                                            '--c-namespace', 'QemuDBus',
>                                            '--generate-c-code', '@BASENAM=
E@
> '])
> -  dbus_display1_lib =3D static_library('dbus-display1', dbus_display1,
> dependencies: gio)
> +  dbus_display1_lib =3D static_library('dbus-display1', dbus_display1,
> dependencies: [gio, pixman])
>    dbus_display1_dep =3D declare_dependency(link_with: dbus_display1_lib,
> include_directories: include_directories('.'))
>    dbus_ss.add(when: [gio, pixman, dbus_display1_dep],
>                if_true: [files(
> --
> 2.38.1
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--0000000000006b795505ff91b1ca
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, Jul 1, 2023 at 1:49=E2=80=
=AFAM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org">=
philmd@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">Since its introduction in commit 142ca628a7 (&quot;ui: add=
 a D-Bus<br>
display backend&quot;), dbus_display1 depends on pixman.<br>
Unfortunatly the refactor commit 1222070e77 (&quot;meson: ensure<br>
dbus-display generated code is built before other units&quot;)<br>
dropped that dependency. Recently commit 6cc5a6159a (&quot;ui/dbus:<br>
win32 support&quot;) expose this problem:<br>
<br>
=C2=A0 In file included from include/ui/console.h:4,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from u=
i/dbus.h:31,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from .=
./audio/dbusaudio.c:36:<br>
=C2=A0 include/ui/qemu-pixman.h:12:10: fatal error: pixman.h: No such file =
or directory<br>
=C2=A0 =C2=A0 =C2=A012 | #include &lt;pixman.h&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~<=
br>
<br>
Restore the missing dependency on pixman.<br></blockquote><div><br></div><d=
iv>I fail to understand how this would help.=C2=A0 dbus-display1 unit is pu=
re GIO/GDBus code, no pixman involved. The derived library dependency is th=
en used to build and link the dbus ui/ module.</div><div><br></div><div>aud=
io/dbus currently requires pixman because it compiles against units from ui=
/dbus, which introduces some indirect pixman dependency from ui/console.</d=
iv><div><br></div><div>It would be worth working on making pixman optional =
altogether (<a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/1172">=
https://gitlab.com/qemu-project/qemu/-/issues/1172</a>), I will try to look=
 at it.<br></div><div><br></div><div>thanks</div><div><br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">
<br>
Reported-by: Frederic Bezies &lt;<a href=3D"mailto:fredbezies@gmail.com" ta=
rget=3D"_blank">fredbezies@gmail.com</a>&gt;<br>
Resolves: <a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/1739" re=
l=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-project/qemu/-/i=
ssues/1739</a><br>
Fixes: 1222070e77 (&quot;meson: ensure dbus-display generated code is built=
 before other units&quot;)<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@lin=
aro.org" target=3D"_blank">philmd@linaro.org</a>&gt;<br>
---<br>
=C2=A0ui/meson.build | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/ui/meson.build b/ui/meson.build<br>
index d81609fb0e..cb178dd095 100644<br>
--- a/ui/meson.build<br>
+++ b/ui/meson.build<br>
@@ -90,7 +90,7 @@ if dbus_display<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0&#39;--interface-prefix&#39;, &#39;org.qemu.&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0&#39;--c-namespace&#39;, &#39;QemuDBus&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0&#39;--generate-c-code&#39;, &#39;@BASENAME@&#39;])<br>
-=C2=A0 dbus_display1_lib =3D static_library(&#39;dbus-display1&#39;, dbus_=
display1, dependencies: gio)<br>
+=C2=A0 dbus_display1_lib =3D static_library(&#39;dbus-display1&#39;, dbus_=
display1, dependencies: [gio, pixman])<br>
=C2=A0 =C2=A0dbus_display1_dep =3D declare_dependency(link_with: dbus_displ=
ay1_lib, include_directories: include_directories(&#39;.&#39;))<br>
=C2=A0 =C2=A0dbus_ss.add(when: [gio, pixman, dbus_display1_dep],<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if_true: [files(<br>
-- <br>
2.38.1<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--0000000000006b795505ff91b1ca--

