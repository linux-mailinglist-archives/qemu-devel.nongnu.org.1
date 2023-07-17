Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F8D755D1F
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 09:41:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLIqi-0000jC-3K; Mon, 17 Jul 2023 03:40:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qLIqg-0000ia-0R
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 03:40:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qLIqe-0001i9-7B
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 03:40:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689579646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pd9t3tNyl67kcQskDPiSqFXS3O5DPxLr29XAuLi6U44=;
 b=bjvzD/hTp3NPGHkNlwexu0va7JeoAlXeVxz6SR9W+ScIvhiWnBgGJHFE8UxO/L0vStC0sk
 pN1s2Ucu+34AsXFYIYIcL7Gn4Zyamk6k+GdbKYPd0RWx+aNSfE1IXw45oFIKIfl/jxDKWF
 hgmr5KR47r8+Iod8ajQPh4eOLr3ssfY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-E50Eghk6NUu0FxlxN4KV4Q-1; Mon, 17 Jul 2023 03:40:45 -0400
X-MC-Unique: E50Eghk6NUu0FxlxN4KV4Q-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-51dd16f823bso2867301a12.0
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 00:40:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689579643; x=1692171643;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pd9t3tNyl67kcQskDPiSqFXS3O5DPxLr29XAuLi6U44=;
 b=TzhW1INmRucJk2/o4QOt5baCBxm4YC/QlfX7HlSsFLKS5GJxl6GaTiQZ1ONPWgyG7G
 5PSsI7bLahM8lPTRRCCH7UQ94xYBtCsHqqf0GLlcXUM0wLiTAg5EyffA8vOE0OHCB2hS
 N/LmJwmSwCF/O7Nb57YmK42F5UJFfwsN4fdeYQmJNf1OHyl/EGPaOoFyfm/T7m0J8SyY
 xm+lCsiWXcaMcq8VVWjR64VekUk65V4KN6r6hSH93QCjwghz3WtxQ8yfFOSp5DvAsmks
 5iLrmlIORST/zmnPnw+hafqYh4pIVAJzGpgfDAHgum+Zkvi6d2mPSNZbUoDupz5S1U6R
 dexg==
X-Gm-Message-State: ABy/qLYhog+9P6FvNAeeHrh2wHWKW0CU1tCx+pZVdd+c7xjOsK2D/nRD
 xYoIibnblFL1Sh+LbzL8UcKPZQfZDa9adPQNKvsBOmqCHqB8l74Dh5UfoflZRKGU3S2QLY+JeHl
 oVVKZwf/YLGyRuPk3mTly/ooSH/OOIlnBOC9BWk0=
X-Received: by 2002:aa7:c14e:0:b0:51d:a4b1:d430 with SMTP id
 r14-20020aa7c14e000000b0051da4b1d430mr11089771edp.3.1689579642829; 
 Mon, 17 Jul 2023 00:40:42 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHVeYYiJPiKlg23dtvbl0E/Rmv0Fnn6UeQTMIKZrd0np6qflmEuBHbEDVGeGb1DiJxK4NW5Ux9GBDDaAGYEtvE=
X-Received: by 2002:aa7:c14e:0:b0:51d:a4b1:d430 with SMTP id
 r14-20020aa7c14e000000b0051da4b1d430mr11089760edp.3.1689579642575; Mon, 17
 Jul 2023 00:40:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230717025936.71456-1-gaoshiyuan@baidu.com>
In-Reply-To: <20230717025936.71456-1-gaoshiyuan@baidu.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 17 Jul 2023 11:40:31 +0400
Message-ID: <CAMxuvaz4NwRfCoWGVBofihBsZnBya7cv3Cq7w-Y6Wzd0mPoDQQ@mail.gmail.com>
Subject: Re: [PATCH] vnc,ps2: fix the PS/2 mouse work badly when connect VNC
To: Shiyuan Gao <gaoshiyuan@baidu.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000006a73810600a9ea9c"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--0000000000006a73810600a9ea9c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shiyuan

