Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E71197548F2
	for <lists+qemu-devel@lfdr.de>; Sat, 15 Jul 2023 15:55:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKfjt-0007h1-9t; Sat, 15 Jul 2023 09:55:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKfia-00048W-1n
 for qemu-devel@nongnu.org; Sat, 15 Jul 2023 09:53:59 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKfiU-0001KG-Nk
 for qemu-devel@nongnu.org; Sat, 15 Jul 2023 09:53:49 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3fbc6ab5ff5so25922245e9.1
 for <qemu-devel@nongnu.org>; Sat, 15 Jul 2023 06:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689429225; x=1692021225;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Tw+lHuhQDkl8BHlJVK/TymddlbqOTxzC1UGZ1En8Tes=;
 b=YT9veVfFWibE/mKemkpFQc6aJXt3Nj0Iwh7NxSqb5q5wqXTQZTfgduGblkPLjrAxaa
 nYDo0bRTfCnLQlR2PJdGHn7cQLY/HW8SDFog19O1kuis1fnHcKHfSvqvNiGAuXufp+5L
 M5dB4he5LK3nHSxgEilAnauwgSmGy0CYABqdemQikJyJvnIUwaT8uVuSJgbkH0YU0LY+
 lccC4hRDMgsKI7jY9Y579CRV3fxeYU3EU/BVmSfh46urxa39zqCJar5NrWxQUlQYr3y4
 LEAszEbfJ7Dcm+PibnyTg2dPoH1DK5NcN+Da2c+tl9xYDLquKx2WCzLN3R+mvPiYZVz8
 vOyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689429225; x=1692021225;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tw+lHuhQDkl8BHlJVK/TymddlbqOTxzC1UGZ1En8Tes=;
 b=H0axSSkfDpRu3g6e7BcM/oHllSjyy9maEsNBza9mXR2wasPLxF4he+teNUjOntMjKH
 DPxRToYgQckHc1aUdTtvq9xpul0isFCYiyIXAGsInh5wXTMzL1EahXMCa9GBij1+ct/v
 H6IZZQhs4zMgIRfp1w5uW7nUEzzjZs8JwmEAMBAwDrd/vJTOFgVJERJhxoiRBH14vP70
 UN1B1cccKpqLUOaN4QAG4xCpx+hJMOUQ/xULeq4loifLaRg1x36E6tMISVXSTazvYL1S
 ggy+JM34Myqw/1zQFj4z4YfR57J3fY2wDKuv9KnlhZrj4AA4JBZE2LNQ2m886p4b6yoS
 SwTg==
X-Gm-Message-State: ABy/qLbm2vpZblM3E499IOKHAghKMrPkly2iFuaP+NdvSWvVUbSuz5k5
 gWviBUo1LLKBnXFl1Tj0PUzxsmkcYWJJid7sJJskjA==
X-Google-Smtp-Source: APBJJlEDZTNTdBaY3aN71pQZRP06Wza0w9mzyIo20G4c2INKoC3fXCtkxxaGe3/YpfPXVLO7YOWyCA==
X-Received: by 2002:a05:6000:1c4:b0:314:133a:f04 with SMTP id
 t4-20020a05600001c400b00314133a0f04mr6611871wrx.49.1689429225483; 
 Sat, 15 Jul 2023 06:53:45 -0700 (PDT)
Received: from stoup.lan ([51.219.12.49]) by smtp.gmail.com with ESMTPSA id
 k10-20020a5d66ca000000b00313f9085119sm13838014wrw.113.2023.07.15.06.53.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Jul 2023 06:53:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 33/47] accel/tcg: Introduce page_find_range_empty
Date: Sat, 15 Jul 2023 14:53:03 +0100
Message-Id: <20230715135317.7219-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230715135317.7219-1-richard.henderson@linaro.org>
References: <20230715135317.7219-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x335.google.com
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


