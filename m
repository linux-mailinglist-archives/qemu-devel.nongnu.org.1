Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D209872EB1
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Mar 2024 07:14:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhkXD-0006aC-2l; Wed, 06 Mar 2024 01:13:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rhkWe-0005Qu-2B
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 01:13:15 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rhkWc-0006KE-8j
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 01:13:11 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1dcad814986so4887705ad.0
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 22:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709705589; x=1710310389;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CotLFv3JVXm6i3Wu/BAcc+rvRVqdPlzG06TuPB40/EU=;
 b=HlvHwOPy4H8SXmMpIy16jUcuQnJlKYcu1EJNTLEfJfimzwjnIzz94T6GzCAKo3t6AD
 OM/JPerOUdHeMevRUeA97LblG76hb/BtaAlN1BAa5yd6NoP0Y8xTJD5CJRGu4g6xxWxs
 o564gc6gZ1SJ6sklhCLWLUXpfMtckXB5JT9MX3wc87FRDFNiNo5GtfdL5HgzwCUOfqsp
 4mSmmfGDowOSLcCWruzoKXMS+t4csqjZSGdZ3DcD5SEoteR2Xo9jmQEs1tehK3sTC7wt
 r5WfPQIrDHGu47049WFL055v809KXKKCh//k1GfdIwEfRllLPlZj4uIv4m3la4pqWnob
 LLfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709705589; x=1710310389;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CotLFv3JVXm6i3Wu/BAcc+rvRVqdPlzG06TuPB40/EU=;
 b=watFKbd2UAkzXtJPzxbqyPpWe/5Swt+mQr5Igg5BvlkyRDfGzc074URNKeSH4Lm/Gj
 0gWFvYxQ08EgL4ApjL2ArZmgWUJmyFlkVmmVsX5z7xZpuqOmiDYJA1HfrGu5lplS3V0z
 ezgfaS7TSZ+F9bClMzl45vVs0VAvt9H5t8Pz6mRkyfM6xCL4b/r6Y0zafJJPXg/tXjCn
 YAnUcUxjMmrwDeMx+DQprZa6RqUGqHXj057PlaaKkRYlKk6OXSAEjtejOafsNOdsxfTj
 JIUHAJeb3rFKwrQJZRW2fk67HUunwvYtkMtJbav9n/uuqhI14cNwRIGhJvNlSBUF40gR
 ek5w==
X-Gm-Message-State: AOJu0Yw8KIveCs7/CDkDeVMWsEgr+IR5H4ln+jEL7BsZpLJSXOcp3Ff+
 LprqTsR/PSpYf0pqBKiyYR9r7bDPBqpE8EHZxOLrfdPLkAeoco7ugh/1AMVP49iqNBwfi77RSMT
 J
X-Google-Smtp-Source: AGHT+IGdXbli+6LKCOWcDCTTDtp4kMd5BqmbVKf/r4Fi5z6jw0U3FU8H/XebNw7PrcQZWHPgltjyng==
X-Received: by 2002:a17:902:6504:b0:1dc:8ba1:edc3 with SMTP id
 b4-20020a170902650400b001dc8ba1edc3mr4158612plk.9.1709705588741; 
 Tue, 05 Mar 2024 22:13:08 -0800 (PST)
Received: from localhost ([157.82.206.27]) by smtp.gmail.com with UTF8SMTPSA id
 li4-20020a170903294400b001d8f82c61cdsm11691289plb.231.2024.03.05.22.13.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Mar 2024 22:13:08 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 06 Mar 2024 15:12:24 +0900
Subject: [PATCH v3 18/19] contrib/elf2dmp: Clamp QEMU note to file size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240306-elf2dmp-v3-18-d74e6c3da49c@daynix.com>
References: <20240306-elf2dmp-v3-0-d74e6c3da49c@daynix.com>
In-Reply-To: <20240306-elf2dmp-v3-0-d74e6c3da49c@daynix.com>
To: Viktor Prutyanov <viktor.prutyanov@phystech.edu>, 
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::62b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This fixes crashes with truncated dumps.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 contrib/elf2dmp/qemu_elf.c | 87 +++++++++++++++++++++++++++++-----------------
 1 file changed, 55 insertions(+), 32 deletions(-)

diff --git a/contrib/elf2dmp/qemu_elf.c b/contrib/elf2dmp/qemu_elf.c
index 7d896cac5b15..8d750adf904a 100644
--- a/contrib/elf2dmp/qemu_elf.c
+++ b/contrib/elf2dmp/qemu_elf.c
@@ -6,6 +6,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/host-utils.h"
 #include "err.h"
 #include "qemu_elf.h"
 
