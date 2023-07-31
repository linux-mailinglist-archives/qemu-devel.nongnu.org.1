Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CAB876A260
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 23:03:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQa22-0000qm-4N; Mon, 31 Jul 2023 17:02:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qQa1z-0000pJ-TZ
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 17:02:20 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qQa1y-0006O5-14
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 17:02:19 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1bbc64f9a91so41992255ad.0
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 14:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690837336; x=1691442136;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mSaiqNFB6jjwG6Ld2HBVU8RlVJLDefjbnB1ExR7a8lc=;
 b=nLZbXqv/52iHwGyg2zsQMW9ocy2hzVUi8NLCeymLuPl47DSDWum+fzp9gnQ1zSk9F3
 HS3BLciiiz6oEWa7+HN3xvG9FtV8KrIhc1OdHlybbqaPZbLWGkfU/OLChPC2MS/0K9nD
 zkPqLFujZwZVBCjtnYdahBaG1ebNDgChFXjh9wuN7FCXx7RanqbfK0ca7hN48yZQ+c5F
 oVMUnsneR3FY9mVk87R8zesS9uYmz8fT6Ajn4QstWldrcfp86jX9wqdGkmtPbCGmx8mq
 rnVToLr5V3mw3FmInSr1tskFXl+ryGOH2UfQyfmw1Os9IIoCEQoT099DJSPRBBaDsMWS
 HiRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690837336; x=1691442136;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mSaiqNFB6jjwG6Ld2HBVU8RlVJLDefjbnB1ExR7a8lc=;
 b=byfP6gWzK9d/6wctIl8aHRqCfiD+kRw5pouJOkF2SJblvugiADK4vnSowadLpkbbfZ
 Y9RdU9bdBDTbST9i+p1vEmIAouTmjBsQIPfRwBacElsc6IXAn3V0TqBm2GKzA+ufyAGp
 zWZkhZO2WarUdtLexVfLuKRlH4wTB0LaeKpYAc0jweeKBIOrFxLKqGEdjdLc6Eg5Wk/D
 cgFAZ6Efmo0ChP26T1XbHOGytl2tzMcIYERz0Tdgv9sfMawCUg8vhtSXQYBDhrs8ZQ/7
 hY2+qcb6HCWRNh9aMih7h8v1NAvmOpENVSOtzpFP5ydn+kU3RxYPoQeNiTy3YjeWaNII
 H7Uw==
X-Gm-Message-State: ABy/qLZQ3o6p6nUVD4vDL/orLRBwC6EtI23lcI0UVhoUELI1cqtpjXcF
 AMlvCNACZzshBBxH1lbTBaISQMVAqwS8de8O0A4=
X-Google-Smtp-Source: APBJJlGl4bUPv1g7dZ6q8nbKHF/JWZlgb/oDbWSdOPRm0BfdN8bfV3KwhkJYvf4xXgPdbaWh7u28gQ==
X-Received: by 2002:a17:902:a405:b0:1bb:660:98d0 with SMTP id
 p5-20020a170902a40500b001bb066098d0mr9908765plq.59.1690837336575; 
 Mon, 31 Jul 2023 14:02:16 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:4f6f:6b:2de4:e0cb])
 by smtp.gmail.com with ESMTPSA id
 r11-20020a1709028bcb00b001bb8895848bsm8924230plo.71.2023.07.31.14.02.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Jul 2023 14:02:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 04/10] util/interval-tree: Use qatomic_read/set for
 rb_parent_color
Date: Mon, 31 Jul 2023 14:02:05 -0700
Message-Id: <20230731210211.137353-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230731210211.137353-1-richard.henderson@linaro.org>
References: <20230731210211.137353-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

While less susceptible to optimization problems than left and right,
interval_tree_iter_next also reads rb_parent(), so make sure that
stores and loads are atomic.

This goes further than technically required, changing all loads to
be atomic, rather than simply the ones in the iteration side.  But
it doesn't really affect the code generation on the rebalance side
and is cleaner to handle everything the same.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 util/interval-tree.c | 47 ++++++++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 21 deletions(-)

diff --git a/util/interval-tree.c b/util/interval-tree.c
index d86c0752db..f2866aa7d3 100644
--- a/util/interval-tree.c
+++ b/util/interval-tree.c
@@ -48,12 +48,6 @@
  *
  * It also guarantees that if the lookup returns an element it is the 'correct'
  * one. But not returning an element does _NOT_ mean it's not present.
- *
- * NOTE:
- *
- * Stores to __rb_parent_color are not important for simple lookups so those
- * are left undone as of now. Nor did I check for loops involving parent
- * pointers.
  */
 
 typedef enum RBColor
