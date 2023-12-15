Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8BB814A17
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Dec 2023 15:09:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rE8qh-00021M-4R; Fri, 15 Dec 2023 09:07:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rE8qY-0001vv-GR
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 09:07:23 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rE8qV-00082c-EW
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 09:07:22 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5522ba3f94aso750085a12.1
 for <qemu-devel@nongnu.org>; Fri, 15 Dec 2023 06:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702649238; x=1703254038; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=c4HT5F+UK7/71bqtR8jPcbK9fR7Z9VZ3+y4MRuMODng=;
 b=ZBwwgtw5ILQkjAk07Mg39rtdFqqm9nx8jw5SjdqO/FuvvWiRe2ZdUJt5AnO7DvV2q5
 SL+noiIhwGCxhjdNIjcZyK/N67xDZfn6a1xg8h9GypKRgj9ni1tef/CyfohEKjqL2sHa
 okxeuCEhAfD2QwoCYE16CeWYl+y+OkyPxcRzX3gl7sbeprPDjTbGt8G/i8OXN8B/0AJx
 8Zmx9h/2K1JkSuACgNc2d8/LWOWFp39DkwYR5+Bkplb4JqxzfnqUNcniM6iFKSQKogGe
 mdqGHKn5pDkTyzkMIVKjVi7gax/Advv01E6RyOadY+TwLkq+RSrWovtrzfz0J7q1LSeD
 zzaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702649238; x=1703254038;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c4HT5F+UK7/71bqtR8jPcbK9fR7Z9VZ3+y4MRuMODng=;
 b=Y54vDoGPdanKUb8dKRcDlZ4I2lWNyHC6dCLg9QaBrxM7SFt/d4/BiNAOx/NIba1+9e
 J63yTY2fo7j+lf6ZDkLM1u32OQ8UYxjW6oWfdrTaOg2y47hT78ewmEhys+PhQuJGCxYv
 GQQPDmTZShThJBoF3yx9QhKoTWmwWooxtDBm2MtR+MSDzo/i8ILg96BZvcr2NacatXHc
 V8mEw4o5d8WFMyyUfQB0obKJPeRG8MGqMt9c5+WE4O0iNvbj9fjKNkc6ofw2X0sXAeF3
 NMPLnYRTt2tQqI6my08Gnr9KVlRtjlEj08CkSEJyNYx1lvfZPPuWpdThPPtFy0gdpiIS
 o0zA==
X-Gm-Message-State: AOJu0YzYWjN/tYzCntbs3sGTe612Bdc/o8bXEK0qkKf5prJEWF3fxLa4
 rDYyxq7azo0mxb707CCM0eg1CSkPn68yFBNn5Aqe9A==
X-Google-Smtp-Source: AGHT+IFMxp+k5ylN3JVVL5GUBi5tkgosCGJEdMKthAmgTbkJ+0Y+a/rvaEP2ry9iZCi1tMWRvPEISdOpi2dW84Bsmlo=
X-Received: by 2002:a50:9b5c:0:b0:551:8766:7296 with SMTP id
 a28-20020a509b5c000000b0055187667296mr2014998edj.105.1702649237658; Fri, 15
 Dec 2023 06:07:17 -0800 (PST)
MIME-Version: 1.0
References: <20231103182750.855577-1-peter.maydell@linaro.org>
In-Reply-To: <20231103182750.855577-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Dec 2023 14:07:06 +0000
Message-ID: <CAFEAcA-QXorAggMFLEknvkrrBtCZSEWpcW_Fx_GTrxD0RfqUFg@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/musicpal: Convert to qemu_add_kbd_event_handler()
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Jan Kiszka <jan.kiszka@web.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Ping for code review, since we're approaching the end of the
8.2 freeze ?

thanks
-- PMM

