Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5753D7E474B
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 18:43:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Q63-0006z1-7r; Tue, 07 Nov 2023 12:42:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1r0Q5v-0006xt-FA; Tue, 07 Nov 2023 12:42:32 -0500
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1r0Q5m-0005Id-Dq; Tue, 07 Nov 2023 12:42:30 -0500
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-5a82f176860so71324477b3.1; 
 Tue, 07 Nov 2023 09:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699378941; x=1699983741; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=L2hvoR5YVh/gheFJI+MqsmQfWW1bfnPifA7WCM8EUI0=;
 b=bfQsr362/SBz1yv3Wc5FpLzNaA6exO0BX5f8WneNhs3cruwkFKXGvEAIuisYpDTDG7
 zpqlyRC/8B6odISrnNaMKMT2cp974rz+kUu6gnGE3oKRPhEAeDY14/pEFE4J3dYYwrC+
 8oRVxvyFqfw+JzfaUVXkhHDf+y17HG9EqJ7ibQ3qc5I72RVOLE2zAAyJ1I/KDVacje/g
 OHsFHcP4VJ6l2E0wK+Lce58VcTNeBuDoi8qw6d49c1iT+7nkj+icjw6EMPDojyHbux99
 fPCSPvquOLEsjGqie8c6bhDmy0E3DYnnS8SKTYK4XFBBUyN7h/AWZf2ReC+gNYtTRsIP
 8GzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699378941; x=1699983741;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L2hvoR5YVh/gheFJI+MqsmQfWW1bfnPifA7WCM8EUI0=;
 b=NqhmYp3044/w7auEm4vo1dhvFkL89hckuBkdWXEchVtojiQomW5VskrRft0mDBCu/K
 64YKlS7Iy9o/44aNXi39Al9DjgwCh0NyHz5MBDy+rPx6VRT0SrHazkl1BhEPYk1PHFuF
 23I+ctWEBSmi6cIBhfk2mURh7oUUgqu0GuQGSHkdHzvaBNfMAJhaPRKZ49ZwrAzqIKZ8
 nr83VNkxcGgmiLkMiSHlHQMWnqMHC3zR0FylofpkZE+cCxR+AL+DQdcMRHLkU8avU4Fp
 UsUCpLtb6CBNKLEPEs8SEw2fYn+h09nN+0qsNAMb7ntIBuM5ML5Wrbu3gx+1Dsri81bY
 iW6A==
X-Gm-Message-State: AOJu0Ywd41JuE0jZVA4w4JXfe7yO7diz/dCN5Y8FgVe/IxWeNOHYSx+8
 +8h1kbi5rFVC3GzFk8oT4Q8=
X-Google-Smtp-Source: AGHT+IFHgRehbMhH7cfZEpETvZsyGOOVir0B1Q5WCRqMBPfntC2JymTBYbDSepB8gxXu3Rx/gcp9ZA==
X-Received: by 2002:a05:690c:95:b0:5a8:60ad:39a4 with SMTP id
 be21-20020a05690c009500b005a860ad39a4mr15679407ywb.3.1699378940859; 
 Tue, 07 Nov 2023 09:42:20 -0800 (PST)
Received: from [192.168.68.107] ([179.193.10.161])
 by smtp.gmail.com with ESMTPSA id
 w9-20020a817b09000000b0059a34cfa2a5sm5794758ywc.67.2023.11.07.09.42.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Nov 2023 09:42:20 -0800 (PST)
Message-ID: <fa33a840-2135-4ba8-9db1-6684275e93c3@gmail.com>
Date: Tue, 7 Nov 2023 14:42:17 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/3] Add emulation of AmigaOne XE board
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, clg@kaod.org, philmd@linaro.org,
 Bernhard Beschow <shentey@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Rene Engel <ReneEngel80@emailn.de>, vr_qemu@t-online.de
References: <cover.1698406922.git.balaton@eik.bme.hu>
 <697ad2e0-cb23-4efe-89e5-d1b521c0648f@gmail.com>
 <b6ff86da-2532-708a-6737-4489d260c8a7@eik.bme.hu>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <b6ff86da-2532-708a-6737-4489d260c8a7@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=danielhb413@gmail.com; helo=mail-yw1-x1136.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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



