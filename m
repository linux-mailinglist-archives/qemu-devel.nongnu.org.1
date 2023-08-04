Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CC776FC62
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 10:48:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRqSY-0006XB-Ga; Fri, 04 Aug 2023 04:46:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qRqSX-0006Wz-4h
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 04:46:57 -0400
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qRqSU-0000Hk-VC
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 04:46:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691138812; x=1691743612; i=deller@gmx.de;
 bh=W4IpvJIxMRKVuZixXKDGMafBU5hIBdSYbG4FigxE6Lw=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=kAtpPCa7MaZstLkzhX/5r454qUQuGfnlS8Pv1EPtPndlmfIGxcFVM+N/9HS0jcmtgIj/ar1
 1naWTxJQ5rDVtXfXmI7TswtzExkMl3W/iwe974bn7AKA1y/9I24UNgqnS0pFHYBUAex7iA+Ez
 mbZLlxL+Ru766YJw+tpiK/PNqXmDjGeuotftIMzkAC6peaEodEfX7kHvkL/OMVyzocBdtoicc
 QajIkoLQwsx7eSngIMrFyGi4Q6zi04HlRWSdJQncVGLEbHQ7sDJFB26zElqBdEoiPZ5SY74K7
 Rm7vQZ/zXjVHHOFOd/2L4culPn5SG1aQIMEH5MWyoO/syQYd+Dig==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.152.187]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MuDbx-1pXx0z1l4X-00ubLH; Fri, 04
 Aug 2023 10:46:52 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Helge Deller <deller@gmx.de>
Subject: [PATCH] linux-user: Show heap address in /proc/pid/maps
Date: Fri,  4 Aug 2023 10:46:45 +0200
Message-ID: <20230804084645.36077-1-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Fun48LZ2kjlRGMvUWML9+Y5T5RuKBAC8cYl1YaUR8ssQSvJnLzN
 AInsDT2CyarPG3Ckp97n9b0ui28UM7rjJikfct2zpmZZ0olhhLv+MXffoatFKV9U6kqkcHC
 pHbVtLvz24R4gqNGUMtpagBe2Sv2+swryGuLAGbHqW5gWr2Fu2vQ/c4SP+lr8GwQtze7dkh
 6ePKskLV+ihbpzqN/enPQ==
UI-OutboundReport: notjunk:1;M01:P0:DgHNV1xD0KY=;kFf+vUz/0EIZlC/mKR3Y9XLL04k
 aE/cQe4omqbceWA0rG5zSFZ6FwxBiJNUFCOZo58SXmxRdqhlgYxXJwN2d1cfZ+VpVsqKO9N6Q
 C7cCCHT1R19FpyjA72CMbf/XsgH2e7DYgeFJyirqi40M6Dtcnv8/hIbmwnFpBojETnaDj79Cr
 QJjdVcGfcH46+SN2ChLbKOmh7WsSC5XlOTDmD84UeL7oG9Rx96z/NYOiZgBAVep8cr34XC+tD
 +y5HNqdfATGnj2NKtioQn1J4d3IUSdOElCWDIZSlfCd/dNSKsoO0r4a2eK4vxkSgq5Hb0IerB
 kKJ1OazdwpoS73JbH0wvIrAIyVl79zJCuvRsnL6c1dJ+BZQ7AcmlwLE8EKY6auWkPda61MZ4z
 t6IRPXt10URGDiYz8muhVZRdj1/4Xr8ylr83IMoYYyCYFyA9wMOeQdfGnwFHAB+3zjlAC2oWD
 MqVjcRB9X9bdKbsG61cC/lIlGdrGZS1Uykxd8kEtK16RgMmUnA8bycJS/OxaHmAUry/JBQ4VI
 3ne37+3bVknNmYDUVz7JerOy9421r68OnanV9lrk5fCsHDF/BzB0ZG3nZR64NE0qgjUHRUnSn
 9rUO+SHGrUpwHIFXr8CA2eTy+/KlgtEAtVDP25mUGeRRkL7DjF48Kadf/b/e36TjVFisPMo0R
 66QbTCkPKfrlpShCYpZgFaDYnMb0MwJ290Ox2W2dq7GVaTIoTJ9zH/0R9vNkqhD+BmbcCae5D
 apf4ZIwsC++nn/uZUE4GRaPVaODGVvWTT/0gmY7nQntxzTqu9IVzZmGHMhMgq8jPTliWOWsPP
 Pb4uus8kUGf+tfgAQq2m5zouI3H33j+6uezatSoeLNULLcpZjutdvdKLc3qOumrmmgg/F41QV
 NyCwFAdmZlQ+UV78cRogmmzfv9NOyTSpodzVDtccCrbRPJyp5/UGj1+RSgZa3b/apNazwYzWP
 CRhsCITIZsU/Y5h87Yl9Ne8NmQo=
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Show the memory location of the heap in the /proc/pid/maps file inside
the guest. Store the heap address in ts->heap_base, which requires to
make that variable accessible for all guest architectures, not just
architectures for semihosted binaries (arm, m68k, riscv).

