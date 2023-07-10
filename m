Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 136CB74D181
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 11:32:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qInFs-0000IV-QZ; Mon, 10 Jul 2023 05:32:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qInFp-0000Be-BF
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 05:32:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qInFn-0006vt-P2
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 05:32:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688981543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8svLrQ0A8+NCtzZRk3+ecgzQXbQ5+iNhU/EnQVbRezw=;
 b=eAPGgolL1ag34RUMqnKCWE7eSfN+MsDOHf1ib+8AvP5sEb1MYYPkNxryXDDdvWcd8LFFag
 lTxYNS9LY7x3e8tqyU5cEAb2hncRQNhL0XMg3/zQW56k4XNcJbtAH3lbNJavv5ZlzXclLe
 7FDBex9yDQQHf3p8/QOUCOsW9qqvEJM=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-ABbA_-HKOdexwaIovafIUg-1; Mon, 10 Jul 2023 05:32:21 -0400
X-MC-Unique: ABbA_-HKOdexwaIovafIUg-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2b710c5677eso21200971fa.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 02:32:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688981540; x=1691573540;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8svLrQ0A8+NCtzZRk3+ecgzQXbQ5+iNhU/EnQVbRezw=;
 b=itkG8+uESsWQ+bhBxdv1N6L+o3ladMQA8NCyCYHzDQ70nOX5wrM6OMWRZ0LQeLgBQE
 ER2T4+P7LvdxGncwAc3d3S7X+7rZz/chpJuMm6Bjq14uKPZ4qFmVK5zghHQ37ksCVSP0
 A4vhA4BodgokUXWfoMLp6EV0yf8bYzlVZw5kMoClr7Zs33o+UlkRgyj2axmau9XEHNoj
 xd4/cbpQ0y4vo7EX6ShlulEdi4HkuUiu5Zf8GqpHPwdgClOknJYh3U7zbUcWWRl4Imjw
 I9YVcC0uop+8qJXeISXOo1TdhZCIuUf2XbBcxFCxvHgPMHf1XCcvBy6G/gCQubBoPwpH
 Kmjw==
X-Gm-Message-State: ABy/qLYyx9HJl5zYpoA8cuq9JBcJXi/SkzPVV+ZNA3VMHgZG5T6rKYER
 DMH8X2kjLxCBNgiGR7rDoY25UbKh1MOQ6kbj+ZYPp0YW6h3KaDkABVTsB9s6gJmZZAlFrK7hHz9
 xwiL63b55FI+hTVr3Z4nynIdElLBea4A=
X-Received: by 2002:a2e:880a:0:b0:2b6:cc93:4ecb with SMTP id
 x10-20020a2e880a000000b002b6cc934ecbmr10581060ljh.43.1688981540147; 
 Mon, 10 Jul 2023 02:32:20 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGiXwWwp9MdKgBhrZ54b2DJoRx4R6qen8imCNbXCgRR6oM/Xn0Jng89jCJuCAXjX2ygRsai/lbcfqNqp+P0E9I=
X-Received: by 2002:a2e:880a:0:b0:2b6:cc93:4ecb with SMTP id
 x10-20020a2e880a000000b002b6cc934ecbmr10581036ljh.43.1688981539847; Mon, 10
 Jul 2023 02:32:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230710092638.161625-1-thuth@redhat.com>
In-Reply-To: <20230710092638.161625-1-thuth@redhat.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Mon, 10 Jul 2023 12:32:08 +0300
Message-ID: <CAPMcbCrOSA=2G1rrALeoM=S=VwkGE0qOAui4n3XnTi3VjjtbPw@mail.gmail.com>
Subject: Re: [PATCH] docs/devel: Fix coding style in style.rst
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-trivial@nongnu.org, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Juan Quintela <quintela@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000b710fc06001ea8de"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

--000000000000b710fc06001ea8de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>

On Mon, Jul 10, 2023 at 12:26=E2=80=AFPM Thomas Huth <thuth@redhat.com> wro=
te:

