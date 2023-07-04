Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C118746CAC
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 11:03:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGbwU-0007a3-Ku; Tue, 04 Jul 2023 05:03:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qGbwG-0007Xq-JE
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 05:03:13 -0400
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qGbwE-0007Ie-Ud
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 05:03:12 -0400
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-403715da067so2603911cf.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 02:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688461389; x=1691053389;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+kmC4tcCT0hmoEEuAY95B7MFc2NoC+YnNgzqC9Lo+xs=;
 b=INNQ/Ys3OmradcHaOEGc2ZZDRmUg0oJ+aiYFZDTINPYNtcBhZi5SMQVNNt1aVZabXo
 r1Dr3d+6NjiDqALm5myomkDgurZVtIzGSJAy9oVf9snwZLIsQj6yS5R9Cc2bnsw0hfcD
 W1UjKjpSKM7Ev1vgwZTkiEtQTCiIyaf8kH2z5zO6xjyBGrH7r7ri727d1goprnlqtTHq
 cs1h3l2gGpwWsfHcKrOnabDaICknCxyPqbt4s3bmc98LgpoFhabQy1/OJ6GJt857zIJY
 xQgPmNfTulALA4MtkSYdxVGTtCWfCsYOLKmz4zJ9uVgxC4QUyTP6AVgAiq0fhoYMLfzY
 8eOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688461389; x=1691053389;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+kmC4tcCT0hmoEEuAY95B7MFc2NoC+YnNgzqC9Lo+xs=;
 b=ctS/gEQz8GSZ94VYa5btMUohsDB8LoVNI/jQDN6HJX6t9Y3XffLHNgxewodxVnszYe
 ds2y0RRSaJLYos2NmRLaMbP9kP/4bbfItxh7K5hxHW5MeA0ipI0Yooc+1Vn0R9dhHe85
 DVIgRnRoplI7R2fPmD1D32YrGPR6YOTXQsdkEiYXA57ZEuxxKbqWwiC7JsMU32BRefYj
 lZ6g9hBtnchw8iXikoPw0xqfsCmc7hqB/3aMNvwEnaT1G9tkdU7sT3bKp8ZXz2HUEJG5
 SDni+s2gmVAVLtIng7v1Hdcw61YnzhaBuSbJg9vPfCbL/e3JkFPkbUFvn5OsLmTMw6Lx
 v3fQ==
X-Gm-Message-State: AC+VfDyq3cj9qnx5LAPGNkm69w/0fVMmdjUrf2G8yFuXnJifQ46Vf0Y/
 v0TPwcxXUfhiffjZAILOM4H/Wq/klvdVa8Al8e0=
X-Google-Smtp-Source: ACHHUZ7CVKl06B5LQJ6bsXW/bjUi3JFirWoXqSP5w+YFDp2UQKJiv/h4WbDoE5YiR5xGvyU6e5ifGy545ZdssT7IHvA=
X-Received: by 2002:ac8:4e55:0:b0:3f3:91bd:a459 with SMTP id
 e21-20020ac84e55000000b003f391bda459mr15793170qtw.34.1688461389497; Tue, 04
 Jul 2023 02:03:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230704084210.101822-1-mcascell@redhat.com>
In-Reply-To: <20230704084210.101822-1-mcascell@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 4 Jul 2023 11:02:58 +0200
Message-ID: <CAJ+F1CLi54BFaeYjZ_eHq+nixPkAcFOGquLx0kRc_YeUeLZVKA@mail.gmail.com>
Subject: Re: [PATCH] ui/vnc-clipboard: fix infinite loop in inflate_buffer
 (CVE-2023-3255)
To: Mauro Matteo Cascella <mcascell@redhat.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, kevin.denis@synacktiv.com
Content-Type: multipart/alternative; boundary="0000000000005689ba05ffa58d2a"
Received-SPF: pass client-ip=2607:f8b0:4864:20::831;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x831.google.com
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

--0000000000005689ba05ffa58d2a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 4, 2023 at 10:42=E2=80=AFAM Mauro Matteo Cascella <mcascell@red=
hat.com>
wrote:

> A wrong exit condition may lead to an infinite loop when inflating a
> valid zlib buffer containing some extra bytes in the `inflate_buffer`
> function. The bug only occurs post-authentication. Return the buffer
> immediately if the end of the compressed data has been reached
> (Z_STREAM_END).
>
> Fixes: CVE-2023-3255
> Fixes: 0bf41cab ("ui/vnc: clipboard support")
> Reported-by: Kevin Denis <kevin.denis@synacktiv.com>
> Signed-off-by: Mauro Matteo Cascella <mcascell@redhat.com>
>

