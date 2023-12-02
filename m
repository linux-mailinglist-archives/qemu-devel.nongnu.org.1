Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B28CF801D09
	for <lists+qemu-devel@lfdr.de>; Sat,  2 Dec 2023 14:28:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9Q1w-0002Kx-CC; Sat, 02 Dec 2023 08:27:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lbryndza.oss@icloud.com>)
 id 1r9Q1u-0002Kj-Bg
 for qemu-devel@nongnu.org; Sat, 02 Dec 2023 08:27:34 -0500
Received: from pv50p00im-ztdg10012101.me.com ([17.58.6.49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lbryndza.oss@icloud.com>)
 id 1r9Q1r-0007XY-IT
 for qemu-devel@nongnu.org; Sat, 02 Dec 2023 08:27:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
 s=1a1hai; t=1701523647;
 bh=qCNR5toA3CSpWkOslPu34v88XblDLhXsIPeVs+gUrgA=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
 b=iCmTbAeg23jkW3hUt92rXx/AHhkqptNSpqoqj/d6MUUlZ2NwZ4zJJcNxF7A3WyZXY
 NFrLYj9QdzhiWGYSANgQ5U7/NfB93ofhUAWxinDdFLMOiLpynXuXRfdjfjAn2N96Ol
 +0/+RUgrtFkczMTt5+zZyHd5ajy5SEnlZMwMA0KuhP7ysr6NsrNH56RLONHi973Mmt
 FCncGqss6bD5n8MGsm7mFeiHN0rZLVUMc633iQawWp2086Yb8uAt1Dx4tQbI0ta415
 D99WdJex2vXOIuu/eY0Z9lt2jL0vAfR1gi1USZ7Vk6/R5eD0L4+EYBXwyGfbPRWhiM
 Ez+XihR/XHPeQ==
Received: from smtpclient.apple (pv50p00im-dlb-asmtp-mailmevip.me.com
 [17.56.9.10])
 by pv50p00im-ztdg10012101.me.com (Postfix) with ESMTPSA id 8F679740160;
 Sat,  2 Dec 2023 13:27:25 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: [PATCH qemu v2] Fixing the basic functionality of STM32 timers
From: Lucjan Bryndza <lbryndza.oss@icloud.com>
In-Reply-To: <CAKmqyKNc7yfrkuJ5a3ZQd7jQkqNXLDP8rH7qzUDWhtBMvMgc5Q@mail.gmail.com>
Date: Sat, 2 Dec 2023 14:27:12 +0100
Cc: qemu-devel@nongnu.org,
 alistair@alistair23.me
Content-Transfer-Encoding: quoted-printable
Message-Id: <F44CCD1B-B9B5-4A51-9370-9FA5D0587373@icloud.com>
References: <169869595054.30747.1587003712699663871-0@git.sr.ht>
 <CAKmqyKNc7yfrkuJ5a3ZQd7jQkqNXLDP8rH7qzUDWhtBMvMgc5Q@mail.gmail.com>
To: Alistair Francis <alistair23@gmail.com>
X-Mailer: Apple Mail (2.3774.200.91.1.1)
X-Proofpoint-GUID: wc24d5EmEATr0lDgsiELBVPyuYFZq2nx
X-Proofpoint-ORIG-GUID: wc24d5EmEATr0lDgsiELBVPyuYFZq2nx
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.517,18.0.883,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2022-06-21=5F08:2022-06-21=5F01,2022-06-21=5F08,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 spamscore=0 bulkscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 clxscore=1015 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2312020099
Received-SPF: pass client-ip=17.58.6.49; envelope-from=lbryndza.oss@icloud.com;
 helo=pv50p00im-ztdg10012101.me.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Alistair=20

Sorry for the delay in response and thank you for a response.


The previous STM32 timer implementation did not work properly. Incorrect =
calculation of time to next interrupt caused interrupts not to be =
reported correctly.  For example, programming the timer-counter circuit =
with an interval of 1ms caused the first interrupt to come after ten =
seconds and the next interrupts even after a few minutes.=20
The reason why this happened was the overflow of variables in internal =
calculations and the incorrectly declared frequency of the time base.=20

Moreover, the previous implementation did not take into account the =
actual behavior of the STM32 timer time base block. Only upward counting =
was implemented, while in reality the time-base block can count both up, =
down, and alternately up-down depending on the configuration of the CR1 =
CR2 configuration registers. The current implementation adds this =
functionality which ensures compatibility with the actual time-base =
block of stm32 microcontrollers.  Plus, it also fixes a problem with =
time step determination and uses the newer ptimer() api at the same =
time.

I've also broken the patch into smaller pieces to make it easier to do a =
review and I am sending third version of it in a separate message.=20

Best Regards,
Lucjan Bryndza


> Wiadomo=C5=9B=C4=87 napisana przez Alistair Francis =
<alistair23@gmail.com> w dniu 22.11.2023, o godz. 07:25:
>=20
> On Tue, Oct 31, 2023 at 6:35=E2=80=AFAM ~lbryndza <lbryndza@git.sr.ht> =
wrote:
>>=20
>> From: Lucjan Bryndza <lbryndza.oss@icloud.com>
>>=20
>> The current implementation of timers does not work properly
>> even in basic functionality. A counter configured to report
>> an interrupt every 10ms reports the first interrupts after a
>> few seconds.  There are also no properly implemented count up and
>> count down modes. This commit fixes bugs with interrupt
>> reporting and implements the basic modes of the counter's
>> time-base block.
>>=20
>> Signed-off-by: Lucjan Bryndza <lbryndza.oss@icloud.com>
>=20
> Thanks. This is already easier to follow than the first version. It
> still helps to split this up, it's relatively long and difficult to
> follow the changes.
>=20
> You have done a great job of explaining what the current problem is in
> the commit message, but do you mind explaining a bit more details
> about your fix?
>=20
> I know it might seem like a pain, but I am pretty much reviewing the
> STM32 work in my spare time and I haven't worked on it directly in
> awhile. The simpler you can make the changes the easier and quicker it
> is to review. As you have noticed, timers are tricky to get right, so
> we want to try and make sure it's correct this time :)
>=20
>> ---
>> hw/arm/stm32f405_soc.c             |   2 +-
>> hw/timer/stm32f2xx_timer.c         | 262 =
+++++++++++++++++++----------
>> include/hw/timer/stm32f2xx_timer.h |  23 ++-
>> 3 files changed, 189 insertions(+), 98 deletions(-)
>>=20
>> diff --git a/hw/arm/stm32f405_soc.c b/hw/arm/stm32f405_soc.c
>> index cef23d7ee4..69316181b3 100644
>> --- a/hw/arm/stm32f405_soc.c
>> +++ b/hw/arm/stm32f405_soc.c
>> @@ -183,7 +183,7 @@ static void stm32f405_soc_realize(DeviceState =
*dev_soc, Error **errp)
>>     /* Timer 2 to 5 */
>>     for (i =3D 0; i < STM_NUM_TIMERS; i++) {
>>         dev =3D DEVICE(&(s->timer[i]));
>> -        qdev_prop_set_uint64(dev, "clock-frequency", 1000000000);
>> +        qdev_prop_set_uint64(dev, "clock-frequency", 48000000);
>>         if (!sysbus_realize(SYS_BUS_DEVICE(&s->timer[i]), errp)) {
>>             return;
>>         }
>> diff --git a/hw/timer/stm32f2xx_timer.c b/hw/timer/stm32f2xx_timer.c
>> index ba8694dcd3..9a992231fa 100644
>> --- a/hw/timer/stm32f2xx_timer.c
>> +++ b/hw/timer/stm32f2xx_timer.c
>> @@ -23,12 +23,17 @@
>>  */
>>=20
>> #include "qemu/osdep.h"
>> +#include "qapi/error.h"
>> #include "hw/irq.h"
>> #include "hw/qdev-properties.h"
>> #include "hw/timer/stm32f2xx_timer.h"
>> #include "migration/vmstate.h"
>> #include "qemu/log.h"
>> #include "qemu/module.h"
>> +#include "qemu/typedefs.h"
>> +#include "qemu/timer.h"
>> +#include "qemu/main-loop.h"
>> +#include "sysemu/dma.h"
>>=20
>> #ifndef STM_TIMER_ERR_DEBUG
>> #define STM_TIMER_ERR_DEBUG 0
>> @@ -42,63 +47,87 @@
>>=20
>> #define DB_PRINT(fmt, args...) DB_PRINT_L(1, fmt, ## args)
>>=20
>> -static void stm32f2xx_timer_set_alarm(STM32F2XXTimerState *s, =
int64_t now);
>>=20
>> -static void stm32f2xx_timer_interrupt(void *opaque)
>> +static uint32_t stm32f2xx_timer_get_count(STM32F2XXTimerState *s)
>> {
>> -    STM32F2XXTimerState *s =3D opaque;
>> -
>> -    DB_PRINT("Interrupt\n");
>> -
>> -    if (s->tim_dier & TIM_DIER_UIE && s->tim_cr1 & TIM_CR1_CEN) {
>> -        s->tim_sr |=3D 1;
>> -        qemu_irq_pulse(s->irq);
>> -        stm32f2xx_timer_set_alarm(s, s->hit_time);
>> -    }
>> -
>> -    if (s->tim_ccmr1 & (TIM_CCMR1_OC2M2 | TIM_CCMR1_OC2M1) &&
>> -        !(s->tim_ccmr1 & TIM_CCMR1_OC2M0) &&
>> -        s->tim_ccmr1 & TIM_CCMR1_OC2PE &&
>> -        s->tim_ccer & TIM_CCER_CC2E) {
>> -        /* PWM 2 - Mode 1 */
>> -        DB_PRINT("PWM2 Duty Cycle: %d%%\n",
>> -                s->tim_ccr2 / (100 * (s->tim_psc + 1)));
>> +    uint64_t cnt =3D ptimer_get_count(s->timer);
>> +    if (s->count_mode =3D=3D TIMER_UP_COUNT) {
>> +        return s->tim_arr - (cnt & 0xffff);
>> +    } else {
>> +        return cnt & 0xffff;
>>     }
>> }
>>=20
>> -static inline int64_t stm32f2xx_ns_to_ticks(STM32F2XXTimerState *s, =
int64_t t)
>> +
>> +static void stm32f2xx_timer_set_count(STM32F2XXTimerState *s, =
uint32_t cnt)
>> {
>> -    return muldiv64(t, s->freq_hz, 1000000000ULL) / (s->tim_psc + =
1);
>> +    if (s->count_mode =3D=3D TIMER_UP_COUNT) {
>> +        ptimer_set_count(s->timer, s->tim_arr - (cnt & 0xffff));
>> +    } else {
>> +        ptimer_set_count(s->timer, cnt & 0xffff);
>> +    }
>> }
>>=20
>> -static void stm32f2xx_timer_set_alarm(STM32F2XXTimerState *s, =
int64_t now)
>> +static void stm32f2xx_timer_update(STM32F2XXTimerState *s)
>> {
>> -    uint64_t ticks;
>> -    int64_t now_ticks;
>> +    if (s->tim_cr1 & TIM_CR1_DIR) {
>> +        s->count_mode =3D TIMER_DOWN_COUNT;
>> +    } else {
>> +        s->count_mode =3D TIMER_UP_COUNT;
>> +    }
>>=20
>> -    if (s->tim_arr =3D=3D 0) {
>> -        return;
>> +    if (s->tim_cr1 & TIM_CR1_CMS) {
>> +        s->count_mode =3D TIMER_UP_COUNT;
>>     }
>>=20
>> -    DB_PRINT("Alarm set at: 0x%x\n", s->tim_cr1);
>> +    if (s->tim_cr1 & TIM_CR1_CEN) {
>> +        DB_PRINT("Enabling timer\n");
>> +        ptimer_set_freq(s->timer, s->freq_hz);
>> +        ptimer_run(s->timer, !(s->tim_cr1 & 0x04));
>> +    } else {
>> +        DB_PRINT("Disabling timer\n");
>> +        ptimer_stop(s->timer);
>> +    }
>> +}
>>=20
>> -    now_ticks =3D stm32f2xx_ns_to_ticks(s, now);
>> -    ticks =3D s->tim_arr - (now_ticks - s->tick_offset);
>> +static void stm32f2xx_timer_update_uif(STM32F2XXTimerState *s, =
uint8_t value)
>> +{
>> +    s->tim_sr &=3D ~TIM_SR1_UIF;
>> +    s->tim_sr |=3D (value & TIM_SR1_UIF);
>> +    qemu_set_irq(s->irq, value);
>> +}
>>=20
>> -    DB_PRINT("Alarm set in %d ticks\n", (int) ticks);
>> +static void stm32f2xx_timer_tick(void *opaque)
>> +{
>> +    STM32F2XXTimerState *s =3D (STM32F2XXTimerState *)opaque;
>> +    DB_PRINT("Alarm raised\n");
>> +    stm32f2xx_timer_update_uif(s, 1);
>> +
>> +    if (s->count_mode =3D=3D TIMER_UP_COUNT) {
>> +        stm32f2xx_timer_set_count(s, 0);
>> +    } else {
>> +        stm32f2xx_timer_set_count(s, s->tim_arr);
>> +    }
>>=20
>> -    s->hit_time =3D muldiv64((ticks + (uint64_t) now_ticks) * =
(s->tim_psc + 1),
>> -                               1000000000ULL, s->freq_hz);
>> +    if (s->tim_cr1 & TIM_CR1_CMS) {
>> +        if (s->count_mode =3D=3D TIMER_UP_COUNT) {
>> +            s->count_mode =3D TIMER_DOWN_COUNT;
>> +        } else {
>> +            s->count_mode =3D TIMER_UP_COUNT;
>> +        }
>> +    }
>>=20
>> -    timer_mod(s->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + =
s->hit_time);
>> -    DB_PRINT("Wait Time: %" PRId64 " ticks\n", s->hit_time);
>> +    if (s->tim_cr1 & TIM_CR1_OPM) {
>> +        s->tim_cr1 &=3D ~TIM_CR1_CEN;
>> +    } else {
>> +        stm32f2xx_timer_update(s);
>> +    }
>> }
>>=20
>> +
>> static void stm32f2xx_timer_reset(DeviceState *dev)
>> {
>>     STM32F2XXTimerState *s =3D STM32F2XXTIMER(dev);
>> -    int64_t now =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>> -
>>     s->tim_cr1 =3D 0;
>>     s->tim_cr2 =3D 0;
>>     s->tim_smcr =3D 0;
>> @@ -117,8 +146,6 @@ static void stm32f2xx_timer_reset(DeviceState =
*dev)
>>     s->tim_dcr =3D 0;
>>     s->tim_dmar =3D 0;
>>     s->tim_or =3D 0;
>> -
>> -    s->tick_offset =3D stm32f2xx_ns_to_ticks(s, now);
>> }
>>=20
>> static uint64_t stm32f2xx_timer_read(void *opaque, hwaddr offset,
>> @@ -132,15 +159,18 @@ static uint64_t stm32f2xx_timer_read(void =
*opaque, hwaddr offset,
>>     case TIM_CR1:
>>         return s->tim_cr1;
>>     case TIM_CR2:
>> -        return s->tim_cr2;
>> +        qemu_log_mask(LOG_GUEST_ERROR, "stm32_timer: CR2 not =
supported");
>> +        return 0;
>=20
> These type of smaller changes can be split into a separate patch
>=20
>>     case TIM_SMCR:
>> -        return s->tim_smcr;
>> +        qemu_log_mask(LOG_GUEST_ERROR, "stm32_timer: SMCR not =
supported");
>> +        return 0;
>>     case TIM_DIER:
>>         return s->tim_dier;
>>     case TIM_SR:
>>         return s->tim_sr;
>>     case TIM_EGR:
>> -        return s->tim_egr;
>> +        qemu_log_mask(LOG_GUEST_ERROR, "stm32_timer: EGR write =
only");
>> +        return 0;
>>     case TIM_CCMR1:
>>         return s->tim_ccmr1;
>>     case TIM_CCMR2:
>> @@ -148,8 +178,7 @@ static uint64_t stm32f2xx_timer_read(void =
*opaque, hwaddr offset,
>>     case TIM_CCER:
>>         return s->tim_ccer;
>>     case TIM_CNT:
>> -        return stm32f2xx_ns_to_ticks(s, =
qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL)) -
>> -               s->tick_offset;
>> +        return stm32f2xx_timer_get_count(s);
>>     case TIM_PSC:
>>         return s->tim_psc;
>>     case TIM_ARR:
>> @@ -163,105 +192,152 @@ static uint64_t stm32f2xx_timer_read(void =
*opaque, hwaddr offset,
>>     case TIM_CCR4:
>>         return s->tim_ccr4;
>>     case TIM_DCR:
>> -        return s->tim_dcr;
>> +        qemu_log_mask(LOG_GUEST_ERROR, "stm32_timer: DCR not =
supported");
>> +        return 0;
>>     case TIM_DMAR:
>> -        return s->tim_dmar;
>> +        qemu_log_mask(LOG_GUEST_ERROR, "stm32_timer: CR2 not =
supported");
>> +        return 0;
>>     case TIM_OR:
>>         return s->tim_or;
>>     default:
>>         qemu_log_mask(LOG_GUEST_ERROR,
>>                       "%s: Bad offset 0x%"HWADDR_PRIx"\n", __func__, =
offset);
>>     }
>> -
>>     return 0;
>> }
>>=20
>> +static void stm32f2xx_update_cr1(STM32F2XXTimerState *s, uint64_t =
value)
>> +{
>> +    s->tim_cr1 =3D value & 0x3FF;
>> +    ptimer_transaction_begin(s->timer);
>> +    stm32f2xx_timer_update(s);
>> +    ptimer_transaction_commit(s->timer);
>> +    DB_PRINT("write cr1 =3D %x\n", s->tim_cr1);
>> +}
>> +
>> +static void stm32f2xx_update_sr(STM32F2XXTimerState *s, uint64_t =
value)
>> +{
>> +    s->tim_sr ^=3D (value ^ 0xFFFF);
>> +    s->tim_sr &=3D 0x1eFF;
>> +    ptimer_transaction_begin(s->timer);
>> +    stm32f2xx_timer_update_uif(s, s->tim_sr & 0x1);
>> +    ptimer_transaction_commit(s->timer);
>> +    DB_PRINT("write sr =3D %x\n", s->tim_sr);
>> +}
>> +
>> +static void stm32f2xx_update_psc(STM32F2XXTimerState *s, uint64_t =
value)
>> +{
>> +    s->tim_psc =3D value & 0xffff;
>> +    ptimer_transaction_begin(s->timer);
>> +    ptimer_set_freq(s->timer, s->freq_hz);
>> +    ptimer_transaction_commit(s->timer);
>> +    DB_PRINT("write psc =3D %x\n", s->tim_psc);
>> +}
>> +
>> +static void stm32f2xx_update_egr(STM32F2XXTimerState *s, uint64_t =
value)
>> +{
>> +    s->tim_egr =3D value & 0x1E;
>> +    if (value & TIM_EGR_TG) {
>> +        s->tim_sr |=3D TIM_EGR_TG;
>> +    }
>> +    if (value & TIM_EGR_UG) {
>> +        /* UG bit - reload */
>> +        ptimer_transaction_begin(s->timer);
>> +        ptimer_set_limit(s->timer, s->tim_arr, 1);
>> +        ptimer_transaction_commit(s->timer);
>> +    }
>> +    DB_PRINT("write EGR =3D %x\n", s->tim_egr);
>> +}
>> +
>> +static void stm32f2xx_update_cnt(STM32F2XXTimerState *s, uint64_t =
value)
>> +{
>> +    ptimer_transaction_begin(s->timer);
>> +    stm32f2xx_timer_set_count(s, value & 0xffff);
>> +    ptimer_transaction_commit(s->timer);
>> +    DB_PRINT("write cnt =3D %x\n", stm32f2xx_timer_get_count(s));
>> +}
>> +
>> +static void stm32f2xx_update_arr(STM32F2XXTimerState *s, uint64_t =
value)
>> +{
>> +    s->tim_arr =3D value & 0xffff;
>> +    ptimer_transaction_begin(s->timer);
>> +    ptimer_set_limit(s->timer, s->tim_arr, 1);
>> +    ptimer_transaction_commit(s->timer);
>> +    DB_PRINT("write arr =3D %x\n", s->tim_arr);
>> +}
>> +
>> static void stm32f2xx_timer_write(void *opaque, hwaddr offset,
>> -                        uint64_t val64, unsigned size)
>> +                        uint64_t value, unsigned size)
>> {
>>     STM32F2XXTimerState *s =3D opaque;
>> -    uint32_t value =3D val64;
>> -    int64_t now =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>> -    uint32_t timer_val =3D 0;
>> -
>> -    DB_PRINT("Write 0x%x, 0x%"HWADDR_PRIx"\n", value, offset);
>=20
> Why remove this?
>=20
>>=20
>>     switch (offset) {
>>     case TIM_CR1:
>> -        s->tim_cr1 =3D value;
>> +        stm32f2xx_update_cr1(s, value);
>>         return;
>>     case TIM_CR2:
>> -        s->tim_cr2 =3D value;
>> +        qemu_log_mask(LOG_GUEST_ERROR, "stm32_timer: CR2 not =
supported");
>>         return;
>>     case TIM_SMCR:
>> -        s->tim_smcr =3D value;
>> +        qemu_log_mask(LOG_GUEST_ERROR, "stm32_timer: SCMR not =
supported");
>>         return;
>>     case TIM_DIER:
>> -        s->tim_dier =3D value;
>> +        s->tim_dier =3D value & 0x5F5F;
>> +        DB_PRINT("write dier =3D %x\n", s->tim_dier);
>>         return;
>>     case TIM_SR:
>> -        /* This is set by hardware and cleared by software */
>> -        s->tim_sr &=3D value;
>> +        stm32f2xx_update_sr(s, value);
>>         return;
>>     case TIM_EGR:
>> -        s->tim_egr =3D value;
>> -        if (s->tim_egr & TIM_EGR_UG) {
>> -            timer_val =3D 0;
>> -            break;
>> -        }
>> +        stm32f2xx_update_egr(s, value);
>>         return;
>>     case TIM_CCMR1:
>> -        s->tim_ccmr1 =3D value;
>> +        s->tim_ccmr1 =3D value & 0xffff;
>> +        DB_PRINT("write ccmr1 =3D %x\n", s->tim_ccmr1);
>=20
> I don't think we need this print
>=20
>>         return;
>>     case TIM_CCMR2:
>> -        s->tim_ccmr2 =3D value;
>> +        s->tim_ccmr2 =3D value & 0xffff;
>> +        DB_PRINT("write ccmr2 =3D %x\n", s->tim_ccmr2);
>>         return;
>>     case TIM_CCER:
>> -        s->tim_ccer =3D value;
>> +        s->tim_ccer =3D value & 0x3333;
>> +        DB_PRINT("write ccer =3D %x\n", s->tim_ccer);
>>         return;
>>     case TIM_PSC:
>> -        timer_val =3D stm32f2xx_ns_to_ticks(s, now) - =
s->tick_offset;
>> -        s->tim_psc =3D value & 0xFFFF;
>> -        break;
>> +        stm32f2xx_update_psc(s, value);
>> +        return;
>>     case TIM_CNT:
>> -        timer_val =3D value;
>> -        break;
>> +        stm32f2xx_update_cnt(s, value);
>> +        return;
>>     case TIM_ARR:
>> -        s->tim_arr =3D value;
>> -        stm32f2xx_timer_set_alarm(s, now);
>> +        stm32f2xx_update_arr(s, value);
>>         return;
>>     case TIM_CCR1:
>> -        s->tim_ccr1 =3D value;
>> +        s->tim_ccr1 =3D value & 0xffff;
>>         return;
>>     case TIM_CCR2:
>> -        s->tim_ccr2 =3D value;
>> +        s->tim_ccr2 =3D value & 0xffff;
>=20
> These small changes can also be split into a separate patch
>=20
>>         return;
>>     case TIM_CCR3:
>> -        s->tim_ccr3 =3D value;
>> +        s->tim_ccr3 =3D value & 0xffff;
>>         return;
>>     case TIM_CCR4:
>> -        s->tim_ccr4 =3D value;
>> +        s->tim_ccr4 =3D value & 0xffff;
>>         return;
>>     case TIM_DCR:
>> -        s->tim_dcr =3D value;
>> +        qemu_log_mask(LOG_GUEST_ERROR, "stm32_timer: DCR not =
supported");
>>         return;
>>     case TIM_DMAR:
>> -        s->tim_dmar =3D value;
>> +        qemu_log_mask(LOG_GUEST_ERROR, "stm32_timer: DMAR not =
supported");
>>         return;
>>     case TIM_OR:
>> -        s->tim_or =3D value;
>> +        qemu_log_mask(LOG_GUEST_ERROR, "stm32_timer: OR not =
supported");
>>         return;
>>     default:
>>         qemu_log_mask(LOG_GUEST_ERROR,
>>                       "%s: Bad offset 0x%"HWADDR_PRIx"\n", __func__, =
offset);
>>         return;
>>     }
>> -
>> -    /* This means that a register write has affected the timer in a =
way that
>> -     * requires a refresh of both tick_offset and the alarm.
>> -     */
>> -    s->tick_offset =3D stm32f2xx_ns_to_ticks(s, now) - timer_val;
>> -    stm32f2xx_timer_set_alarm(s, now);
>> }
>>=20
>> static const MemoryRegionOps stm32f2xx_timer_ops =3D {
>> @@ -272,10 +348,10 @@ static const MemoryRegionOps =
stm32f2xx_timer_ops =3D {
>>=20
>> static const VMStateDescription vmstate_stm32f2xx_timer =3D {
>>     .name =3D TYPE_STM32F2XX_TIMER,
>> -    .version_id =3D 1,
>> -    .minimum_version_id =3D 1,
>> +    .version_id =3D 2,
>> +    .minimum_version_id =3D 2,
>>     .fields =3D (VMStateField[]) {
>> -        VMSTATE_INT64(tick_offset, STM32F2XXTimerState),
>> +        VMSTATE_INT32(count_mode, STM32F2XXTimerState),
>>         VMSTATE_UINT32(tim_cr1, STM32F2XXTimerState),
>>         VMSTATE_UINT32(tim_cr2, STM32F2XXTimerState),
>>         VMSTATE_UINT32(tim_smcr, STM32F2XXTimerState),
>> @@ -300,7 +376,7 @@ static const VMStateDescription =
vmstate_stm32f2xx_timer =3D {
>>=20
>> static Property stm32f2xx_timer_properties[] =3D {
>>     DEFINE_PROP_UINT64("clock-frequency", struct STM32F2XXTimerState,
>> -                       freq_hz, 1000000000),
>> +                       freq_hz, 0),
>=20
> Why remove the default?
>=20
> Alistair
>=20
>>     DEFINE_PROP_END_OF_LIST(),
>> };
>>=20
>> @@ -318,7 +394,11 @@ static void stm32f2xx_timer_init(Object *obj)
>> static void stm32f2xx_timer_realize(DeviceState *dev, Error **errp)
>> {
>>     STM32F2XXTimerState *s =3D STM32F2XXTIMER(dev);
>> -    s->timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, =
stm32f2xx_timer_interrupt, s);
>> +    if (s->freq_hz =3D=3D 0) {
>> +        error_setg(errp, "stm32f2xx_timer: Timer clock not =
defined");
>> +        return;
>> +    }
>> +    s->timer =3D ptimer_init(stm32f2xx_timer_tick, s, =
PTIMER_POLICY_LEGACY);
>> }
>>=20
>> static void stm32f2xx_timer_class_init(ObjectClass *klass, void =
*data)
>> diff --git a/include/hw/timer/stm32f2xx_timer.h =
b/include/hw/timer/stm32f2xx_timer.h
>> index 90f40f1746..c83f7b0d6f 100644
>> --- a/include/hw/timer/stm32f2xx_timer.h
>> +++ b/include/hw/timer/stm32f2xx_timer.h
>> @@ -28,6 +28,7 @@
>> #include "hw/sysbus.h"
>> #include "qemu/timer.h"
>> #include "qom/object.h"
>> +#include "hw/ptimer.h"
>>=20
>> #define TIM_CR1      0x00
>> #define TIM_CR2      0x04
>> @@ -49,9 +50,15 @@
>> #define TIM_DMAR     0x4C
>> #define TIM_OR       0x50
>>=20
>> -#define TIM_CR1_CEN   1
>> +#define TIM_CR1_CEN 0x0001
>> +#define TIM_CR1_DIR 0x0010
>> +#define TIM_CR1_CMS 0x0060
>> +#define TIM_CR1_OPM 0x0008
>>=20
>> -#define TIM_EGR_UG 1
>> +#define TIM_SR1_UIF 0x0001
>> +
>> +#define TIM_EGR_UG 0x0001
>> +#define TIM_EGR_TG 0x0040
>>=20
>> #define TIM_CCER_CC2E   (1 << 4)
>> #define TIM_CCMR1_OC2M2 (1 << 14)
>> @@ -61,6 +68,7 @@
>>=20
>> #define TIM_DIER_UIE  1
>>=20
>> +
>> #define TYPE_STM32F2XX_TIMER "stm32f2xx-timer"
>> typedef struct STM32F2XXTimerState STM32F2XXTimerState;
>> DECLARE_INSTANCE_CHECKER(STM32F2XXTimerState, STM32F2XXTIMER,
>> @@ -72,12 +80,10 @@ struct STM32F2XXTimerState {
>>=20
>>     /* <public> */
>>     MemoryRegion iomem;
>> -    QEMUTimer *timer;
>> +    ptimer_state *timer;
>>     qemu_irq irq;
>> -
>> -    int64_t tick_offset;
>> -    uint64_t hit_time;
>>     uint64_t freq_hz;
>> +    int count_mode;
>>=20
>>     uint32_t tim_cr1;
>>     uint32_t tim_cr2;
>> @@ -99,4 +105,9 @@ struct STM32F2XXTimerState {
>>     uint32_t tim_or;
>> };
>>=20
>> +enum {
>> +    TIMER_UP_COUNT     =3D 0,
>> +    TIMER_DOWN_COUNT   =3D 1
>> +};
>> +
>> #endif /* HW_STM32F2XX_TIMER_H */
>> --
>> 2.38.5
>>=20


