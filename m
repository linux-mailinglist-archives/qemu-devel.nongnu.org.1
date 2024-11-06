Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD659BF80C
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Nov 2024 21:34:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8mhy-0006HK-J9; Wed, 06 Nov 2024 15:32:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1t8mhv-0006Gp-GI
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 15:32:51 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1t8mhq-0005iI-Jq
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 15:32:51 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C743E4E600F;
 Wed, 06 Nov 2024 21:32:41 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id 2vkA_dUxvBcO; Wed,  6 Nov 2024 21:32:39 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id C5D764E6004; Wed, 06 Nov 2024 21:32:39 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C0B6D746F60;
 Wed, 06 Nov 2024 21:32:39 +0100 (CET)
Date: Wed, 6 Nov 2024 21:32:39 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, peter.maydell@linaro.org,
 huth@tuxfamily.org, berrange@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 1/2] next-kbd: convert to use
 qemu_input_handler_register()
In-Reply-To: <13995544-2d94-4b35-a7c2-f11e0599170f@linaro.org>
Message-ID: <872fd077-b870-f910-88a5-a045787aa681@eik.bme.hu>
References: <20241106120928.242443-1-mark.cave-ayland@ilande.co.uk>
 <20241106120928.242443-2-mark.cave-ayland@ilande.co.uk>
 <4c127d3c-3610-e6b7-9358-3d88d28477a0@eik.bme.hu>
 <13995544-2d94-4b35-a7c2-f11e0599170f@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-994263130-1730925159=:64954"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-994263130-1730925159=:64954
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 6 Nov 2024, Philippe Mathieu-Daudé wrote:
> On 6/11/24 13:00, BALATON Zoltan wrote:
>> On Wed, 6 Nov 2024, Mark Cave-Ayland wrote:
>>> Convert the next-kbd device from the legacy UI 
>>> qemu_add_kbd_event_handler()
>>> function to use qemu_input_handler_register().
>>> 
>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>> Reviewed-by: Thomas Huth <huth@tuxfamily.org>
>>> ---
>>> hw/m68k/next-kbd.c | 163 ++++++++++++++++++++++++++++++---------------
>>> 1 file changed, 108 insertions(+), 55 deletions(-)
>
>
>>> -static const unsigned char next_keycodes[128] = {
>>> -    0x00, 0x49, 0x4A, 0x4B, 0x4C, 0x4D, 0x50, 0x4F,
>>> -    0x4E, 0x1E, 0x1F, 0x20, 0x1D, 0x1C, 0x1B, 0x00,
>>> -    0x42, 0x43, 0x44, 0x45, 0x48, 0x47, 0x46, 0x06,
>>> -    0x07, 0x08, 0x00, 0x00, 0x2A, 0x00, 0x39, 0x3A,
>>> -    0x3B, 0x3C, 0x3D, 0x40, 0x3F, 0x3E, 0x2D, 0x2C,
>>> -    0x2B, 0x26, 0x00, 0x00, 0x31, 0x32, 0x33, 0x34,
>>> -    0x35, 0x37, 0x36, 0x2e, 0x2f, 0x30, 0x00, 0x00,
>>> -    0x00, 0x38, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>>> -    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
>>> -    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
>>> -    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
>>> -    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
>>> +#define NEXTKBD_NO_KEY 0xff
>> 
>> Now you don't need this 0xff define any more because you can use 0 as no 
>> key value then the [0 ... Q_KEY_CODE__MAX] init below can also be dropped 
>> because static variables are 0 init automatically.
>
> Whether 0 or 0xff is best for NO_KEY, I don't know.
> However, definitions are useful when reviewing ...
>
>> 
>> Regards,
>> BALATON Zoltan
>> 
>>> +static const int qcode_to_nextkbd_keycode[] = {
>>> +    /* Make sure future additions are automatically set to NEXTKBD_NO_KEY 
>>> */
>>> +    [0 ... Q_KEY_CODE__MAX]    = NEXTKBD_NO_KEY,
>>> +
>>> +    [Q_KEY_CODE_ESC]           = 0x49,
>>> +    [Q_KEY_CODE_1]             = 0x4a,
>>> +    [Q_KEY_CODE_2]             = 0x4b,
>>> +    [Q_KEY_CODE_3]             = 0x4c,
>>> +    [Q_KEY_CODE_4]             = 0x4d,
> [...]
>
>>> +static void nextkbd_event(DeviceState *dev, QemuConsole *src, InputEvent 
>>> *evt)
>>> +{
>>> +    NextKBDState *s = NEXTKBD(dev);
>>> +    int qcode, keycode;
>>> +    bool key_down = evt->u.key.data->down;
>>> +
>>> +    qcode = qemu_input_key_value_to_qcode(evt->u.key.data->key);
>>> +    if (qcode >= ARRAY_SIZE(qcode_to_nextkbd_keycode)) {
>>> +        return;
>>> +    }
>>> +
>>> +    /* Shift key currently has no keycode, so handle separately */
>>> +    if (qcode == Q_KEY_CODE_SHIFT) {
>>> +        if (key_down) {
>>> +            s->shift |= KD_LSHIFT;
>>> +        } else {
>>> +            s->shift &= ~KD_LSHIFT;
>>> +        }
>>> +    }
>>> +
>>> +    if (qcode == Q_KEY_CODE_SHIFT_R) {
>>> +        if (key_down) {
>>> +            s->shift |= KD_RSHIFT;
>>> +        } else {
>>> +            s->shift &= ~KD_RSHIFT;
>>> +        }
>>> +    }
>>> +
>>> +    keycode = qcode_to_nextkbd_keycode[qcode];
>>> +    if (keycode == NEXTKBD_NO_KEY) {
>
> ... here ^

I this case !keycode is pretty self explanatory IMO.

Regards,
BALATON Zoltan

>>> +        return;
>>> +    }
>>> +
>>> +    /* If key release event, create keyboard break code */
>>> +    if (!key_down) {
>>> +        keycode |= 0x80;
>>> +    }
>>> +
>>> +    nextkbd_put_keycode(s, keycode);
>>> +}
>
>
--3866299591-994263130-1730925159=:64954--

