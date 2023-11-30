Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 471EF7FFC8C
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 21:33:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8niT-0007tt-7h; Thu, 30 Nov 2023 15:32:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r8niM-0007s3-Dt
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 15:32:51 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r8niI-0006pS-62
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 15:32:48 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40b27b498c3so14377695e9.0
 for <qemu-devel@nongnu.org>; Thu, 30 Nov 2023 12:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701376364; x=1701981164; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oUiyJ1cB1DIa3M3qVdNbd1jlN4HndUvF2HWNgmV1Wgs=;
 b=R7EKMYTsTlFeqHVzDcITyDCK625tYaYjHsHg51B2H8ho0n4NiZ+3dmlTe0fHQJYDfa
 to5L7In24+X+c+K/lWk9ja37CBKv+6EkIflcodhs9IJaN69zTNJKUWyVYXKIjjcd1wQi
 trkCGeWVTUmVJPi55sNpeGSmdxJe4NKmjrc24QUfYNhZHhwPK2YlstcRgXAq6yNrM6Fg
 8B/UY2CH++JUA0LUsuSx3NRXwYplz4TyRBJLOl3sCKWAKnq/EONOj2I05lT6i3Q8W0hl
 LiJQEjd3Hw4NjmZOmQ3MWb5gqs6QAffBBdN8DlSDEN7RFZuAavNZisJ2Qo9B5xKFbm3F
 k7vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701376364; x=1701981164;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oUiyJ1cB1DIa3M3qVdNbd1jlN4HndUvF2HWNgmV1Wgs=;
 b=bqASBnzjzOkSl1eNoJClKhZ7r1jMnpYSeSDdPwYYUjCgdS2RMuHtCxyf7yqLX7ArXO
 a0oLwidnpFWa6PlV+TH4/JaJ5RxZndjX/lqmTOA8L/wEJUDiyriSWae384X87jj+rfjG
 HQURvclmdivb41XtgMpRGOkS2qtA+xVz2FsZnotkqD3FTt2BgUkNlvusfcOfJQ1x7MEH
 ALyJDQd26wE1C+qlet9Bbssp9/vr1mIfWPm2yxt6ayAFGrENGd30j6c6Pg1TAKeLqZz3
 Y4IqoIHn92WOghczl2SfGDjAnl3z5t3p9QC0nfGDCgJaXZx5zICNvaoMVkEpzrxy5wR7
 jh3w==
X-Gm-Message-State: AOJu0YxCzCS2N7Xu48saalLov8wdj5q5CRRPltzjBHCm6o5yQOzg/Ofd
 VC0Byp0SJhhkfKGtl5Wmja3lJ/NdjYJLdZTbnZTJBQ==
X-Google-Smtp-Source: AGHT+IHHNg8LJsezy57/nBIFRaXoqPdu1dC1d34J3zQisQ7TqfPySEHLv/8zsxQekSy/4lldOdODYQ==
X-Received: by 2002:a5d:638d:0:b0:333:2fd2:5d49 with SMTP id
 p13-20020a5d638d000000b003332fd25d49mr81987wru.123.1701376363823; 
 Thu, 30 Nov 2023 12:32:43 -0800 (PST)
Received: from m1x-phil.lan (sev93-h02-176-184-17-116.dsl.sta.abo.bbox.fr.
 [176.184.17.116]) by smtp.gmail.com with ESMTPSA id
 d9-20020a05600c34c900b0040b2c195523sm6888542wmq.31.2023.11.30.12.32.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 30 Nov 2023 12:32:43 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0] accel/tcg: Remove unused tb_invalidate_phys_addr()
Date: Thu, 30 Nov 2023 21:32:40 +0100
Message-ID: <20231130203241.31099-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Commit e3f7c801f1 introduced the TCGCPUOps::debug_check_breakpoint()
handler, and commit 10c37828b2 "moved breakpoint recognition outside
of translation", so "we no longer need to flush any TBs when changing
BPs".

The last target using tb_invalidate_phys_addr() was converted to the
debug_check_breakpoint(), so this function is now unused. Remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Based-on: <20231130171920.3798954-1-jcmvbkbc@gmail.com>
---
 include/exec/exec-all.h |  5 -----
 cpu-target.c            | 29 -----------------------------
 2 files changed, 34 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index ee90ef122b..df3d93a2e2 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -518,11 +518,6 @@ static inline void tb_set_page_addr1(TranslationBlock *tb,
 uint32_t curr_cflags(CPUState *cpu);
 
 /* TranslationBlock invalidate API */
-#if defined(CONFIG_USER_ONLY)
-void tb_invalidate_phys_addr(hwaddr addr);
-#else
-void tb_invalidate_phys_addr(AddressSpace *as, hwaddr addr, MemTxAttrs attrs);
-#endif
 void tb_phys_invalidate(TranslationBlock *tb, tb_page_addr_t page_addr);
 void tb_invalidate_phys_range(tb_page_addr_t start, tb_page_addr_t last);
 void tb_set_jmp_target(TranslationBlock *tb, int n, uintptr_t addr);
diff --git a/cpu-target.c b/cpu-target.c
index 508013e23d..997ca2e846 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -276,35 +276,6 @@ void list_cpus(void)
 #endif
 }
 
-#if defined(CONFIG_USER_ONLY)
-void tb_invalidate_phys_addr(hwaddr addr)
-{
-    mmap_lock();
-    tb_invalidate_phys_page(addr);
-    mmap_unlock();
-}
-#else
-void tb_invalidate_phys_addr(AddressSpace *as, hwaddr addr, MemTxAttrs attrs)
-{
-    ram_addr_t ram_addr;
-    MemoryRegion *mr;
-    hwaddr l = 1;
-
-    if (!tcg_enabled()) {
-        return;
-    }
-
-    RCU_READ_LOCK_GUARD();
-    mr = address_space_translate(as, addr, &addr, &l, false, attrs);
-    if (!(memory_region_is_ram(mr)
-          || memory_region_is_romd(mr))) {
-        return;
-    }
-    ram_addr = memory_region_get_ram_addr(mr) + addr;
-    tb_invalidate_phys_page(ram_addr);
-}
-#endif
-
 /* enable or disable single step mode. EXCP_DEBUG is returned by the
    CPU loop after each instruction */
 void cpu_single_step(CPUState *cpu, int enabled)
-- 
2.41.0


