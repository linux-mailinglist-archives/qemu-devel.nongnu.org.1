Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C597E487A
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 19:42:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0R1e-0000lv-SA; Tue, 07 Nov 2023 13:42:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1r0R1C-0000gv-7e; Tue, 07 Nov 2023 13:41:42 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1r0R0k-0000pc-N5; Tue, 07 Nov 2023 13:41:40 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A976175A4BE;
 Tue,  7 Nov 2023 19:41:22 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 9D27075A4BC; Tue,  7 Nov 2023 19:41:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 9AC8A75A4B7;
 Tue,  7 Nov 2023 19:41:22 +0100 (CET)
Date: Tue, 7 Nov 2023 19:41:22 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Nicholas Piggin <npiggin@gmail.com>, clg@kaod.org, philmd@linaro.org, 
 Bernhard Beschow <shentey@gmail.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Rene Engel <ReneEngel80@emailn.de>, vr_qemu@t-online.de
Subject: Re: [PATCH v7 0/3] Add emulation of AmigaOne XE board
In-Reply-To: <9d50d770-a47a-06e4-5f8c-b710c8926533@eik.bme.hu>
Message-ID: <fda92206-a035-56bd-8786-57a3cc14bd83@eik.bme.hu>
References: <cover.1698406922.git.balaton@eik.bme.hu>
 <697ad2e0-cb23-4efe-89e5-d1b521c0648f@gmail.com>
 <b6ff86da-2532-708a-6737-4489d260c8a7@eik.bme.hu>
 <fa33a840-2135-4ba8-9db1-6684275e93c3@gmail.com>
 <9d50d770-a47a-06e4-5f8c-b710c8926533@eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-528643256-1699382482=:27557"
X-Virus-Scanned: ClamAV using ClamSMTP
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-528643256-1699382482=:27557
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 7 Nov 2023, BALATON Zoltan wrote:
> On Tue, 7 Nov 2023, Daniel Henrique Barboza wrote:
>> On 11/7/23 14:33, BALATON Zoltan wrote:
>>> On Tue, 7 Nov 2023, Daniel Henrique Barboza wrote:
>>>> Zoltan,
>>>> 
>>>> Gitlab is complaining about a missing file in one of the tests:
>>>> 
>>>> 
>>>>  8/259 qemu:qtest+qtest-ppc / qtest-ppc/test-hmp ERROR           0.22s   
>>>> killed by signal 6 SIGABRT
>>>> 4324>>> 
>>>> G_TEST_DBUS_DAEMON=/builds/danielhb/qemu/tests/dbus-vmstate-daemon.sh 
>>>> QTEST_QEMU_BINARY=./qemu-system-ppc MALLOC_PERTURB_=87 
>>>> PYTHON=/builds/danielhb/qemu/build/pyvenv/bin/python3 
>>>> /builds/danielhb/qemu/build/tests/qtest/test-hmp --tap -k
>>>> 4325――――――――――――――――――――――――――――――――――――― ✀ 
>>>> ―――――――――――――――――――――――――――――――――――――
>>>> 4326stderr:
>>>> 4327qemu-system-ppc: Could not find firmware 'u-boot-amigaone.bin'
>>>> 4328Broken pipe
>>>> 4329../tests/qtest/libqtest.c:195: kill_qemu() tried to terminate QEMU 
>>>> process but encountered exit status 1 (expected 0)
>>>> 4330(test program exited with status code -6)
>>>> 4331TAP parsing error: Too few tests run (expected 13, got 0)
>
> OK, how about with v8 of patch2 I've just sent? The other pathches are

OK, sent v9 then. This shuold be it now.

