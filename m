Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D7073E3E2
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 17:48:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDoKi-0001KI-4T; Mon, 26 Jun 2023 11:40:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDoK0-0000L7-1V
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 11:40:08 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDoJx-0002t7-19
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 11:40:07 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-313e2fdd186so2812430f8f.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 08:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687793999; x=1690385999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LYf1gmlgoP191xGrWH4MvF7u3DHHhcwq16njodVFQaw=;
 b=nPbXq6i5N5ZwztsR2I9R2LcD/yRBBQQaBFnxKNKVlOPrzKtmvoTcYdQZVep2lFTcZD
 dx0brrowbNXXgpbN2KP+aII4wTVfA8UcyEUZKr54plKILRFJu+6hcE8mon7d4X+ExRhJ
 OlsVB6rpeQQ+EwXQGpKIhA/xracjFZRt7KlMoVG0wZ0DHwB+rIG80dmVux49hzgGmvVj
 JN1C0FFF65MyAj30Nu38KtfdeScIfYnCuxsU89JaWKfzxRAEcKDPEoBZ91oyDUvp0Uvi
 7/h37uwCzZJd10gcet6KdOdKOIscIFT/KMxWlwIMVxImlklz1U9TgRp8E6hTCypgn5k3
 WyCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687793999; x=1690385999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LYf1gmlgoP191xGrWH4MvF7u3DHHhcwq16njodVFQaw=;
 b=ILejNGLaQB+OJx+ACSb7Yjyv6SQEDCI+V32VvSIhW0L8ma8UYLeMkslSv26oPU1BG3
 UrcGss0fU6oNBUf1pAaRlDZ5/JdeaafvAjXt6i6eYv2cgeJKx6ruC2r04+Wg9qi9UsM2
 vgpNkEzfUaPVBHsSvL7Nii/sXZiHrAPRkW2YWlPiojMZSMpQg/5WTjNon2YaiynhchpJ
 YXFoj6ZB64KbOr8cLTcQlBqczf0Iwnjf15yjrpyndu7/4xFYh3hIf/T8S6LBe3AMOqre
 3laSaswxvRqKZFv5tvT2ydpNo5ewvDLZTr1QaP83FumR6MFfcu9C/xkOVz1ic5ZWSw+4
 5/5A==
X-Gm-Message-State: AC+VfDwzsZUTIu4jg7uqGYXC0PTxnGXruTyonsZopZH/uBFz6VDfQhbU
 DZAbcDmmtN7Ju8CNDwya0PEsM4eMZkIMKAcZJzNgGgu6
X-Google-Smtp-Source: ACHHUZ7f1ZnP5ICDMVPfaZrGL8xv8GbTUHthLpNordI44izOFB9HZTDIXYa+3GQ7TE8F6/bPK4Fhmw==
X-Received: by 2002:a5d:5612:0:b0:313:f505:8211 with SMTP id
 l18-20020a5d5612000000b00313f5058211mr1460128wrv.46.1687793999771; 
 Mon, 26 Jun 2023 08:39:59 -0700 (PDT)
Received: from localhost.localdomain ([139.47.42.170])
 by smtp.gmail.com with ESMTPSA id
 t1-20020adfe441000000b00313f45f74a8sm2164178wrm.103.2023.06.26.08.39.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 08:39:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 21/22] accel/tcg: Move TLB_WATCHPOINT to TLB_SLOW_FLAGS_MASK
Date: Mon, 26 Jun 2023 17:39:44 +0200
Message-Id: <20230626153945.76180-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230626153945.76180-1-richard.henderson@linaro.org>
References: <20230626153945.76180-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x429.google.com
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

This frees up one bit of the primary tlb flags without
impacting the TLB_NOTDIRTY logic.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h |  8 ++++----
 accel/tcg/cputlb.c     | 18 ++++++++++++++----
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 4422f4bb07..b5618613cc 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -325,8 +325,6 @@ CPUArchState *cpu_copy(CPUArchState *env);
 #define TLB_NOTDIRTY        (1 << (TARGET_PAGE_BITS_MIN - 2))
 /* Set if TLB entry is an IO callback.  */
 #define TLB_MMIO            (1 << (TARGET_PAGE_BITS_MIN - 3))
-/* Set if TLB entry contains a watchpoint.  */
-#define TLB_WATCHPOINT      (1 << (TARGET_PAGE_BITS_MIN - 4))
 /* Set if the slow path must be used; more flags in CPUTLBEntryFull. */
 #define TLB_FORCE_SLOW      (1 << (TARGET_PAGE_BITS_MIN - 5))
 /* Set if TLB entry writes ignored.  */
@@ -338,7 +336,7 @@ CPUArchState *cpu_copy(CPUArchState *env);
  */
 #define TLB_FLAGS_MASK \
     (TLB_INVALID_MASK | TLB_NOTDIRTY | TLB_MMIO \
-    | TLB_WATCHPOINT | TLB_FORCE_SLOW | TLB_DISCARD_WRITE)
+    | TLB_FORCE_SLOW | TLB_DISCARD_WRITE)
 
 /*
  * Flags stored in CPUTLBEntryFull.slow_flags[x].
@@ -346,8 +344,10 @@ CPUArchState *cpu_copy(CPUArchState *env);
  */
 /* Set if TLB entry requires byte swap.  */
 #define TLB_BSWAP            (1 << 0)
+/* Set if TLB entry contains a watchpoint.  */
+#define TLB_WATCHPOINT       (1 << 1)
 
-#define TLB_SLOW_FLAGS_MASK  TLB_BSWAP
+#define TLB_SLOW_FLAGS_MASK  (TLB_BSWAP | TLB_WATCHPOINT)
 
 /* The two sets of flags must not overlap. */
 QEMU_BUILD_BUG_ON(TLB_FLAGS_MASK & TLB_SLOW_FLAGS_MASK);
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 3671846744..5b51eff5a4 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1981,7 +1981,7 @@ static void *atomic_mmu_lookup(CPUArchState *env, vaddr addr, MemOpIdx oi,
          */
         goto stop_the_world;
     }
-    /* Collect TLB_WATCHPOINT for read. */
+    /* Collect tlb flags for read. */
     tlb_addr |= tlbe->addr_read;
 
     /* Notice an IO access or a needs-MMU-lookup access */
@@ -1998,9 +1998,19 @@ static void *atomic_mmu_lookup(CPUArchState *env, vaddr addr, MemOpIdx oi,
         notdirty_write(env_cpu(env), addr, size, full, retaddr);
     }
 
-    if (unlikely(tlb_addr & TLB_WATCHPOINT)) {
-        cpu_check_watchpoint(env_cpu(env), addr, size, full->attrs,
-                             BP_MEM_READ | BP_MEM_WRITE, retaddr);
+    if (unlikely(tlb_addr & TLB_FORCE_SLOW)) {
+        int wp_flags = 0;
+
+        if (full->slow_flags[MMU_DATA_STORE] & TLB_WATCHPOINT) {
+            wp_flags |= BP_MEM_WRITE;
+        }
+        if (full->slow_flags[MMU_DATA_LOAD] & TLB_WATCHPOINT) {
+            wp_flags |= BP_MEM_READ;
+        }
+        if (wp_flags) {
+            cpu_check_watchpoint(env_cpu(env), addr, size,
+                                 full->attrs, wp_flags, retaddr);
+        }
     }
 
     return hostaddr;
-- 
2.34.1


