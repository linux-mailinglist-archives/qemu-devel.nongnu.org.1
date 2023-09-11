Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B442979A8CC
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 16:43:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfi87-0006Cl-C2; Mon, 11 Sep 2023 10:43:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1qfi82-0006Br-FP
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 10:43:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1qfi7z-0006CV-Kw
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 10:43:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694443382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4EUdjsAOG3vZiZVThWGILZZGP47D1O4IHrKsuAoYfz4=;
 b=c4UStb86uAvQ/k8IoKNMorfI16TaKCeOJbZ7wF7WXUbPxSgRBebVS/4jgs0K50Dl49QV6U
 O+cyywBSbSAAT+Kqgt5I5YaW4qO+yT24TxB2tbmEQmQBGIs9fHySjIipni47rSrxu6JU07
 prA5zsmpqxoIcVFvlYZi8oHJBRGEh1k=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-etQiObKEOUiZs7Zu1PYFGw-1; Mon, 11 Sep 2023 10:43:00 -0400
X-MC-Unique: etQiObKEOUiZs7Zu1PYFGw-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-26d63b60934so6194515a91.1
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 07:43:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694443379; x=1695048179;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4EUdjsAOG3vZiZVThWGILZZGP47D1O4IHrKsuAoYfz4=;
 b=FqL6/BJZY8bOEsuELPBkRBHACT+/xH/f9t04OE5j1O9HS+0ArRXFyRLCZpRKcSH/tZ
 QjBjzCjtWVHC2Ut6EuQwlbrumTBoP5HooDafqKResXDD2eEvXqIU3EdIEugL4iZXshGv
 k97fg+zSRzl4zWD3zQExsO+xUA3WASy1ucfIDMMwxM/p1r+nO0mG0kNAnZAjtvB033nk
 Y41t0MwbgzLkwvUaLt8M2XoqKNpgbQ9WVj0zGsTvCB59qR4SKl+Wm3BMrtq89Sxcr53b
 0ZiZsBH3BPBTJMrH3H3WasdLEqGcWMOSuHnpc4dEI696EsCLGszrjNJHsgw9J756i87c
 g8Dg==
X-Gm-Message-State: AOJu0YxOBB/UFeid2GiyAGAcwFNfVw6pNX9Law+c8H1YDDudcxVwQjd9
 n9u+D5HErX6Fmp0KqsVdBlakHhi1EWkcpVcTWdsNkLhiFgn2+Jj0XE85nwiGP2KFXrgnDHe1oxM
 oNgH1FfV5aFniC0CKkD3JCosx+Zc4GIc=
X-Received: by 2002:a17:90b:1e49:b0:268:71e4:ec2a with SMTP id
 pi9-20020a17090b1e4900b0026871e4ec2amr7967083pjb.48.1694443379598; 
 Mon, 11 Sep 2023 07:42:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGweI0LnPetnAVM0bFbje6UPZcLJqNmV79zNjF59hnX06pQJFKmi2zRPO/Y/sGVNd62k1s9Grn605xuG/2Iw3g=
X-Received: by 2002:a17:90b:1e49:b0:268:71e4:ec2a with SMTP id
 pi9-20020a17090b1e4900b0026871e4ec2amr7967072pjb.48.1694443379328; Mon, 11
 Sep 2023 07:42:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230911140638.1458156-1-marcandre.lureau@redhat.com>
In-Reply-To: <20230911140638.1458156-1-marcandre.lureau@redhat.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Mon, 11 Sep 2023 16:42:48 +0200
Message-ID: <CADSE00JJjgi8mdcHA304GAW=HxoKA4G-uBwasnUOZrREpXdWnQ@mail.gmail.com>
Subject: Re: [PATCH] ui: fix crash when there are no active_console
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000b79bf1060516573c"
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

--000000000000b79bf1060516573c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 11, 2023 at 4:08=E2=80=AFPM <marcandre.lureau@redhat.com> wrote=
:

> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Thread 1 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.
> 0x0000555555888630 in dpy_ui_info_supported (con=3D0x0) at
> ../ui/console.c:812
> 812         return con->hw_ops->ui_info !=3D NULL;
> (gdb) bt
> #0  0x0000555555888630 in dpy_ui_info_supported (con=3D0x0) at
> ../ui/console.c:812
> #1  0x00005555558a44b1 in protocol_client_msg (vs=3D0x5555578c76c0,
> data=3D0x5555581e93f0 <incomplete sequence \373>, len=3D24) at ../ui/vnc.=
c:2585
> #2  0x00005555558a19ac in vnc_client_read (vs=3D0x5555578c76c0) at
> ../ui/vnc.c:1607
> #3  0x00005555558a1ac2 in vnc_client_io (ioc=3D0x5555581eb0e0,
> condition=3DG_IO_IN, opaque=3D0x5555578c76c0) at ../ui/vnc.c:1635
>
> Fixes:
> https://issues.redhat.com/browse/RHEL-2600
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  ui/console.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/ui/console.c b/ui/console.c
> index 90ae4be602..0f31ecece6 100644
> --- a/ui/console.c
> +++ b/ui/console.c
> @@ -808,6 +808,9 @@ bool dpy_ui_info_supported(QemuConsole *con)
>      if (con =3D=3D NULL) {
>          con =3D active_console;
>      }
> +    if (con =3D=3D NULL) {
> +        return false;
> +    }
>
>      return con->hw_ops->ui_info !=3D NULL;
>  }
> @@ -817,6 +820,9 @@ const QemuUIInfo *dpy_get_ui_info(const QemuConsole
> *con)
>      if (con =3D=3D NULL) {
>          con =3D active_console;
>      }
> +    if (con =3D=3D NULL) {
> +        return NULL;
> +    }
>
>      return &con->ui_info;
>  }
> @@ -826,6 +832,9 @@ int dpy_set_ui_info(QemuConsole *con, QemuUIInfo
> *info, bool delay)
>      if (con =3D=3D NULL) {
>          con =3D active_console;
>      }
> +    if (con =3D=3D NULL) {
> +        return -1;
> +    }
>
>      if (!dpy_ui_info_supported(con)) {
>          return -1;
> @@ -1401,6 +1410,10 @@ QEMUCursor *qemu_console_get_cursor(QemuConsole
> *con)
>      if (con =3D=3D NULL) {
>          con =3D active_console;
>      }
> +    if (con =3D=3D NULL) {
> +        return NULL;
> +    }
> +
>      return QEMU_IS_GRAPHIC_CONSOLE(con) ?
> QEMU_GRAPHIC_CONSOLE(con)->cursor : NULL;
>  }
>
> @@ -1414,6 +1427,10 @@ bool qemu_console_is_graphic(QemuConsole *con)
>      if (con =3D=3D NULL) {
>          con =3D active_console;
>      }
> +    if (con =3D=3D NULL) {
> +        return false;
> +    }
> +
>      return con && QEMU_IS_GRAPHIC_CONSOLE(con);
>  }
>
> @@ -1422,6 +1439,10 @@ bool qemu_console_is_fixedsize(QemuConsole *con)
>      if (con =3D=3D NULL) {
>          con =3D active_console;
>      }
> +    if (con =3D=3D NULL) {
> +        return false;
> +    }
> +
>

The "con" initialization condition is already checked in the line below
(now unnecessarily).
If the if block is preferred for consistency with other functions, we could
remove the con check from
the condition below:
```
return QEMU_IS_GRAPHIC_CONSOLE(con) || QEMU_IS_FIXED_TEXT_CONSOLE(con);
```


>      return con && (QEMU_IS_GRAPHIC_CONSOLE(con) ||
> QEMU_IS_FIXED_TEXT_CONSOLE(con));
>  }
>
> @@ -1493,6 +1514,10 @@ int qemu_console_get_index(QemuConsole *con)
>      if (con =3D=3D NULL) {
>          con =3D active_console;
>      }
> +    if (con =3D=3D NULL) {
> +        return -1;
> +    }
> +
>

Same as before, here we could simply "return con->index;"


>      return con ? con->index : -1;

 }
>
> --
> 2.41.0
>
>
>

--000000000000b79bf1060516573c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><div dir=3D"ltr" class=3D"gmail_sign=
ature"><div dir=3D"ltr"><br></div></div></div></div><br><div class=3D"gmail=
_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Sep 11, 2023 at 4:08=
=E2=80=AFPM &lt;<a href=3D"mailto:marcandre.lureau@redhat.com">marcandre.lu=
reau@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">From: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre=
.lureau@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<b=
r>
<br>
Thread 1 &quot;qemu-system-x86&quot; received signal SIGSEGV, Segmentation =
fault.<br>
0x0000555555888630 in dpy_ui_info_supported (con=3D0x0) at ../ui/console.c:=
812<br>
812=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return con-&gt;hw_ops-&gt;ui_info !=3D=
 NULL;<br>
