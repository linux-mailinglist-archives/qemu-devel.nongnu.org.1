Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6F0721183
	for <lists+qemu-devel@lfdr.de>; Sat,  3 Jun 2023 20:14:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5VkZ-0000v3-Kq; Sat, 03 Jun 2023 14:13:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q5VkS-0000uf-2i; Sat, 03 Jun 2023 14:13:11 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q5VkP-0005Pk-3v; Sat, 03 Jun 2023 14:13:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:References:Cc:To:From:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=o7xeTLrY/aHBWFTydI0e+eOkpn97uhMNv8jGZ3aq+5o=; b=0LzCjlwN1lTMwo/Xv2v30GPPjs
 6xmYARa1Zx2GvxtS8SA+wrdPlBEzgRvogGE43Gtqu0HW8AeAgwlsRoznbGZqg+2V6U+5w/MMpUvdL
 BK5ZGLDWh0XtIkkm9bh4gwhLln/jqXage6nXLpNKG8d7n+31VnXkt+WGOI14COAyQcgySeOwZ6EhG
 icnku3tIF8qfi8Eja9OeEKCJ+rK6My2GnQ+HJvxRqDrRM65ZQps4tO8iU4RGIkkUKA6GYT/rP6gPc
 mbQiO0IcZ7DN6pM8ToAxj0pHR7p3HlrwHAdf1gp/tH3rEAdOYV/LkBerdCk2xPG3cZ0DdlSmvIjRQ
 zTDuciUm4XjeZhKvPj9rdBba/mYrmV//MbzL6qytPqgBV2ZoHVWA3nesh6IllS0wh+8VFiEtFxx24
 HpEVXKygE4IJwp1Sf69JXmXjP9CPp4hf0FSfjcfz/qFwWlBZog8eaXnrcMfgwGC9nSqFvfHAsTcWq
 9VozD2VjhZP4C6hKT3f/vbkMSsKKTz4OQQ5r1HQU7r0hUCTgyB9XYGL25Ygunuc4KmpboHnSCvD39
 p7H2WSMjBPD5s8Jatue2dLZ2nTaZsHf2osF97gItbdmJd5P4UQf6ho9cthnESNR8JL/rsVJPNndm5
 OJ6qEFZ+Yk++VorWyYsve4Xb7DQ6h9t+7UYadCE+o=;
Received: from [2a00:23c4:8bac:6900:b726:cf58:4c12:f013]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q5VkC-0000R1-Gs; Sat, 03 Jun 2023 19:12:56 +0100
Message-ID: <eae9ddaa-a914-b4f2-7fea-0f1731ab0706@ilande.co.uk>
Date: Sat, 3 Jun 2023 19:12:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Sergey Kambalin <serg.oker@gmail.com>
References: <20230531203559.29140-1-philmd@linaro.org>
 <20230531203559.29140-16-philmd@linaro.org>
 <43f014f5-6dd7-7c46-eea4-ed9cffe8ec48@ilande.co.uk>
In-Reply-To: <43f014f5-6dd7-7c46-eea4-ed9cffe8ec48@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bac:6900:b726:cf58:4c12:f013
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 15/15] hw/timer/arm_timer: QOM'ify ARM_TIMER
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 03/06/2023 19:07, Mark Cave-Ayland wrote:

