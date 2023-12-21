Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D8681C0B1
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 23:01:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGR5i-0003ug-QX; Thu, 21 Dec 2023 17:00:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rGR5g-0003u8-RW
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 17:00:28 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rGR5e-0003ZH-V6
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 17:00:28 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40d2e56f3a6so7505905e9.1
 for <qemu-devel@nongnu.org>; Thu, 21 Dec 2023 14:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703196023; x=1703800823; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A0dXbM/oAAuWOMM4vRRq44+m6Dp5jVD+mER24v9B3jE=;
 b=ipUzsR1v7mQ4tVmryZ71aziR8A6PsmF4Y2zvnqsFk8pJMkOUg2yWCkVkPBizoZqubs
 cUEMm1qfJlqWcfr6i4U+GdDxkJOoLYqtNbw5O1G0GArdhpdyy18+5AXmQGbl9O33vLnu
 nyqEASvyJuioOMxqCQTaov4DoON/NJkW8JW5BKIpGY8NZHI9J/GFO1E9D/GoegZgkU1f
 M20+qWVv4WW8ZQBrlUnBGAIDb3PmF/JHNI0NGHf2/8STz9VeRX1ZENKALVbnnbtrFf5o
 GoKIZr1FjSK9olBnO1SvKOxc6SrMpq+ebcgInkYsLpzP9apNNJvFQTKTLDMpN4yceSO2
 Jmyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703196023; x=1703800823;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=A0dXbM/oAAuWOMM4vRRq44+m6Dp5jVD+mER24v9B3jE=;
 b=GZE8KVRG3+oJNYbVv/XD+6hgHgMJdun+hkGrcuBwHLNqsJugXizOWXNFeUOG6cvZmr
 BLK/MMDx1iecO7iwr0cIosY9sPMZGw3lR1zu4a+80HlPKN4kJ64lQDTulhxvkpbmeiJv
 GRSGxfWxUSdp86bl+MVsa81YevzmBTvkcqsYsTcxWXA0jlz0YFGEVbjKtuiKEQWYhxmF
 5N55aSGTO3fbgwB9ewUAUTlTtijMLYC8xAiZLV3bXwCFSXzjcoi9b6nEoOS7f9zltS8q
 xHoFQGKAlRsgH2aiOu9kqBMlNZJFqhxsj5jnq5zyiy6V9ZurfO8lTVMfznaj7aTFO2KZ
 BYgQ==
X-Gm-Message-State: AOJu0YzwJFcz9qPzHmCs3T3iAiqzWdMWSr3yqffqWeEFJhbEp2MJLLOs
 Zz1gJZ8hmabATR2JwNswdOOFUF2O7eW0dQ==
X-Google-Smtp-Source: AGHT+IGhnVJLfhf6N8SWi9MpzKNBb0P0jcPnf4Vb19M5QriaqjKgyl4CJxy996IWVCmJ5qxPlguGRA==
X-Received: by 2002:a05:600c:d3:b0:40b:5e4a:2360 with SMTP id
 u19-20020a05600c00d300b0040b5e4a2360mr160193wmm.98.1703196023228; 
 Thu, 21 Dec 2023 14:00:23 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 p6-20020a05600c468600b004053e9276easm12303067wmo.32.2023.12.21.14.00.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 14:00:22 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5401C5F8B5;
 Thu, 21 Dec 2023 22:00:22 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: QEMU Developers <qemu-devel@nongnu.org>,  Peter Maydell
 <peter.maydell@linaro.org>
