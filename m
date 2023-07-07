Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 372AC74B844
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 22:45:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHsGa-0004zN-IZ; Fri, 07 Jul 2023 16:41:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHsGM-0004o1-2t
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 16:41:10 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHsGK-0004kr-3Y
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 16:41:09 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3fb4146e8deso29580435e9.0
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 13:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688762466; x=1691354466;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BvCmbIPrY85Qj0xJIhdk6WMERPf4zDCfB4ii0LMHB14=;
 b=KLl+5beIy5d/Or79p7wL2ZUINOf8is3PBYA1CgLVbX+AS5FlnzP9OO9QBnPUm0TLsM
 /atE6H0yS4rBywUY0vpiHkyzALSCCex2PCGiwFz5PEO3UhtTK8LhZLEC26aqLgBe4w73
 ErLGZy7xZnlTVuuuFfutUk3RkZ2rXQkKjv3KpVQH0uFN7QVPdQwaQFFBrpvtLABQgmjk
 77dIZbOezX6aopsoNfwKJzCpDMKURN956yXvj+wPS7jA9Bvx6jlVoCa1lVYHrT8PWPqp
 Aka35xs315wCd7/oRRWRQbc2D5W8m/XWPF9dVL7DDruFydeNwjkYZ/GIJNzwJ4gRpVAu
 mU3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688762466; x=1691354466;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BvCmbIPrY85Qj0xJIhdk6WMERPf4zDCfB4ii0LMHB14=;
 b=AITctq2Wq31+M/c/CvXM38/5HCBGUzaAN7nKGxFu8w9/A0VFOaIid+/gOsNFT7QWIw
 T3lI6a4q/fFpSCN8TGBYUYZIxIyIKNQ35BDRlE+LOLUnKLv0+8onF9QXLRRizLXWglDn
 a1BXHR/soasuJv213k1GXKWjwIF/ZhOr6GV4aGY2ymQBeu+KQnz9YkNIjUg48Ygvbujj
 AqW4k3x0FJ5rkFlJxEORG7cJT2SzwBmxXrPGSgDHuqmiczPOU2rfGKBq1yHMzRcfoO7E
 sORcjZj1PbHx4L/PzZG1hTyZ2Kr6OdSFCbOb8FPH8LVQ5o/I/at8dHIW5f4MXOz9XbUP
 q76Q==
X-Gm-Message-State: ABy/qLbBS0W+R4Oi8CShL+tMTk3Yif/QeLHSFH9Pe/+4CkiSRianVSHw
 XliB32+4ueVhbCKORTTdqJKmBQ8IuawNaVgUAHvKqw==
X-Google-Smtp-Source: APBJJlGbbI68PI1rSUrXb5VTDrX5sjaaulFGfSSQdlFsZTy1N/M1zDbpBpsqGkdvxscrIJmSBFRx9w==
X-Received: by 2002:a1c:4c08:0:b0:3fa:935e:e185 with SMTP id
 z8-20020a1c4c08000000b003fa935ee185mr6638470wmf.22.1688762466658; 
 Fri, 07 Jul 2023 13:41:06 -0700 (PDT)
Received: from localhost.localdomain (host-92-23-208-66.as13285.net.
 [92.23.208.66]) by smtp.gmail.com with ESMTPSA id
 q10-20020a1ce90a000000b003fbb25da65bsm3337736wmc.30.2023.07.07.13.41.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 13:41:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	mjt@tls.msk.ru
Subject: [PATCH v2 14/24] accel/tcg: Introduce page_find_range_empty
Date: Fri,  7 Jul 2023 21:40:44 +0100
Message-Id: <20230707204054.8792-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230707204054.8792-1-richard.henderson@linaro.org>
References: <20230707204054.8792-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32b.google.com
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


