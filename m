Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D217714AA
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Aug 2023 14:01:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qScQn-0001m9-Kk; Sun, 06 Aug 2023 08:00:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qScQf-0001e6-4I
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:00:16 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qScQY-0005Zc-Bt
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:00:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691323202; x=1691928002; i=deller@gmx.de;
 bh=BKktR5qvDpZhGFDmdKt3homsN0Spxz2G9V86MUsjSCA=;
 h=X-UI-Sender-Class:From:To:Subject:Date;
 b=YRH6I5O23hj3FW8DLAA1BhA5V+YQAsUUoCmtbuOv2vvpbNfnHxp8ZAlw5Ldv5rj23gzOnH2
 mrASEPS7fHXXnoY/teFYCEoErNOyPNcZfMIiqcZQydz8AsWGiZP4fbIiovDYdi56uNpitqoDw
 vAMmNF5q7Ym577bjevo5Q0l1FV7ieN8OsPjrOanqojKFJ8OpsuGWpaRwHCUQkBH2D0MpLlVox
 wOBcfNJsyqEABHI+V5VVFz+HvHeBGeImGmJ9O17RIM2Xqe1hwtVVGYI/8BAT18Jp2hv9MTMzZ
 QtHUcgRBcsvBdwy5EA7cRWkxoXJu4m1DjxCE7U+tOJamNXY0eQPA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.152.250]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MCKBm-1qatto1Lik-009PeD; Sun, 06
 Aug 2023 14:00:02 +0200
From: Helge Deller <deller@gmx.de>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH 00/23] Introduce MMU_INDEX()
Date: Sun,  6 Aug 2023 13:59:38 +0200
Message-ID: <20230806120001.89130-1-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:amxHu7sQZH+QOR8FTA2q50IdjitN5ytnHyx2HBqz8VMkMz0ngtQ
 TY8LMwUQGHkg/bLSWiGdc+uWG76fHXkcBhQ0Tbld68D5sudxGulvl8LEhCkctg6qedY8jy/
 0nJnqkTKbn2D5zdlJyUg6D9SAB34Cdj8tlXiJM8rBFZeVVNV0f+ZeAebfljR31+OjqCbBcQ
 X6ZF33+Dq+aksoyayrg9w==
UI-OutboundReport: notjunk:1;M01:P0:hDuXm34bDf4=;kGzPs5aaCGxzLM8Kq9UtFLY01rr
 XAMrJBpMlsdap5mgIeYqui/q69flHcq1MmwE7upPLNJd8FMeQr7KidNhhjV/DkHLaRTVyUCxR
 HSMGnnzbg+GXQWq+O78zOR3MuWDE7oYuxa8S4BpYpwMNzvAIukWAAP4FL96JOrWAJsNmVTZQU
 5nLXMJLQjLfL8OYGQk+NZvxgnIY1LhbQ+0jyf5dm4s1OWMrRUCWMMuZPOiy53l+N/ezAgwcrL
 EE82GXbSXBKjft6hX/EORY1karJofJUZ0vM8/7QHhbj3BlSpPO7hT3LUq5r2mWqjffQFbps5o
 mCgO5K4OT7WQUPZbDE4N2Rp7i54FN2Pqim3kgH4HwhfqVQBKFqQ6hVONvlsm1kQhSjsxtgZOJ
 dDqCoYmfW9zFhNLudTo/+Gv7lAZl6RDqlXx+xMHjmHJ4qyYgTtYWJiZUQzbQaUBuOOie5NxA1
 6vFdFJkB9AUmJxLVuw2xE+iJH2rxsfsTzTXC0zz71uEiqFf5TmLnYXfjdO4az3P8ZJ88yBgzp
 fMVF/9CyE7t1QBDFTECICXadS/7jNO1nHXLX6DgDe2jHcDUOFyiwGRrh/tEdYpmmafrb63jqv
 TsChz3AxQAxVEcE7oTeCa6YPMJ3THeKj6JiwQxVjzONoCBzXoTDmlAi49b7enm6/n64bp1mh7
 sn1vOisX7EWLdk2qcmBh/QHsGpcW1+LFVCW5IJWMe2GYKd/nwTyMiKfAtNDkg5LKXnYWIsu1Z
 N8+BMEMl8SwVdB7B6Zvi+FAL48SYVDQlxnZshJ0/qWPxD9jptuAnC446b2QymZqNyHTMEMmKx
 g3Egb7KlTLP+34FLW3Ux2iL+PHU+LCdbbbKHuTITqI/dIXxjT2Y32fwTvguyvsKD4mmCr2ajv
 eDP+U0/w+tftoxFjNxkum5s01amwaH5A+FUIkNUVS3a0jQUbHm/cTlgReCEIBFlJmSZjiGHHx
 IZtKt9S/X2nqCmBqhAhWyVNVE/w=
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