@@ -15,36 +16,11 @@
 #define ROUND_UP(n, d) (((n) + (d) - 1) & -(0 ? (n) : (d)))
 #endif
 
-#ifndef DIV_ROUND_UP
-#define DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
-#endif
-
-#define ELF_NOTE_SIZE(hdr_size, name_size, desc_size)   \
-    ((DIV_ROUND_UP((hdr_size), 4) +                     \
-      DIV_ROUND_UP((name_size), 4) +                    \
-      DIV_ROUND_UP((desc_size), 4)) * 4)
-
 int is_system(QEMUCPUState *s)
 {
     return s->gs.base >> 63;
 }
 
-static char *nhdr_get_name(Elf64_Nhdr *nhdr)
-{
-    return (char *)nhdr + ROUND_UP(sizeof(*nhdr), 4);
-}
-
-static void *nhdr_get_desc(Elf64_Nhdr *nhdr)
-{
-    return nhdr_get_name(nhdr) + ROUND_UP(nhdr->n_namesz, 4);
-}
-
-static Elf64_Nhdr *nhdr_get_next(Elf64_Nhdr *nhdr)
-{
-    return (void *)((uint8_t *)nhdr + ELF_NOTE_SIZE(sizeof(*nhdr),
-                nhdr->n_namesz, nhdr->n_descsz));
-}
-
 Elf64_Phdr *elf64_getphdr(void *map)
 {
     Elf64_Ehdr *ehdr = map;
@@ -60,13 +36,35 @@ Elf64_Half elf_getphdrnum(void *map)
     return ehdr->e_phnum;
 }
 
+static bool advance_note_offset(uint64_t *offsetp, uint64_t size, uint64_t end)
+{
+    uint64_t offset = *offsetp;
+
+    if (uadd64_overflow(offset, size, &offset) || offset > UINT64_MAX - 3) {
+        return false;
+    }
+
+    offset = ROUND_UP(offset, 4);
+
+    if (offset > end) {
+        return false;
+    }
+
+    *offsetp = offset;
+
+    return true;
+}
+
 static bool init_states(QEMU_Elf *qe)
 {
     Elf64_Phdr *phdr = elf64_getphdr(qe->map);
-    Elf64_Nhdr *start = (void *)((uint8_t *)qe->map + phdr[0].p_offset);
-    Elf64_Nhdr *end = (void *)((uint8_t *)start + phdr[0].p_memsz);
     Elf64_Nhdr *nhdr;
     GPtrArray *states;
+    QEMUCPUState *state;
+    uint32_t state_size;
+    uint64_t offset;
+    uint64_t end_offset;
+    char *name;
 
     if (phdr[0].p_type != PT_NOTE) {
         eprintf("Failed to find PT_NOTE\n");
@@ -74,15 +72,40 @@ static bool init_states(QEMU_Elf *qe)
     }
 
     qe->has_kernel_gs_base = 1;
+    offset = phdr[0].p_offset;
     states = g_ptr_array_new();
 
-    for (nhdr = start; nhdr < end; nhdr = nhdr_get_next(nhdr)) {
-        if (!strcmp(nhdr_get_name(nhdr), QEMU_NOTE_NAME)) {
-            QEMUCPUState *state = nhdr_get_desc(nhdr);
+    if (uadd64_overflow(offset, phdr[0].p_memsz, &end_offset) ||
+        end_offset > qe->size) {
+        end_offset = qe->size;
+    }
+
+    while (offset < end_offset) {
+        nhdr = (void *)((uint8_t *)qe->map + offset);
+
+        if (!advance_note_offset(&offset, sizeof(*nhdr), end_offset)) {
+            break;
+        }
+
+        name = (char *)qe->map + offset;
+
+        if (!advance_note_offset(&offset, nhdr->n_namesz, end_offset)) {
+            break;
+        }
+
+        state = (void *)((uint8_t *)qe->map + offset);
+
+        if (!advance_note_offset(&offset, nhdr->n_descsz, end_offset)) {
+            break;
+        }
+
+        if (!strcmp(name, QEMU_NOTE_NAME) &&
+            nhdr->n_descsz >= offsetof(QEMUCPUState, kernel_gs_base)) {
+            state_size = MIN(state->size, nhdr->n_descsz);
 
-            if (state->size < sizeof(*state)) {
+            if (state_size < sizeof(*state)) {
                 eprintf("CPU #%u: QEMU CPU state size %u doesn't match\n",
-                        states->len, state->size);
+                        states->len, state_size);
                 /*
                  * We assume either every QEMU CPU state has KERNEL_GS_BASE or
                  * no one has.

-- 
2.44.0


