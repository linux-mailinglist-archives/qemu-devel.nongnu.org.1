Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC837617B2
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 13:53:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOGad-0006w6-Dz; Tue, 25 Jul 2023 07:52:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qOGab-0006vI-Cp
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 07:52:29 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qOGaZ-0002Kq-If
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 07:52:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690285941; x=1690890741; i=deller@gmx.de;
 bh=fVQFPRK5enCK1ItFwvcU3gz1ISxvjWP9wzrocVMsB/0=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=anmAjmIrfR9TvcxJT5K1u7wnv+p8lDsRtowT2Q1fDPI0EVJU3UCi0IINUAu45s1CG2jPAam
 xF49HPgIndfPJN9e4eLZFRMTpGfMPH+nQo3Dk428CdobVaiJCtXVSc9yEu7g3HmPZYfQz2xHw
 KD/s2qyVSbViExSGmJVJphyIdnjCzp4qFsZ5YV9nT4nejQ77TciEsh1HPvSPXqQHqVdySKdg+
 cHfm5KmAE3GQVxb6Wny5lw4eW+3RI51NVxmd9x6YNO0CP5WwdOfDpsk18/ZrE6gnHyIJUnMuT
 GQ9Kbw6UPDSrN9C16z96apXTKRGEd4mBZYDll8BJ1Idg71/xaJDQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.145.136]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N7QxB-1ppmDg0VhN-017oVS; Tue, 25
 Jul 2023 13:52:21 +0200
From: Helge Deller <deller@gmx.de>
To: Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 Andreas Schwab <schwab@suse.de>, Laurent Vivier <laurent@vivier.eu>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Helge Deller <deller@gmx.de>
Subject: [PATCH v3 1/3] linux-user: Show heap address in /proc/pid/maps
Date: Tue, 25 Jul 2023 13:52:16 +0200
Message-ID: <20230725115218.52738-2-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725115218.52738-1-deller@gmx.de>
References: <20230725115218.52738-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4FDIsh9x/zU/eCt5ZyQR6IERFAzFtlB1TOYA4hJ4NLCp+Alld8S
 E7Tpfv6mU7SZ7RoJUX5WBehq8ctj6FeICCUst424P4jveaBg8HwmeSTZXAUGwBBHsTMdCxI
 2Z7IL7i+lXciTWNG9bjDJ67wMyYYFIGmMiVbShTaFgWqcqytpmVvdfzLMBx4ZtbxzpzREWk
 0H6cWATcZTCGOUGd46aZQ==
UI-OutboundReport: notjunk:1;M01:P0:Anh58Xrp+gg=;wpwPunikxO/mo54W9IEj2lky1z0
 XI2h7H4ZDGCH4UtD1ypp7dDFDM3mZDAu8uFVfxzBvrlnapjZmlAK2twDB/Jyvs4dEgIwSQvh2
 qtmcXvZh1xbI2rUilPpKcG02Imk7dcuNStS/oqbviyU2/CidNGPvTkUn+JtXEyBMnCP4kAMgb
 l3DZxUDUvwpaXhW2gw1clKdxILrk5M0rnOqMTA6N2ToFJNiJeIWqXy2nJ+QzoOFQlRafzeNVG
 ikG63FcW4YPUO7veJrzhId4kGcHD52qcK8VJoPR6ETmMQRRBH16m+5/9lbmLwvnEHgBLZu4qj
 cl8BNLBs1VyBxeT0UBs2Pfk8ErR2iuLZnePhOEeWAdaPi65EBQyovb3hETxW5mZVXbqo/OEN7
 sL8DhR53s3ktkQHsueELTHvHJcuNP3fIa1Pridijgw9b3XR5ehvjuD++I5t5sctJ1/MlZ2iuq
 SbVT0Ggp6Ay+zDg8zGnr2t2m/yPCsHtbXZ7e+UpsHTUjoIn9nI+rWHGC4L3Qv4QCFMEYc1qmb
 HZIXr+0ttfhegpuYsQh5lDrSo+tfs3USS4ziXY8krucfRqi4/SqhJotw6TNjhPvLJi0Ehq9ID
 KRT6lQ8Bu1cszzh3jLMQro9AEiBU98sdkDqyIXHDlNtIbkwV8vlvCfG+kQuE9+dQtiKS2cfRk
 h2B5vBeApAefsoS8JecusaIqnNG4pA46D+8daZmUjlPsxygnpRJGEpxHq8wIceEq2Q65kWbZJ
 eorogocbbCfS7W2+0D9bKmjfMvSZmALToS3GG8lFpvJKlyNZINWPFYb5EXYOVr598RpWh6Zvs
 UT6qg67gcO2VKqjs365G1wDiCde2Xeb2EuttaVACVSOjk8CcbJsTHqm4zLxbQMaTFzFAqLChi
 Fj4adA3/XoU30BiampMHbEnD+YiWqqjVduCT7aycH7K4zncknGn+DCyQ94pX53TTipT//KAkF
 kAUwGQ==
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Show the memory location of the heap in the /proc/pid/maps file inside the
guest. The heap address will be stored in ts->heap_base, so make that
variable visible for all guest architectures, not just architectures for
semihosted binaries (arm, m68k, riscv).

