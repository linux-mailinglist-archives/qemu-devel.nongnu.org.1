Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C500976757B
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 20:32:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPRJq-0006Zn-09; Fri, 28 Jul 2023 13:32:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qPRJT-0006Sq-8E
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 13:31:42 -0400
Received: from mout.gmx.net ([212.227.15.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qPRJP-0002n6-0D
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 13:31:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690565488; x=1691170288; i=deller@gmx.de;
 bh=9TH2AdWJCl9pPPf75k34jgRiKxXiicQ1fz6W3mcqY1Q=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=R4uwtKTCmZ76D01WGXublaSrmsqEvWUmi/X2bH97P8Je7gTxpotn7Q+32YsPz6KAeXlrmh3
 z/pXHFnbtXHXylKBlluTj6oxNIJybwZOAIYNqx5zg6+U0Fs7Tr5R8bV8k7ZxLUj9Vz529dZD3
 48woNDz8+xDlrraatOfzedwcGg/1OmNK5g5nViTnRQ0uzzoqQoI4Ec0Z7F+yXZ2jJRdWLqpnG
 DbPoLjHfCv9IHMrTyTuXMr5RRFRHIkxylDdxrOoTgvRiiDkgEROXMIodVtmd77lBdYGeGdeMC
 lEjAqVHEbwXenJ3xFySuOxqMclcA+v2w7vrodg2HK+kvDowftYkw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.159.73]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MIx3I-1q9PX00eVe-00KP6y; Fri, 28
 Jul 2023 19:31:28 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH v5 3/3] linux-user: Load pie executables at upper memory
Date: Fri, 28 Jul 2023 19:31:26 +0200
Message-ID: <20230728173127.259192-4-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230728173127.259192-1-deller@gmx.de>
References: <20230728173127.259192-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:V5BQ4mK34W4zi5l1+D9aUmuVjKV4/uao46H0CqjkMZxb1p+sPeT
 CKX5mDegLzuYLGgoEXs84t+Vlr3+HBKUHvXKMTBqJRtF89APcXeKFyPtbWJygQETcKiTxgm
 JhvcJIkNjGNbercBN5Kstnvwmj8+314fjCJNLuFQcO+hYrzAmC3XPkajNkjK03Dnqaf3iyK
 3p40m7RIEGrVUMMHzKZAA==
UI-OutboundReport: notjunk:1;M01:P0:dlikNTzfAPk=;roonChS6OtYeCoLcQz1oz+0U4kI
 QOktLapaUz5jM4KS6gfLGXPABb02ZXWqA5wz8fiOP3hW9ffb0dDVyKdm8kpq/M2WmDQE1fvr4
 2bFDLPPc5Gr+hsQK1Tb4d91fyO4elx5sxV+aZL39kly9x6JOx+wXcPtyQXIdm/ajDFR44Y8oh
 g3ZxsPG0LJ8fO//jecOUqtwBiOxZJRU9A+mqvWYVAwLoVzPYMgjLEs6GDr45XsiunX7MihtvO
 MQeBTEwIvfBojmNoTI+HEqSTmmtvVQxdUxIjTcF73JCfqx0LurAzj+xVDtHAsrhSwCQww4YAB
 NNP13ZwGrav5easTnDb+64jkvTYoQ5S47GpSBGbSl8Baw+L0XQeMEKoyuTIIHMut34cAjsO2k
 0lsVEx2jfUea3+rrygFxnjWw4H2zrMh5WCa1bWf1VHUrt/DaPtefOC9k5DhTwukjh/SYUrJQs
 g5wMDn8L+LsNJ0uFMXk5zn+KwvWXu/Z0zM2CczNFp3uSK/1KBqjDlePBeZc6zCIVc6wF42uHW
 LNiB/w6JJ1ygFgg6dLAeLfBN/PF47F2X2/tnqUnzMowEbZGMirF0jd9xWvOlXqcnp7aOnR6ow
 /pt9C+o7vx3wRSCxfEPeoPx5u0+4SAhZTfmm7IpSBslfP9gc6EW0Zj1+wiG2QZkp6RCcC6N7Z
 Yy29QLqFbGXY60pexoCoL2PNpXLS08ySKSfsuv+mvP9ff6enopnV2LYrsVU3KC4CJDRV+L7fB
 zXcxasm9PYRbGGU5KWe9VqFCuxJhX9XLUrtAr3pPaT+MZg7x7UW4N6sqAm3ppdxH0fi1TJ1on
 TnaARfSLQL52WFl6CXHqgkYO3xDgmil0g80Sw1ciwbh7tpSTxBvg829EQoWpqmIw04TA44Vei
 TRPJ3v3KHCabB+Bp0mpBF8jzXLlFEZfAFjDE7PmDDCtmI9SeJjXFD4Dd6L05uryqUMlhmINVE
 2ba3tAS9MUtuYQneQPKRYV88hk0=
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
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

