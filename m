Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6003E7617B3
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 13:53:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOGae-0006wS-Qj; Tue, 25 Jul 2023 07:52:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qOGac-0006w7-Tj
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 07:52:30 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qOGaa-0002MP-7S
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 07:52:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690285941; x=1690890741; i=deller@gmx.de;
 bh=q34b3jO4pz0ToHdtWJOkpF1oDqxSHLwWgPdVBphMzi8=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=enKHRRLLAjSek/rpyb21T9weALihZ5u/3LOfGdZNqq7AKv+tuR3ycKZE5rgD2ZywGlHZiD4
 2QoOiSwooakW/HpizJlg9SJmZavnAdRPnmvt2b8/+Vi37givyl8eQ6MJ5pmVIYyHVmWm/n7ds
 YuHKnX1vEeRXrlQc8YEVSnGaGPnu7lrOaGUPVbkmMd81e8ScD7Vp8vJSaZy6f1GqwXsWOm0Gj
 Ixnw9AgA9YMowCjcBjVrkTLd6UwajkGRcMeO7OHqhQ21T1DmlvkiXNDRwfJnI2T9Fw0RKbLUG
 wKhTGuZuW4Le4GPqrQiDhd5C2S5oUdnsqqpQ9LGppl1OvORqcHzQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.145.136]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MbAgq-1pmjyn2C1g-00bYex; Tue, 25
 Jul 2023 13:52:21 +0200
From: Helge Deller <deller@gmx.de>
To: Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 Andreas Schwab <schwab@suse.de>, Laurent Vivier <laurent@vivier.eu>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Helge Deller <deller@gmx.de>
Subject: [PATCH v3 3/3] linux-user: Load pie executables at upper memory
Date: Tue, 25 Jul 2023 13:52:18 +0200
Message-ID: <20230725115218.52738-4-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725115218.52738-1-deller@gmx.de>
References: <20230725115218.52738-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hyJ06P6rPQLmSYh9PbSMURIh0SjLKBpaCLPvgLy49tZSdfAnloS
 6MrbTgPyYeVaUMQnxg075OH8vympgFnWIx661gQsJMc6KnN3FiXTVwmyJ5uZdAmykgTPH+N
 3EAHy+gdsTjOQQS0XJtZtnRktukc0PsL4vcD9R/HubswQl8fgdUvviOueMZcGSw09SAWCWD
 RqXQfH3SAIpWJlAAqJWZg==
UI-OutboundReport: notjunk:1;M01:P0:dk/s/8KWZtU=;deXzR3Z7nAvr6qY1V6KcCGF0AjD
 tdKPpp4AYkEHSrFyrvXQQqchFKN84m7yDRdd1eHtPwgp10n0xPupxT+Gkyhdy4qIp0b7Q2jLb
 3CTv9QGamM1aUr8D3v7bkYXstpiZE7fpYxHFXU4mXL/j40htr5/w1IVvWc2KsQSrNBYWOTBwv
 3axDUBY+JpXLoO/Urq3xYAozLVJqmNbDfpAD0LsJBtj2l/O4gdD6z6sHxMHtfZUJMFVaX0W47
 iHl88cERU6yZHtdXzSZNFTUsH/zM2HWZgMj30LH8XQYEOX9/piXWsVYs+wb7bEk58Jg8hLtsI
 PVyRdPpI9QJpXTDYdh9wmestb1xcs7Q6xcF5wF3dI0ySQ7j0LdOltqn2jgTuOEdKhcubN/SUC
 wKjXxhqcpr2y3/3ItqbU9CWy5qdfbohYwVQZN5/6UxYDMcqebQdr4E5R4jmgniul97LePQa9L
 4fzC9OwlCuFs+XtJSJJpuDuXS5I5o8eWVSFzkoXpSLDsi637MYkrfPzf8o9gnYCCJGvQRmgZ7
 wdvDwr5aNhqcSEHYAJ6ppIReIqS9n2LdnZfyHYBHIA5jQyC+hldlX/d9JiUwz/16IUiSbZqxC
 EfCE1qtIWXvu/NKSQntIoedBCGDry3tOacsboN1OeVmgYbuuAkxJ5KJh4VW0r7561OnHLTpCb
 RNDH4bZaYVzhXQVE0q4iaY1hgBJHrJxfmfqgszzU/vX8USGKJmOUVlmuQPWRI2ikVFGyLWPeN
 BxQyWLrYy8rvGyXZGUcfBlYMRm7DpmgUHccC2rN/quVGC3K1haI0z6Q/am3AX6jbrJRntceLB
 YSSOU96ysV+y7IAHTiIR1+eReXVcAJSZf+mKQ42BOiy6+tS9pJPyolo2mwUqNFycGG+lQupRn
 gejwBufNR+Dg1dWenB69+rvgViQflPxG9kZuqlal29LJ4QxWGDRPSTn5G3RHA7ykmUju3j1dJ
 z+41ZASYZ9QcT4HdYZl2hZFBeZ4=
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
- 0x40000000    for 32-bit guest binaries on 64-bit host, and
- 0x00000000    for 32-bit guest binaries on 32-bit host.

Reason for this change is to unbreak the Thread Sanitizer (TSan)
application again, as it was done in aab613fb9597 ("linux-user: Update
TASK_UNMAPPED_BASE for aarch64").

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
index 59cbeacf24..3ba41e9a7b 100644
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
+# define TASK_UNMAPPED_BASE_PIE	0x40000000
+# define TASK_UNMAPPED_BASE	0xf0000000
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