Show 32- and 64-bit pointers with 8 digits and leading zeros (%08x/%08lx).
For 64-bit we could use %16lx, but we mimic the Linux kernel, which shows
even 64-bit addresses with %08lx.

Example:

user@machine:/# uname -a
Linux paq 5.15.88+ #47 SMP Sun Jan 15 12:53:11 CET 2023 aarch64 GNU/Linux

user@machine:/# cat /proc/self/maps
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

Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 include/exec/cpu_ldst.h | 4 ++--
 linux-user/main.c       | 1 +
 linux-user/qemu.h       | 4 ++--
 linux-user/syscall.c    | 8 ++++++--
 4 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index 645476f0e5..f1e6f31e88 100644
=2D-- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -72,10 +72,10 @@
  */
 #if TARGET_VIRT_ADDR_SPACE_BITS <=3D 32
 typedef uint32_t abi_ptr;
-#define TARGET_ABI_FMT_ptr "%x"
+#define TARGET_ABI_FMT_ptr "%08x"
 #else
 typedef uint64_t abi_ptr;
-#define TARGET_ABI_FMT_ptr "%"PRIx64
+#define TARGET_ABI_FMT_ptr "%08"PRIx64
 #endif

 #ifndef TARGET_TAGGED_ADDRESSES
diff --git a/linux-user/main.c b/linux-user/main.c
index 51ee8649e2..c1838f5d4f 100644
=2D-- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -986,6 +986,7 @@ int main(int argc, char **argv, char **envp)
        the real value of GUEST_BASE into account.  */
     tcg_prologue_init(tcg_ctx);

+    ts->heap_base =3D info->brk;
     target_cpu_copy_regs(env, regs);

     if (gdbstub) {
diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 4f8b55e2fb..6d08453124 100644
=2D-- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -119,11 +119,11 @@ typedef struct TaskState {
 #ifdef TARGET_M68K
     abi_ulong tp_value;
 #endif
-#if defined(TARGET_ARM) || defined(TARGET_M68K) || defined(TARGET_RISCV)
+
     /* Extra fields for semihosted binaries.  */
     abi_ulong heap_base;
     abi_ulong heap_limit;
-#endif
+
     abi_ulong stack_base;
     int used; /* non zero if used */
     struct image_info *info;
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 7c2c2f6e2f..beba1c9cde 100644
=2D-- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8090,14 +8090,18 @@ static int open_self_maps_1(CPUArchState *cpu_env,=
 int fd, bool smaps)
                 continue;
             }

+            path =3D e->path;
+
+            if (ts->heap_base && h2g(min) =3D=3D ts->heap_base) {
+                path =3D "[heap]";
+            }
+
 #ifdef TARGET_HPPA
             if (h2g(max) =3D=3D ts->info->stack_limit) {
 #else
             if (h2g(min) =3D=3D ts->info->stack_limit) {
 #endif
                 path =3D "[stack]";
-            } else {
-                path =3D e->path;
             }

             count =3D dprintf(fd, TARGET_ABI_FMT_ptr "-" TARGET_ABI_FMT_p=
tr
=2D-
2.41.0


