Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7719875DEA5
	for <lists+qemu-devel@lfdr.de>; Sat, 22 Jul 2023 23:45:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNKOy-0000I7-8g; Sat, 22 Jul 2023 17:44:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNKOw-0000HK-H1
 for qemu-devel@nongnu.org; Sat, 22 Jul 2023 17:44:34 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNKOo-00033F-Ob
 for qemu-devel@nongnu.org; Sat, 22 Jul 2023 17:44:34 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3fbc244d384so25481715e9.0
 for <qemu-devel@nongnu.org>; Sat, 22 Jul 2023 14:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690062265; x=1690667065;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RIXdZdL1FiTxhzgwxu6CqaY5btcznVXT/yw1VVMrSHI=;
 b=M96gN/5DHwpuCZVjhRfoYzlfy4pqbWMZ1ssy3loBVh9cXoaD+nyp8Bga6sH53i74CJ
 IgK7kC215BXga+AJ0psvTBZNPlWf+dnQadMVzv+CT6hrh9OKPfi1TgKj5X+VfjqNNuYf
 cK9lrsVFES8w0HYF32jp9c+Ssdes27tIyDBP4YZLlDQdYjQlO+KonH15fLaqrPRI/i5Q
 2qJ03QL2vJdUphEs60Tb62aaqNG7+SM8uhGjwk4mktaK69buETpJkLTyw/BKtJKe2Daa
 uyUpTWSEpuBSo4niE6H3a8R1ZQKUPoGPFrJwq6QwYQt6ICPvTVsx5DpvlfgqkpULloUW
 BSWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690062265; x=1690667065;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RIXdZdL1FiTxhzgwxu6CqaY5btcznVXT/yw1VVMrSHI=;
 b=g6ah6D0IAdzgVjOTLraX98p51sS642yfGTVRsGwKWrfJNlVfHdqCZtYvb2q8psa/7I
 8bxu6yaa2PEHIpjvTh3fglYArBcFCSmlam6wA7Aok3+viQu6qoUMaNDUfJgWp+7SDGdr
 E9DGpo4wCf43FDg38FmLAEd71+9kcADlBXnavrmyHB2zWjLAP/UPGiN0BUtCo71Pymty
 WmNfPgSIHcAr6F8Lq5u7nFHhuBp8SNjD52AW5qx89oKBmPhZlOKSDEf3tiFwQ1V4Uv8t
 i4YQ0fLW5QfaRaz8V4UDt5jrrQsRs/MOtYClz40BldhTLpFqENm1vseM09bosm/uphvi
 5BIQ==
X-Gm-Message-State: ABy/qLYSJ3DHwKv+hWoa/lXCEY950r5M0QVVklM+a1pqY+/GMoomuNrD
 ix/7EW90BKu1HyR3TNnJcKZxxtwT9uaQKnskSNPxgQ==
X-Google-Smtp-Source: APBJJlGu7nQ5xywulv/CIhLVX3CZPaZbPFRANn4lyLKhfa2hogojc2XxOeB0vUWTHEdpCKY+JWKuXg==
X-Received: by 2002:a7b:cd0c:0:b0:3fc:7d2:e0c0 with SMTP id
 f12-20020a7bcd0c000000b003fc07d2e0c0mr4916595wmj.27.1690062265096; 
 Sat, 22 Jul 2023 14:44:25 -0700 (PDT)
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
Subject: [PATCH for-8.1 v2 2/4] util/interval-tree: Use qatomic_set_mb in
 rb_link_node
Date: Sat, 22 Jul 2023 22:44:20 +0100
Message-Id: <20230722214422.118743-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230722214422.118743-1-richard.henderson@linaro.org>
References: <20230722214422.118743-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Ensure that the stores to rb_left and rb_right are complete before
inserting the new node into the tree.  Otherwise a concurrent reader
could see garbage in the new leaf.

Cc: qemu-stable@nongnu.org
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 util/interval-tree.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/util/interval-tree.c b/util/interval-tree.c
index 5a0ad21b2d..759562db7d 100644
--- a/util/interval-tree.c
+++ b/util/interval-tree.c
@@ -128,7 +128,11 @@ static inline void rb_link_node(RBNode *node, RBNode *parent, RBNode **rb_link)
     node->rb_parent_color = (uintptr_t)parent;
     node->rb_left = node->rb_right = NULL;
 
-    qatomic_set(rb_link, node);
+    /*
+     * Ensure that node is initialized before insertion,
+     * as viewed by a concurrent search.
+     */
+    qatomic_set_mb(rb_link, node);
 }
 
 static RBNode *rb_next(RBNode *node)
-- 
2.34.1