This patchset introduces the new helper macro MMU_INDEX().
whill will (after applying the last patch) allow to generate
 smaller code by the tcg.

Patch #1 adds the MMU_INDEX() helper macro, which simply wraps
the given value.

Patches #2-#23 are trivial patches which convert each target to use the MM=
U_INDEX()
macro.

Patch #24 switches MMU_INDEX() to return a new MMU idx which
is counts down from (NB_MMU_MODES-1). That change reduces the needed
negative offset to access the TLB entry which in turn let the tcg compiler
generates smaller instructions.

Please review.

Helge

Helge Deller (23):
  cpu-defs.h; Add MMU_INDEX() helper
  target/i386: Use MMU_INDEX() helper
  target/hppa: Use MMU_INDEX() helper
  target/alpha: Use MMU_INDEX() helper
  target/avr: Use MMU_INDEX() helper
  target/hexagon: Use MMU_INDEX() helper
  target/loongarch: Use MMU_INDEX() helper
  target/mips: Use MMU_INDEX() helper
  target/openrisc: Use MMU_INDEX() helper
  target/riscv: Use MMU_INDEX() helper
  target/s390x: Use MMU_INDEX() helper
  target/sparc: Use MMU_INDEX() helper
  target/xtensa: Use MMU_INDEX() helper
  target/arm: Use MMU_INDEX() helper
  target/cris: Use MMU_INDEX() helper
  target/m68k: Use MMU_INDEX() helper
  target/microblaze: Use MMU_INDEX() helper
  target/m68k: Use MMU_INDEX() helper
  target/ppc: Use MMU_INDEX() helper
  target/rx: Use MMU_INDEX() helper
  target/sh4: Use MMU_INDEX() helper
  target/tricore: Use MMU_INDEX() helper
  cpu-defs.h: Reduce generated code size by inverting MMU_INDEX()

 include/exec/cpu-defs.h   | 10 ++++++++++
 target/alpha/cpu.h        |  6 +++---
 target/arm/cpu.h          |  4 ++--
 target/avr/cpu.h          |  4 ++--
 target/cris/cpu.h         |  4 ++--
 target/hexagon/cpu.h      |  2 +-
 target/hppa/cpu.h         |  6 +++---
 target/i386/cpu.h         | 10 +++++-----
 target/loongarch/cpu.h    |  8 ++++----
 target/m68k/cpu.h         |  6 +++---
 target/microblaze/cpu.h   |  6 +++---
 target/mips/cpu.h         |  6 +++---
 target/nios2/cpu.h        |  4 ++--
 target/openrisc/cpu.h     |  6 +++---
 target/ppc/cpu.h          |  5 +++--
 target/riscv/cpu.h        |  4 ++--
 target/riscv/cpu_helper.c |  2 +-
 target/rx/cpu.h           |  2 +-
 target/s390x/cpu.h        | 10 +++++-----
 target/sh4/cpu.h          |  7 ++++---
 target/sparc/cpu.h        | 20 ++++++++++----------
 target/tricore/cpu.h      |  4 ++--
 target/xtensa/cpu.h       |  4 ++--
 23 files changed, 76 insertions(+), 64 deletions(-)

=2D-
2.41.0


