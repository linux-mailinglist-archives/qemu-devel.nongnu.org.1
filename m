Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1515E79F532
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 00:48:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgYdh-0007B5-EO; Wed, 13 Sep 2023 18:47:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <viktor@daynix.com>) id 1qgYdd-00079j-LL
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 18:47:13 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <viktor@daynix.com>) id 1qgYdb-0007le-JZ
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 18:47:13 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-501bd7711e8so491941e87.1
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 15:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1694645229; x=1695250029;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sRDq0Frl7ofiI6ZyF6ZdAHnr6ekU2KaX/hYSpVHMAzM=;
 b=CYpoCttaSyqfiaPunfJ8Vb6IHO4BX9tQidsFdsMwLyAXGR3NKf0NRpBPS9xkJ1FTMO
 /Zq+eBnhiXqCQfyk78WiqLTECQCU5K4n2R+JdkUNlf2FbnUXz9u3PzqG2tlZ5MH0DULV
 41mmdA8iivGHmrc6nmyL54HvzRDEFQlBN594tXq1lqH0Oys4kw6upC/GtMp+DRsnvCQc
 ziQp1/DOUw3D63/fo9584KPNWNBkOlr8AOGQutwmVqLQe9uWz32U43PbZv9/cWuPWUSc
 4loGxrQkI7LiuT+jyaTZqhKrywXrQUJbZywlsdVw46kgvrTkVrRlcl0RcmJcgjtJuvxg
 CXNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694645229; x=1695250029;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sRDq0Frl7ofiI6ZyF6ZdAHnr6ekU2KaX/hYSpVHMAzM=;
 b=NdtVJrO0cFMB4KExjRzRNoXFQ4k5H99B+eve0sWvz5PFdLX6bzFAJ7yNQilsSCWj9J
 z4wqyrpmhhtliojRMEvq6IuYp+tkOr0U3nyDLJKvAw+xReP2JBmRNGtYXutOPBlebVs3
 vRgklBY0h0IX41+i3CGHsDCxgkqqP6OQftMZsvGzvcU3ifk1XpC2JUiGv3Pam9jbbV9O
 9WXhq5udu7NUkRnC/dUBYIK9jD5JvEQ/wVoiN6LzqrGiPLvZ9oVZZB1g/PSzVsigQnmM
 u/z4DG4cJoD6OYCzb7zB7vvqqKD0yCD13JvjCIo17Q6+gZ+bSvgnZHwRy9W4HEzyd27G
 inEw==
X-Gm-Message-State: AOJu0Yw29zdmSOI0SBHK5ovnjC7YmSkePwS7sun2BpgMkMGA2h7f0rmO
 cNo3OTTBBMudOit1n8CZHcazig==
X-Google-Smtp-Source: AGHT+IHeGZeu4O4rqmqgDdRwOXV1TSrWDJK165TCXD87XWN++I1t03lerrNVm4DvXdFUt5pdM7IOtA==
X-Received: by 2002:a19:6412:0:b0:4ff:87f6:6ee5 with SMTP id
 y18-20020a196412000000b004ff87f66ee5mr2728194lfb.10.1694645229346; 
 Wed, 13 Sep 2023 15:47:09 -0700 (PDT)
Received: from localhost.localdomain ([109.252.90.8])
 by smtp.gmail.com with ESMTPSA id
 u28-20020a056512041c00b004fdba93b92asm25020lfk.252.2023.09.13.15.47.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Sep 2023 15:47:09 -0700 (PDT)
From: Viktor Prutyanov <viktor@daynix.com>
To: annie.li@oracle.com,
	akihiko.odaki@daynix.com,
	kkostiuk@redhat.com
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, yan@daynix.com,
 viktor@daynix.com, viktor.prutyanov@phystech.edu
Subject: [PATCH 2/5] elf2dmp: introduce physical block alignment
Date: Thu, 14 Sep 2023 01:46:54 +0300
Message-Id: <20230913224657.11606-3-viktor@daynix.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230913224657.11606-1-viktor@daynix.com>
References: <20230913224657.11606-1-viktor@daynix.com>
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

Physical memory ranges may not be aligned to page size in QEMU ELF, but
DMP can only contain page-aligned runs. So, align them.