(gdb) bt<br>
#0=C2=A0 0x0000555555888630 in dpy_ui_info_supported (con=3D0x0) at ../ui/c=
onsole.c:812<br>
#1=C2=A0 0x00005555558a44b1 in protocol_client_msg (vs=3D0x5555578c76c0, da=
ta=3D0x5555581e93f0 &lt;incomplete sequence \373&gt;, len=3D24) at ../ui/vn=
c.c:2585<br>
#2=C2=A0 0x00005555558a19ac in vnc_client_read (vs=3D0x5555578c76c0) at ../=
ui/vnc.c:1607<br>
#3=C2=A0 0x00005555558a1ac2 in vnc_client_io (ioc=3D0x5555581eb0e0, conditi=
on=3DG_IO_IN, opaque=3D0x5555578c76c0) at ../ui/vnc.c:1635<br>
<br>
Fixes:<br>
<a href=3D"https://issues.redhat.com/browse/RHEL-2600" rel=3D"noreferrer" t=
arget=3D"_blank">https://issues.redhat.com/browse/RHEL-2600</a><br>
<br>
Signed-off-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lurea=
u@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
---<br>
=C2=A0ui/console.c | 25 +++++++++++++++++++++++++<br>
=C2=A01 file changed, 25 insertions(+)<br>
<br>
diff --git a/ui/console.c b/ui/console.c<br>
index 90ae4be602..0f31ecece6 100644<br>
--- a/ui/console.c<br>
+++ b/ui/console.c<br>
@@ -808,6 +808,9 @@ bool dpy_ui_info_supported(QemuConsole *con)<br>
=C2=A0 =C2=A0 =C2=A0if (con =3D=3D NULL) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0con =3D active_console;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 if (con =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0return con-&gt;hw_ops-&gt;ui_info !=3D NULL;<br>
=C2=A0}<br>
@@ -817,6 +820,9 @@ const QemuUIInfo *dpy_get_ui_info(const QemuConsole *co=
n)<br>
=C2=A0 =C2=A0 =C2=A0if (con =3D=3D NULL) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0con =3D active_console;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 if (con =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
+=C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0return &amp;con-&gt;ui_info;<br>
=C2=A0}<br>
@@ -826,6 +832,9 @@ int dpy_set_ui_info(QemuConsole *con, QemuUIInfo *info,=
 bool delay)<br>
=C2=A0 =C2=A0 =C2=A0if (con =3D=3D NULL) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0con =3D active_console;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 if (con =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
+=C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (!dpy_ui_info_supported(con)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
@@ -1401,6 +1410,10 @@ QEMUCursor *qemu_console_get_cursor(QemuConsole *con=
)<br>
=C2=A0 =C2=A0 =C2=A0if (con =3D=3D NULL) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0con =3D active_console;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 if (con =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0return QEMU_IS_GRAPHIC_CONSOLE(con) ? QEMU_GRAPHIC_CONS=
OLE(con)-&gt;cursor : NULL;<br>
=C2=A0}<br>
<br>
@@ -1414,6 +1427,10 @@ bool qemu_console_is_graphic(QemuConsole *con)<br>
=C2=A0 =C2=A0 =C2=A0if (con =3D=3D NULL) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0con =3D active_console;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 if (con =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0return con &amp;&amp; QEMU_IS_GRAPHIC_CONSOLE(con);<br>
=C2=A0}<br>
<br>
@@ -1422,6 +1439,10 @@ bool qemu_console_is_fixedsize(QemuConsole *con)<br>
=C2=A0 =C2=A0 =C2=A0if (con =3D=3D NULL) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0con =3D active_console;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 if (con =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 }<br>
+<br></blockquote><div><br></div><div>The &quot;con&quot; initialization co=
ndition is already checked in the line below (now unnecessarily).</div><div=
>If the if block is preferred for consistency with other functions, we coul=
d remove the con check from</div><div>the condition below:</div><div>```</d=
iv><div>return QEMU_IS_GRAPHIC_CONSOLE(con) || QEMU_IS_FIXED_TEXT_CONSOLE(c=
on);<br></div><div>```</div><div>=C2=A0</div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0return con &amp;&amp; (QEMU_IS_GRAPHIC_CONSOLE(con) || =
QEMU_IS_FIXED_TEXT_CONSOLE(con));<br>
=C2=A0}<br>
<br>
@@ -1493,6 +1514,10 @@ int qemu_console_get_index(QemuConsole *con)<br>
=C2=A0 =C2=A0 =C2=A0if (con =3D=3D NULL) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0con =3D active_console;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 if (con =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
+=C2=A0 =C2=A0 }<br>
+<br></blockquote><div><br></div><div>Same as before, here we could simply =
&quot;return con-&gt;index;&quot;</div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0return con ? con-&gt;index : -1;=C2=A0</blockquote><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0}<br>
<br>
-- <br>
2.41.0<br>
<br>
<br>
</blockquote></div></div>

--000000000000b79bf1060516573c--


