Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 716FF75DEA4
	for <lists+qemu-devel@lfdr.de>; Sat, 22 Jul 2023 23:45:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNKP0-0000J4-QR; Sat, 22 Jul 2023 17:44:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNKOx-0000ID-U2
 for qemu-devel@nongnu.org; Sat, 22 Jul 2023 17:44:35 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNKOp-00033l-W4
 for qemu-devel@nongnu.org; Sat, 22 Jul 2023 17:44:35 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3fd190065a7so24704985e9.2
 for <qemu-devel@nongnu.org>; Sat, 22 Jul 2023 14:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690062266; x=1690667066;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fNV9KjzEsBoviNOMWq+gTDNaJIuDvwgsDMpOIIStNx8=;
 b=gF5+FZ4INNFjFYpokp0BOEpjXOwZkfBxeCN36Lv7QoDkAvLudkOP5YGFMQquycS3H3
 TMoHlvQegdVDS+QlyvHUTQztzDByyavfiQoGtwvjrn+t1AtfpjRF8RMzJ2hJXGkGlLPK
 xbBOD+8PALel8Ck/VXByfgk8nS7/cMch+j0yMIiS3z3LKnKrsaAveqK8a0b9LK5mHD8R
 JUeeHC/pNKbpIUi0akQf6JyH31MyaxdRQkoZRV8WkCcvGF3C4oKCjUodGer4sp9d7bTg
 3pC22pbdfh8M+1fywz4kPUsBjIbPDBfOox0600We/IBvMv7W9IDagU2bT+7GTPYKcRw2
 F1Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690062266; x=1690667066;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fNV9KjzEsBoviNOMWq+gTDNaJIuDvwgsDMpOIIStNx8=;
 b=gEAYkaCiXzMSG6YADlC0IQit5Q50mxwEPRD28Qglu0+HQfXzBUF7f9WQ24pQS4cRMT
 KmQEDvfJnLxGoXAwFbN8RQxuOgP18ylUPab82ckDZLVv3WELp94vVlNboL8gR7IGTmMA
 4omCLVoh6fPJkmHYFFU+gn7QBkp62yjlOAPKDeV0Vt3/kFZxxPFS8Nf52YGcu5J3m2ZC
 vCvn4IFJ8S9uVQgZ0UHB8evX7wF7KLXdtiCAnErS4xv7FOU+VydCf8XG4es+BLyupbdW
 HA+w3U1HH3QckoqDZR0KoCXJGZMhkyHqECufi0cyXxxqItqeexSIfZw+HqEyNBFT44Yg
 9OYQ==
X-Gm-Message-State: ABy/qLYxlml+6ydMkqLs+XyjnxhNP5R1aVWCPn2knOj4g7X+8pgP30ru
 +8vTuX7U+HilfAMREXZkn+JKFU8hw8pon2W/EJV8gQ==
X-Google-Smtp-Source: APBJJlHhh6UrK0Odvo0F1qf04Ihrd8WlphlH9qcGHkfdUqddx+zdQ2IzXt9wQoypaafBnUvMN9qVRw==
X-Received: by 2002:a05:600c:155:b0:3fc:10:b25b with SMTP id
 w21-20020a05600c015500b003fc0010b25bmr4344821wmm.21.1690062266052; 
 Sat, 22 Jul 2023 14:44:26 -0700 (PDT)
Received: from stoup.acentic.lan
 (179.181-106-213.static.virginmediabusiness.co.uk. [213.106.181.179])
 by smtp.gmail.com with ESMTPSA id
 v22-20020a7bcb56000000b003fbb9339b29sm8846384wmj.42.2023.07.22.14.44.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Jul 2023 14:44:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH for-8.2? v2 4/4] util/interval-tree: Use qatomic_read/set for
 rb_parent_color
Date: Sat, 22 Jul 2023 22:44:22 +0100
Message-Id: <20230722214422.118743-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230722214422.118743-1-richard.henderson@linaro.org>
References: <20230722214422.118743-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32e.google.com
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


