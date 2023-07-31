Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E713876A259
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 23:03:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQa1y-0000oS-Pm; Mon, 31 Jul 2023 17:02:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qQa1w-0000nQ-Jc
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 17:02:16 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qQa1v-0006M6-0k
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 17:02:16 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1bc02bd4eafso17987665ad.1
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 14:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690837334; x=1691442134;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wm4GRXTtNsgafsC2QchrPp0CcNNwD+XuJ7FjQ2Qh7j0=;
 b=vZFSz+3e0gk1wqoGnSzwi6OCMMItlZBc89kuoAnaOHzlUpKE0TBk55jpqAwnDFyzcV
 6JDDoQZv3EMfvr21/QL2GB7gWFkioFNVb1GLQwNMvi0VhlsqIOM8XFjTZv27Y+kynx/p
 oqfmqj7jp54ei6gD/PKUNP5pFi6JeKSVuEV/UREscdS/JWUhw/tNxHDdFEr6CLz1HQM6
 dnCmaB/wV6W6xrUXlApZfmlvX82OyFED+chGjizF2jeS6+H35OoASr1I9IjuV6qjvPIW
 CdlJP/8FxbmdQEtVjkH2Wd2VGTOIH4kukPQy5lOrywueij3mhCabpL3ONhpkggvZI0Xa
 Qc/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690837334; x=1691442134;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wm4GRXTtNsgafsC2QchrPp0CcNNwD+XuJ7FjQ2Qh7j0=;
 b=Kc2eqnRNevJyKSGNuCPRa+clxMH2DcmqLuW6lT/2oGg+FWzHnfLInAdbislgVhk6Vx
 9HGHrN8jTFj7S+kqE8nxvnRlNz9MyQrioDqUixwX23eQAJaK7n70YK4aIs+Mc7GfBF4o
 de21LaWMFPaF63ErmmMWB6ZfwgANXSR/x68Mn6YJpQqnMuYGmxMGWTxi4kU954vnuHo6
 ZQCLSUSUNfHHjnEyax16iSnK6crskGVAXn/IF84dHM7TbUS0nAaQ+JPilQTBsC7xvvgX
 fWCIoN7wlegqRP+u93LyVlxyCfILTKrbduQ9TaMIGt4as0Hq0Rt/LaYREX2s91a8asf+
 LO9Q==
X-Gm-Message-State: ABy/qLZwlOeydQnnY25Tk3zdlOZy5Ox2uYq7pr0/0GK4d4ZRA3ks1WUE
 upPHVGxk4L6AejSiHBL7G8dKbfpYc/ziGiwieYk=
X-Google-Smtp-Source: APBJJlHPUD6yZ6afRfZFL6hk3R5F0EAS8F98cNsVWXXwfZ159W+yFyFNApVeLmnmke2hJ79ZbGGzWw==
X-Received: by 2002:a17:902:988e:b0:1b2:1a79:147d with SMTP id
 s14-20020a170902988e00b001b21a79147dmr11047962plp.2.1690837333797; 
 Mon, 31 Jul 2023 14:02:13 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:4f6f:6b:2de4:e0cb])
 by smtp.gmail.com with ESMTPSA id
 r11-20020a1709028bcb00b001bb8895848bsm8924230plo.71.2023.07.31.14.02.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Jul 2023 14:02:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 01/10] util/interval-tree: Use qatomic_read for left/right
 while searching
Date: Mon, 31 Jul 2023 14:02:02 -0700
Message-Id: <20230731210211.137353-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230731210211.137353-1-richard.henderson@linaro.org>
References: <20230731210211.137353-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
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


