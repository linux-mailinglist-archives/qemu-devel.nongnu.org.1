Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA4278115B
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 19:14:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX32C-0008Qm-4s; Fri, 18 Aug 2023 13:13:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX322-0008Lf-4W
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:13:06 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX31z-00087J-Gd
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:13:05 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1bc83a96067so8714425ad.0
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 10:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692378782; x=1692983582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xRESX9nFR6tNCpUYhPFWnwcFBDJbo9xNbLHublG/Dkk=;
 b=xxMLexHMqP8i5m0FMT0NADayUZknlyJRIIYFL8eWEwXV6jJGdWRCS4sLu4DF/piUwz
 GbJTwGmIUiYDna90YiP4As0HNWz0SPyhdwOY6olF9PVFXucjjBqju/5qXXmgpPMAKZ2a
 wTsAOGAp1yCFkOwBfqathxMe4qkyr9DJVj6QiiyzkLO+VHSGGEQ0qClq8bAPCpeLjDg5
 W54Kc7zPuhhXGEUbK8sn33i+mxyzH447Kgb9clvl5NHgR9JOWDkwUX3LCbI1dXylOz4v
 JxBSdJ40c6fKpo8qxTpHKT8W75OGtaERaLSthB6tQlKn80rZh4AjFY+y4/vUFFXozxcj
 RqOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692378782; x=1692983582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xRESX9nFR6tNCpUYhPFWnwcFBDJbo9xNbLHublG/Dkk=;
 b=N+KuRaKi7fHRNQUVDZblshYOfvFQSH+Qp6OrGtiGOlpmxccU/KWUv8BNI4IZgXEpk4
 /bIjlPjNiQPcbzgBK5ctxgALscUzBIs6PHGyDo7mfBrO1mLj2YpS8dFh6mTS75NcU+6z
 1UVJinQSVgnHSlks4wPJ9atSJkR0xy/Dss5K30MmSCMuHGaEGgqznfnH0Xzi+awS4V4j
 ywKkQxv9WTma/JhlhqVCUcUULRWSog0X0AIuq1gSx2D1tDv5/soRb1eCeK6q57sHb9WE
 otMBq3l8kPJJr6QEYRFO27ukE91x93s8lZGEDxLNVS1FAn5SmdZD4mM0lKs+haUQlfTt
 uvnQ==
X-Gm-Message-State: AOJu0YyNhNrwT1q4tYEGUEROeJRDI2YlXrz+MX0LEs7uEcCmW/l3WJoK
 beWfpoh3iKy3fffHSKLiMWLh43FNTx+JhniR89Y=
X-Google-Smtp-Source: AGHT+IEBYi2NRTEtNYsRZzyqZeUmJhGfLrqiXBsfehxcNFjSwuO6ZDZXUv2cobHyeTHYcpwKJf7tEQ==
X-Received: by 2002:a17:902:e88b:b0:1b8:9ecd:8b86 with SMTP id
 w11-20020a170902e88b00b001b89ecd8b86mr4006618plg.5.1692378782039; 
 Fri, 18 Aug 2023 10:13:02 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 jw24-20020a170903279800b001adf6b21c77sm2020025plb.107.2023.08.18.10.13.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 10:13:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 28/33] accel/tcg: Disconnect TargetPageDataNode from page size
Date: Fri, 18 Aug 2023 10:12:22 -0700
Message-Id: <20230818171227.141728-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818171227.141728-1-richard.henderson@linaro.org>
References: <20230818171227.141728-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

Dynamically size the node for the runtime target page size.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/user-exec.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 4c1697500a..09dc85c851 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -863,7 +863,7 @@ tb_page_addr_t get_page_addr_code_hostp(CPUArchState *env, vaddr addr,
 typedef struct TargetPageDataNode {
     struct rcu_head rcu;
     IntervalTreeNode itree;
-    char data[TPD_PAGES][TARGET_PAGE_DATA_SIZE] __attribute__((aligned));
+    char data[] __attribute__((aligned));
 } TargetPageDataNode;
 
 static IntervalTreeRoot targetdata_root;
@@ -901,7 +901,8 @@ void page_reset_target_data(target_ulong start, target_ulong last)
         n_last = MIN(last, n->last);
         p_len = (n_last + 1 - n_start) >> TARGET_PAGE_BITS;
 
-        memset(t->data[p_ofs], 0, p_len * TARGET_PAGE_DATA_SIZE);
+        memset(t->data + p_ofs * TARGET_PAGE_DATA_SIZE, 0,
+               p_len * TARGET_PAGE_DATA_SIZE);
     }
 }
 
@@ -909,7 +910,7 @@ void *page_get_target_data(target_ulong address)
 {
     IntervalTreeNode *n;
     TargetPageDataNode *t;
-    target_ulong page, region;
+    target_ulong page, region, p_ofs;
 
     page = address & TARGET_PAGE_MASK;
     region = address & TBD_MASK;
@@ -925,7 +926,8 @@ void *page_get_target_data(target_ulong address)
         mmap_lock();
         n = interval_tree_iter_first(&targetdata_root, page, page);
         if (!n) {
-            t = g_new0(TargetPageDataNode, 1);
+            t = g_malloc0(sizeof(TargetPageDataNode)
+                          + TPD_PAGES * TARGET_PAGE_DATA_SIZE);
             n = &t->itree;
             n->start = region;
             n->last = region | ~TBD_MASK;
@@ -935,7 +937,8 @@ void *page_get_target_data(target_ulong address)
     }
 
     t = container_of(n, TargetPageDataNode, itree);
-    return t->data[(page - region) >> TARGET_PAGE_BITS];
+    p_ofs = (page - region) >> TARGET_PAGE_BITS;
+    return t->data + p_ofs * TARGET_PAGE_DATA_SIZE;
 }
 #else
 void page_reset_target_data(target_ulong start, target_ulong last) { }
-- 
2.34.1


