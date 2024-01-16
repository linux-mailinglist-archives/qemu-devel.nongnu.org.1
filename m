Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7140E82F202
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 16:58:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPloP-0005Zw-1m; Tue, 16 Jan 2024 10:57:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rPloM-0005ZA-GL
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 10:57:10 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rPloK-0005OE-FN
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 10:57:10 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a28b0207c1dso814900466b.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 07:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705420627; x=1706025427; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Lxk0ItVRgHD7AlkEQ0GOc9f/MCeC+C+nelHHzRfEGFI=;
 b=rrPREMIBmVxkVSW9m8kzx++Q1EYXrdBN/oaeP/4hQjhO859lzS5ZeBps3sbszRZqS/
 ozHaxslhTkgOVvaP3W0TMMB0374U33s69XY+PULIgDqhHJoGsoARK64xS8XA2/SBLL0e
 ZuK7a1GX98VrO/sSHMuKc9/VLV09FbFaIjtHloh5urDE9PkvBYB7lTZHQKbqzbvrQtqf
 OQexe6NVNdeoqcxcmchqvvLIHqe9spJs734NKVEWPxDFOLl1REa1MpAo6+CDbpImZN/l
 2bykqxm60psc0pmY3BcxcKaLrMfMyO6z+J8NLiObc0dyCtF99GxhAhfWQaXoratcKj46
 2Ryg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705420627; x=1706025427;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Lxk0ItVRgHD7AlkEQ0GOc9f/MCeC+C+nelHHzRfEGFI=;
 b=v1APKIhTyHWA5nCHwIs5Gvzu4gGkorKnXP/UnUHBotYNf+jKpmjvq/1pXV7Yc5Rz63
 eog4Huhk4HlFplhQ2u81eqSdkCch+Cw4IFSHhdm7XW26b2yThg0nGlVgymslOZoI3SuA
 i8sf1sKOxJI3uEdVLPrYesVnJgcAuoOFhsog7qvLPSlUDUCBIFTdjRS4053UvvRIEB+7
 UFdvPHKF6ALlruUIGVIdq5RsFRkY8CVvOq4AaR2AdNRG/pmUmt7iFc4n6zSjH7mvc+IM
 +g1A4xVFgCJcG0qgZ7a5nhQAxy9zX1Jjj5FXpB4AHgBYI9AKgqvN9QVpe8we2dO1tKeT
 aUVQ==
X-Gm-Message-State: AOJu0YzDFIWwPcN/ldhKsZqXTpENBu7xVkh/mXK6J6aU7JtJ2Rqj7ozi
 byL87hfKaINGrhJpM4GOS/C35WOgmmtqNg==
X-Google-Smtp-Source: AGHT+IGFl5LcWxbbc8jwRTYFQoBWqofdRXDIsjnkBLy8ysWseY+FJ054DPQpSDIcgY1GHt602VuHOw==
X-Received: by 2002:a17:907:9283:b0:a2b:5c42:76d0 with SMTP id
 bw3-20020a170907928300b00a2b5c4276d0mr4722822ejc.54.1705420626739; 
 Tue, 16 Jan 2024 07:57:06 -0800 (PST)
Received: from [192.168.1.102] ([176.176.156.199])
 by smtp.gmail.com with ESMTPSA id
 o26-20020a170906289a00b00a2bd8953af2sm6594342ejd.55.2024.01.16.07.57.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jan 2024 07:57:06 -0800 (PST)
Message-ID: <b763463b-3174-43dd-8ee5-2a01e98a8bdb@linaro.org>
Date: Tue, 16 Jan 2024 16:57:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/arm/musicpal: Convert to qemu_add_kbd_event_handler()
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Jan Kiszka <jan.kiszka@web.de>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20231103182750.855577-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231103182750.855577-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Cc'ing Gerd & Marc-André for UI.

