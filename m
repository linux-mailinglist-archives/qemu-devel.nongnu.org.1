Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A4A7A2DBB
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 05:36:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhM1G-0006Ba-KT; Fri, 15 Sep 2023 23:30:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhM1D-0006Ar-Ob
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 23:30:51 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhM1C-00088b-2G
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 23:30:51 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-68fdcc37827so2793943b3a.0
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 20:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694835048; x=1695439848; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H8VdfeDW6kikdde/NruMPkmBjI2wGO+ImbTcebxuJbg=;
 b=nDJXc1WBt6mXTr3z9L6x7L4JaAMw9Gu1GmAi8QpO8sA6Ee6MDW1Mj7E+WxLGujLqG2
 VN+c6gKq2+Y12oyuOmJGCCIVKhcFaOGnGVMTvNG0USxLdTAukp4PWxvQuq29bHQvYegv
 WWgyv4t+DnEJdlX6uy4vfjxEYB7znr1I6uxTiBPPAFol4H2to0/vandq7CPNuwzJbyy5
 GPcwSOLaY//QMnJ3tWcGMVba3cQGsp16H4yVWe9AcLQumtPH1xC9cmTHuL4AF+zBBb42
 RXITztNkVCQUghspixgz3kVyl1Shu2oq374JUBgjc4f2hiDPK2ggg6rocioShCTj5Qyx
 Ra6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694835048; x=1695439848;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H8VdfeDW6kikdde/NruMPkmBjI2wGO+ImbTcebxuJbg=;
 b=xPabuqLwFC1OTsQkQcVP9KlDjmcoCuyAlz2KOCWqBhD9l/+VAKValLTQPIXN7plFtZ
 wAB4yV54VLsVyx5751OC3yJrytbqwGvRM6Trc5AmZYkDeaUtrF+BY9ENbObXM0hZXNgt
 26PW/ffN3UsX+b5WAnwW/d1F5Eb1xBPCP5l8GeYQNjkV+ooFovIrkg+ncPmvje/sISSl
 tK/G9J6vO0TNRac3hnV/+nAKRGhraI+IXU5ySm/gFP142EtHugo9/J7P8IMyH9mhAS/E
 rTKOOAw2LJ3W/lxJLT1ZacmVXenYsIgAiAFF1wn4NGqIfwAMo0A7OFl58F+O2I3REZcu
 z2uw==
X-Gm-Message-State: AOJu0YzJQsnz45WfnAxZ7hizb47ELzqyXuZ4VD/NARBykTXCa1OMXwbf
 XfMNQd0ZU4xdBWVkNixhdtKEysKCvATX9/rM75E=
X-Google-Smtp-Source: AGHT+IHtwUP4SLHuSlgdbm3Lc8fEXyh1Pt/ag7PO/5ePZgs0GvLGf2XTYtRV1WTrZ0LwLZFJLz4qJA==
X-Received: by 2002:a05:6a20:3955:b0:137:c971:6a0c with SMTP id
 r21-20020a056a20395500b00137c9716a0cmr3605961pzg.31.1694835048684; 
 Fri, 15 Sep 2023 20:30:48 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 j26-20020aa783da000000b00687a4b70d1esm3577320pfn.218.2023.09.15.20.30.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 20:30:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 39/39] tcg: Map code_gen_buffer with PROT_BTI
Date: Fri, 15 Sep 2023 20:30:11 -0700
Message-Id: <20230916033011.479144-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230916033011.479144-1-richard.henderson@linaro.org>
References: <20230916033011.479144-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

For linux aarch64 host supporting BTI, map the buffer
to require BTI instructions at branch landing pads.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/region.c | 41 ++++++++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 11 deletions(-)

diff --git a/tcg/region.c b/tcg/region.c
index 2b28ed3556..a078899096 100644
--- a/tcg/region.c
+++ b/tcg/region.c
@@ -33,8 +33,19 @@
 #include "tcg/tcg.h"
 #include "exec/translation-block.h"
 #include "tcg-internal.h"
+#include "host/cpuinfo.h"
 
 
+/*
+ * Local source-level compatibility with Unix.
+ * Used by tcg_region_init below.
+ */
+#if defined(_WIN32)
+#define PROT_READ   1
+#define PROT_WRITE  2
+#define PROT_EXEC   4
+#endif
+
 struct tcg_region_tree {
     QemuMutex lock;
     QTree *tree;
@@ -83,6 +94,18 @@ bool in_code_gen_buffer(const void *p)
     return (size_t)(p - region.start_aligned) <= region.total_size;
 }
 
+#ifndef CONFIG_TCG_INTERPRETER
+static int host_prot_read_exec(void)
+{
+#if defined(CONFIG_LINUX) && defined(HOST_AARCH64) && defined(PROT_BTI)
+    if (cpuinfo & CPUINFO_BTI) {
+        return PROT_READ | PROT_EXEC | PROT_BTI;
+    }
+#endif
+    return PROT_READ | PROT_EXEC;
+}
+#endif
+
 #ifdef CONFIG_DEBUG_TCG
 const void *tcg_splitwx_to_rx(void *rw)
 {
@@ -505,14 +528,6 @@ static int alloc_code_gen_buffer(size_t tb_size, int splitwx, Error **errp)
     return PROT_READ | PROT_WRITE;
 }
 #elif defined(_WIN32)
-/*
- * Local source-level compatibility with Unix.
- * Used by tcg_region_init below.
- */
-#define PROT_READ   1
-#define PROT_WRITE  2
-#define PROT_EXEC   4
-
 static int alloc_code_gen_buffer(size_t size, int splitwx, Error **errp)
 {
     void *buf;
@@ -567,7 +582,7 @@ static int alloc_code_gen_buffer_splitwx_memfd(size_t size, Error **errp)
         goto fail;
     }
 
-    buf_rx = mmap(NULL, size, PROT_READ | PROT_EXEC, MAP_SHARED, fd, 0);
+    buf_rx = mmap(NULL, size, host_prot_read_exec(), MAP_SHARED, fd, 0);
     if (buf_rx == MAP_FAILED) {
         goto fail_rx;
     }
@@ -642,7 +657,7 @@ static int alloc_code_gen_buffer_splitwx_vmremap(size_t size, Error **errp)
         return -1;
     }
 
-    if (mprotect((void *)buf_rx, size, PROT_READ | PROT_EXEC) != 0) {
+    if (mprotect((void *)buf_rx, size, host_prot_read_exec()) != 0) {
         error_setg_errno(errp, errno, "mprotect for jit splitwx");
         munmap((void *)buf_rx, size);
         munmap((void *)buf_rw, size);
@@ -805,7 +820,7 @@ void tcg_region_init(size_t tb_size, int splitwx, unsigned max_cpus)
     need_prot = PROT_READ | PROT_WRITE;
 #ifndef CONFIG_TCG_INTERPRETER
     if (tcg_splitwx_diff == 0) {
-        need_prot |= PROT_EXEC;
+        need_prot |= host_prot_read_exec();
     }
 #endif
     for (size_t i = 0, n = region.n; i < n; i++) {
@@ -820,7 +835,11 @@ void tcg_region_init(size_t tb_size, int splitwx, unsigned max_cpus)
             } else if (need_prot == (PROT_READ | PROT_WRITE)) {
                 rc = qemu_mprotect_rw(start, end - start);
             } else {
+#ifdef CONFIG_POSIX
+                rc = mprotect(start, end - start, need_prot);
+#else
                 g_assert_not_reached();
+#endif
             }
             if (rc) {
                 error_setg_errno(&error_fatal, errno,
-- 
2.34.1


