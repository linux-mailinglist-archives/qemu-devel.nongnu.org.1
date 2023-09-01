Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE0578F70B
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 04:25:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbtpf-0007iF-8Z; Thu, 31 Aug 2023 22:24:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbtpZ-0007Aw-M7
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 22:24:17 -0400
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbtpJ-0001St-VQ
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 22:24:13 -0400
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-1c26bb27feeso960863fac.0
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 19:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693535035; x=1694139835; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v2oMFltgopchvkCHTnrNxCsJsKx6S/nBlH+XZvf6iJQ=;
 b=uQAacoMe2WjDYLW0a/J/nKVA7w/hLcOTOn6aS9DCQ5TJB+VvahbbScmhjVUXXA7Dpn
 cnspQc+B18oKBa343SW4kMEu3C+SrvIBa+uWYDUpmUj3gJ6tp99n400BzHcrKYYyWd2T
 l9CvXQysmkX2i6elqlfThbFG4KnOzhIvoxe+JKqAhvgg8a5mbxrCO2CI5oo4uCN5UIfI
 P0Xp4/sfqxN20/QuSfM3TAe2wQnH91yzBFp9iR69nnpz+eqEYE7AMZqCOl2ZcNSNdZPD
 GyB9t7OVuFZ+V/Fz1qde/+2pl/m2yDH9/jpwNeJv1VXMemzRghv+ipEiZQhAWz0HTqBt
 eF9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693535035; x=1694139835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v2oMFltgopchvkCHTnrNxCsJsKx6S/nBlH+XZvf6iJQ=;
 b=dzxa+Vxo6OVKuCf7gYoSSf1xOjvXG1tGpTwEMF0Vt14VupbQoDqwyYJE6xjDZvHcYj
 /4EeAz6Nspa/XS0Wem+KHfd0bPctvA+G0PG9bT8LSy8Y5joqTihcjkiwdPa8N+jXRKQc
 P5yz7Z85jmO/Gy2xjncPK/aelDwUwHYKhHgHGK31zRmMoDBddwca5RUbtjuvr/XDhKx6
 IhDg+Bp86AjnbkQAaav5tQ3hw3lZie24Y9jdCVTkV42zZb0tgGhczZM2H5t4PPGwrjGZ
 4b9VOjVl9z25l61kSVtyQ8Fp8luEBxy9RE2V/T2qLUI1di0yfgqki9xc3hQTzJnm1t1R
 Yh9w==
X-Gm-Message-State: AOJu0Yw6+ZF0kqUu1cTbJ1MVQGG1AIJ3yuOew/7pODt16RdCElsGQCX5
 AtuG8BJ5Kyvc1ia2SXImb4GIQvh2Le26Ek0yD5U=
X-Google-Smtp-Source: AGHT+IFRkdGSIfCJdhpgv8TZpIfA6N04ObBj2uDDZG0hEfsCmeGVdA+gAB1wc/mJMb1SCOEf9G0mMw==
X-Received: by 2002:a05:6870:7021:b0:1b4:4a2e:33f1 with SMTP id
 u33-20020a056870702100b001b44a2e33f1mr1523556oae.29.1693535035472; 
 Thu, 31 Aug 2023 19:23:55 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 c25-20020aa781d9000000b0068a54866ca8sm1906977pfn.134.2023.08.31.19.23.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 19:23:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, alex.bennee@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 28/33] accel/tcg: Disconnect TargetPageDataNode from page
 size
Date: Thu, 31 Aug 2023 19:23:26 -0700
Message-Id: <20230901022331.115247-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230901022331.115247-1-richard.henderson@linaro.org>
References: <20230901022331.115247-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::36;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x36.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