On 3/11/23 19:27, Peter Maydell wrote:
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
>   hw/arm/musicpal.c | 131 +++++++++++++++++++++-------------------------
>   1 file changed, 61 insertions(+), 70 deletions(-)
> 
> diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
> index 9703bfb97fb..e8c1250ab04 100644
> --- a/hw/arm/musicpal.c
> +++ b/hw/arm/musicpal.c
> @@ -1043,20 +1043,6 @@ static const TypeInfo musicpal_gpio_info = {
>   };
>   
>   /* Keyboard codes & masks */
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
>   #define MP_KEY_WHEEL_VOL       (1 << 0)
>   #define MP_KEY_WHEEL_VOL_INV   (1 << 1)
>   #define MP_KEY_WHEEL_NAV       (1 << 2)
> @@ -1074,67 +1060,66 @@ struct musicpal_key_state {
>       SysBusDevice parent_obj;
>       /*< public >*/
>   
> -    uint32_t kbd_extended;
>       uint32_t pressed_keys;
>       qemu_irq out[8];
>   };
>   
> -static void musicpal_key_event(void *opaque, int keycode)
> +static void musicpal_key_event(DeviceState *dev, QemuConsole *src,
> +                               InputEvent *evt)
>   {
> -    musicpal_key_state *s = opaque;
> +    musicpal_key_state *s = MUSICPAL_KEY(dev);
> +    InputKeyEvent *key = evt->u.key.data;
> +    int qcode = qemu_input_key_value_to_qcode(key->key);
>       uint32_t event = 0;
>       int i;
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
>       }
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
>               event = 0;
>           }
>       }
>   
>       if (event) {
>           /* Raise GPIO pin first if repeating a key */
> -        if (!(keycode & KEY_RELEASED) && (s->pressed_keys & event)) {
> +        if (key->down && (s->pressed_keys & event)) {
>               for (i = 0; i <= 7; i++) {
>                   if (event & (1 << i)) {
>                       qemu_set_irq(s->out[i], 1);
> @@ -1143,17 +1128,15 @@ static void musicpal_key_event(void *opaque, int keycode)
>           }
>           for (i = 0; i <= 7; i++) {
>               if (event & (1 << i)) {
> -                qemu_set_irq(s->out[i], !!(keycode & KEY_RELEASED));
> +                qemu_set_irq(s->out[i], !key->down);
>               }
>           }
> -        if (keycode & KEY_RELEASED) {
> -            s->pressed_keys &= ~event;
> -        } else {
> +        if (key->down) {
>               s->pressed_keys |= event;
> +        } else {
> +            s->pressed_keys &= ~event;
>           }
>       }
> -
> -    s->kbd_extended = 0;
>   }
>   
>   static void musicpal_key_init(Object *obj)
> @@ -1162,20 +1145,27 @@ static void musicpal_key_init(Object *obj)
>       DeviceState *dev = DEVICE(sbd);
>       musicpal_key_state *s = MUSICPAL_KEY(dev);
>   
> -    s->kbd_extended = 0;
>       s->pressed_keys = 0;
>   
>       qdev_init_gpio_out(dev, s->out, ARRAY_SIZE(s->out));
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
>   }
>   
>   static const VMStateDescription musicpal_key_vmsd = {
>       .name = "musicpal_key",
> -    .version_id = 1,
> -    .minimum_version_id = 1,
> +    .version_id = 2,
> +    .minimum_version_id = 2,
>       .fields = (VMStateField[]) {
> -        VMSTATE_UINT32(kbd_extended, musicpal_key_state),
>           VMSTATE_UINT32(pressed_keys, musicpal_key_state),
>           VMSTATE_END_OF_LIST()
>       }
> @@ -1186,6 +1176,7 @@ static void musicpal_key_class_init(ObjectClass *klass, void *data)
>       DeviceClass *dc = DEVICE_CLASS(klass);
>   
>       dc->vmsd = &musicpal_key_vmsd;
> +    dc->realize = musicpal_key_realize;
>   }
>   
>   static const TypeInfo musicpal_key_info = {


