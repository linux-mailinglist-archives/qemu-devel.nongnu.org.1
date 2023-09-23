Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4EA7AC197
	for <lists+qemu-devel@lfdr.de>; Sat, 23 Sep 2023 14:00:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qk1IH-0003jG-3O; Sat, 23 Sep 2023 07:59:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qk1I8-0003hz-H1
 for qemu-devel@nongnu.org; Sat, 23 Sep 2023 07:59:20 -0400
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qk1I6-0005a4-69
 for qemu-devel@nongnu.org; Sat, 23 Sep 2023 07:59:20 -0400
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-4121b5334f3so23934501cf.0
 for <qemu-devel@nongnu.org>; Sat, 23 Sep 2023 04:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695470356; x=1696075156; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XKko8NE0KHhv5DKEPhcWzRY5ySIeEjra3mIVvcTS5Ts=;
 b=g9kleY7hZ3dGdvZHWz/9NdBi8aJgDcMh2MV5o0UVaXuPgDTgB+mqezkGRC3HFjTWBS
 ugfUDQsZfp4zARvMLY4BffW5cHiMBAoU2dFaGACM9i1RvvuulYKdsnxiZagNotxxS+yI
 ThuNR2ui76buUgbfYastpWDyRcHnHwbNeTkaJLhoCp/E2ljpTxlISTwe4eTXteMDqQlB
 fa7QSlc8UVXGBapWaBCLTePLnYghUOqa3a/dXl7WFmexeZrtbguJ58H7jivw+M7GXifr
 Nb+wzPpwBX/7T+q5upnhe2VsOUTHyENdI9wsxvVr/tgQLLfyn2Q+jI/gQOgMLUfCwaBF
 FJ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695470356; x=1696075156;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XKko8NE0KHhv5DKEPhcWzRY5ySIeEjra3mIVvcTS5Ts=;
 b=gWGNIO+yc0xhSvcnUnpkCgQiaolMzvJImcXUHx0Oj2MV2HJgUfSqMWTah7wWuzpob6
 qKjN2kuj0fES9Pb029kswwRAhjwcijFomPouwhP3zvP09vQ6X24w4eNX6v0Q63myAMp6
 Qlz5Z9hXHd5FtRpFNz5zvGIM79TfVDliE9V6/Y9CcHW3GWGRd4m/A+9seZkwEh3oHAIR
 y07bPQn0+IdPDB2nPcsxhzZ4Yg7I0SgQA5vuaMQx0ab1rbxPrLDsmYm3Lv6ciQ8KNbEr
 M57u7r3Vz9s5QpNqjjJYVJHZzob9K0LzkfgJTeKJrfW9uPYcQ3PXFLqG4v00u0W5hLgn
 JWOg==
X-Gm-Message-State: AOJu0YxnJrkCMfrai1jPHmBdzaFoAIIDjYqyG0Oz2M2mvsyVQT8S6fUj
 c6evhdHmvYzpAwxmF3NVCJ5a1MoINcv/SJc3A49/FIykpPU2pA==
X-Google-Smtp-Source: AGHT+IGg+3d6O7i3SDurC+GTSXCBfmOsoyUUPl5Ee0lmGJCMdWtPpl7kq8M0c6v1vfLhi6GNME2Rpd3fl7gDPXcvTCk=
X-Received: by 2002:ac8:7e8c:0:b0:412:2d6d:932a with SMTP id
 w12-20020ac87e8c000000b004122d6d932amr2781204qtj.56.1695470356412; Sat, 23
 Sep 2023 04:59:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230921082936.28100-1-akihiko.odaki@daynix.com>
