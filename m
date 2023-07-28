Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FE07675EC
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 20:58:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPRJn-0006XS-1O; Fri, 28 Jul 2023 13:31:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qPRJX-0006UJ-0N
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 13:31:44 -0400
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qPRJP-0002nC-0S
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 13:31:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690565487; x=1691170287; i=deller@gmx.de;
 bh=COA1ky/p5KI/5DvnYLh995JoBAeRr2vBdci9X1nlkQw=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=qtmhPFnVBU6lJfO756jC6TApTIotK10YynBxzYpljAZmf79+cuX9SMENJ+ojJUakPU6ENGH
 txifMVwa+xDj2pp9Jar2zXDzbZLyAGQ8w6ZOaGd1bgEMbAX1eLcrdard9XexO/8k/zBOZgsZB
 rdQPk/YxqB8EOuKowasV0rroY5WGpcRJnE/Id9bE5FRbK3nbaoPkkXrk3bs8NoEYh8mpJY/Lh
 YugtXQDE6n9KxEYlQ5V5IBPRJ/ruyci69fjA/ySUsV2oOXp24iTAWcGedPX/pK3079HxM6Jc4
 oKwkRrHW9CHcA6nVwNOXHB1gdBGMRJz9bRTNeRVjCH6KeFNVcYdg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.159.73]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MMGRA-1q8K892pIk-00JJBQ; Fri, 28
 Jul 2023 19:31:27 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH v5 0/3] linux-user: Fix and optimize target memory layout
Date: Fri, 28 Jul 2023 19:31:23 +0200
Message-ID: <20230728173127.259192-1-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HAGpyvz3guXKbH4Ly8D+azQqh3ikJZimrLGiO9XQA2F+Z+vUZsu
 ESzaEgOZVsNHCYhTQZvme1Dn4WJ9pvsas6Fo873Se4cR7zUKVsKd+P5tsCsy3aliMk+9zNV
 1t5E7bgudeUe3Wi5KAoMjHusu7PQGXDESFhENUgkPVdrCcA5e+9s/0EWxFG1ttHllnXGJaY
 lkM7KgMBnfNunRWpPIePQ==
UI-OutboundReport: notjunk:1;M01:P0:AQzDP2GjPIc=;H2M76XkkXhDpWZZ7ufa0Q8QEIIS
 t44WM4/+Xyl9J+9uERrNP6xmJqUVssb2Ty0MLgu0n84RfgbJc/hH+1360GiS+FIGvrrxcc4By
 vcrhRPF3+8BInfPJcgVw6v69nZkHRg+WOsskBu1k8HOgAZwBI4IlviMog6hi9Tc3YAqrvQbw6
 rGvQtSzSX+o25GXGtH0DMHtPvgn+BzqFeiajCxQIG72UCYSiNAGbqebLEnlwz1EnT93pc3Xhz
 zq6mLmAdsYqjgq9extFJIB7QiLri0esWb04xXzoYJ8g3dCf9euFgVxlNdIfTEudPJOQAiI0pI
 UpEDTuo8dyYIASqREn5uRSJmjsHEX3o3E21NeYXxpOx6l0Y8y2b79v8Z5y4hRzXmHFWlSJcFb
 KUVjbQn9AqVEtw2STt0cD+W+e7LGZn4Rr+/Ge2v6z9ygFm6iCrz4boVE+eFgK+I97QNNIu349
 FOJLyy6u5fpd+6tQwy4zq1dbS7SoGzgwj+yX5t2KZp/Yfg+J6FvHgvCoCP/D02VEC0+7u0cBw
 iMXkwMnVcPAV02Y6efEFSfqt772farfrdRLxqWLF9HmVpxe+QKfX1a4Dq1ybXvRIeJC8HlKWo
 LX+z4kBJoZOKH4KAkVlRxgnI8TsGBAMYVlIfEIyBcxHQNyr5A7lBEe/3KbSobu40SDqAnjZQf
 PiZ4mCIjx3jqM1mI4JScqVSPDGQjow8rXP5uGp7Xzs8hbwXLdvBjmSrUlPp84iK/czPcw5P8q
 DVHARw40KlUOJlPFUkevxB+e8zSePRmTP+2UuQNRyeknWsiRJCvimsyM9EXlMhnm2rOdIrS+j
 cwZ1dFjSLPLV9yYsXyGiaMrEdM/0lJXG6yXHZ/3I8IgZH7HNTOYStUlC1cdjYwvLhhxra8/L+
 /uK6zq15GJ0PpTRRObPaoESdx5jfept9eOaDnyQNVARe1ZRsWg6/gl5+bDisygqTyAB9TNybF
 CCBLSCJEMhN+0Wpt2hVIVace/es=
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

While trying to fix a bug which prevents running a static
armhf binary with linux-user, I noticed a whole bunch of
memory layout issues on various platforms. Most noteably
the free heap space was very limited in the current setup.
A large heap is important for example, if you want to
use qemu-user for building Linux packages where gcc requires
lots of space (e.g. using qemu-user as buildd for debian
packages).

Those findings led to this patch series, which
- fixes qemu-arm to run static armhf binaries
- shows the address of heap in /proc/self/maps output on
  all architectures
- optimizes address layout of loaded executable
- increases free heap for guest apps

NOTE:
- this patch series is for qemu v8.1.0-rc ONLY.
- do not apply on top of v8.0-stable series, which uses
  a different search algorithm for free mmap memory
  and thus will give incorrect memory layouts.

If people want to check, you may pull from here:
https://github.com/hdeller/qemu-hppa/tree/brk-fixes-2

It would be great if other people would test as well, and
if this patch series would be considered for inclusion into
8.0-rc release.

I tested the patch series on top of git head with chroots of alpha, arm,
armel, arm64, hppa, m68k, mips64el, mipsel, powerpc, ppc64, ppc64el,
s390x, sh4 and sparc64 on a x86-64 host.
The memory layout of git head and the layout with this patch series are
both shown below as reference.

Changes:
v5:
- Runtime-checked on many target architectures
- Calculate valid memory layout based on GUEST_ADDR_MAX limit
- Really fixed showing heap in /proc/self/maps for all architectures
v4:
- add note that patch series is for v8.1.0-rc only
- changed TASK_UNMAPPED_BASE for 32- on 64-bit userspace

=2D-----------------------------------------------------------------------=
------------
Memory layout with this patch series applied:
(output of: "uname -a && cat /proc/self/maps" from inside the chroot)

