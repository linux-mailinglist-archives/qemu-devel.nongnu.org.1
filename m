Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F3E76C0E2
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 01:30:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQymU-0001Jn-93; Tue, 01 Aug 2023 19:27:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qQymS-0001J9-Du
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 19:27:56 -0400
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qQymP-00078A-Gj
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 19:27:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690932468; x=1691537268; i=deller@gmx.de;
 bh=zaJutCebOOz0E3/UV6NEgL2gk9VANF+T02Ta9HvtqlI=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=pTrWyjIsd4aS+DPs7MbWYgAXPnfGwrAqwUvZu1sfsLPHvuF5UZJhVRrJhyrxTIwC/qF3ztc
 +d4wBurnZML3W6L2+O7imFoXnVbPFLno1ePd+rDGrMqDVpqpKgLIXUsQ7TXocUbMcI6dSKpQN
 ufXlviImeT9I2ZeixhbymZmI7UjIz+Xd9N3lFdhfGHGjC6AlSXo9xe9BDZU7P8+VdL0YOffAj
 wDtYo0UNsaBI14XrFYGBPn88srs4U4rJqnprblyuJsOqisB9zATtoWH0C5fAcp+p8kMezXc7O
 GmB3eAI22ouaeVY0vD9VD3bYeBXtjaTXenbJgVGqgjHKWm1dwO+Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.150.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MjS9C-1pyq1W1GMU-00kyMy; Wed, 02
 Aug 2023 01:27:48 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Joel Stanley <joel@jms.id.au>, Akihiko Odaki <akihiko.odaki@daynix.com>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH v6 6/8] linux-user: Show heap address in /proc/pid/maps
Date: Wed,  2 Aug 2023 01:27:43 +0200
Message-ID: <20230801232745.4125-7-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801232745.4125-1-deller@gmx.de>
References: <20230801232745.4125-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FcSKaqRG+UQoM/e8bVKZMhJhM92ldW50ooy66A+1sZs6BFfQhI8
 0Del+mw0qLTPjRlkm7EGfHAWPFZsNJE/HHbSC/J7uHwLyEUU8yHZU4IsJsDWknzCsn/mZya
 GVzdII3YfUqdlzKTJDq5F0qXr6jFGkb0WjeRnfokcJtc72g2DeivRqTRSMuB8APbpnBCmov
 emFK5YAUPRqYT99+Xb3Gg==
UI-OutboundReport: notjunk:1;M01:P0:3abnKUOp52I=;c5LZGAegFhlRiUEfFCKHzxn8agj
 TvSfQNLp7lZ3ZDD7mTdAGFHpd3KTHmaMGmNBy3JTnwEhfKcsIRdHT/nuCwyyRcs6GHwCyv9Mg
 ii1fU/wTtwMQmrbmn4abO8jj7qLhhyUYSnO7EGy9H0fq6a4YCofBwOZ7uwiw4zhYYwx5csJXG
 YWz7nLKYDoIj0cwYgyj6mq8MIIeltNIHU8MWR5JtqwYcERwTNOi9zsQkjFbilWdWRZueaIz4P
 bV4tCbmb1/uK7XMLmp8wKzs9Bl9OzhFYAggHaLFmUJDJ3jvuyD//DhKVyGYx17p55vE63+Pp3
 u8k437NG9WQ8EYz4TAU4ql6DG9q0RYZbQaYeIrnwK48/W5B8i4Y+WodzQmpw/6s49FMgupGr2
 FPc5IwKIr3pYuMBtM1DgVJ1KbPBghCxtLBLi2yJjl+s8TsrZwiwIjS53kfjgT8b7esbzvtZAi
 z7+EWaPE2miKZav7ftMAmf6gSMfBlsCh2en2wHBW/vDgKefUVa+kJMamdXibf638ThYt/i7eX
 n1gZvjgY0FRY8CQGbw/A6vHmex0jTX17suDT+uGue/BwxjTlYD7eAog+VFgxW7NIByi3ohXUX
 bVlMdOszqk7dxZWRnm7rX+rAAhb7yEQxN03cIACCPzpNxQGZ7dTKzXGLxafd6kuiij8bvft6c
 YMy9zQlpZRWEeqflaGL1TEpRAQbG4pZMxZRNVMNofnpxp/o+82u7AxVTya34hEdXk77hLl1YC
 ut3HWdOAR17QdgFf4O7TkIL0B6r1S7kUVZQnFUNVncv1Epfo8V9ZoBVztB4F+qOG3vJNe8XuD
 6StwmnDWBYzTdkCX+BpygaVBul8abKGQP14GYBIzytklT6cKTWxAHOOY0A3RLACxrfBOh8za6
 xHJIxgYT8a+0CoHujet3Ng5PGnygv0mimStRg1blEnl+P1po8fBZPvzzxa0MLhVoK+5dea3Pd
 lkWKv7ZkxG058svtFkTc0y/FsMs=
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

Note that /proc/pid/maps in the guest needs to show target-aligned
addresses. This is fixed in this patch, so now the heap and stack
address for architectures like sparc64 and alpha now show up in that
output as well.

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
 include/exec/cpu_ldst.h |  4 ++--
 linux-user/main.c       |  2 ++
 linux-user/qemu.h       |  4 ++--
 linux-user/syscall.c    | 13 +++++++++----
 4 files changed, 15 insertions(+), 8 deletions(-)

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
index dba67ffa36..fa6e47510f 100644
=2D-- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -946,6 +946,7 @@ int main(int argc, char **argv, char **envp)
         }
     }

+    info->brk =3D TARGET_PAGE_ALIGN(info->brk);
     target_set_brk(info->brk);
     syscall_init();
     signal_init();
@@ -955,6 +956,7 @@ int main(int argc, char **argv, char **envp)
        the real value of GUEST_BASE into account.  */
     tcg_prologue_init(tcg_ctx);

+    ts->heap_base =3D info->brk;
     target_cpu_copy_regs(env, regs);

     if (gdbstub) {
diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 802794db63..7a6adac637 100644
=2D-- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -121,11 +121,11 @@ typedef struct TaskState {
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
index 475260b7ce..dc8266c073 100644
=2D-- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8078,8 +8078,9 @@ static int open_self_maps_1(CPUArchState *cpu_env, i=
nt fd, bool smaps)
         MapInfo *e =3D (MapInfo *) s->data;

         if (h2g_valid(e->start)) {
-            unsigned long min =3D e->start;
-            unsigned long max =3D e->end;
+            /* show page granularity of guest in /proc/pid/maps */
+            unsigned long min =3D TARGET_PAGE_ALIGN(e->start);
+            unsigned long max =3D TARGET_PAGE_ALIGN(e->end);
             int flags =3D page_get_flags(h2g(min));
             const char *path;

@@ -8090,14 +8091,18 @@ static int open_self_maps_1(CPUArchState *cpu_env,=
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


