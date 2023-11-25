Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F30B47F8CAC
	for <lists+qemu-devel@lfdr.de>; Sat, 25 Nov 2023 18:17:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6wGH-0005vI-Sq; Sat, 25 Nov 2023 12:16:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1r6wGD-0005ui-WB
 for qemu-devel@nongnu.org; Sat, 25 Nov 2023 12:16:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1r6wG9-0002KU-Ml
 for qemu-devel@nongnu.org; Sat, 25 Nov 2023 12:16:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700932559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n2+dcUqlP5aXh9lIHQJQn5kX+d5UMdu71CY1J7T0yWI=;
 b=LC6BHsh9BXFTV43d4UzV9b0Aw8AVLUa6K3lHYFosqyHHpLCrhhoEv3wp9TfSWGnQwI54YC
 8t7RXh6u6cFtYXNcAv9VS5ZWDUQgVsLt84irg9ec1O9WSGqxqw6oz8Y6Qof03kwh5SmsDU
 kJbL5aI5Vgtt6NaF6DepCLTccF2rEwM=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-dHR2FR8-MbG68ThLYl5Vlw-1; Sat, 25 Nov 2023 12:15:56 -0500
X-MC-Unique: dHR2FR8-MbG68ThLYl5Vlw-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-50ab368b334so2214632e87.0
 for <qemu-devel@nongnu.org>; Sat, 25 Nov 2023 09:15:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700932555; x=1701537355;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n2+dcUqlP5aXh9lIHQJQn5kX+d5UMdu71CY1J7T0yWI=;
 b=OE55uWQJSc4tJChczR+AYeb+NujyDouvQ/WAQvhuwgR6VfClsAIfGtEDQOEVhaEpTU
 mm96HyhUwpT1ryA9cXVo0PDZ9IqI8vKtzYJBg/QJaYDtp7xu95zK4QcKbHa8GErnMS3I
 XR+JjR9nDT9/JRv87sS3H6wBllUNXn914/8d23neZyufIwZhh4qSMY7Kc09ei6j3iCY2
 JRiMMokmslnzumwyi2h3ojF/S1603KV6J9nOrHtsfXGJ/zZkfVbNLjdiKcqu7wplT6UP
 f6Gc6GTscXnMriivf88fs9ab3LkvkqxWdc5e+wyFl/Po5Ky4SN88Ebj3qQF/loocDcnp
 rENg==
X-Gm-Message-State: AOJu0Yyqr8QF87cezOojzwp1iZLfZpYEDolv1XojJoyET9dx/WYFKOE2
 QhVqebl4RpEG/cWM9zu6CTGV9UM4/3cHe/G4UzJs6EnpHVFPq47s7648UejyxRH+PHX9snaslnF
 2f4agOIEPfiDk4f9/5qXa/3f0rmuIwp4=
X-Received: by 2002:a05:6512:2c95:b0:50a:a872:3b1c with SMTP id
 dw21-20020a0565122c9500b0050aa8723b1cmr3401033lfb.27.1700932555311; 
 Sat, 25 Nov 2023 09:15:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEifhgUHJG3gMpE7OZGBOeDjZwxunWuVypg75PUEhk8dQ807onO/7CJkTtsxPLw+S9B7k2iEb8LdiSK0tOO2xY=
X-Received: by 2002:a05:6512:2c95:b0:50a:a872:3b1c with SMTP id
 dw21-20020a0565122c9500b0050aa8723b1cmr3401028lfb.27.1700932554921; Sat, 25
 Nov 2023 09:15:54 -0800 (PST)
MIME-Version: 1.0
References: <20231102141010.300310-1-marcandre.lureau@redhat.com>
In-Reply-To: <20231102141010.300310-1-marcandre.lureau@redhat.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Sat, 25 Nov 2023 19:15:43 +0200
Message-ID: <CAPMcbCoaRdeUvrZosMbdVjsCM+LJQYMGcwdfWY0MwEfJotxe5g@mail.gmail.com>
Subject: Re: [PATCH] build-sys: fix meson project version usage
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, 
 Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="000000000000b93021060afd3867"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--000000000000b93021060afd3867
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>

On Thu, Nov 2, 2023 at 4:10=E2=80=AFPM <marcandre.lureau@redhat.com> wrote:

> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Program wixl found: YES (/usr/bin/wixl)
>
> ../qga/meson.build:149:16: ERROR: Unknown variable "project".
>
> Fixes: e20d68aa0b9 ("configure, meson: use command line options to
> configure qemu-ga")
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qga/meson.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/qga/meson.build b/qga/meson.build
> index 940a51d55d..ff7a8496e4 100644
> --- a/qga/meson.build
> +++ b/qga/meson.build
> @@ -146,7 +146,7 @@ if targetos =3D=3D 'windows'
>        libpcre =3D 'libpcre2'
>      endif
>      qga_msi_version =3D get_option('qemu_ga_version') =3D=3D '' \
> -      ? project.version() \
> +      ? meson.project_version() \
>        : get_option('qemu_ga_version')
>      qga_msi =3D custom_target('QGA MSI',
>                              input: files('installer/qemu-ga.wxs'),
> --
> 2.41.0
>
>

--000000000000b93021060afd3867
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Konstantin Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;</div><br><di=
v class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Nov 2=
, 2023 at 4:10=E2=80=AFPM &lt;<a href=3D"mailto:marcandre.lureau@redhat.com=
">marcandre.lureau@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">From: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"ma=
ilto:marcandre.lureau@redhat.com" target=3D"_blank">marcandre.lureau@redhat=
.com</a>&gt;<br>
<br>
Program wixl found: YES (/usr/bin/wixl)<br>
<br>
../qga/meson.build:149:16: ERROR: Unknown variable &quot;project&quot;.<br>
<br>
Fixes: e20d68aa0b9 (&quot;configure, meson: use command line options to con=
figure qemu-ga&quot;)<br>
Signed-off-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lurea=
u@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
---<br>
=C2=A0qga/meson.build | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/qga/meson.build b/qga/meson.build<br>
index 940a51d55d..ff7a8496e4 100644<br>
--- a/qga/meson.build<br>
+++ b/qga/meson.build<br>
@@ -146,7 +146,7 @@ if targetos =3D=3D &#39;windows&#39;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0libpcre =3D &#39;libpcre2&#39;<br>
=C2=A0 =C2=A0 =C2=A0endif<br>
=C2=A0 =C2=A0 =C2=A0qga_msi_version =3D get_option(&#39;qemu_ga_version&#39=
;) =3D=3D &#39;&#39; \<br>
-=C2=A0 =C2=A0 =C2=A0 ? project.version() \<br>
+=C2=A0 =C2=A0 =C2=A0 ? meson.project_version() \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0: get_option(&#39;qemu_ga_version&#39;)<br>
=C2=A0 =C2=A0 =C2=A0qga_msi =3D custom_target(&#39;QGA MSI&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0input: files(&#39;installer/qemu-ga.wxs&#39;=
),<br>
-- <br>
2.41.0<br>
<br>
</blockquote></div>

--000000000000b93021060afd3867--


