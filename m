Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 183DC77E37D
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 16:25:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWHSi-00043O-QE; Wed, 16 Aug 2023 10:25:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qWHSf-0003xF-PZ
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 10:25:25 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qWHSc-0003kh-UJ
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 10:25:25 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-68872cadc7cso1184895b3a.1
 for <qemu-devel@nongnu.org>; Wed, 16 Aug 2023 07:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692195921; x=1692800721;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=czkgg7jUOKlP3GcfTMH8TgF34amSntL+ZEW9hzFx4Wg=;
 b=wx2Kn8X/CNoONFLsVHsBCvWiYH6pu3btMmFj4IgvAWspAno/AjBsrtfUXGBx/qKzeN
 yklevRitt+lOUZ2DwcYWMciAtC4ja561z5Ma2nD3YUu/cx3tItR9xiP83P+BAkHUvi8s
 JjQJDouc9keZQkwWqcpqlbncueY50ENsx1ZSbrFOhk8eZnx9VWbKlQKX3T/wVrkWlopG
 AYt/3+megQ3hXmDXGwOPqE5Q08ZG3pUiIT2u+6x/UvtMk47wcTYLa9xkZEftFcsnaUy9
 PGNMIsx6KGtCh9fuH88zgGhvltvCGf09WXRypb2WoqUBcdcPGNzgM/A3WWUaeWC3+ED4
 FdSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692195921; x=1692800721;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=czkgg7jUOKlP3GcfTMH8TgF34amSntL+ZEW9hzFx4Wg=;
 b=fAprKVsXpFPbxspkUVPLUSZqWM7xQc2thl2QsF+iCHvdgtMTmGF2I3cbmLFuPGqXdV
 2thklWDemeWrudG4vz/MnHY18qgCoyyJIpzfga2SMAYYhs9jyn6mkWi8bDVb/UfSWNDk
 bsPxonA542xOheDILPlP5gwdegHuZbljlI2F+MtvkygbSFrJiPYZmCheUoxU9f78qk01
 5oTFnhCv0dbZKSWnTlWVMN+Rl0qUizgVI91upEo2Fwz/muqIGCt2fmxvda3NS7Tqy8yf
 ZU95Y+2vRav/iNx7AkKzGoejPHTTwtyhcx6pmg6QWoJ4mkFXLHvwhpxh2g+YAls79zKw
 fa+w==
X-Gm-Message-State: AOJu0YyyM/Xj/XyHyw/ab8EbV85XgBXFcW0eVPDRGHrophi60cJjkJX1
 CMoBsipyNkPUUcjcPv1VDGyw+rCg/UzGJzCS2p8=
X-Google-Smtp-Source: AGHT+IGft5PuIyGbDKsADDsa+pfUB8Btn8kHBWM+KJ7Cw1Byt3wrzRq5qkPY/ARNaKCpraLAK/owtg==
X-Received: by 2002:a05:6a00:a93:b0:687:570:5021 with SMTP id
 b19-20020a056a000a9300b0068705705021mr2423164pfl.15.1692195921594; 
 Wed, 16 Aug 2023 07:25:21 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:a064:e3f9:a812:973b])
 by smtp.gmail.com with ESMTPSA id
 i12-20020aa78b4c000000b00678cb337353sm11156019pfd.208.2023.08.16.07.25.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Aug 2023 07:25:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 4/4] tcg: Map code_gen_buffer with PROT_BTI
Date: Wed, 16 Aug 2023 07:25:16 -0700
Message-Id: <20230816142516.469743-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230816142516.469743-1-richard.henderson@linaro.org>
References: <20230816142516.469743-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/region.c | 39 ++++++++++++++++++++++++++++-----------
 1 file changed, 28 insertions(+), 11 deletions(-)

diff --git a/tcg/region.c b/tcg/region.c
index 2b28ed3556..58cb68c6c8 100644
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
@@ -83,6 +94,16 @@ bool in_code_gen_buffer(const void *p)
     return (size_t)(p - region.start_aligned) <= region.total_size;
 }
 
+static int host_prot_read_exec(void)
+{
+#if defined(CONFIG_LINUX) && defined(HOST_AARCH64) && defined(PROT_BTI)
+    if (cpuinfo & CPUINFO_BTI) {
+        return PROT_READ | PROT_EXEC | PROT_BTI;
+    }
+#endif
+    return PROT_READ | PROT_EXEC;
+}
+
 #ifdef CONFIG_DEBUG_TCG
 const void *tcg_splitwx_to_rx(void *rw)
 {
@@ -505,14 +526,6 @@ static int alloc_code_gen_buffer(size_t tb_size, int splitwx, Error **errp)
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
@@ -567,7 +580,7 @@ static int alloc_code_gen_buffer_splitwx_memfd(size_t size, Error **errp)
         goto fail;
     }
 
-    buf_rx = mmap(NULL, size, PROT_READ | PROT_EXEC, MAP_SHARED, fd, 0);
+    buf_rx = mmap(NULL, size, host_prot_read_exec(), MAP_SHARED, fd, 0);
     if (buf_rx == MAP_FAILED) {
         goto fail_rx;
     }
@@ -642,7 +655,7 @@ static int alloc_code_gen_buffer_splitwx_vmremap(size_t size, Error **errp)
         return -1;
     }
 
-    if (mprotect((void *)buf_rx, size, PROT_READ | PROT_EXEC) != 0) {
+    if (mprotect((void *)buf_rx, size, host_prot_read_exec()) != 0) {
         error_setg_errno(errp, errno, "mprotect for jit splitwx");
         munmap((void *)buf_rx, size);
         munmap((void *)buf_rw, size);
@@ -805,7 +818,7 @@ void tcg_region_init(size_t tb_size, int splitwx, unsigned max_cpus)
     need_prot = PROT_READ | PROT_WRITE;
 #ifndef CONFIG_TCG_INTERPRETER
     if (tcg_splitwx_diff == 0) {
-        need_prot |= PROT_EXEC;
+        need_prot |= host_prot_read_exec();
     }
 #endif
     for (size_t i = 0, n = region.n; i < n; i++) {
@@ -820,7 +833,11 @@ void tcg_region_init(size_t tb_size, int splitwx, unsigned max_cpus)
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


