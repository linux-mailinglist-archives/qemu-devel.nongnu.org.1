Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C11D7CFB50
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:38:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtTCp-0003g2-L0; Thu, 19 Oct 2023 09:36:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qtTBw-0001zQ-9V
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:36:02 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qtTBr-0001FG-C1
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:35:59 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-32ddfb38c02so244047f8f.3
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 06:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697722550; x=1698327350; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DCEBJydvw/gsEIeAPEKmaoZZ5w+fj2mZw0RxfZs5m5s=;
 b=vnvB20EIc7tXACRVRQyE26v4LieyahC/l5ZvIlmcCES2Ig1wKXs5RT/9fl2jXnx8ld
 kJHjho77NZEPe7ftw9WU94e84ILQEVtwWLHOksePBwfgf8b5z7kp26/7VlPRpSn3TvGf
 2TdwmjlKKYVyfMww0Xj5QFyh7tlD8opQcBP+IS9IXx+2KwUT+G1AB+wKrXyVt1GE3k4O
 J8MAU+fRu6gxr2FRfWFhvYbAyjApM0ErAaAoRz1YLDrzsZUj4HDglVtUkB1yjYPzUbcu
 WHavIvoQkwP22ZbzXep5+UqHyx57f83JqzAboGyELCZLYcwJJyRZcpnw3AKpdLSdl2lH
 OsfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697722550; x=1698327350;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DCEBJydvw/gsEIeAPEKmaoZZ5w+fj2mZw0RxfZs5m5s=;
 b=GQ4kkJ4YMvJgNasfs4e30CP8Ic7o9mEBFXIKAPnpeuqE7VAeX1g6wobv1dO7O7h+yr
 emgyPXfgBKPPGAupqfyW/jlmJiBBC9fXt3CvhwwP5DT842mZCZnaDL9wpElDarpy1TNF
 pX/GWRRSMPEuE87TguZMy1b7NhPbw8pTlZ7K/405+GK2+deEF0wekUA/oTa9Ec2qlY/r
 edplJl0rnoBkZTLHdZxsm8ygkTqgLl6xxwUkzM5e++bmvHCkH5IigklYscyTpLbsubRs
 Q2MMw+hxgOYDLYyTw0pwoQtHIENLJNnTE3f5GGxjfWfIlBi97Vt/ep47ucac1tmY8LJX
 X3uA==
X-Gm-Message-State: AOJu0YzCEbYqZ3ZTsPwxpvcJiA3Sy8Hf+KRTEYoreaAce806Vlr0j9JU
 aQby0z9K93bbcuvmYEdbqp/8jekz3v7bomNC+Ts=
X-Google-Smtp-Source: AGHT+IEq0/Kd87UmRG7okGKg36g3dDacarUUkSMuvCPbBaptOa+Wne0RDQLZg+XD93WXVk7o8mtg6g==
X-Received: by 2002:a5d:4b48:0:b0:314:1313:c3d6 with SMTP id
 w8-20020a5d4b48000000b003141313c3d6mr1457635wrs.33.1697722550271; 
 Thu, 19 Oct 2023 06:35:50 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 d28-20020adf9b9c000000b0031f3ad17b2csm4512690wrc.52.2023.10.19.06.35.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 06:35:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/24] contrib/elf2dmp: Use g_malloc(), g_new() and g_free()
Date: Thu, 19 Oct 2023 14:35:37 +0100
Message-Id: <20231019133537.2114929-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019133537.2114929-1-peter.maydell@linaro.org>
References: <20231019133537.2114929-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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

From: Suraj Shirvankar <surajshirvankar@gmail.com>

QEMU coding style uses the glib memory allocation APIs, not
the raw libc malloc/free. Switch the allocation and free
calls in elf2dmp to use these functions (dropping the now-unneeded
checks for failure).

Signed-off-by: Suraj Shirvankar <surajshirvankar@gmail.com>
Message-id: 169753938460.23804.11418813007617535750-1@git.sr.ht
[PMM: also remove NULL checks from g_malloc() calls;
 beef up commit message]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 contrib/elf2dmp/addrspace.c |  7 ++-----
 contrib/elf2dmp/main.c      |  9 +++------
 contrib/elf2dmp/pdb.c       | 19 ++++++++-----------
 contrib/elf2dmp/qemu_elf.c  |  7 ++-----
 4 files changed, 15 insertions(+), 27 deletions(-)

diff --git a/contrib/elf2dmp/addrspace.c b/contrib/elf2dmp/addrspace.c
index 64b5d680adc..6f608a517b1 100644
--- a/contrib/elf2dmp/addrspace.c
+++ b/contrib/elf2dmp/addrspace.c
@@ -72,10 +72,7 @@ int pa_space_create(struct pa_space *ps, QEMU_Elf *qemu_elf)
         }
     }
 
