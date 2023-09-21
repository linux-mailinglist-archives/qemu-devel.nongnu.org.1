Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 890177A985A
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 19:41:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjNcc-0002At-NH; Thu, 21 Sep 2023 13:37:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qjNcZ-00029H-Vy
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 13:37:48 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qjNcP-0007ie-Au
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 13:37:47 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4053cb57f02so44065e9.1
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 10:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695317855; x=1695922655; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=okurW1rZE+ASazRHBXqN9Qp4RNXWE3FoF9D8aOYfxp8=;
 b=KIfK6ZaK4vvv9jkyufJprjry8lKeuE8V/6xcMxIKwag4zKFl2Ylr+npNF1Je01+egB
 G8VBGV3SHoY1ZsdGt+er5RA/HodDA/wo+5m7caNS+nsQRNb4lTg4JmrVFvJnmCREsqiK
 wq+IzfmatE6RONHylMVg18Nu72m3PIg/Gni32xk4RDuBnkQ/y7wIiKTP2mFTeWNG3f7D
 6GRUmKjz91nuMXadFu6xI1OG7ewBRhievm+mQb4AdFxt/SArkEybzi+LUABO7tofCBVW
 S7+KNfavzPQ7wh3ME855DZ/96EjVVJIxmfQCVt2J4p+33qfPm175LHd83l66HPDKy4HO
 UioA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695317855; x=1695922655;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=okurW1rZE+ASazRHBXqN9Qp4RNXWE3FoF9D8aOYfxp8=;
 b=FoMbSjGdVE6BqjtA0X8nrVV/x2oVcJvkktopnE9YqnlGGEZnSaildfIqx7AP+qcEd1
 tGQb5ZuQLHJu89kNYFMI+j1+BfILRq07+kfCV38ys90IXVbo+BhHmlwUG5O8UYRV+KOl
 ubjq8pHArQG2UjR8JMmxP8iCHE+9VSCEc4h82+CEby017IaGXOgqV6lv4a+XBLOCk/WD
 ZM5FyEPtM7H8SqL3nNwhtJw2DSP1mf320bDY5wEywrUarGM+7m6QYeL8FbM73P8dbZcT
 ZEwVINDkIMgSq11ZRu5wjiYy8Gy76fE1wJ4UCJAT1oWH8fguYConGg7OolbVPayxlInc
 90UQ==
X-Gm-Message-State: AOJu0YwqHg0rl6FqyOzh6Mnd98QIMLknxJhOnQ6voF3dEk7SpemYPbQh
 b7qSclfuRWf+dP1uPOE611FBoBoME+WziU0SqGg=
X-Google-Smtp-Source: AGHT+IEKI7llB3o9ft/iD+y0ASIv4CdIIrJBdNBgkWaAbSC+yiI2nQR/aPj9zVywcUjq92BPGiXWwQ==
X-Received: by 2002:a1c:771a:0:b0:401:bf56:8ba0 with SMTP id
 t26-20020a1c771a000000b00401bf568ba0mr5368012wmi.28.1695317855655; 
 Thu, 21 Sep 2023 10:37:35 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 m14-20020a7bce0e000000b003feff926fc5sm2464122wmc.17.2023.09.21.10.37.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Sep 2023 10:37:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/30] elf2dmp: use Linux mmap with MAP_NORESERVE when possible
Date: Thu, 21 Sep 2023 18:37:19 +0100
Message-Id: <20230921173720.3250581-30-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921173720.3250581-1-peter.maydell@linaro.org>
References: <20230921173720.3250581-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Viktor Prutyanov <viktor@daynix.com>

Glib's g_mapped_file_new maps file with PROT_READ|PROT_WRITE and
MAP_PRIVATE. This leads to premature physical memory allocation of dump
file size on Linux hosts and may fail. On Linux, mapping the file with
MAP_NORESERVE limits the allocation by available memory.

Signed-off-by: Viktor Prutyanov <viktor@daynix.com>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-id: 20230915170153.10959-5-viktor@daynix.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 contrib/elf2dmp/qemu_elf.h |  2 ++
 contrib/elf2dmp/qemu_elf.c | 68 +++++++++++++++++++++++++++++++-------
 2 files changed, 58 insertions(+), 12 deletions(-)

diff --git a/contrib/elf2dmp/qemu_elf.h b/contrib/elf2dmp/qemu_elf.h
index b2f0d9cbc9b..afa75f10b2d 100644
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
diff --git a/contrib/elf2dmp/qemu_elf.c b/contrib/elf2dmp/qemu_elf.c
index ebda60dcb8a..de6ad744c6d 100644
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
-- 
2.34.1


