Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B520B74AFDD
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 13:33:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHjgf-0001tP-7E; Fri, 07 Jul 2023 07:31:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjgc-0001r2-0c; Fri, 07 Jul 2023 07:31:42 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjga-0006Wj-50; Fri, 07 Jul 2023 07:31:41 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-6b72c4038b6so1632000a34.0; 
 Fri, 07 Jul 2023 04:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688729498; x=1691321498;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+GckRC9WF6jBz5Y1RBX2K1cG6eGjL8Tz8QkqA60Fn2M=;
 b=Z9HHub1RqQVzPsIo+Zei2f/ppXbAKROaAnd8QQuCHkpIr92Xgv3DULyc9b/D5F5g7w
 t3tQjYh4ZygxKPt0EGq9q5QmE99/4jv9Tclr77LccsFV7cmMhV63Zh2JKKLqIg694j/v
 4s4FX774gtRiNiHtMuS26mYP4cZrA5r85RO2gVAiGLGsSMpGet5X9Uulj0d+3sMEiqSF
 CNtYwxuCsqyvvtIUyt/vSGfT4V1Aw7Ej1DMngeKh/uu3e4X0pW7baHWbT8TpD4rX9tX2
 3vhBc4p1DoM1c8/hqJ2Y/qeh5iGwmM+YbBskDD1ySKaqBpI8b/MDVCeRtxHY/3wfB/n5
 Hp/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688729498; x=1691321498;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+GckRC9WF6jBz5Y1RBX2K1cG6eGjL8Tz8QkqA60Fn2M=;
 b=WzNiU8DZI+DbJT+Hr0xUFq7FnnSmdMLxIyZAfILmNQPVgOerwVfxjcm238UGbo34KY
 HM51A2GuBxg3yHKw7wbw2JmrLE0xEvi/piFGG1WFHyLypZaV/HWwzYBVzdpaucS2Uge5
 EEugbxNzNaxAA83eWEBmDKBQwCOKydrwvNzXJHPHnOJNo9Jp1EIDslLnLPH655lDNbKL
 B9ofsW4ew0wcUNdd7BEdyqGsWCyAKmfnhXRYBq+eqXCDdGW+lLSA92y4aUcv7KQdlE8Z
 ME46oZapA/A75v015epYaKgmRxvnZkcMJMGgxpAHtaWtuSNC/OJYCIXJ796ME9o7hZzJ
 VhSA==
X-Gm-Message-State: ABy/qLZeAHxJ4K3z3CJSePZx/BWRFi1+XNCZDzUFbNEwew7leFZ7/Yxg
 QqjI1oSngpNFQr9pPXWJIGK7GPRQsEU=
X-Google-Smtp-Source: APBJJlG9UHTdlbHwTxIkaEtzYdwyal5yqMfiHWkXpeqmPYNnYnBObg9z7Wg3K9iqYZZso1iVN/Uu+w==
X-Received: by 2002:a05:6830:1e72:b0:6b7:9a33:8580 with SMTP id
 m18-20020a0568301e7200b006b79a338580mr4989172otr.30.1688729498494; 
 Fri, 07 Jul 2023 04:31:38 -0700 (PDT)
Received: from grind.. ([2804:14c:f435:9162::1002])
 by smtp.gmail.com with ESMTPSA id
 g17-20020a9d6c51000000b006b74b37f5e5sm1574859otq.20.2023.07.07.04.31.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 04:31:38 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 06/60] target/ppc: Tidy POWER book4 SPR registration
Date: Fri,  7 Jul 2023 08:30:14 -0300
Message-ID: <20230707113108.7145-7-danielhb413@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707113108.7145-1-danielhb413@gmail.com>
References: <20230707113108.7145-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=danielhb413@gmail.com; helo=mail-ot1-x334.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Nicholas Piggin <npiggin@gmail.com>

POWER book4 (implementation-specific) SPRs are sometimes in their own
functions, but in other cases are mixed with architected SPRs. Do some
spring cleaning on these.

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Message-ID: <20230625120317.13877-2-npiggin@gmail.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 target/ppc/cpu_init.c | 82 +++++++++++++++++++++++++++++--------------
 1 file changed, 55 insertions(+), 27 deletions(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index aeff71d063..dc93581dd3 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -5370,31 +5370,6 @@ static void register_book3s_ids_sprs(CPUPPCState *env)
                  &spr_read_generic, SPR_NOACCESS,
                  &spr_read_generic, NULL,
                  0x00000000);
-    spr_register_hv(env, SPR_HID0, "HID0",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
-                 0x00000000);
-    spr_register_hv(env, SPR_TSCR, "TSCR",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic32,
-                 0x00000000);
-    spr_register_hv(env, SPR_HMER, "HMER",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_hmer,
-                 0x00000000);
-    spr_register_hv(env, SPR_HMEER, "HMEER",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
-                 0x00000000);
-    spr_register_hv(env, SPR_TFMR, "TFMR",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
-                 0x00000000);
     spr_register_hv(env, SPR_LPIDR, "LPIDR",
                  SPR_NOACCESS, SPR_NOACCESS,
                  SPR_NOACCESS, SPR_NOACCESS,
@@ -5656,14 +5631,60 @@ static void register_power8_ic_sprs(CPUPPCState *env)
 #endif
 }
 