In-Reply-To: <20230921082936.28100-1-akihiko.odaki@daynix.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sat, 23 Sep 2023 15:59:04 +0400
Message-ID: <CAJ+F1CKCW51M2et++x=fzR0O5xxf_DgPuJ+0ZgyoCdEOPeJ-zA@mail.gmail.com>
Subject: Re: [PATCH v3] input: Allow to choose console with
 qemu_input_is_absolute
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82f;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Thu, Sep 21, 2023 at 12:30=E2=80=AFPM Akihiko Odaki <akihiko.odaki@dayni=
x.com> wrote:
>
> Although an input is routed depending on the console,
> qemu_input_is_absolute() had no mechanism to specify the console.
>
> Accept QemuConsole as an argument for qemu_input_is_absolute, and let
> the display know the absolute/relative state for a particular console.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
> V2 -> V3: Rebased to commit 55394dcbec8f0c29c30e792c102a0edd50a52bf4
> V1 -> V2: Rebased to commit 79b677d658d3d35e1e776826ac4abb28cdce69b8
>
>  include/ui/input.h |  2 +-
>  ui/dbus-console.c  |  6 +++---
>  ui/gtk.c           | 12 ++++++------
>  ui/input.c         | 29 +++++++----------------------
>  ui/sdl2.c          | 26 +++++++++++++-------------
>  ui/spice-input.c   |  2 +-
>  ui/vnc.c           |  2 +-
>  ui/cocoa.m         |  2 +-
>  ui/trace-events    |  1 -
>  9 files changed, 33 insertions(+), 49 deletions(-)
>
> diff --git a/include/ui/input.h b/include/ui/input.h
> index c29a730a71..24d8e4579e 100644
> --- a/include/ui/input.h
> +++ b/include/ui/input.h
> @@ -57,7 +57,7 @@ void qemu_input_queue_btn(QemuConsole *src, InputButton=
 btn, bool down);
