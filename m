Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C255A75ED1B
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 10:09:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNqcU-00073w-GK; Mon, 24 Jul 2023 04:08:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qNqcS-00073n-CM
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 04:08:40 -0400
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qNqcQ-0006hj-TT
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 04:08:40 -0400
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-4052d327682so21950711cf.1
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 01:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690186117; x=1690790917;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5rz5YHSAQHgFBkW+Hhq9NsVXRztjeV/SBwp72njpnH8=;
 b=j0abyG+lXpSrc3ZqYTx0CPT3NPpW670OfaO/ZSxARbpKw0N1cIt+FLCtuP6JeBKr44
 etFyEyM8Eiq8NrIavlvGuyxo9IYyJtumtYK8q2k6J3S55GZXnZW3hxPDyHyHTt9c0ryq
 K1c6VxLl7zAHj3uefLQ4IzD5mVcZQhbL8eiGQzGEs0zJx4s21Y27gLSYN3xqBnWOH8Id
 SIzu3wUz6N58bwZbmwlEVTXPwQbWYGuHTxmAGJc9vL4hT2CvXxwgAo2uJph3yFfC/0vx
 Pi1uqW1yh1QzDrGeMZ+xbMPTzfmCdxNSDSmbgkzzBnqBKcY4UqOMWdy6FQCJo5dyqVr9
 5ITA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690186117; x=1690790917;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5rz5YHSAQHgFBkW+Hhq9NsVXRztjeV/SBwp72njpnH8=;
 b=d7me+1E3ofUyEqGw8ApYFYF5ofB/F2B/irNkcnB3QvOhvvNkaVs3yPl4+ZjsPmH+m2
 LCmohpvkT6BkWb3VR+yDAPlld6TTxdRqypLGmXwHKTeHH7iV89MzLnCH/Bl90sJuhV+p
 UdxqPTwuR+n9GHSGYtO8LLBiAJY56/9copstj196P2ERvvbtec0NZh7/9CgQt4B1FOJZ
 WTd80TZ2tNqESOlDJGDNl3Y0ePJEpoPLkkexEJnxJgNyeLbegNvH5E7eBmHBBhJ56L/2
 MiPN6k+eux4QCiB6D/PjykfhUa/exPATRNaA6acNpFyc8nyQ2O268Jh3Gm0SWbikfd2q
 yzRw==
X-Gm-Message-State: ABy/qLZHPoORRgZNjrEx5Q4EOgEo490kwozCGz+CQWUeonm75wuW/RNV
 ojISzDFyo0UBwQvVTBTAwfgJmLGX55DSGf4sK6E=
X-Google-Smtp-Source: APBJJlHLck7eMCO9cFPH210XiVXfH/eLKFjhJGjYgLOO8fMkoLGIFw3dntQEphXYeuBwHc6DsK74osu1nRdeiP62SZY=
X-Received: by 2002:a05:622a:1a93:b0:403:e7aa:4ba8 with SMTP id
 s19-20020a05622a1a9300b00403e7aa4ba8mr8002937qtc.3.1690186117410; Mon, 24 Jul
 2023 01:08:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230723210355.28717-1-sergii@zasenko.name>
In-Reply-To: <20230723210355.28717-1-sergii@zasenko.name>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 24 Jul 2023 12:08:26 +0400
Message-ID: <CAJ+F1C+_y8APEqWq2fL0DHA3gYLD+wCkwUp+8D1MpARcVfFr_Q@mail.gmail.com>
Subject: Re: [PATCH] Allow UNIX socket for VNC websocket
To: Sergii Zasenko <sergii@zasenko.name>,
 "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000021f6bb0601371ff9"
Received-SPF: pass client-ip=2607:f8b0:4864:20::82e;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82e.google.com
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

--00000000000021f6bb0601371ff9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

Daniel, in commit 275e0d616b ("ui: refactor code for populating
SocketAddress from vnc_display_open"), you said "This refactoring also
removes the restriction that prevents enabling websockets when the plain
VNC server is listening on a UNIX socket.". But you didn't remove the
condition. I suppose it was a left-over?


On Mon, Jul 24, 2023 at 1:59=E2=80=AFAM Sergii Zasenko <sergii@zasenko.name=
> wrote:

> Signed-off-by: Sergii Zasenko <sergii@zasenko.name>
>

lgtm
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>



> ---
>  ui/vnc.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/ui/vnc.c b/ui/vnc.c
> index 92964dc..dea1414 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -3715,11 +3715,6 @@ static int vnc_display_get_address(const char
> *addrstr,
>          addr->type =3D SOCKET_ADDRESS_TYPE_UNIX;
>          addr->u.q_unix.path =3D g_strdup(addrstr + 5);
>
> -        if (websocket) {
> -            error_setg(errp, "UNIX sockets not supported with websock");
> -            goto cleanup;
> -        }
> -
>          if (to) {
>              error_setg(errp, "Port range not support with UNIX socket");
>              goto cleanup;
> --
> 2.39.2
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--00000000000021f6bb0601371ff9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><div><br></div><div>Daniel, i=
n commit 275e0d616b (&quot;ui: refactor code for populating SocketAddress f=
rom vnc_display_open&quot;), you said &quot;This refactoring also removes t=
he restriction that prevents enabling websockets when the plain VNC server =
is listening on a UNIX socket.&quot;. But you didn&#39;t remove the conditi=
on. I suppose it was a left-over?<br></div><div><br></div><div><br></div><d=
iv class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jul =
24, 2023 at 1:59=E2=80=AFAM Sergii Zasenko &lt;<a href=3D"mailto:sergii@zas=
enko.name">sergii@zasenko.name</a>&gt; wrote:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">Signed-off-by: Sergii Zasenko &lt;<a href=3D"=
mailto:sergii@zasenko.name" target=3D"_blank">sergii@zasenko.name</a>&gt;<b=
r></blockquote><div><br></div><div>lgtm</div><div>Reviewed-by: Marc-Andr=C3=
=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.com">marcandre.lur=
eau@redhat.com</a>&gt;</div><div><br></div><div>=C2=A0<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0ui/vnc.c | 5 -----<br>
=C2=A01 file changed, 5 deletions(-)<br>
<br>
diff --git a/ui/vnc.c b/ui/vnc.c<br>
index 92964dc..dea1414 100644<br>
--- a/ui/vnc.c<br>
+++ b/ui/vnc.c<br>
@@ -3715,11 +3715,6 @@ static int vnc_display_get_address(const char *addrs=
tr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0addr-&gt;type =3D SOCKET_ADDRESS_TYPE_UNI=
X;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0addr-&gt;u.q_unix.path =3D g_strdup(addrs=
tr + 5);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (websocket) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;UNIX sock=
ets not supported with websock&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto cleanup;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (to) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp, &quot;Port=
 range not support with UNIX socket&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto cleanup;<br>
-- <br>
2.39.2<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--00000000000021f6bb0601371ff9--