+/* SPRs specific to IBM POWER CPUs */
+static void register_power_common_book4_sprs(CPUPPCState *env)
+{
+#if !defined(CONFIG_USER_ONLY)
+    spr_register_hv(env, SPR_HID0, "HID0",
+                 SPR_NOACCESS, SPR_NOACCESS,
+                 SPR_NOACCESS, SPR_NOACCESS,
+                 &spr_read_generic, &spr_write_generic,
+                 0x00000000);
+    spr_register_hv(env, SPR_TSCR, "TSCR",
+                 SPR_NOACCESS, SPR_NOACCESS,
+                 SPR_NOACCESS, SPR_NOACCESS,
+                 &spr_read_generic, &spr_write_generic32,
+                 0x00000000);
+    spr_register_hv(env, SPR_HMER, "HMER",
+                 SPR_NOACCESS, SPR_NOACCESS,
+                 SPR_NOACCESS, SPR_NOACCESS,
+                 &spr_read_generic, &spr_write_hmer,
+                 0x00000000);
+    spr_register_hv(env, SPR_HMEER, "HMEER",
+                 SPR_NOACCESS, SPR_NOACCESS,
+                 SPR_NOACCESS, SPR_NOACCESS,
+                 &spr_read_generic, &spr_write_generic,
+                 0x00000000);
+    spr_register_hv(env, SPR_TFMR, "TFMR",
+                 SPR_NOACCESS, SPR_NOACCESS,
+                 SPR_NOACCESS, SPR_NOACCESS,
+                 &spr_read_generic, &spr_write_generic,
+                 0x00000000);
+#endif
+}
+
+static void register_power9_book4_sprs(CPUPPCState *env)
+{
+    /* Add a number of P9 book4 registers */
+    register_power_common_book4_sprs(env);
+#if !defined(CONFIG_USER_ONLY)
+    spr_register_kvm(env, SPR_WORT, "WORT",
+                     SPR_NOACCESS, SPR_NOACCESS,
+                     &spr_read_generic, &spr_write_generic,
+                     KVM_REG_PPC_WORT, 0);
+#endif
+}
+
 static void register_power8_book4_sprs(CPUPPCState *env)
 {
     /* Add a number of P8 book4 registers */
+    register_power_common_book4_sprs(env);
 #if !defined(CONFIG_USER_ONLY)
     spr_register_kvm(env, SPR_ACOP, "ACOP",
                      SPR_NOACCESS, SPR_NOACCESS,
                      &spr_read_generic, &spr_write_generic,
                      KVM_REG_PPC_ACOP, 0);
+    /* PID is only in BookE in ISA v2.07 */
     spr_register_kvm(env, SPR_BOOKS_PID, "PID",
                      SPR_NOACCESS, SPR_NOACCESS,
                      &spr_read_generic, &spr_write_pidr,
@@ -5679,10 +5700,12 @@ static void register_power7_book4_sprs(CPUPPCState *env)
 {
     /* Add a number of P7 book4 registers */
 #if !defined(CONFIG_USER_ONLY)
+    register_power_common_book4_sprs(env);
     spr_register_kvm(env, SPR_ACOP, "ACOP",
                      SPR_NOACCESS, SPR_NOACCESS,
                      &spr_read_generic, &spr_write_generic,
                      KVM_REG_PPC_ACOP, 0);
+    /* PID is only in BookE in ISA v2.06 */
     spr_register_kvm(env, SPR_BOOKS_PID, "PID",
                      SPR_NOACCESS, SPR_NOACCESS,
                      &spr_read_generic, &spr_write_generic32,
@@ -5716,6 +5739,11 @@ static void register_power9_mmu_sprs(CPUPPCState *env)
                     SPR_NOACCESS, SPR_NOACCESS,
                     &spr_read_generic, &spr_write_generic,
                     0x0000000000000000);
+    /* PID is part of the BookS ISA from v3.0 */
+    spr_register_kvm(env, SPR_BOOKS_PID, "PID",
+                     SPR_NOACCESS, SPR_NOACCESS,
+                     &spr_read_generic, &spr_write_pidr,
+                     KVM_REG_PPC_PID, 0);
 #endif
 }
 
@@ -6269,7 +6297,7 @@ static void init_proc_POWER9(CPUPPCState *env)
     register_power8_dpdes_sprs(env);
     register_vtb_sprs(env);
     register_power8_ic_sprs(env);
-    register_power8_book4_sprs(env);
+    register_power9_book4_sprs(env);
     register_power8_rpr_sprs(env);
     register_power9_mmu_sprs(env);
 
@@ -6462,7 +6490,7 @@ static void init_proc_POWER10(CPUPPCState *env)
     register_power8_dpdes_sprs(env);
     register_vtb_sprs(env);
     register_power8_ic_sprs(env);
-    register_power8_book4_sprs(env);
+    register_power9_book4_sprs(env);
     register_power8_rpr_sprs(env);
     register_power9_mmu_sprs(env);
     register_power10_hash_sprs(env);
-- 
2.41.0


