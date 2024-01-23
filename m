Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 39279838BC0
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 11:26:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSDzS-00055r-Ge; Tue, 23 Jan 2024 05:26:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rSDyf-0004ga-ES
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 05:25:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rSDyd-0004wW-II
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 05:25:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706005554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0P9/oGoE42ImR/xsTtkgHngHfHnyAHpbh+6t3QJ35gU=;
 b=JL/KwZuakMXwEzULOKkwo/N436mjjjRjbfRZ7m0lJ2DU3FWll16zx7/QsT8w3XBxoSuJNa
 ND0tb8myN+AHmYlaGNmJhtIuunNPvnPVrM2DbnqlRXbBJIBMvg5vUy3ZeBAkx3uQF7R0b2
 SFc6NTdiTJZIUbQgdb19cHEfg3v2pQ8=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-wu6rbT9NNbGC1HzZ33whRw-1; Tue, 23 Jan 2024 05:25:50 -0500
X-MC-Unique: wu6rbT9NNbGC1HzZ33whRw-1
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-466e4de8230so1171709137.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 02:25:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706005550; x=1706610350;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0P9/oGoE42ImR/xsTtkgHngHfHnyAHpbh+6t3QJ35gU=;
 b=EhiMrg15jIM2Lrql4D7zyciMRutMwnATt5Fm81cIedPrvdF1EkLFO72HCzP7Ybxa4O
 T9MFBFWItRgxp5scMoDMV4b8ADM9wV8BaSVP3D3E1O1L3D8HgH17/QIZW5mPYimT7XWM
 hNi1nJFnXkMB1FJ0nv6Zo1b2YuMLurccshCl9xt15Bab69xu2RH67DLZOXiKbDhe4z/X
 wryNns0kyu0X0DW06CjKcFLDxmVQWkydVpr7lsMZPfSP7z6rZQSXMgZhX3FHDxI7Ahy/
 wqb1FX+CuyK4gsXC+Iu8W7ZJ7/Dz19eXC83HYO78n8QLQBs762RMxOaM5zv6K29s/Sol
 4gkg==
X-Gm-Message-State: AOJu0Yx1am9F5jKZQq9G68BrAtWTXLPs/rE1MxejZ4pwMSFmUI3uEj3Y
 rNmDSl6bKSNCp86G7hUf7/c/8jmCZ+yoaQGuCzSYYoEuLXH8ANw98fiv7C9EyUDoYWo9rEmOwPg
 Ctovrtvu+utDR+MBDnyhS+83fqBite8go2BlaOmg9kshJfttJ5qGQ18/5mtHRP9g2+5RF4yuIUU
 0dsIT/pMvHSyUN3ePMj9U9u0bVieY=
X-Received: by 2002:a67:f4ce:0:b0:469:4eda:6b7f with SMTP id
 s14-20020a67f4ce000000b004694eda6b7fmr2673360vsn.62.1706005550344; 
 Tue, 23 Jan 2024 02:25:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGbdrdHWkRcV6S4I7sNHEUJ/Iz9MR7K9nQ/6dGA1ZrujJetStBaUNdaZ/ro2vpi4gWk7wd5wA3I0yr602DM2VQ=
X-Received: by 2002:a67:f4ce:0:b0:469:4eda:6b7f with SMTP id
 s14-20020a67f4ce000000b004694eda6b7fmr2673356vsn.62.1706005550087; Tue, 23
 Jan 2024 02:25:50 -0800 (PST)
MIME-Version: 1.0
References: <20240122191753.103118-1-thuth@redhat.com>
 <20240122191753.103118-3-thuth@redhat.com>
In-Reply-To: <20240122191753.103118-3-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 23 Jan 2024 11:25:38 +0100
Message-ID: <CABgObfZRmavOuv-1iXEyjfcMnKYBGwytYTY7cATpNA14QtHM=g@mail.gmail.com>
Subject: Re: [PATCH 2/5] util/uri: Simplify uri_string_unescape()
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Stefan Weil <sw@weilnetz.de>, 
 qemu-trivial <qemu-trivial@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000cc5ce5060f9a5e74"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.289,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

--000000000000cc5ce5060f9a5e74
Content-Type: text/plain; charset="UTF-8"