Signed-off-by: Viktor Prutyanov <viktor@daynix.com>
---
 contrib/elf2dmp/addrspace.c | 31 +++++++++++++++++++++++++++++--
 contrib/elf2dmp/addrspace.h |  1 +
 contrib/elf2dmp/main.c      |  5 +++--
 3 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/contrib/elf2dmp/addrspace.c b/contrib/elf2dmp/addrspace.c
index 0b04cba00e..64b5d680ad 100644
--- a/contrib/elf2dmp/addrspace.c
+++ b/contrib/elf2dmp/addrspace.c
@@ -14,7 +14,7 @@ static struct pa_block *pa_space_find_block(struct pa_space *ps, uint64_t pa)
 
     for (i = 0; i < ps->block_nr; i++) {
         if (ps->block[i].paddr <= pa &&
-                pa <= ps->block[i].paddr + ps->block[i].size) {
+                pa < ps->block[i].paddr + ps->block[i].size) {
             return ps->block + i;
         }
     }
@@ -33,6 +33,30 @@ static uint8_t *pa_space_resolve(struct pa_space *ps, uint64_t pa)
     return block->addr + (pa - block->paddr);
 }
 
+static void pa_block_align(struct pa_block *b)
+{
+    uint64_t low_align = ((b->paddr - 1) | ELF2DMP_PAGE_MASK) + 1 - b->paddr;
+    uint64_t high_align = (b->paddr + b->size) & ELF2DMP_PAGE_MASK;
+
+    if (low_align == 0 && high_align == 0) {
+        return;
+    }
+
+    if (low_align + high_align < b->size) {
+        printf("Block 0x%"PRIx64"+:0x%"PRIx64" will be aligned to "
+                "0x%"PRIx64"+:0x%"PRIx64"\n", b->paddr, b->size,
+                b->paddr + low_align, b->size - low_align - high_align);
+        b->size -= low_align + high_align;
+    } else {
+        printf("Block 0x%"PRIx64"+:0x%"PRIx64" is too small to align\n",
+                b->paddr, b->size);
+        b->size = 0;
+    }
+
+    b->addr += low_align;
+    b->paddr += low_align;
+}
+
 int pa_space_create(struct pa_space *ps, QEMU_Elf *qemu_elf)
 {
     Elf64_Half phdr_nr = elf_getphdrnum(qemu_elf->map);
@@ -60,10 +84,13 @@ int pa_space_create(struct pa_space *ps, QEMU_Elf *qemu_elf)
                 .paddr = phdr[i].p_paddr,
                 .size = phdr[i].p_filesz,
             };
-            block_i++;
+            pa_block_align(&ps->block[block_i]);
+            block_i = ps->block[block_i].size ? (block_i + 1) : block_i;
         }
     }
 
+    ps->block_nr = block_i;
+
     return 0;
 }
 
diff --git a/contrib/elf2dmp/addrspace.h b/contrib/elf2dmp/addrspace.h
index 00b44c1218..039c70c5b0 100644
--- a/contrib/elf2dmp/addrspace.h
+++ b/contrib/elf2dmp/addrspace.h
@@ -12,6 +12,7 @@
 
 #define ELF2DMP_PAGE_BITS 12
 #define ELF2DMP_PAGE_SIZE (1ULL << ELF2DMP_PAGE_BITS)
+#define ELF2DMP_PAGE_MASK (ELF2DMP_PAGE_SIZE - 1)
 #define ELF2DMP_PFN_MASK (~(ELF2DMP_PAGE_SIZE - 1))
 
 #define INVALID_PA  UINT64_MAX
diff --git a/contrib/elf2dmp/main.c b/contrib/elf2dmp/main.c
index bb6744c0cd..b7e3930164 100644
--- a/contrib/elf2dmp/main.c
+++ b/contrib/elf2dmp/main.c
@@ -400,9 +400,10 @@ static int write_dump(struct pa_space *ps,
     for (i = 0; i < ps->block_nr; i++) {
         struct pa_block *b = &ps->block[i];
 
-        printf("Writing block #%zu/%zu to file...\n", i, ps->block_nr);
+        printf("Writing block #%zu/%zu of %"PRIu64" bytes to file...\n", i,
+                ps->block_nr, b->size);
         if (fwrite(b->addr, b->size, 1, dmp_file) != 1) {
-            eprintf("Failed to write dump header\n");
+            eprintf("Failed to write block\n");
             fclose(dmp_file);
             return 1;
         }
-- 
2.21.0


