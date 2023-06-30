Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D0B743CC0
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 15:27:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFE4n-0007iY-CK; Fri, 30 Jun 2023 09:22:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFE4k-0007gW-KT
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 09:22:14 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFE4j-0003R6-0D
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 09:22:14 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3141140f51bso2198675f8f.1
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 06:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688131331; x=1690723331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b9o1+scNBHwOltGOMKjLdxQCBRKnxZyx9r5UrOt0WL8=;
 b=rPRb1G6jrKtVeopxrAYnvGkwuDWMl3PwtIcmJT5p0EaMb5dzzWcXb+wndQlQOoT4b/
 xhYz67nrdy/9wb51SV/+cXMp0QH2Eaoz6REsrLOSIkT9lOqvV/2olW/JN/qzNx15b783
 TwVszseDR8aLOytKXuOjrVyrQ9b87dYPzUagkbPGitYFSTPav3DFduad5sCq/cHq98uw
 osszEnVKThXbNEWoWJyixfIR/BjU9Vn5vPlWN+5I94rRr+r9Vnky11QHwta8ojHpppsh
 LmJ0upDyauHnwo8eMjX4aOdudQV+0TljbljWfTlBfVmVb7n/I4/CjZZ0aeFv0biYee6w
 hg4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688131331; x=1690723331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b9o1+scNBHwOltGOMKjLdxQCBRKnxZyx9r5UrOt0WL8=;
 b=CM6qWjEdtCPtWRS+w0p7hbtEhpDtIYwzturBV+daLramdPt2gdg8v9y0C0J0AhUJSs
 Kl2JpfLHY6/ihk2wpvi17tKx8CGlThPs+Y9Lq8yMzZ4+IVevReROhLJoUlo1JXwtlkx/
 Og+btVR6IlWDPZIQtV0UFJorFNuvG7/zvHT+pddX8XrfYAIdA6yG5TUO9YLaEl1jATF3
 BuJbazPvKCjPwnsBd9+y2GTEsa2On10e+ExJipbwP3Zhkrn4P4k0Jayz/liOd2u2dBoR
 hQzOULfBPAWLk1ReIsud4pSZCTIzPsnuwoLQcfak2LSt9jhY3Ryx9f7azrkITTGc86Yv
 jpqg==
X-Gm-Message-State: ABy/qLZ2PxbVnBrRv3g66OYnZRckc6uh9j6G9eezS2xwXs1mRY9H+X9n
 DlwQ3MMhLgcAK8K5rFayg+9h3ukVqPCsN+dtDsbxeg==
X-Google-Smtp-Source: APBJJlExWZaWf9VMkGtjlacsNJvdpbekB8uO7UNuryQJlkf/FUdmr5VqKc67YRTnUi7YM3Q/yh6tAA==
X-Received: by 2002:a5d:6a0b:0:b0:313:e6f3:d05a with SMTP id
 m11-20020a5d6a0b000000b00313e6f3d05amr2088050wru.16.1688131331671; 
 Fri, 30 Jun 2023 06:22:11 -0700 (PDT)
Received: from localhost.localdomain ([139.47.41.96])
 by smtp.gmail.com with ESMTPSA id
 a16-20020adfdd10000000b00313ef2150dcsm14571092wrm.45.2023.06.30.06.22.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 06:22:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mjt@tls.msk.ru,
	laurent@vivier.eu
Subject: [PATCH 14/24] accel/tcg: Introduce page_find_range_empty
Date: Fri, 30 Jun 2023 15:21:49 +0200
Message-Id: <20230630132159.376995-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230630132159.376995-1-richard.henderson@linaro.org>
References: <20230630132159.376995-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x432.google.com
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
index 5b2c230d52..e2195c7e3d 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -235,6 +235,21 @@ int page_check_range(target_ulong start, target_ulong len, int flags);
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
index 25c605dc1b..dee4931f86 100644
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


