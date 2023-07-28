Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4265876757D
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 20:33:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPRJq-0006Zr-2B; Fri, 28 Jul 2023 13:32:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qPRJU-0006Sx-3O
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 13:31:42 -0400
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qPRJQ-0002n8-M7
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 13:31:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690565488; x=1691170288; i=deller@gmx.de;
 bh=j0OG3FRX465/8njpjGzgWhdkeMZO7GNiiY977hTnKug=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=tVvLltoITAD/TU/sj4c7DySBX1vGgEV+WuwAlIpbSuw+3kzsZk8LZlraWMJro4AKG5tbDcx
 PipiOpOrFrGPVlEa2BoqRsO6u7IeUmPJunrq+MJBJ3LngUhLmruK+1a0Va+jg8qo+hSXiIvzA
 EoeeMbMOu3MhRu/+VpohWuXSKeKTTtXzB4LVGDgXz07eVX1XfDhm3ePcsGNMxCyhPEc/VgfCc
 jIIdn1g+hcs4Oa4nddsh6FWKXEYE16Zd5U5ILM9KEG9TFYyrnz+CdSoQ7dzt8jvPVHX4G7oiV
 sMbrVBFg0mJiaPKbkIUHEv4HY/Qe7RohedBTjTFWDvUvQp3NMG8Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.159.73]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M7sHo-1qTGnd3ZVS-00545E; Fri, 28
 Jul 2023 19:31:27 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH v5 1/3] linux-user: Show heap address in /proc/pid/maps
Date: Fri, 28 Jul 2023 19:31:24 +0200
Message-ID: <20230728173127.259192-2-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230728173127.259192-1-deller@gmx.de>
References: <20230728173127.259192-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TZwdUk5CRXSEucmFv+vgl6gBXD/IVTDsb3Iu46EFkIVUknyoImh
 vwm/JCAO1wXxUEMP529BuXkCQvmK7yerMwzzYAbdWeeJJTZ+oEwiMzDE8Ad9OXVUlSEXvIB
 6GYGQ5jik0+iJH7ufhAPEm9LjWQHBe85OXhP1xPD9mmQ+Xb6aZI9RgaCtTN2o8EA47sypAi
 GOecQ3j+4HVmv5P7LHp4g==
UI-OutboundReport: notjunk:1;M01:P0:nkvVeSt3Lp0=;6URYg1+A3bTF3ldU/WBW8GFaGpb
 f8r49/Nxc1xbtIvvAS+yTGORWIq2Su1nuJcTA+S4OujS1pPd5n7o41gWJ+oiMSyiiCQA2d4Fd
 LuDJ50hy4HtNBumsWDAaWhZr9ppJlPhOjlwnDg37W/9JY+7g3EmxuQUHNxJhGVwX2TnysaPG5
 8hvc10AC96WwdM3y5Oo4bxfwLheisnLZ0FmFSiTVBnahpHDBqCkDvEu6RjfEkyP7QfDwDJYtZ
 QRWK5JDEU66fVLWbheAyH3Ia/1nkaAMuBTDiron8Ciei/kbbOoSAWvmuBVpYk22ArCqUL3IEe
 9k54edOaY3gPOylD6mDp91CEr8UwWnI+wq0F6f6f5pqWGlWX9oo5QbT0HCYQzmXaH2e34zVlq
 /f84iYzcPSk08BstmNH4Is1CmPnhTScOuLTntk3/vTVYYkNby7JlW6FH1vCur5X8m8qDDn9+x
 XZ88cuewsfQlYV6YC0+Te/Flu78QFaCB5A+1/caRyI6o7sDrHI0GWaP39LRBqm3ynNjmS/3f9
 6pAcPjaqeUwAkH08YpNnQIAukTOMvcdFNUsAteGdAUW4efdRvwt9cm602ss0dBht6N4HMl5kq
 G7RP+4X+Hvo+cKE6DEkie4soHD5ZJBiAZRnwkLFxIe7wuV+cLQOvQ/8VBC6eAv9qz3yvToHYA
 DgfNrrFkHb3+anPpIsjAHFbz/zR6m6BlqU8woUpRaGC1vGTyBq0v7CU1YA//NsJktp+o/aKLR
 aICbiiMZB2lkb833G1p1AMyWhBClpSbKgJI5kHpIjlE+osb3Zs8hS4LLV4TKPRySqpptDPFz+
 8NgYNj4aKKI2zI1MFzKhQnSVi5jRmSDT2JWov2zwyrWinPhmjsaGUb4TkBFtvZ/cyYnoqQn8U
 h94jgjQMoMsYe2y2sQkV/sAf5pAq3AuWOMkiH586+8DtUO6tKAXNu3I0S/y77SJr3IUSBI7tW
 0r/V1HunqClI+G0MpqfeJnaCC5A=
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
index 95727a816a..54abf273dd 100644
=2D-- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8119,8 +8119,9 @@ static int open_self_maps_1(CPUArchState *cpu_env, i=
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

@@ -8131,14 +8132,18 @@ static int open_self_maps_1(CPUArchState *cpu_env,=
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


