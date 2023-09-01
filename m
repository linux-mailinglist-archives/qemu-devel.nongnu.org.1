Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C59978FFC1
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 17:13:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc5pG-0007aN-Gc; Fri, 01 Sep 2023 11:12:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qc5oz-0007YL-Q9
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 11:12:31 -0400
Received: from mout.gmx.net ([212.227.15.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qc5ov-0005xa-Ie
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 11:12:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1693581143; x=1694185943; i=deller@gmx.de;
 bh=2w4DaA5p9fnT8REbrlN5S6EUOK88ccX76Pgxi6gyDL8=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=ov9zem2GhctQsIYs5aJB+ktIG2TZMLkdp2G17tvETtW1ttSqXBtLVKXQ6wPkU6ZpciAkC29
 jqgWHgAd5sp+XSPVPk9ukp4hbrLCIPhJRFjNUmQkmq3Vb9pzbZmnRDJ4SZuiHUt1wPBroubOS
 H3C8rhGuO2a1iYGY0Q2zlKqHRNELBdYw32wiKXZmaAy+aQdPX53S1yr+xGk1bNcqzeulA7thG
 IIXpPh266vnc4XussF7wHdYWlcG5/cGXr21upUM9mRM9oucqlOxldiqzR64ogcPlPg578aPcn
 pI01C814FR8xosgZa03n93EL4/yE+DmdWiMIpMIqX+YccMsl1kdQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.152.187]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M72oH-1qbEbZ3iAR-008YrJ; Fri, 01
 Sep 2023 17:12:22 +0200
Message-ID: <c3ade361-12e4-9a0e-6bf2-39b926109d78@gmx.de>
Date: Fri, 1 Sep 2023 17:12:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 00/13] linux-user patch queue
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230824010237.1379735-1-richard.henderson@linaro.org>
 <05129269-b718-53e0-0a1d-d8640ea9b57f@linaro.org>
From: Helge Deller <deller@gmx.de>
In-Reply-To: <05129269-b718-53e0-0a1d-d8640ea9b57f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QCYp1xHF4NOmA7LSAmsv7M0TRWuWjrczfaIS332kxWJO6vf+8oO
 J2GRrgRJG11Xds4Ux5Z9KUneWGyYAw9HA6P7wlka8f2mk3fCnYtUGxcbsb/Ep/QVlIwz9V4
 oZqRKjcW1gTsWU7aTAb3OpOkKpyi+QjT37M62wpYhB5J9wK3FbY2cc2Gus4LTfpSF56Mn7L
 QbPe4tXu5kpKTyrvayolw==
UI-OutboundReport: notjunk:1;M01:P0:B3QmtdYpV/U=;J0N7Ikao56wzpcXU1DrYoHATpyB
 2Pc+YM50MTxjIkrqDE+0M2TJidkzGIo3xF4V59h5cCEOtTJQ+gZfK49CJDnVkPDHFKiNzY60S
 RqIb2KkrnGlFsM6Fkw3O2xNhu6s+W+T4DBo5VAoU0lDwK4fAZdkSxRxaYk+di0zvMHK6/ZKBi
 /53h2SFEcTqDPzqBRrWDcBmsw6FFFao6nfKmCURHLw/PolDpdrNIHJ0iFwPjVQwOK+MH8UrYN
 Xx7i+xsW6Rn+28O3hOUNpiLYuScifSHQErnU45Z2WnwQddLh/8t8GExuL/8A2/RL99u7ou9bM
 ohL81QTessUCZWULmTGKQVWNEpbBMZNhZI4bhBLGVv5IRmcVHw6PJdqKlHSsmW1FXhxVU/gVT
 +LThQZ0oHT6gFXntuOip56Yh00fQIUfitcCdNYwwcFiuCz9T8XcmQ2jAhUejNZ/Xa4RdViCDk
 /be5uN9ekRMfVolYMZQwYnftQLM5ShWuowksQSrFmL0F9755XsN98SJlOInOdyUftEl0EH3PK
 OgIWTqRynZ76MH4/olUP9t+sSg8luy/VHWPoNoO15IWWUH7Gjs4rfrg3RC2sThVyg4B2TRLs0
 9g/nFwyB2oVTD7tUVKKugYhX0tY4Pkgx/rejJfDvCv+vQSF6hKOCPx4FYVQHfjzpHnavflIkI
 Vq20md902Nuc6ZD/w+Npy/fRBsPGBx/kAzRIYkiHdFBI+OdQM4rqk9Kwohu5T5XTosV09NJBB
 YYoa0CADqY83FA10LVHdMqNq0uFZE7u4sthjQ6V7ivktUl3o6B4PEbjgDu8wzT1YJ8JjCfR4T
 L0qT3Q5D9vW0BQZc4hrPmtdxkaoqoqf6umDtThzoT+H08wIqk4838/lqZN2QLx57K+FZCHWV4
 xX/ihr5p8stlF/ojEYkoYEtqwMZsPHYGPrT02XCSge9VLRp5cBh7RzcX5WvCQEMH1XfffXrPI
 oBaWf9sVceYsEHFGUCxsQOnKWlQ=
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FREEMAIL_REPLY=1, NICE_REPLY_A=-3.478, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 9/1/23 04:32, Richard Henderson wrote:
> Ping.

