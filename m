Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5084676C0E0
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 01:29:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQymU-0001KC-UZ; Tue, 01 Aug 2023 19:27:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qQymT-0001Jl-Jx
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 19:27:57 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qQymP-000789-Hk
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 19:27:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690932468; x=1691537268; i=deller@gmx.de;
 bh=1NFU1YviBFmyuIZFHJbwVvbCDXdoRmikoWBij4USGWU=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=j5UauReCePrF8CNZOgGaTc20I5qvp0stItKyuu5q3fzNBRzplgXrBHvq3YY3J8Ex/07kAkB
 G2GT9ifd/V0ZZcqLXrH7MtAr1yblEFzipB/Mjapr0qslauKo0rkATqcjtuTQNnzo2EGBssOvu
 41vqzGki/eYOS3s+X2kz8YBwfy3QfY7N7KcCIwZ/oQbA+KyB4sJjqNS8e0yBggL5E+19xPF+L
 +46ETnoOx5m3ZP8PIaLV2Wh5IMqqB3rg7Y6t0fEGBV8IiVzIhLhYqx2sJLMdCKPYM4BR66b59
 oYyRJDGcnI0fifcJocvUv2GvkhZagH582Oi2UNY2O54C1HT39GYw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.150.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MlNp7-1pz6jp3IIX-00lnaJ; Wed, 02
 Aug 2023 01:27:48 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Joel Stanley <joel@jms.id.au>, Akihiko Odaki <akihiko.odaki@daynix.com>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH v6 8/8] linux-user: Load pie executables at upper memory
Date: Wed,  2 Aug 2023 01:27:45 +0200
Message-ID: <20230801232745.4125-9-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801232745.4125-1-deller@gmx.de>
References: <20230801232745.4125-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oEQ5BeGs/zGeiLDZaQX8yqdaTWWxFnfr0OOnvq7UesuMOR4zFRG
 z7oIHmEImpS4XbJsknsP6i7If35YaqG/wOcUFfd6hmFNp6JSx1pIsPuXtMgMJfrvB5ClByi
 QgPgsAnJwpro6tVQlA9vw2u3N+dX3oq7RuX0dbvd6VcCatXGRlkCljPGTRV6fyLPf1QlDz5
 nF/zI0mHVyC81e0qNDuVQ==
UI-OutboundReport: notjunk:1;M01:P0:7lqx3j3ha7Y=;ckoRRyF7pI3lCAqntnczbHSBAFf
 kuOlInHr8aHWWo2Qu6XCJkgDTGJBUXNbm4jt8omLyY6vTJKZOEF8BCyJVRYp7/KFGclX+tvnU
 rYqvSKYbJBYwSP6G7gJ0K5ToYBIT2qg7MUltRvQGJFWSC+bhXdN98YsdfDhU+nhodgXvPXcC7
 uwDywuKMr4svMO/TTmaUwZp6uB0/aC5wmk8PExKb1GiHTk1I2U/zkK0qsmOd9gQhOe5yM7xZT
 dS1F0SX/lxq3dimeFJ9COw0aJNMty+hIuOdFw5jpKmjkuvcQdW6QUgrLtqpyd8K5k9bryxiqV
 0wNStTZPFFY8AUUbc8rGmvdTqiKe82eM3ckcyxHP4cNfXxJQklhZ9FosobtfOloGQXgaUys/K
 p3ce4wQHv34qUg78eTfcZ5/Knnz8zCoOGsYeRlygclU0Rs8gm1IBPf/x8f8FB3ryNbPgGzct9
 d3GJVqldyLfD4lZPKa2yX+iUCItLHoXkgOeDH2i4NStn2krAL0QAIr0/dBrTMUjRSJbbLNOkh
 zH3Zk4V0G2NkiWzdYfK7VYap+LeVbfasSZjX0C+ABwX19sL4kYn5OCHDSgK8p61cFICl9xyb+
 Iilth4BiwxLyNxb9lmzaEyJzXDYPmYsPvV7EMeuaGGxO17cQUh3CxojlnAO2ErPFiAPaXjN4t
 RHWqTHaF2/DJ3sydfOr8j+Phyx1a1QpjxWJyu9nJ0QIAcpvbyPYdfBWhtPaJKJPTolH1Amvsl
 +6ijIaoQ3xHAQ/XbO15mJ/b0DHOXU+7Ls2uKSY9sXmNxgWrtU1DqSE99rQb8TWAVgJsuvb3+p
 Op+87husWM0Rqc9HnIR4mpITJDw5xXoW2r67GtJDymRXkuOfqdwlasbea1qTJrGUlZ3awUGZC
 5dj+kHIlJXdJo7yYQGG4IHEeQrrOKknDqBQLZHpX+peTX2wMPGm26yzOpLNbbxiUstTweGMF/
 9jf3cnoYvkAEqMP7sCLkiq/A17g=
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
index 59cbeacf24..3bbfc108eb 100644
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
+# define TASK_UNMAPPED_BASE	(GUEST_ADDR_MAX - 0x20000000 + 1)
+#else /* HOST_LONG_BITS =3D=3D 32 && TARGET_ABI_BITS =3D=3D 32 */
+# define TASK_UNMAPPED_BASE_PIE	0x00000000
+# define TASK_UNMAPPED_BASE	0x40000000
+#endif
+
 /*
  * Read a good amount of data initially, to hopefully get all the
  * program headers loaded.
diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index c624feead0..3441198e21 100644
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


