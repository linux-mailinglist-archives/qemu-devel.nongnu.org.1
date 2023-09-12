Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CABE479C7C2
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 09:11:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfxXb-0001Uf-3K; Tue, 12 Sep 2023 03:10:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1qfxXZ-0001UT-Io
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 03:10:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1qfxXX-0005Ml-3W
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 03:10:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694502626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NqqCJj2VSGfPsUqMn8P5KU6lBaZHi8AIVUibCxAYEg0=;
 b=XYiQN18KR8U8Hitp/PQ1u0nZDhTAaLv4Bu1HctbMR8DWXqK/szw8wSl47HFY/XkQgFaOO5
 O/Zhv6sOzG5pFqT/4oO7buHUVXMVuG95o9sv7CJasFi3UFOI3T0ZYkvSiXald3toL6legf
 q5v47vh80a7RVbruqZXv3Sb3ZBOzJ1U=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-RlrZZy8IO6qffs5Lkckjyw-1; Tue, 12 Sep 2023 03:10:24 -0400
X-MC-Unique: RlrZZy8IO6qffs5Lkckjyw-1
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-68fbd5cd02bso2522230b3a.2
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 00:10:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694502623; x=1695107423;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NqqCJj2VSGfPsUqMn8P5KU6lBaZHi8AIVUibCxAYEg0=;
 b=rC4caVZDYi+A3AWuMuymkQm3zWkrwS7gvMKVNTgKb8Ac8DUUsXuFA5S848ekHMbRd9
 YeLQNuTjpFcTG1AbX+XnZwMa6mbA1K86dhB6Y/EbspPPVhr2qsxRapOor+AeRn3hRZhg
 2vcYzch1QJKldslO3Tzxjp504+aNhSrTiqSeDuyNFv6o8DS3gosmPyGeaF0iB2p63eRF
 dtSPW82uLP8/VjWAKI6gUYozxBMCmBidTS1WiZ0qkZYq6XbKtcuqca6T2ElqZ6Nh86WL
 9w6jCqykiYCmvrkPW2bTp+D4p9hEloT6bmxTSc3Ds4gIkRiNfXaGCkIiLldpFuhUEexe
 lASA==
X-Gm-Message-State: AOJu0YytTAyqWwIsZmetK4BF9Yqt5wOmXRcaLsuVNP3fD/+LEDBn9pOx
 mn29ARAZDr+cQ9zbGXx35aA6jYZ3jTckzm/+seQCgNSIX7BGT9HwMtROBNrzxGCE3si4E3Mvyn4
 rh4dhm9yekgJx8kslI5TIUJSzYLfrnDCWaSJHyxNBQg==
X-Received: by 2002:a05:6a20:3ca1:b0:122:10f9:f635 with SMTP id
 b33-20020a056a203ca100b0012210f9f635mr12501044pzj.19.1694502622955; 
 Tue, 12 Sep 2023 00:10:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHN4XSMwXSp7NWRuxWDLbwYN8IZYqXX5+uxq4eJJgUNTlXVs+0diyhVWzsTKLeRwJpOBAk4yIb0rub/9PxlXtI=
X-Received: by 2002:a05:6a20:3ca1:b0:122:10f9:f635 with SMTP id
 b33-20020a056a203ca100b0012210f9f635mr12501032pzj.19.1694502622701; Tue, 12
 Sep 2023 00:10:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230912062836.1530898-1-marcandre.lureau@redhat.com>
 <20230912062836.1530898-2-marcandre.lureau@redhat.com>
In-Reply-To: <20230912062836.1530898-2-marcandre.lureau@redhat.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Tue, 12 Sep 2023 09:10:11 +0200
Message-ID: <CADSE00JeX5ozMOovgOO3vbucGfjXNJhEnoS4Si-sJB-eKTsqow@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ui: add precondition for dpy_get_ui_info()
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000e5f5450605242214"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
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

--000000000000e5f5450605242214
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 12, 2023 at 8:28=E2=80=AFAM <marcandre.lureau@redhat.com> wrote=
:

> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Ensure that it only get called when dpy_ui_info_supported(). The
> function should always return a result. There should be a non-null
> console or active_console.
>
> Modify the argument to be const as well.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/ui/console.h | 2 +-
>  ui/console.c         | 4 +++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/include/ui/console.h b/include/ui/console.h
> index 031e5d5194..08c0f0dc70 100644
> --- a/include/ui/console.h
> +++ b/include/ui/console.h
> @@ -329,7 +329,7 @@ void
> update_displaychangelistener(DisplayChangeListener *dcl,
>                                    uint64_t interval);
>  void unregister_displaychangelistener(DisplayChangeListener *dcl);
>
> -bool dpy_ui_info_supported(QemuConsole *con);
> +bool dpy_ui_info_supported(const QemuConsole *con);
>  const QemuUIInfo *dpy_get_ui_info(const QemuConsole *con);
>  int dpy_set_ui_info(QemuConsole *con, QemuUIInfo *info, bool delay);
>
> diff --git a/ui/console.c b/ui/console.c
> index 0fbec4d0bd..1c710a6d5e 100644
> --- a/ui/console.c
> +++ b/ui/console.c
> @@ -803,7 +803,7 @@ static void dpy_set_ui_info_timer(void *opaque)
>      con->hw_ops->ui_info(con->hw, head, &con->ui_info);
>  }
>
> -bool dpy_ui_info_supported(QemuConsole *con)
> +bool dpy_ui_info_supported(const QemuConsole *con)
>  {
>      if (con =3D=3D NULL) {
>          con =3D active_console;
> @@ -817,6 +817,8 @@ bool dpy_ui_info_supported(QemuConsole *con)
>
>  const QemuUIInfo *dpy_get_ui_info(const QemuConsole *con)
>  {
> +    assert(dpy_ui_info_supported(con));
> +
>

I wonder if it would be better to avoid the assertion and return NULL
if not supported, and let the caller handle (logging an error for example).

But there are many other similar assertions in this file, so it is probably
good as it is...

Reviewed-by: Albert Esteve <aesteve@redhat.com>


>      if (con =3D=3D NULL) {
>          con =3D active_console;
>      }
> --
> 2.41.0
>
>

--000000000000e5f5450605242214
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br clear=3D"all"><div><div dir=3D"ltr" c=
lass=3D"gmail_signature"><div dir=3D"ltr"><p style=3D"color:rgb(0,0,0);font=
-family:RedHatText,sans-serif;font-weight:bold;margin:0px;padding:0px;font-=
size:14px"><br></p></div></div></div></div><br><div class=3D"gmail_quote"><=
div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 12, 2023 at 8:28=E2=80=AFA=
M &lt;<a href=3D"mailto:marcandre.lureau@redhat.com">marcandre.lureau@redha=
t.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">From: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@re=
dhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
<br>
Ensure that it only get called when dpy_ui_info_supported(). The<br>
function should always return a result. There should be a non-null<br>
console or active_console.<br>
<br>
Modify the argument to be const as well.<br>
<br>
Signed-off-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lurea=
u@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
---<br>
=C2=A0include/ui/console.h | 2 +-<br>
=C2=A0ui/console.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 4 +++-<br>
=C2=A02 files changed, 4 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/include/ui/console.h b/include/ui/console.h<br>
index 031e5d5194..08c0f0dc70 100644<br>
--- a/include/ui/console.h<br>
+++ b/include/ui/console.h<br>
@@ -329,7 +329,7 @@ void update_displaychangelistener(DisplayChangeListener=
 *dcl,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t interval);<br>
=C2=A0void unregister_displaychangelistener(DisplayChangeListener *dcl);<br=
>
<br>
-bool dpy_ui_info_supported(QemuConsole *con);<br>
+bool dpy_ui_info_supported(const QemuConsole *con);<br>
=C2=A0const QemuUIInfo *dpy_get_ui_info(const QemuConsole *con);<br>
=C2=A0int dpy_set_ui_info(QemuConsole *con, QemuUIInfo *info, bool delay);<=
br>
<br>
diff --git a/ui/console.c b/ui/console.c<br>
index 0fbec4d0bd..1c710a6d5e 100644<br>
--- a/ui/console.c<br>
+++ b/ui/console.c<br>
@@ -803,7 +803,7 @@ static void dpy_set_ui_info_timer(void *opaque)<br>
=C2=A0 =C2=A0 =C2=A0con-&gt;hw_ops-&gt;ui_info(con-&gt;hw, head, &amp;con-&=
gt;ui_info);<br>
=C2=A0}<br>
<br>
-bool dpy_ui_info_supported(QemuConsole *con)<br>
+bool dpy_ui_info_supported(const QemuConsole *con)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0if (con =3D=3D NULL) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0con =3D active_console;<br>
@@ -817,6 +817,8 @@ bool dpy_ui_info_supported(QemuConsole *con)<br>
<br>
=C2=A0const QemuUIInfo *dpy_get_ui_info(const QemuConsole *con)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 assert(dpy_ui_info_supported(con));<br>
+<br></blockquote><div><br></div><div>I wonder if it would be better to avo=
id the assertion and return NULL</div><div>if not supported, and let the ca=
ller handle (logging an error for example).</div><div><br></div><div>But th=
ere are many other similar assertions in this file, so it is probably good =
as it is...</div><div><br></div><div>Reviewed-by: Albert Esteve &lt;<a href=
=3D"mailto:aesteve@redhat.com" target=3D"_blank">aesteve@redhat.com</a>&gt;=
<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">
=C2=A0 =C2=A0 =C2=A0if (con =3D=3D NULL) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0con =3D active_console;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-- <br>
2.41.0<br>
<br>
</blockquote></div></div>

--000000000000e5f5450605242214--


