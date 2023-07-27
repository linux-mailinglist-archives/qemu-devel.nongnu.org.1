Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC976764AFB
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 10:13:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOv4f-0000rL-Ep; Thu, 27 Jul 2023 03:06:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qOv4c-0000qn-W2
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 03:06:11 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qOv4a-0002rL-04
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 03:06:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690441562; x=1691046362; i=deller@gmx.de;
 bh=pKnMUfIW9/Sf9A9l6uPQTG3DwwQZWzXRAKJkydm85ZY=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=J1DL/5k8b/tH4sBA/211fDwkqwvwWNqhgtg/SxmDPI1CZJi/VOQJQRbMDhqyJBE+cGpTGal
 HzK7Q2IRqVXVt9cNKnd8ialMsRr12NYBOEM+wYpiYt5CTf/YRjAs/H5sYr+FszusNDB14VD98
 b8YuXgu5zNJOL6H6WWidShy2y6CaxGcVenDWzdSVShRxs8tOqVMHKpySqit+2O+J5cWMOoLkz
 UsXI+PkcEdmlptrxQVQdPoOpFdOtwJ1hXNC3+OM8LFBK3TpWObh6YHGAqXtdD4FXLfDSY5g0a
 CpPrGgnyMwiYFFNk/oo6FabXWtavYPkcKH++sSDDPIg1Kj9PXQNg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.159.20]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MVvLB-1qHanv0xEL-00Rnem; Thu, 27
 Jul 2023 09:06:02 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH v4 3/3] linux-user: Load pie executables at upper memory
Date: Thu, 27 Jul 2023 09:06:01 +0200
Message-ID: <20230727070601.31383-4-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230727070601.31383-1-deller@gmx.de>
References: <20230727070601.31383-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GFaL+/aQFqXct/HMzeQrbDHg//CAhVdVeI4WBFtbwHfL6zPR8+Y
 b6lHntUmpRvMTtZ8j1640aj9we8a4V+qlbq2PvUpJ3eh3SoAcsGEg9+VEvwGAYEknXpUHnZ
 LYSlAFTtmNMxbCH/dCDNmV7zN0pUZkSePWHeRePJKJFf2tkVBNyBSoq0n40b/ycinxQkD3X
 2D7lym5ivYx6PX4NRiZpw==
UI-OutboundReport: notjunk:1;M01:P0:jv8/9ivQ5l0=;u+/mc8a78/yckpTMwb4z3GRuwxZ
 6dSzTa24soMg6Lnzk1nIighC3QAOD1RHKBDTKE9F8A09rht+IxXka5FzhCp/W2qVTcLTBYEw8
 wF0LXkLPmspfxy2f0y/Mjf8akrRZ+lqY5cO5vrunUTNcZZjTV/CQzDNHka90Y62iMBL8mM00a
 ZRqQrrtS2aAKIS8p3hJoitfcahL8ieW6mjwwrPwTbuZPiyFHO2haDtE4mz1HXpBYGrJsmUwKV
 ZoIRMhCM4JOEmctY5DJT3Zt+GUFKRrI1OJqrJCRELxR5Aabt81PFiT3DCSKAF6EnbH8mffLBN
 pgh6Gzr0xVBoPjkNjEpmZiHCRiBm18VJehUmLvMh1IPLnJvyhgJPUzEeQcZW06l95PGuh6h7i
 k0Za6tcoeRX/ep2gvlPDBD6on7l+mXCL4SeMjYVjbZhQ5MBBkl/8Gprl78sbQ3oguKlH84Fy3
 4BcJOms7QvxiBAegb0GTiBzeVcXl77xwvFaykqyysK4RNMv1wKu+6uDxmqhrK21xtIRKpuGKu
 v7rqO5NI++Rp4B3EixXGuH0xQVmQFh1ur4gRBbMYynklUOcxLT4s/KVz4KgpT6QvAwMK1HUQe
 vqbrJpIHGy7nDUjlXAMJArm2kcufAbN2IoFoZOD6nHMT0IMxGUY3nsW8UUP1rsbe3TDzUzmSf
 YzCtXIGlf8UGUUbe8TrnrYmJvkxHckhhESelmdqk6z6GJuqYBn4AWu5L1symlUgaJGzwOJJR/
 g4OYGZhrvYfryUQ9vLAJKcxCmDUNmDXXUN0GE7V8Db0hgOSxUB7JDtLKTdApyRrJeMwWUYkEd
 BN0QOnjRHB5QaD5fnuO6633QKE/cuVhU/qISJvB2bGYdY5SRNZ4Y9xZKMwd1QB3ckM9opdkz4
 +J43zfEfIa7UyrCynNIMfbWrMgYv4AuLD+RGlctMEh9To6Ywe7vcMlUjKFZusFb/odh0ORnSN
 B4srUw==
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

Adjust the loader to load dynamic pie executables at around:
~ 0x5500000000  for 64-bit guest binaries on 64-bit host,
- 0x00500000    for 32-bit guest binaries on 64-bit host, and
- 0x00000000    for 32-bit guest binaries on 32-bit host.