alpha-chroot
Linux p100 6.4.4-200.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Wed Jul 19 16:32:4=
9 UTC 2023 alpha GNU/Linux
120000000-12000a000 r-xp 00000000 fd:00 417269                           /=
usr/bin/cat
12000a000-12001e000 ---p 00000000 00:00 0
12001e000-120020000 r--p 0000e000 fd:00 417269                           /=
usr/bin/cat
120020000-120022000 rw-p 00000000 00:00 0
120022000-120044000 rw-p 00000000 00:00 0                                [=
heap]
7000000000-7000002000 ---p 00000000 00:00 0
7000002000-7000802000 rw-p 00000000 00:00 0                              [=
stack]
7000802000-7000830000 r-xp 00000000 fd:00 421566                         /=
usr/lib/alpha-linux-gnu/ld-linux.so.2
7000830000-7000840000 ---p 00000000 00:00 0
7000840000-7000842000 r--p 0002e000 fd:00 421566                         /=
usr/lib/alpha-linux-gnu/ld-linux.so.2
7000842000-7000844000 rw-p 00030000 fd:00 421566                         /=
usr/lib/alpha-linux-gnu/ld-linux.so.2
7000844000-7000846000 r-xp 00000000 00:00 0
7000850000-7000a30000 r-xp 00000000 fd:00 421569                         /=
usr/lib/alpha-linux-gnu/libc.so.6.1
7000a30000-7000a3c000 ---p 001e0000 fd:00 421569                         /=
usr/lib/alpha-linux-gnu/libc.so.6.1
7000a3c000-7000a40000 r--p 001ec000 fd:00 421569                         /=
usr/lib/alpha-linux-gnu/libc.so.6.1
7000a40000-7000a42000 rw-p 001f0000 fd:00 421569                         /=
usr/lib/alpha-linux-gnu/libc.so.6.1
7000a42000-7000a50000 rw-p 00000000 00:00 0
7000a56000-7000a5a000 rw-p 00000000 00:00 0
7f3a0c000000-7f3a0c000000 ---p 00000000 00:00 0
7f3a11e00000-7f3a11e00000 ---p 00000000 00:00 0

arm64-chroot
Linux p100 6.4.4-200.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Wed Jul 19 16:32:4=
9 UTC 2023 aarch64 GNU/Linux
5500000000-5500009000 r-xp 00000000 fd:00 570430                         /=
usr/bin/cat
5500009000-550001f000 ---p 00000000 00:00 0
550001f000-5500020000 r--p 0000f000 fd:00 570430                         /=
usr/bin/cat
5500020000-5500021000 rw-p 00010000 fd:00 570430                         /=
usr/bin/cat
5500021000-5500042000 rw-p 00000000 00:00 0                              [=
heap]
7000000000-7000001000 ---p 00000000 00:00 0
7000001000-7000801000 rw-p 00000000 00:00 0                              [=
stack]
7000801000-7000827000 r-xp 00000000 fd:00 571555                         /=
usr/lib/aarch64-linux-gnu/ld-linux-aarch64.so.1
7000827000-700083f000 ---p 00000000 00:00 0
700083f000-7000841000 r--p 0002e000 fd:00 571555                         /=
usr/lib/aarch64-linux-gnu/ld-linux-aarch64.so.1
7000841000-7000843000 rw-p 00030000 fd:00 571555                         /=
usr/lib/aarch64-linux-gnu/ld-linux-aarch64.so.1
7000843000-7000844000 r-xp 00000000 00:00 0
7000844000-7000846000 rw-p 00000000 00:00 0
7000850000-70009d7000 r-xp 00000000 fd:00 571558                         /=
usr/lib/aarch64-linux-gnu/libc.so.6
70009d7000-70009ed000 ---p 00187000 fd:00 571558                         /=
usr/lib/aarch64-linux-gnu/libc.so.6
70009ed000-70009f0000 r--p 0018d000 fd:00 571558                         /=
usr/lib/aarch64-linux-gnu/libc.so.6
70009f0000-70009f2000 rw-p 00190000 fd:00 571558                         /=
usr/lib/aarch64-linux-gnu/libc.so.6
70009f2000-70009ff000 rw-p 00000000 00:00 0

armel-chroot
Linux p100 6.4.4-200.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Wed Jul 19 16:32:4=
9 UTC 2023 armv7l GNU/Linux
00300000-00308000 r-xp 00000000 fd:00 801471                             /=
usr/bin/cat
00308000-0031f000 ---p 00000000 00:00 0
0031f000-00320000 r--p 0000f000 fd:00 801471                             /=
usr/bin/cat
00320000-00321000 rw-p 00010000 fd:00 801471                             /=
usr/bin/cat
00321000-00342000 rw-p 00000000 00:00 0                                  [=
heap]
f3000000-f3001000 ---p 00000000 00:00 0
f3001000-f3801000 rw-p 00000000 00:00 0                                  [=
stack]
f3801000-f3827000 r-xp 00000000 fd:00 802599                             /=
usr/lib/arm-linux-gnueabi/ld-linux.so.3
f3827000-f3828000 r--p 00026000 fd:00 802599                             /=
usr/lib/arm-linux-gnueabi/ld-linux.so.3
f3828000-f3829000 rw-p 00027000 fd:00 802599                             /=
usr/lib/arm-linux-gnueabi/ld-linux.so.3
f3829000-f382a000 r-xp 00000000 00:00 0
f382a000-f382c000 rw-p 00000000 00:00 0
f382c000-f399e000 r-xp 00000000 fd:00 802602                             /=
usr/lib/arm-linux-gnueabi/libc.so.6
f399e000-f39a0000 r--p 00172000 fd:00 802602                             /=
usr/lib/arm-linux-gnueabi/libc.so.6
f39a0000-f39a1000 rw-p 00174000 fd:00 802602                             /=
usr/lib/arm-linux-gnueabi/libc.so.6
f39a1000-f39ab000 rw-p 00000000 00:00 0
ffff0000-ffff1000 r-xp 00000000 00:00 0

hppa-chroot
Linux p100 6.4.4-200.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Wed Jul 19 16:32:4=
9 UTC 2023 parisc GNU/Linux
00000000-00001000 --xp 00000000 00:00 0
00010000-00019000 r-xp 00000000 fd:00 1061893                            /=
usr/bin/cat
00019000-0001a000 rwxp 00009000 fd:00 1061893                            /=
usr/bin/cat
0001a000-0003b000 rw-p 00000000 00:00 0                                  [=
heap]
f3000000-f8000000 rwxp 00000000 00:00 0                                  [=
stack]
f8000000-f802f000 r-xp 00000000 fd:00 1069300                            /=
usr/lib/hppa-linux-gnu/ld.so.1
f802f000-f8030000 r--p 0002f000 fd:00 1069300                            /=
usr/lib/hppa-linux-gnu/ld.so.1
f8030000-f8034000 rwxp 00030000 fd:00 1069300                            /=
usr/lib/hppa-linux-gnu/ld.so.1
f8034000-f8035000 r-xp 00000000 00:00 0
f8035000-f8037000 rw-p 00000000 00:00 0
f8037000-f81f3000 r-xp 00000000 fd:00 1069303                            /=
usr/lib/hppa-linux-gnu/libc.so.6
f81f3000-f81f5000 r--p 001bc000 fd:00 1069303                            /=
usr/lib/hppa-linux-gnu/libc.so.6
f81f5000-f81fa000 rwxp 001be000 fd:00 1069303                            /=
usr/lib/hppa-linux-gnu/libc.so.6

