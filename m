Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 719C870BFEF
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 15:43:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q15pG-00014Z-0t; Mon, 22 May 2023 09:43:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1q15pE-00013R-C2
 for qemu-devel@nongnu.org; Mon, 22 May 2023 09:43:48 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1q15pC-0004qW-JS
 for qemu-devel@nongnu.org; Mon, 22 May 2023 09:43:47 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-4f4b0a0b557so1153953e87.1
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 06:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684763025; x=1687355025;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AMJrcUJMkw8KDp6xy8ASI2acejc2LRR4LMxlSmlRfDA=;
 b=Locy8bxXTG+4baUnoTQqwZwXsDusglW8KVHLWzheGKmWffhn7fLv8mAHt9xbvtzzEU
 yLlZlR9CoyBrjA/EHm9z7pOBDthC72umwghwQiP7C28fNFhuLdq3+TgNDrTolHMhH8tc
 7YZpwaVgkanG0fmp3Ih7SjlfyfIHHfRu/D2IdQK5/O4IPuw9TJUx7TDlurrmX5EzZHjl
 sZc2W7wUc1bD30EFjrfPO0E2ArOUmCrKySBXY7pqRXM+BGt3aCenTeVATkbJzfKzchL3
 53GXO7qh1rDY0tK0W7qHG62TBcpgF3SLduLKbfiOMKNlP295LxCLg/EfyGhTFqJBxO8u
 oJ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684763025; x=1687355025;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AMJrcUJMkw8KDp6xy8ASI2acejc2LRR4LMxlSmlRfDA=;
 b=NVHjgwDLM//miR6bw/bVvUUNIYJ8qF+GtlZ/fluKI8ilRg+nfUy6GRgrfkt8jcWIb8
 StTht9mdc58iHZbeQYckl2QiMrZV7vpPiUA9tf6D8zi4E5m2QjF/cfWyQhXnznOhe1WN
 /ocqDHpKa4ycDbivsRiOCf39ODkuUyZCxEEteXrrlOePGGSjcysed+mbWnwwCkpbsUT5
 mt0Y4FgGtuQbTfR0nnZfV0HnepYot2EaxFImxCcn0PZ9aPwVea7TYrzUuGbYu1OTUIIQ
 rJGyXVqQUL8qdqwBmtgR3XhHNBy8AV4kMwvg58qgQSS2zh3l9/Q87GyP14dnkSx6Zu5v
 sPRQ==
X-Gm-Message-State: AC+VfDx5zC97+UEtuuo4K2xH+Bi1kckWWXceTW7tk/ki6jgQxeZ3O/eO
 cVn87V6nBAfdyTfYdLsYmi2GLCKeWxR0alLudwJQgwRRK2IQpQ==
X-Google-Smtp-Source: ACHHUZ6+WNvzcbu6207hdtvlc20/D3LvtPvhE+SWjPQ7f3b9sFO4ToCbcy9WeHgiPMBRrEFImjag4gyKUpEM5fLPn24=
X-Received: by 2002:ac2:539a:0:b0:4e8:43e2:a8 with SMTP id
 g26-20020ac2539a000000b004e843e200a8mr3882317lfh.8.1684763024539; 
 Mon, 22 May 2023 06:43:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230522071906.59766-1-pbonzini@redhat.com>
In-Reply-To: <20230522071906.59766-1-pbonzini@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 22 May 2023 17:43:33 +0400
Message-ID: <CAJ+F1CKGd2y2jbPX50YxnYURXX0jQ37D59XvPW2DEmU--kk5Mg@mail.gmail.com>
Subject: Re: [PATCH] meson: fix rule for qemu-ga installer
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000009bc46105fc487572"
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-lf1-x134.google.com
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

--0000000000009bc46105fc487572
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 22, 2023 at 11:20=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com=
> wrote:

> The bindir variable is not available in the "glib" variable, which is an
> internal
> dependency (created with "declare_dependency").  Use glib_pc instead,
> which contains
> the variable as it is instantiated from glib-2.0.pc.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  qga/meson.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/qga/meson.build b/qga/meson.build
> index 622b5f94a232..d3291b4376cb 100644
> --- a/qga/meson.build
> +++ b/qga/meson.build
> @@ -154,7 +154,7 @@ if targetos =3D=3D 'windows'
>                                qemu_ga_msi_arch[cpu],
>                                qemu_ga_msi_vss,
>                                '-D', 'BUILD_DIR=3D' +
> meson.project_build_root(),
> -                              '-D', 'BIN_DIR=3D' +
> glib.get_variable('bindir'),
> +                              '-D', 'BIN_DIR=3D' +
> glib_pc.get_variable('bindir'),
>                                '-D', 'QEMU_GA_VERSION=3D' +
> config_host['QEMU_GA_VERSION'],
>                                '-D', 'QEMU_GA_MANUFACTURER=3D' +
> config_host['QEMU_GA_MANUFACTURER'],
>                                '-D', 'QEMU_GA_DISTRO=3D' +
> config_host['QEMU_GA_DISTRO'],
> --
> 2.40.1
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--0000000000009bc46105fc487572
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, May 22, 2023 at 11:20=E2=80=
=AFAM Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com">pbonzini@red=
hat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">The bindir variable is not available in the &quot;glib&quot; variabl=
e, which is an internal<br>
dependency (created with &quot;declare_dependency&quot;).=C2=A0 Use glib_pc=
 instead, which contains<br>
the variable as it is instantiated from glib-2.0.pc.<br>
<br>
Signed-off-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" tar=
get=3D"_blank">pbonzini@redhat.com</a>&gt;<br></blockquote><div><br></div><=
div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lur=
eau@redhat.com">marcandre.lureau@redhat.com</a>&gt; <br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0qga/meson.build | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/qga/meson.build b/qga/meson.build<br>
index 622b5f94a232..d3291b4376cb 100644<br>
--- a/qga/meson.build<br>
+++ b/qga/meson.build<br>
@@ -154,7 +154,7 @@ if targetos =3D=3D &#39;windows&#39;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_ga_msi_arch[cpu],<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_ga_msi_vss,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;-D&#39;, &#39;BUILD_DIR=3D&#39; =
+ meson.project_build_root(),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;-D&#39;, &#39;BIN_DIR=3D&#39; + glib.g=
et_variable(&#39;bindir&#39;),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;-D&#39;, &#39;BIN_DIR=3D&#39; + glib_p=
c.get_variable(&#39;bindir&#39;),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;-D&#39;, &#39;QEMU_GA_VERSION=3D=
&#39; + config_host[&#39;QEMU_GA_VERSION&#39;],<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;-D&#39;, &#39;QEMU_GA_MANUFACTUR=
ER=3D&#39; + config_host[&#39;QEMU_GA_MANUFACTURER&#39;],<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;-D&#39;, &#39;QEMU_GA_DISTRO=3D&=
#39; + config_host[&#39;QEMU_GA_DISTRO&#39;],<br>
-- <br>
2.40.1<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--0000000000009bc46105fc487572--

