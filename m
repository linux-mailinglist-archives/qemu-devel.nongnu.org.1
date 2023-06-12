Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3523E72BD24
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 11:55:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8eG0-0005AY-Hy; Mon, 12 Jun 2023 05:54:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1q8eFy-00059d-Qv
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 05:54:38 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1q8eFw-0005L7-JX
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 05:54:38 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-4f004cc54f4so4806145e87.3
 for <qemu-devel@nongnu.org>; Mon, 12 Jun 2023 02:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686563674; x=1689155674;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=K9vBRHnXqPgwEMrEBl5BKC5DkCDQxRZjJLhBrhwrbHs=;
 b=gajJDYl5Wpm9653rrI4197AgOHgWLq08VBUVwPJiBAont4rKnVzPNx1tAU0J9pA/cs
 sjnot9NoGCYENWaicCyqVMhOSMGQFHQyMfZkLldaa8q60O9QT5/TjEe//FwFcSNeh54Q
 39EPZ8C6fZpL3rkLRv53U135KT4INUSREyBMYbj4EAIq1CzdJsIXAlfrbpueXZvE6cl+
 5zJEWhAkROpY+qu6LkvEIVALIQgYYH/NjphMbNa6pvVMojX+wwTuHLrAwylxLAntg16d
 nQcSOttvSNNKN2DEEL2rbx7E1aXaiHZ/SSbEjEiZu0NqqRfnX1sVg6aY2aqp7Szk1qvI
 cQVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686563674; x=1689155674;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K9vBRHnXqPgwEMrEBl5BKC5DkCDQxRZjJLhBrhwrbHs=;
 b=LvsbOlpu1Eq9WGUd9M8Tl/xM7uXZPBKYWA1WT6SIF3QidUNWjWQtmngXFKe6HqdFsh
 kJTuXRCZ+oHJUuFE27sseSuwV0Qqk7PRFqOpjyNmXko1s3m7MeJ+kgZNe2aAtX8DvRlf
 053Ewf0GR9zq8XwWMa3dr10ylCrXiV19oHvZAHNARWWZraRu+8VeE773CoxbwplI9m/Y
 idj2z6NSRKapq3Y/3lm6jpsE9jHRpSn/CKlrWD5BYX9rzzYKgPBfMF5zwk2kdzxXi2W6
 fwBTNgZWIO/RXNciGt4x32NAJf/3rok5Ug0FFJWX2MSWjBCFf1DoSsGzFHPQksG12hzu
 AGgQ==
X-Gm-Message-State: AC+VfDwc5TvSqHtVqI9aw0etINr6ZoSCYWoM34jnE/psnP411oJd+U+6
 RID4IB1my2ILV3E3+jlrC/b7V+3jsih/gAiaxQo=
X-Google-Smtp-Source: ACHHUZ7h4HsdqnGqK69XPhhhesSwSn31zRGb1Xr940HRQ2g8hdiKcnr8/ikx1uG7mbQcW8FZwUARsQFl/uVmrRJ4bvM=
X-Received: by 2002:a2e:9c50:0:b0:2a7:6e85:e287 with SMTP id
 t16-20020a2e9c50000000b002a76e85e287mr2377501ljj.45.1686563674356; Mon, 12
 Jun 2023 02:54:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230608192345.708062-1-lucas.chollet@free.fr>
In-Reply-To: <20230608192345.708062-1-lucas.chollet@free.fr>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 12 Jun 2023 11:54:19 +0200
Message-ID: <CAJ+F1CK2LE3z8ziTiuN5jEA-Ep-9fs7uRQPoda_ie525uUECWg@mail.gmail.com>
Subject: Re: [PATCH] hw/i386/vmmouse: use the new input api
To: Lucas Chollet <lucas.chollet@free.fr>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000b37fed05fdebb486"
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-lf1-x12d.google.com
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

--000000000000b37fed05fdebb486
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lucas

On Thu, Jun 8, 2023 at 9:49=E2=80=AFPM Lucas Chollet <lucas.chollet@free.fr=
> wrote:

> No functional changes intended.
>
> Signed-off-by: Lucas Chollet <lucas.chollet@free.fr>
> ---
>  hw/i386/vmmouse.c | 95 +++++++++++++++++++++++++++++++++++------------
>  1 file changed, 71 insertions(+), 24 deletions(-)
>