m68k-chroot
Linux p100 6.4.4-200.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Wed Jul 19 16:32:4=
9 UTC 2023 m68k GNU/Linux
80000000-80007000 r-xp 00000000 fd:00 409133                             /=
usr/bin/cat
80007000-80009000 ---p 00000000 00:00 0
80009000-8000a000 r--p 00007000 fd:00 409133                             /=
usr/bin/cat
8000a000-8000b000 rw-p 00008000 fd:00 409133                             /=
usr/bin/cat
8000b000-8002c000 rw-p 00000000 00:00 0                                  [=
heap]
f3000000-f3001000 ---p 00000000 00:00 0
f3001000-f3801000 rw-p 00000000 00:00 0                                  [=
stack]
f3801000-f3821000 r-xp 00000000 fd:00 448209                             /=
usr/lib/m68k-linux-gnu/ld.so.1
f3821000-f3822000 ---p 00000000 00:00 0
f3822000-f3823000 r--p 00021000 fd:00 448209                             /=
usr/lib/m68k-linux-gnu/ld.so.1
f3823000-f3825000 rw-p 00022000 fd:00 448209                             /=
usr/lib/m68k-linux-gnu/ld.so.1
f3825000-f3826000 r-xp 00000000 00:00 0
f3826000-f3997000 r-xp 00000000 fd:00 448212                             /=
usr/lib/m68k-linux-gnu/libc.so.6
f3997000-f3998000 ---p 00171000 fd:00 448212                             /=
usr/lib/m68k-linux-gnu/libc.so.6
f3998000-f399a000 r--p 00170000 fd:00 448212                             /=
usr/lib/m68k-linux-gnu/libc.so.6
f399a000-f399e000 rw-p 00172000 fd:00 448212                             /=
usr/lib/m68k-linux-gnu/libc.so.6
f399e000-f39aa000 rw-p 00000000 00:00 0

mips64el-chroot
Linux p100 6.4.4-200.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Wed Jul 19 16:32:4=
9 UTC 2023 mips64 GNU/Linux
5500000000-550000b000 r-xp 00000000 fd:00 811277                         /=
usr/bin/cat
550000b000-550001f000 ---p 00000000 00:00 0
550001f000-5500020000 r--p 0000f000 fd:00 811277                         /=
usr/bin/cat
5500020000-5500021000 rw-p 00010000 fd:00 811277                         /=
usr/bin/cat
5500021000-5500042000 rw-p 00000000 00:00 0                              [=
heap]
7000000000-7000001000 ---p 00000000 00:00 0
7000001000-7000801000 rwxp 00000000 00:00 0                              [=
stack]
7000801000-700082e000 r-xp 00000000 fd:00 812402                         /=
usr/lib/mips64el-linux-gnuabi64/ld.so.1
700082e000-7000840000 ---p 00000000 00:00 0
7000840000-7000841000 r--p 0002f000 fd:00 812402                         /=
usr/lib/mips64el-linux-gnuabi64/ld.so.1
7000841000-7000843000 rw-p 00030000 fd:00 812402                         /=
usr/lib/mips64el-linux-gnuabi64/ld.so.1
7000843000-7000844000 r-xp 00000000 00:00 0
7000844000-7000846000 rw-p 00000000 00:00 0
7000850000-7000a3a000 r-xp 00000000 fd:00 812405                         /=
usr/lib/mips64el-linux-gnuabi64/libc.so.6
7000a3a000-7000a4a000 ---p 001ea000 fd:00 812405                         /=
usr/lib/mips64el-linux-gnuabi64/libc.so.6
7000a4a000-7000a50000 r--p 001ea000 fd:00 812405                         /=
usr/lib/mips64el-linux-gnuabi64/libc.so.6
7000a50000-7000a55000 rw-p 001f0000 fd:00 812405                         /=
usr/lib/mips64el-linux-gnuabi64/libc.so.6
7000a55000-7000a62000 rw-p 00000000 00:00 0
7000a68000-7000a6a000 rw-p 00000000 00:00 0

mipsel-chroot
Linux p100 6.4.4-200.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Wed Jul 19 16:32:4=
9 UTC 2023 mips GNU/Linux
00300000-00309000 r-xp 00000000 fd:00 818831                             /=
usr/bin/cat
00309000-0031f000 ---p 00000000 00:00 0
0031f000-00320000 r--p 0000f000 fd:00 818831                             /=
usr/bin/cat
00320000-00321000 rw-p 00010000 fd:00 818831                             /=
usr/bin/cat
00321000-00342000 rw-p 00000000 00:00 0                                  [=
heap]
73000000-73001000 ---p 00000000 00:00 0
73001000-73801000 rwxp 00000000 00:00 0                                  [=
stack]
73801000-7382d000 r-xp 00000000 fd:00 819956                             /=
usr/lib/mipsel-linux-gnu/ld.so.1
7382d000-73840000 ---p 00000000 00:00 0
73840000-73841000 r--p 0002f000 fd:00 819956                             /=
usr/lib/mipsel-linux-gnu/ld.so.1
73841000-73842000 rw-p 00030000 fd:00 819956                             /=
usr/lib/mipsel-linux-gnu/ld.so.1
73842000-73843000 r-xp 00000000 00:00 0
73843000-73845000 rw-p 00000000 00:00 0
73850000-73a0e000 r-xp 00000000 fd:00 819959                             /=
usr/lib/mipsel-linux-gnu/libc.so.6
73a0e000-73a1d000 ---p 001be000 fd:00 819959                             /=
usr/lib/mipsel-linux-gnu/libc.so.6
73a1d000-73a20000 r--p 001bd000 fd:00 819959                             /=
usr/lib/mipsel-linux-gnu/libc.so.6
73a20000-73a23000 rw-p 001c0000 fd:00 819959                             /=
usr/lib/mipsel-linux-gnu/libc.so.6
73a23000-73a2d000 rw-p 00000000 00:00 0

powerpc-chroot
Linux p100 6.4.4-200.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Wed Jul 19 16:32:4=
9 UTC 2023 ppc GNU/Linux
000c0000-002d5000 r-xp 00000000 fd:00 538459                             /=
usr/lib/powerpc-linux-gnu/libc.so.6
002d5000-002eb000 ---p 00215000 fd:00 538459                             /=
usr/lib/powerpc-linux-gnu/libc.so.6
002eb000-002f0000 r--p 0021b000 fd:00 538459                             /=
usr/lib/powerpc-linux-gnu/libc.so.6
002f0000-002f1000 rw-p 00220000 fd:00 538459                             /=
usr/lib/powerpc-linux-gnu/libc.so.6
002f1000-002fb000 rw-p 00000000 00:00 0
00300000-0030b000 r-xp 00000000 fd:00 535994                             /=
usr/bin/cat
0030b000-0031f000 ---p 00000000 00:00 0
0031f000-00320000 r--p 0000f000 fd:00 535994                             /=
usr/bin/cat
00320000-00321000 rw-p 00010000 fd:00 535994                             /=
usr/bin/cat
00321000-00343000 rw-p 00000000 00:00 0                                  [=
heap]
f3000000-f3001000 ---p 00000000 00:00 0
f3001000-f3801000 rw-p 00000000 00:00 0                                  [=
stack]
f3801000-f3834000 r-xp 00000000 fd:00 538456                             /=
usr/lib/powerpc-linux-gnu/ld.so.1
f3834000-f384f000 ---p 00000000 00:00 0
f384f000-f3851000 r--p 0003e000 fd:00 538456                             /=
usr/lib/powerpc-linux-gnu/ld.so.1
f3851000-f3852000 rw-p 00040000 fd:00 538456                             /=
usr/lib/powerpc-linux-gnu/ld.so.1
f3852000-f3853000 r-xp 00000000 00:00 0
f3853000-f3855000 rw-p 00000000 00:00 0

