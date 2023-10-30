Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3767DC0FC
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 21:07:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxYWb-00080E-Tr; Mon, 30 Oct 2023 16:06:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lbryndza.oss@icloud.com>)
 id 1qxYWX-0007zy-Jh
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 16:06:09 -0400
Received: from mr85p00im-zteg06021901.me.com ([17.58.23.194])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lbryndza.oss@icloud.com>)
 id 1qxYWN-0002Km-BL
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 16:06:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
 s=1a1hai; t=1698696355;
 bh=l9qdZVjHgZiUZdDT5KVebyRqUvbNV2tdLXhEoy1rC6Y=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
 b=yLRPh3Y9WXy6kkBu1zu599y/b/jJmH9SN+9alt8jK3tKtNaIvPG10/gSwc4Nv0qC7
 WaWG7eZPc0Q1+0w7P0FCdtAsTrTLpWdFypNowCiZmg4fNKjtLD27U/cus+pBjLMdfU
 ogRM8RJQa/ffHlCOmF0JxkU0YMwim/htaqgItrR9jdArKKj+5CRWJ3gU43XPOEnc0N
 lLfdjf90tFzq3R/xhUceGhaMB+mwZLF8W95+/jUqewo7rd1Ahm6D97jYxg5uf3YLwK
 BIGsEkPakNfuOxW6kGmbqP2bsBToIUf7F11wS349Jmnd/NwHR69+oMtTSXRVIir0P9
 XnhmxTxoiPIXw==
Received: from smtpclient.apple (mr38p00im-dlb-asmtp-mailmevip.me.com
 [17.57.152.18])
 by mr85p00im-zteg06021901.me.com (Postfix) with ESMTPSA id 952F9740365;
 Mon, 30 Oct 2023 20:05:54 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: Patch to fix malfunctioning of T2-T5 timers on the STM32 platform
From: Lucjan Bryndza <lbryndza.oss@icloud.com>
In-Reply-To: <856b918d-ea32-8b88-f366-76ef81f121f9@linaro.org>
Date: Mon, 30 Oct 2023 21:05:41 +0100
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9F2A532F-E797-4026-95DD-A3E3D5AA51E1@icloud.com>
References: <04E66FC8-A5DC-469B-B23E-8FF9E4757915@icloud.com>
 <856b918d-ea32-8b88-f366-76ef81f121f9@linaro.org>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: Apple Mail (2.3774.200.91.1.1)
X-Proofpoint-GUID: yVswqBGnG9o2ZUDuhEV2uI_dECXQI6Br
X-Proofpoint-ORIG-GUID: yVswqBGnG9o2ZUDuhEV2uI_dECXQI6Br
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.572,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2020-02-14=5F11:2020-02-14=5F02,2020-02-14=5F11,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 spamscore=0 mlxscore=0 clxscore=1011 adultscore=0 phishscore=0 bulkscore=0
 mlxlogscore=996 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2310300159
Received-SPF: pass client-ip=17.58.23.194;
 envelope-from=lbryndza.oss@icloud.com; helo=mr85p00im-zteg06021901.me.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi Philippe=20


