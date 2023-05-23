Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D6070DEFD
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 16:16:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1SVl-0003QN-9b; Tue, 23 May 2023 09:57:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SVe-0003FB-20
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:57:09 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SVb-0004Cs-6L
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:57:05 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-64d3bc502ddso5122350b3a.0
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684850222; x=1687442222;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OVmsUx5trCwxWekmTd1RE9Nb9Hhxj1t4Uos0U6OmJ/w=;
 b=rd5dBAFJ+i2tym6Xr9t6sA6gQH6AkVzfIwKiViNeTK3GxHP+cuudVqCIJtFkPE5dk9
 IH6sINRdT716LrbMqWDZLAFsuYVOBxzsfBNjQfW5j0qmU5ox3H8gX56goPYWxX8dvch8
 IDC70dckXsrInY/tyEAQyT2OTRUnb3D8W41VDV62TrMZqgWUuJ5f/2FSEhsrU7+4xeEh
 EOtubzR+ZT+uSJcaZV+f69+wP2A5L+qJG3VHdYehpP8gd68VoMkKxFB0z3WW9DqPzNfL
 telci+jAWDkGD9KBzcxWN9gv2I4szKDKFWDGtmzKNPQ3VdRq/t1nkvdtJhgi6JKHas1f
 eWGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684850222; x=1687442222;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OVmsUx5trCwxWekmTd1RE9Nb9Hhxj1t4Uos0U6OmJ/w=;
 b=BCglddv7qEBJ/NlAtSHX1VBqHtIxpSADTi/xCyP5RsAXb03GmyKyzTDBBHYbxlAh3+
 Jkq1GkZNqtc94cLLEIyl1wjTpblgVypgQ1rziQTuTWFqTFObM2OvdrW99kLS8/wb6X3/
 V7vrF58WEHCNwByRY/3zxzsUHz1Y7BTRQ+fw7Jk26RnWgErgt1Lm4raCWgznerXD0Jfn
 TLbV6IBAVw+rv3y4jBb4mBubZTCOsVPDgGT9lSotjg2LSLHNgV69hiycHc6XvhTnoJqr
 vMVCANs/PyHlBfdLnPghHhbLlOkkjwpApFZP34s8HQoI3N0NEZkcGQzPruQMJoEF6kpW
 dn6g==
X-Gm-Message-State: AC+VfDzjrWsbMFWcqsREwvHMqr7mQJGCKbTxzhE125yYYYbj8GoDN6SX
 OpSIQAg/E6A1bfG4IKFXPA87U56r7yUmI/bDy1I=
X-Google-Smtp-Source: ACHHUZ6Lk7AA4CX+4qGfDvAsyvGgYFpyKNzHGDsDPm1UBcpY00KpYN71I2u1azIZchKHIA696jPq5Q==
X-Received: by 2002:a05:6a00:1307:b0:64b:256:204c with SMTP id
 j7-20020a056a00130700b0064b0256204cmr18298429pfu.20.1684850221464; 
 Tue, 23 May 2023 06:57:01 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 v11-20020a62a50b000000b0063799398eaesm5805790pfm.51.2023.05.23.06.57.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 06:57:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 46/52] tcg: Fix PAGE/PROT confusion
Date: Tue, 23 May 2023 06:53:16 -0700
Message-Id: <20230523135322.678948-47-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523135322.678948-1-richard.henderson@linaro.org>
References: <20230523135322.678948-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

The bug was hidden because they happen to have the same values.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/region.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/tcg/region.c b/tcg/region.c
index 34ac124081..184e684b04 100644
--- a/tcg/region.c
+++ b/tcg/region.c
@@ -507,6 +507,14 @@ static int alloc_code_gen_buffer(size_t tb_size, int splitwx, Error **errp)
     return PROT_READ | PROT_WRITE;
 }
 #elif defined(_WIN32)
+/*
+ * Local source-level compatibility with Unix.
+ * Used by tcg_region_init below.
+ */
+#define PROT_READ   1
+#define PROT_WRITE  2
+#define PROT_EXEC   4
+
 static int alloc_code_gen_buffer(size_t size, int splitwx, Error **errp)
 {
     void *buf;
@@ -527,7 +535,7 @@ static int alloc_code_gen_buffer(size_t size, int splitwx, Error **errp)
     region.start_aligned = buf;
     region.total_size = size;
 
-    return PAGE_READ | PAGE_WRITE | PAGE_EXEC;
+    return PROT_READ | PROT_WRITE | PROT_EXEC;
 }
 #else
 static int alloc_code_gen_buffer_anon(size_t size, int prot,
@@ -796,10 +804,10 @@ void tcg_region_init(size_t tb_size, int splitwx, unsigned max_cpus)
      * buffer -- let that one use hugepages throughout.
      * Work with the page protections set up with the initial mapping.
      */
-    need_prot = PAGE_READ | PAGE_WRITE;
+    need_prot = PROT_READ | PROT_WRITE;
 #ifndef CONFIG_TCG_INTERPRETER
     if (tcg_splitwx_diff == 0) {
-        need_prot |= PAGE_EXEC;
+        need_prot |= PROT_EXEC;
     }
 #endif
     for (size_t i = 0, n = region.n; i < n; i++) {
@@ -809,9 +817,9 @@ void tcg_region_init(size_t tb_size, int splitwx, unsigned max_cpus)
         if (have_prot != need_prot) {
             int rc;
 
-            if (need_prot == (PAGE_READ | PAGE_WRITE | PAGE_EXEC)) {
+            if (need_prot == (PROT_READ | PROT_WRITE | PROT_EXEC)) {
                 rc = qemu_mprotect_rwx(start, end - start);
-            } else if (need_prot == (PAGE_READ | PAGE_WRITE)) {
+            } else if (need_prot == (PROT_READ | PROT_WRITE)) {
                 rc = qemu_mprotect_rw(start, end - start);
             } else {
                 g_assert_not_reached();
-- 
2.34.1


