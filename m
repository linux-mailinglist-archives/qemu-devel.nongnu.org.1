Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A9175DBEC
	for <lists+qemu-devel@lfdr.de>; Sat, 22 Jul 2023 13:36:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNAtR-000655-68; Sat, 22 Jul 2023 07:35:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNAtL-00062D-UY
 for qemu-devel@nongnu.org; Sat, 22 Jul 2023 07:35:21 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNAtI-0000hm-PA
 for qemu-devel@nongnu.org; Sat, 22 Jul 2023 07:35:19 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3fb4146e8deso25798485e9.0
 for <qemu-devel@nongnu.org>; Sat, 22 Jul 2023 04:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690025709; x=1690630509;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6bjcssZxr7dS2LvruC06Zhi+kFpRW6MiPOiHl1L5fio=;
 b=trBYRYC4hHGNhuO8RKCgYeL8mKYly7pnjYb+ESKHg0nVsasvFOX2TQFb/BujsjGOFT
 KZlwrYd6gXsbnPVIcX+CQFHHqSERBkE4i/jHptexRZ1wS/DX8AaDCudETI4A+qmHL2n8
 q8BLHi+6Bt9XKbYCoBrAAjjCtovl3TPzSrEJQVlwVSJlLHeK/CYkcxhoySLn+RwiGNgy
 sJW3UAMSKTf8wH5JDpcLiuJO/sSNm6sfAWAI35lZ/5/HQoOd551HQ51WpA8y/VKIK780
 GL/96swu8fvUjXf/pEiseaik2hugB7xh036E59tjPukiCM+iqzW0c05yRL+t6GtwFMP6
 f44g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690025709; x=1690630509;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6bjcssZxr7dS2LvruC06Zhi+kFpRW6MiPOiHl1L5fio=;
 b=GBM5G2SCFPIbTAwGSsYjm4wlXN34FiJLyQY8D0CMeN+KYsjbehkbBLnkc3N5Wn3+dY
 MP40c51lOHp7gCzvDQvUIf8mORIoHOgQX+8vn4KH6lopmkSJ9a/aKaYqcxG2ZJejLFkL
 GC9gp8Ok11yoXhgyYfwEji8W/4yZWnVPt5lI3Rcvo1Ce9Mjnjj6PoUXHEu8uuzGeu9uX
 6yh5RxHypuogO/OMK/a+yV0vbRgqCvnZL21aUgq58D7dQ++TaWNqpeObip30jTQVcTf0
 UFbQvkpRTb9a39LUCeaIZaTPY1sY8mhsgpc//j5MrKyEFstSdJArjrJIuAoXIRl19Rzv
 lZwA==
X-Gm-Message-State: ABy/qLajDhE4bHEqoaHfmo50gCZDYvvA/UHMPR9AvidHsig2bOYfjvfi
 DGNmd5LyDzXcazIKzb4RheWRCPWV7kpX4QhaXQRJsw==
X-Google-Smtp-Source: APBJJlEsxKF26tIBUsLD4ZIWWUVaXu+wRfMD007GRtVI8EYs2zugz1wfXLYfco3FzDr6PmOi6GQAHw==
X-Received: by 2002:a05:600c:204:b0:3f9:b748:ff37 with SMTP id
 4-20020a05600c020400b003f9b748ff37mr3569835wmi.20.1690025709510; 
 Sat, 22 Jul 2023 04:35:09 -0700 (PDT)
Received: from stoup.acentic.lan
 (179.181-106-213.static.virginmediabusiness.co.uk. [213.106.181.179])
 by smtp.gmail.com with ESMTPSA id
 y15-20020a7bcd8f000000b003fbdd5d0758sm5130938wmj.22.2023.07.22.04.35.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Jul 2023 04:35:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v2 1/3] include/exec: Add WITH_MMAP_LOCK_GUARD
Date: Sat, 22 Jul 2023 12:35:05 +0100
Message-Id: <20230722113507.78332-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230722113507.78332-1-richard.henderson@linaro.org>
References: <20230722113507.78332-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x332.google.com
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
 include/exec/exec-all.h | 10 ++++++++++
 bsd-user/mmap.c         |  1 +
 linux-user/mmap.c       |  1 +
 3 files changed, 12 insertions(+)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 5fa0687cd2..d02517e95f 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -629,6 +629,15 @@ void TSA_NO_TSA mmap_lock(void);
 void TSA_NO_TSA mmap_unlock(void);
 bool have_mmap_lock(void);
 
+static inline void mmap_unlock_guard(void *unused)
+{
+    mmap_unlock();
+}
+
+#define WITH_MMAP_LOCK_GUARD()                                            \
+    for (int _mmap_lock_iter __attribute__((cleanup(mmap_unlock_guard)))  \
+         = (mmap_lock(), 0); _mmap_lock_iter == 0; _mmap_lock_iter = 1)
+
 /**
  * adjust_signal_pc:
  * @pc: raw pc from the host signal ucontext_t.
@@ -683,6 +692,7 @@ G_NORETURN void cpu_loop_exit_sigbus(CPUState *cpu, target_ulong addr,
 #else
 static inline void mmap_lock(void) {}
 static inline void mmap_unlock(void) {}
+#define WITH_MMAP_LOCK_GUARD()
 
 void tlb_reset_dirty(CPUState *cpu, ram_addr_t start1, ram_addr_t length);
 void tlb_set_dirty(CPUState *cpu, vaddr addr);
diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c
index aca8764356..74ed00b9fe 100644
--- a/bsd-user/mmap.c
+++ b/bsd-user/mmap.c
@@ -32,6 +32,7 @@ void mmap_lock(void)
 
 void mmap_unlock(void)
 {
+    assert(mmap_lock_count > 0);
     if (--mmap_lock_count == 0) {
         pthread_mutex_unlock(&mmap_mutex);
     }
diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 44b53bd446..a5dfb56545 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -36,6 +36,7 @@ void mmap_lock(void)
 
 void mmap_unlock(void)
 {
+    assert(mmap_lock_count > 0);
     if (--mmap_lock_count == 0) {
         pthread_mutex_unlock(&mmap_mutex);
     }
-- 
2.34.1