On 11/7/23 14:33, BALATON Zoltan wrote:
> On Tue, 7 Nov 2023, Daniel Henrique Barboza wrote:
>> Zoltan,
>>
>> Gitlab is complaining about a missing file in one of the tests:
>>
>>
>>  8/259 qemu:qtest+qtest-ppc / qtest-ppc/test-hmp ERROR           0.22s   killed by signal 6 SIGABRT
>> 4324>>> G_TEST_DBUS_DAEMON=/builds/danielhb/qemu/tests/dbus-vmstate-daemon.sh QTEST_QEMU_BINARY=./qemu-system-ppc MALLOC_PERTURB_=87 PYTHON=/builds/danielhb/qemu/build/pyvenv/bin/python3 /builds/danielhb/qemu/build/tests/qtest/test-hmp --tap -k
>> 4325――――――――――――――――――――――――――――――――――――― ✀ ―――――――――――――――――――――――――――――――――――――
>> 4326stderr:
>> 4327qemu-system-ppc: Could not find firmware 'u-boot-amigaone.bin'
>> 4328Broken pipe
>> 4329../tests/qtest/libqtest.c:195: kill_qemu() tried to terminate QEMU process but encountered exit status 1 (expected 0)
>> 4330(test program exited with status code -6)
>> 4331TAP parsing error: Too few tests run (expected 13, got 0)
>>
>>
>> You can reproduce it like this:
>>
>> $ make -j -C build  && QTEST_QEMU_BINARY=./build/qemu-system-ppc64 ./build/tests/qtest/test-hmp
>>
>> I ended up amending in-tree (downloaded the firmware, put it under pc-bios, updated pc-bios/meson.build).
>> My manual test now passes, but not sure if gitlab will nag about it. Let's wait and see.
> 
> This is handled in the avocado test and it should download the file from the URL there. When tested locally it worked and downloaded the file and extracted the firmware bin from it. Can the gitlab CI download stuff or does it expect it to be in local cache already where you need to put it somehow beforehand? I think Philippe said something about that before but I did not quite get it as I don't know neither avocado nor gitlab. Hope Philippe is reading it and can chime in.

Gitlab CI can download stuff. But note that the error above is not avocado, it's hmp.
It expects a firmware file to be available, and I'm not entirely sure it'll make any
effort (e.g. downloading it) aside from checking if the file exists.
> 
> But the test is not required to run the machine so as a last resort you could just drop the avocado patch and then we can add it later if we can't figure this out now.

Not sure if dropping the avocado test would remediate the situation, but noted.

For now let's push stuff upstream. We have the freeze window to make smaller
adjustments if needed.


Thanks,

Daniel

> 
> Regards,
> BALATON Zoltan
> 
>> I told you: code freeze is a blast! Let's see if it's still sunny for the
>> AmigaOne XE board emulation.
>>
>>
>>
>> Thanks,
>>
>>
>> Daniel
>>
>>
>>
>>
>>
>> On 10/27/23 08:54, BALATON Zoltan wrote:
>>> Changes in v7:
>>> - Increase default memory size to 512m to match pegasos2 and sam460ex
>>> and it's a better default for AmigaOS
>>>
>>> Changes in v6:
>>> - Dropped patch 1, now it's
>>>
>>> Based-on: <20231024224056.842607-1-mark.cave-ayland@ilande.co.uk>
>>>
>>> ([PATCH v2 0/3] ide: implement simple legacy/native mode switching for PCI IDE controllers)
>>> - Added Tested-by from Rene
>>>
>>> Changes in v5:
>>> - Fixed avocado test
>>>
>>> Changes in v4:
>>> - Found typo in comment in patch 1 so ended up rewording it again
>>> trying to make it more concise. Also take the idea of using
>>> range_covers_byte from Mark's patch
>>> - Added RFC patch for avocado test (untested, I don't have Avocado)
>>>
>>> Changes in v3:
>>> - Update values, comment and commit message in patch 1 again
>>>
>>> Changes in v2:
>>> - Update comment and commit message in patch 1 (Mark)
>>> - Fix irq mapping in patch 2 (Volker)
>>>
>>> Regards,
>>> BALATON Zoltan
>>>
>>> BALATON Zoltan (3):
>>>    hw/pci-host: Add emulation of Mai Logic Articia S
>>>    hw/ppc: Add emulation of AmigaOne XE board
>>>    tests/avocado: Add test for amigaone board
>>>
>>>   MAINTAINERS                             |   8 +
>>>   configs/devices/ppc-softmmu/default.mak |   1 +
>>>   hw/pci-host/Kconfig                     |   5 +
>>>   hw/pci-host/articia.c                   | 293 ++++++++++++++++++++++++
>>>   hw/pci-host/meson.build                 |   2 +
>>>   hw/ppc/Kconfig                          |   7 +
>>>   hw/ppc/amigaone.c                       | 164 +++++++++++++
>>>   hw/ppc/meson.build                      |   2 +
>>>   include/hw/pci-host/articia.h           |  17 ++
>>>   tests/avocado/ppc_amiga.py              |  38 +++
>>>   10 files changed, 537 insertions(+)
>>>   create mode 100644 hw/pci-host/articia.c
>>>   create mode 100644 hw/ppc/amigaone.c
>>>   create mode 100644 include/hw/pci-host/articia.h
>>>   create mode 100644 tests/avocado/ppc_amiga.py
>>>
>>
>>

