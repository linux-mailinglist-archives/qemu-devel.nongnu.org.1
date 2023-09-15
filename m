Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6687A2428
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 19:03:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhCCt-0003SC-5U; Fri, 15 Sep 2023 13:02:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <viktor@daynix.com>) id 1qhCCp-0003Nf-B5
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 13:02:11 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <viktor@daynix.com>) id 1qhCCn-0000LY-LD
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 13:02:11 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-5007abb15e9so4055959e87.0
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 10:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1694797328; x=1695402128;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZX87+UWr8lrrIsKDRoUiR5UzsqRSt0csBfbQi+d1bi8=;
 b=07b1JL+XD6ma5HT/9tPTuROsdTEGqjc5CGx1dGFzdWWNZPwBdyHsCoTFLy/ftT6pVT
 w7FpdOdbgWDov9drTwS16xoKQ8bYVTyy0D0e/ZGArHyVileOfG0Q0FXmkKJzo+6acRGG
 Pvv9OBTawkBzwQNdxykY9Jraylv9YXnS7pgGdKW0nYBC8VwBC1+OHiPyehDw4mUDWHTk
 VzVdNBTah7EnKU/KGzPNqhrZk7ON5B/6IlN9jai24EjN70KRW42RzuJ9BtnmgiwTn5Bh
 8xZTYR9euul3dvAhKMmqJudVXVc3V6Y+dua8KHWMef4aBSz7BkhnXwedFC/twpTx8Xyh
 uuTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694797328; x=1695402128;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZX87+UWr8lrrIsKDRoUiR5UzsqRSt0csBfbQi+d1bi8=;
 b=dDeTCTczunEr9QKCh7wwNT9j/EQnB5Jp0UG4vR4d/giz+VuOZFx1V/RbVIhic6pIlc
 lOoV1pSj9GnXJIjmwlLVzewVBwcL5OlzLhf4C+CKbTutac/MDosqoSskkYReUgtGhzEg
 K0LOu+QgtiKDXaRJVhmjWOCzyLZrkcYnM34mtot2709w0HMD94VZ24DCoShsQxsIc8fP
 Slkcs7+hwSpueKAUyphgki9OmiWwOP8Z6ZoO5ZcZ5Rta0UEbIotomQzzcsDDJnnt4PNG
 p4E7yYTJjw5Sk3oQjWDgwSTTwA3e1jNEu7rll3VtA4hHa6OLD3ARRw214ijJXAYeVsP3
 kQcw==
X-Gm-Message-State: AOJu0Yx1DI6pL5pz/LXUOI4MdNBYlU7WjchSEMCZ2SYKF/V5tkwATHL+
 PNOIajZqG3QOEdhKuhwanFO+Kg==
X-Google-Smtp-Source: AGHT+IFGetnVODBDR3ayqC8t+QXWUBxmoURbyCJi6/DcpXjJNtGGwbP8IJyqsDRPhYNfS161bL6mZA==
X-Received: by 2002:a05:6512:3b9d:b0:500:807a:f1a4 with SMTP id
 g29-20020a0565123b9d00b00500807af1a4mr2711891lfv.18.1694797327845; 
 Fri, 15 Sep 2023 10:02:07 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-8.nat.spd-mgts.ru.
 [109.252.90.8]) by smtp.gmail.com with ESMTPSA id
 u7-20020a056512040700b005009ab1992esm690431lfk.154.2023.09.15.10.02.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 10:02:07 -0700 (PDT)
From: Viktor Prutyanov <viktor@daynix.com>
To: annie.li@oracle.com,
	akihiko.odaki@daynix.com,
	kkostiuk@redhat.com
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, yan@daynix.com,
 viktor@daynix.com, viktor.prutyanov@phystech.edu
Subject: [PATCH v2 4/5] elf2dmp: use Linux mmap with MAP_NORESERVE when
 possible
Date: Fri, 15 Sep 2023 20:01:52 +0300
Message-Id: <20230915170153.10959-5-viktor@daynix.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230915170153.10959-1-viktor@daynix.com>
References: <20230915170153.10959-1-viktor@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::12b;
 envelope-from=viktor@daynix.com; helo=mail-lf1-x12b.google.com
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
 contrib/elf2dmp/qemu_elf.c | 68 +++++++++++++++++++++++++++++++-------
 contrib/elf2dmp/qemu_elf.h |  2 ++
 2 files changed, 58 insertions(+), 12 deletions(-)

diff --git a/contrib/elf2dmp/qemu_elf.c b/contrib/elf2dmp/qemu_elf.c
index ebda60dcb8..de6ad744c6 100644
--- a/contrib/elf2dmp/qemu_elf.c
+++ b/contrib/elf2dmp/qemu_elf.c
@@ -165,10 +165,40 @@ static bool check_ehdr(QEMU_Elf *qe)
     return true;
 }
 
-int QEMU_Elf_init(QEMU_Elf *qe, const char *filename)
+static int QEMU_Elf_map(QEMU_Elf *qe, const char *filename)
 {
+#ifdef CONFIG_LINUX
+    struct stat st;
+    int fd;
+
+    printf("Using Linux mmap\n");
+
+    fd = open(filename, O_RDONLY, 0);
+    if (fd == -1) {
+        eprintf("Failed to open ELF dump file \'%s\'\n", filename);
+        return 1;
+    }
+
+    if (fstat(fd, &st)) {
+        eprintf("Failed to get size of ELF dump file\n");
+        close(fd);
+        return 1;
+    }
+    qe->size = st.st_size;
+
+    qe->map = mmap(NULL, qe->size, PROT_READ | PROT_WRITE,
+            MAP_PRIVATE | MAP_NORESERVE, fd, 0);
+    if (qe->map == MAP_FAILED) {
+        eprintf("Failed to map ELF file\n");
+        close(fd);
+        return 1;
+    }
+
+    close(fd);
+#else
     GError *gerr = NULL;
-    int err = 0;
+
+    printf("Using GLib mmap\n");
 
     qe->gmf = g_mapped_file_new(filename, TRUE, &gerr);
     if (gerr) {
@@ -179,29 +209,43 @@ int QEMU_Elf_init(QEMU_Elf *qe, const char *filename)
 
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
index b2f0d9cbc9..afa75f10b2 100644
--- a/contrib/elf2dmp/qemu_elf.h
+++ b/contrib/elf2dmp/qemu_elf.h
@@ -32,7 +32,9 @@ typedef struct QEMUCPUState {
 int is_system(QEMUCPUState *s);
 
 typedef struct QEMU_Elf {
+#ifndef CONFIG_LINUX
     GMappedFile *gmf;
+#endif
     size_t size;
     void *map;
     QEMUCPUState **state;
-- 
2.21.0


