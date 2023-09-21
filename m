Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF71F7A984D
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 19:39:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjNcd-0002BP-DW; Thu, 21 Sep 2023 13:37:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qjNcb-0002Ab-Uj
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 13:37:49 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qjNcO-0007iM-5G
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 13:37:49 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-32172a50356so1255138f8f.0
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 10:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695317855; x=1695922655; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tpP7WvKkmw1P1SqkcMNN7UBPT2euBBFe5uh9vcxXSwE=;
 b=c1BQo2gYW29AceuPVkr6eld4+Cja0HwMR8XMKithGZp/VjFwpDaNG1TWVfccGIEUCd
 pDe5Rt9zqL6hW74xIBnE0iwrSde7Ob+cwUpooV40zuoBsoBHLBnZajMS15lGO1sd1gCK
 KU0zXWwjxpj07LvizmqOzlVivYIGjNIKOoubU1JaVzcD6egB8XzHzRXpPCc73BOZM4ZJ
 e6RdqQC5ns0GCELud1FQ8Mfag5VDp4AOG5cvkq3BeDHXr6uLoYJDiNSM++2EB6KUQXWT
 +y7pE1jqd2+IBksUiwAdk3/5lJvlPp66ewnNPC1SpFVC1hVXji6bWsNxzeO7uvt+flp7
 yjxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695317855; x=1695922655;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tpP7WvKkmw1P1SqkcMNN7UBPT2euBBFe5uh9vcxXSwE=;
 b=aXkBRDa9SD9H9w9KMq/z43uSCyoUL2KaqN3epMc8zAhrLcO2wPjaQGrcyOoDfZq1kj
 7CwCpovvsLEFZEdT4JqcVwCgpFw8oQ0/4AHnCr8XSde+8bkadqx8pzMc6ExT464K3+uy
 rTTi1PsEKI4KU90tbzNe6X0DmKklRKZf8jPa8KoFRpJQ5+cFkG7BvI3SQcAetYLMtaxR
 57k2Ojdr5uRMCVKZNNzoL6ApeYdMBaULxxO7CbgDlY8MHcqyP/FVZR+3Qszf+zczUENu
 LcElyo8vwgBOSdmcREbNFdEorSDYPwogl+zwkyIiCI/8Dh/cBwwle4GPpmVC8EsxAWF1
 fGWg==
X-Gm-Message-State: AOJu0YwHVh0CllltO+4lsZBFnPVmniQifM7Lvs5KbNZRviiMiCEkB5cb
 R2qnCfeKk9BsKpiZxsiFlaYKTmcHDYYR1UyNmcw=
X-Google-Smtp-Source: AGHT+IH7r4ugyOxzVjNWfgYNl6YlesOHsq999nDG4SUbzTexgs0pDk0yeWUToTZIhsKArMqCqhPMKw==
X-Received: by 2002:a5d:6346:0:b0:31f:e5cf:6724 with SMTP id
 b6-20020a5d6346000000b0031fe5cf6724mr6508426wrw.46.1695317854816; 
 Thu, 21 Sep 2023 10:37:34 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 m14-20020a7bce0e000000b003feff926fc5sm2464122wmc.17.2023.09.21.10.37.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Sep 2023 10:37:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/30] elf2dmp: introduce physical block alignment
Date: Thu, 21 Sep 2023 18:37:17 +0100
Message-Id: <20230921173720.3250581-28-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921173720.3250581-1-peter.maydell@linaro.org>
References: <20230921173720.3250581-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

Physical memory ranges may not be aligned to page size in QEMU ELF, but
DMP can only contain page-aligned runs. So, align them.

Signed-off-by: Viktor Prutyanov <viktor@daynix.com>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-id: 20230915170153.10959-3-viktor@daynix.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 contrib/elf2dmp/addrspace.h |  1 +
 contrib/elf2dmp/addrspace.c | 31 +++++++++++++++++++++++++++++--
 contrib/elf2dmp/main.c      |  5 +++--
 3 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/contrib/elf2dmp/addrspace.h b/contrib/elf2dmp/addrspace.h
index 00b44c12180..039c70c5b07 100644
--- a/contrib/elf2dmp/addrspace.h
+++ b/contrib/elf2dmp/addrspace.h
@@ -12,6 +12,7 @@
 
 #define ELF2DMP_PAGE_BITS 12
 #define ELF2DMP_PAGE_SIZE (1ULL << ELF2DMP_PAGE_BITS)
+#define ELF2DMP_PAGE_MASK (ELF2DMP_PAGE_SIZE - 1)
 #define ELF2DMP_PFN_MASK (~(ELF2DMP_PAGE_SIZE - 1))
 
 #define INVALID_PA  UINT64_MAX
diff --git a/contrib/elf2dmp/addrspace.c b/contrib/elf2dmp/addrspace.c
index 0b04cba00e5..64b5d680adc 100644
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
 
diff --git a/contrib/elf2dmp/main.c b/contrib/elf2dmp/main.c
index bb6744c0cd6..b7e39301641 100644
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
2.34.1


