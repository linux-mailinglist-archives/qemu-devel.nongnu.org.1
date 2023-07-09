Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 128D374C75A
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 20:43:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIZEE-00055q-76; Sun, 09 Jul 2023 14:33:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZDz-0003aB-OB
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:33:35 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZDx-0004Gl-6F
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:33:35 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-31441dfbf97so4314267f8f.1
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 11:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688927612; x=1691519612;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tw+lHuhQDkl8BHlJVK/TymddlbqOTxzC1UGZ1En8Tes=;
 b=UvYjNgBIl4rFgkHQ+ucXCccsdPHZvz0zzQ2m2UAxjRcoK4Pq7/Zk5hOFe7HF5NEDl/
 F3wIF5YLkaoMC9zrWhYcZpz+8tTXtEf2BV9S78J/905R+6PvsxI0duzG+DdKEJZFLXWF
 BZVpS1xTwzPsV6XlXh1RFREbB4VFm5viAZPwpe1d+HSa6QIA3nLKnU1bNkqC6eAjEj6p
 Z9OUmjB0y6+huTFxGssMdRy+dIgMaGUHZu0GNoJs9p+Tx3KLuvuNO2YQEmT+jVkk7JIt
 SStiweAv69RwjczpvEx+ELjacjmYAnNYgR0WSycwpaXzdc+9QYzEl1jo4uO75dNeU7YG
 CWrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688927612; x=1691519612;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tw+lHuhQDkl8BHlJVK/TymddlbqOTxzC1UGZ1En8Tes=;
 b=RBOw+trl9O2ZC/mqFS/UYYW+4h1kipIsS7P4rdh87co/6o12IQPLYV+V9PWyNNuBVF
 4ly7V/6bjO7+z+wd9ZOPP5Hs0PQz258F123YoJa9cdtuUzhvjAnAjIxscuyqM9omsZ+I
 R66xuw8xBVosZ6jkXxRwymv/xP4kRb4lK/ApelDzfKxVq/lNNHGK4Pqef9QjYBui7pI9
 FUHVxuq7j2rXnu+pII0CrnxtsZVHuTh0vlSWXjlLjNLqUTb7aVzeVkKbejEHh32Yc4+8
 IG8p0fTwW1lnwpg+eKWhe7X5coxQfrRmRgVif0Ljn2eJPZB+mQa+jD3iN5oulRiGV4eH
 OGXQ==
X-Gm-Message-State: ABy/qLbVazWtewG4mIX2znqAt+pyBheyuBV0G2+6SgG++t+XKuGhXscI
 Ze2SXfmk23/mynNc4Q92i4QWerCtl0L7LDUeYyCN9Q==
X-Google-Smtp-Source: APBJJlEFoi90emDeeLOqJVQ6LxOJepZtEw6jNVk2SiusMa1BytxWIIm5VlySZxeUb0r4hLwuSYaiTg==
X-Received: by 2002:adf:ec90:0:b0:314:545f:6e94 with SMTP id
 z16-20020adfec90000000b00314545f6e94mr9968414wrn.65.1688927611853; 
 Sun, 09 Jul 2023 11:33:31 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 e17-20020a5d4e91000000b0031433760a92sm9635256wru.115.2023.07.09.11.33.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 11:33:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu
Subject: [PATCH 33/45] accel/tcg: Introduce page_find_range_empty
Date: Sun,  9 Jul 2023 19:29:17 +0100
Message-Id: <20230709182934.309468-66-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230709182934.309468-1-richard.henderson@linaro.org>
References: <20230709182934.309468-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x435.google.com
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

Use the interval tree to locate an unused range in the VM.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230707204054.8792-17-richard.henderson@linaro.org>
---
 include/exec/cpu-all.h | 15 +++++++++++++++
 accel/tcg/user-exec.c  | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 94f828b109..eb1c54701a 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -236,6 +236,21 @@ int page_check_range(target_ulong start, target_ulong len, int flags);
  */
 bool page_check_range_empty(target_ulong start, target_ulong last);
 
+/**
+ * page_find_range_empty
+ * @min: first byte of search range
+ * @max: last byte of search range
+ * @len: size of the hole required
+ * @align: alignment of the hole required (power of 2)
+ *
+ * If there is a range [x, x+@len) within [@min, @max] such that
+ * x % @align == 0, then return x.  Otherwise return -1.
+ * The memory lock must be held, as the caller will want to ensure
+ * the returned range stays empty until a new mapping can be installed.
+ */
+target_ulong page_find_range_empty(target_ulong min, target_ulong max,
+                                   target_ulong len, target_ulong align);
+
 /**
  * page_get_target_data(address)
  * @address: guest virtual address
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index ab684a3ea2..e4f9563730 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -605,6 +605,47 @@ bool page_check_range_empty(target_ulong start, target_ulong last)
     return pageflags_find(start, last) == NULL;
 }
 
+target_ulong page_find_range_empty(target_ulong min, target_ulong max,
+                                   target_ulong len, target_ulong align)
+{
+    target_ulong len_m1, align_m1;
+
+    assert(min <= max);
+    assert(max <= GUEST_ADDR_MAX);
+    assert(len != 0);
+    assert(is_power_of_2(align));
+    assert_memory_lock();
+
+    len_m1 = len - 1;
+    align_m1 = align - 1;
+
+    /* Iteratively narrow the search region. */
+    while (1) {
+        PageFlagsNode *p;
+
+        /* Align min and double-check there's enough space remaining. */
+        min = (min + align_m1) & ~align_m1;
+        if (min > max) {
+            return -1;
+        }
+        if (len_m1 > max - min) {
+            return -1;
+        }
+
+        p = pageflags_find(min, min + len_m1);
+        if (p == NULL) {
+            /* Found! */
+            return min;
+        }
+        if (max <= p->itree.last) {
+            /* Existing allocation fills the remainder of the search region. */
+            return -1;
+        }
+        /* Skip across existing allocation. */
+        min = p->itree.last + 1;
+    }
+}
+
 void page_protect(tb_page_addr_t address)
 {
     PageFlagsNode *p;
-- 
2.34.1