The patch diff isn't great, and there is a risk of regressions. I wonder if
input-legacy is really meant to be deprecated (after 10y it is still
around).

Otherwise, the patch looks ok to me, except some question below:


>
> diff --git a/hw/i386/vmmouse.c b/hw/i386/vmmouse.c
> index a56c185f15..bdddbb64ac 100644
> --- a/hw/i386/vmmouse.c
> +++ b/hw/i386/vmmouse.c
> @@ -24,7 +24,7 @@
>
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
> -#include "ui/console.h"
> +#include "ui/input.h"
>  #include "hw/i386/vmport.h"
>  #include "hw/input/i8042.h"
>  #include "hw/qdev-properties.h"
> @@ -61,7 +61,10 @@ struct VMMouseState {
>      uint16_t nb_queue;
>      uint16_t status;
>      uint8_t absolute;
> -    QEMUPutMouseEntry *entry;
> +    int32_t last_x;
> +    int32_t last_y;
> +    int32_t last_buttons;
> +    QemuInputHandlerState *entry;
>      ISAKBDState *i8042;
>  };
>
> @@ -91,33 +94,72 @@ static uint32_t vmmouse_get_status(VMMouseState *s)
>      return (s->status << 16) | s->nb_queue;
>  }
>
> -static void vmmouse_mouse_event(void *opaque, int x, int y, int dz, int
> buttons_state)
> +static void vmmouse_mouse_event(DeviceState *dev, QemuConsole *src,
> +                                InputEvent *evt)
>  {
> -    VMMouseState *s =3D opaque;
> -    int buttons =3D 0;
> +    static const int bmap[INPUT_BUTTON__MAX] =3D {
> +        [INPUT_BUTTON_LEFT]   =3D 0x20,
> +        [INPUT_BUTTON_MIDDLE] =3D 0x08,
> +        [INPUT_BUTTON_RIGHT]  =3D 0x10,
> +    };
> +
> +    VMMouseState *s =3D VMMOUSE(dev);
> +    InputMoveEvent *move;
> +    InputBtnEvent *btn;
> +
> +    int32_t dz =3D 0;
>
>      if (s->nb_queue > (VMMOUSE_QUEUE_SIZE - 4))
>          return;
>
> -    DPRINTF("vmmouse_mouse_event(%d, %d, %d, %d)\n",
> -            x, y, dz, buttons_state);
> +    switch (evt->type) {
> +    case INPUT_EVENT_KIND_REL:
> +        move =3D evt->u.rel.data;
> +        if (move->axis =3D=3D INPUT_AXIS_X) {
> +            s->last_x +=3D move->value;
> +        } else if (move->axis =3D=3D INPUT_AXIS_Y) {
> +            s->last_y -=3D move->value;
> +        }
> +        break;
>
> -    if ((buttons_state & MOUSE_EVENT_LBUTTON))
> -        buttons |=3D 0x20;
> -    if ((buttons_state & MOUSE_EVENT_RBUTTON))
> -        buttons |=3D 0x10;
> -    if ((buttons_state & MOUSE_EVENT_MBUTTON))
> -        buttons |=3D 0x08;
> +    case INPUT_EVENT_KIND_ABS:
> +        move =3D evt->u.rel.data;
> +        if (move->axis =3D=3D INPUT_AXIS_X) {
> +            s->last_x =3D move->value;
> +        } else if (move->axis =3D=3D INPUT_AXIS_Y) {
> +            s->last_y =3D move->value;
> +        }
> +        break;
>
> -    if (s->absolute) {
> -        x <<=3D 1;
> -        y <<=3D 1;
> +    case INPUT_EVENT_KIND_BTN:
> +        btn =3D evt->u.btn.data;
> +        if (btn->down) {
> +            s->last_buttons |=3D bmap[btn->button];
> +            if (btn->button =3D=3D INPUT_BUTTON_WHEEL_UP) {
> +                dz--;
> +            } else if (btn->button =3D=3D INPUT_BUTTON_WHEEL_DOWN) {
> +                dz++;
> +            }
> +
> +        } else {
> +          s->last_buttons &=3D ~bmap[btn->button];
> +        }
> +        break;
> +
> +    default:
> +        /* keep gcc happy */
> +        break;
>      }
>
> -    s->queue[s->nb_queue++] =3D buttons;
> -    s->queue[s->nb_queue++] =3D x;
> -    s->queue[s->nb_queue++] =3D y;
> +    s->queue[s->nb_queue++] =3D s->last_buttons;
> +    s->queue[s->nb_queue++] =3D s->absolute ? s->last_x << 1 : s->last_x=
;
> +    s->queue[s->nb_queue++] =3D s->absolute ? s->last_y << 1 : s->last_y=
;
>      s->queue[s->nb_queue++] =3D dz;
> +}
> +
> +static void vmmouse_mouse_sync(DeviceState *dev)
> +{
> +    VMMouseState *s =3D VMMOUSE(dev);
>
>      /* need to still generate PS2 events to notify driver to
>         read from queue */
> @@ -127,11 +169,18 @@ static void vmmouse_mouse_event(void *opaque, int x=
,
> int y, int dz, int buttons_
>  static void vmmouse_remove_handler(VMMouseState *s)
>  {
>      if (s->entry) {
> -        qemu_remove_mouse_event_handler(s->entry);
> +        qemu_input_handler_unregister(s->entry);
>          s->entry =3D NULL;
>      }
>  }
>
> +static QemuInputHandler vm_mouse_handler =3D {
> +    .name  =3D "vmmouse",
> +    .mask  =3D INPUT_EVENT_MASK_BTN | INPUT_EVENT_MASK_ABS,
> +    .event =3D vmmouse_mouse_event,
> +    .sync  =3D vmmouse_mouse_sync,
> +};
> +
>  static void vmmouse_update_handler(VMMouseState *s, int absolute)
>  {
>      if (s->status !=3D 0) {
> @@ -142,10 +191,8 @@ static void vmmouse_update_handler(VMMouseState *s,
> int absolute)
>          vmmouse_remove_handler(s);
>      }
>      if (s->entry =3D=3D NULL) {
> -        s->entry =3D qemu_add_mouse_event_handler(vmmouse_mouse_event,
> -                                                s, s->absolute,
> -                                                "vmmouse");
> -        qemu_activate_mouse_event_handler(s->entry);
> +        s->entry =3D qemu_input_handler_register(DEVICE(s),
> &vm_mouse_handler);
>

You don't take "absolute" state into account anymore, so
vm_mouse_handler.mask is always with MASK_ABS. I think this may be
problematic as mouse_mode won't change properly from abs/rel.

+        qemu_input_handler_activate(s->entry);
>      }
>  }
>
> --
> 2.39.2
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000b37fed05fdebb486
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Lucas<br></div><br><div class=3D"gmail=
_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jun 8, 2023 at 9:49=
=E2=80=AFPM Lucas Chollet &lt;<a href=3D"mailto:lucas.chollet@free.fr">luca=
s.chollet@free.fr</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">No functional changes intended.<br>
<br>
Signed-off-by: Lucas Chollet &lt;<a href=3D"mailto:lucas.chollet@free.fr" t=
arget=3D"_blank">lucas.chollet@free.fr</a>&gt;<br>
---<br>
=C2=A0hw/i386/vmmouse.c | 95 +++++++++++++++++++++++++++++++++++-----------=
-<br>
=C2=A01 file changed, 71 insertions(+), 24 deletions(-)<br></blockquote><di=
v><br></div><div>The patch diff isn&#39;t great, and there is a risk of reg=
ressions. I wonder if input-legacy is really meant to be deprecated (after =
10y it is still around).</div><div><br></div><div>Otherwise, the patch look=
s ok to me, except some question below:<br></div><div>=C2=A0<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">
<br>
diff --git a/hw/i386/vmmouse.c b/hw/i386/vmmouse.c<br>
index a56c185f15..bdddbb64ac 100644<br>
--- a/hw/i386/vmmouse.c<br>
+++ b/hw/i386/vmmouse.c<br>
@@ -24,7 +24,7 @@<br>
<br>
=C2=A0#include &quot;qemu/osdep.h&quot;<br>
=C2=A0#include &quot;qapi/error.h&quot;<br>
-#include &quot;ui/console.h&quot;<br>
+#include &quot;ui/input.h&quot;<br>
=C2=A0#include &quot;hw/i386/vmport.h&quot;<br>
=C2=A0#include &quot;hw/input/i8042.h&quot;<br>
=C2=A0#include &quot;hw/qdev-properties.h&quot;<br>
@@ -61,7 +61,10 @@ struct VMMouseState {<br>
=C2=A0 =C2=A0 =C2=A0uint16_t nb_queue;<br>
=C2=A0 =C2=A0 =C2=A0uint16_t status;<br>
=C2=A0 =C2=A0 =C2=A0uint8_t absolute;<br>
-=C2=A0 =C2=A0 QEMUPutMouseEntry *entry;<br>
+=C2=A0 =C2=A0 int32_t last_x;<br>
+=C2=A0 =C2=A0 int32_t last_y;<br>
+=C2=A0 =C2=A0 int32_t last_buttons;<br>
+=C2=A0 =C2=A0 QemuInputHandlerState *entry;<br>
=C2=A0 =C2=A0 =C2=A0ISAKBDState *i8042;<br>
=C2=A0};<br>
<br>
@@ -91,33 +94,72 @@ static uint32_t vmmouse_get_status(VMMouseState *s)<br>
=C2=A0 =C2=A0 =C2=A0return (s-&gt;status &lt;&lt; 16) | s-&gt;nb_queue;<br>
=C2=A0}<br>
<br>
-static void vmmouse_mouse_event(void *opaque, int x, int y, int dz, int bu=
ttons_state)<br>
+static void vmmouse_mouse_event(DeviceState *dev, QemuConsole *src,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InputEvent *evt)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 VMMouseState *s =3D opaque;<br>
-=C2=A0 =C2=A0 int buttons =3D 0;<br>
+=C2=A0 =C2=A0 static const int bmap[INPUT_BUTTON__MAX] =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 [INPUT_BUTTON_LEFT]=C2=A0 =C2=A0=3D 0x20,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 [INPUT_BUTTON_MIDDLE] =3D 0x08,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 [INPUT_BUTTON_RIGHT]=C2=A0 =3D 0x10,<br>
+=C2=A0 =C2=A0 };<br>
+<br>
+=C2=A0 =C2=A0 VMMouseState *s =3D VMMOUSE(dev);<br>
+=C2=A0 =C2=A0 InputMoveEvent *move;<br>
+=C2=A0 =C2=A0 InputBtnEvent *btn;<br>
+<br>
+=C2=A0 =C2=A0 int32_t dz =3D 0;<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (s-&gt;nb_queue &gt; (VMMOUSE_QUEUE_SIZE - 4))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
<br>
-=C2=A0 =C2=A0 DPRINTF(&quot;vmmouse_mouse_event(%d, %d, %d, %d)\n&quot;,<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 x, y, dz, buttons_state);<br>
+=C2=A0 =C2=A0 switch (evt-&gt;type) {<br>
+=C2=A0 =C2=A0 case INPUT_EVENT_KIND_REL:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 move =3D evt-&gt;u.rel.data;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (move-&gt;axis =3D=3D INPUT_AXIS_X) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;last_x +=3D move-&gt;value=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (move-&gt;axis =3D=3D INPUT_AXIS_Y) =
{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;last_y -=3D move-&gt;value=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
<br>
-=C2=A0 =C2=A0 if ((buttons_state &amp; MOUSE_EVENT_LBUTTON))<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 buttons |=3D 0x20;<br>
-=C2=A0 =C2=A0 if ((buttons_state &amp; MOUSE_EVENT_RBUTTON))<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 buttons |=3D 0x10;<br>
-=C2=A0 =C2=A0 if ((buttons_state &amp; MOUSE_EVENT_MBUTTON))<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 buttons |=3D 0x08;<br>
+=C2=A0 =C2=A0 case INPUT_EVENT_KIND_ABS:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 move =3D evt-&gt;u.rel.data;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (move-&gt;axis =3D=3D INPUT_AXIS_X) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;last_x =3D move-&gt;value;=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (move-&gt;axis =3D=3D INPUT_AXIS_Y) =
{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;last_y =3D move-&gt;value;=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
<br>
-=C2=A0 =C2=A0 if (s-&gt;absolute) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 x &lt;&lt;=3D 1;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 y &lt;&lt;=3D 1;<br>
+=C2=A0 =C2=A0 case INPUT_EVENT_KIND_BTN:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 btn =3D evt-&gt;u.btn.data;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (btn-&gt;down) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;last_buttons |=3D bmap[btn=
-&gt;button];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (btn-&gt;button =3D=3D INPUT_=
BUTTON_WHEEL_UP) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dz--;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (btn-&gt;button =3D=3D=
 INPUT_BUTTON_WHEEL_DOWN) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dz++;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;last_buttons &amp;=3D ~bmap[btn-&=
gt;button];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
+=C2=A0 =C2=A0 default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* keep gcc happy */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 s-&gt;queue[s-&gt;nb_queue++] =3D buttons;<br>
-=C2=A0 =C2=A0 s-&gt;queue[s-&gt;nb_queue++] =3D x;<br>
-=C2=A0 =C2=A0 s-&gt;queue[s-&gt;nb_queue++] =3D y;<br>
+=C2=A0 =C2=A0 s-&gt;queue[s-&gt;nb_queue++] =3D s-&gt;last_buttons;<br>
+=C2=A0 =C2=A0 s-&gt;queue[s-&gt;nb_queue++] =3D s-&gt;absolute ? s-&gt;las=
t_x &lt;&lt; 1 : s-&gt;last_x;<br>
+=C2=A0 =C2=A0 s-&gt;queue[s-&gt;nb_queue++] =3D s-&gt;absolute ? s-&gt;las=
t_y &lt;&lt; 1 : s-&gt;last_y;<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;queue[s-&gt;nb_queue++] =3D dz;<br>
+}<br>
+<br>
+static void vmmouse_mouse_sync(DeviceState *dev)<br>
+{<br>
+=C2=A0 =C2=A0 VMMouseState *s =3D VMMOUSE(dev);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* need to still generate PS2 events to notify driver t=
o<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 read from queue */<br>
@@ -127,11 +169,18 @@ static void vmmouse_mouse_event(void *opaque, int x, =
int y, int dz, int buttons_<br>
=C2=A0static void vmmouse_remove_handler(VMMouseState *s)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0if (s-&gt;entry) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_remove_mouse_event_handler(s-&gt;entry);<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_input_handler_unregister(s-&gt;entry);<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;entry =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
+static QemuInputHandler vm_mouse_handler =3D {<br>
+=C2=A0 =C2=A0 .name=C2=A0 =3D &quot;vmmouse&quot;,<br>
+=C2=A0 =C2=A0 .mask=C2=A0 =3D INPUT_EVENT_MASK_BTN | INPUT_EVENT_MASK_ABS,=
<br>
+=C2=A0 =C2=A0 .event =3D vmmouse_mouse_event,<br>
+=C2=A0 =C2=A0 .sync=C2=A0 =3D vmmouse_mouse_sync,<br>
+};<br>
+<br>
=C2=A0static void vmmouse_update_handler(VMMouseState *s, int absolute)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0if (s-&gt;status !=3D 0) {<br>
@@ -142,10 +191,8 @@ static void vmmouse_update_handler(VMMouseState *s, in=
t absolute)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vmmouse_remove_handler(s);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0if (s-&gt;entry =3D=3D NULL) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;entry =3D qemu_add_mouse_event_handler(v=
mmouse_mouse_event,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 s, s-&gt;absolute,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 &quot;vmmouse&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_activate_mouse_event_handler(s-&gt;entry)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;entry =3D qemu_input_handler_register(DE=
VICE(s), &amp;vm_mouse_handler); <br></blockquote><div><br></div><div>You d=
on&#39;t take &quot;absolute&quot; state into account anymore, so vm_mouse_=
handler.mask is always with MASK_ABS. I think this may be problematic as mo=
use_mode won&#39;t change properly from abs/rel.<br></div><div><br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_input_handler_activate(s-&gt;entry);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
-- <br>
2.39.2<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--000000000000b37fed05fdebb486--

