Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E052E76F724
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 03:47:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRjsw-0002h6-2l; Thu, 03 Aug 2023 21:45:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRjsn-0002dG-64
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 21:45:38 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRjsk-0005Bf-FU
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 21:45:36 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-55b0e7efb1cso875202a12.1
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 18:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691113531; x=1691718331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y2R1cWGHzOEOxowvH71/O+CgU7805zY7DZl/vbJ8Gvs=;
 b=m80fb8dLDr1hdEZwEmmPn0fPBLiihleBFqrPr36GSeEC4/7v18DX97Y7XB2gG8HwNm
 XhLFtw+wCntq23OHNUX4jjtHegXj3WXbloht1pjg4LPM77RdJXjIKwoJWG4wPYGhWLx0
 BwuopLLKAq5r3rtbhykR5dTFYnG73Qetw2CPH2d9HseCEsSez4vy3UpV9EKqPL4wCg0y
 JbEX31D5IuJjcy+z0w68zx5tp6OcoOmPzgMvPK8uHj4i2UQX97q62e4HDrSnr3zQQvbE
 k6KLFI+t5j/WIX2EMqU0qiWRNYcPAMOTWpAHl5tHoF0ORN0GAphEYLbqQRhJG8vbDb1K
 tNNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691113531; x=1691718331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y2R1cWGHzOEOxowvH71/O+CgU7805zY7DZl/vbJ8Gvs=;
 b=YUEXTg2mx1XvHsxfjBl2InvjNgPc81eXRKvnX17w6ochaegXsdKzgLOw5DRVRF5hOk
 LQ+mkDL+NsvKh1VCGdfF1LejvzckSeUnPu4JbdTvRijGlBxRlYWl4HLwTEz9WbOCGqvy
 dD3DkZnJqI7kBCrkPtgHiMKFX+cN/1unT1J9XfX04wCQLlbhMDXwzTgrj0D2pAiKjGSJ
 yrylN/GjbibQuDIApmSmO95qBxq7zuDrg2WiyWn1PlgnDwnWnaoI8xxTy2lrQcl8F6r7
 F58iEci1w9BpKR36FFf7sqSpwXglTFWiHCgL0URDny8r2BSLMhEneGE9rZnayphtw4FG
 qj/g==
X-Gm-Message-State: AOJu0Yw3Nwr5vyib5DpQtitVcj9fjvyyC80C2QevmQtiFyxAevaXVnBJ
 IDjnCmNsckABSVWkn19VWbVAU4ethpbBNF331Fg=
X-Google-Smtp-Source: AGHT+IEhudMKWuIYNCwOeaiDSVuEX4u1pr94u1+6F0cTqDQmrBrtTBZBmERIy6r4WAQihlZR4tef7Q==
X-Received: by 2002:a05:6300:8002:b0:13c:3b5e:a12a with SMTP id
 an2-20020a056300800200b0013c3b5ea12amr243297pzc.34.1691113531701; 
 Thu, 03 Aug 2023 18:45:31 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:9d52:4fe8:10ce:5c3])
 by smtp.gmail.com with ESMTPSA id
 c5-20020aa78c05000000b0066f37665a63sm456138pfd.73.2023.08.03.18.45.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Aug 2023 18:45:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: joel@jms.id.au, akihiko.odaki@daynix.com, laurent@vivier.eu, deller@gmx.de
Subject: [PATCH v8 16/17] linux-user: Do not adjust zero_bss for host page size
Date: Thu,  3 Aug 2023 18:45:16 -0700
Message-Id: <20230804014517.6361-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804014517.6361-1-richard.henderson@linaro.org>
References: <20230804014517.6361-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Rely on target_mmap to handle guest vs host page size mismatch.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 54 +++++++++++++++++++-------------------------
 1 file changed, 23 insertions(+), 31 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index e853a4ab33..66ab617bd1 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2212,44 +2212,36 @@ static abi_ulong setup_arg_pages(struct linux_binprm *bprm,
 
 /* Map and zero the bss.  We need to explicitly zero any fractional pages
    after the data section (i.e. bss).  */
-static void zero_bss(abi_ulong elf_bss, abi_ulong last_bss, int prot)
+static void zero_bss(abi_ulong start_bss, abi_ulong end_bss, int prot)
 {
-    uintptr_t host_start, host_map_start, host_end;
+    abi_ulong align_bss;
 
-    last_bss = TARGET_PAGE_ALIGN(last_bss);
+    align_bss = TARGET_PAGE_ALIGN(start_bss);
+    end_bss = TARGET_PAGE_ALIGN(end_bss);
 
-    /* ??? There is confusion between qemu_real_host_page_size and
-       qemu_host_page_size here and elsewhere in target_mmap, which
-       may lead to the end of the data section mapping from the file
-       not being mapped.  At least there was an explicit test and
-       comment for that here, suggesting that "the file size must
-       be known".  The comment probably pre-dates the introduction
-       of the fstat system call in target_mmap which does in fact
-       find out the size.  What isn't clear is if the workaround
-       here is still actually needed.  For now, continue with it,
-       but merge it with the "normal" mmap that would allocate the bss.  */
+    if (start_bss < align_bss) {
+        int flags = page_get_flags(start_bss);
 
-    host_start = (uintptr_t) g2h_untagged(elf_bss);
-    host_end = (uintptr_t) g2h_untagged(last_bss);
-    host_map_start = REAL_HOST_PAGE_ALIGN(host_start);
-
-    if (host_map_start < host_end) {
-        void *p = mmap((void *)host_map_start, host_end - host_map_start,
-                       prot, MAP_FIXED | MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
-        if (p == MAP_FAILED) {
-            perror("cannot mmap brk");
-            exit(-1);
+        if (!(flags & PAGE_VALID)) {
+            /* Map the start of the bss. */
+            align_bss -= TARGET_PAGE_SIZE;
+        } else if (flags & PAGE_WRITE) {
+            /* The page is already mapped writable. */
+            memset(g2h_untagged(start_bss), 0, align_bss - start_bss);
+        } else {
+            /* Read-only zeros? */
+            g_assert_not_reached();
         }
     }
 
-    /* Ensure that the bss page(s) are valid */
-    if ((page_get_flags(last_bss-1) & prot) != prot) {
-        page_set_flags(elf_bss & TARGET_PAGE_MASK, last_bss - 1,
-                       prot | PAGE_VALID);
-    }
-
-    if (host_start < host_map_start) {
-        memset((void *)host_start, 0, host_map_start - host_start);
+    if (align_bss < end_bss) {
+        abi_long err = target_mmap(align_bss, end_bss - align_bss, prot,
+                                   MAP_FIXED | MAP_PRIVATE | MAP_ANONYMOUS,
+                                   -1, 0);
+        if (err == -1) {
+            perror("cannot mmap brk");
+            exit(-1);
+        }
     }
 }
 
-- 
2.34.1


