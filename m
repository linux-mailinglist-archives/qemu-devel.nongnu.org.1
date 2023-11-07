Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 226817E336F
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:05:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0CO6-0006Lh-U5; Mon, 06 Nov 2023 22:04:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CNz-0006KD-Ld
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:04:16 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CNy-0000dL-0Q
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:04:15 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1cc2575dfc7so37447185ad.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 19:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699326252; x=1699931052; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ez2Z78a8l3Rct3xuqmIfMNHaaKAnGMRqCCq6D0MIJeY=;
 b=gvj2zCXK1VmsMAK/XeXHANcDV5IIea7ZgL5rOnhwLfFVMUGy/sZNloNDAza3RqTFkJ
 KF4UBVcGD0TjKFuswNJj3jpSWwa2yL7dvIKvWAfWTJlk2X5DWF4ozDlq/gYWusi4ed8L
 dmwhiL+VYQanQwGLcclaQC1mw6DkfzSHSPAwyTrjqHk6s134BRJXHavmREhJxMY7ck3K
 ol6ULnl5ucd2BuehyQFF5NUDF436sD4mgITQSvo6lPsqZnZbB86JSfcrrQMlXqGNpGJG
 CNGB2xk1SyuckUfkWvKokxlk2w/TeU1YUyVLDS8o7CRmddwvTCbpPSPrsg8bkq5TO64v
 5JbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699326252; x=1699931052;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ez2Z78a8l3Rct3xuqmIfMNHaaKAnGMRqCCq6D0MIJeY=;
 b=LCZyJ/0f5APl1sqwKu29B6F3rttAb/zGUPe7p3uKSWCH+pyZhDYpphgRqHfZfC4y2a
 IbjXb8RpR8UowVfyNwKxAMmoFca0peIy1bWrCJiJS9NCORzkZ5VEhtdy6+X+2S6fj1Jy
 lAcOLne8MB3loiBGGpavTm8qBsWsWmZJKbRZxArbqNJNc9CP0JTzhGPT0qK3zgV5jeis
 YI3WtlBvyQCMVtfTvzlsRSe9DEWwRll28Uqlg+pL7LGFkwONNiOh0vSXbqufkLMUSWtd
 gEhDJVt3MHRfW+Lu0vadAJKgTJpnZAAOzmZnvRwEcXqENl55qa5aYDCWHR7eMvlOSmi7
 gc5A==
X-Gm-Message-State: AOJu0YyNLshrbhkoSfkG5xoOk1Ch1CDhkDfJQPsBmBTkleUy8npG6kse
 Ad9VAjo486odld7Jnb+RhT/O7SJYm9HXR6BiBB8=
X-Google-Smtp-Source: AGHT+IHlZyPOgq3FAVTJiCUOrPaekDoK8oGURImN7Ps70TqWC5rWnnPC4K/ElWyMHS6u13zQYGpcdQ==
X-Received: by 2002:a17:902:bc42:b0:1ca:87e0:93e3 with SMTP id
 t2-20020a170902bc4200b001ca87e093e3mr26241664plz.7.1699326252642; 
 Mon, 06 Nov 2023 19:04:12 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 u9-20020a17090282c900b001c72d5e16acsm6518012plz.57.2023.11.06.19.04.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 19:04:12 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/85] target/hppa: Split out hppa_flush_tlb_range
Date: Mon,  6 Nov 2023 19:02:47 -0800
Message-Id: <20231107030407.8979-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107030407.8979-1-richard.henderson@linaro.org>
References: <20231107030407.8979-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/mem_helper.c | 39 ++++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index 60cae646cc..828cceb29c 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -67,6 +67,25 @@ static void hppa_flush_tlb_ent(CPUHPPAState *env, HPPATLBEntry *ent,
     ent->itree.start = -1;
 }
 
+static HPPATLBEntry *hppa_flush_tlb_range(CPUHPPAState *env,
+                                          vaddr va_b, vaddr va_e)
+{
+    HPPATLBEntry *empty = NULL;
+
+    /* Zap any old entries covering ADDR; notice empty entries on the way.  */
+    for (int i = HPPA_BTLB_ENTRIES; i < ARRAY_SIZE(env->tlb); ++i) {
+        HPPATLBEntry *ent = &env->tlb[i];
+
+        if (!ent->entry_valid) {
+            empty = ent;
+        } else if (va_e >= ent->itree.start && va_b <= ent->itree.last) {
+            hppa_flush_tlb_ent(env, ent, false);
+            empty = ent;
+        }
+    }
+    return empty;
+}
+
 static HPPATLBEntry *hppa_alloc_tlb_ent(CPUHPPAState *env)
 {
     HPPATLBEntry *ent;
@@ -284,21 +303,11 @@ bool hppa_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
 /* Insert (Insn/Data) TLB Address.  Note this is PA 1.1 only.  */
 void HELPER(itlba)(CPUHPPAState *env, target_ulong addr, target_ureg reg)
 {
-    HPPATLBEntry *empty = NULL;
-    int i;
+    HPPATLBEntry *empty;
 
     /* Zap any old entries covering ADDR; notice empty entries on the way.  */
-    for (i = HPPA_BTLB_ENTRIES; i < ARRAY_SIZE(env->tlb); ++i) {
-        HPPATLBEntry *ent = &env->tlb[i];
-        if (ent->itree.start <= addr && addr <= ent->itree.last) {
-            if (ent->entry_valid) {
-                hppa_flush_tlb_ent(env, ent, false);
-            }
-            if (!empty) {
-                empty = ent;
-            }
-        }
-    }
+    addr &= TARGET_PAGE_MASK;
+    empty = hppa_flush_tlb_range(env, addr, addr + TARGET_PAGE_SIZE - 1);
 
     /* If we didn't see an empty entry, evict one.  */
     if (empty == NULL) {
@@ -306,8 +315,8 @@ void HELPER(itlba)(CPUHPPAState *env, target_ulong addr, target_ureg reg)
     }
 
     /* Note that empty->entry_valid == 0 already.  */
-    empty->itree.start = addr & TARGET_PAGE_MASK;
-    empty->itree.last = empty->itree.start + TARGET_PAGE_SIZE - 1;
+    empty->itree.start = addr;
+    empty->itree.last = addr + TARGET_PAGE_SIZE - 1;
     empty->pa = extract32(reg, 5, 20) << TARGET_PAGE_BITS;
     trace_hppa_tlb_itlba(env, empty, empty->itree.start,
                          empty->itree.last, empty->pa);
-- 
2.34.1


