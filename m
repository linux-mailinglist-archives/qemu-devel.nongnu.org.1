Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBF879F533
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 00:48:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgYdh-0007B6-Ls; Wed, 13 Sep 2023 18:47:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <viktor@daynix.com>) id 1qgYdf-0007A0-1O
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 18:47:15 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <viktor@daynix.com>) id 1qgYdc-0007nt-Fi
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 18:47:14 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-502e7d66c1eso57156e87.1
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 15:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1694645231; x=1695250031;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yH8HMC5hbSt9eozfwF10NL6pa0YQ8wwIF2lIAW9O7bA=;
 b=eO6tR7h84/bcvSYA18abBDPoc4gee8trU5WBCUhbe+a+VTNyqB3VOeTgDTYk07WF8P
 3emOrXcbaQCrh6/yERJqlbZib49BlVfANCT76zJgWVRFXjWSjg9O4++FF6WdWHamTDDD
 LUYI2bO5yNQS6dOBy1sSylE3qlb0h6jk1bEcCGOwo8DvGV45Qig10fFFY1H2DyMzpng+
 Mz8U0M0LvfeL+OpY6+i5p7sltgcr0VlPq+R5yMA3RcKdVn6olMBV5A8ks4Vkg6B+pJCq
 Ko0qO/2NP9sCG4UX007Itr7+1vE+z3oHE+JHTIbGzNjGfr/6oAmXVMG8Pj+vbqJwC7KB
 TE2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694645231; x=1695250031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yH8HMC5hbSt9eozfwF10NL6pa0YQ8wwIF2lIAW9O7bA=;
 b=WRRFrh5oHNfOp09W5g5i4V+8B/i5LXydTt70Z73vhNCDa6ca2GZgH9sKV9u1N4lcfu
 TyHawu9YVlCIZNvmFBY6J4n6U+ur3rTv/3hf8mSnJ94biPqddOjen9Pgp4fGyY3ZrsUp
 raveRwlIvqV1VnA1TslcmJGvdeYHlY2+Lx/5wys6PrhzMRprxaQpZchdObKTZYsCNcIA
 dK+DCGDrSVUAaYYYdkbHhafIdydwRplRXDPhbHOUUYdTH75Sl3GMLMQUe4gHHXMwByGI
 f1gBbO6f4SUVP8v5oyVoaHVcMZ8t+Pvz+fPTUx/x8UXjS2KrUUSqfkYK6I3CFxFGLegH
 WF7w==
X-Gm-Message-State: AOJu0YyV4yJ01o5BfwyB6BxAUWVo6aAD99YV+ZzDYyd2I763Eq5hLlbu
 cYkf1jEEf9QZwdR2YabdTjOUfw==
X-Google-Smtp-Source: AGHT+IHHm94EggcNepjD2EuTcwonqUw1WpG9K3oK+0iE3emVeIP2aH4LVQCN1Jm+vPDmqrQTiRSYJQ==
X-Received: by 2002:a19:5002:0:b0:500:a008:a4c5 with SMTP id
 e2-20020a195002000000b00500a008a4c5mr2812005lfb.59.1694645230969; 
 Wed, 13 Sep 2023 15:47:10 -0700 (PDT)
Received: from localhost.localdomain ([109.252.90.8])
 by smtp.gmail.com with ESMTPSA id
 u28-20020a056512041c00b004fdba93b92asm25020lfk.252.2023.09.13.15.47.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Sep 2023 15:47:10 -0700 (PDT)
From: Viktor Prutyanov <viktor@daynix.com>
To: annie.li@oracle.com,
	akihiko.odaki@daynix.com,
	kkostiuk@redhat.com
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, yan@daynix.com,
 viktor@daynix.com, viktor.prutyanov@phystech.edu
Subject: [PATCH 4/5] elf2dmp: use Linux mmap with MAP_NORESERVE when possible
Date: Thu, 14 Sep 2023 01:46:56 +0300
Message-Id: <20230913224657.11606-5-viktor@daynix.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230913224657.11606-1-viktor@daynix.com>
References: <20230913224657.11606-1-viktor@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::131;
 envelope-from=viktor@daynix.com; helo=mail-lf1-x131.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Glib's g_mapped_file_new maps file with PROT_READ|PROT_WRITE and