On Mon, Jul 17, 2023 at 7:16=E2=80=AFAM Shiyuan Gao <gaoshiyuan@baidu.com> =
wrote:

> When only use PS/2 mouse without usb-tablet, the mouse pointer of the
> guest on the VNC will work badly that the cursor of VNC is inconsistent
> with the mouse pointer of guest.
>
>
Afaik, VNC doesn't support client-side drawing of guest mouse (there are no
message to set guest mouse position). So the guest mouse should be drawn by
the server, and currently QEMU doesn't do it.


> The reason is the PS/2 mouse use relative coordinates and we can't know
> the initial position of the guest mouse pointer.
>

It's not just about the initial position.


>
>
So move the guest mouse pointer to (0, 0) of the screen when connect the
> VNC, and then move the mouse pointer to the cursor of VNC(absolute
> coordinates are also relative coordinates).
>
>
It's hardly a solution, you still have no clue what will be the guest mouse
position.


> On windows VM, also need disable "Enhance Pointer Precision" Option in
> "Pointer Options" (Control Panel -> Mouse).
>
>
Apparently, this option doesn't have much to do with relative mouse motion.
Can you explain what it does with this change?


Which guest OS are you using? Hopefully they all support either usb-tablet
or vmmouse extension for absolute positioning. Otherwise, I'd suggest using
Spice, which has those messages for client side guest-mouse drawing.



> Signed-off-by: Shiyuan Gao <gaoshiyuan@baidu.com>
> ---
>  hw/input/ps2.c | 2 +-
>  ui/vnc.c       | 5 +++++
>  2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/hw/input/ps2.c b/hw/input/ps2.c
> index 45af76a837..e1f44bd298 100644
> --- a/hw/input/ps2.c
> +++ b/hw/input/ps2.c
> @@ -77,7 +77,7 @@
>  #define MOUSE_STATUS_ENABLED    0x20
>  #define MOUSE_STATUS_SCALE21    0x10
>
> -#define PS2_QUEUE_SIZE      16  /* Queue size required by PS/2 protocol =
*/
> +#define PS2_QUEUE_SIZE      32  /* Queue size required by PS/2 protocol =
*/
>  #define PS2_QUEUE_HEADROOM  8   /* Queue size for keyboard command
> replies */
>
>  /* Bits for 'modifiers' field in PS2KbdState */
> diff --git a/ui/vnc.c b/ui/vnc.c
> index 92964dcc0c..a1a6048ee4 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -1816,6 +1816,11 @@ static void pointer_event(VncState *vs, int
> button_mask, int x, int y)
>          if (vs->last_x !=3D -1) {
>              qemu_input_queue_rel(con, INPUT_AXIS_X, x - vs->last_x);
>              qemu_input_queue_rel(con, INPUT_AXIS_Y, y - vs->last_y);
> +        } else {
> +            qemu_input_queue_rel(con, INPUT_AXIS_X, 0 - width);
> +            qemu_input_queue_rel(con, INPUT_AXIS_Y, 0 - height);
> +            x =3D 0;
> +            y =3D 0;
>          }
>          vs->last_x =3D x;
>          vs->last_y =3D y;
> --
> 2.27.0
>
>