> On 31/05/2023 21:35, Philippe Mathieu-Daudé wrote:
> 
>> Introduce the ARM_TIMER sysbus device.
>>
>> arm_timer_new() is converted as QOM instance init()/finalize()
>> handlers. Note in arm_timer_finalize() we release a ptimer handle
>> which was previously leaked.
>>
>> ArmTimerState is directly embedded into SP804State/IcpPitState,
>> and is initialized as a QOM child.
>>
>> Since the timer frequency belongs to ARM_TIMER, have it hold the
>> QOM property. SP804State/IcpPitState directly access it.
>>
>> Similarly the SP804State/IcpPitState input IRQ becomes the
>> ARM_TIMER sysbus output IRQ.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/timer/arm_timer.c | 109 +++++++++++++++++++++++++++----------------
>>   1 file changed, 70 insertions(+), 39 deletions(-)
>>
>> diff --git a/hw/timer/arm_timer.c b/hw/timer/arm_timer.c
>> index 82123b40c0..a929fbba62 100644
>> --- a/hw/timer/arm_timer.c
>> +++ b/hw/timer/arm_timer.c
>> @@ -17,6 +17,7 @@
>>   #include "qemu/module.h"
>>   #include "qemu/log.h"
>>   #include "qom/object.h"
>> +#include "qapi/error.h"
>>   /* Common timer implementation.  */
>> @@ -29,14 +30,18 @@
>>   #define TIMER_CTRL_PERIODIC     (1 << 6)
>>   #define TIMER_CTRL_ENABLE       (1 << 7)
>> -typedef struct {
>> +#define TYPE_ARM_TIMER "arm-timer"
>> +OBJECT_DECLARE_SIMPLE_TYPE(ArmTimerState, ARM_TIMER)
> 
> As per our QOM guidelines ArmTimerState and the OBJECT_* macro should live in a 
> separate header file.

Ah wait: does "ArmTimerState is directly embedded into SP804State/IcpPitState, and is 
initialized as a QOM child." mean that ARM_TIMER is never instantiated externally?

>> +struct ArmTimerState {
>> +    SysBusDevice parent_obj;
> 
> And don't forget to add a blank line here too.
> 
>>       ptimer_state *timer;
>>       uint32_t control;
>>       uint32_t limit;
>>       uint32_t freq;
>>       int int_level;
>>       qemu_irq irq;
>> -} ArmTimerState;
>> +};
>>   /* Check all active timers, and schedule the next timer interrupt.  */
>> @@ -172,23 +177,42 @@ static const VMStateDescription vmstate_arm_timer = {
>>       }
>>   };
>> -static void arm_timer_reset(ArmTimerState *s)
>> +static void arm_timer_reset(DeviceState *dev)
>>   {
>> +    ArmTimerState *s = ARM_TIMER(dev);
>> +
>>       s->control = TIMER_CTRL_IE;
>>   }
> 
> If you're currently set up to test the ARM timers with these changes, is it worth 
> considering converting this to use the Resettable interface at the same time?
> 
>> -static ArmTimerState *arm_timer_new(uint32_t freq, qemu_irq irq_out)
>> +static void arm_timer_init(Object *obj)
>>   {
>> -    ArmTimerState *s;
>> +    ArmTimerState *s = ARM_TIMER(obj);
>> +    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
>> -    s = g_new0(ArmTimerState, 1);
>> -    s->freq = freq;
>> -    arm_timer_reset(s);
>> -
>> -    s->irq = irq_out;
>>       s->timer = ptimer_init(arm_timer_tick, s, PTIMER_POLICY_LEGACY);
>> -    vmstate_register(NULL, VMSTATE_INSTANCE_ID_ANY, &vmstate_arm_timer, s);
>> -    return s;
>> +
>> +    sysbus_init_irq(sbd, &s->irq);
>> +}
>> +
>> +static void arm_timer_finalize(Object *obj)
>> +{
>> +    ArmTimerState *s = ARM_TIMER(obj);
>> +
>> +    ptimer_free(s->timer);
>> +}
>> +
>> +static Property arm_timer_properties[] = {
>> +    DEFINE_PROP_UINT32("freq", ArmTimerState, freq, 0),
>> +    DEFINE_PROP_END_OF_LIST(),
>> +};
>> +
>> +static void arm_timer_class_init(ObjectClass *oc, void *data)
>> +{
>> +    DeviceClass *dc = DEVICE_CLASS(oc);
>> +
>> +    dc->reset = arm_timer_reset;
>> +    dc->vmsd = &vmstate_arm_timer;
>> +    device_class_set_props(dc, arm_timer_properties);
>>   }
>>   /*
>> @@ -204,11 +228,9 @@ struct SP804State {
>>       SysBusDevice parent_obj;
>>       MemoryRegion iomem;
>> -    ArmTimerState *timer[2];
>> -    uint32_t freq[2];
>> +    ArmTimerState timer[2];
>>       int level[2];
>>       qemu_irq irq;
>> -    qemu_irq irq_in[2];
>>   };
>>   static const uint8_t sp804_ids[] = {
>> @@ -233,10 +255,10 @@ static uint64_t sp804_read(void *opaque, hwaddr offset,
>>       SP804State *s = opaque;
>>       if (offset < 0x20) {
>> -        return arm_timer_read(s->timer[0], offset);
>> +        return arm_timer_read(&s->timer[0], offset);
>>       }
>>       if (offset < 0x40) {
>> -        return arm_timer_read(s->timer[1], offset - 0x20);
>> +        return arm_timer_read(&s->timer[1], offset - 0x20);
>>       }
>>       /* TimerPeriphID */
>> @@ -265,12 +287,12 @@ static void sp804_write(void *opaque, hwaddr offset,
>>       SP804State *s = opaque;
>>       if (offset < 0x20) {
>> -        arm_timer_write(s->timer[0], offset, value);
>> +        arm_timer_write(&s->timer[0], offset, value);
>>           return;
>>       }
>>       if (offset < 0x40) {
>> -        arm_timer_write(s->timer[1], offset - 0x20, value);
>> +        arm_timer_write(&s->timer[1], offset - 0x20, value);
>>           return;
>>       }
>> @@ -304,6 +326,12 @@ static void sp804_init(Object *obj)
>>       memory_region_init_io(&s->iomem, obj, &sp804_ops, s,
>>                             "sp804", 0x1000);
>>       sysbus_init_mmio(sbd, &s->iomem);
>> +
>> +    qdev_init_gpio_in_named(DEVICE(obj), sp804_set_irq,
>> +                            "timer-in", ARRAY_SIZE(s->timer));
>> +    for (unsigned i = 0; i < ARRAY_SIZE(s->timer); i++) {
>> +        object_initialize_child(obj, "timer[*]", &s->timer[i], TYPE_ARM_TIMER);
>> +    }
>>   }
>>   static void sp804_realize(DeviceState *dev, Error **errp)
>> @@ -311,23 +339,17 @@ static void sp804_realize(DeviceState *dev, Error **errp)
>>       SP804State *s = SP804(dev);
>>       for (unsigned i = 0; i < ARRAY_SIZE(s->timer); i++) {
>> -        s->irq_in[i] = qemu_allocate_irq(sp804_set_irq, s, i);
>> -        s->timer[i] = arm_timer_new(s->freq[i], s->irq_in[i]);
>> -    }
>> -}
>> -
>> -static void sp804_unrealize(DeviceState *dev)
>> -{
>> -    SP804State *s = SP804(dev);
>> -
>> -    for (unsigned i = 0; i < ARRAY_SIZE(s->timer); i++) {
>> -        qemu_free_irq(s->irq_in[i]);
>> +        if (!sysbus_realize(SYS_BUS_DEVICE(&s->timer[i]), errp)) {
>> +            return;
>> +        }
>> +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->timer[i]), 0,
>> +                           qdev_get_gpio_in_named(dev, "timer-in", i));
>>       }
>>   }
>>   static Property sp804_properties[] = {
>> -    DEFINE_PROP_UINT32("freq0", SP804State, freq[0], 1000000),
>> -    DEFINE_PROP_UINT32("freq1", SP804State, freq[1], 1000000),
>> +    DEFINE_PROP_UINT32("freq0", SP804State, timer[0].freq, 1000000),
>> +    DEFINE_PROP_UINT32("freq1", SP804State, timer[1].freq, 1000000),
>>       DEFINE_PROP_END_OF_LIST(),
>>   };
>> @@ -336,7 +358,6 @@ static void sp804_class_init(ObjectClass *klass, void *data)
>>       DeviceClass *k = DEVICE_CLASS(klass);
>>       k->realize = sp804_realize;
>> -    k->unrealize = sp804_unrealize;
>>       device_class_set_props(k, sp804_properties);
>>       k->vmsd = &vmstate_sp804;
>>   }
>> @@ -350,8 +371,7 @@ struct IntegratorPitState {
>>       SysBusDevice parent_obj;
>>       MemoryRegion iomem;
>> -    ArmTimerState *timer[3];
>> -    qemu_irq irq_in[3];
>> +    ArmTimerState timer[3];
>>       qemu_irq irq[3];
>>   };
>> @@ -368,7 +388,7 @@ static uint64_t icp_pit_read(void *opaque, hwaddr offset,
>>           return 0;
>>       }
>> -    return arm_timer_read(s->timer[n], offset & 0xff);
>> +    return arm_timer_read(&s->timer[n], offset & 0xff);
>>   }
>>   static void icp_pit_write(void *opaque, hwaddr offset,
>> @@ -383,7 +403,7 @@ static void icp_pit_write(void *opaque, hwaddr offset,
>>           return;
>>       }
>> -    arm_timer_write(s->timer[n], offset & 0xff, value);
>> +    arm_timer_write(&s->timer[n], offset & 0xff, value);
>>   }
>>   static const MemoryRegionOps icp_pit_ops = {
>> @@ -414,7 +434,8 @@ static void icp_pit_init(Object *obj)
>>                               "timer-in", ARRAY_SIZE(s->timer));
>>       for (unsigned i = 0; i < ARRAY_SIZE(s->timer); i++) {
>> -        s->timer[i] = arm_timer_new(tmr_freq[i], s->irq_in[i]);
>> +        object_initialize_child(obj, "timer[*]", &s->timer[i], TYPE_ARM_TIMER);
>> +        qdev_prop_set_uint32(DEVICE(&s->timer[i]), "freq", tmr_freq[i]);
>>           sysbus_init_irq(dev, &s->irq[i]);
>>       }
>> @@ -430,7 +451,10 @@ static void icp_pit_realize(DeviceState *dev, Error **errp)
>>       IntegratorPitState *s = INTEGRATOR_PIT(dev);
>>       for (unsigned i = 0; i < ARRAY_SIZE(s->timer); i++) {
>> -        sysbus_connect_irq(SYS_BUS_DEVICE(dev), i,
>> +        if (!sysbus_realize(SYS_BUS_DEVICE(&s->timer[i]), errp)) {
>> +            return;
>> +        }
>> +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->timer[i]), 0,
>>                              qdev_get_gpio_in_named(dev, "timer-in", i));
>>       }
>>   }
>> @@ -444,6 +468,13 @@ static void icp_pit_class_init(ObjectClass *klass, void *data)
>>   static const TypeInfo arm_timer_types[] = {
>>       {
>> +        .name           = TYPE_ARM_TIMER,
>> +        .parent         = TYPE_SYS_BUS_DEVICE,
>> +        .instance_size  = sizeof(ArmTimerState),
>> +        .instance_init  = arm_timer_init,
>> +        .instance_finalize = arm_timer_finalize,
>> +        .class_init     = arm_timer_class_init,
>> +    }, {
>>           .name           = TYPE_INTEGRATOR_PIT,
>>           .parent         = TYPE_SYS_BUS_DEVICE,
>>           .instance_size  = sizeof(IntegratorPitState),


ATB,

Mark.


