Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 303A27DC15B
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 21:39:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxZ1W-0008EF-Mo; Mon, 30 Oct 2023 16:38:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qxZ1U-0008DJ-Tw; Mon, 30 Oct 2023 16:38:08 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qxZ1S-0007J2-L0; Mon, 30 Oct 2023 16:38:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SyF+WfYOcafPUzfohavt56YZ1a8og4MVEmfTcVo57eU=; b=j9GS/cReygmQpkNsVKhntow3NQ
 uShnzdW4zzF/eDojFIHEl9oY2wls4JHR/WJSOmGU3h4i4mQs0P9E6nwRgAaoDhMMN/wnyjctkXCk4
 MZkK/cfcEd6OqqN2H661JGLnR4xT3QYJ0so2+6g+cYQAGGpdz4UrENmNicEZkIEpwg/SCh0KmLKba
 +wurJEqgrHF4hsBzlr/VlD/zQaSmii0NtLYPP45gyVpTPUAbJMwbJLuKP5Epi1IqljXRY2dfQGGNr
 w27jZFvLHRaL531HsVgVJbmWHKL5qRkiQxfIGhAYoiDTULn6l5l8mBEUNPmm3g1esbyLZNGLT0i+Z
 YkNxWGBLyi/f17lzJ5yU0ftHq+J5vXdWL2Ex/gZeFH1DyQtXl6ay8cXkClkWwLA/V/MYd/fEqbhfS
 RLovp99/0AHAnFrU0YPCObQKjFajS0DYCNqLKESSkmJufQnXcV0Ly4yan66yaM1NWPsqX5upnXANq
 4r8cEJb/Qq53JxDI7Ct+ZXrVfu0Z0xCZCoGgOZLO6G8zBX26tgVvhl1FO8J1VtzGh+SUipfXdOibJ
 KNMZmpmYK2WU6VwQrv1SeZIFZn256Ety+lmuQVn8rGzx1ZXf6asLMrM3XJfiCHUN/ONtc4FV1psg1
 aK5LvmArEpKHZJFa5ZOMLvyECmq5ugEmUaxEM95PA=;
Received: from [2a00:23c4:8bb0:5400:5ff2:9176:6cc5:bf69]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qxZ1E-000Clj-TE; Mon, 30 Oct 2023 20:37:56 +0000
Message-ID: <9ea5c9b8-d740-4cec-9896-568babeca9aa@ilande.co.uk>
Date: Mon, 30 Oct 2023 20:37:57 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>
References: <20231030114802.3671871-1-peter.maydell@linaro.org>
 <20231030114802.3671871-6-peter.maydell@linaro.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 xsBNBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAHNME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPsLA
 eAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63M7ATQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABwsBfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
In-Reply-To: <20231030114802.3671871-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb0:5400:5ff2:9176:6cc5:bf69
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v2 5/6] hw/input/stellaris_input: Convert to qdev
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 30/10/2023 11:48, Peter Maydell wrote:

