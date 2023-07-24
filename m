Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED9775F20A
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 12:06:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNsRb-0006j4-0Q; Mon, 24 Jul 2023 06:05:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qNsRU-0006ie-JE
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 06:05:28 -0400
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qNsRP-0007zX-FY
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 06:05:26 -0400
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-403cb525738so37315791cf.2
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 03:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690193122; x=1690797922;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Rrc/mf/4kaR1YoH/AJ/koBVXZS5GcKPOfPermIZ8D/c=;
 b=KavbBwEnBGL2qkWp47CdsSwaYyMgJVDdKOQFv8BPlnuuZkxE5SN+2VxXck0SqfVXJ3
 l6cfXarYgGqduENj0ytr6D+23ncTuwIQg2YQo2fYSMugvOCHL+eRgOwrdTP/X2E4MQSD
 qoGTwgwij1pvHlAIcsqhybEAVWaiglTRnWv8fas9FvyD7+2vkQLPziQ/pBrxNcU47L02
 MUevdsFOab9pzWQxkS7Lsr5/PjW9F3YHul5bmX6o6oILi206BcZlMbews8iQ6Jx0CcoW
 NXfCojPw4OaHdL7GFcNsLHi/SX5YqMdJbTLzweLFPqK2WPPNWCNmgraojuMKlFYsNdob
 capg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690193122; x=1690797922;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Rrc/mf/4kaR1YoH/AJ/koBVXZS5GcKPOfPermIZ8D/c=;
 b=GDmCW7LscGU+X4n0gRKeYSOiHOV/PNpbjXmWne3ZigoNQGlch+GZV59gmrV0tZFe1k
 y3x6IT+XpocK7g4xwpoeJob0St6gozW3Udmt8XdJyTUCKSPFAI+QK2r2uFHozQCIp7WU
 rDuLEEXWrXRG1zWmqTy/XyFK7sJeAtlNL+3uH0eTHMihOemSnQh+nk8LnsYz/4YyHmTC
 5++UnzGuaep0Z1s0qZP17pwooleZryh7Nb6B5WE1GzyGjMyyxK6pXwIpWLtmGXep4/6f
 kukppAI24ixs9K/8CgyyzjrCF2fkpKrWouQgG4eV1XxL2ypGvcprIftDJZUO8A9kQz3m
 Evig==
X-Gm-Message-State: ABy/qLbVBdfY9eCku8qbTPAJiJxoaeyXVK0+PXD1+jXXlNdOhnK9RkGe
 SUy3PcnV7U/FWOz5WdBKg2uXj7tmSnjRPD7eLwY=
X-Google-Smtp-Source: APBJJlGlGgbk8NEBMZ5+xarGNSwnb6NrULQFM5iqJtNMWSVyb4SAdG5nmTBej1UjUvD1oh6Q6STAdS6YALm/m5aCvHE=
X-Received: by 2002:ac8:59d2:0:b0:405:4003:ebbe with SMTP id
 f18-20020ac859d2000000b004054003ebbemr10556874qtf.3.1690193122421; Mon, 24
 Jul 2023 03:05:22 -0700 (PDT)
MIME-Version: 1.0
References: <ZL47B09wgJybWThE@redhat.com>
 <20230724100353.16628-1-sergii@zasenko.name>
In-Reply-To: <20230724100353.16628-1-sergii@zasenko.name>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 24 Jul 2023 14:05:11 +0400
Message-ID: <CAJ+F1CJJAsc_YKRXj_=TW=9113MLN94jTZ9khig3wnh6E4VXVQ@mail.gmail.com>
Subject: Re: [PATCH] Allow UNIX socket option for VNC websocket
To: Sergii Zasenko <sergii@zasenko.name>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000a9efd4060138c0d3"
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

--000000000000a9efd4060138c0d3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 24, 2023 at 2:04=E2=80=AFPM Sergii Zasenko <sergii@zasenko.name=
> wrote:

> - Remove unix socket option limitation for VNC websocket
> - Reflect websocket option changes in documentation
>
> Signed-off-by: Sergii Zasenko <sergii@zasenko.name>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  qemu-options.hx | 4 ++++
>  ui/vnc.c        | 5 -----
>  2 files changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 29b98c3..8cc910d 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -2451,6 +2451,10 @@ SRST
>          host. It is possible to control the websocket listen address
>          independently, using the syntax ``websocket``\ =3Dhost:port.
>
> +        Websocket could be allowed over UNIX domain socket, using the
> syntax
> +        ``websocket``\ =3Dunix:path, where path is the location of a uni=
x
> socket
> +        to listen for connections on.
> +
>          If no TLS credentials are provided, the websocket connection
>          runs in unencrypted mode. If TLS credentials are provided, the
>          websocket connection requires encrypted client connections.
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

--000000000000a9efd4060138c0d3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jul 24, 2023 at 2:04=E2=80=AF=
PM Sergii Zasenko &lt;<a href=3D"mailto:sergii@zasenko.name">sergii@zasenko=
.name</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">- Remove unix socket option limitation for VNC websocket<br>
- Reflect websocket option changes in documentation<br>
<br>
Signed-off-by: Sergii Zasenko &lt;<a href=3D"mailto:sergii@zasenko.name" ta=
rget=3D"_blank">sergii@zasenko.name</a>&gt;<br></blockquote><div><br></div>=
<div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lu=
reau@redhat.com">marcandre.lureau@redhat.com</a>&gt;</div><div>=C2=A0<br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0qemu-options.hx | 4 ++++<br>
=C2=A0ui/vnc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 5 -----<br>
=C2=A02 files changed, 4 insertions(+), 5 deletions(-)<br>
<br>
diff --git a/qemu-options.hx b/qemu-options.hx<br>
index 29b98c3..8cc910d 100644<br>
--- a/qemu-options.hx<br>
+++ b/qemu-options.hx<br>
@@ -2451,6 +2451,10 @@ SRST<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0host. It is possible to control the webso=
cket listen address<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0independently, using the syntax ``websock=
et``\ =3Dhost:port.<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Websocket could be allowed over UNIX domain so=
cket, using the syntax<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ``websocket``\ =3Dunix:path, where path is the=
 location of a unix socket<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 to listen for connections on.<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0If no TLS credentials are provided, the w=
ebsocket connection<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0runs in unencrypted mode. If TLS credenti=
als are provided, the<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0websocket connection requires encrypted c=
lient connections.<br>
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

--000000000000a9efd4060138c0d3--