Fix the elf loader to calculate a valid TASK_UNMAPPED_BASE address for all
32-bit architectures, based on the GUEST_ADDR_MAX constant.

Additionally modify the elf loader to load dynamic pie executables at
around:
~ 0x5500000000  for 64-bit guest binaries on 64-bit host,
- 0x00300000    for 32-bit guest binaries on 64-bit host, and
- 0x00000000    for 32-bit guest binaries on 32-bit host.

With this patch the Thread Sanitizer (TSan) application will work again,
as in commit aab613fb9597 ("linux-user: Update TASK_UNMAPPED_BASE for
aarch64").

Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 linux-user/elfload.c |  6 ++++--
 linux-user/loader.h  | 12 ++++++++++++
 linux-user/mmap.c    | 35 ++++++++++++++++++-----------------
 3 files changed, 34 insertions(+), 19 deletions(-)

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
index 59cbeacf24..d0e4ac4c07 100644
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
+# define TASK_UNMAPPED_BASE_PIE	0x00300000
+# define TASK_UNMAPPED_BASE	(GUEST_ADDR_MAX - 0xd000000 + 1)
+#else /* HOST_LONG_BITS =3D=3D 32 && TARGET_ABI_BITS =3D=3D 32 */
+# define TASK_UNMAPPED_BASE_PIE	0x00000000
+# define TASK_UNMAPPED_BASE	0x40000000
+#endif
+
 /*
  * Read a good amount of data initially, to hopefully get all the
  * program headers loaded.
diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 848d2fd4bb..59d52b93f9 100644
=2D-- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -23,6 +23,7 @@
 #include "user-internals.h"
 #include "user-mmap.h"
 #include "target_mman.h"
+#include "loader.h"

 static pthread_mutex_t mmap_mutex =3D PTHREAD_MUTEX_INITIALIZER;
 static __thread int mmap_lock_count;
@@ -295,23 +296,6 @@ static bool mmap_frag(abi_ulong real_start, abi_ulong=
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
-abi_ulong mmap_next_start =3D TASK_UNMAPPED_BASE;
-
 unsigned long last_brk;

 /*
@@ -344,6 +328,23 @@ abi_ulong mmap_find_vma(abi_ulong start, abi_ulong si=
ze, abi_ulong align)
     abi_ulong addr;
     int wrapped, repeat;

+    static abi_ulong mmap_next_start;
+
+    /* initialize mmap_next_start if necessary */
+    if (!mmap_next_start) {
+        mmap_next_start =3D TASK_UNMAPPED_BASE;
+
+        /* do sanity checks on guest memory layout */
+        if (mmap_next_start >=3D GUEST_ADDR_MAX) {
+            mmap_next_start =3D GUEST_ADDR_MAX - 0x1000000000 + 1;
+        }
+
+        if (TASK_UNMAPPED_BASE_PIE >=3D mmap_next_start) {
+            fprintf(stderr, "Memory too small for PIE executables.\n");
+            exit(EXIT_FAILURE);
+        }
+    }
+
     align =3D MAX(align, qemu_host_page_size);

     /* If 'start' =3D=3D 0, then a default start address is used. */
=2D-
2.41.0


