Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E067FFD26
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 21:57:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8o4w-0007q4-HT; Thu, 30 Nov 2023 15:56:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r8o4u-0007pf-7B
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 15:56:08 -0500
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r8o4s-0002GK-3F
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 15:56:07 -0500
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-50bc8e37b5fso2029282e87.0
 for <qemu-devel@nongnu.org>; Thu, 30 Nov 2023 12:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701377764; x=1701982564; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QTr2rPu2VpCo6RhTJ/nuIiKy4X7g6aQOJ9u1LKnoSgY=;
 b=T1ya5xYcki+/UFBxQXaahK4UUnNGRmXsW9zLWvp/trUtujXeKBsLhuRyLPBI/rwk37
 jKaFOBhfpeGR/h5Ki0QjErdrrerwYmF8TTJ5h3ovTCO+bMD5T2aDH0D7WOsOhEQzMqwS
 Pon2eJWIqBE8HWx5nTjFMF7mjn5Y11aH/4BS5vK5BnRYqim1yKyPJXdUIKDqbp29d0I+
 4niS8x76hsBXmtHoL8UoLdvsar/ryB8K+yDZPv5YkZ+iTDfgNVyIitaqrX6Vo/Sk6Tnq
 fHYFwJe1N2DOvp0eSzqqEbnwUxiPv0GNBt7KWWkXNbGMBOk+PsxyxnkAG4vvLZmkMEQ0
 OUdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701377764; x=1701982564;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QTr2rPu2VpCo6RhTJ/nuIiKy4X7g6aQOJ9u1LKnoSgY=;
 b=HH2DVHre3xvNKBkBUAb+gPQr63D74LweoyozpL1/Exf1srXie4czdOg83iXvl8wg1d
 gwV6wD4AWe0qacV11WbgUXWi7QRxVJZWiTrpN/qFRv8fmCMBtgHI1NHL0/rHHl9TubvM
 sb4LaRCRv91e52A128bDTpCHODpJLB4yvtyQiAnCGM8PeeuIbi2xXDO5KGhoifvgoVin
 lejRCBhr50NOkcz5IpYbRaZo6luVJXXFKFclMLS/anmkWFl4myqZDLSDUjSSaJoYu6Vw
 RnxbPoeYXYeUQiOo3j8jUNjZF5uYMK0CdHm3POnsDnXdyWqXyGJXEPuFFsN1Haj4DI8A
 3gXw==
X-Gm-Message-State: AOJu0YzdgWgmejeg46QHBMl6hIMPybfu9yD2Z2aHl+t1MfjGeVH0mxHs
 PnIlLyOc1l+lwBCip2824rIuFc83BmOG9bQAMtYWfQ==
X-Google-Smtp-Source: AGHT+IEWAXT3YQbdYWe/fJeDKctoIhqKOmfYv6YfLZNfk3dN8TaKl6puIXFnWqhXNkX5LyCXg2sceA==
X-Received: by 2002:ac2:55a6:0:b0:50b:d764:76f1 with SMTP id
 y6-20020ac255a6000000b0050bd76476f1mr85291lfg.128.1701377764127; 
 Thu, 30 Nov 2023 12:56:04 -0800 (PST)
Received: from m1x-phil.lan (sev93-h02-176-184-17-116.dsl.sta.abo.bbox.fr.
 [176.184.17.116]) by smtp.gmail.com with ESMTPSA id
 x5-20020aa7d385000000b0054866f0c1b8sm908659edq.69.2023.11.30.12.56.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 30 Nov 2023 12:56:03 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0] accel/tcg: Remove tb_invalidate_phys_page() from
 system emulation
Date: Thu, 30 Nov 2023 21:56:00 +0100
Message-ID: <20231130205600.35727-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x132.google.com
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

Since previous commit, tb_invalidate_phys_page() is not used
anymore in system emulation. Make it static for user emulation
and remove its public declaration in "exec/translate-all.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Based-on: <20231130203241.31099-1-philmd@linaro.org>
---
 include/exec/translate-all.h |  1 -
 accel/tcg/tb-maint.c         | 24 +-----------------------
 2 files changed, 1 insertion(+), 24 deletions(-)

diff --git a/include/exec/translate-all.h b/include/exec/translate-all.h
index 88602ae8d8..85c9460c7c 100644
--- a/include/exec/translate-all.h
+++ b/include/exec/translate-all.h
@@ -23,7 +23,6 @@
 
 
 /* translate-all.c */
-void tb_invalidate_phys_page(tb_page_addr_t addr);
 void tb_check_watchpoint(CPUState *cpu, uintptr_t retaddr);
 
 #ifdef CONFIG_USER_ONLY
diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index 3d2a896220..da39a43bd8 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -1021,7 +1021,7 @@ void tb_invalidate_phys_range(tb_page_addr_t start, tb_page_addr_t last)
  * Called with mmap_lock held for user-mode emulation
  * NOTE: this function must not be called while a TB is running.
  */
-void tb_invalidate_phys_page(tb_page_addr_t addr)
+static void tb_invalidate_phys_page(tb_page_addr_t addr)
 {
     tb_page_addr_t start, last;
 
@@ -1160,28 +1160,6 @@ tb_invalidate_phys_page_range__locked(struct page_collection *pages,
 #endif
 }
 
-/*
- * Invalidate all TBs which intersect with the target physical
- * address page @addr.
- */
-void tb_invalidate_phys_page(tb_page_addr_t addr)
-{
-    struct page_collection *pages;
-    tb_page_addr_t start, last;
-    PageDesc *p;
-
-    p = page_find(addr >> TARGET_PAGE_BITS);
-    if (p == NULL) {
-        return;
-    }
-
-    start = addr & TARGET_PAGE_MASK;
-    last = addr | ~TARGET_PAGE_MASK;
-    pages = page_collection_lock(start, last);
-    tb_invalidate_phys_page_range__locked(pages, p, start, last, 0);
-    page_collection_unlock(pages);
-}
-
 /*
  * Invalidate all TBs which intersect with the target physical address range
  * [start;last]. NOTE: start and end may refer to *different* physical pages.
-- 
2.41.0


