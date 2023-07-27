Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF11976484B
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 09:18:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOv4e-0000rJ-LO; Thu, 27 Jul 2023 03:06:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qOv4b-0000qe-OD
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 03:06:09 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qOv4Z-0002rO-IR
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 03:06:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690441562; x=1691046362; i=deller@gmx.de;
 bh=fVQFPRK5enCK1ItFwvcU3gz1ISxvjWP9wzrocVMsB/0=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=pCZHkRKBUsGBUkUIAQ/WslOwWV0nr1LsnSTxNZ9AdOUJ+TwwqKBdmFj5fVK11M7JXHd+8/L
 e+eL8i1nRXhKy/SstL8s9ud2Jm7JjYDfnGBLTocRs0in4E4lLAcRZfMcty+1QX66HjP1qBsva
 0M4FtM6byxlHm4pAQ+CJHKMIUiG16HrapG30vECpQyNaaJ2NWP7+PC2KfEwBW90/4dMXAANqP
 YrgtpTnb2oPyIffSuPNHHNAkIqnTjRlvzXiSLKq9GzJTpkIn6bX9rTykGNtuEJbYVLFyMbd9z
 E+YmtXQy2B42mCEIRLJ0R8Cls0vjJhmN54c3AiRXfggZs/WpYbog==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.159.20]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Ma24y-1qLhXB3t6y-00VuGL; Thu, 27
 Jul 2023 09:06:01 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH v4 1/3] linux-user: Show heap address in /proc/pid/maps
Date: Thu, 27 Jul 2023 09:05:59 +0200
Message-ID: <20230727070601.31383-2-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230727070601.31383-1-deller@gmx.de>
References: <20230727070601.31383-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HKEvNr9QbHF0n79Y/QHEW5mAI43hjR02pSFaYdVj3sUeKrg5Mt1
 7XKPmaOFmnDH/oADKkrt/N9+RBPq3e8eV4Kq84rU/5U9g918TzgCa02LzyJecnXiRqnBEJR
 /TG/kFxKxGxAf4tIS7FcsH81g+kNKgBc5PXi47xJNhDFp98UuZwZM11KrGYyafYh/zWhTlU
 43yk0R7fidfwtIz5Or7kQ==
UI-OutboundReport: notjunk:1;M01:P0:dyWiSlWhm/g=;eioH0rBvB9j9bNwxTLrebSJ8noK
 jaxPyhV34Kj+myMyjcBI+xakTo3YNCOww+Bbg/luz5VVsPXz7cmILRq/PPZPhhp19bPGavds+
 ZCH58UNGTD5jWv0Y0EcyV7qg/pqOaROYzNKT6vCzo2TBVHe1e7F0FgUMHFP3O3zTZFvRR5b6F
 +vyeBqXUG1Re1lrFAg7Ti3XY5WRe+HqARogvT+sfKpxFL2d9s37JQWt0FTBVD3XYrkCdUBQ3R
 hmT9KY6ZDt6l1DMU061jdkK33jj1dHmfJmtoQSsY9FcQvCawb3U3yt3C4oyU5Bqo3J/I5li+f
 27VNLMQcMWQDsp9/wb8rjVEanGWCeKp1Jl4OOiFcht/95EI75Asw06kABkktT4VgggvCKoFU2
 Vxxs/ilgPBt2Jtjjqr+1wa7yRIvAn6PddqPc68np0n39gzFqG/k120HZ2Qs3FR8wa71P5y12h
 b8vptjYxu02zfkXByI3iACjgD8deNY6o9wZRlZP1SLLB8s+H9s8RLtxAV04LSoIDGm14LrA+S
 D2oMU8o2qjYwPHefyD+wyNecbrlhvEj2LOonDoRe1ZrYFONcr3U5eLYP2DOn6cgRrpfltdNVt
 0yEMVqbjauOF3tcCgM0Rlwio7YR0AARb2F+95sNhaPai3vO7erS3XpfrTFtqqshER456rxoYj
 heedW1C608CGTZ39/0H3PaS59eUUVyL3aV6nh483+O+rYGzNFPwU/cYZWaa01Gzlw6dUjPvNr
 VGz1vlf4Z8VT73npJp/okastnPQA9QQqbsXgAez4K0KyOaHos96GyEpMlpxwouUGCGxBiKtPQ
 d9+E3xvChLdnjUAgewEWEfZcfNudFT/hLJ/OsPvTkh/8OGJTfSZD707oMeBlusIMAKNFvPfvP
 OwQAofYxhngHYSxAEGZ8k7f72ELGPeWJW842tKo2WiW4Ar63YTB+mOxZbDQHZhKYz/fQbYjOd
 50mRRsaNpmQSPy3GDvDZw0PjKUY=
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
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


