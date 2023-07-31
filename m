Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BDB76A267
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 23:04:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQa20-0000pu-Tq; Mon, 31 Jul 2023 17:02:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qQa1z-0000ol-1L
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 17:02:19 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qQa1x-0006NK-B8
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 17:02:18 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1b9cdef8619so30895025ad.0
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 14:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690837336; x=1691442136;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rB9T/dW/PWoV+QiJ6XYC1bP+RmxJz6XfaOi54UnlvMA=;
 b=TB4xxgkqXFVE2y3+OQQWBOMSvC6igAdqcbDaAFrF2+vTMJJFEHeDcdtOtzjBBmuLYZ
 0ecyHNnbN0Vpf+M+uBO47D6dEUFPvfBXSK3I5fdcl6FPbKs706Eag2juT/7Bj+D83VBp
 VBwxnc0txp33IYuf0zyRuhGsuo/UKNFOGP+9goSIHks598d8ljzAgdhVPkJZfx2Src4T
 XvWH2OsaxfUOIB3q1Q1Vc4KXxPZ/muBjmOgCAYSHpKcR+pHE6pEi/6Sg0Y27oaB4olw3
 YVPHv0v+s8SJiEOlDpPcKKL//jG6YBC2de0zPA+gnSQAfaLXYbb3TUVINp0X+aHhrBMz
 GTIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690837336; x=1691442136;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rB9T/dW/PWoV+QiJ6XYC1bP+RmxJz6XfaOi54UnlvMA=;
 b=MPwkxx0Nqgj+hHYqHEAbcS3T8VlAZ1BXkHH6FLYZf6YyVTvNzzJRYL+Vc+jI/9Nnd6
 TL/w4DebOhFhjhCi+HKQQGo9DB49jrNQGqOjW+xeWBmDETv7oZZqkVU1tMt8BarIm06h
 iE3FnW79PjzkWqBZWdJExESclsO7UEqIRFdB1EoJ/tlXn0VGPwqw24XoLCNItiGVOEgB
 uhuHvQLY20hs0/TJjs17iuu99qkUASyPDOLhgaxaYePFnnFf3l2CZJ89NasWq0k1rQjy
 JoEkDfrRq3XTfnwKxeGLjKs8Q1OuFONPKc3tEEHZBjXNVRS7AtzaRMTYwOSl17042BdH
 x8aA==
X-Gm-Message-State: ABy/qLY6LipHfBZgiktfK8+Xq0zJVHIdvIKXjl66uX1tFMH9y/dZhyy8
 tnb8YaABd+PmkZVlHgTGa/yRiWrOVUUgb2h2uYw=
X-Google-Smtp-Source: APBJJlGwANDNJzM+xbi/j+J4s03Gv5aYEMPivNFxUKH/5vVa2CH1tHhpQITFpVfBNRcpogNu0nkFeQ==
X-Received: by 2002:a17:903:22c6:b0:1b8:41d4:89f with SMTP id
 y6-20020a17090322c600b001b841d4089fmr12322778plg.4.1690837335719; 
 Mon, 31 Jul 2023 14:02:15 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:4f6f:6b:2de4:e0cb])
 by smtp.gmail.com with ESMTPSA id
 r11-20020a1709028bcb00b001bb8895848bsm8924230plo.71.2023.07.31.14.02.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Jul 2023 14:02:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 03/10] util/interval-tree: Introduce pc_parent
Date: Mon, 31 Jul 2023 14:02:04 -0700
Message-Id: <20230731210211.137353-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230731210211.137353-1-richard.henderson@linaro.org>
References: <20230731210211.137353-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 util/interval-tree.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/util/interval-tree.c b/util/interval-tree.c
index 759562db7d..d86c0752db 100644
--- a/util/interval-tree.c
+++ b/util/interval-tree.c
@@ -68,9 +68,14 @@ typedef struct RBAugmentCallbacks {
     void (*rotate)(RBNode *old, RBNode *new);
 } RBAugmentCallbacks;
 
+static inline RBNode *pc_parent(uintptr_t pc)
+{
+    return (RBNode *)(pc & ~1);
+}
+
 static inline RBNode *rb_parent(const RBNode *n)
 {
-    return (RBNode *)(n->rb_parent_color & ~1);
+    return pc_parent(n->rb_parent_color);
 }
 
 static inline RBNode *rb_red_parent(const RBNode *n)
@@ -532,7 +537,7 @@ static void rb_erase_augmented(RBNode *node, RBRoot *root,
          * so as to bypass rb_erase_color() later on.
          */
         pc = node->rb_parent_color;
-        parent = rb_parent(node);
+        parent = pc_parent(pc);
         rb_change_child(node, child, parent, root);
         if (child) {
             child->rb_parent_color = pc;
@@ -544,7 +549,7 @@ static void rb_erase_augmented(RBNode *node, RBRoot *root,
     } else if (!child) {
         /* Still case 1, but this time the child is node->rb_left */
         pc = node->rb_parent_color;
-        parent = rb_parent(node);
+        parent = pc_parent(pc);
         tmp->rb_parent_color = pc;
         rb_change_child(node, tmp, parent, root);
         rebalance = NULL;
@@ -600,7 +605,7 @@ static void rb_erase_augmented(RBNode *node, RBRoot *root,
         rb_set_parent(tmp, successor);
 
         pc = node->rb_parent_color;
-        tmp = rb_parent(node);
+        tmp = pc_parent(pc);
         rb_change_child(node, successor, tmp, root);
 
         if (child2) {
-- 
2.34.1


