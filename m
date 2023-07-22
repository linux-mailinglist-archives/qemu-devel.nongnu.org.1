Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA2775DEA6
	for <lists+qemu-devel@lfdr.de>; Sat, 22 Jul 2023 23:45:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNKP2-0000JJ-Cr; Sat, 22 Jul 2023 17:44:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNKOx-0000Hw-H7
 for qemu-devel@nongnu.org; Sat, 22 Jul 2023 17:44:35 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNKOp-00033o-UP
 for qemu-devel@nongnu.org; Sat, 22 Jul 2023 17:44:35 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3fbc6ab5ff5so24863615e9.1
 for <qemu-devel@nongnu.org>; Sat, 22 Jul 2023 14:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690062265; x=1690667065;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sf2hbqGSfpDYzrcF3FbPVWShzpIjn+H1soor9634WcY=;
 b=VCmsbwMm/pC5uJgYalCqjoBmRknXJNdWpUOXF1a9Ad5oWyXV9lwji4ZUJyzCNVpJh1
 ktaxM3rAv7ONxjQsPl1Ba6Ia0foHIzcRAKhR/5MZtq1iQKq9Cw0Hoisgzxo/JXqcupqE
 o/6MjE5GJWCeBR5f9Dj5Ammaf6wkt2qSanEmG8j0ZFf7wu5a77KE68+mw2suiUeDT1mX
 Pp7wmIrhXJ2o1VMPJgPIBpCIJjoGV+5o8AuTazLIV3jT5XbtrBRDy2+0iFEXcMNDlVqk
 M6KbKWBibpQGHL02F2wBH2mbeCOysHdeS04IT65OGpV0QzWP79Wh82HIePEUfmDNOMEA
 ALIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690062265; x=1690667065;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sf2hbqGSfpDYzrcF3FbPVWShzpIjn+H1soor9634WcY=;
 b=XFIuUEyynvBxXEEVgAM2wLzn5uIycf+Z7Z4mD6UJoBa0EnZNBxCPNajbHpfgr5MUIg
 oR0F/o5JPlXHLwbuq8WworuuYCoX1VuTub0olXzSSW03NUnuSeKKBRSyoHCgRjCFAJ16
 yhZCgdsCel5bt8KuLWWCfBTfsvWCV70XQrYsG8TwonbsdZv4VRHKpLJ6VsepQpx1WXTZ
 P5O+ByIak37NbgCuLXQ/FZv/1N9s29pD1zL2DMh5zzfiLzlEK2cSkgu67o3PklFaTc1P
 hFj4Vf4A2uk17NLKHX7/JZgV7cAbuYPMhyi8TVybvh+iy8XKkqk8MoLYy63ezLQrPWVo
 PYfw==
X-Gm-Message-State: ABy/qLYpjSIkCnMHEktnn3kmZehwkvoyVFT+rG4yU1oSoVHQUoaAM8lc
 rNXNyffUXgeCRq5wgXD2l9vqpvgNPmTr0ZEPb4/JHw==
X-Google-Smtp-Source: APBJJlEuuDikT2pJiQlXFgHFavPM2qNz+7vucpNbWRone/0NB6AnHa97gwoLAe6/C3oCBcDR4Lom3A==
X-Received: by 2002:a05:600c:2187:b0:3fb:d68d:4c6f with SMTP id
 e7-20020a05600c218700b003fbd68d4c6fmr4341570wme.14.1690062265599; 
 Sat, 22 Jul 2023 14:44:25 -0700 (PDT)
Received: from stoup.acentic.lan
 (179.181-106-213.static.virginmediabusiness.co.uk. [213.106.181.179])
 by smtp.gmail.com with ESMTPSA id
 v22-20020a7bcb56000000b003fbb9339b29sm8846384wmj.42.2023.07.22.14.44.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Jul 2023 14:44:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH for-8.2? v2 3/4] util/interval-tree: Introduce pc_parent
Date: Sat, 22 Jul 2023 22:44:21 +0100
Message-Id: <20230722214422.118743-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230722214422.118743-1-richard.henderson@linaro.org>
References: <20230722214422.118743-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x330.google.com
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