MAP_PRIVATE. This leads to premature physical memory allocation of dump
file size on Linux hosts and may fail. On Linux, mapping the file with
MAP_NORESERVE limits the allocation by available memory.

Signed-off-by: Viktor Prutyanov <viktor@daynix.com>
---
 contrib/elf2dmp/qemu_elf.c | 66 +++++++++++++++++++++++++++++++-------
 contrib/elf2dmp/qemu_elf.h |  4 +++
 2 files changed, 58 insertions(+), 12 deletions(-)

diff --git a/contrib/elf2dmp/qemu_elf.c b/contrib/elf2dmp/qemu_elf.c
index ebda60dcb8..94a8c3ad15 100644
--- a/contrib/elf2dmp/qemu_elf.c
+++ b/contrib/elf2dmp/qemu_elf.c
@@ -165,10 +165,37 @@ static bool check_ehdr(QEMU_Elf *qe)
     return true;
 }
 
-int QEMU_Elf_init(QEMU_Elf *qe, const char *filename)
+static int QEMU_Elf_map(QEMU_Elf *qe, const char *filename)
 {
+#ifdef CONFIG_LINUX
+    struct stat st;
+
+    printf("Using Linux's mmap\n");
+
+    qe->fd = open(filename, O_RDONLY, 0);
+    if (qe->fd == -1) {
+        eprintf("Failed to open ELF dump file \'%s\'\n", filename);
+        return 1;
+    }
+
+    if (fstat(qe->fd, &st)) {
+        eprintf("Failed to get size of ELF dump file\n");
+        close(qe->fd);
+        return 1;
+    }
+    qe->size = st.st_size;
+
+    qe->map = mmap(NULL, qe->size, PROT_READ | PROT_WRITE,
+            MAP_PRIVATE | MAP_NORESERVE, qe->fd, 0);
+    if (qe->map == MAP_FAILED) {
+        eprintf("Failed to map ELF file\n");
+        close(qe->fd);
+        return 1;
+    }
+#else
     GError *gerr = NULL;
-    int err = 0;
+
+    printf("Using GLib's mmap\n");
 
     qe->gmf = g_mapped_file_new(filename, TRUE, &gerr);
     if (gerr) {
@@ -179,29 +206,44 @@ int QEMU_Elf_init(QEMU_Elf *qe, const char *filename)
 
     qe->map = g_mapped_file_get_contents(qe->gmf);
     qe->size = g_mapped_file_get_length(qe->gmf);
+#endif
+
+    return 0;
+}
+
+static void QEMU_Elf_unmap(QEMU_Elf *qe)
+{
+#ifdef CONFIG_LINUX
+    munmap(qe->map, qe->size);
+    close(qe->fd);
+#else
+    g_mapped_file_unref(qe->gmf);
+#endif
+}
+
+int QEMU_Elf_init(QEMU_Elf *qe, const char *filename)
+{
+    if (QEMU_Elf_map(qe, filename)) {
+        return 1;
+    }
 
     if (!check_ehdr(qe)) {
         eprintf("Input file has the wrong format\n");
-        err = 1;
-        goto out_unmap;
+        QEMU_Elf_unmap(qe);
+        return 1;
     }
 
     if (init_states(qe)) {
         eprintf("Failed to extract QEMU CPU states\n");
-        err = 1;
-        goto out_unmap;
+        QEMU_Elf_unmap(qe);
+        return 1;
     }
 
     return 0;
-
-out_unmap:
-    g_mapped_file_unref(qe->gmf);
-
-    return err;
 }
 
 void QEMU_Elf_exit(QEMU_Elf *qe)
 {
     exit_states(qe);
-    g_mapped_file_unref(qe->gmf);
+    QEMU_Elf_unmap(qe);
 }
diff --git a/contrib/elf2dmp/qemu_elf.h b/contrib/elf2dmp/qemu_elf.h
index b2f0d9cbc9..2a71beca8e 100644
--- a/contrib/elf2dmp/qemu_elf.h
+++ b/contrib/elf2dmp/qemu_elf.h
@@ -32,7 +32,11 @@ typedef struct QEMUCPUState {
 int is_system(QEMUCPUState *s);
 
 typedef struct QEMU_Elf {
+#ifdef CONFIG_POSIX
+    int fd;
+#else
     GMappedFile *gmf;
+#endif
     size_t size;
     void *map;
     QEMUCPUState **state;
-- 
2.21.0