@@ -68,6 +62,16 @@ typedef struct RBAugmentCallbacks {
     void (*rotate)(RBNode *old, RBNode *new);
 } RBAugmentCallbacks;
 
+static inline uintptr_t rb_pc(const RBNode *n)
+{
+    return qatomic_read(&n->rb_parent_color);
+}
+
+static inline void rb_set_pc(RBNode *n, uintptr_t pc)
+{
+    qatomic_set(&n->rb_parent_color, pc);
+}
+
 static inline RBNode *pc_parent(uintptr_t pc)
 {
     return (RBNode *)(pc & ~1);
@@ -75,12 +79,12 @@ static inline RBNode *pc_parent(uintptr_t pc)
 
 static inline RBNode *rb_parent(const RBNode *n)
 {
-    return pc_parent(n->rb_parent_color);
+    return pc_parent(rb_pc(n));
 }
 
 static inline RBNode *rb_red_parent(const RBNode *n)
 {
-    return (RBNode *)n->rb_parent_color;
+    return (RBNode *)rb_pc(n);
 }
 
 static inline RBColor pc_color(uintptr_t pc)
@@ -100,27 +104,27 @@ static inline bool pc_is_black(uintptr_t pc)
 
 static inline RBColor rb_color(const RBNode *n)
 {
-    return pc_color(n->rb_parent_color);
+    return pc_color(rb_pc(n));
 }
 
 static inline bool rb_is_red(const RBNode *n)
 {
-    return pc_is_red(n->rb_parent_color);
+    return pc_is_red(rb_pc(n));
 }
 
 static inline bool rb_is_black(const RBNode *n)
 {
-    return pc_is_black(n->rb_parent_color);
+    return pc_is_black(rb_pc(n));
 }
 
 static inline void rb_set_black(RBNode *n)
 {
-    n->rb_parent_color |= RB_BLACK;
+    rb_set_pc(n, rb_pc(n) | RB_BLACK);
 }
 
 static inline void rb_set_parent_color(RBNode *n, RBNode *p, RBColor color)
 {
-    n->rb_parent_color = (uintptr_t)p | color;
+    rb_set_pc(n, (uintptr_t)p | color);
 }
 
 static inline void rb_set_parent(RBNode *n, RBNode *p)
@@ -186,9 +190,10 @@ static inline void rb_change_child(RBNode *old, RBNode *new,
 static inline void rb_rotate_set_parents(RBNode *old, RBNode *new,
                                          RBRoot *root, RBColor color)
 {
-    RBNode *parent = rb_parent(old);
+    uintptr_t pc = rb_pc(old);
+    RBNode *parent = pc_parent(pc);
 
-    new->rb_parent_color = old->rb_parent_color;
+    rb_set_pc(new, pc);
     rb_set_parent_color(old, new, color);
     rb_change_child(old, new, parent, root);
 }
@@ -536,11 +541,11 @@ static void rb_erase_augmented(RBNode *node, RBRoot *root,
          * and node must be black due to 4). We adjust colors locally
          * so as to bypass rb_erase_color() later on.
          */
-        pc = node->rb_parent_color;
+        pc = rb_pc(node);
         parent = pc_parent(pc);
         rb_change_child(node, child, parent, root);
         if (child) {
-            child->rb_parent_color = pc;
+            rb_set_pc(child, pc);
             rebalance = NULL;
         } else {
             rebalance = pc_is_black(pc) ? parent : NULL;
@@ -548,9 +553,9 @@ static void rb_erase_augmented(RBNode *node, RBRoot *root,
         tmp = parent;
     } else if (!child) {
         /* Still case 1, but this time the child is node->rb_left */
-        pc = node->rb_parent_color;
+        pc = rb_pc(node);
         parent = pc_parent(pc);
-        tmp->rb_parent_color = pc;
+        rb_set_pc(tmp, pc);
         rb_change_child(node, tmp, parent, root);
         rebalance = NULL;
         tmp = parent;
@@ -604,7 +609,7 @@ static void rb_erase_augmented(RBNode *node, RBRoot *root,
         qatomic_set(&successor->rb_left, tmp);
         rb_set_parent(tmp, successor);
 
-        pc = node->rb_parent_color;
+        pc = rb_pc(node);
         tmp = pc_parent(pc);
         rb_change_child(node, successor, tmp, root);
 
@@ -614,7 +619,7 @@ static void rb_erase_augmented(RBNode *node, RBRoot *root,
         } else {
             rebalance = rb_is_black(successor) ? parent : NULL;
         }
-        successor->rb_parent_color = pc;
+        rb_set_pc(successor, pc);
         tmp = successor;
     }
 
-- 
2.34.1