ppc64-chroot
Linux p100 6.4.4-200.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Wed Jul 19 16:32:4=
9 UTC 2023 ppc64 GNU/Linux
5500000000-550000c000 r-xp 00000000 fd:00 550284                         /=
usr/bin/cat
550000c000-550001f000 ---p 00000000 00:00 0
550001f000-5500020000 r--p 0000f000 fd:00 550284                         /=
usr/bin/cat
5500020000-5500021000 rw-p 00010000 fd:00 550284                         /=
usr/bin/cat
5500021000-5500042000 rw-p 00000000 00:00 0                              [=
heap]
7000000000-7000001000 ---p 00000000 00:00 0
7000001000-7000801000 rw-p 00000000 00:00 0                              [=
stack]
7000801000-7000847000 r-xp 00000000 fd:00 551358                         /=
usr/lib/powerpc64-linux-gnu/ld64.so.1
7000847000-700085e000 ---p 00000000 00:00 0
700085e000-7000861000 r--p 0004d000 fd:00 551358                         /=
usr/lib/powerpc64-linux-gnu/ld64.so.1
7000861000-7000863000 rw-p 00050000 fd:00 551358                         /=
usr/lib/powerpc64-linux-gnu/ld64.so.1
7000863000-7000864000 r-xp 00000000 00:00 0
7000870000-7000a7a000 r-xp 00000000 fd:00 551361                         /=
usr/lib/powerpc64-linux-gnu/libc.so.6
7000a7a000-7000a87000 ---p 0020a000 fd:00 551361                         /=
usr/lib/powerpc64-linux-gnu/libc.so.6
7000a87000-7000aa0000 r--p 00217000 fd:00 551361                         /=
usr/lib/powerpc64-linux-gnu/libc.so.6
7000aa0000-7000aa2000 rw-p 00230000 fd:00 551361                         /=
usr/lib/powerpc64-linux-gnu/libc.so.6
7000aa2000-7000aaf000 rw-p 00000000 00:00 0
7000ab3000-7000ab5000 rw-p 00000000 00:00 0

ppc64el-chroot
Linux p100 6.4.4-200.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Wed Jul 19 16:32:4=
9 UTC 2023 ppc64le GNU/Linux
5500000000-550000b000 r-xp 00000000 fd:00 826393                         /=
usr/bin/cat
550000b000-550001f000 ---p 00000000 00:00 0
550001f000-5500020000 r--p 0000f000 fd:00 826393                         /=
usr/bin/cat
5500020000-5500021000 rw-p 00010000 fd:00 826393                         /=
usr/bin/cat
5500021000-5500042000 rw-p 00000000 00:00 0                              [=
heap]
7000000000-7000001000 ---p 00000000 00:00 0
7000001000-7000801000 rw-p 00000000 00:00 0                              [=
stack]
7000801000-700084e000 r-xp 00000000 fd:00 827518                         /=
usr/lib/powerpc64le-linux-gnu/ld64.so.2
700084e000-700085f000 ---p 00000000 00:00 0
700085f000-7000861000 r--p 0004e000 fd:00 827518                         /=
usr/lib/powerpc64le-linux-gnu/ld64.so.2
7000861000-7000863000 rw-p 00050000 fd:00 827518                         /=
usr/lib/powerpc64le-linux-gnu/ld64.so.2
7000863000-7000864000 r-xp 00000000 00:00 0
7000870000-7000aa4000 r-xp 00000000 fd:00 827521                         /=
usr/lib/powerpc64le-linux-gnu/libc.so.6
7000aa4000-7000abc000 ---p 00234000 fd:00 827521                         /=
usr/lib/powerpc64le-linux-gnu/libc.so.6
7000abc000-7000ac0000 r--p 0023c000 fd:00 827521                         /=
usr/lib/powerpc64le-linux-gnu/libc.so.6
7000ac0000-7000ac2000 rw-p 00240000 fd:00 827521                         /=
usr/lib/powerpc64le-linux-gnu/libc.so.6
7000ac2000-7000acf000 rw-p 00000000 00:00 0
7000ad3000-7000ad5000 rw-p 00000000 00:00 0

s390x-chroot
Linux p100 6.4.4-200.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Wed Jul 19 16:32:4=
9 UTC 2023 s390x GNU/Linux
5500000000-550000a000 r-xp 00000000 fd:00 833950                         /=
usr/bin/cat
550000a000-550000b000 r--p 00009000 fd:00 833950                         /=
usr/bin/cat
550000b000-550000c000 rw-p 0000a000 fd:00 833950                         /=
usr/bin/cat
550000c000-550002d000 rw-p 00000000 00:00 0                              [=
heap]
7000000000-7000001000 ---p 00000000 00:00 0
7000001000-7000801000 rw-p 00000000 00:00 0                              [=
stack]
7000801000-700082b000 r-xp 00000000 fd:00 835075                         /=
usr/lib/s390x-linux-gnu/ld64.so.1
700082b000-700082d000 r--p 00029000 fd:00 835075                         /=
usr/lib/s390x-linux-gnu/ld64.so.1
700082d000-700082f000 rw-p 0002b000 fd:00 835075                         /=
usr/lib/s390x-linux-gnu/ld64.so.1
700082f000-7000830000 r-xp 00000000 00:00 0
7000830000-70009f1000 r-xp 00000000 fd:00 835078                         /=
usr/lib/s390x-linux-gnu/libc.so.6
70009f1000-70009f5000 r--p 001c1000 fd:00 835078                         /=
usr/lib/s390x-linux-gnu/libc.so.6
70009f5000-70009f7000 rw-p 001c5000 fd:00 835078                         /=
usr/lib/s390x-linux-gnu/libc.so.6
70009f7000-7000a06000 rw-p 00000000 00:00 0