Show 32- and 64-bit pointers with 8 digits and leading zeros (%08x/%08lx).
For 64-bit we could use %16lx, but we mimic the Linux kernel, which shows
it with %08lx too.

Example:

user@machine:/# uname -a
Linux paq 5.15.88+ #47 SMP Sun Jan 15 12:53:11 CET 2023 aarch64 GNU/Linux

user@machine:/# cat /proc/self/maps
00000000-00009000 r-xp 00000000 08:01 2380521                            /=
usr/bin/cat
00009000-0001f000 ---p 00000000 00:00 0
0001f000-00020000 r--p 0000f000 08:01 2380521                            /=
usr/bin/cat
00020000-00021000 rw-p 00010000 08:01 2380521                            /=
usr/bin/cat
00021000-00042000 rw-p 00000000 00:00 0                                  [=
heap]
5500000000-5500001000 ---p 00000000 00:00 0
5500001000-5500801000 rw-p 00000000 00:00 0                              [=
stack]
5500801000-5500827000 r-xp 00000000 08:01 2395258                        /=
usr/lib/aarch64-linux-gnu/ld-linux-aarch64.so.1
5500827000-550083f000 ---p 00000000 00:00 0
550083f000-5500841000 r--p 0002e000 08:01 2395258                        /=
usr/lib/aarch64-linux-gnu/ld-linux-aarch64.so.1
5500841000-5500843000 rw-p 00030000 08:01 2395258                        /=
usr/lib/aarch64-linux-gnu/ld-linux-aarch64.so.1
5500843000-5500844000 r-xp 00000000 00:00 0
5500844000-5500846000 rw-p 00000000 00:00 0
5500850000-55009d7000 r-xp 00000000 08:01 2395261                        /=
usr/lib/aarch64-linux-gnu/libc.so.6
55009d7000-55009ed000 ---p 00187000 08:01 2395261                        /=
usr/lib/aarch64-linux-gnu/libc.so.6
55009ed000-55009f0000 r--p 0018d000 08:01 2395261                        /=
usr/lib/aarch64-linux-gnu/libc.so.6
55009f0000-55009f2000 rw-p 00190000 08:01 2395261                        /=
usr/lib/aarch64-linux-gnu/libc.so.6
55009f2000-55009ff000 rw-p 00000000 00:00 0

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
index dba67ffa36..12f3d8a93e 100644
=2D-- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -955,6 +955,7 @@ int main(int argc, char **argv, char **envp)
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
index 95727a816a..220c4a04b8 100644
=2D-- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8131,14 +8131,18 @@ static int open_self_maps_1(CPUArchState *cpu_env,=
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


