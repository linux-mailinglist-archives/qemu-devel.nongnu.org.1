Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 969EA7CC4CB
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 15:33:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qskBn-0002Qu-7f; Tue, 17 Oct 2023 09:32:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qskBj-0002Na-M4
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 09:32:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qskBg-0001oi-9V
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 09:32:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697549562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RnAjHPCtvpada5g6xexifMtMc7c621wwFdrDkXtr44M=;
 b=hMfcVNpP6RgN03OeLMNedgHRSI2bjFskUmf/FBXKORdre7biBHe7QGMOTOh1TyoZRLHcVs
 esv+QtGBpw6/ofe0W5EP2C3bAMCh/ZGHP6T3EDHWSf+YkgWpHxHbGj/SCecZT7iToUxack
 XAPBGf1+FjMRj+AwAPf1GHtxO9WIb+Y=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-294-lhTzw5dwMt66BUMKXI_qUA-1; Tue, 17 Oct 2023 09:32:40 -0400
X-MC-Unique: lhTzw5dwMt66BUMKXI_qUA-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5344aaf2703so4414730a12.0
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 06:32:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697549559; x=1698154359;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RnAjHPCtvpada5g6xexifMtMc7c621wwFdrDkXtr44M=;
 b=XIC3V8heaTzMapmcfVRoOgJANoXoevv2U5qjKLy3QyPzllM9guG7431+dKifTMOsdz
 tfMIsncZ60k6sRGNqPu6jE1UiW30AteERq+AlX+uwIoBkf8/SueYO2uEIvDh1jMUl1bq
 3lbVvkgw14RbEhtyC19xVaqqOe315Tiix+QlWSlmikx/J+LN0CsJG85huTAMUGQNOlvW
 ukKtbm93fsvKtaRuRU70GQQi+BI5JLz2LTkNxnWPXX4bZRoHW1V/Aohzk7RSIiEFggmW
 06diD2hciXYgH6BbIGVpfoIdPLs/ItflY40p9j5QVfo0539N8FDI/+m0ShtcIldtLyTB
 6/fg==
X-Gm-Message-State: AOJu0YxTSOmcvNgnsAlSXvAKWfKMDlqnQleN9XjQ798qNyW/KZKZXi/5
 4irdYspCS3d6+aC3gonVuoDcBQzFqVdonXUHtuVXYUoU0/I1TyZNKO+Tzi+01QsUJ25w0oJH28Y
 EF76ij4hkh0wALmJM0mK5cbOxSW2RP5A=
X-Received: by 2002:a50:d59d:0:b0:53f:25c4:357b with SMTP id
 v29-20020a50d59d000000b0053f25c4357bmr916171edi.4.1697549559257; 
 Tue, 17 Oct 2023 06:32:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE76Oi8to2BgfUxjSB0lsc/TQQ702YBKQHGt8xXJ9CSzy3oS07a/kmDA26uONAYXladps8VAlENH4TI4rm7F+4=
X-Received: by 2002:a50:d59d:0:b0:53f:25c4:357b with SMTP id
 v29-20020a50d59d000000b0053f25c4357bmr916157edi.4.1697549558880; Tue, 17 Oct
 2023 06:32:38 -0700 (PDT)
MIME-Version: 1.0
References: <20231017131251.43708-1-philmd@linaro.org>
In-Reply-To: <20231017131251.43708-1-philmd@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 17 Oct 2023 17:32:27 +0400
Message-ID: <CAMxuvazWSrZHMDqbJZ36CX1WsoWvZh+C0UeGrw=PvME5LUHtpQ@mail.gmail.com>
Subject: Re: [PATCH] ui/input: Constify QemuInputHandler structure
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 xen-devel@lists.xenproject.org, 
 Stefano Stabellini <sstabellini@kernel.org>, qemu-ppc@nongnu.org,
 Paul Durrant <paul@xen.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Song Gao <gaosong@loongson.cn>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Anthony Perard <anthony.perard@citrix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Oct 17, 2023 at 5:13=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Access to QemuInputHandlerState::handler are read-only.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  include/hw/virtio/virtio-input.h | 2 +-