sh4-chroot
Linux p100 6.4.4-200.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Wed Jul 19 16:32:4=
9 UTC 2023 sh4 GNU/Linux
00400000-00407000 r-xp 00000000 fd:00 557846                             /=
usr/bin/cat
00407000-0041f000 ---p 00000000 00:00 0
0041f000-00420000 r--p 0000f000 fd:00 557846                             /=
usr/bin/cat
00420000-00421000 rw-p 00010000 fd:00 557846                             /=
usr/bin/cat
00421000-00442000 rw-p 00000000 00:00 0                                  [=
heap]
73000000-73001000 ---p 00000000 00:00 0
73001000-73801000 rw-p 00000000 00:00 0                                  [=
stack]
73801000-73822000 r-xp 00000000 fd:00 558920                             /=
usr/lib/sh4-linux-gnu/ld-linux.so.2
73822000-73840000 ---p 00000000 00:00 0
73840000-73841000 r--p 0002f000 fd:00 558920                             /=
usr/lib/sh4-linux-gnu/ld-linux.so.2
73841000-73842000 rw-p 00030000 fd:00 558920                             /=
usr/lib/sh4-linux-gnu/ld-linux.so.2
73842000-73843000 r-xp 00000000 00:00 0
73843000-73845000 rw-p 00000000 00:00 0
73850000-739b8000 r-xp 00000000 fd:00 558923                             /=
usr/lib/sh4-linux-gnu/libc.so.6
739b8000-739ce000 ---p 00168000 fd:00 558923                             /=
usr/lib/sh4-linux-gnu/libc.so.6
739ce000-739d0000 r--p 0016e000 fd:00 558923                             /=
usr/lib/sh4-linux-gnu/libc.so.6
739d0000-739d1000 rw-p 00170000 fd:00 558923                             /=
usr/lib/sh4-linux-gnu/libc.so.6
739d1000-739db000 rw-p 00000000 00:00 0

sparc64-chroot
Linux p100 6.4.4-200.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Wed Jul 19 16:32:4=
9 UTC 2023 sparc64 GNU/Linux
5500000000-5500008000 r-xp 00000000 fd:00 565395                         /=
usr/bin/cat
5500008000-55001fe000 ---p 00000000 00:00 0
55001fe000-5500200000 r--p 000fe000 fd:00 565395                         /=
usr/bin/cat
5500200000-5500202000 rwxp 00100000 fd:00 565395                         /=
usr/bin/cat
5500202000-5500224000 rw-p 00000000 00:00 0                              [=
heap]
7000000000-7000002000 ---p 00000000 00:00 0
7000002000-7000802000 rw-p 00000000 00:00 0                              [=
stack]
7000802000-700082a000 r-xp 00000000 fd:00 525238                         /=
usr/lib/sparc64-linux-gnu/ld-linux.so.2
700082a000-7000a00000 ---p 00000000 00:00 0
7000a00000-7000a02000 r--p 000fe000 fd:00 525238                         /=
usr/lib/sparc64-linux-gnu/ld-linux.so.2
7000a02000-7000a04000 rw-p 00100000 fd:00 525238                         /=
usr/lib/sparc64-linux-gnu/ld-linux.so.2
7000a04000-7000a08000 rw-p 00000000 00:00 0
7000b00000-7000c8c000 r-xp 00000000 fd:00 525241                         /=
usr/lib/sparc64-linux-gnu/libc.so.6
7000c8c000-7000d04000 ---p 0018c000 fd:00 525241                         /=
usr/lib/sparc64-linux-gnu/libc.so.6
7000d04000-7000dfc000 ---p 00000000 00:00 0
7000dfc000-7000e00000 r--p 001fc000 fd:00 525241                         /=
usr/lib/sparc64-linux-gnu/libc.so.6
7000e00000-7000e04000 rwxp 00200000 fd:00 525241                         /=
usr/lib/sparc64-linux-gnu/libc.so.6
7000e04000-7000e10000 rwxp 00000000 00:00 0
7ff864000000-7ff864000000 ---p 00000000 00:00 0
7ff86b000000-7ff86b000000 ---p 00000000 00:00 0

=2D-----------------------------------------------------------------------=
------------
Memory layout from git head (without this patch series)

alpha-chroot
Linux p100 6.4.4-200.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Wed Jul 19 16:32:4=
9 UTC 2023 alpha GNU/Linux
120000000-12000a000 r-xp 00000000 fd:00 417269                           /=
usr/bin/cat
12000a000-12001e000 ---p 00000000 00:00 0
12001e000-120020000 r--p 0000e000 fd:00 417269                           /=
usr/bin/cat
120020000-120021000 rw-p 00000000 00:00 0
120021000-120044000 rw-p 00000000 00:00 0
4000000000-4000002000 ---p 00000000 00:00 0
4000002000-4000802000 rw-p 00000000 00:00 0                              [=
stack]
4000802000-4000830000 r-xp 00000000 fd:00 421566                         /=
usr/lib/alpha-linux-gnu/ld-linux.so.2
4000830000-4000840000 ---p 00000000 00:00 0
4000840000-4000842000 r--p 0002e000 fd:00 421566                         /=
usr/lib/alpha-linux-gnu/ld-linux.so.2
4000842000-4000844000 rw-p 00030000 fd:00 421566                         /=
usr/lib/alpha-linux-gnu/ld-linux.so.2
4000844000-4000846000 r-xp 00000000 00:00 0
4000850000-4000a30000 r-xp 00000000 fd:00 421569                         /=
usr/lib/alpha-linux-gnu/libc.so.6.1
4000a30000-4000a3c000 ---p 001e0000 fd:00 421569                         /=
usr/lib/alpha-linux-gnu/libc.so.6.1
4000a3c000-4000a40000 r--p 001ec000 fd:00 421569                         /=
usr/lib/alpha-linux-gnu/libc.so.6.1
4000a40000-4000a42000 rw-p 001f0000 fd:00 421569                         /=
usr/lib/alpha-linux-gnu/libc.so.6.1
4000a42000-4000a50000 rw-p 00000000 00:00 0
4000a56000-4000a5a000 rw-p 00000000 00:00 0

arm64-chroot
Linux p100 6.4.4-200.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Wed Jul 19 16:32:4=
9 UTC 2023 aarch64 GNU/Linux
5500000000-5500009000 r-xp 00000000 fd:00 570430                         /=
usr/bin/cat
5500009000-550001f000 ---p 00000000 00:00 0
550001f000-5500020000 r--p 0000f000 fd:00 570430                         /=
usr/bin/cat
5500020000-5500021000 rw-p 00010000 fd:00 570430                         /=
usr/bin/cat
5500021000-5500042000 rw-p 00000000 00:00 0
5502021000-5502022000 ---p 00000000 00:00 0
5502022000-5502822000 rw-p 00000000 00:00 0                              [=
stack]
5502822000-5502848000 r-xp 00000000 fd:00 571555                         /=
usr/lib/aarch64-linux-gnu/ld-linux-aarch64.so.1
5502848000-5502860000 ---p 00000000 00:00 0
5502860000-5502862000 r--p 0002e000 fd:00 571555                         /=
usr/lib/aarch64-linux-gnu/ld-linux-aarch64.so.1
5502862000-5502864000 rw-p 00030000 fd:00 571555                         /=
usr/lib/aarch64-linux-gnu/ld-linux-aarch64.so.1
5502864000-5502865000 r-xp 00000000 00:00 0
5502865000-5502867000 rw-p 00000000 00:00 0
5502870000-55029f7000 r-xp 00000000 fd:00 571558                         /=
usr/lib/aarch64-linux-gnu/libc.so.6
55029f7000-5502a0d000 ---p 00187000 fd:00 571558                         /=
usr/lib/aarch64-linux-gnu/libc.so.6
5502a0d000-5502a10000 r--p 0018d000 fd:00 571558                         /=
usr/lib/aarch64-linux-gnu/libc.so.6
5502a10000-5502a12000 rw-p 00190000 fd:00 571558                         /=
usr/lib/aarch64-linux-gnu/libc.so.6
5502a12000-5502a1f000 rw-p 00000000 00:00 0

