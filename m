Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4E2799A71
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 20:47:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qf2yA-00022Y-1L; Sat, 09 Sep 2023 14:46:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qf2y8-00022O-Px
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 14:46:08 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qf2y2-0002xO-QE
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 14:46:08 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-68fb7fb537dso55904b3a.2
 for <qemu-devel@nongnu.org>; Sat, 09 Sep 2023 11:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694285161; x=1694889961; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tBXZgZ1YDZu8m+OxXcx4KGg4Z0Uw5UN+dX1vhmo3Wtg=;
 b=YUUVAFIO3CoYaCuXWo3CIlZY22+UU++f7U9Os1WC62dh92CxRwI+2Nvc59lebyj62X
 udPG7BAoQlU/iaQ/d3f+4iGiV/WCITB52T1FUlJh9vgvkfq2hanxxRRiEnYixTaUMWgO
 TZNTNIR0qdytGzaj2n7XzsI69MVPOGJXd0WtQ0SCZXbYyejwyx5o/VqB7LtHjpcW5lek
 MT7bAdJ4CwthsKanYYAoCcdhO6b6S+EzNrCWVB0G+weI930AYls8dDdQnf2s0mtPUfaB
 gQxcsIbAL+5BF+8z35n2O86sAjZiYrfiBEbZ4PmWuTmaA+DqBUoI04ONOZEQcZghaREn
 98Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694285161; x=1694889961;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tBXZgZ1YDZu8m+OxXcx4KGg4Z0Uw5UN+dX1vhmo3Wtg=;
 b=FjUbzdd/6yvgRI6yLejm54jcEXfOmsm3oiOUqDjn+ELR5VnEz5Xt1rwF+qLiK8zXBf
 qMJEFuXy18CEpfcy+A2j/urMUTcJtKZVTRA2yYl2PQxfnwKdG9IsYT56OlK85wgP6taZ
 v2Zsj0ig27Bzaw6P/voQmKAOjDzHKNc250BXGKYVRsuT+bCEtOIxhNgwj9PeQolt+eeK
 /LDz0Ldl2ljCqXF1AH1HXYkbj50xx7nRbd/DYEVgTQV0S2FJPFEUR0zTzHH8ArOqE31Q
 oBgUzL8kuOShRBiEEK3ZOR7v9+1UdYlHVCBAPEaQAQnnwAdNjwpfXPdoR5hFyiMyFGlQ
 C2hg==
X-Gm-Message-State: AOJu0YzfHBOw/9K9B5OMfnQcb25pwRjelh1k0lef3Eq6PDhnA0X1CmUv
 +Qxkb1gFl/wOHHSTZbbQtnZf9cwnMA888sxslWE=
X-Google-Smtp-Source: AGHT+IGlJZS0hQph6gQ85duuBTLICQmVxs2iFOLzfhkql19t3NKg3RtD3/hG4Ml00bs1OjKBzU5UFw==
X-Received: by 2002:a05:6a20:324a:b0:133:b3a9:90d with SMTP id
 hm10-20020a056a20324a00b00133b3a9090dmr5072240pzc.36.1694285160985; 
 Sat, 09 Sep 2023 11:46:00 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 z12-20020a170902ee0c00b001bbaf09ce15sm3550855plb.152.2023.09.09.11.45.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Sep 2023 11:46:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com,
	philmd@linaro.org,
	qemu-stable@nongnu.org
Subject: [PATCH v2] linux-user: Fixes for zero_bss
Date: Sat,  9 Sep 2023 11:45:59 -0700
Message-Id: <20230909184559.36504-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The previous change, 2d385be6152, assumed !PAGE_VALID meant that
the page would be unmapped by the elf image.  However, since we
reserved the entire image space via mmap, PAGE_VALID will always
be set.  Instead, assume PROT_NONE for the same condition.

Furthermore, assume bss is only ever present for writable segments,
and that there is no page overlap between PT_LOAD segments.
Instead of an assert, return false to indicate failure.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1854
Fixes: 2d385be6152 ("linux-user: Do not adjust zero_bss for host page size")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Pass errp to zero_bss, so we can give a reasonable error message.
---
 linux-user/elfload.c | 53 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 40 insertions(+), 13 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index a5b28fa3e7..5271b749b0 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2304,31 +2304,58 @@ static abi_ulong setup_arg_pages(struct linux_binprm *bprm,
  * Map and zero the bss.  We need to explicitly zero any fractional pages
  * after the data section (i.e. bss).  Return false on mapping failure.
  */
-static bool zero_bss(abi_ulong start_bss, abi_ulong end_bss, int prot)
+static bool zero_bss(abi_ulong start_bss, abi_ulong end_bss,
+                     int prot, Error **errp)
 {
     abi_ulong align_bss;
 
+    /* We only expect writable bss; the code segment shouldn't need this. */
+    if (!(prot & PROT_WRITE)) {
+        error_setg(errp, "PT_LOAD with non-writable bss");
+        return false;
+    }
+
     align_bss = TARGET_PAGE_ALIGN(start_bss);
     end_bss = TARGET_PAGE_ALIGN(end_bss);
 
     if (start_bss < align_bss) {
         int flags = page_get_flags(start_bss);
 
-        if (!(flags & PAGE_VALID)) {
-            /* Map the start of the bss. */
+        if (!(flags & PAGE_BITS)) {
+            /*
+             * The whole address space of the executable was reserved
+             * at the start, therefore all pages will be VALID.
+             * But assuming there are no PROT_NONE PT_LOAD segments,
+             * a PROT_NONE page means no data all bss, and we can
+             * simply extend the new anon mapping back to the start
+             * of the page of bss.
+             */
             align_bss -= TARGET_PAGE_SIZE;
-        } else if (flags & PAGE_WRITE) {
-            /* The page is already mapped writable. */
-            memset(g2h_untagged(start_bss), 0, align_bss - start_bss);
         } else {
-            /* Read-only zeros? */
-            g_assert_not_reached();
+            /*
+             * The start of the bss shares a page with something.
+             * The only thing that we expect is the data section,
+             * which would already be marked writable.
+             * Overlapping the RX code segment seems malformed.
+             */
+            if (!(flags & PAGE_WRITE)) {
+                error_setg(errp, "PT_LOAD with bss overlapping "
+                           "non-writable page");
+                return false;
+            }
+
+            /* The page is already mapped and writable. */
+            memset(g2h_untagged(start_bss), 0, align_bss - start_bss);
         }
     }
 
-    return align_bss >= end_bss ||
-           target_mmap(align_bss, end_bss - align_bss, prot,
-                       MAP_FIXED | MAP_PRIVATE | MAP_ANON, -1, 0) != -1;
+    if (align_bss < end_bss &&
+        target_mmap(align_bss, end_bss - align_bss, prot,
+                    MAP_FIXED | MAP_PRIVATE | MAP_ANON, -1, 0) == -1) {
+        error_setg_errno(errp, errno, "Error mapping bss");
+        return false;
+    }
+    return true;
 }
 
 #if defined(TARGET_ARM)
@@ -3352,8 +3379,8 @@ static void load_elf_image(const char *image_name, int image_fd,
 
             /* If the load segment requests extra zeros (e.g. bss), map it. */
             if (vaddr_ef < vaddr_em &&
-                !zero_bss(vaddr_ef, vaddr_em, elf_prot)) {
-                goto exit_mmap;
+                !zero_bss(vaddr_ef, vaddr_em, elf_prot, &err)) {
+                goto exit_errmsg;
             }
 
             /* Find the full program boundaries.  */
-- 
2.34.1


