Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B004B7A2DCD
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 05:38:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhM17-000652-0I; Fri, 15 Sep 2023 23:30:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhM13-00063g-Sl
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 23:30:41 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhM12-00084k-CP
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 23:30:41 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-68fb2e9ebcdso2315167b3a.2
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 20:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694835039; x=1695439839; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UG+6oF1qA9HtR8kn5xL4s+bZVE8kzhMwk4Vv90T+jnY=;
 b=cWJjN9XWqEPTQd6/gQzXDzFEy6Kl1kGvcrwAfyS5lxb8cdgarNSJRP5kXvbTFxb0q3
 3uTVcWv/nnHPTjXrI/pz4FsB53vLhl9/MZ9bIdkGtV/eKa+S388rWsM52OM1Nr+zxhDx
 /8kRl4aYPVjNnYijyIJ8v47ZHIKRWmJgvXKLkK6U4oCypBHJCX2a98wQBNtF7ldswhXL
 pOBgrU5svrzulJwh9cDIyramoHP7FDLdiwBZnFxhHAt3fCOqr99cJE+BuBo/uf3xFdGz
 Kaj21siHPTRbEJDYrFTd6ltdN6zPBdD/Zy2LD8DNwg2/BuKn/wYuYj/O06tljXITEpfV
 xMoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694835039; x=1695439839;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UG+6oF1qA9HtR8kn5xL4s+bZVE8kzhMwk4Vv90T+jnY=;
 b=JGb2GNOHA8XYnPqKBDCwJ7MLtWuDrj/jPkdK5wWeiOPWMF7nN7YpDJTCLLkSLUXmH4
 xzRVkMdRjHWLHw1WDvnjhoU/nfoCFGlhnCuaACHV9mI9mfRs2Ytg93EtOcTwVRmVwHbH
 kLnQvHVikCKlTmoJ5bZclGl7/2CZMgE2nSkwutIBSKtGhQ+HG2ObzpWn5a4YBC4CDeLg
 QbCoVay6sJv6lrDf8CtmbZ2XccIrab19ptbDgdQATz9YqskTv2b7+mMGb0FNOt+PQJQC
 n3Yud38MqFKYe/L/V3Y/TWlUpp7hn9D+l82v+HJaARobEBRzELR2YMoPPNSsvngU9uXR
 lVlQ==
X-Gm-Message-State: AOJu0YzdxPJ9rAe5rBTqRyiWfnQGvNCWGyGamZPZDi7KUKbd2Mcb5l6M
 GkijlBAGFoNjzZIqHZ2E26vYfs3rTAIkrTp8dd0=
X-Google-Smtp-Source: AGHT+IEGNizxxIYmx24Qxf/SlBDpIPe5m53wDHnp0r7+PdF6UPQDaLfDNMIdSk1wxL7/8LXQ7KUnrQ==
X-Received: by 2002:a05:6a00:2484:b0:690:15c7:60c0 with SMTP id
 c4-20020a056a00248400b0069015c760c0mr4037130pfv.19.1694835039078; 
 Fri, 15 Sep 2023 20:30:39 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 j26-20020aa783da000000b00687a4b70d1esm3577320pfn.218.2023.09.15.20.30.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 20:30:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 28/39] accel/tcg: Merge cpu_transaction_failed into io_failed
Date: Fri, 15 Sep 2023 20:30:00 -0700
Message-Id: <20230916033011.479144-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230916033011.479144-1-richard.henderson@linaro.org>
References: <20230916033011.479144-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

Push computation down into the if statements to the point
the data is used.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index fd1b07c5a3..f3635afb36 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1350,23 +1350,6 @@ static inline void cpu_unaligned_access(CPUState *cpu, vaddr addr,
                                           mmu_idx, retaddr);
 }
 
-static inline void cpu_transaction_failed(CPUState *cpu, hwaddr physaddr,
-                                          vaddr addr, unsigned size,
-                                          MMUAccessType access_type,
-                                          int mmu_idx, MemTxAttrs attrs,
-                                          MemTxResult response,
-                                          uintptr_t retaddr)
-{
-    CPUClass *cc = CPU_GET_CLASS(cpu);
-
-    if (!cpu->ignore_memory_transaction_failures &&
-        cc->tcg_ops->do_transaction_failed) {
-        cc->tcg_ops->do_transaction_failed(cpu, physaddr, addr, size,
-                                           access_type, mmu_idx, attrs,
-                                           response, retaddr);
-    }
-}
-
 static MemoryRegionSection *
 io_prepare(hwaddr *out_offset, CPUArchState *env, hwaddr xlat,
            MemTxAttrs attrs, vaddr addr, uintptr_t retaddr)
@@ -1390,9 +1373,19 @@ static void io_failed(CPUArchState *env, CPUTLBEntryFull *full, vaddr addr,
                       unsigned size, MMUAccessType access_type, int mmu_idx,
                       MemTxResult response, uintptr_t retaddr)
 {
-    hwaddr physaddr = full->phys_addr | (addr & ~TARGET_PAGE_MASK);
-    cpu_transaction_failed(env_cpu(env), physaddr, addr, size, access_type,
-                           mmu_idx, full->attrs, response, retaddr);
+    CPUState *cpu = env_cpu(env);
+
+    if (!cpu->ignore_memory_transaction_failures) {
+        CPUClass *cc = CPU_GET_CLASS(cpu);
+
+        if (cc->tcg_ops->do_transaction_failed) {
+            hwaddr physaddr = full->phys_addr | (addr & ~TARGET_PAGE_MASK);
+
+            cc->tcg_ops->do_transaction_failed(cpu, physaddr, addr, size,
+                                               access_type, mmu_idx,
+                                               full->attrs, response, retaddr);
+        }
+    }
 }
 
 static uint64_t io_readx(CPUArchState *env, CPUTLBEntryFull *full,
-- 
2.34.1