armel-chroot
Linux p100 6.4.4-200.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Wed Jul 19 16:32:4=
9 UTC 2023 armv7l GNU/Linux
40000000-40008000 r-xp 00000000 fd:00 801471                             /=
usr/bin/cat
40008000-4001f000 ---p 00000000 00:00 0
4001f000-40020000 r--p 0000f000 fd:00 801471                             /=
usr/bin/cat
40020000-40021000 rw-p 00010000 fd:00 801471                             /=
usr/bin/cat
40021000-40023000 rw-p 00000000 00:00 0
40023000-40195000 r-xp 00000000 fd:00 802602                             /=
usr/lib/arm-linux-gnueabi/libc.so.6
40195000-40197000 r--p 00172000 fd:00 802602                             /=
usr/lib/arm-linux-gnueabi/libc.so.6
40197000-40198000 rw-p 00174000 fd:00 802602                             /=
usr/lib/arm-linux-gnueabi/libc.so.6
40198000-402a2000 rw-p 00000000 00:00 0
41021000-41022000 ---p 00000000 00:00 0
41022000-41822000 rw-p 00000000 00:00 0                                  [=
stack]
41822000-41848000 r-xp 00000000 fd:00 802599                             /=
usr/lib/arm-linux-gnueabi/ld-linux.so.3
41848000-41849000 r--p 00026000 fd:00 802599                             /=
usr/lib/arm-linux-gnueabi/ld-linux.so.3
41849000-4184a000 rw-p 00027000 fd:00 802599                             /=
usr/lib/arm-linux-gnueabi/ld-linux.so.3
4184a000-4184b000 r-xp 00000000 00:00 0
ffff0000-ffff1000 r-xp 00000000 00:00 0

hppa-chroot
Linux p100 6.4.4-200.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Wed Jul 19 16:32:4=
9 UTC 2023 parisc GNU/Linux
0-1000 --xp 00000000 00:00 0
10000-19000 r-xp 00000000 fd:00 1061893                                  /=
usr/bin/cat
19000-1a000 rwxp 00009000 fd:00 1061893                                  /=
usr/bin/cat
1a000-3b000 rw-p 00000000 00:00 0
fa000000-ff000000 rwxp 00000000 00:00 0                                  [=
stack]
ff000000-ff02f000 r-xp 00000000 fd:00 1062984                            /=
usr/lib/hppa-linux-gnu/ld.so.1
ff02f000-ff030000 r--p 0002f000 fd:00 1062984                            /=
usr/lib/hppa-linux-gnu/ld.so.1
ff030000-ff034000 rwxp 00030000 fd:00 1062984                            /=
usr/lib/hppa-linux-gnu/ld.so.1
ff034000-ff035000 r-xp 00000000 00:00 0
ff035000-ff037000 rw-p 00000000 00:00 0
ff037000-ff1f3000 r-xp 00000000 fd:00 1062987                            /=
usr/lib/hppa-linux-gnu/libc.so.6
ff1f3000-ff1f5000 r--p 001bc000 fd:00 1062987                            /=
usr/lib/hppa-linux-gnu/libc.so.6
ff1f5000-ff1fa000 rwxp 001be000 fd:00 1062987                            /=
usr/lib/hppa-linux-gnu/libc.so.6

m68k-chroot
Linux p100 6.4.4-200.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Wed Jul 19 16:32:4=
9 UTC 2023 m68k GNU/Linux
40000000-40001000 ---p 00000000 00:00 0
40001000-40801000 rw-p 00000000 00:00 0                                  [=
stack]
40801000-40821000 r-xp 00000000 fd:00 448209                             /=
usr/lib/m68k-linux-gnu/ld.so.1
40821000-40822000 ---p 00000000 00:00 0
40822000-40823000 r--p 00021000 fd:00 448209                             /=
usr/lib/m68k-linux-gnu/ld.so.1
40823000-40825000 rw-p 00022000 fd:00 448209                             /=
usr/lib/m68k-linux-gnu/ld.so.1
40825000-40826000 r-xp 00000000 00:00 0
40826000-40997000 r-xp 00000000 fd:00 448212                             /=
usr/lib/m68k-linux-gnu/libc.so.6
40997000-40998000 ---p 00171000 fd:00 448212                             /=
usr/lib/m68k-linux-gnu/libc.so.6
40998000-4099a000 r--p 00170000 fd:00 448212                             /=
usr/lib/m68k-linux-gnu/libc.so.6
4099a000-4099e000 rw-p 00172000 fd:00 448212                             /=
usr/lib/m68k-linux-gnu/libc.so.6
4099e000-409aa000 rw-p 00000000 00:00 0
80000000-80007000 r-xp 00000000 fd:00 409133                             /=
usr/bin/cat
80007000-80009000 ---p 00000000 00:00 0
80009000-8000a000 r--p 00007000 fd:00 409133                             /=
usr/bin/cat
8000a000-8000b000 rw-p 00008000 fd:00 409133                             /=
usr/bin/cat
8000b000-8002c000 rw-p 00000000 00:00 0

mips64el-chroot
Linux p100 6.4.4-200.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Wed Jul 19 16:32:4=
9 UTC 2023 mips64 GNU/Linux
4000000000-400000b000 r-xp 00000000 fd:00 811277                         /=
usr/bin/cat
400000b000-400001f000 ---p 00000000 00:00 0
400001f000-4000020000 r--p 0000f000 fd:00 811277                         /=
usr/bin/cat
4000020000-4000021000 rw-p 00010000 fd:00 811277                         /=
usr/bin/cat
4000021000-4000042000 rw-p 00000000 00:00 0
4002021000-4002022000 ---p 00000000 00:00 0
4002022000-4002822000 rwxp 00000000 00:00 0                              [=
stack]
4002822000-400284f000 r-xp 00000000 fd:00 812402                         /=
usr/lib/mips64el-linux-gnuabi64/ld.so.1
400284f000-4002861000 ---p 00000000 00:00 0
4002861000-4002862000 r--p 0002f000 fd:00 812402                         /=
usr/lib/mips64el-linux-gnuabi64/ld.so.1
4002862000-4002864000 rw-p 00030000 fd:00 812402                         /=
usr/lib/mips64el-linux-gnuabi64/ld.so.1
4002864000-4002865000 r-xp 00000000 00:00 0
4002865000-4002867000 rw-p 00000000 00:00 0
4002870000-4002a5a000 r-xp 00000000 fd:00 812405                         /=
usr/lib/mips64el-linux-gnuabi64/libc.so.6
4002a5a000-4002a6a000 ---p 001ea000 fd:00 812405                         /=
usr/lib/mips64el-linux-gnuabi64/libc.so.6
4002a6a000-4002a70000 r--p 001ea000 fd:00 812405                         /=
usr/lib/mips64el-linux-gnuabi64/libc.so.6
4002a70000-4002a75000 rw-p 001f0000 fd:00 812405                         /=
usr/lib/mips64el-linux-gnuabi64/libc.so.6
4002a75000-4002a82000 rw-p 00000000 00:00 0
4002a89000-4002a8b000 rw-p 00000000 00:00 0

