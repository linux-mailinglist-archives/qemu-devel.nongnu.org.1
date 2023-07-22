Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCD275DEA7
	for <lists+qemu-devel@lfdr.de>; Sat, 22 Jul 2023 23:45:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNKOy-0000IA-D6; Sat, 22 Jul 2023 17:44:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNKOw-0000HL-Ik
 for qemu-devel@nongnu.org; Sat, 22 Jul 2023 17:44:34 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNKOo-000336-OI
 for qemu-devel@nongnu.org; Sat, 22 Jul 2023 17:44:34 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3fbd33a57b6so29116425e9.2
 for <qemu-devel@nongnu.org>; Sat, 22 Jul 2023 14:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690062264; x=1690667064;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qG/YzCM95hrWGxKPyq8mYT9sLVAwD8vgBndl4G8LDU8=;
 b=FnJSUEIylQCXrnkMbG/R/eKgzZm/VtYXdix7AAUvAWjf6mm2ghDWnDJ7TZkevjQBks
 cS1hx8c96NJ59BRH/BriT2xVOArZII1UghK05PD2+pTeA09090ASHLTR8Acig5PkZgsy
 Ax3dh/Y6MKln0mCnR+sjQkZHITjn6mohF+L6HyA4edZfChqKm7sPm+UuHjSI3XSmMyE/
 DB9juBOwT2phhrwxcXTbJgJjcUhWW6RNYHbW0HzQpaPf90fyjim64zfIdnKmxRPXBOuY
 Z27KQ3YIVJ6I3hX2RCJyu4OzCANFcxztfXevBDu4l72WwCSHbLo1l8LrMcLFIpzHYjqT
 8viw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690062264; x=1690667064;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qG/YzCM95hrWGxKPyq8mYT9sLVAwD8vgBndl4G8LDU8=;
 b=aZL6RNy7IW9aLuziYcFLw3LZlysOCL3QZpepRYG1gFmBfQz3e1hbaDeSf21FYEFA0u
 JBASxE2CzDgZASUrmlRDqC7+wa0o7pVjlsGk9x7tR0xl+vBWY+0oq/U3rJXQvQV2DcSb
 EH68rnTJrczB6H0ppJwqEYQotI9dFqNHk3i8ibxL9GvFor42YRciuHV9U8t6ivZhcQZ6
 n7B7BmsDIthFqc5lxuOUmtRG4uO5Hze9odbd2sMNBvB09a2UTd5wol+nc6bEeLG7mAOh
 COS4n/NZFwGEawhseA0CoTB7w4nDmJ9uDIs8PN88BXxuyCnwtXg8s5aG58BerONDY/rq
 oJKg==
X-Gm-Message-State: ABy/qLbl6/pbLwarPjrIU+kZGNsNbUnPE0lpPpiPyuZvMQLrW9H5ATjR
 s0VYh7wO1B8CRoW5QaRxEnYwFZU5iQ6t94gvVqRRiw==
X-Google-Smtp-Source: APBJJlHKH1K4Ta04G1njxJGDETANnYgY5mkIPGtrmXaLDQ1gjNlZ9shAhA2LHRAdpUwuVQ6rxlY7eg==
X-Received: by 2002:a7b:c4d3:0:b0:3fd:2e28:655e with SMTP id
 g19-20020a7bc4d3000000b003fd2e28655emr1720045wmk.9.1690062264432; 
 Sat, 22 Jul 2023 14:44:24 -0700 (PDT)
Received: from stoup.acentic.lan
 (179.181-106-213.static.virginmediabusiness.co.uk. [213.106.181.179])
 by smtp.gmail.com with ESMTPSA id
 v22-20020a7bcb56000000b003fbb9339b29sm8846384wmj.42.2023.07.22.14.44.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Jul 2023 14:44:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	qemu-stable@nongnu.org
Subject: [PATCH for-8.1 v2 1/4] util/interval-tree: Use qatomic_read for
 left/right while searching
Date: Sat, 22 Jul 2023 22:44:19 +0100
Message-Id: <20230722214422.118743-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230722214422.118743-1-richard.henderson@linaro.org>
References: <20230722214422.118743-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32d.google.com
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

Fixes a race condition (generally without optimization) in which
the subtree is re-read after the protecting if condition.

Cc: qemu-stable@nongnu.org
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 util/interval-tree.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/util/interval-tree.c b/util/interval-tree.c
index 4c0baf108f..5a0ad21b2d 100644
--- a/util/interval-tree.c
+++ b/util/interval-tree.c
@@ -745,8 +745,9 @@ static IntervalTreeNode *interval_tree_subtree_search(IntervalTreeNode *node,
          * Loop invariant: start <= node->subtree_last
          * (Cond2 is satisfied by one of the subtree nodes)
          */
-        if (node->rb.rb_left) {
-            IntervalTreeNode *left = rb_to_itree(node->rb.rb_left);
+        RBNode *tmp = qatomic_read(&node->rb.rb_left);
+        if (tmp) {
+            IntervalTreeNode *left = rb_to_itree(tmp);
 
             if (start <= left->subtree_last) {
                 /*
@@ -765,8 +766,9 @@ static IntervalTreeNode *interval_tree_subtree_search(IntervalTreeNode *node,
             if (start <= node->last) {     /* Cond2 */
                 return node; /* node is leftmost match */
             }
-            if (node->rb.rb_right) {
-                node = rb_to_itree(node->rb.rb_right);
+            tmp = qatomic_read(&node->rb.rb_right);
+            if (tmp) {
+                node = rb_to_itree(tmp);
                 if (start <= node->subtree_last) {
                     continue;
                 }
@@ -814,8 +816,9 @@ IntervalTreeNode *interval_tree_iter_first(IntervalTreeRoot *root,
 IntervalTreeNode *interval_tree_iter_next(IntervalTreeNode *node,
                                           uint64_t start, uint64_t last)
 {
-    RBNode *rb = node->rb.rb_right, *prev;
+    RBNode *rb, *prev;
 
+    rb = qatomic_read(&node->rb.rb_right);
     while (true) {
         /*
          * Loop invariants:
@@ -840,7 +843,7 @@ IntervalTreeNode *interval_tree_iter_next(IntervalTreeNode *node,
             }
             prev = &node->rb;
             node = rb_to_itree(rb);
-            rb = node->rb.rb_right;
+            rb = qatomic_read(&node->rb.rb_right);
         } while (prev == rb);
 
         /* Check if the node intersects [start;last] */
-- 
2.34.1


