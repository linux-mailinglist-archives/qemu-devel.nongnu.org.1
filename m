Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C76B72E364
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 14:54:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q93WA-00024q-Gu; Tue, 13 Jun 2023 08:53:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1q93W5-00024Q-Mb
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 08:53:00 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1q93W3-0002gd-5i
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 08:52:57 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2b3424edd5fso1118001fa.0
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 05:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686660772; x=1689252772;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/lJZIc7uxJyxXndyvhMyKZgco672WuoFWRYRiW9/Lsw=;
 b=cg4NAPnrFawuA6fzAgs61VQrJVA5mCiMaSaC/ekwLSXG2pL9nHX1+BLEMpKYaf1qfH
 RYuZDK2wlIMy7ZQ7Zr03j2cqOXPPF8gkBTz906TNDQLicBahYF3vxmsdQeUviSf0r5HQ
 Kopz4aGglKLw2QxZWKxGRJHQsfJMFSEpNYjbvLBF1qGO5k/We7vHhz1nEVYKcocP8XeX
 bnj4FNqTNbZEJT8b7BK25NalJ6BU+RnxZZfAcL0wn8jJ9we2KiM8M7zsHFbPWvqSUex9
 VbTMtcm0piRNmJTQCHyig5a8TFX66Q8kDLj6zj9ZPxpnAtlNrF8QaKWpYSi7kN7hG+Bx
 4sGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686660772; x=1689252772;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/lJZIc7uxJyxXndyvhMyKZgco672WuoFWRYRiW9/Lsw=;
 b=R5ESSqLhHuQFUoHzHhy/HcTpaH5xrp0CWJd6mXiPOx5oJQr8scDO5GpwPnnNghjCGy
 G5Wiz4btw+8V0/NnmlNt34bs2tPo03tFB5N9Rd4O8ms4IsFzGIJjCa8pbU9HUidDg+dm
 Yl4TnyGb8gH0bn5n9KqKkZNiEAU188K4Qba6HLcWUchqCo48l7bYL8mKekbk9fw3If/v
 9uKHfvFnyYxHWh/dOXOHqBFYuS5/ZOz4Zv9rvZDb1tuJMlJjfZBw6PMPWPkWCl+fNMvH
 VGWXnAxUdIzlX0IAzffXROHqBOXc7fJ+6z8wWxRYTaqmDrikQ9bgUX+Z8Xw+CSrjm9SZ
 3YhQ==
X-Gm-Message-State: AC+VfDzasLx/xLOgieKsjSqEt93Rtmsz6HmY7ZAmqHFVoJYm4dmNGjg3
 MNqezPbkHq6vW75kSsmTeX5oqe6csn9GfCrp2vDM2TlhyoQDHzeh
X-Google-Smtp-Source: ACHHUZ5nQ+ZFc+1RSsetj3c4qSzJdsj0VMhrRYj5Net2Fx+BDyH0EjYPp0cs2nDlu31g/zUI9OT4FR007EekOujHj7U=
X-Received: by 2002:a2e:8043:0:b0:2b3:3e19:a047 with SMTP id
 p3-20020a2e8043000000b002b33e19a047mr494692ljg.6.1686660772271; Tue, 13 Jun
 2023 05:52:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230613104535.356842-1-belmouss@redhat.com>
 <20230613104535.356842-2-belmouss@redhat.com>
In-Reply-To: <20230613104535.356842-2-belmouss@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 13 Jun 2023 14:52:35 +0200
Message-ID: <CAJ+F1CKVTMZD8pcz8bn41iU7WZi1oEhBJh34FUYCYbUsAfGQdQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] ui/dbus: Expose a touch device interface
To: Bilal Elmoussaoui <belmouss@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000301d4605fe0250ab"
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-lj1-x234.google.com
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

--000000000000301d4605fe0250ab
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bilal

On Tue, Jun 13, 2023 at 1:39=E2=80=AFPM Bilal Elmoussaoui <belmouss@redhat.=
com>
wrote:

> So that clients making use of the DBus backend could
> send touch events through the new org.qemu.Display1.Touch
> interface
>
> Signed-off-by: Bilal Elmoussaoui <belmouss@redhat.com>
> ---
>  ui/dbus-console.c    | 56 +++++++++++++++++++++++++++++++++++++++++++-
>  ui/dbus-display1.xml | 38 ++++++++++++++++++++++++++++--
>  ui/trace-events      |  1 +
>  3 files changed, 92 insertions(+), 3 deletions(-)
>
> diff --git a/ui/dbus-console.c b/ui/dbus-console.c
> index f77bc49..c744dd3 100644
> --- a/ui/dbus-console.c
> +++ b/ui/dbus-console.c
> @@ -32,6 +32,8 @@
>
>  #include "dbus.h"
>
> +static struct touch_slot touch_slots[INPUT_EVENT_SLOTS_MAX];
> +
>  struct _DBusDisplayConsole {
>      GDBusObjectSkeleton parent_instance;
>      DisplayChangeListener dcl;
> @@ -44,6 +46,7 @@ struct _DBusDisplayConsole {
>      QKbdState *kbd;
>
>      QemuDBusDisplay1Mouse *iface_mouse;
> +    QemuDBusDisplay1Touch *iface_touch;
>      gboolean last_set;
>      guint last_x;
>      guint last_y;
> @@ -345,6 +348,45 @@ dbus_mouse_rel_motion(DBusDisplayConsole *ddc,
>      return DBUS_METHOD_INVOCATION_HANDLED;
>  }
>
> +static gboolean
> +dbus_touch_send_event(DBusDisplayConsole *ddc,
> +                      GDBusMethodInvocation *invocation,
> +                      guint kind, uint64_t num_slot,
> +                      double x, double y)
> +{
> +    int width, height;
> +    gboolean ret;
> +    trace_dbus_touch_send_event(kind, num_slot, x, y);
> +
> +    if (kind !=3D INPUT_MULTI_TOUCH_TYPE_BEGIN &&
> +        kind !=3D INPUT_MULTI_TOUCH_TYPE_UPDATE &&
> +        kind !=3D INPUT_MULTI_TOUCH_TYPE_CANCEL &&
> +        kind !=3D INPUT_MULTI_TOUCH_TYPE_END)
> +    {
> +        g_dbus_method_invocation_return_error(
> +            invocation, DBUS_DISPLAY_ERROR,
> +            DBUS_DISPLAY_ERROR_INVALID,
> +            "Invalid touch event kind");
> +        return DBUS_METHOD_INVOCATION_HANDLED;
> +    }
> +    width =3D qemu_console_get_width(ddc->dcl.con, 0);
> +    height =3D qemu_console_get_height(ddc->dcl.con, 0);
> +
> +    ret =3D console_handle_touch_event(ddc->dcl.con, touch_slots,
> +                                     num_slot, width, height,
> +                                     x, y, kind);
> +    if (!ret) {
>

+        g_dbus_method_invocation_return_error(
>
> +            invocation, DBUS_DISPLAY_ERROR,
> +            DBUS_DISPLAY_ERROR_INVALID,
> +            "Unexpected touch slot number");
>

With Error* usage, we won't have to "guess" the error


>
>

> +    } else {
> +        qemu_dbus_display1_touch_complete_send_event(ddc->iface_touch,
> +                                                     invocation);
> +    }
> +    return DBUS_METHOD_INVOCATION_HANDLED;
> +}
> +
>  static gboolean
>  dbus_mouse_set_pos(DBusDisplayConsole *ddc,
>                     GDBusMethodInvocation *invocation,
> @@ -440,7 +482,7 @@ dbus_display_console_new(DBusDisplay *display,
> QemuConsole *con)
>      g_autofree char *label =3D NULL;
>      char device_addr[256] =3D "";
>      DBusDisplayConsole *ddc;
> -    int idx;
> +    int idx, i;
>
>      assert(display);
>      assert(con);
> @@ -495,6 +537,18 @@ dbus_display_console_new(DBusDisplay *display,
> QemuConsole *con)
>      g_dbus_object_skeleton_add_interface(G_DBUS_OBJECT_SKELETON(ddc),
>          G_DBUS_INTERFACE_SKELETON(ddc->iface_mouse));
>
> +    ddc->iface_touch =3D qemu_dbus_display1_touch_skeleton_new();
> +    g_object_connect(ddc->iface_touch,
> +        "swapped-signal::handle-send-event", dbus_touch_send_event, ddc,
> +        NULL);
> +    g_dbus_object_skeleton_add_interface(G_DBUS_OBJECT_SKELETON(ddc),
> +        G_DBUS_INTERFACE_SKELETON(ddc->iface_touch));
> +
> +    for (i =3D 0; i < INPUT_EVENT_SLOTS_MAX; i++) {
> +        struct touch_slot *slot =3D &touch_slots[i];
> +        slot->tracking_id =3D -1;
> +    }
> +
>      register_displaychangelistener(&ddc->dcl);
>      ddc->mouse_mode_notifier.notify =3D dbus_mouse_mode_change;
>      qemu_add_mouse_mode_change_notifier(&ddc->mouse_mode_notifier);
> diff --git a/ui/dbus-display1.xml b/ui/dbus-display1.xml
> index c3b2293..ef30ab3 100644
> --- a/ui/dbus-display1.xml
> +++ b/ui/dbus-display1.xml
> @@ -39,8 +39,9 @@
>        "Text" (see :dbus:prop:`Type` and other properties).
>
>        Interactions with a console may be done with
> -      :dbus:iface:`org.qemu.Display1.Keyboard` and
> -      :dbus:iface:`org.qemu.Display1.Mouse` interfaces when available.
> +      :dbus:iface:`org.qemu.Display1.Keyboard`,
> +      :dbus:iface:`org.qemu.Display1.Mouse` and
> +      :dbus:iface:`org.qemu.Display1.Touch` interfaces when available.
>    -->
>    <interface name=3D"org.qemu.Display1.Console">
>      <!--
> @@ -236,6 +237,39 @@
>      <property name=3D"IsAbsolute" type=3D"b" access=3D"read"/>
>    </interface>
>
> +  <!--
> +      org.qemu.Display1.Touch:
> +
> +      This interface in implemented on ``/org/qemu/Display1/Console_$id`=
`
> (see
> +      :dbus:iface:`~org.qemu.Display1.Console` documentation).
> +
> +      .. _dbus-kind-values:
> +
> +      **Kind values**::
> +
> +        Begin       =3D 0
> +        Update      =3D 1
> +        End         =3D 2
> +        Cancel      =3D 3
> +  -->
> +  <interface name=3D"org.qemu.Display1.Touch">
> +    <!--
> +        SendEvent:
> +        @kind: The touch event kind
> +        @num_slot: The slot number.
> +        @x: The x coordinates.
> +        @y: The y coordinates.
> +
> +        Send a touch gesture event.
> +    -->
> +    <method name=3D"SendEvent">
> +      <arg type=3D"u" name=3D"kind" direction=3D"in"/>
> +      <arg type=3D"t" name=3D"num_slot" direction=3D"in"/>
> +      <arg type=3D"d" name=3D"x" direction=3D"in"/>
> +      <arg type=3D"d" name=3D"y" direction=3D"in"/>
> +    </method>
>

We should expose a max-slots property.

+  </interface>
> +
>    <!--
>        org.qemu.Display1.Listener:
>
> diff --git a/ui/trace-events b/ui/trace-events
> index 6747361..138a09c 100644
> --- a/ui/trace-events
> +++ b/ui/trace-events
> @@ -154,6 +154,7 @@ dbus_mouse_press(unsigned int button) "button %u"
>  dbus_mouse_release(unsigned int button) "button %u"
>  dbus_mouse_set_pos(unsigned int x, unsigned int y) "x=3D%u, y=3D%u"
>  dbus_mouse_rel_motion(int dx, int dy) "dx=3D%d, dy=3D%d"
> +dbus_touch_send_event(unsigned int kind, uint32_t num_slot, uint32_t x,
> uint32_t y) "kind=3D%u, num_slot=3D%u, x=3D%d, y=3D%d"
>  dbus_update(int x, int y, int w, int h) "x=3D%d, y=3D%d, w=3D%d, h=3D%d"
>  dbus_clipboard_grab_failed(void) ""
>  dbus_clipboard_register(const char *bus_name) "peer %s"
> --
> 2.40.1
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000301d4605fe0250ab
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Bilal<br></div><br><div class=3D"gmail=
_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jun 13, 2023 at 1:39=
=E2=80=AFPM Bilal Elmoussaoui &lt;<a href=3D"mailto:belmouss@redhat.com">be=
lmouss@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">So that clients making use of the DBus backend could<br>
send touch events through the new org.qemu.Display1.Touch<br>
interface<br>
<br>
Signed-off-by: Bilal Elmoussaoui &lt;<a href=3D"mailto:belmouss@redhat.com"=
 target=3D"_blank">belmouss@redhat.com</a>&gt;<br>
---<br>
=C2=A0ui/dbus-console.c=C2=A0 =C2=A0 | 56 +++++++++++++++++++++++++++++++++=
++++++++++-<br>
=C2=A0ui/dbus-display1.xml | 38 ++++++++++++++++++++++++++++--<br>
=C2=A0ui/trace-events=C2=A0 =C2=A0 =C2=A0 |=C2=A0 1 +<br>
=C2=A03 files changed, 92 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/ui/dbus-console.c b/ui/dbus-console.c<br>
index f77bc49..c744dd3 100644<br>
--- a/ui/dbus-console.c<br>
+++ b/ui/dbus-console.c<br>
@@ -32,6 +32,8 @@<br>
<br>
=C2=A0#include &quot;dbus.h&quot;<br>
<br>
+static struct touch_slot touch_slots[INPUT_EVENT_SLOTS_MAX];<br>
+<br>
=C2=A0struct _DBusDisplayConsole {<br>
=C2=A0 =C2=A0 =C2=A0GDBusObjectSkeleton parent_instance;<br>
=C2=A0 =C2=A0 =C2=A0DisplayChangeListener dcl;<br>
@@ -44,6 +46,7 @@ struct _DBusDisplayConsole {<br>
=C2=A0 =C2=A0 =C2=A0QKbdState *kbd;<br>
<br>
=C2=A0 =C2=A0 =C2=A0QemuDBusDisplay1Mouse *iface_mouse;<br>
+=C2=A0 =C2=A0 QemuDBusDisplay1Touch *iface_touch;<br>
=C2=A0 =C2=A0 =C2=A0gboolean last_set;<br>
=C2=A0 =C2=A0 =C2=A0guint last_x;<br>
=C2=A0 =C2=A0 =C2=A0guint last_y;<br>
@@ -345,6 +348,45 @@ dbus_mouse_rel_motion(DBusDisplayConsole *ddc,<br>
=C2=A0 =C2=A0 =C2=A0return DBUS_METHOD_INVOCATION_HANDLED;<br>
=C2=A0}<br>
<br>
+static gboolean<br>
+dbus_touch_send_event(DBusDisplayConsole *ddc,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 GDBusMethodInvocation *invocation,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 guint kind, uint64_t num_slot,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 double x, double y)<br>
+{<br>
+=C2=A0 =C2=A0 int width, height;<br>
+=C2=A0 =C2=A0 gboolean ret;<br>
+=C2=A0 =C2=A0 trace_dbus_touch_send_event(kind, num_slot, x, y);<br>
+<br>
+=C2=A0 =C2=A0 if (kind !=3D INPUT_MULTI_TOUCH_TYPE_BEGIN &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 kind !=3D INPUT_MULTI_TOUCH_TYPE_UPDATE &amp;&=
amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 kind !=3D INPUT_MULTI_TOUCH_TYPE_CANCEL &amp;&=
amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 kind !=3D INPUT_MULTI_TOUCH_TYPE_END)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_dbus_method_invocation_return_error(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 invocation, DBUS_DISPLAY_ERROR,<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DBUS_DISPLAY_ERROR_INVALID,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Invalid touch event kind&q=
uot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return DBUS_METHOD_INVOCATION_HANDLED;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 width =3D qemu_console_get_width(ddc-&gt;dcl.con, 0);<br>
+=C2=A0 =C2=A0 height =3D qemu_console_get_height(ddc-&gt;dcl.con, 0);<br>
+<br>
+=C2=A0 =C2=A0 ret =3D console_handle_touch_event(ddc-&gt;dcl.con, touch_sl=
ots,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0num_slot, width,=
 height,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0x, y, kind);<br>
+=C2=A0 =C2=A0 if (!ret) {<br>
</blockquote><div><br></div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_dbus_method_invo=
cation_return_error(<blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 invocation, DBUS_DISPLAY_ERROR,<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DBUS_DISPLAY_ERROR_INVALID,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Unexpected touch slot numb=
er&quot;);<br>
</blockquote><div><div><br></div><div>With Error* usage, we won&#39;t have =
to &quot;guess&quot; the error<br></div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex"><br></blockquote></div><div>=C2=A0</div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_dbus_display1_touch_complete_send_event(d=
dc-&gt;iface_touch,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0invocation);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 return DBUS_METHOD_INVOCATION_HANDLED;<br>
+}<br>
+<br>
=C2=A0static gboolean<br>
=C2=A0dbus_mouse_set_pos(DBusDisplayConsole *ddc,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GDBus=
MethodInvocation *invocation,<br>
@@ -440,7 +482,7 @@ dbus_display_console_new(DBusDisplay *display, QemuCons=
ole *con)<br>
=C2=A0 =C2=A0 =C2=A0g_autofree char *label =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0char device_addr[256] =3D &quot;&quot;;<br>
=C2=A0 =C2=A0 =C2=A0DBusDisplayConsole *ddc;<br>
-=C2=A0 =C2=A0 int idx;<br>
+=C2=A0 =C2=A0 int idx, i;<br>
<br>
=C2=A0 =C2=A0 =C2=A0assert(display);<br>
=C2=A0 =C2=A0 =C2=A0assert(con);<br>
@@ -495,6 +537,18 @@ dbus_display_console_new(DBusDisplay *display, QemuCon=
sole *con)<br>
=C2=A0 =C2=A0 =C2=A0g_dbus_object_skeleton_add_interface(G_DBUS_OBJECT_SKEL=
ETON(ddc),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0G_DBUS_INTERFACE_SKELETON(ddc-&gt;iface_m=
ouse));<br>
<br>
+=C2=A0 =C2=A0 ddc-&gt;iface_touch =3D qemu_dbus_display1_touch_skeleton_ne=
w();<br>
+=C2=A0 =C2=A0 g_object_connect(ddc-&gt;iface_touch,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;swapped-signal::handle-send-event&quot;,=
 dbus_touch_send_event, ddc,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL);<br>
+=C2=A0 =C2=A0 g_dbus_object_skeleton_add_interface(G_DBUS_OBJECT_SKELETON(=
ddc),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 G_DBUS_INTERFACE_SKELETON(ddc-&gt;iface_touch)=
);<br>
+<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; INPUT_EVENT_SLOTS_MAX; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct touch_slot *slot =3D &amp;touch_slots[i=
];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 slot-&gt;tracking_id =3D -1;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0register_displaychangelistener(&amp;ddc-&gt;dcl);<br>
=C2=A0 =C2=A0 =C2=A0ddc-&gt;mouse_mode_notifier.notify =3D dbus_mouse_mode_=
change;<br>
=C2=A0 =C2=A0 =C2=A0qemu_add_mouse_mode_change_notifier(&amp;ddc-&gt;mouse_=
mode_notifier);<br>
diff --git a/ui/dbus-display1.xml b/ui/dbus-display1.xml<br>
index c3b2293..ef30ab3 100644<br>
--- a/ui/dbus-display1.xml<br>
+++ b/ui/dbus-display1.xml<br>
@@ -39,8 +39,9 @@<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;Text&quot; (see :dbus:prop:`Type` and othe=
r properties).<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0Interactions with a console may be done with<br>
-=C2=A0 =C2=A0 =C2=A0 :dbus:iface:`org.qemu.Display1.Keyboard` and<br>
-=C2=A0 =C2=A0 =C2=A0 :dbus:iface:`org.qemu.Display1.Mouse` interfaces when=
 available.<br>
+=C2=A0 =C2=A0 =C2=A0 :dbus:iface:`org.qemu.Display1.Keyboard`,<br>
+=C2=A0 =C2=A0 =C2=A0 :dbus:iface:`org.qemu.Display1.Mouse` and<br>
+=C2=A0 =C2=A0 =C2=A0 :dbus:iface:`org.qemu.Display1.Touch` interfaces when=
 available.<br>
=C2=A0 =C2=A0--&gt;<br>
=C2=A0 =C2=A0&lt;interface name=3D&quot;org.qemu.Display1.Console&quot;&gt;=
<br>
=C2=A0 =C2=A0 =C2=A0&lt;!--<br>
@@ -236,6 +237,39 @@<br>
=C2=A0 =C2=A0 =C2=A0&lt;property name=3D&quot;IsAbsolute&quot; type=3D&quot=
;b&quot; access=3D&quot;read&quot;/&gt;<br>
=C2=A0 =C2=A0&lt;/interface&gt;<br>
<br>
+=C2=A0 &lt;!--<br>
+=C2=A0 =C2=A0 =C2=A0 org.qemu.Display1.Touch:<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 This interface in implemented on ``/org/qemu/Display1=
/Console_$id`` (see<br>
+=C2=A0 =C2=A0 =C2=A0 :dbus:iface:`~org.qemu.Display1.Console` documentatio=
n).<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 .. _dbus-kind-values:<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 **Kind values**::<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Begin=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 0<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Update=C2=A0 =C2=A0 =C2=A0 =3D 1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 End=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 2<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Cancel=C2=A0 =C2=A0 =C2=A0 =3D 3<br>
+=C2=A0 --&gt;<br>
+=C2=A0 &lt;interface name=3D&quot;org.qemu.Display1.Touch&quot;&gt;<br>
+=C2=A0 =C2=A0 &lt;!--<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 SendEvent:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 @kind: The touch event kind<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 @num_slot: The slot number.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 @x: The x coordinates.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 @y: The y coordinates.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Send a touch gesture event.<br>
+=C2=A0 =C2=A0 --&gt;<br>
+=C2=A0 =C2=A0 &lt;method name=3D&quot;SendEvent&quot;&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;arg type=3D&quot;u&quot; name=3D&quot;kind&quot; =
direction=3D&quot;in&quot;/&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;arg type=3D&quot;t&quot; name=3D&quot;num_slot&qu=
ot; direction=3D&quot;in&quot;/&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;arg type=3D&quot;d&quot; name=3D&quot;x&quot; dir=
ection=3D&quot;in&quot;/&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;arg type=3D&quot;d&quot; name=3D&quot;y&quot; dir=
ection=3D&quot;in&quot;/&gt;<br>
+=C2=A0 =C2=A0 &lt;/method&gt;<br></blockquote><div><br></div><div>We shoul=
d expose a max-slots property.</div><div><br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">
+=C2=A0 &lt;/interface&gt;<br>
+<br>
=C2=A0 =C2=A0&lt;!--<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0org.qemu.Display1.Listener:<br>
<br>
diff --git a/ui/trace-events b/ui/trace-events<br>
index 6747361..138a09c 100644<br>
--- a/ui/trace-events<br>
+++ b/ui/trace-events<br>
@@ -154,6 +154,7 @@ dbus_mouse_press(unsigned int button) &quot;button %u&q=
uot;<br>
=C2=A0dbus_mouse_release(unsigned int button) &quot;button %u&quot;<br>
=C2=A0dbus_mouse_set_pos(unsigned int x, unsigned int y) &quot;x=3D%u, y=3D=
%u&quot;<br>
=C2=A0dbus_mouse_rel_motion(int dx, int dy) &quot;dx=3D%d, dy=3D%d&quot;<br=
>
+dbus_touch_send_event(unsigned int kind, uint32_t num_slot, uint32_t x, ui=
nt32_t y) &quot;kind=3D%u, num_slot=3D%u, x=3D%d, y=3D%d&quot;<br>
=C2=A0dbus_update(int x, int y, int w, int h) &quot;x=3D%d, y=3D%d, w=3D%d,=
 h=3D%d&quot;<br>
=C2=A0dbus_clipboard_grab_failed(void) &quot;&quot;<br>
=C2=A0dbus_clipboard_register(const char *bus_name) &quot;peer %s&quot;<br>
-- <br>
2.40.1<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--000000000000301d4605fe0250ab--