>  include/ui/input.h               | 2 +-
>  chardev/msmouse.c                | 2 +-
>  chardev/wctablet.c               | 2 +-
>  hw/char/escc.c                   | 2 +-
>  hw/display/xenfb.c               | 6 +++---
>  hw/input/adb-kbd.c               | 2 +-
>  hw/input/hid.c                   | 6 +++---
>  hw/input/ps2.c                   | 4 ++--
>  hw/input/virtio-input-hid.c      | 8 ++++----
>  ui/input-legacy.c                | 2 +-
>  ui/input.c                       | 4 ++--
>  ui/vdagent.c                     | 2 +-
>  13 files changed, 22 insertions(+), 22 deletions(-)
>
> diff --git a/include/hw/virtio/virtio-input.h b/include/hw/virtio/virtio-=
input.h
> index 08f1591424..a6c9703644 100644
> --- a/include/hw/virtio/virtio-input.h
> +++ b/include/hw/virtio/virtio-input.h
> @@ -84,7 +84,7 @@ struct VirtIOInputHID {
>      VirtIOInput                       parent_obj;
>      char                              *display;
>      uint32_t                          head;
> -    QemuInputHandler                  *handler;
> +    const QemuInputHandler            *handler;
>      QemuInputHandlerState             *hs;
>      int                               ledstate;
>      bool                              wheel_axis;
> diff --git a/include/ui/input.h b/include/ui/input.h
> index 24d8e4579e..8f9aac562e 100644
> --- a/include/ui/input.h
> +++ b/include/ui/input.h
> @@ -30,7 +30,7 @@ struct QemuInputHandler {
>  };
>
>  QemuInputHandlerState *qemu_input_handler_register(DeviceState *dev,
> -                                                   QemuInputHandler *han=
dler);
> +                                            const QemuInputHandler *hand=
ler);
>  void qemu_input_handler_activate(QemuInputHandlerState *s);
>  void qemu_input_handler_deactivate(QemuInputHandlerState *s);
>  void qemu_input_handler_unregister(QemuInputHandlerState *s);
> diff --git a/chardev/msmouse.c b/chardev/msmouse.c
> index ab8fe981d6..a774c397b4 100644
> --- a/chardev/msmouse.c
> +++ b/chardev/msmouse.c
> @@ -171,7 +171,7 @@ static int msmouse_chr_write(struct Chardev *s, const=
 uint8_t *buf, int len)
