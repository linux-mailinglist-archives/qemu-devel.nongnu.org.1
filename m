Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 41707783D04
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 11:38:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYNpY-0000VR-LC; Tue, 22 Aug 2023 05:37:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYNpX-0000VH-4Z
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 05:37:43 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYNpU-0001iB-U5
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 05:37:42 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3fee843b44cso24864605e9.1
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 02:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692697059; x=1693301859;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B+OXb740KGUXF3OHqmG1MiP4vOFoMPudT9ZeJkwj3l8=;
 b=I8gLh+KMwphLr2Kx8qM3HiGiSZEV+yOXZcRYLMsdiUHLLVnSI3GEloGwgZSsgcNm29
 juvyna1WfJJeOsmpnogb4/sqDgXRDSlBhyA2Jgoigii15sE/HKC/9Zk+jiLH6HbRFcyq
 TfHCni3lS88x1kuadgBNTkrCx1eYPz/EADyd0EYW+3rkSRshwgATnqOHEgoBXspBfIAo
 Zwx4OgZOHV1wIv9tG6xcIAhDZrmoX+le7FmhZ8HhP9czy1NRX4AwJ9aacWlGJRFjUoGq
 q5kNUo5Emz9+t/zlNo+sQ/j82g7SvtBu+9soY6jpQbxznx9GDV8VbITbZ6T1q/EwIKFo
 FTdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692697059; x=1693301859;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B+OXb740KGUXF3OHqmG1MiP4vOFoMPudT9ZeJkwj3l8=;
 b=I0bIq7mXhD78riKCGYYhV5Ab6j7UfJZHKR5f6FZzwtc/5CiL/gFD/37d6R9ne+zYc7
 eEE2hWYaUdSdme3d18dTTnTbUns1eGh4iY5eFoMqn+CKMXlPqAMA4bmjXTXkgQADzObo
 OgGBfNq6YWA1UVC+6N+tc9uVZSPOl/O7rd+aTHDvg1KVNtDgiSfRnl+94W/XHbEHoOMb
 W9i4otLiYcsPYJILrm8DvLc+/IRrO7rue1S7hSNh8RnQ3Ap6pbybPA71q8ZJf9Jm8ovx
 ROhrR4wGMJhyPeaHfgxuFvZSXIZdAOerBBbFsnH1Ec3qIqykNtDnYwnQe9aD9UKy7lTZ
 wj2g==
X-Gm-Message-State: AOJu0Ywvl9TQOv9p57wIALzW0DE2YrvRFYqF52iWPFbRSYsXXNbr994w
 ONOqRYalrSJkayeYmLIOR+be+xXRmNdgaa+xeU2uNQ==
X-Google-Smtp-Source: AGHT+IGsi9FUWOKNPtxpZMXetQz1+WpOHf4S5QyG11jR82YLn2Fx+W9KydwLDV+6DJpIxkhnu0w2rg==
X-Received: by 2002:a5d:628e:0:b0:31a:e06f:2187 with SMTP id
 k14-20020a5d628e000000b0031ae06f2187mr6418668wru.56.1692697059362; 
 Tue, 22 Aug 2023 02:37:39 -0700 (PDT)
Received: from localhost.localdomain ([37.19.214.4])
 by smtp.gmail.com with ESMTPSA id
 a8-20020adfed08000000b003196dba130asm15266442wro.106.2023.08.22.02.37.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Aug 2023 02:37:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/7] tcg/tcg-op: Document hswap() byte pattern
Date: Tue, 22 Aug 2023 11:37:09 +0200
Message-ID: <20230822093712.38922-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230822093712.38922-1-philmd@linaro.org>
References: <20230822093712.38922-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Document hswap_i32() and hswap_i64(), added in commit
46be8425ff ("tcg: Implement tcg_gen_{h,w}swap_{i32,i64}").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/devel/tcg-ops.rst |  4 ++++
 tcg/tcg-op.c           | 26 +++++++++++++++++++-------
 2 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index 6a166c5665..d9364effd2 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -486,6 +486,10 @@ Misc
          into 32-bit output *t0*.  Depending on the host, this may be a simple shift,
          or may require additional canonicalization.
 
+   * - hswap_i32/i64 *t0*, *t1*
+
+     - | Swap 16-bit halfwords within a 32/64-bit value.
+
 
 Conditional moves
 -----------------
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index f4fe13e040..bb64326a1a 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1091,6 +1091,11 @@ void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg)
     }
 }
 
+/*
+ * hswap_i32: Swap 16-bit halfwords within a 32-bit value.
+ *
+ * Byte pattern:  hswap_i32(abcd) -> cdab
+ */
 void tcg_gen_hswap_i32(TCGv_i32 ret, TCGv_i32 arg)
 {
     /* Swapping 2 16-bit elements is a rotate. */
@@ -1878,19 +1883,26 @@ void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
+/*
+ * hswap_i64: Swap 16-bit halfwords within a 64-bit value.
+ *
+ * See hswap64() in include/qemu/bitops.h
+ *
+ * Byte pattern:  hswap_i64(abcdefgh) -> ghefcdab
+ */
 void tcg_gen_hswap_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
     uint64_t m = 0x0000ffff0000ffffull;
     TCGv_i64 t0 = tcg_temp_ebb_new_i64();
     TCGv_i64 t1 = tcg_temp_ebb_new_i64();
 
-    /* See include/qemu/bitops.h, hswap64. */
-    tcg_gen_rotli_i64(t1, arg, 32);
-    tcg_gen_andi_i64(t0, t1, m);
-    tcg_gen_shli_i64(t0, t0, 16);
-    tcg_gen_shri_i64(t1, t1, 16);
-    tcg_gen_andi_i64(t1, t1, m);
-    tcg_gen_or_i64(ret, t0, t1);
+                                        /* arg = abcdefgh */
+    tcg_gen_rotli_i64(t1, arg, 32);     /*  t1 = efghabcd */
+    tcg_gen_andi_i64(t0, t1, m);        /*  t0 = ..gh..cd */
+    tcg_gen_shli_i64(t0, t0, 16);       /*  t0 = gh..cd.. */
+    tcg_gen_shri_i64(t1, t1, 16);       /*  t1 = ..efghab */
+    tcg_gen_andi_i64(t1, t1, m);        /*  t1 = ..ef..ab */
+    tcg_gen_or_i64(ret, t0, t1);        /* ret = ghefcdab */
 
     tcg_temp_free_i64(t0);
     tcg_temp_free_i64(t1);
-- 
2.41.0