mipsel-chroot
Linux p100 6.4.4-200.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Wed Jul 19 16:32:4=
9 UTC 2023 mips GNU/Linux
40000000-40009000 r-xp 00000000 fd:00 818831                             /=
usr/bin/cat
40009000-4001f000 ---p 00000000 00:00 0
4001f000-40020000 r--p 0000f000 fd:00 818831                             /=
usr/bin/cat
40020000-40021000 rw-p 00010000 fd:00 818831                             /=
usr/bin/cat
40021000-40023000 rw-p 00000000 00:00 0
40030000-401ee000 r-xp 00000000 fd:00 819959                             /=
usr/lib/mipsel-linux-gnu/libc.so.6
401ee000-401fd000 ---p 001be000 fd:00 819959                             /=
usr/lib/mipsel-linux-gnu/libc.so.6
401fd000-40200000 r--p 001bd000 fd:00 819959                             /=
usr/lib/mipsel-linux-gnu/libc.so.6
40200000-40203000 rw-p 001c0000 fd:00 819959                             /=
usr/lib/mipsel-linux-gnu/libc.so.6
40203000-4030d000 rw-p 00000000 00:00 0
41021000-41022000 ---p 00000000 00:00 0
41022000-41822000 rwxp 00000000 00:00 0                                  [=
stack]
41822000-4184e000 r-xp 00000000 fd:00 819956                             /=
usr/lib/mipsel-linux-gnu/ld.so.1
4184e000-41861000 ---p 00000000 00:00 0
41861000-41862000 r--p 0002f000 fd:00 819956                             /=
usr/lib/mipsel-linux-gnu/ld.so.1
41862000-41863000 rw-p 00030000 fd:00 819956                             /=
usr/lib/mipsel-linux-gnu/ld.so.1
41863000-41864000 r-xp 00000000 00:00 0

powerpc-chroot
Linux p100 6.4.4-200.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Wed Jul 19 16:32:4=
9 UTC 2023 ppc GNU/Linux
3fdc0000-3ffd5000 r-xp 00000000 fd:00 538459                             /=
usr/lib/powerpc-linux-gnu/libc.so.6
3ffd5000-3ffeb000 ---p 00215000 fd:00 538459                             /=
usr/lib/powerpc-linux-gnu/libc.so.6
3ffeb000-3fff0000 r--p 0021b000 fd:00 538459                             /=
usr/lib/powerpc-linux-gnu/libc.so.6
3fff0000-3fff1000 rw-p 00220000 fd:00 538459                             /=
usr/lib/powerpc-linux-gnu/libc.so.6
3fff1000-3fffb000 rw-p 00000000 00:00 0
40000000-4000b000 r-xp 00000000 fd:00 535994                             /=
usr/bin/cat
4000b000-4001f000 ---p 00000000 00:00 0
4001f000-40020000 r--p 0000f000 fd:00 535994                             /=
usr/bin/cat
40020000-40021000 rw-p 00010000 fd:00 535994                             /=
usr/bin/cat
40021000-40123000 rw-p 00000000 00:00 0
41021000-41022000 ---p 00000000 00:00 0
41022000-41822000 rw-p 00000000 00:00 0                                  [=
stack]
41822000-41855000 r-xp 00000000 fd:00 538456                             /=
usr/lib/powerpc-linux-gnu/ld.so.1
41855000-41870000 ---p 00000000 00:00 0
41870000-41872000 r--p 0003e000 fd:00 538456                             /=
usr/lib/powerpc-linux-gnu/ld.so.1
41872000-41873000 rw-p 00040000 fd:00 538456                             /=
usr/lib/powerpc-linux-gnu/ld.so.1
41873000-41874000 r-xp 00000000 00:00 0

ppc64-chroot
Linux p100 6.4.4-200.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Wed Jul 19 16:32:4=
9 UTC 2023 ppc64 GNU/Linux
4000000000-400000c000 r-xp 00000000 fd:00 550284                         /=
usr/bin/cat
400000c000-400001f000 ---p 00000000 00:00 0
400001f000-4000020000 r--p 0000f000 fd:00 550284                         /=
usr/bin/cat
4000020000-4000021000 rw-p 00010000 fd:00 550284                         /=
usr/bin/cat
4000021000-4000042000 rw-p 00000000 00:00 0
4002021000-4002022000 ---p 00000000 00:00 0
4002022000-4002822000 rw-p 00000000 00:00 0                              [=
stack]
4002822000-4002868000 r-xp 00000000 fd:00 551358                         /=
usr/lib/powerpc64-linux-gnu/ld64.so.1
4002868000-400287f000 ---p 00000000 00:00 0
400287f000-4002882000 r--p 0004d000 fd:00 551358                         /=
usr/lib/powerpc64-linux-gnu/ld64.so.1
4002882000-4002884000 rw-p 00050000 fd:00 551358                         /=
usr/lib/powerpc64-linux-gnu/ld64.so.1
4002884000-4002885000 r-xp 00000000 00:00 0
4002890000-4002a9a000 r-xp 00000000 fd:00 551361                         /=
usr/lib/powerpc64-linux-gnu/libc.so.6
4002a9a000-4002aa7000 ---p 0020a000 fd:00 551361                         /=
usr/lib/powerpc64-linux-gnu/libc.so.6
4002aa7000-4002ac0000 r--p 00217000 fd:00 551361                         /=
usr/lib/powerpc64-linux-gnu/libc.so.6
4002ac0000-4002ac2000 rw-p 00230000 fd:00 551361                         /=
usr/lib/powerpc64-linux-gnu/libc.so.6
4002ac2000-4002acf000 rw-p 00000000 00:00 0
4002ad4000-4002ad6000 rw-p 00000000 00:00 0

ppc64el-chroot
Linux p100 6.4.4-200.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Wed Jul 19 16:32:4=
9 UTC 2023 ppc64le GNU/Linux
4000000000-400000b000 r-xp 00000000 fd:00 826393                         /=
usr/bin/cat
400000b000-400001f000 ---p 00000000 00:00 0
400001f000-4000020000 r--p 0000f000 fd:00 826393                         /=
usr/bin/cat
4000020000-4000021000 rw-p 00010000 fd:00 826393                         /=
usr/bin/cat
4000021000-4000042000 rw-p 00000000 00:00 0
4002021000-4002022000 ---p 00000000 00:00 0
4002022000-4002822000 rw-p 00000000 00:00 0                              [=
stack]
4002822000-400286f000 r-xp 00000000 fd:00 827518                         /=
usr/lib/powerpc64le-linux-gnu/ld64.so.2
400286f000-4002880000 ---p 00000000 00:00 0
4002880000-4002882000 r--p 0004e000 fd:00 827518                         /=
usr/lib/powerpc64le-linux-gnu/ld64.so.2
4002882000-4002884000 rw-p 00050000 fd:00 827518                         /=
usr/lib/powerpc64le-linux-gnu/ld64.so.2
4002884000-4002885000 r-xp 00000000 00:00 0
4002890000-4002ac4000 r-xp 00000000 fd:00 827521                         /=
usr/lib/powerpc64le-linux-gnu/libc.so.6
4002ac4000-4002adc000 ---p 00234000 fd:00 827521                         /=
usr/lib/powerpc64le-linux-gnu/libc.so.6
4002adc000-4002ae0000 r--p 0023c000 fd:00 827521                         /=
usr/lib/powerpc64le-linux-gnu/libc.so.6
4002ae0000-4002ae2000 rw-p 00240000 fd:00 827521                         /=
usr/lib/powerpc64le-linux-gnu/libc.so.6
4002ae2000-4002aef000 rw-p 00000000 00:00 0
4002af4000-4002af6000 rw-p 00000000 00:00 0