>  void qemu_input_update_buttons(QemuConsole *src, uint32_t *button_map,
>                                 uint32_t button_old, uint32_t button_new)=
;
>
> -bool qemu_input_is_absolute(void);
> +bool qemu_input_is_absolute(QemuConsole *con);
>  int qemu_input_scale_axis(int value,
>                            int min_in, int max_in,
>                            int min_out, int max_out);
> diff --git a/ui/dbus-console.c b/ui/dbus-console.c
> index 36f7349585..49da9ccc83 100644
> --- a/ui/dbus-console.c
> +++ b/ui/dbus-console.c
> @@ -386,7 +386,7 @@ dbus_mouse_rel_motion(DBusDisplayConsole *ddc,
>  {
>      trace_dbus_mouse_rel_motion(dx, dy);
>
> -    if (qemu_input_is_absolute()) {
> +    if (qemu_input_is_absolute(ddc->dcl.con)) {
>          g_dbus_method_invocation_return_error(
>              invocation, DBUS_DISPLAY_ERROR,
>              DBUS_DISPLAY_ERROR_INVALID,
> @@ -453,7 +453,7 @@ dbus_mouse_set_pos(DBusDisplayConsole *ddc,
>
>      trace_dbus_mouse_set_pos(x, y);
>
> -    if (!qemu_input_is_absolute()) {
> +    if (!qemu_input_is_absolute(ddc->dcl.con)) {
>          g_dbus_method_invocation_return_error(
>              invocation, DBUS_DISPLAY_ERROR,
>              DBUS_DISPLAY_ERROR_INVALID,
> @@ -514,7 +514,7 @@ static void
>  dbus_mouse_update_is_absolute(DBusDisplayConsole *ddc)
>  {
>      g_object_set(ddc->iface_mouse,
> -                 "is-absolute", qemu_input_is_absolute(),
> +                 "is-absolute", qemu_input_is_absolute(ddc->dcl.con),
>                   NULL);
>  }
>
> diff --git a/ui/gtk.c b/ui/gtk.c
> index e09f97a86b..40b8d27da5 100644
> --- a/ui/gtk.c
> +++ b/ui/gtk.c
> @@ -204,7 +204,7 @@ static void gd_update_cursor(VirtualConsole *vc)
>      }
>
>      window =3D gtk_widget_get_window(GTK_WIDGET(vc->gfx.drawing_area));
> -    if (s->full_screen || qemu_input_is_absolute() || s->ptr_owner =3D=
=3D vc) {
> +    if (s->full_screen || qemu_input_is_absolute(vc->gfx.dcl.con) || s->=
ptr_owner =3D=3D vc) {
>          gdk_window_set_cursor(window, s->null_cursor);
>      } else {
>          gdk_window_set_cursor(window, NULL);
> @@ -453,7 +453,7 @@ static void gd_mouse_set(DisplayChangeListener *dcl,
>      gint x_root, y_root;
>
>      if (!gtk_widget_get_realized(vc->gfx.drawing_area) ||
> -        qemu_input_is_absolute()) {
> +        qemu_input_is_absolute(dcl->con)) {
>          return;
>      }
>
> @@ -689,7 +689,7 @@ static void gd_mouse_mode_change(Notifier *notify, vo=
id *data)
>
>      s =3D container_of(notify, GtkDisplayState, mouse_mode_notifier);
>      /* release the grab at switching to absolute mode */
> -    if (qemu_input_is_absolute() && s->ptr_owner) {
> +    if (s->ptr_owner && qemu_input_is_absolute(s->ptr_owner->gfx.dcl.con=
)) {
>          if (!s->ptr_owner->window) {
>              gtk_check_menu_item_set_active(GTK_CHECK_MENU_ITEM(s->grab_i=
tem),
>                                             FALSE);
> @@ -903,7 +903,7 @@ static gboolean gd_motion_event(GtkWidget *widget, Gd=
kEventMotion *motion,
>      x =3D (motion->x - mx) / vc->gfx.scale_x * ws;
>      y =3D (motion->y - my) / vc->gfx.scale_y * ws;
>
> -    if (qemu_input_is_absolute()) {
> +    if (qemu_input_is_absolute(vc->gfx.dcl.con)) {
>          if (x < 0 || y < 0 ||
>              x >=3D surface_width(vc->gfx.ds) ||
>              y >=3D surface_height(vc->gfx.ds)) {
> @@ -923,7 +923,7 @@ static gboolean gd_motion_event(GtkWidget *widget, Gd=
kEventMotion *motion,
>      s->last_y =3D y;
>      s->last_set =3D TRUE;
>
> -    if (!qemu_input_is_absolute() && s->ptr_owner =3D=3D vc) {
> +    if (!qemu_input_is_absolute(vc->gfx.dcl.con) && s->ptr_owner =3D=3D =
vc) {
>          GdkScreen *screen =3D gtk_widget_get_screen(vc->gfx.drawing_area=
);
>          GdkDisplay *dpy =3D gtk_widget_get_display(widget);
>          GdkWindow *win =3D gtk_widget_get_window(widget);
> @@ -965,7 +965,7 @@ static gboolean gd_button_event(GtkWidget *widget, Gd=
kEventButton *button,
>
>      /* implicitly grab the input at the first click in the relative mode=
 */
>      if (button->button =3D=3D 1 && button->type =3D=3D GDK_BUTTON_PRESS =
&&
> -        !qemu_input_is_absolute() && s->ptr_owner !=3D vc) {
> +        !qemu_input_is_absolute(vc->gfx.dcl.con) && s->ptr_owner !=3D vc=
) {
>          if (!vc->window) {
>              gtk_check_menu_item_set_active(GTK_CHECK_MENU_ITEM(s->grab_i=
tem),
>                                             TRUE);
> diff --git a/ui/input.c b/ui/input.c
> index 1aad64b07c..cbe8573c5c 100644
> --- a/ui/input.c
> +++ b/ui/input.c
> @@ -56,7 +56,7 @@ QemuInputHandlerState *qemu_input_handler_register(Devi=
ceState *dev,
>      s->id =3D id++;
>      QTAILQ_INSERT_TAIL(&handlers, s, node);
>
> -    qemu_input_check_mode_change();
> +    notifier_list_notify(&mouse_mode_notifiers, NULL);
>      return s;
>  }
>
> @@ -64,21 +64,21 @@ void qemu_input_handler_activate(QemuInputHandlerStat=
e *s)
>  {
>      QTAILQ_REMOVE(&handlers, s, node);
>      QTAILQ_INSERT_HEAD(&handlers, s, node);
> -    qemu_input_check_mode_change();
> +    notifier_list_notify(&mouse_mode_notifiers, NULL);
>  }
>
>  void qemu_input_handler_deactivate(QemuInputHandlerState *s)
>  {
>      QTAILQ_REMOVE(&handlers, s, node);
>      QTAILQ_INSERT_TAIL(&handlers, s, node);
> -    qemu_input_check_mode_change();
> +    notifier_list_notify(&mouse_mode_notifiers, NULL);
>  }
>
>  void qemu_input_handler_unregister(QemuInputHandlerState *s)
>  {
>      QTAILQ_REMOVE(&handlers, s, node);
>      g_free(s);
> -    qemu_input_check_mode_change();
> +    notifier_list_notify(&mouse_mode_notifiers, NULL);
>  }
>
>  void qemu_input_handler_bind(QemuInputHandlerState *s,
> @@ -494,12 +494,12 @@ void qemu_input_update_buttons(QemuConsole *src, ui=
nt32_t *button_map,
>      }
>  }
>
> -bool qemu_input_is_absolute(void)
> +bool qemu_input_is_absolute(QemuConsole *con)
>  {
>      QemuInputHandlerState *s;
>
>      s =3D qemu_input_find_handler(INPUT_EVENT_MASK_REL | INPUT_EVENT_MAS=
K_ABS,
> -                                NULL);
> +                                con);
>      return (s !=3D NULL) && (s->handler->mask & INPUT_EVENT_MASK_ABS);
>  }
>
> @@ -583,21 +583,6 @@ void qemu_input_queue_mtt_abs(QemuConsole *src, Inpu=
tAxis axis, int value,
>      qemu_input_event_send(src, &evt);
>  }
>
> -void qemu_input_check_mode_change(void)
> -{
> -    static int current_is_absolute;
> -    int is_absolute;
> -
> -    is_absolute =3D qemu_input_is_absolute();
> -
> -    if (is_absolute !=3D current_is_absolute) {
> -        trace_input_mouse_mode(is_absolute);
> -        notifier_list_notify(&mouse_mode_notifiers, NULL);
> -    }
> -
> -    current_is_absolute =3D is_absolute;
> -}
> -
>  void qemu_add_mouse_mode_change_notifier(Notifier *notify)
>  {
>      notifier_list_add(&mouse_mode_notifiers, notify);
> @@ -657,6 +642,6 @@ bool qemu_mouse_set(int index, Error **errp)
>      }
>
>      qemu_input_handler_activate(s);
> -    qemu_input_check_mode_change();
> +    notifier_list_notify(&mouse_mode_notifiers, NULL);
>      return true;
>  }
> diff --git a/ui/sdl2.c b/ui/sdl2.c
> index 178cc054ab..fbfdb64e90 100644
> --- a/ui/sdl2.c
> +++ b/ui/sdl2.c
> @@ -203,7 +203,7 @@ static void sdl_hide_cursor(struct sdl2_console *scon=
)
>      SDL_ShowCursor(SDL_DISABLE);
>      SDL_SetCursor(sdl_cursor_hidden);
>
> -    if (!qemu_input_is_absolute()) {
> +    if (!qemu_input_is_absolute(scon->dcl.con)) {
>          SDL_SetRelativeMouseMode(SDL_TRUE);
>      }
>  }
> @@ -214,12 +214,12 @@ static void sdl_show_cursor(struct sdl2_console *sc=
on)
>          return;
>      }
>
> -    if (!qemu_input_is_absolute()) {
> +    if (!qemu_input_is_absolute(scon->dcl.con)) {
>          SDL_SetRelativeMouseMode(SDL_FALSE);
>      }
>
>      if (guest_cursor &&
> -        (gui_grab || qemu_input_is_absolute() || absolute_enabled)) {
> +        (gui_grab || qemu_input_is_absolute(scon->dcl.con) || absolute_e=
nabled)) {
>          SDL_SetCursor(guest_sprite);
>      } else {
>          SDL_SetCursor(sdl_cursor_normal);
> @@ -245,7 +245,7 @@ static void sdl_grab_start(struct sdl2_console *scon)
>      }
>      if (guest_cursor) {
>          SDL_SetCursor(guest_sprite);
> -        if (!qemu_input_is_absolute() && !absolute_enabled) {
> +        if (!qemu_input_is_absolute(scon->dcl.con) && !absolute_enabled)=
 {
>              SDL_WarpMouseInWindow(scon->real_window, guest_x, guest_y);
>          }
>      } else {
> @@ -280,7 +280,7 @@ static void absolute_mouse_grab(struct sdl2_console *=
scon)
>
>  static void sdl_mouse_mode_change(Notifier *notify, void *data)
>  {
> -    if (qemu_input_is_absolute()) {
> +    if (qemu_input_is_absolute(sdl2_console[0].dcl.con)) {
>          if (!absolute_enabled) {
>              absolute_enabled =3D 1;
>              SDL_SetRelativeMouseMode(SDL_FALSE);
> @@ -311,7 +311,7 @@ static void sdl_send_mouse_event(struct sdl2_console =
*scon, int dx, int dy,
>          prev_state =3D state;
>      }
>
> -    if (qemu_input_is_absolute()) {
> +    if (qemu_input_is_absolute(scon->dcl.con)) {
>          qemu_input_queue_abs(scon->dcl.con, INPUT_AXIS_X,
>                               x, 0, surface_width(scon->surface));
>          qemu_input_queue_abs(scon->dcl.con, INPUT_AXIS_Y,
> @@ -497,7 +497,7 @@ static void handle_mousemotion(SDL_Event *ev)
>          return;
>      }
>
> -    if (qemu_input_is_absolute() || absolute_enabled) {
> +    if (qemu_input_is_absolute(scon->dcl.con) || absolute_enabled) {
>          int scr_w, scr_h;
>          SDL_GetWindowSize(scon->real_window, &scr_w, &scr_h);
>          max_x =3D scr_w - 1;
> @@ -513,7 +513,7 @@ static void handle_mousemotion(SDL_Event *ev)
>              sdl_grab_start(scon);
>          }
>      }
> -    if (gui_grab || qemu_input_is_absolute() || absolute_enabled) {
> +    if (gui_grab || qemu_input_is_absolute(scon->dcl.con) || absolute_en=
abled) {
>          sdl_send_mouse_event(scon, ev->motion.xrel, ev->motion.yrel,
>                               ev->motion.x, ev->motion.y, ev->motion.stat=
e);
>      }
> @@ -530,7 +530,7 @@ static void handle_mousebutton(SDL_Event *ev)
>      }
>
>      bev =3D &ev->button;
> -    if (!gui_grab && !qemu_input_is_absolute()) {
> +    if (!gui_grab && !qemu_input_is_absolute(scon->dcl.con)) {
>          if (ev->type =3D=3D SDL_MOUSEBUTTONUP && bev->button =3D=3D SDL_=
BUTTON_LEFT) {
>              /* start grabbing all events */
>              sdl_grab_start(scon);
> @@ -603,7 +603,7 @@ static void handle_windowevent(SDL_Event *ev)
>          }
>          /* fall through */
>      case SDL_WINDOWEVENT_ENTER:
> -        if (!gui_grab && (qemu_input_is_absolute() || absolute_enabled))=
 {
> +        if (!gui_grab && (qemu_input_is_absolute(scon->dcl.con) || absol=
ute_enabled)) {
>              absolute_mouse_grab(scon);
>          }
>          /* If a new console window opened using a hotkey receives the
> @@ -733,9 +733,9 @@ static void sdl_mouse_warp(DisplayChangeListener *dcl=
,
>          if (!guest_cursor) {
>              sdl_show_cursor(scon);
>          }
> -        if (gui_grab || qemu_input_is_absolute() || absolute_enabled) {
> +        if (gui_grab || qemu_input_is_absolute(scon->dcl.con) || absolut=
e_enabled) {
>              SDL_SetCursor(guest_sprite);
> -            if (!qemu_input_is_absolute() && !absolute_enabled) {
> +            if (!qemu_input_is_absolute(scon->dcl.con) && !absolute_enab=
led) {
>                  SDL_WarpMouseInWindow(scon->real_window, x, y);
>              }
>          }
> @@ -773,7 +773,7 @@ static void sdl_mouse_define(DisplayChangeListener *d=
cl,
>          return;
>      }
>      if (guest_cursor &&
> -        (gui_grab || qemu_input_is_absolute() || absolute_enabled)) {
> +        (gui_grab || qemu_input_is_absolute(dcl->con) || absolute_enable=
d)) {
>          SDL_SetCursor(guest_sprite);
>      }
>  }
> diff --git a/ui/spice-input.c b/ui/spice-input.c
> index bbd502564e..a5c5d78474 100644
> --- a/ui/spice-input.c
> +++ b/ui/spice-input.c
> @@ -224,7 +224,7 @@ static const SpiceTabletInterface tablet_interface =
=3D {
>  static void mouse_mode_notifier(Notifier *notifier, void *data)
>  {
>      QemuSpicePointer *pointer =3D container_of(notifier, QemuSpicePointe=
r, mouse_mode);
> -    bool is_absolute  =3D qemu_input_is_absolute();
> +    bool is_absolute  =3D qemu_input_is_absolute(NULL);
>
>      if (pointer->absolute =3D=3D is_absolute) {
>          return;
> diff --git a/ui/vnc.c b/ui/vnc.c
> index 6fd86996a5..e2114499d9 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -1771,7 +1771,7 @@ uint32_t read_u32(uint8_t *data, size_t offset)
>  static void check_pointer_type_change(Notifier *notifier, void *data)
>  {
>      VncState *vs =3D container_of(notifier, VncState, mouse_mode_notifie=
r);
> -    int absolute =3D qemu_input_is_absolute();
> +    int absolute =3D qemu_input_is_absolute(vs->vd->dcl.con);
>
>      if (vnc_has_feature(vs, VNC_FEATURE_POINTER_TYPE_CHANGE) && vs->abso=
lute !=3D absolute) {
>          vnc_lock_output(vs);
> diff --git a/ui/cocoa.m b/ui/cocoa.m
> index df6d13be38..145f42d190 100644
> --- a/ui/cocoa.m
> +++ b/ui/cocoa.m
> @@ -2001,7 +2001,7 @@ static void cocoa_refresh(DisplayChangeListener *dc=
l)
>      COCOA_DEBUG("qemu_cocoa: cocoa_refresh\n");
>      graphic_hw_update(NULL);
>
> -    if (qemu_input_is_absolute()) {
> +    if (qemu_input_is_absolute(dcl->con)) {
>          dispatch_async(dispatch_get_main_queue(), ^{
>              if (![cocoaView isAbsoluteEnabled]) {
>                  if ([cocoaView isMouseGrabbed]) {
> diff --git a/ui/trace-events b/ui/trace-events
> index 76b19a2995..16c35c9fd6 100644
> --- a/ui/trace-events
> +++ b/ui/trace-events
> @@ -92,7 +92,6 @@ input_event_rel(int conidx, const char *axis, int value=
) "con %d, axis %s, value
>  input_event_abs(int conidx, const char *axis, int value) "con %d, axis %=
s, value 0x%x"
>  input_event_mtt(int conidx, const char *axis, int value) "con %d, axis %=
s, value 0x%x"
>  input_event_sync(void) ""
> -input_mouse_mode(int absolute) "absolute %d"
>
>  # sdl2-input.c
>  sdl2_process_key(int sdl_scancode, int qcode, const char *action) "trans=
lated SDL scancode %d to QKeyCode %d (%s)"
> --
> 2.41.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