Il lun 22 gen 2024, 20:18 Thomas Huth <thuth@redhat.com> ha scritto:

> uri_string_unescape() basically does the same as the glib function
> g_uri_unescape_string(), with just an additional length parameter.
>

You can replace it altogether with g_uri_unescape_segment.

Paolo

So we can simplify this function a lot by limiting the length with
> g_strndup() first and then by calling g_uri_unescape_string() instead
> of walking through the string manually.
>
> Suggested-by: Stefan Weil <stefan.weil@weilnetz.de>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  util/uri.c | 49 +++----------------------------------------------
>  1 file changed, 3 insertions(+), 46 deletions(-)
>
> diff --git a/util/uri.c b/util/uri.c
> index 33b6c7214e..2a75f535ba 100644
> --- a/util/uri.c
> +++ b/util/uri.c
> @@ -1561,15 +1561,6 @@ done_cd:
>      return 0;
>  }
>
> -static int is_hex(char c)
> -{
> -    if (((c >= '0') && (c <= '9')) || ((c >= 'a') && (c <= 'f')) ||
> -        ((c >= 'A') && (c <= 'F'))) {
> -        return 1;
> -    }
> -    return 0;
> -}
> -
>  /**
>   * uri_string_unescape:
>   * @str:  the string to unescape
> @@ -1585,8 +1576,7 @@ static int is_hex(char c)
>   */
>  char *uri_string_unescape(const char *str, int len)
>  {
> -    char *ret, *out;
> -    const char *in;
> +    g_autofree char *lstr = NULL;
>
>      if (str == NULL) {
>          return NULL;
> @@ -1594,42 +1584,9 @@ char *uri_string_unescape(const char *str, int len)
>      if (len <= 0) {
>          len = strlen(str);
>      }
> -    if (len < 0) {
> -        return NULL;
> -    }
> -
> -    ret = g_malloc(len + 1);
> +    lstr = g_strndup(str, len);
>
> -    in = str;
> -    out = ret;
> -    while (len > 0) {
> -        if ((len > 2) && (*in == '%') && (is_hex(in[1])) &&
> (is_hex(in[2]))) {
> -            in++;
> -            if ((*in >= '0') && (*in <= '9')) {
> -                *out = (*in - '0');
> -            } else if ((*in >= 'a') && (*in <= 'f')) {
> -                *out = (*in - 'a') + 10;
> -            } else if ((*in >= 'A') && (*in <= 'F')) {
> -                *out = (*in - 'A') + 10;
> -            }
> -            in++;
> -            if ((*in >= '0') && (*in <= '9')) {
> -                *out = *out * 16 + (*in - '0');
> -            } else if ((*in >= 'a') && (*in <= 'f')) {
> -                *out = *out * 16 + (*in - 'a') + 10;
> -            } else if ((*in >= 'A') && (*in <= 'F')) {
> -                *out = *out * 16 + (*in - 'A') + 10;
> -            }
> -            in++;
> -            len -= 3;
> -            out++;
> -        } else {
> -            *out++ = *in++;
> -            len--;
> -        }
> -    }
> -    *out = 0;
> -    return ret;
> +    return g_uri_unescape_string(lstr, NULL);
>  }
>
>  /**
> --
> 2.43.0
>
>

--000000000000cc5ce5060f9a5e74
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il lun 22 gen 2024, 20:18 Thomas Huth &lt;<a href=3D"m=
ailto:thuth@redhat.com">thuth@redhat.com</a>&gt; ha scritto:<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex">uri_string_unescape() basically does the same as =
the glib function<br>
g_uri_unescape_string(), with just an additional length parameter.<br></blo=
ckquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">You can r=
eplace it altogether with g_uri_unescape_segment.</div><div dir=3D"auto"><b=
r></div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div dir=
=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
So we can simplify this function a lot by limiting the length with<br>
g_strndup() first and then by calling g_uri_unescape_string() instead<br>
of walking through the string manually.<br>
<br>
Suggested-by: Stefan Weil &lt;<a href=3D"mailto:stefan.weil@weilnetz.de" ta=
rget=3D"_blank" rel=3D"noreferrer">stefan.weil@weilnetz.de</a>&gt;<br>
Signed-off-by: Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com" target=
=3D"_blank" rel=3D"noreferrer">thuth@redhat.com</a>&gt;<br>
---<br>
=C2=A0util/uri.c | 49 +++----------------------------------------------<br>
=C2=A01 file changed, 3 insertions(+), 46 deletions(-)<br>
<br>
diff --git a/util/uri.c b/util/uri.c<br>
index 33b6c7214e..2a75f535ba 100644<br>
--- a/util/uri.c<br>
+++ b/util/uri.c<br>
@@ -1561,15 +1561,6 @@ done_cd:<br>
=C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0}<br>
<br>
-static int is_hex(char c)<br>
-{<br>
-=C2=A0 =C2=A0 if (((c &gt;=3D &#39;0&#39;) &amp;&amp; (c &lt;=3D &#39;9&#3=
9;)) || ((c &gt;=3D &#39;a&#39;) &amp;&amp; (c &lt;=3D &#39;f&#39;)) ||<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ((c &gt;=3D &#39;A&#39;) &amp;&amp; (c &lt;=3D=
 &#39;F&#39;))) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1;<br>
-=C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 return 0;<br>
-}<br>
-<br>
=C2=A0/**<br>
=C2=A0 * uri_string_unescape:<br>
=C2=A0 * @str:=C2=A0 the string to unescape<br>
@@ -1585,8 +1576,7 @@ static int is_hex(char c)<br>
=C2=A0 */<br>
=C2=A0char *uri_string_unescape(const char *str, int len)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 char *ret, *out;<br>
-=C2=A0 =C2=A0 const char *in;<br>
+=C2=A0 =C2=A0 g_autofree char *lstr =3D NULL;<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (str =3D=3D NULL) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return NULL;<br>
@@ -1594,42 +1584,9 @@ char *uri_string_unescape(const char *str, int len)<=
br>
=C2=A0 =C2=A0 =C2=A0if (len &lt;=3D 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0len =3D strlen(str);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 if (len &lt; 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 ret =3D g_malloc(len + 1);<br>
+=C2=A0 =C2=A0 lstr =3D g_strndup(str, len);<br>
<br>
-=C2=A0 =C2=A0 in =3D str;<br>
-=C2=A0 =C2=A0 out =3D ret;<br>
-=C2=A0 =C2=A0 while (len &gt; 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((len &gt; 2) &amp;&amp; (*in =3D=3D &#39;%=
&#39;) &amp;&amp; (is_hex(in[1])) &amp;&amp; (is_hex(in[2]))) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 in++;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((*in &gt;=3D &#39;0&#39;) &a=
mp;&amp; (*in &lt;=3D &#39;9&#39;)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *out =3D (*in - &#=
39;0&#39;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if ((*in &gt;=3D &#39;a&#=
39;) &amp;&amp; (*in &lt;=3D &#39;f&#39;)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *out =3D (*in - &#=
39;a&#39;) + 10;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if ((*in &gt;=3D &#39;A&#=
39;) &amp;&amp; (*in &lt;=3D &#39;F&#39;)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *out =3D (*in - &#=
39;A&#39;) + 10;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 in++;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((*in &gt;=3D &#39;0&#39;) &a=
mp;&amp; (*in &lt;=3D &#39;9&#39;)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *out =3D *out * 16=
 + (*in - &#39;0&#39;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if ((*in &gt;=3D &#39;a&#=
39;) &amp;&amp; (*in &lt;=3D &#39;f&#39;)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *out =3D *out * 16=
 + (*in - &#39;a&#39;) + 10;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if ((*in &gt;=3D &#39;A&#=
39;) &amp;&amp; (*in &lt;=3D &#39;F&#39;)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *out =3D *out * 16=
 + (*in - &#39;A&#39;) + 10;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 in++;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 len -=3D 3;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 out++;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *out++ =3D *in++;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 len--;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 *out =3D 0;<br>
-=C2=A0 =C2=A0 return ret;<br>
+=C2=A0 =C2=A0 return g_uri_unescape_string(lstr, NULL);<br>
=C2=A0}<br>
<br>
=C2=A0/**<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div></div></div>

--000000000000cc5ce5060f9a5e74--