s390x-chroot
Linux p100 6.4.4-200.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Wed Jul 19 16:32:4=
9 UTC 2023 s390x GNU/Linux
4000000000-400000a000 r-xp 00000000 fd:00 833950                         /=
usr/bin/cat
400000a000-400000b000 r--p 00009000 fd:00 833950                         /=
usr/bin/cat
400000b000-400000c000 rw-p 0000a000 fd:00 833950                         /=
usr/bin/cat
400000c000-400002d000 rw-p 00000000 00:00 0
400200c000-400200d000 ---p 00000000 00:00 0
400200d000-400280d000 rw-p 00000000 00:00 0                              [=
stack]
400280d000-4002837000 r-xp 00000000 fd:00 835075                         /=
usr/lib/s390x-linux-gnu/ld64.so.1
4002837000-4002839000 r--p 00029000 fd:00 835075                         /=
usr/lib/s390x-linux-gnu/ld64.so.1
4002839000-400283b000 rw-p 0002b000 fd:00 835075                         /=
usr/lib/s390x-linux-gnu/ld64.so.1
400283b000-400283c000 r-xp 00000000 00:00 0
400283c000-40029fd000 r-xp 00000000 fd:00 835078                         /=
usr/lib/s390x-linux-gnu/libc.so.6
40029fd000-4002a01000 r--p 001c1000 fd:00 835078                         /=
usr/lib/s390x-linux-gnu/libc.so.6
4002a01000-4002a03000 rw-p 001c5000 fd:00 835078                         /=
usr/lib/s390x-linux-gnu/libc.so.6
4002a03000-4002a12000 rw-p 00000000 00:00 0

sh4-chroot
Linux p100 6.4.4-200.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Wed Jul 19 16:32:4=
9 UTC 2023 sh4 GNU/Linux
400000-407000 r-xp 00000000 fd:00 557846                                 /=
usr/bin/cat
407000-41f000 ---p 00000000 00:00 0
41f000-420000 r--p 0000f000 fd:00 557846                                 /=
usr/bin/cat
420000-421000 rw-p 00010000 fd:00 557846                                 /=
usr/bin/cat
421000-442000 rw-p 00000000 00:00 0
40000000-40001000 ---p 00000000 00:00 0
40001000-40801000 rw-p 00000000 00:00 0                                  [=
stack]
40801000-40822000 r-xp 00000000 fd:00 558920                             /=
usr/lib/sh4-linux-gnu/ld-linux.so.2
40822000-40840000 ---p 00000000 00:00 0
40840000-40841000 r--p 0002f000 fd:00 558920                             /=
usr/lib/sh4-linux-gnu/ld-linux.so.2
40841000-40842000 rw-p 00030000 fd:00 558920                             /=
usr/lib/sh4-linux-gnu/ld-linux.so.2
40842000-40843000 r-xp 00000000 00:00 0
40843000-40845000 rw-p 00000000 00:00 0
40850000-409b8000 r-xp 00000000 fd:00 558923                             /=
usr/lib/sh4-linux-gnu/libc.so.6
409b8000-409ce000 ---p 00168000 fd:00 558923                             /=
usr/lib/sh4-linux-gnu/libc.so.6
409ce000-409d0000 r--p 0016e000 fd:00 558923                             /=
usr/lib/sh4-linux-gnu/libc.so.6
409d0000-409d1000 rw-p 00170000 fd:00 558923                             /=
usr/lib/sh4-linux-gnu/libc.so.6
409d1000-409db000 rw-p 00000000 00:00 0

sparc64-chroot
Linux p100 6.4.4-200.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Wed Jul 19 16:32:4=
9 UTC 2023 sparc64 GNU/Linux
4000000000-4000008000 r-xp 00000000 fd:00 565395                         /=
usr/bin/cat
4000008000-40001fe000 ---p 00000000 00:00 0
40001fe000-4000200000 r--p 000fe000 fd:00 565395                         /=
usr/bin/cat
4000200000-4000201000 rwxp 00100000 fd:00 565395                         /=
usr/bin/cat
4002202000-4002204000 ---p 00000000 00:00 0
4002204000-4002a04000 rw-p 00000000 00:00 0                              [=
stack]
4002a04000-4002a2c000 r-xp 00000000 fd:00 525238                         /=
usr/lib/sparc64-linux-gnu/ld-linux.so.2
4002a2c000-4002c02000 ---p 00000000 00:00 0
4002c02000-4002c04000 r--p 000fe000 fd:00 525238                         /=
usr/lib/sparc64-linux-gnu/ld-linux.so.2
4002c04000-4002c06000 rw-p 00100000 fd:00 525238                         /=
usr/lib/sparc64-linux-gnu/ld-linux.so.2
4002c06000-4002c0a000 rw-p 00000000 00:00 0
4002d00000-4002e8c000 r-xp 00000000 fd:00 525241                         /=
usr/lib/sparc64-linux-gnu/libc.so.6
4002e8c000-4002f04000 ---p 0018c000 fd:00 525241                         /=
usr/lib/sparc64-linux-gnu/libc.so.6
4002f04000-4002ffc000 ---p 00000000 00:00 0
4002ffc000-4003000000 r--p 001fc000 fd:00 525241                         /=
usr/lib/sparc64-linux-gnu/libc.so.6
4003000000-4003004000 rwxp 00200000 fd:00 525241                         /=
usr/lib/sparc64-linux-gnu/libc.so.6
4003004000-4003010000 rwxp 00000000 00:00 0

Helge Deller (3):
  linux-user: Show heap address in /proc/pid/maps
  linux-user: Optimize memory layout for static and dynamic executables
  linux-user: Load pie executables at upper memory

 include/exec/cpu_ldst.h |  4 +--
 linux-user/elfload.c    | 59 +++++++++++++----------------------------
 linux-user/loader.h     | 12 +++++++++
 linux-user/main.c       |  2 ++
 linux-user/mmap.c       | 33 ++++++++++++-----------
 linux-user/qemu.h       |  4 +--
 linux-user/syscall.c    | 13 ++++++---
 7 files changed, 64 insertions(+), 63 deletions(-)

=2D-
2.41.0