This fixes the Thread Sanitizer (TSan) application again, as it was
done in aab613fb9597 ("linux-user: Update TASK_UNMAPPED_BASE for
aarch64"). Additionally it increases the free heap space for
applications.

Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 linux-user/elfload.c |  6 ++++--
 linux-user/loader.h  | 12 ++++++++++++
 linux-user/mmap.c    | 16 +---------------
 3 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 47a118e430..8f5a79b537 100644
=2D-- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -3021,6 +3021,7 @@ static void load_elf_image(const char *image_name, i=
nt image_fd,
     struct elfhdr *ehdr =3D (struct elfhdr *)bprm_buf;
     struct elf_phdr *phdr;
     abi_ulong load_addr, load_bias, loaddr, hiaddr, error;
+    unsigned long load_offset =3D 0;
     int i, retval, prot_exec;
     Error *err =3D NULL;
     bool is_main_executable;
@@ -3121,6 +3122,7 @@ static void load_elf_image(const char *image_name, i=
nt image_fd,
              * select guest_base.  In this case we pass a size.
              */
             probe_guest_base(image_name, 0, hiaddr - loaddr);
+            load_offset =3D TASK_UNMAPPED_BASE_PIE;
         }
     }

@@ -3138,7 +3140,7 @@ static void load_elf_image(const char *image_name, i=
nt image_fd,
      * In both cases, we will overwrite pages in this range with mappings
      * from the executable.
      */
-    load_addr =3D target_mmap(loaddr, (size_t)hiaddr - loaddr + 1, PROT_N=
ONE,
+    load_addr =3D target_mmap(loaddr + load_offset, (size_t)hiaddr - load=
dr + 1, PROT_NONE,
                             MAP_PRIVATE | MAP_ANON | MAP_NORESERVE |
                             (is_main_executable ? MAP_FIXED : 0),
                             -1, 0);
@@ -3176,7 +3178,7 @@ static void load_elf_image(const char *image_name, i=
nt image_fd,
     info->start_data =3D -1;
     info->end_data =3D 0;
     /* possible start for brk is behind all sections of this ELF file. */
-    info->brk =3D TARGET_PAGE_ALIGN(hiaddr);
+    info->brk =3D TARGET_PAGE_ALIGN(load_offset + hiaddr);
     info->elf_flags =3D ehdr->e_flags;

     prot_exec =3D PROT_EXEC;
diff --git a/linux-user/loader.h b/linux-user/loader.h
index 59cbeacf24..799016cc99 100644
=2D-- a/linux-user/loader.h
+++ b/linux-user/loader.h
@@ -18,6 +18,18 @@
 #ifndef LINUX_USER_LOADER_H
 #define LINUX_USER_LOADER_H

+/* where to map binaries? */
+#if HOST_LONG_BITS =3D=3D 64 && TARGET_ABI_BITS =3D=3D 64
+# define TASK_UNMAPPED_BASE_PIE 0x5500000000
+# define TASK_UNMAPPED_BASE	0x7000000000
+#elif HOST_LONG_BITS =3D=3D 64 && TARGET_ABI_BITS =3D=3D 32
+# define TASK_UNMAPPED_BASE_PIE	0x00500000
+# define TASK_UNMAPPED_BASE	0xfa000000
+#else /* HOST_LONG_BITS =3D=3D 32 && TARGET_ABI_BITS =3D=3D 32 */
+# define TASK_UNMAPPED_BASE_PIE	0x00000000
+# define TASK_UNMAPPED_BASE	0x40000000
+#endif
+
 /*
  * Read a good amount of data initially, to hopefully get all the
  * program headers loaded.
diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 848d2fd4bb..9434bc805d 100644
=2D-- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -23,6 +23,7 @@
 #include "user-internals.h"
 #include "user-mmap.h"
 #include "target_mman.h"
+#include "loader.h"

 static pthread_mutex_t mmap_mutex =3D PTHREAD_MUTEX_INITIALIZER;
 static __thread int mmap_lock_count;
@@ -295,21 +296,6 @@ static bool mmap_frag(abi_ulong real_start, abi_ulong=
 start, abi_ulong last,
     return true;
 }

-#if HOST_LONG_BITS =3D=3D 64 && TARGET_ABI_BITS =3D=3D 64
-#ifdef TARGET_AARCH64
-# define TASK_UNMAPPED_BASE  0x5500000000
-#else
-# define TASK_UNMAPPED_BASE  0x4000000000
-#endif
-#elif HOST_LONG_BITS =3D=3D 64 && TARGET_ABI_BITS =3D=3D 32
-#ifdef TARGET_HPPA
-# define TASK_UNMAPPED_BASE  0xfa000000
-#else
-# define TASK_UNMAPPED_BASE  0xe0000000
-#endif
-#else /* HOST_LONG_BITS =3D=3D 32 && TARGET_ABI_BITS =3D=3D 32 */
-# define TASK_UNMAPPED_BASE  0x40000000
-#endif
 abi_ulong mmap_next_start =3D TASK_UNMAPPED_BASE;

 unsigned long last_brk;
=2D-
2.41.0