--0000000000006a73810600a9ea9c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Shiyuan</div><br><div class=3D"gmail_q=
uote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jul 17, 2023 at 7:16=E2=
=80=AFAM Shiyuan Gao &lt;<a href=3D"mailto:gaoshiyuan@baidu.com">gaoshiyuan=
@baidu.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">When only use PS/2 mouse without usb-tablet, the mouse pointer o=
f the<br>
guest on the VNC will work badly that the cursor of VNC is inconsistent<br>
with the mouse pointer of guest.<br>
<br></blockquote><div><br></div><div>Afaik, VNC doesn&#39;t support client-=
side drawing of guest mouse (there are no message to set guest mouse positi=
on). So the guest mouse should be drawn by the server, and currently QEMU d=
oesn&#39;t do it.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">
The reason is the PS/2 mouse use relative coordinates and we can&#39;t know=
<br>
the initial position of the guest mouse pointer.<br></blockquote><div><br><=
/div><div>It&#39;s not just about the initial position.<br></div><div>=C2=
=A0<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=C2=A0 <br><=
/blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
So move the guest mouse pointer to (0, 0) of the screen when connect the<br=
>
VNC, and then move the mouse pointer to the cursor of VNC(absolute<br>
coordinates are also relative coordinates).<br>
<br></blockquote><div><br></div><div>It&#39;s hardly a solution, you still =
have no clue what will be the guest mouse position.<br></div><div>=C2=A0</d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">
On windows VM, also need disable &quot;Enhance Pointer Precision&quot; Opti=
on in<br>
&quot;Pointer Options&quot; (Control Panel -&gt; Mouse).<br>
<br></blockquote><div><br></div><div>Apparently, this option doesn&#39;t ha=
ve much to do with relative mouse motion. Can you explain what it does with=
 this change?</div><div><br></div><div><br></div><div>Which guest OS are yo=
u using? Hopefully they all support either usb-tablet or vmmouse extension =
for absolute positioning. Otherwise, I&#39;d suggest using Spice, which has=
 those messages for client side guest-mouse drawing.</div><div><br></div><d=
iv>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Signed-off-by: Shiyuan Gao &lt;<a href=3D"mailto:gaoshiyuan@baidu.com" targ=
et=3D"_blank">gaoshiyuan@baidu.com</a>&gt;<br>
---<br>
=C2=A0hw/input/ps2.c | 2 +-<br>
=C2=A0ui/vnc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 5 +++++<br>
=C2=A02 files changed, 6 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/hw/input/ps2.c b/hw/input/ps2.c<br>
index 45af76a837..e1f44bd298 100644<br>
--- a/hw/input/ps2.c<br>
+++ b/hw/input/ps2.c<br>
@@ -77,7 +77,7 @@<br>
=C2=A0#define MOUSE_STATUS_ENABLED=C2=A0 =C2=A0 0x20<br>
=C2=A0#define MOUSE_STATUS_SCALE21=C2=A0 =C2=A0 0x10<br>
<br>
-#define PS2_QUEUE_SIZE=C2=A0 =C2=A0 =C2=A0 16=C2=A0 /* Queue size required=
 by PS/2 protocol */<br>
+#define PS2_QUEUE_SIZE=C2=A0 =C2=A0 =C2=A0 32=C2=A0 /* Queue size required=
 by PS/2 protocol */<br>
=C2=A0#define PS2_QUEUE_HEADROOM=C2=A0 8=C2=A0 =C2=A0/* Queue size for keyb=
oard command replies */<br>
<br>
=C2=A0/* Bits for &#39;modifiers&#39; field in PS2KbdState */<br>
diff --git a/ui/vnc.c b/ui/vnc.c<br>
index 92964dcc0c..a1a6048ee4 100644<br>
--- a/ui/vnc.c<br>
+++ b/ui/vnc.c<br>
@@ -1816,6 +1816,11 @@ static void pointer_event(VncState *vs, int button_m=
ask, int x, int y)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (vs-&gt;last_x !=3D -1) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_input_queue_rel(con, I=
NPUT_AXIS_X, x - vs-&gt;last_x);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_input_queue_rel(con, I=
NPUT_AXIS_Y, y - vs-&gt;last_y);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_input_queue_rel(con, INPUT_=
AXIS_X, 0 - width);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_input_queue_rel(con, INPUT_=
AXIS_Y, 0 - height);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 x =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 y =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vs-&gt;last_x =3D x;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vs-&gt;last_y =3D y;<br>
-- <br>
2.27.0<br>
<br>
</blockquote></div></div>

--0000000000006a73810600a9ea9c--


