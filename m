Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E74FBA99D9B
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Apr 2025 03:04:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kuR-000729-61; Wed, 23 Apr 2025 20:57:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7ktO-0005j7-Ew
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:56:45 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7ktM-00054f-JR
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:56:42 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7399838db7fso512430b3a.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745456199; x=1746060999; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CTmftL2su6jwrf+15dG9AUJcmzSAFqQvTSHtk/3sj+U=;
 b=aOxC22Dd8SelhKyI65+o2hdZ7EQd8YhSoc61NQwndmV/+GVHR1kkpf8DnNAEd2P6pp
 8kjxPCtCRsoHVVhR/OiwfSUSTl5H6ll8R1aKSg5gRKN+zg/JvWN7Xd5ETZmo0taGDEL3
 tIullLoQMJMHeMbBX4SlWfsZuNtG9ObLA93x/3SDat0z1fOy+IlxFeQhL7xkE27O78nC
 iZV8OnfPCk4vKc4+td8wHHJIKOGYpIMbCDbem8Coh9f+GA8Y+IHtoeI/smVnNbuqWqpl
 0gk/LXTxVbhjdj51LC5k4h+OYJhVkacH6mHSQKCDJpxz+HvfIRvYSC/BWBzifQmmlpOz
 z14A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745456199; x=1746060999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CTmftL2su6jwrf+15dG9AUJcmzSAFqQvTSHtk/3sj+U=;
 b=WjSwI9Hx8yUAbTTtAa8CebQf2eKRTgkBROOdmULHrugf7t/uWrzYljt7tD0KHUbyjg
 J2IkpuFRhibN5ZKnwt5991svCnpwI47/WhK4Q0v4yAnzq3w0w3jXbLDbvhe7CuYvJ4Y7
 D0dPqie4hpSm0ijxOFcEMT5mDy9bFf8VBUNebOLtdfpm9K2K/t2cBJkVixHT6BtVBNyR
 kiVUt+FugMe5xrufK1jtDfbza/KicZO0G3qq21dtrEugcNNTIRw5p/O3P/avX9Xk+1nc
 nhdY3lm7CaxMvtktWoorVpCESGcSbOmtBiI9l5jF2GIju0wfUlADWOMwtwlQCsROJ5r/
 wm5g==
X-Gm-Message-State: AOJu0YxaY454lzfgD437Xw8cJhJZR50ElgRE/VGRIlml9bY+kA2Nq4bM
 WdCisgwgXd44pa+ugbDKY5Y+h+ZLruzW7VbZmAZ+CVxkw9v5PgpF9PC+S62ZwZ2/qHoYZsxGXT2
 M
X-Gm-Gg: ASbGncuHQM5bQLoIWv0+J2HLODcpD/2OtvMZrwN6nFFTUR+mnnrYUDg68hNxjc5yvel
 zp/H/X8kQagkfJEBkieIObJHbJW9Uttlx/0mB1bVP4saJBeZLCgMa5hz2alzXOtBiKEXQe3psa2
 KfKmQSYVX1ZqwIKhVJ5P/nBykqLsDQRXgOlp1kqDfiy94JERD0lfJYH4gch4i1Gy5HS/dTg6UZw
 rRTvDChOe9L508vIxKB1bBe6D+Brv+9hy7gbRFqNHEJ7YVN4MQvIfaDlN6tzsnWukDjZ64gWecZ
 n+qdykUsWv1gABitVkQpCBm45dzZEboplj/XeitGKv/W2FETxI0/1W8+J6Kc3N85pVtJeTJ9SXk
 =
X-Google-Smtp-Source: AGHT+IEbUP0HkOJzLsUOcUjmOjaxNviJzshVtSFMZbJ+ZV+9y6zx381bMLyVzgUlq+07zFJPDAJddw==
X-Received: by 2002:a05:6a00:3be1:b0:732:56a7:a935 with SMTP id
 d2e1a72fcca58-73e268ef408mr490742b3a.12.1745456199028; 
 Wed, 23 Apr 2025 17:56:39 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15fa907fcdsm119775a12.54.2025.04.23.17.56.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:56:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 087/148] target/riscv: Restrict SoftMMU mmu_index() to TCG
Date: Wed, 23 Apr 2025 17:48:32 -0700
Message-ID: <20250424004934.598783-88-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Move riscv_cpu_mmu_index() to the TCG-specific file,
convert CPUClass::mmu_index() to TCGCPUOps::mmu_index().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250401080938.32278-17-philmd@linaro.org>
---
 target/riscv/cpu.c         | 6 ------
 target/riscv/tcg/tcg-cpu.c | 6 ++++++
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 09ded6829a..430b02d2a5 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1021,11 +1021,6 @@ bool riscv_cpu_has_work(CPUState *cs)
 }
 #endif /* !CONFIG_USER_ONLY */
 
-static int riscv_cpu_mmu_index(CPUState *cs, bool ifetch)
-{
-    return riscv_env_mmu_index(cpu_env(cs), ifetch);
-}
-
 static void riscv_cpu_reset_hold(Object *obj, ResetType type)
 {
 #ifndef CONFIG_USER_ONLY
@@ -3049,7 +3044,6 @@ static void riscv_cpu_common_class_init(ObjectClass *c, void *data)
                                        &mcc->parent_phases);
 
     cc->class_by_name = riscv_cpu_class_by_name;
-    cc->mmu_index = riscv_cpu_mmu_index;
     cc->dump_state = riscv_cpu_dump_state;
     cc->set_pc = riscv_cpu_set_pc;
     cc->get_pc = riscv_cpu_get_pc;
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 5aef9eef36..bee7dfd803 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -91,6 +91,11 @@ static const char *cpu_priv_ver_to_str(int priv_ver)
     return priv_spec_str;
 }
 
+static int riscv_cpu_mmu_index(CPUState *cs, bool ifetch)
+{
+    return riscv_env_mmu_index(cpu_env(cs), ifetch);
+}
+
 static void riscv_cpu_synchronize_from_tb(CPUState *cs,
                                           const TranslationBlock *tb)
 {
@@ -138,6 +143,7 @@ static const TCGCPUOps riscv_tcg_ops = {
     .translate_code = riscv_translate_code,
     .synchronize_from_tb = riscv_cpu_synchronize_from_tb,
     .restore_state_to_opc = riscv_restore_state_to_opc,
+    .mmu_index = riscv_cpu_mmu_index,
 
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = riscv_cpu_tlb_fill,
-- 
2.43.0