-    ps->block = malloc(sizeof(*ps->block) * ps->block_nr);
-    if (!ps->block) {
-        return 1;
-    }
+    ps->block = g_new(struct pa_block, ps->block_nr);
 
     for (i = 0; i < phdr_nr; i++) {
         if (phdr[i].p_type == PT_LOAD) {
@@ -97,7 +94,7 @@ int pa_space_create(struct pa_space *ps, QEMU_Elf *qemu_elf)
 void pa_space_destroy(struct pa_space *ps)
 {
     ps->block_nr = 0;
-    free(ps->block);
+    g_free(ps->block);
 }
 
 void va_space_set_dtb(struct va_space *vs, uint64_t dtb)
diff --git a/contrib/elf2dmp/main.c b/contrib/elf2dmp/main.c
index 6de5c9808ef..cbc38a7c103 100644
--- a/contrib/elf2dmp/main.c
+++ b/contrib/elf2dmp/main.c
@@ -120,14 +120,11 @@ static KDDEBUGGER_DATA64 *get_kdbg(uint64_t KernBase, struct pdb_reader *pdb,
         }
     }
 
-    kdbg = malloc(kdbg_hdr.Size);
-    if (!kdbg) {
-        return NULL;
-    }
+    kdbg = g_malloc(kdbg_hdr.Size);
 
     if (va_space_rw(vs, KdDebuggerDataBlock, kdbg, kdbg_hdr.Size, 0)) {
         eprintf("Failed to extract entire KDBG\n");
-        free(kdbg);
+        g_free(kdbg);
         return NULL;
     }
 
@@ -643,7 +640,7 @@ int main(int argc, char *argv[])
     }
 
 out_kdbg:
-    free(kdbg);
+    g_free(kdbg);
 out_pdb:
     pdb_exit(&pdb);
 out_pdb_file:
diff --git a/contrib/elf2dmp/pdb.c b/contrib/elf2dmp/pdb.c
index 8e3c18c82f7..40991f5f4c3 100644
--- a/contrib/elf2dmp/pdb.c
+++ b/contrib/elf2dmp/pdb.c
@@ -94,18 +94,18 @@ uint64_t pdb_resolve(uint64_t img_base, struct pdb_reader *r, const char *name)
 
 static void pdb_reader_ds_exit(struct pdb_reader *r)
 {
-    free(r->ds.toc);
+    g_free(r->ds.toc);
 }
 
 static void pdb_exit_symbols(struct pdb_reader *r)
 {
-    free(r->modimage);
-    free(r->symbols);
+    g_free(r->modimage);
+    g_free(r->symbols);
 }
 
 static void pdb_exit_segments(struct pdb_reader *r)
 {
-    free(r->segs);
+    g_free(r->segs);
 }
 
 static void *pdb_ds_read(const PDB_DS_HEADER *header,
@@ -120,10 +120,7 @@ static void *pdb_ds_read(const PDB_DS_HEADER *header,
 
     nBlocks = (size + header->block_size - 1) / header->block_size;
 
-    buffer = malloc(nBlocks * header->block_size);
-    if (!buffer) {
-        return NULL;
-    }
+    buffer = g_malloc(nBlocks * header->block_size);
 
     for (i = 0; i < nBlocks; i++) {
         memcpy(buffer + i * header->block_size, (const char *)header +
@@ -206,7 +203,7 @@ static int pdb_init_symbols(struct pdb_reader *r)
     return 0;
 
 out_symbols:
-    free(symbols);
+    g_free(symbols);
 
     return err;
 }
@@ -263,7 +260,7 @@ static int pdb_reader_init(struct pdb_reader *r, void *data)
 out_sym:
     pdb_exit_symbols(r);
 out_root:
-    free(r->ds.root);
+    g_free(r->ds.root);
 out_ds:
     pdb_reader_ds_exit(r);
 
@@ -274,7 +271,7 @@ static void pdb_reader_exit(struct pdb_reader *r)
 {
     pdb_exit_segments(r);
     pdb_exit_symbols(r);
-    free(r->ds.root);
+    g_free(r->ds.root);
     pdb_reader_ds_exit(r);
 }
 
diff --git a/contrib/elf2dmp/qemu_elf.c b/contrib/elf2dmp/qemu_elf.c
index de6ad744c6d..055e6f8792e 100644
--- a/contrib/elf2dmp/qemu_elf.c
+++ b/contrib/elf2dmp/qemu_elf.c
@@ -94,10 +94,7 @@ static int init_states(QEMU_Elf *qe)
 
     printf("%zu CPU states has been found\n", cpu_nr);
 
-    qe->state = malloc(sizeof(*qe->state) * cpu_nr);
-    if (!qe->state) {
-        return 1;
-    }
+    qe->state = g_new(QEMUCPUState*, cpu_nr);
 
     cpu_nr = 0;
 
@@ -115,7 +112,7 @@ static int init_states(QEMU_Elf *qe)
 
 static void exit_states(QEMU_Elf *qe)
 {
-    free(qe->state);
+    g_free(qe->state);
 }
 
 static bool check_ehdr(QEMU_Elf *qe)
-- 
2.34.1


