Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDF976A266
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 23:04:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQa20-0000p4-IF; Mon, 31 Jul 2023 17:02:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qQa1x-0000ns-ON
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 17:02:17 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qQa1w-0006Me-2L
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 17:02:17 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-686b91c2744so3549453b3a.0
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 14:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690837334; x=1691442134;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MA43mJPR4S1w+5iUDGlCigiGv8RYffvPZ7jW3KkkkqY=;
 b=cnGCnJqqN4OfwiB0PvTjzUO6GXxsNjPqBlL9J8Iy38HrST4Uxez8/EljBqcWQEqyTX
 x6Ci/EReAK8TdaZxilC77JTpudNJ2Qos13ZQkcUsMxDV+6bt6RDcp0tuHLclSXLTzKFG
 PUWed66a8f0pWHkGD3ja4z4Qwb9hKDUQOLJglU0EteoR9oHGowLw/vRiVvNoioTXHHWZ
 OxQ1Ul+GudS8fZta9Z8HrSqUWGy+f8GEMfiPGSBZ3GIV/16mrtAX+vRP9DSVvro0gBMi
 7Ib8WHx1b+IAid8+mT6V11E6IzWKq/+Nm3Bu/VSwCMfIjbHvgA6yGx2K00qAK3HtzlDb
 OfUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690837334; x=1691442134;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MA43mJPR4S1w+5iUDGlCigiGv8RYffvPZ7jW3KkkkqY=;
 b=hfJKVJvYdGAG0qUC9CMgAhbIC5UkJVTjFpRbUXFmFDX+GHt/qSDuHwnzT3ZiKoddTp
 1U7k+ElGsY1HWwPZ6s02/Z0p/QLqASP8nbVP3Hby6akhk/Yz8lcirrqiELBf2L4q4Unv
 uPj45+WkztwjmXU8OAkp6MpNjlP1FGbRf/Uq5oBmHIr2K4/5tW6bSKfAeqkZJMy1uJOG
 fI4VnsiQZN1jFT//X0SRumbOELOhuPylHXhI1t020s0j2f8Wrvy10D/l71oNssOQF7jK
 da6MfKN4o/TB9eX3cHiCddwxAc/802LNb0kpfVyTdXErZalqurpWr+QKK7eHasa6YPeW
 gNSQ==
X-Gm-Message-State: ABy/qLaC2Hqv0hMfrRDDVWBjFJnPc2Wwm22lHslgwW5CbX5pmwMs5pTJ
 FtI46rtaG1DNV59vj/mV0uLV7jnxzJtIWMrfw+4=
X-Google-Smtp-Source: APBJJlGbg/vLA91ladWhdhlW69j0I0y1pO7+QJYhFC/eel7VGl8wNWu4h5drdYZdaYJckGotfd803w==
X-Received: by 2002:a17:90a:de90:b0:267:f5d1:1dd3 with SMTP id
 n16-20020a17090ade9000b00267f5d11dd3mr9408459pjv.11.1690837334647; 
 Mon, 31 Jul 2023 14:02:14 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:4f6f:6b:2de4:e0cb])
 by smtp.gmail.com with ESMTPSA id
 r11-20020a1709028bcb00b001bb8895848bsm8924230plo.71.2023.07.31.14.02.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Jul 2023 14:02:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 02/10] util/interval-tree: Use qatomic_set_mb in rb_link_node
Date: Mon, 31 Jul 2023 14:02:03 -0700
Message-Id: <20230731210211.137353-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230731210211.137353-1-richard.henderson@linaro.org>
References: <20230731210211.137353-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

Ensure that the stores to rb_left and rb_right are complete before
inserting the new node into the tree.  Otherwise a concurrent reader
could see garbage in the new leaf.

Cc: qemu-stable@nongnu.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
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