On Fri, 3 Nov 2023 at 18:27, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Convert the musicpal key input device to use
> qemu_add_kbd_event_handler().  This lets us simplify it because we no
> longer need to track whether we're in the middle of a PS/2 multibyte
> key sequence.
>
> In the conversion we move the keyboard handler registration from init
> to realize, because devices shouldn't disturb the state of the
> simulation by doing things like registering input handlers until
> they're realized, so that device objects can be introspected
> safely.
>
> The behaviour where key-repeat is permitted for the arrow-keys only
> is intentional (added in commit 7c6ce4baedfcd0c), so we retain it,
> and add a comment to that effect.
>
> This is a migration compatibility break for musicpal.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/arm/musicpal.c | 131 +++++++++++++++++++++-------------------------
>  1 file changed, 61 insertions(+), 70 deletions(-)
>
> diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
> index 9703bfb97fb..e8c1250ab04 100644
> --- a/hw/arm/musicpal.c
> +++ b/hw/arm/musicpal.c
> @@ -1043,20 +1043,6 @@ static const TypeInfo musicpal_gpio_info = {
>  };
>
>  /* Keyboard codes & masks */
> -#define KEY_RELEASED            0x80
> -#define KEY_CODE                0x7f
> -
> -#define KEYCODE_TAB             0x0f
> -#define KEYCODE_ENTER           0x1c
> -#define KEYCODE_F               0x21
> -#define KEYCODE_M               0x32
> -
> -#define KEYCODE_EXTENDED        0xe0
> -#define KEYCODE_UP              0x48
> -#define KEYCODE_DOWN            0x50
> -#define KEYCODE_LEFT            0x4b
> -#define KEYCODE_RIGHT           0x4d
> -
>  #define MP_KEY_WHEEL_VOL       (1 << 0)
>  #define MP_KEY_WHEEL_VOL_INV   (1 << 1)
>  #define MP_KEY_WHEEL_NAV       (1 << 2)
> @@ -1074,67 +1060,66 @@ struct musicpal_key_state {
>      SysBusDevice parent_obj;
>      /*< public >*/
>
> -    uint32_t kbd_extended;
>      uint32_t pressed_keys;
>      qemu_irq out[8];
>  };
>
> -static void musicpal_key_event(void *opaque, int keycode)
> +static void musicpal_key_event(DeviceState *dev, QemuConsole *src,
> +                               InputEvent *evt)
>  {
> -    musicpal_key_state *s = opaque;
> +    musicpal_key_state *s = MUSICPAL_KEY(dev);
> +    InputKeyEvent *key = evt->u.key.data;
> +    int qcode = qemu_input_key_value_to_qcode(key->key);
>      uint32_t event = 0;
>      int i;
>
> -    if (keycode == KEYCODE_EXTENDED) {
> -        s->kbd_extended = 1;
> -        return;
> +    switch (qcode) {
> +    case Q_KEY_CODE_UP:
> +        event = MP_KEY_WHEEL_NAV | MP_KEY_WHEEL_NAV_INV;
> +        break;
> +
> +    case Q_KEY_CODE_DOWN:
> +        event = MP_KEY_WHEEL_NAV;
> +        break;
> +
> +    case Q_KEY_CODE_LEFT:
> +        event = MP_KEY_WHEEL_VOL | MP_KEY_WHEEL_VOL_INV;
> +        break;
> +
> +    case Q_KEY_CODE_RIGHT:
> +        event = MP_KEY_WHEEL_VOL;
> +        break;
> +
> +    case Q_KEY_CODE_F:
> +        event = MP_KEY_BTN_FAVORITS;
> +        break;
> +
> +    case Q_KEY_CODE_TAB:
> +        event = MP_KEY_BTN_VOLUME;
> +        break;
> +
> +    case Q_KEY_CODE_RET:
> +        event = MP_KEY_BTN_NAVIGATION;
> +        break;
> +
> +    case Q_KEY_CODE_M:
> +        event = MP_KEY_BTN_MENU;
> +        break;
>      }
>
> -    if (s->kbd_extended) {
> -        switch (keycode & KEY_CODE) {
> -        case KEYCODE_UP:
> -            event = MP_KEY_WHEEL_NAV | MP_KEY_WHEEL_NAV_INV;
> -            break;
> -
> -        case KEYCODE_DOWN:
> -            event = MP_KEY_WHEEL_NAV;
> -            break;
> -
> -        case KEYCODE_LEFT:
> -            event = MP_KEY_WHEEL_VOL | MP_KEY_WHEEL_VOL_INV;
> -            break;
> -
> -        case KEYCODE_RIGHT:
> -            event = MP_KEY_WHEEL_VOL;
> -            break;
> -        }
> -    } else {
> -        switch (keycode & KEY_CODE) {
> -        case KEYCODE_F:
> -            event = MP_KEY_BTN_FAVORITS;
> -            break;
> -
> -        case KEYCODE_TAB:
> -            event = MP_KEY_BTN_VOLUME;
> -            break;
> -
> -        case KEYCODE_ENTER:
> -            event = MP_KEY_BTN_NAVIGATION;
> -            break;
> -
> -        case KEYCODE_M:
> -            event = MP_KEY_BTN_MENU;
> -            break;
> -        }
> -        /* Do not repeat already pressed buttons */
> -        if (!(keycode & KEY_RELEASED) && (s->pressed_keys & event)) {
> +    /*
> +     * We allow repeated wheel-events when the arrow keys are held down,
> +     * but do not repeat already-pressed buttons for the other key inputs.
> +     */
> +    if (!(event & (MP_KEY_WHEEL_NAV | MP_KEY_WHEEL_VOL))) {
> +        if (key->down && (s->pressed_keys & event)) {
>              event = 0;
>          }
>      }
>
>      if (event) {
>          /* Raise GPIO pin first if repeating a key */
> -        if (!(keycode & KEY_RELEASED) && (s->pressed_keys & event)) {
> +        if (key->down && (s->pressed_keys & event)) {
>              for (i = 0; i <= 7; i++) {
>                  if (event & (1 << i)) {
>                      qemu_set_irq(s->out[i], 1);
> @@ -1143,17 +1128,15 @@ static void musicpal_key_event(void *opaque, int keycode)
>          }
>          for (i = 0; i <= 7; i++) {
>              if (event & (1 << i)) {
> -                qemu_set_irq(s->out[i], !!(keycode & KEY_RELEASED));
> +                qemu_set_irq(s->out[i], !key->down);
>              }
>          }
> -        if (keycode & KEY_RELEASED) {
> -            s->pressed_keys &= ~event;
> -        } else {
> +        if (key->down) {
>              s->pressed_keys |= event;
> +        } else {
> +            s->pressed_keys &= ~event;
>          }
>      }
> -
> -    s->kbd_extended = 0;
>  }
>
>  static void musicpal_key_init(Object *obj)
> @@ -1162,20 +1145,27 @@ static void musicpal_key_init(Object *obj)
>      DeviceState *dev = DEVICE(sbd);
>      musicpal_key_state *s = MUSICPAL_KEY(dev);
>
> -    s->kbd_extended = 0;
>      s->pressed_keys = 0;
>
>      qdev_init_gpio_out(dev, s->out, ARRAY_SIZE(s->out));
> +}
>
> -    qemu_add_kbd_event_handler(musicpal_key_event, s);
> +static const QemuInputHandler musicpal_key_handler = {
> +    .name = "musicpal_key",
> +    .mask = INPUT_EVENT_MASK_KEY,
> +    .event = musicpal_key_event,
> +};
> +
> +static void musicpal_key_realize(DeviceState *dev, Error **errp)
> +{
> +    qemu_input_handler_register(dev, &musicpal_key_handler);
>  }
>
>  static const VMStateDescription musicpal_key_vmsd = {
>      .name = "musicpal_key",
> -    .version_id = 1,
> -    .minimum_version_id = 1,
> +    .version_id = 2,
> +    .minimum_version_id = 2,
>      .fields = (VMStateField[]) {
> -        VMSTATE_UINT32(kbd_extended, musicpal_key_state),
>          VMSTATE_UINT32(pressed_keys, musicpal_key_state),
>          VMSTATE_END_OF_LIST()
>      }
> @@ -1186,6 +1176,7 @@ static void musicpal_key_class_init(ObjectClass *klass, void *data)
>      DeviceClass *dc = DEVICE_CLASS(klass);
>
>      dc->vmsd = &musicpal_key_vmsd;
> +    dc->realize = musicpal_key_realize;
>  }
>
>  static const TypeInfo musicpal_key_info = {
> --
> 2.34.1
>

