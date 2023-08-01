Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 435F776C0DC
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 01:28:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQymV-0001MM-Cb; Tue, 01 Aug 2023 19:27:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qQymS-0001JO-KZ
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 19:27:56 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qQymP-000786-7M
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 19:27:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690932468; x=1691537268; i=deller@gmx.de;
 bh=lAN249IyTXdxU+qyf5qo5ihznd6eja0cEzaQkKzVRDg=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=N7CJn+/jqJi/7qHQRoViMk25d2ZE8WR/PNI3x2dR79Fwq/G1/baWMhZSYvbuceKbuXIWFKu
 5qY+DgGBjN3mxRMYks1azhn99zhtMXUq4LBrSvmvNmbCWygAp8uOWUgi16G+xtfyGq8yiaSXD
 bAkffJ8wk/TYKQ1nBIs5EbdsDqwmgLe8GseAFzJkhjOBa3nW6AlKujUXeWh6W2HzruGqTpQev
 0OaFvAgK+R1AwirksN5mRhbfmqswDEYE2W+FMjLU6CHMbsSo11HngVY+7FGj4eqGECFNxmIiX
 5M/P5kNJBEIVcNDSKnYa+4q6QLAtQwp+1CF/x7qz/UzzRUlwTrEA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.150.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MCKFu-1qaMhK2Gf4-009RlI; Wed, 02
 Aug 2023 01:27:48 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Joel Stanley <joel@jms.id.au>, Akihiko Odaki <akihiko.odaki@daynix.com>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH v6 7/8] linux-user: Optimize memory layout for static and
 dynamic executables
Date: Wed,  2 Aug 2023 01:27:44 +0200
Message-ID: <20230801232745.4125-8-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801232745.4125-1-deller@gmx.de>
References: <20230801232745.4125-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wHB8943utChrnrZuINliwuivkUPx+xinjcGdb6oRRoDh4B10PkV
 H3nAVCjTXtm5nJ1MV0MNOr/GnP1euQFfxvw+bNEF0HzSuRQnJ6obLkC8YBOcojuOYUQinQD
 +kzpcyR46wvHi+p3FQC6PU6PPdFhK8UFLELWC9Br+BB0M6zyD4eisJSdNV3EShwRuZR0UEJ
 qDI/bro7//3WyKa/Pskdw==
UI-OutboundReport: notjunk:1;M01:P0:kK2wHqQeajU=;x9uVhfPvK5WHWhvDx24BVvQgc2M
 DxSQlbp46+Bis6N4IfRm+D0EZaDUMMkP6XxPhHJs6ZeS8zqIOhZxHcRzMIGOQIWFp47h5Q6XO
 hmPmbqHgPLr+DIXXdB56anNptFZ/mqoMsdrMHHvj4sIrtf325vLdWz5G6whoZRcPGvJ3A7429
 2FYm52CY1+M+GRlTY44Gtkl2tQr9DbgFnL5v6TyJ0y4I4swh5SjmHpDyiOaTmB5UbxNv0pNVm
 yrMW+szHBeeirXnhYCscD+bXSY/Orl7PY6SCpGOCrJmYlaIzJIxMADbRctxjbMv3obbmujkWn
 wWs6LjpgkE/DHQ0KzDSd6AysAkkgsJ3snAVwucoQpiOUgK962rTid57R3lFVTaW3cHFcebeS1
 7oqgQpbAgJZ78gPwqi5141cXQssxSpYmn4ML/3ymPZ/JFs7l7rLaCFSgu3/IuNZLZal3gKzfq
 iKGXmEUZAOmgKWXH1BvOqb3uPEkSyBMSYMrciRsjCXV/ZITiQk8iDkZc1XQTBxGuiuoWEXdQu
 Xb0u5Asza/PdcwOuXUjMyTqCP4Uja06p6fLyuKolYtmssmoFt7k3rwuse3KnmbwLOmM11D5SU
 yimOxFTIJyuOKxHx05EeJnJdhZVPh3fdg+KQ/bSe/J/F9MDgD1ptjEtfSOUnswQgqNNYFUQ4+
 CTziegnA+qdcrKYsUYpn4Z5QRgJBM7+huf4avv0vvcTJ6ZiZ7DjXmpxrxmN3P2K0yCPaYRjNG
 /YCZ4m+ohCDHxjywihpxJxQl3P9ckpwnnwwRDENZOKCX6DdxwrgmTirIiP5h5ZW6f21Gj004W
 2r3Lw0EVbrCqR065prPVd/dueMHywk3yIysY+Co6MUw+nogZFDerHwYZerCxbuUYru2D1mytM
 m/7QNy5o1S+YNlbR9tqKgIS//5J1m+rWlLfDNaqoSnTuL3sOXh2EOBe+9cIXK/M1vNMYw2XQg
 3Ce6FOcZZWL2aeR6d7tRosvxbNI=
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