> Convert the hw/input/stellaris_input device to qdev.
> 
> The interface uses an array property for the board to specify the
> keycodes to use, so the s->keycodes memory is now allocated by the
> array-property machinery.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> v1->v2: drop private/public comment lines
> ---
>   include/hw/input/stellaris_gamepad.h | 22 ++++++++-
>   hw/arm/stellaris.c                   | 26 +++++++---
>   hw/input/stellaris_gamepad.c         | 73 +++++++++++++++++++---------
>   3 files changed, 89 insertions(+), 32 deletions(-)
> 
> diff --git a/include/hw/input/stellaris_gamepad.h b/include/hw/input/stellaris_gamepad.h
> index 23cfd3c95f3..6140b889a28 100644
> --- a/include/hw/input/stellaris_gamepad.h
> +++ b/include/hw/input/stellaris_gamepad.h
> @@ -11,8 +11,26 @@
>   #ifndef HW_INPUT_STELLARIS_GAMEPAD_H
>   #define HW_INPUT_STELLARIS_GAMEPAD_H
>   
> +#include "hw/sysbus.h"
> +#include "qom/object.h"
>   
> -/* stellaris_gamepad.c */
> -void stellaris_gamepad_init(int n, qemu_irq *irq, const int *keycode);
> +/*
> + * QEMU interface:
> + *  + QOM array property "keycodes": uint32_t QEMU keycodes to handle
> + *  + unnamed GPIO outputs: one per keycode, in the same order as the
> + *    "keycodes" array property entries; asserted when key is down
> + */
> +
> +#define TYPE_STELLARIS_GAMEPAD "stellaris-gamepad"
> +OBJECT_DECLARE_SIMPLE_TYPE(StellarisGamepad, STELLARIS_GAMEPAD)
> +
> +struct StellarisGamepad {
> +    SysBusDevice parent_obj;

Minor style comment: for QOM types there should be an empty line after parent_obj to 
aid identification (as per 
https://qemu.readthedocs.io/en/master/devel/style.html#qemu-object-model-declarations).

> +    uint32_t num_buttons;
> +    qemu_irq *irqs;
> +    uint32_t *keycodes;
> +    uint8_t *pressed;
> +    int extension;
> +};
>   
>   #endif
> diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
> index 96585dd7106..707b0dae375 100644
> --- a/hw/arm/stellaris.c
> +++ b/hw/arm/stellaris.c
> @@ -31,6 +31,7 @@
>   #include "hw/timer/stellaris-gptm.h"
>   #include "hw/qdev-clock.h"
>   #include "qom/object.h"
> +#include "qapi/qmp/qlist.h"
>   
>   #define GPIO_A 0
>   #define GPIO_B 1
> @@ -1274,16 +1275,27 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
>           sysbus_connect_irq(SYS_BUS_DEVICE(enet), 0, qdev_get_gpio_in(nvic, 42));
>       }
>       if (board->peripherals & BP_GAMEPAD) {
> -        qemu_irq gpad_irq[5];
> +        QList *gpad_keycode_list = qlist_new();
>           static const int gpad_keycode[5] = { 0xc8, 0xd0, 0xcb, 0xcd, 0x1d };
> +        DeviceState *gpad;
>   
> -        gpad_irq[0] = qemu_irq_invert(gpio_in[GPIO_E][0]); /* up */
> -        gpad_irq[1] = qemu_irq_invert(gpio_in[GPIO_E][1]); /* down */
> -        gpad_irq[2] = qemu_irq_invert(gpio_in[GPIO_E][2]); /* left */
> -        gpad_irq[3] = qemu_irq_invert(gpio_in[GPIO_E][3]); /* right */
> -        gpad_irq[4] = qemu_irq_invert(gpio_in[GPIO_F][1]); /* select */
> +        gpad = qdev_new(TYPE_STELLARIS_GAMEPAD);
> +        for (i = 0; i < ARRAY_SIZE(gpad_keycode); i++) {
> +            qlist_append_int(gpad_keycode_list, gpad_keycode[i]);
> +        }
> +        qdev_prop_set_array(gpad, "keycodes", gpad_keycode_list);
> +        sysbus_realize_and_unref(SYS_BUS_DEVICE(gpad), &error_fatal);
>   
> -        stellaris_gamepad_init(5, gpad_irq, gpad_keycode);
> +        qdev_connect_gpio_out(gpad, 0,
> +                              qemu_irq_invert(gpio_in[GPIO_E][0])); /* up */
> +        qdev_connect_gpio_out(gpad, 1,
> +                              qemu_irq_invert(gpio_in[GPIO_E][1])); /* down */
> +        qdev_connect_gpio_out(gpad, 2,
> +                              qemu_irq_invert(gpio_in[GPIO_E][2])); /* left */
> +        qdev_connect_gpio_out(gpad, 3,
> +                              qemu_irq_invert(gpio_in[GPIO_E][3])); /* right */
> +        qdev_connect_gpio_out(gpad, 4,
> +                              qemu_irq_invert(gpio_in[GPIO_F][1])); /* select */
>       }
>       for (i = 0; i < 7; i++) {
>           if (board->dc4 & (1 << i)) {
> diff --git a/hw/input/stellaris_gamepad.c b/hw/input/stellaris_gamepad.c
> index 82ddc47a26d..6ccf0e80adc 100644
> --- a/hw/input/stellaris_gamepad.c
> +++ b/hw/input/stellaris_gamepad.c
> @@ -8,19 +8,13 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include "qapi/error.h"
>   #include "hw/input/stellaris_gamepad.h"
>   #include "hw/irq.h"
> +#include "hw/qdev-properties.h"
>   #include "migration/vmstate.h"
>   #include "ui/console.h"
>   
> -typedef struct {
> -    uint32_t num_buttons;
> -    int extension;
> -    qemu_irq *irqs;
> -    uint32_t *keycodes;
> -    uint8_t *pressed;
> -} StellarisGamepad;
> -
>   static void stellaris_gamepad_put_key(void * opaque, int keycode)
>   {
>       StellarisGamepad *s = (StellarisGamepad *)opaque;
> @@ -57,22 +51,55 @@ static const VMStateDescription vmstate_stellaris_gamepad = {
>       }
>   };
>   
> -/* Returns an array of 5 output slots.  */
> -void stellaris_gamepad_init(int n, qemu_irq *irq, const int *keycode)
> +static void stellaris_gamepad_realize(DeviceState *dev, Error **errp)
>   {
> -    StellarisGamepad *s;
> -    int i;
> +    StellarisGamepad *s = STELLARIS_GAMEPAD(dev);
>   
> -    s = g_new0(StellarisGamepad, 1);
> -    s->irqs = g_new0(qemu_irq, n);
> -    s->keycodes = g_new0(uint32_t, n);
> -    s->pressed = g_new0(uint8_t, n);
> -    for (i = 0; i < n; i++) {
> -        s->irqs[i] = irq[i];
> -        s->keycodes[i] = keycode[i];
> +    if (s->num_buttons == 0) {
> +        error_setg(errp, "keycodes property array must be set");
> +        return;
>       }
> -    s->num_buttons = n;
> -    qemu_add_kbd_event_handler(stellaris_gamepad_put_key, s);
> -    vmstate_register(NULL, VMSTATE_INSTANCE_ID_ANY,
> -                     &vmstate_stellaris_gamepad, s);
> +
> +    s->irqs = g_new0(qemu_irq, s->num_buttons);
> +    s->pressed = g_new0(uint8_t, s->num_buttons);
> +    qdev_init_gpio_out(dev, s->irqs, s->num_buttons);
> +    qemu_add_kbd_event_handler(stellaris_gamepad_put_key, dev);
>   }
> +
> +static void stellaris_gamepad_reset_enter(Object *obj, ResetType type)
> +{
> +    StellarisGamepad *s = STELLARIS_GAMEPAD(obj);
> +
> +    memset(s->pressed, 0, s->num_buttons * sizeof(uint8_t));
> +}
> +
> +static Property stellaris_gamepad_properties[] = {
> +    DEFINE_PROP_ARRAY("keycodes", StellarisGamepad, num_buttons,
> +                      keycodes, qdev_prop_uint32, uint32_t),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void stellaris_gamepad_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
> +
> +    rc->phases.enter = stellaris_gamepad_reset_enter;
> +    dc->realize = stellaris_gamepad_realize;
> +    dc->vmsd = &vmstate_stellaris_gamepad;
> +    device_class_set_props(dc, stellaris_gamepad_properties);
> +}
> +
> +static const TypeInfo stellaris_gamepad_info = {
> +    .name = TYPE_STELLARIS_GAMEPAD,
> +    .parent = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(StellarisGamepad),
> +    .class_init = stellaris_gamepad_class_init,
> +};
> +
> +static void stellaris_gamepad_register_types(void)
> +{
> +    type_register_static(&stellaris_gamepad_info);
> +}
> +
> +type_init(stellaris_gamepad_register_types);

Is it worth converting this to use DEFINE_TYPES() during the conversion? I know Phil 
has considered some automation to remove the type_init() boilerplate for the majority 
of cases.


ATB,

Mark.


