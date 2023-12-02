Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BFD801D12
	for <lists+qemu-devel@lfdr.de>; Sat,  2 Dec 2023 14:42:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9QEh-00056C-4Q; Sat, 02 Dec 2023 08:40:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1r9QEa-00055L-PS
 for qemu-devel@nongnu.org; Sat, 02 Dec 2023 08:40:40 -0500
Received: from mail-b.sr.ht ([173.195.146.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1r9QET-0008Us-Ic
 for qemu-devel@nongnu.org; Sat, 02 Dec 2023 08:40:36 -0500
Authentication-Results: mail-b.sr.ht; dkim=none 
Received: from git.sr.ht (unknown [173.195.146.142])
 by mail-b.sr.ht (Postfix) with ESMTPSA id 6D85711EF32;
 Sat,  2 Dec 2023 13:40:32 +0000 (UTC)
From: ~lbryndza <lbryndza@git.sr.ht>
Date: Sat, 02 Dec 2023 13:40:32 +0000
Subject: [PATCH qemu v3 00/20] Fix malfunctioning of T2-T5 timers on the STM32
 platform
MIME-Version: 1.0
Message-ID: <170152443229.18048.53824064267512246-0@git.sr.ht>
X-Mailer: git.sr.ht
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair23@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=173.195.146.151; envelope-from=outgoing@sr.ht;
 helo=mail-b.sr.ht
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_REPLYTO=2.095,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
Reply-To: ~lbryndza <lbryndza.oss@icloud.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Current implementation of T2 - T5 times on the STM32 platform does not
work properly.
After configuring the timer-counter circuit to report interrupts every
10ms, in reality the first interrupt is reported
only once after a few seconds, while subsequent interrupts do not come.
The current code also does not properly emulate the operation of even
the basic functions of the TIME-BASE unit.
This patch contains fixes that reimplements the basic functionality
of the time base unit such as up-counting down-counting , and alternate-
mode up-down counting.
The ptimer() API is used to emulate timers.
After applying the patch, STM32 timer works correctly in its basic
functionality.
The ISIX-RTOS test unit was used to test the patch.
Links and instructions can be found below:

https://github.com/lucckb/isixrtos/blob/master/tests/libisix/01_basic_primiti=
ves.cpp
https://github.com/lucckb/isixrtos/blob/master/extras/doc/unit_test_qemu.md


qemu-system-arm -M olimex-stm32-h405  -kernel
build/tests/libisix/isixunittests.binary -nographic
unittests_entry.cpp:146|ISIX VERSION pub/ep0319-157-gb239b35f-dirty
unittests_entry.cpp:83|Exceptions pretest. OK
51 selected tests
[   RUN    ] 01_base_00 TimeBase timer vs systick
[  1001ms  ] ...
[   RUN    ] 01_base_01 Basic heap allocator
[   1ms    ] ...

Lucjan Bryndza (20):
  Fixing the basic functionality of STM32 timers
  Fixing the basic functionality of STM32 timers
  Fixing the basic functionality of STM32 timers
  Fixing the basic functionality of STM32 timers
  Fixing the basic functionality of STM32 timers
  Fixing the basic functionality of STM32 timers
  Fixing the basic functionality of STM32 timers
  Fixing the basic functionality of STM32 timers
  Fixing the basic functionality of STM32 timers
  Fixing the basic functionality of STM32 timers
  Fixing the basic functionality of STM32 timers
  Fixing the basic functionality of STM32 timers
  Fixing the basic functionality of STM32 timers
  Fixing the basic functionality of STM32 timers
  Fixing the basic functionality of STM32 timers
  Fixing the basic functionality of STM32 timers
  Fixing the basic functionality of STM32 timers
  Fixing the basic functionality of STM32 timers
  Fixing the basic functionality of STM32 timers
  Fixing the basic functionality of STM32 timers

 hw/arm/stm32f405_soc.c             |   2 +-
 hw/timer/stm32f2xx_timer.c         | 262 +++++++++++++++++++----------
 include/hw/timer/stm32f2xx_timer.h |  23 ++-
 3 files changed, 189 insertions(+), 98 deletions(-)

--=20
2.38.5