Reorganize the guest memory layout to get as much memory as possible for
heap for the guest application.

This patch optimizes the memory layout by loading pie executables
into lower memory and shared libs into higher memory (at
TASK_UNMAPPED_BASE). This leaves a bigger memory area usable for heap
space which will be located directly after the executable.
Up to now, pie executable and shared libs were loaded directly behind
each other in the area at TASK_UNMAPPED_BASE, which leaves very little
space for heap.

I tested this patchset with chroots of alpha, arm, armel, arm64, hppa, m68=
k,
mips64el, mipsel, powerpc, ppc64, ppc64el, s390x, sh4 and sparc64 on a x86=
-64
host, and with a static armhf binary (which fails to run without this patc=
h).

This patch temporarily breaks the Thread Sanitizer (TSan) application
which expects specific boundary definitions for memory mappings on
different platforms [1], see commit aab613fb9597 ("linux-user: Update
TASK_UNMAPPED_BASE for aarch64") for aarch64. The follow-up patch fixes it
again.

[1] https://github.com/llvm/llvm-project/blob/master/compiler-rt/lib/tsan/=
rtl/tsan_platform.h

Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 linux-user/elfload.c | 55 +++++++++++++-------------------------------
 linux-user/mmap.c    |  8 ++++---
 2 files changed, 21 insertions(+), 42 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 2aee2298ec..47a118e430 100644
=2D-- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -3023,6 +3023,7 @@ static void load_elf_image(const char *image_name, i=
nt image_fd,
     abi_ulong load_addr, load_bias, loaddr, hiaddr, error;
     int i, retval, prot_exec;
     Error *err =3D NULL;
+    bool is_main_executable;

     /* First of all, some simple consistency checks */
     if (!elf_check_ident(ehdr)) {
@@ -3106,28 +3107,8 @@ static void load_elf_image(const char *image_name, =
int image_fd,
         }
     }

-    if (pinterp_name !=3D NULL) {
-        /*
-         * This is the main executable.
-         *
-         * Reserve extra space for brk.
-         * We hold on to this space while placing the interpreter
-         * and the stack, lest they be placed immediately after
-         * the data segment and block allocation from the brk.
-         *
-         * 16MB is chosen as "large enough" without being so large as
-         * to allow the result to not fit with a 32-bit guest on a
-         * 32-bit host. However some 64 bit guests (e.g. s390x)
-         * attempt to place their heap further ahead and currently
-         * nothing stops them smashing into QEMUs address space.
-         */
-#if TARGET_LONG_BITS =3D=3D 64
-        info->reserve_brk =3D 32 * MiB;
-#else
-        info->reserve_brk =3D 16 * MiB;
-#endif
-        hiaddr +=3D info->reserve_brk;
-
+    is_main_executable =3D (pinterp_name !=3D NULL);
+    if (is_main_executable) {
         if (ehdr->e_type =3D=3D ET_EXEC) {
             /*
              * Make sure that the low address does not conflict with
@@ -3136,7 +3117,7 @@ static void load_elf_image(const char *image_name, i=
nt image_fd,
             probe_guest_base(image_name, loaddr, hiaddr);
         } else {
             /*
-             * The binary is dynamic, but we still need to
+             * The binary is dynamic (pie-executabe), but we still need t=
o
              * select guest_base.  In this case we pass a size.
              */
             probe_guest_base(image_name, 0, hiaddr - loaddr);
@@ -3159,7 +3140,7 @@ static void load_elf_image(const char *image_name, i=
nt image_fd,
      */
     load_addr =3D target_mmap(loaddr, (size_t)hiaddr - loaddr + 1, PROT_N=
ONE,
                             MAP_PRIVATE | MAP_ANON | MAP_NORESERVE |
-                            (ehdr->e_type =3D=3D ET_EXEC ? MAP_FIXED : 0)=
,
+                            (is_main_executable ? MAP_FIXED : 0),
                             -1, 0);
     if (load_addr =3D=3D -1) {
         goto exit_mmap;
@@ -3194,7 +3175,8 @@ static void load_elf_image(const char *image_name, i=
nt image_fd,
     info->end_code =3D 0;
     info->start_data =3D -1;
     info->end_data =3D 0;
-    info->brk =3D 0;
+    /* possible start for brk is behind all sections of this ELF file. */
+    info->brk =3D TARGET_PAGE_ALIGN(hiaddr);
     info->elf_flags =3D ehdr->e_flags;

     prot_exec =3D PROT_EXEC;
@@ -3288,9 +3270,6 @@ static void load_elf_image(const char *image_name, i=
nt image_fd,
                     info->end_data =3D vaddr_ef;
                 }
             }
-            if (vaddr_em > info->brk) {
-                info->brk =3D vaddr_em;
-            }
 #ifdef TARGET_MIPS
         } else if (eppnt->p_type =3D=3D PT_MIPS_ABIFLAGS) {
             Mips_elf_abiflags_v0 abiflags;
@@ -3618,6 +3597,15 @@ int load_elf_binary(struct linux_binprm *bprm, stru=
ct image_info *info)

     if (elf_interpreter) {
         load_elf_interp(elf_interpreter, &interp_info, bprm->buf);
+        /*
+	 * Use brk address of interpreter if it was loaded above the
+	 * executable and leaves less than 16 MB for heap.
+	 * This happens e.g. with static binaries on armhf.
+         */
+        if (interp_info.brk > info->brk &&
+            interp_info.load_bias - info->brk < 16 * MiB)  {
+            info->brk =3D interp_info.brk;
+        }

         /* If the program interpreter is one of these two, then assume
            an iBCS2 image.  Otherwise assume a native linux image.  */
@@ -3672,17 +3660,6 @@ int load_elf_binary(struct linux_binprm *bprm, stru=
ct image_info *info)
     bprm->core_dump =3D &elf_core_dump;
 #endif

-    /*
-     * If we reserved extra space for brk, release it now.
-     * The implementation of do_brk in syscalls.c expects to be able
-     * to mmap pages in this space.
-     */
-    if (info->reserve_brk) {
-        abi_ulong start_brk =3D TARGET_PAGE_ALIGN(info->brk);
-        abi_ulong end_brk =3D TARGET_PAGE_ALIGN(info->brk + info->reserve=
_brk);
-        target_munmap(start_brk, end_brk - start_brk);
-    }
-
     return 0;
 }

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 2f26cbaf5d..c624feead0 100644
=2D-- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -299,14 +299,16 @@ static bool mmap_frag(abi_ulong real_start, abi_ulon=
g start, abi_ulong last,
 #ifdef TARGET_AARCH64
 # define TASK_UNMAPPED_BASE  0x5500000000
 #else
-# define TASK_UNMAPPED_BASE  (1ul << 38)
+# define TASK_UNMAPPED_BASE  0x4000000000
 #endif
-#else
+#elif HOST_LONG_BITS =3D=3D 64 && TARGET_ABI_BITS =3D=3D 32
 #ifdef TARGET_HPPA
 # define TASK_UNMAPPED_BASE  0xfa000000
 #else
-# define TASK_UNMAPPED_BASE  0x40000000
+# define TASK_UNMAPPED_BASE  0xe0000000
 #endif
+#else /* HOST_LONG_BITS =3D=3D 32 && TARGET_ABI_BITS =3D=3D 32 */
+# define TASK_UNMAPPED_BASE  0x40000000
 #endif
 abi_ulong mmap_next_start =3D TASK_UNMAPPED_BASE;

=2D-
2.41.0


