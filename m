Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F080C7AD6BD
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 13:11:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkjTZ-0000hO-Pc; Mon, 25 Sep 2023 07:10:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchitale@ventanamicro.com>)
 id 1qkjTV-0000gf-Bj
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 07:10:01 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mchitale@ventanamicro.com>)
 id 1qkjTT-0005aL-In
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 07:10:01 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1c44a25bd0bso52805885ad.0
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 04:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1695640198; x=1696244998; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TS+cakekHUbEFVZDWRxMWd3aE9uo+32F1PaZKZpCiHg=;
 b=hEYOhAQfXAWGrHDziqlfnxmfMvnOdrwmKRWZOOmWIbhxsbd98FUrQfafFi1G880tvJ
 TJgY6Eg4ARpLWQrExyglM4EMK20/XrDrluZ3X82jRaiShNJayDBvijiFJYstEhHp92E/
 Zv2z2fgbvz1LllfSKRozWxBXXJmMe5actZ/yITJ1mGTJ1c0DyAhQU/JBIR6EeCACAnud
 NHx+MVCMA0guqjMLkpIydvO8G/2cOpWwvZlE+FferN5hduQVNt/3T3MdZLhjfc1RXH8j
 sDGyz4hl58Ad4EcJ6FOjzmtVXnaQIQ0cFJzQBV26kNRuFvBQtMGZrqwXyEVz7xuUfVWk
 7TvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695640198; x=1696244998;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TS+cakekHUbEFVZDWRxMWd3aE9uo+32F1PaZKZpCiHg=;
 b=IFP/7JZr54Gdfy+bqhS0Olt6H3y1/j+pPrUGRuKHXR6pBuDRZr6ZeB54kDvZI3TXB/
 CBaqOQmhhV+KlSI4eDTIns+7DE4SFcRPwi+QtuAbmyyy7qdOd0wj2Hr7nFFeL9NVUSY/
 Z7zkyLMfloygHduRV/CHir7paCdBbvojQs1L92/BdAYNyX5xUqRLEDAdNxI4bRV6/DVQ
 HUhEAxohzK39rOKlPpRZerzjQo4k/R4m1TqH7pBA1GnJkeP5B4guj+L9xnEFAfF3J78J
 hj8oKqqdQUgvA9alELmbfC2RtsUKREitvNO+pug7i5ydbEjYm1eIqthca56wg6o1wzCg
 rKuQ==
X-Gm-Message-State: AOJu0YwHrHOAoVZrY7fOdNP/fWkbOS/JIIa5N/gCneUceXY6US66VAzs
 9n2bFUHZQdRsGGcRuzPgPOu+SA==
X-Google-Smtp-Source: AGHT+IHlXWS+1Jvt+0R/H0zebZ45LCA9h74+cHYJdZypCzqheKbiEDMdGmnISMzHIT45QNAZhfLSpg==
X-Received: by 2002:a17:902:d483:b0:1b8:a67f:1c15 with SMTP id
 c3-20020a170902d48300b001b8a67f1c15mr15645373plg.25.1695640197417; 
 Mon, 25 Sep 2023 04:09:57 -0700 (PDT)
Received: from mchitale-vm.. ([103.97.165.210])
 by smtp.googlemail.com with ESMTPSA id
 b8-20020a170902d50800b001c44c8d857esm8461096plg.120.2023.09.25.04.09.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 04:09:56 -0700 (PDT)
From: Mayuresh Chitale <mchitale@ventanamicro.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: Mayuresh Chitale <mchitale@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH] target/riscv: pmp: Clear pmp/smepmp bits on reset
Date: Mon, 25 Sep 2023 16:39:46 +0530
Message-Id: <20230925110946.541019-1-mchitale@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=mchitale@ventanamicro.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

As per the Priv and Smepmp specifications, certain bits such as the 'L'
bit of pmp entries and mseccfg.MML can only be cleared upon reset and it
is necessary to do so to allow 'M' mode firmware to correctly reinitialize
the pmp/smpemp state across reboots.

Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
---
 target/riscv/cpu.c | 11 +++++++++++
 target/riscv/pmp.c | 10 ++++++++++
 target/riscv/pmp.h |  1 +
 3 files changed, 22 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 0fb01788e7..561567651e 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -761,6 +761,17 @@ static void riscv_cpu_reset_hold(Object *obj)
     }
     /* mmte is supposed to have pm.current hardwired to 1 */
     env->mmte |= (EXT_STATUS_INITIAL | MMTE_M_PM_CURRENT);
+
+    /*
+     * Clear mseccfg and unlock all the PMP entries upon reset.
+     * This is allowed as per the priv and smepmp specifications
+     * and is needed to clear stale entries across reboots.
+     */
+    if (riscv_cpu_cfg(env)->ext_smepmp) {
+        env->mseccfg = 0;
+    }
+
+    pmp_unlock_entries(env);
 #endif
     env->xl = riscv_cpu_mxl(env);
     riscv_cpu_update_mask(env);
diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index f498e414f0..5b14eb511a 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -129,6 +129,16 @@ static void pmp_write_cfg(CPURISCVState *env, uint32_t pmp_index, uint8_t val)
     }
 }
 
+void pmp_unlock_entries(CPURISCVState *env)
+{
+    uint32_t pmp_num = pmp_get_num_rules(env);
+    int i;
+
+    for (i = 0; i < pmp_num; i++) {
+        env->pmp_state.pmp[i].cfg_reg &= ~PMP_LOCK;
+    }
+}
+
 static void pmp_decode_napot(target_ulong a, target_ulong *sa,
                              target_ulong *ea)
 {
diff --git a/target/riscv/pmp.h b/target/riscv/pmp.h
index b296ea1fc6..0ab60fe15f 100644
--- a/target/riscv/pmp.h
+++ b/target/riscv/pmp.h
@@ -82,6 +82,7 @@ void pmp_update_rule_addr(CPURISCVState *env, uint32_t pmp_index);
 void pmp_update_rule_nums(CPURISCVState *env);
 uint32_t pmp_get_num_rules(CPURISCVState *env);
 int pmp_priv_to_page_prot(pmp_priv_t pmp_priv);
+void pmp_unlock_entries(CPURISCVState *env);
 
 #define MSECCFG_MML_ISSET(env) get_field(env->mseccfg, MSECCFG_MML)
 #define MSECCFG_MMWP_ISSET(env) get_field(env->mseccfg, MSECCFG_MMWP)
-- 
2.34.1