Subject: Re: virtio-pci in qemu-system-arm is broken in 8.2
In-Reply-To: <87frzvzafv.fsf@draig.linaro.org> ("Alex =?utf-8?Q?Benn=C3=A9?=
 =?utf-8?Q?e=22's?= message of "Thu, 21 Dec 2023 18:18:12 +0000")
References: <90d7351c-2680-4ab6-95ee-5dac4e3f21c5@tls.msk.ru>
 <87frzvzafv.fsf@draig.linaro.org>
User-Agent: mu4e 1.11.26; emacs 29.1
Date: Thu, 21 Dec 2023 22:00:22 +0000
Message-ID: <87a5q3z05l.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Michael Tokarev <mjt@tls.msk.ru> writes:
>
>> It looks like virtio-pci is entirely broke in qemu-system-arm, at least =
in tcg
>> mode running on x86.  The guest (current linux system) just does not det=
ect
>> any virtio-pci devices at all.
>>
>> When 8.1 is booting, the following messages are displayed (debian initra=
mfs):
>>
>> Loading, please wait...
>> Starting systemd-udevd version 255-1
>> [    6.455941] virtio-pci 0000:00:01.0: enabling device (0100 -> 0103)
>> [    6.929155] virtio-pci 0000:00:02.0: enabling device (0100 -> 0103)
>> [    7.764652] virtio_blk virtio1: 2/0/0 default/read/poll queues
>> [    7.783216] virtio_blk virtio1: [vda] 2097026 512-byte logical blocks=
 (1.07 GB/1024 MiB)
>> [    8.636453] virtio_net virtio0 enp0s1: renamed from eth0
>>
>> But when 8.2 is booting, it ends up at:
>>
>> Loading, please wait...
>> Starting systemd-udevd version 255-1
>> ..and nothing.  here it waits for the root fs to appear, and drops into =
the shell
>>
>> git bisect points at this commit:
>>
>> commit b8f7959f28c4f36496bc0a694fa28bf5078152c5
>> Author: Peter Maydell <peter.maydell@linaro.org>
>> Date:   Mon Jul 24 18:43:33 2023 +0100
>>
>>     target/arm: Do all "ARM_FEATURE_X implies Y" checks in post_init
>>
>> Reverting this commit on top of 8.2.0 (or current qemu master)
>> makes things works again.
>>
>> It's interesting how we missed this out entirely, as it's been applied
>> at the beginning of 8.2 development cycle, it's 228th commit after
>> 8.1.0.
>>
>> It looks like we've quite a bit more regressions like this in 8.2.0..
>> :(
>
> We have at least one test that does use virtio-pci on qemu-system-arm
> and passes. From:
>
>   ./pyvenv/bin/avocado run ./tests/avocado --filter-by-tags=3Darch:arm
>
> We can see:
>
>   grep "virtio" /home/alex/avocado/job-results/job-2023-12-21T18.11-8dc03=
b2/job.log | grep pci
>   2023-12-21 18:14:31,294 machine L0470 DEBUG| VM launch command:
> './qemu-system-arm -display none -vga none -chardev socket,id=3Dmon,fd=3D5
> -mon chardev=3Dmon,mode=3Dcontrol -machine versatilepb -chardev
> socket,id=3Dconsole,fd=3D19 -serial chardev:console -cpu arm926 -kernel
> /home/alex/avocado/data/cache/by_location/a8e6fbd14f0270fef06aaef9fc413c5=
a6ed71120/zImage
> -append printk.time=3D0 root=3D/dev/vda console=3DttyAMA0 -blockdev
> driver=3Draw,file.driver=3Dfile,file.filename=3D/home/alex/avocado/job-re=
sults/job-2023-12-21T18.11-8dc03b2/test-results/tmp_dir1mqewwjv/40-._tests_=
avocado_tuxrun_baselines.py_TuxRunBaselineTest.test_armv5/rootfs.ext4,node-=
name=3Dhd0
> -device virtio-blk-pci,drive=3Dhd0 -dtb
> /home/alex/avocado/data/cache/by_location/a8e6fbd14f0270fef06aaef9fc413c5=
a6ed71120/versatile-pb.dtb'
>   2023-12-21 18:14:31,722 __init__         L0153 DEBUG| virtio-pci 0000:0=
0:0d.0: enabling device (0100 -> 0103)
>
> But obviously not enough coverage to catch this regression.

modified   tests/avocado/tuxrun_baselines.py
@@ -168,7 +168,7 @@ def run_tuxtest_tests(self, haltmsg):
     def common_tuxrun(self,
                       csums=3DNone,
                       dt=3DNone,
-                      drive=3D"virtio-blk-device",
+                      drive=3D"virtio-blk-pci",
                       haltmsg=3D"reboot: System halted",
                       console_index=3D0):
         """

And then we get:

 (1/3) ./tests/avocado/tuxrun_baselines.py:TuxRunBaselineTest.test_armv5: P=
ASS (5.64 s)
 (2/3) ./tests/avocado/tuxrun_baselines.py:TuxRunBaselineTest.test_armv7: F=
AIL: Failure message found in console: "Kernel panic - not syncing". Expect=
ed: "Welcome to TuxTest" (1.21 s)
 (3/3) ./tests/avocado/tuxrun_baselines.py:TuxRunBaselineTest.test_armv7be:=
 FAIL: Failure message found in console: "Kernel panic - not syncing". Expe=
cted: "Welcome to TuxTest" (1.24 s)
RESULTS    : PASS 1 | ERROR 0 | FAIL 2 | SKIP 0 | WARN 0 | INTERRUPT 0 | CA=
NCEL 0
JOB TIME   : 8.50 s

So I guess this somehow hits ARMv7 only. Maybe something about I/O
access?

  2023-12-21 18:21:29,424 __init__         L0153 DEBUG| pl061_gpio 9030000.=
pl061: PL061 GPIO chip registered
  2023-12-21 18:21:29,427 __init__         L0153 DEBUG| pci-host-generic 40=
10000000.pcie: host bridge /pcie@10000000 ranges:
  2023-12-21 18:21:29,428 __init__         L0153 DEBUG| pci-host-generic 40=
10000000.pcie:       IO 0x003eff0000..0x003effffff -> 0x0000000000
  2023-12-21 18:21:29,428 __init__         L0153 DEBUG| pci-host-generic 40=
10000000.pcie:      MEM 0x0010000000..0x003efeffff -> 0x0010000000
  2023-12-21 18:21:29,428 __init__         L0153 DEBUG| pci-host-generic 40=
10000000.pcie:      MEM 0x8000000000..0xffffffffff -> 0x8000000000
  2023-12-21 18:21:29,429 __init__         L0153 DEBUG| pci-host-generic 40=
10000000.pcie: can't claim ECAM area [mem 0x10000000-0x1fffffff]: address c=
onflict with pcie@10000000 [mem 0x10000000-0x3efeffff]
  2023-12-21 18:21:29,429 __init__         L0153 DEBUG| pci-host-generic: p=
robe of 4010000000.pcie failed with error -16

>
>>
>> /mjt

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