> unchanged so did not resend those. It should allow ronning without -bios for 
> qtest and as this test just runs monitor commands without starting the 
> machine that should be OK. Hopefully this fixes it.
>
> Regards,
> BALATON Zoltan
>
>>>> You can reproduce it like this:
>>>> 
>>>> $ make -j -C build  && QTEST_QEMU_BINARY=./build/qemu-system-ppc64 
>>>> ./build/tests/qtest/test-hmp
>>>> 
>>>> I ended up amending in-tree (downloaded the firmware, put it under 
>>>> pc-bios, updated pc-bios/meson.build).
>>>> My manual test now passes, but not sure if gitlab will nag about it. 
>>>> Let's wait and see.
>>> 
>>> This is handled in the avocado test and it should download the file from 
>>> the URL there. When tested locally it worked and downloaded the file and 
>>> extracted the firmware bin from it. Can the gitlab CI download stuff or 
>>> does it expect it to be in local cache already where you need to put it 
>>> somehow beforehand? I think Philippe said something about that before but 
>>> I did not quite get it as I don't know neither avocado nor gitlab. Hope 
>>> Philippe is reading it and can chime in.
>> 
>> Gitlab CI can download stuff. But note that the error above is not avocado, 
>> it's hmp.
>> It expects a firmware file to be available, and I'm not entirely sure it'll 
>> make any
>> effort (e.g. downloading it) aside from checking if the file exists.
>>> 
>>> But the test is not required to run the machine so as a last resort you 
>>> could just drop the avocado patch and then we can add it later if we can't 
>>> figure this out now.
>> 
>> Not sure if dropping the avocado test would remediate the situation, but 
>> noted.
>> 
>> For now let's push stuff upstream. We have the freeze window to make 
>> smaller
>> adjustments if needed.
>> 
>> 
>> Thanks,
>> 
>> Daniel
>> 
>>> 
>>> Regards,
>>> BALATON Zoltan
>>> 
>>>> I told you: code freeze is a blast! Let's see if it's still sunny for the
>>>> AmigaOne XE board emulation.
>>>> 
>>>> 
>>>> 
>>>> Thanks,
>>>> 
>>>> 
>>>> Daniel
>>>> 
>>>> 
>>>> 
>>>> 
>>>> 
>>>> On 10/27/23 08:54, BALATON Zoltan wrote:
>>>>> Changes in v7:
>>>>> - Increase default memory size to 512m to match pegasos2 and sam460ex
>>>>> and it's a better default for AmigaOS
>>>>> 
>>>>> Changes in v6:
>>>>> - Dropped patch 1, now it's
>>>>> 
>>>>> Based-on: <20231024224056.842607-1-mark.cave-ayland@ilande.co.uk>
>>>>> 
>>>>> ([PATCH v2 0/3] ide: implement simple legacy/native mode switching for 
>>>>> PCI IDE controllers)
>>>>> - Added Tested-by from Rene
>>>>> 
>>>>> Changes in v5:
>>>>> - Fixed avocado test
>>>>> 
>>>>> Changes in v4:
>>>>> - Found typo in comment in patch 1 so ended up rewording it again
>>>>> trying to make it more concise. Also take the idea of using
>>>>> range_covers_byte from Mark's patch
>>>>> - Added RFC patch for avocado test (untested, I don't have Avocado)
>>>>> 
>>>>> Changes in v3:
>>>>> - Update values, comment and commit message in patch 1 again
>>>>> 
>>>>> Changes in v2:
>>>>> - Update comment and commit message in patch 1 (Mark)
>>>>> - Fix irq mapping in patch 2 (Volker)
>>>>> 
>>>>> Regards,
>>>>> BALATON Zoltan
>>>>> 
>>>>> BALATON Zoltan (3):
>>>>>    hw/pci-host: Add emulation of Mai Logic Articia S
>>>>>    hw/ppc: Add emulation of AmigaOne XE board
>>>>>    tests/avocado: Add test for amigaone board
>>>>> 
>>>>>   MAINTAINERS                             |   8 +
>>>>>   configs/devices/ppc-softmmu/default.mak |   1 +
>>>>>   hw/pci-host/Kconfig                     |   5 +
>>>>>   hw/pci-host/articia.c                   | 293 ++++++++++++++++++++++++
>>>>>   hw/pci-host/meson.build                 |   2 +
>>>>>   hw/ppc/Kconfig                          |   7 +
>>>>>   hw/ppc/amigaone.c                       | 164 +++++++++++++
>>>>>   hw/ppc/meson.build                      |   2 +
>>>>>   include/hw/pci-host/articia.h           |  17 ++
>>>>>   tests/avocado/ppc_amiga.py              |  38 +++
>>>>>   10 files changed, 537 insertions(+)
>>>>>   create mode 100644 hw/pci-host/articia.c
>>>>>   create mode 100644 hw/ppc/amigaone.c
>>>>>   create mode 100644 include/hw/pci-host/articia.h
>>>>>   create mode 100644 tests/avocado/ppc_amiga.py
>>>>> 
>>>> 
>>>> 
>> 
>
--3866299591-528643256-1699382482=:27557--

