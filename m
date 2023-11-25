Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5B97F8CDC
	for <lists+qemu-devel@lfdr.de>; Sat, 25 Nov 2023 18:38:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6wb7-0003i9-R9; Sat, 25 Nov 2023 12:37:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1r6wb5-0003hp-6c
 for qemu-devel@nongnu.org; Sat, 25 Nov 2023 12:37:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1r6wb3-00067o-Gs
 for qemu-devel@nongnu.org; Sat, 25 Nov 2023 12:37:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700933856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FMAIiQka9/yPO/G5vrQvPVXbWGNavDOVoTp9qUVBmdU=;
 b=WDCDLWR49Cq24upKMEY2NIgSw01Cfrok3leEQFA1vngzEF2gC9UCmCuG+VmwPof14zW4FF
 IiKMvAXromveL8VT8R6YPJZujmo+LDqErMLFuK1NvZN2Kq4kXGfpvd7LuIHOij+yBf/Jcu
 z/Z74WZQOJS4kbx1BEm4jNJNqPESKLQ=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-294-emL5yZt9NFCZGMx6XtjdYw-1; Sat, 25 Nov 2023 12:37:34 -0500
X-MC-Unique: emL5yZt9NFCZGMx6XtjdYw-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-50aa7e5bd0aso2946041e87.0
 for <qemu-devel@nongnu.org>; Sat, 25 Nov 2023 09:37:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700933853; x=1701538653;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FMAIiQka9/yPO/G5vrQvPVXbWGNavDOVoTp9qUVBmdU=;
 b=e0PTT9SegAOiNeXn6Txm1NVAbPV3lkxD+18n7nxcL6+euPt0eEj8V8C8iGZzF9J0qT
 UX1eAj2Aky30TlYVKQeMzeDeEP2kF9uXld+8a9/ntAB4+ZtqSIPqFkdLgY9k2fpbzyjU
 YFc5d52aDNHHOmZtHtplcLFzvbPwUL3LxJtfhRzJgPBNgJmgtRQZ54GhvkErYO73GpnH
 BFyyBqPZNb3TPhsXBjHk2spcTtdHcFf5sy2PoGYirMrF0Eh8S/R8ctrzCfjflUJx+kB1
 VX6ndYcMdFZEEat44cuGu4dYZrHfrkIhYAeM3y7Pm1cvscc4V/NNWch+eg8ckB5f1ZrA
 zeAg==
X-Gm-Message-State: AOJu0Yzc63vGq8qiPyT6wrDJkLdLUbRoayLvSoJkj/YM0IGnGzKhpZOc
 0VBKPutzuAZeVYtmdx9xxYHc5iKHC+U0OVNj5rLUnz+T7TMQw2PvK9mZSkbvVmbiiST0QMX7UFI
 y+f9+XNf8UvkPq9R4p2XcTTa4yVBLhDs=
X-Received: by 2002:a05:6512:696:b0:50a:ba8a:ec12 with SMTP id
 t22-20020a056512069600b0050aba8aec12mr5826053lfe.49.1700933852931; 
 Sat, 25 Nov 2023 09:37:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHLPDbf29ynI/3STJczYCOblpMG3uyFHt6clYXhr7hPGWFJfbDBSS05fTs1CTBjrow0SsZpMl3BnmBFBpO4QDE=
X-Received: by 2002:a05:6512:696:b0:50a:ba8a:ec12 with SMTP id
 t22-20020a056512069600b0050aba8aec12mr5826041lfe.49.1700933852535; Sat, 25
 Nov 2023 09:37:32 -0800 (PST)
MIME-Version: 1.0
References: <20231125152740.584224-1-sw@weilnetz.de>
In-Reply-To: <20231125152740.584224-1-sw@weilnetz.de>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Sat, 25 Nov 2023 19:37:21 +0200
Message-ID: <CAPMcbCr+B0uLvGrpVub6Sp4=RJdy-MXGbspKHg_VU2ostKobQQ@mail.gmail.com>
Subject: Re: [PATCH for-8.2] Fix broken build for QEMU guest agent
To: Stefan Weil <sw@weilnetz.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <michael.roth@amd.com>,
 qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000001130e5060afd8616"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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

--0000000000001130e5060afd8616
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stefan,

Thanks for your patch.
PULL was sent with Marc-Andr=C3=A9 patch
https://patchew.org/QEMU/20231125173011.374840-1-kkostiuk@redhat.com/

Best Regards,
Konstantin Kostiuk.


On Sat, Nov 25, 2023 at 5:29=E2=80=AFPM Stefan Weil via <qemu-devel@nongnu.=
org>
wrote:

> Meson setup failed:
>
>     qga/meson.build:148:4: ERROR: Unknown variable "project".
>
> Fixes commit e20d68aa ("configure, meson: use command line options [...]"=
).
>
> Signed-off-by: Stefan Weil <sw@weilnetz.de>
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
> 2.39.2
>
>
>

--0000000000001130e5060afd8616
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Stefan,</div><div><br></div><div>Thanks for your p=
atch.</div><div>PULL was sent with Marc-Andr=C3=A9 patch <a href=3D"https:/=
/patchew.org/QEMU/20231125173011.374840-1-kkostiuk@redhat.com/">https://pat=
chew.org/QEMU/20231125173011.374840-1-kkostiuk@redhat.com/</a></div><div><b=
r></div><div><div><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=
=3D"gmail_signature"><div dir=3D"ltr"><div>Best Regards,</div><div>Konstant=
in Kostiuk.</div></div></div></div><br></div></div><br><div class=3D"gmail_=
quote"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, Nov 25, 2023 at 5:29=
=E2=80=AFPM Stefan Weil via &lt;<a href=3D"mailto:qemu-devel@nongnu.org">qe=
mu-devel@nongnu.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">Meson setup failed:<br>
<br>
=C2=A0 =C2=A0 qga/meson.build:148:4: ERROR: Unknown variable &quot;project&=
quot;.<br>
<br>
Fixes commit e20d68aa (&quot;configure, meson: use command line options [..=
.]&quot;).<br>
<br>
Signed-off-by: Stefan Weil &lt;<a href=3D"mailto:sw@weilnetz.de" target=3D"=
_blank">sw@weilnetz.de</a>&gt;<br>
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
2.39.2<br>
<br>
<br>
</blockquote></div>

--0000000000001130e5060afd8616--