> Wiadomo=C5=9B=C4=87 napisana przez Philippe Mathieu-Daud=C3=A9 =
<philmd@linaro.org> w dniu 30.10.2023, o godz. 05:18:
>=20
> Hi Lucjan,
>=20
> On 27/10/23 21:37, Lucjan Bryndza wrote:
>> Current implementation of T2 - T5 times on the STM32 platform does =
not work properly.
>> After configuring the timer-counter circuit to report interrupts =
every 10ms, in reality the first interrupt is reported
>> only once after a few seconds, while subsequent interrupts do not =
come.
>> The current code also does not properly emulate the operation of even =
the basic functions of the TIME-BASE unit.
>> This patch contains fixes that reimplements the basic functionality
>> of the time base unit such as up-counting down-counting , and =
alternate-mode up-down counting.
>> The ptimer() API is used to emulate timers.
>> After applying the patch, STM32 timer works correctly in its basic =
functionality.
>> The ISIX-RTOS test unit was used to test the patch.
>> Links and instructions can be found below:
>> =
https://github.com/lucckb/isixrtos/blob/master/tests/libisix/01_basic_prim=
itives.cpp =
<https://github.com/lucckb/isixrtos/blob/master/tests/libisix/01_basic_pri=
mitives.cpp>
>> =
https://github.com/lucckb/isixrtos/blob/master/extras/doc/unit_test_qemu.m=
d =
<https://github.com/lucckb/isixrtos/blob/master/extras/doc/unit_test_qemu.=
md>
>> qemu-system-arm -M olimex-stm32-h405  -kernel =
build/tests/libisix/isixunittests.binary -nographic
>> unittests_entry.cpp:146|ISIX VERSION pub/ep0319-157-gb239b35f-dirty
>> unittests_entry.cpp:83|Exceptions pretest. OK
>> 51 selected tests
>> [   RUN    ] 01_base_00 TimeBase timer vs systick
>> [  1001ms  ] ...
>> [   RUN    ] 01_base_01 Basic heap allocator
>> [   1ms    ] ...
>> Best Regards
>> Lucjan Bryndza
>> =46rom 3ccfe70979d1b263d4fa22104ecf42ac5a628554 Mon Sep 17 00:00:00 =
2001
>> From: Lucjan Bryndza <lbryndza.oss@icloud.com>
>> Date: Thu, 26 Oct 2023 22:45:26 +0200
>> Subject: [PATCH] Fixing the basic functionality of STM32 timers
>> The current implementation of timers does not work properly
>> even in the basic functionality. A counter configured to report
>> an interrupt 10ms every reports the first interrupts after a
>> few seconds.   Count up and
>> count down modes are also not properly implemented. This commit fixes =
bugs with interrupt
>> reporting and implements the basic modes of the counter's
>> time-base block.
>> Signed-off-by: Lucjan Bryndza <lbryndza.oss@icloud.com>
>> ---
>>  hw/arm/stm32f405_soc.c             |   2 +-
>>  hw/timer/stm32f2xx_timer.c         | 291 =
++++++++++++++++++-----------
>>  include/hw/timer/stm32f2xx_timer.h |  23 ++-
>>  3 files changed, 202 insertions(+), 114 deletions(-)
>> diff --git a/hw/arm/stm32f405_soc.c b/hw/arm/stm32f405_soc.c
>> index cef23d7ee4..69316181b3 100644
>> --- a/hw/arm/stm32f405_soc.c
>> +++ b/hw/arm/stm32f405_soc.c
>> @@ -183,7 +183,7 @@ static void stm32f405_soc_realize(DeviceState =
*dev_soc, Error **errp)
>>      /* Timer 2 to 5 */
>>      for (i =3D 0; i < STM_NUM_TIMERS; i++) {
>>          dev =3D DEVICE(&(s->timer[i]));
>> -        qdev_prop_set_uint64(dev, "clock-frequency", 1000000000);
>> +       qdev_prop_set_uint64(dev, "clock-frequency", 48000000);
>=20
> Correct, this is for the 405 SoC.
>=20
>>          if (!sysbus_realize(SYS_BUS_DEVICE(&s->timer[i]), errp)) {
>>              return;
>>          }
>> diff --git a/hw/timer/stm32f2xx_timer.c b/hw/timer/stm32f2xx_timer.c
>> index ba8694dcd3..65f3287125 100644
>> --- a/hw/timer/stm32f2xx_timer.c
>> +++ b/hw/timer/stm32f2xx_timer.c
>> @@ -29,11 +29,18 @@
>>  #include "migration/vmstate.h"
>>  #include "qemu/log.h"
>>  #include "qemu/module.h"
>> +#include "qemu/typedefs.h"
>> +#include "qemu/timer.h"
>> +#include "qemu/main-loop.h"
>> +#include "sysemu/dma.h"
>>  #ifndef STM_TIMER_ERR_DEBUG
>>  #define STM_TIMER_ERR_DEBUG 0
>>  #endif
>> +/* PCLK /4 */
>> +#define CLOCK_FREQUENCY 48000000ULL
>=20
> This timer is generic, we shouldn't enforce a frequency from a
> particular SoC.

Ok I=E2=80=99ve been removed this line=20
>=20
>=20
>>  static const MemoryRegionOps stm32f2xx_timer_ops =3D {
>> @@ -275,7 +353,7 @@ static const VMStateDescription =
vmstate_stm32f2xx_timer =3D {
>>      .version_id =3D 1,
>>      .minimum_version_id =3D 1,
>>      .fields =3D (VMStateField[]) {
>> -        VMSTATE_INT64(tick_offset, STM32F2XXTimerState),
>> +        VMSTATE_INT32(count_mode, STM32F2XXTimerState),
>>          VMSTATE_UINT32(tim_cr1, STM32F2XXTimerState),
>>          VMSTATE_UINT32(tim_cr2, STM32F2XXTimerState),
>>          VMSTATE_UINT32(tim_smcr, STM32F2XXTimerState),
>> @@ -300,25 +378,24 @@ static const VMStateDescription =
vmstate_stm32f2xx_timer =3D {
>>  static Property stm32f2xx_timer_properties[] =3D {
>>      DEFINE_PROP_UINT64("clock-frequency", struct =
STM32F2XXTimerState,
>> -                       freq_hz, 1000000000),
>> +                       freq_hz, CLOCK_FREQUENCY),
>=20
> So here I suggest using '0', and in stm32f2xx_timer_realize() =
propagate
> an error if the frequency is still 0.

Ok.I have changed as you suggested



>=20
>>      DEFINE_PROP_END_OF_LIST(),
>>  };
>=20
> Regards,
>=20
> Phil.


Best Regards
Lucjan=20