Basic testing with my chroots seems to give no
problems, so for the series:

Tested-by: Helge Deller <deller@gmx.de>

Helge

>
> On 8/23/23 18:02, Richard Henderson wrote:
>> Combine a bunch of smaller linux-user patches:
>>
>> Supercedes: 20230801230842.414421-1-deller@gmx.de
>> ("[PATCH v2 0/3] linux-user: /proc/cpuinfo fix and content emulation fo=
r arm")
>> Supercedes: 20230807122206.655701-1-iii@linux.ibm.com
>> ("[PATCH v2] linux-user: Emulate the Anonymous: keyword in /proc/self/s=
maps")
>> Supercedes: 20230816181437.572997-1-richard.henderson@linaro.org
>> ("[PATCH 0/6] linux-user: Rewrite open_self_maps")
>> Supercedes: 20230820204408.327348-1-richard.henderson@linaro.org
>> ("[PATCH 0/4] linux-user: shmat/shmdt improvements")
>>
>> with some additions.=C2=A0 Patches needing review:
>>
>> =C2=A0=C2=A0 01-linux-user-Split-out-cpu-target_proc.h.patch
>> =C2=A0=C2=A0 11-linux-user-Use-WITH_MMAP_LOCK_GUARD-in-target_-shmat.pa=
tch
>> =C2=A0=C2=A0 12-linux-user-Fix-shmdt.patch
>> =C2=A0=C2=A0 13-linux-user-Track-shm-regions-with-an-interval-tree.patc=
h
>>
>>
>> r~
>>
>>
>> Helge Deller (2):
>> =C2=A0=C2=A0 linux-user: Emulate /proc/cpuinfo on aarch64 and arm
>> =C2=A0=C2=A0 linux-user: Emulate /proc/cpuinfo for Alpha
>>
>> Ilya Leoshkevich (1):
>> =C2=A0=C2=A0 linux-user: Emulate the Anonymous: keyword in /proc/self/s=
maps
>>
>> Richard Henderson (10):
>> =C2=A0=C2=A0 linux-user: Split out cpu/target_proc.h
>> =C2=A0=C2=A0 util/selfmap: Use dev_t and ino_t in MapInfo
>> =C2=A0=C2=A0 linux-user: Use walk_memory_regions for open_self_maps
>> =C2=A0=C2=A0 linux-user: Adjust brk for load_bias
>> =C2=A0=C2=A0 linux-user: Show heap address in /proc/pid/maps
>> =C2=A0=C2=A0 linux-user: Remove ELF_START_MMAP and image_info.start_mma=
p
>> =C2=A0=C2=A0 linux-user: Move shmat and shmdt implementations to mmap.c
>> =C2=A0=C2=A0 linux-user: Use WITH_MMAP_LOCK_GUARD in target_{shmat,shmd=
t}
>> =C2=A0=C2=A0 linux-user: Fix shmdt
>> =C2=A0=C2=A0 linux-user: Track shm regions with an interval tree
>>
>> =C2=A0 include/qemu/selfmap.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 4 +-
>> =C2=A0 linux-user/aarch64/target_proc.h=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
=C2=A0 1 +
>> =C2=A0 linux-user/alpha/target_proc.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 67 ++++
>> =C2=A0 linux-user/arm/target_proc.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 101 ++++++
>> =C2=A0 linux-user/cris/target_proc.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 1 +
>> =C2=A0 linux-user/hexagon/target_proc.h=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
=C2=A0 1 +
>> =C2=A0 linux-user/hppa/target_proc.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 26 ++
>> =C2=A0 linux-user/i386/target_proc.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 1 +
>> =C2=A0 linux-user/loader.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 6 =
+-
>> =C2=A0 linux-user/loongarch64/target_proc.h |=C2=A0=C2=A0 1 +
>> =C2=A0 linux-user/m68k/target_proc.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 16 +
>> =C2=A0 linux-user/microblaze/target_proc.h=C2=A0 |=C2=A0=C2=A0 1 +
>> =C2=A0 linux-user/mips/target_proc.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 1 +
>> =C2=A0 linux-user/mips64/target_proc.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 1 +
>> =C2=A0 linux-user/nios2/target_proc.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 1 +
>> =C2=A0 linux-user/openrisc/target_proc.h=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0 1 +
>> =C2=A0 linux-user/ppc/target_proc.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
>> =C2=A0 linux-user/qemu.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 1 -
>> =C2=A0 linux-user/riscv/target_proc.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 37 ++
>> =C2=A0 linux-user/s390x/target_proc.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 109 ++++++
>> =C2=A0 linux-user/sh4/target_proc.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
>> =C2=A0 linux-user/sparc/target_proc.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 16 +
>> =C2=A0 linux-user/user-mmap.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 4 +
>> =C2=A0 linux-user/x86_64/target_proc.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 1 +
>> =C2=A0 linux-user/xtensa/target_proc.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 1 +
>> =C2=A0 linux-user/elfload.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 170 ++++++---
>> =C2=A0 linux-user/mmap.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 16=
8 +++++++++
>> =C2=A0 linux-user/syscall.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 514 +++++++------=
--------------
>> =C2=A0 util/selfmap.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 12 +-
>> =C2=A0 29 files changed, 828 insertions(+), 437 deletions(-)
>> =C2=A0 create mode 100644 linux-user/aarch64/target_proc.h
>> =C2=A0 create mode 100644 linux-user/alpha/target_proc.h
>> =C2=A0 create mode 100644 linux-user/arm/target_proc.h
>> =C2=A0 create mode 100644 linux-user/cris/target_proc.h
>> =C2=A0 create mode 100644 linux-user/hexagon/target_proc.h
>> =C2=A0 create mode 100644 linux-user/hppa/target_proc.h
>> =C2=A0 create mode 100644 linux-user/i386/target_proc.h
>> =C2=A0 create mode 100644 linux-user/loongarch64/target_proc.h
>> =C2=A0 create mode 100644 linux-user/m68k/target_proc.h
>> =C2=A0 create mode 100644 linux-user/microblaze/target_proc.h
>> =C2=A0 create mode 100644 linux-user/mips/target_proc.h
>> =C2=A0 create mode 100644 linux-user/mips64/target_proc.h
>> =C2=A0 create mode 100644 linux-user/nios2/target_proc.h
>> =C2=A0 create mode 100644 linux-user/openrisc/target_proc.h
>> =C2=A0 create mode 100644 linux-user/ppc/target_proc.h
>> =C2=A0 create mode 100644 linux-user/riscv/target_proc.h
>> =C2=A0 create mode 100644 linux-user/s390x/target_proc.h
>> =C2=A0 create mode 100644 linux-user/sh4/target_proc.h
>> =C2=A0 create mode 100644 linux-user/sparc/target_proc.h
>> =C2=A0 create mode 100644 linux-user/x86_64/target_proc.h
>> =C2=A0 create mode 100644 linux-user/xtensa/target_proc.h
>>
>
>