> As defined earlier in this file, the opening curly brace of
> functions should be placed on a separate line. So we should
> do it in the examples here, too.
>
> Reported-by: Konstantin Kostiuk <kkostiuk@redhat.com>
> Fixes: 821f296756 ("docs: document use of automatic cleanup functions in
> glib")
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  docs/devel/style.rst | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/docs/devel/style.rst b/docs/devel/style.rst
> index aa5e083ff8..3cfcdeb9cd 100644
> --- a/docs/devel/style.rst
> +++ b/docs/devel/style.rst
> @@ -567,7 +567,8 @@ For example, instead of
>
>  .. code-block:: c
>
> -    int somefunc(void) {
> +    int somefunc(void)
> +    {
>          int ret =3D -1;
>          char *foo =3D g_strdup_printf("foo%", "wibble");
>          GList *bar =3D .....
> @@ -588,7 +589,8 @@ Using g_autofree/g_autoptr enables the code to be
> written as:
>
>  .. code-block:: c
>
> -    int somefunc(void) {
> +    int somefunc(void)
> +    {
>          g_autofree char *foo =3D g_strdup_printf("foo%", "wibble");
>          g_autoptr (GList) bar =3D .....
>
> @@ -613,7 +615,8 @@ are still some caveats to beware of
>
>  .. code-block:: c
>
> -    char *somefunc(void) {
> +    char *somefunc(void)
> +    {
>          g_autofree char *foo =3D g_strdup_printf("foo%", "wibble");
>          g_autoptr (GList) bar =3D .....
>
> --
> 2.39.3
>
>

--000000000000b710fc06001ea8de
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Reviewed-by: Konstantin Kostiuk &lt;<a hr=
ef=3D"mailto:kkostiuk@redhat.com" target=3D"_blank">kkostiuk@redhat.com</a>=
&gt;</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_at=
tr">On Mon, Jul 10, 2023 at 12:26=E2=80=AFPM Thomas Huth &lt;<a href=3D"mai=
lto:thuth@redhat.com">thuth@redhat.com</a>&gt; wrote:<br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">As defined earlier in this file, the =
opening curly brace of<br>
functions should be placed on a separate line. So we should<br>
do it in the examples here, too.<br>
<br>
Reported-by: Konstantin Kostiuk &lt;<a href=3D"mailto:kkostiuk@redhat.com" =
target=3D"_blank">kkostiuk@redhat.com</a>&gt;<br>
Fixes: 821f296756 (&quot;docs: document use of automatic cleanup functions =
in glib&quot;)<br>
Signed-off-by: Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com" target=
=3D"_blank">thuth@redhat.com</a>&gt;<br>
---<br>
=C2=A0docs/devel/style.rst | 9 ++++++---<br>
=C2=A01 file changed, 6 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/docs/devel/style.rst b/docs/devel/style.rst<br>
index aa5e083ff8..3cfcdeb9cd 100644<br>
--- a/docs/devel/style.rst<br>
+++ b/docs/devel/style.rst<br>
@@ -567,7 +567,8 @@ For example, instead of<br>
<br>
=C2=A0.. code-block:: c<br>
<br>
-=C2=A0 =C2=A0 int somefunc(void) {<br>
+=C2=A0 =C2=A0 int somefunc(void)<br>
+=C2=A0 =C2=A0 {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int ret =3D -1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char *foo =3D g_strdup_printf(&quot;foo%&=
quot;, &quot;wibble&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0GList *bar =3D .....<br>
@@ -588,7 +589,8 @@ Using g_autofree/g_autoptr enables the code to be writt=
en as:<br>
<br>
=C2=A0.. code-block:: c<br>
<br>
-=C2=A0 =C2=A0 int somefunc(void) {<br>
+=C2=A0 =C2=A0 int somefunc(void)<br>
+=C2=A0 =C2=A0 {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_autofree char *foo =3D g_strdup_printf(=
&quot;foo%&quot;, &quot;wibble&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_autoptr (GList) bar =3D .....<br>
<br>
@@ -613,7 +615,8 @@ are still some caveats to beware of<br>
<br>
=C2=A0.. code-block:: c<br>
<br>
-=C2=A0 =C2=A0 char *somefunc(void) {<br>
+=C2=A0 =C2=A0 char *somefunc(void)<br>
+=C2=A0 =C2=A0 {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_autofree char *foo =3D g_strdup_printf(=
&quot;foo%&quot;, &quot;wibble&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_autoptr (GList) bar =3D .....<br>
<br>
-- <br>
2.39.3<br>
<br>
</blockquote></div></div>

--000000000000b710fc06001ea8de--