>      return len;
>  }
>
> -static QemuInputHandler msmouse_handler =3D {
> +static const QemuInputHandler msmouse_handler =3D {
>      .name  =3D "QEMU Microsoft Mouse",
>      .mask  =3D INPUT_EVENT_MASK_BTN | INPUT_EVENT_MASK_REL,
>      .event =3D msmouse_input_event,
> diff --git a/chardev/wctablet.c b/chardev/wctablet.c
> index 43bdf6b608..f4008bf35b 100644
> --- a/chardev/wctablet.c
> +++ b/chardev/wctablet.c
> @@ -178,7 +178,7 @@ static void wctablet_input_sync(DeviceState *dev)
>      }
>  }
>
> -static QemuInputHandler wctablet_handler =3D {
> +static const QemuInputHandler wctablet_handler =3D {
>      .name  =3D "QEMU Wacom Pen Tablet",
>      .mask  =3D INPUT_EVENT_MASK_BTN | INPUT_EVENT_MASK_ABS,
>      .event =3D wctablet_input_event,
> diff --git a/hw/char/escc.c b/hw/char/escc.c
> index 4be66053c1..48b30ee760 100644
> --- a/hw/char/escc.c
> +++ b/hw/char/escc.c
> @@ -845,7 +845,7 @@ static void sunkbd_handle_event(DeviceState *dev, Qem=
uConsole *src,
>      put_queue(s, keycode);
>  }
>
> -static QemuInputHandler sunkbd_handler =3D {
> +static const QemuInputHandler sunkbd_handler =3D {
>      .name  =3D "sun keyboard",
>      .mask  =3D INPUT_EVENT_MASK_KEY,
>      .event =3D sunkbd_handle_event,
> diff --git a/hw/display/xenfb.c b/hw/display/xenfb.c
> index 0074a9b6f8..b2130a0d70 100644
> --- a/hw/display/xenfb.c
> +++ b/hw/display/xenfb.c
> @@ -321,20 +321,20 @@ static void xenfb_mouse_sync(DeviceState *dev)
>      xenfb->wheel =3D 0;
>  }
>
> -static QemuInputHandler xenfb_keyboard =3D {
> +static const QemuInputHandler xenfb_keyboard =3D {
>      .name  =3D "Xen PV Keyboard",
>      .mask  =3D INPUT_EVENT_MASK_KEY,
>      .event =3D xenfb_key_event,
>  };
>
> -static QemuInputHandler xenfb_abs_mouse =3D {
> +static const QemuInputHandler xenfb_abs_mouse =3D {
>      .name  =3D "Xen PV Mouse",
>      .mask  =3D INPUT_EVENT_MASK_BTN | INPUT_EVENT_MASK_ABS,
>      .event =3D xenfb_mouse_event,
>      .sync  =3D xenfb_mouse_sync,
>  };
>
> -static QemuInputHandler xenfb_rel_mouse =3D {
> +static const QemuInputHandler xenfb_rel_mouse =3D {
>      .name  =3D "Xen PV Mouse",
>      .mask  =3D INPUT_EVENT_MASK_BTN | INPUT_EVENT_MASK_REL,
>      .event =3D xenfb_mouse_event,
> diff --git a/hw/input/adb-kbd.c b/hw/input/adb-kbd.c
> index a9088c910c..e21edf9acd 100644
> --- a/hw/input/adb-kbd.c
> +++ b/hw/input/adb-kbd.c
> @@ -355,7 +355,7 @@ static void adb_kbd_reset(DeviceState *dev)
>      s->count =3D 0;
>  }
>
> -static QemuInputHandler adb_keyboard_handler =3D {
> +static const QemuInputHandler adb_keyboard_handler =3D {
>      .name  =3D "QEMU ADB Keyboard",
>      .mask  =3D INPUT_EVENT_MASK_KEY,
>      .event =3D adb_keyboard_event,
> diff --git a/hw/input/hid.c b/hw/input/hid.c
> index a9c7dd1ce1..b8e85374ca 100644
> --- a/hw/input/hid.c
> +++ b/hw/input/hid.c
> @@ -510,20 +510,20 @@ void hid_free(HIDState *hs)
>      hid_del_idle_timer(hs);
>  }
>
> -static QemuInputHandler hid_keyboard_handler =3D {
> +static const QemuInputHandler hid_keyboard_handler =3D {
>      .name  =3D "QEMU HID Keyboard",
>      .mask  =3D INPUT_EVENT_MASK_KEY,
>      .event =3D hid_keyboard_event,
>  };
>
> -static QemuInputHandler hid_mouse_handler =3D {
> +static const QemuInputHandler hid_mouse_handler =3D {
>      .name  =3D "QEMU HID Mouse",
>      .mask  =3D INPUT_EVENT_MASK_BTN | INPUT_EVENT_MASK_REL,
>      .event =3D hid_pointer_event,
>      .sync  =3D hid_pointer_sync,
>  };
>
> -static QemuInputHandler hid_tablet_handler =3D {
> +static const QemuInputHandler hid_tablet_handler =3D {
>      .name  =3D "QEMU HID Tablet",
>      .mask  =3D INPUT_EVENT_MASK_BTN | INPUT_EVENT_MASK_ABS,
>      .event =3D hid_pointer_event,
> diff --git a/hw/input/ps2.c b/hw/input/ps2.c
> index 45af76a837..c8fd23cf36 100644
> --- a/hw/input/ps2.c
> +++ b/hw/input/ps2.c
> @@ -1231,7 +1231,7 @@ static const VMStateDescription vmstate_ps2_mouse =
=3D {
>      }
>  };
>
> -static QemuInputHandler ps2_keyboard_handler =3D {
> +static const QemuInputHandler ps2_keyboard_handler =3D {
>      .name  =3D "QEMU PS/2 Keyboard",
>      .mask  =3D INPUT_EVENT_MASK_KEY,
>      .event =3D ps2_keyboard_event,
> @@ -1242,7 +1242,7 @@ static void ps2_kbd_realize(DeviceState *dev, Error=
 **errp)
>      qemu_input_handler_register(dev, &ps2_keyboard_handler);
>  }
>
> -static QemuInputHandler ps2_mouse_handler =3D {
> +static const QemuInputHandler ps2_mouse_handler =3D {
>      .name  =3D "QEMU PS/2 Mouse",
>      .mask  =3D INPUT_EVENT_MASK_BTN | INPUT_EVENT_MASK_REL,
>      .event =3D ps2_mouse_event,
> diff --git a/hw/input/virtio-input-hid.c b/hw/input/virtio-input-hid.c
> index 7053ad72d4..45e4d4c75d 100644
> --- a/hw/input/virtio-input-hid.c
> +++ b/hw/input/virtio-input-hid.c
> @@ -265,7 +265,7 @@ static const TypeInfo virtio_input_hid_info =3D {
>
>  /* ----------------------------------------------------------------- */
>
> -static QemuInputHandler virtio_keyboard_handler =3D {
> +static const QemuInputHandler virtio_keyboard_handler =3D {
>      .name  =3D VIRTIO_ID_NAME_KEYBOARD,
>      .mask  =3D INPUT_EVENT_MASK_KEY,
>      .event =3D virtio_input_handle_event,
> @@ -322,7 +322,7 @@ static const TypeInfo virtio_keyboard_info =3D {
>
>  /* ----------------------------------------------------------------- */
>
> -static QemuInputHandler virtio_mouse_handler =3D {
> +static const QemuInputHandler virtio_mouse_handler =3D {
>      .name  =3D VIRTIO_ID_NAME_MOUSE,
>      .mask  =3D INPUT_EVENT_MASK_BTN | INPUT_EVENT_MASK_REL,
>      .event =3D virtio_input_handle_event,
> @@ -416,7 +416,7 @@ static const TypeInfo virtio_mouse_info =3D {
>
>  /* ----------------------------------------------------------------- */
>
> -static QemuInputHandler virtio_tablet_handler =3D {
> +static const QemuInputHandler virtio_tablet_handler =3D {
>      .name  =3D VIRTIO_ID_NAME_TABLET,
>      .mask  =3D INPUT_EVENT_MASK_BTN | INPUT_EVENT_MASK_ABS,
>      .event =3D virtio_input_handle_event,
> @@ -541,7 +541,7 @@ static const TypeInfo virtio_tablet_info =3D {
>
>  /* ----------------------------------------------------------------- */
>
> -static QemuInputHandler virtio_multitouch_handler =3D {
> +static const QemuInputHandler virtio_multitouch_handler =3D {
>      .name  =3D VIRTIO_ID_NAME_MULTITOUCH,
>      .mask  =3D INPUT_EVENT_MASK_BTN | INPUT_EVENT_MASK_MTT,
>      .event =3D virtio_input_handle_event,
> diff --git a/ui/input-legacy.c b/ui/input-legacy.c
> index 46ea74e44d..210ae5eaca 100644
> --- a/ui/input-legacy.c
> +++ b/ui/input-legacy.c
> @@ -127,7 +127,7 @@ static void legacy_kbd_event(DeviceState *dev, QemuCo=
nsole *src,
>      }
>  }
>
> -static QemuInputHandler legacy_kbd_handler =3D {
> +static const QemuInputHandler legacy_kbd_handler =3D {
>      .name  =3D "legacy-kbd",
>      .mask  =3D INPUT_EVENT_MASK_KEY,
>      .event =3D legacy_kbd_event,
> diff --git a/ui/input.c b/ui/input.c
> index cbe8573c5c..dc745860f4 100644
> --- a/ui/input.c
> +++ b/ui/input.c
> @@ -10,7 +10,7 @@
>
>  struct QemuInputHandlerState {
>      DeviceState       *dev;
> -    QemuInputHandler  *handler;
> +    const QemuInputHandler *handler;
>      int               id;
>      int               events;
>      QemuConsole       *con;
> @@ -46,7 +46,7 @@ static uint32_t queue_count;
>  static uint32_t queue_limit =3D 1024;
>
>  QemuInputHandlerState *qemu_input_handler_register(DeviceState *dev,
> -                                                   QemuInputHandler *han=
dler)
> +                                            const QemuInputHandler *hand=
ler)
>  {
>      QemuInputHandlerState *s =3D g_new0(QemuInputHandlerState, 1);
>      static int id =3D 1;
> diff --git a/ui/vdagent.c b/ui/vdagent.c
> index 00d36a8677..706d6d97bd 100644
> --- a/ui/vdagent.c
> +++ b/ui/vdagent.c
> @@ -297,7 +297,7 @@ static void vdagent_pointer_sync(DeviceState *dev)
>      }
>  }
>
> -static QemuInputHandler vdagent_mouse_handler =3D {
> +static const QemuInputHandler vdagent_mouse_handler =3D {
>      .name  =3D "vdagent mouse",
>      .mask  =3D INPUT_EVENT_MASK_BTN | INPUT_EVENT_MASK_ABS,
>      .event =3D vdagent_pointer_event,
> --
> 2.41.0
>


