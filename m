Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B07D74AEC2
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 12:31:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHija-0006Eh-W8; Fri, 07 Jul 2023 06:30:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHijZ-0006EM-Fe
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 06:30:41 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHijX-0007Qi-Pk
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 06:30:41 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-4fba8f2197bso2734753e87.3
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 03:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688725838; x=1691317838;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9aYAsTwrnIfgMh7N1jotL01ZdurLTw6jZVeOqtLv9YU=;
 b=D5yVXG0BpDk0AxMxiQkmTYN/enXQhrVa1u6tE9azl/JPn4kff6AHNYmr5/UeL273zL
 bUNCNGNohf8XPR9skk2cxW5qmLLNfAJIBHbOdoI6VvBVUtWsscLaXSPFnItYwsB6zh61
 1scM4Mey4bVkDT60s7JIvJGcvORjN58z+hswDQYdEsRffbARWeX8G5ITElJN3YWK8J+I
 g9r0TfL60y5p/jm0lUY93ZAIEs+PwBtd5pkLi/K5hgp856q5UOalE/Do851a3EQMfUIP
 czV3XxLsyo4Kf3HzZEXGZD3LiMaiSHfCo7ZhEAwzmt9sUnCweFuJzNPfL5rUTipdaiCG
 KhdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688725838; x=1691317838;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9aYAsTwrnIfgMh7N1jotL01ZdurLTw6jZVeOqtLv9YU=;
 b=BRcFyEQBdZlbQyBK6TPsUSjNCQ+ViPG57bbIuTW+d7PcL5LxCakehTh/iud1FiScdY
 2X4jATsNB19i3FGmS1iTPCYVj77syk1UViHw22G4yfVGC/f/Es7pJpWQrVaJfzMR/LnZ
 wXzD3C4uwiY69Pnfsq5EU0/O2LbNvn7Gt0BABzmW3ISO9JGsNM7GkddYln3o7QpVOhZT
 P9/HgxTUixmwzQ7HJW2NGar2SBAyS4P1oRwF4rLRpyeFFmTaGXCsjV/jiozifwSeflCr
 tMQAlgLNn13umeBGRArxMvc1AunuBvTyepbs3zgR3Sst4jqn0kB0kxsxZr8vg2LvwgkI
 IPVg==
X-Gm-Message-State: ABy/qLYtARg6Q6JpRnzzVcJYTQ5VJqxDTWgNx6GB0LjeKJmhnUTsHI8j
 x6OH34+n14SNNatF8T3XKL1YpGq3MS1YKV/MeqU=
X-Google-Smtp-Source: APBJJlHtm+IssEO+iljKLNmYi7aF9VxngqqiuWxie3RRo6gA1bYgcGofjFL7gkHWQ8phEM30R7BHUQ==
X-Received: by 2002:ac2:5b1d:0:b0:4f7:6976:2070 with SMTP id
 v29-20020ac25b1d000000b004f769762070mr3513737lfn.40.1688725838234; 
 Fri, 07 Jul 2023 03:30:38 -0700 (PDT)
Received: from stoup.. ([91.223.100.9]) by smtp.gmail.com with ESMTPSA id
 u7-20020ac243c7000000b004fbb2080185sm625103lfl.213.2023.07.07.03.30.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 03:30:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	qemu-stable@nongnu.org
Subject: [PATCH] util/interval-tree: Avoid race conditions without optimization
Date: Fri,  7 Jul 2023 11:30:36 +0100
Message-Id: <20230707103036.5647-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x12e.google.com
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

Read the left and right trees once, so that the gating
tests are meaningful.  This was only a problem at -O0,
where the compiler didn't CSE the two reads.

Cc: qemu-stable@nongnu.org
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 util/interval-tree.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/util/interval-tree.c b/util/interval-tree.c
index 4c0baf108f..31978c32ac 100644
--- a/util/interval-tree.c
+++ b/util/interval-tree.c
@@ -741,12 +741,15 @@ static IntervalTreeNode *interval_tree_subtree_search(IntervalTreeNode *node,
                                                       uint64_t last)
 {
     while (true) {
+        RBNode *rb_tmp;
+
         /*
          * Loop invariant: start <= node->subtree_last
          * (Cond2 is satisfied by one of the subtree nodes)
          */
-        if (node->rb.rb_left) {
-            IntervalTreeNode *left = rb_to_itree(node->rb.rb_left);
+        rb_tmp = node->rb.rb_left;
+        if (rb_tmp) {
+            IntervalTreeNode *left = rb_to_itree(rb_tmp);
 
             if (start <= left->subtree_last) {
                 /*
@@ -765,8 +768,10 @@ static IntervalTreeNode *interval_tree_subtree_search(IntervalTreeNode *node,
             if (start <= node->last) {     /* Cond2 */
                 return node; /* node is leftmost match */
             }
-            if (node->rb.rb_right) {
-                node = rb_to_itree(node->rb.rb_right);
+
+            rb_tmp = node->rb.rb_right;
+            if (rb_tmp) {
+                node = rb_to_itree(rb_tmp);
                 if (start <= node->subtree_last) {
                     continue;
                 }
-- 
2.34.1