Tested-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Note: we may want to disconnect the client when there are extra bytes in
the message, or print some warnings.


> ---
>  ui/vnc-clipboard.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/ui/vnc-clipboard.c b/ui/vnc-clipboard.c
> index 8aeadfaa21..c759be3438 100644
> --- a/ui/vnc-clipboard.c
> +++ b/ui/vnc-clipboard.c
> @@ -50,8 +50,11 @@ static uint8_t *inflate_buffer(uint8_t *in, uint32_t
> in_len, uint32_t *size)
>          ret =3D inflate(&stream, Z_FINISH);
>          switch (ret) {
>          case Z_OK:
> -        case Z_STREAM_END:
>              break;
> +        case Z_STREAM_END:
> +            *size =3D stream.total_out;
> +            inflateEnd(&stream);
> +            return out;
>          case Z_BUF_ERROR:
>              out_len <<=3D 1;
>              if (out_len > (1 << 20)) {
> @@ -66,11 +69,6 @@ static uint8_t *inflate_buffer(uint8_t *in, uint32_t
> in_len, uint32_t *size)
>          }
>      }
>
> -    *size =3D stream.total_out;
> -    inflateEnd(&stream);
> -
> -    return out;
> -
>  err_end:
>      inflateEnd(&stream);
>  err:
> --
> 2.41.0
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--0000000000005689ba05ffa58d2a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jul 4, 2023 at 10:42=E2=80=AF=
AM Mauro Matteo Cascella &lt;<a href=3D"mailto:mcascell@redhat.com">mcascel=
l@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">A wrong exit condition may lead to an infinite loop when inflat=
ing a<br>
valid zlib buffer containing some extra bytes in the `inflate_buffer`<br>
function. The bug only occurs post-authentication. Return the buffer<br>
immediately if the end of the compressed data has been reached<br>
(Z_STREAM_END).<br>
<br>
Fixes: CVE-2023-3255<br>
Fixes: 0bf41cab (&quot;ui/vnc: clipboard support&quot;)<br>
Reported-by: Kevin Denis &lt;<a href=3D"mailto:kevin.denis@synacktiv.com" t=
arget=3D"_blank">kevin.denis@synacktiv.com</a>&gt;<br>
Signed-off-by: Mauro Matteo Cascella &lt;<a href=3D"mailto:mcascell@redhat.=
com" target=3D"_blank">mcascell@redhat.com</a>&gt;<br></blockquote><div><di=
v><br></div><div>Tested-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:ma=
rcandre.lureau@redhat.com">marcandre.lureau@redhat.com</a>&gt;</div></div><=
div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lur=
eau@redhat.com">marcandre.lureau@redhat.com</a>&gt;</div><div><br></div><di=
v>Note: we may want to disconnect the client when there are extra bytes in =
the message, or print some warnings.<br></div><div>=C2=A0<br></div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0ui/vnc-clipboard.c | 10 ++++------<br>
=C2=A01 file changed, 4 insertions(+), 6 deletions(-)<br>
<br>
diff --git a/ui/vnc-clipboard.c b/ui/vnc-clipboard.c<br>
index 8aeadfaa21..c759be3438 100644<br>
--- a/ui/vnc-clipboard.c<br>
+++ b/ui/vnc-clipboard.c<br>
@@ -50,8 +50,11 @@ static uint8_t *inflate_buffer(uint8_t *in, uint32_t in_=
len, uint32_t *size)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D inflate(&amp;stream, Z_FINISH);<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0switch (ret) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case Z_OK:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 case Z_STREAM_END:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case Z_STREAM_END:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *size =3D stream.total_out;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 inflateEnd(&amp;stream);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return out;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case Z_BUF_ERROR:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0out_len &lt;&lt;=3D 1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (out_len &gt; (1 &lt;&lt=
; 20)) {<br>
@@ -66,11 +69,6 @@ static uint8_t *inflate_buffer(uint8_t *in, uint32_t in_=
len, uint32_t *size)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 *size =3D stream.total_out;<br>
-=C2=A0 =C2=A0 inflateEnd(&amp;stream);<br>
-<br>
-=C2=A0 =C2=A0 return out;<br>
-<br>
=C2=A0err_end:<br>
=C2=A0 =C2=A0 =C2=A0inflateEnd(&amp;stream);<br>
=C2=A0err:<br>
-- <br>
2.41.0<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--0000000000005689ba05ffa58d2a--

