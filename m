Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD66B7213C8
	for <lists+qemu-devel@lfdr.de>; Sun,  4 Jun 2023 01:37:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5ank-0005bR-9G; Sat, 03 Jun 2023 19:36:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q5anT-0005MY-M9; Sat, 03 Jun 2023 19:36:37 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q5anR-0003SK-Vj; Sat, 03 Jun 2023 19:36:35 -0400
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-39aa4919a57so463953b6e.0; 
 Sat, 03 Jun 2023 16:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685835391; x=1688427391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8TeLkXHbQFXqTkthMIJ2eNjzh0ZfEhGFxO1aTt1j4J4=;
 b=RzUeyUhxzqJV/2u3y4GDCiA4Alxu0pDPgRjH8pOkvtTZmUuu8juqB+lPCs2dXKjITZ
 fbEZiw+ExX8c3KPf3+scHVhcA0CVXLi/xENtA51kzQP4D1/f/KaudvCEC9f9oTLcCcpD
 /V5rPI7JUTXUHnvOknG7nbdlrB5s7j5O9OeNcm1RHKKmiggLgScHcnrL0SDIEOFCTeM4
 ganUSnaQ2yybUF6KERaL3OXepr2b+VtW/GCo1cUup3HZ/T6TLKSiaQtiJx9K3hjeuGoF
 3mwAaBHQ/k48vLlNJpLMdBeA9ztQ9EdoXAz+PeNzvfwKuS7vYBMaQc1c0X4FNPDjYAfI
 IZxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685835391; x=1688427391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8TeLkXHbQFXqTkthMIJ2eNjzh0ZfEhGFxO1aTt1j4J4=;
 b=EwMNh7OTgcoGT3O5eFBLD0pA6HeQMHkTr8M6+lG5VxhHvnaDwxkOep2l4p0PRaur5n
 sfJZ+yaBnIJ9MaJptChNgsfTs+Y9pzgTWSprS2mw2c92SfQhqYT1xtGDxArITScDCYEN
 V17S0aKvNGwUYOmg55/iO8M/2cA+audKCmk66a5F4M44SufWGsL4sr8K/hgOW8mFyUb1
 AJCRwpUK2w+PDG3WRIkw2oQlJlmxq5J6lMz4cY2AjBRfJfoMcsyqQSTmGpaH+3vPSz1b
 IzwcKSdR/m9B5GcHJXrVXv8dvp4qt+IndO047R8+32lyZ5JvGjxP791+5/S821BjLq3Z
 JBGg==
X-Gm-Message-State: AC+VfDzC2Efron+8zAfIoohVcJPLCdTAb112EHC63atfe5EcjnYk1pXE
 NozSKWYsjzdNJGKVLpzT9foTjeaK6AU=
X-Google-Smtp-Source: ACHHUZ6lVSCjFkpI6Bw2flR+XarNaqhf5KEVBS0S8SeNaDNet0y8D3ZOKsr6cH/8tn+7LF0LNOqnrA==
X-Received: by 2002:a05:6808:1c3:b0:397:f93e:e160 with SMTP id
 x3-20020a05680801c300b00397f93ee160mr3988624oic.39.1685835391276; 
 Sat, 03 Jun 2023 16:36:31 -0700 (PDT)
Received: from wheely.local0.net ([203.221.142.9])
 by smtp.gmail.com with ESMTPSA id
 io23-20020a17090312d700b001aface7bdd8sm3743533plb.31.2023.06.03.16.36.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Jun 2023 16:36:30 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH 2/4] target/ppc: Tidy POWER book4 SPR registration
Date: Sun,  4 Jun 2023 09:36:10 +1000
Message-Id: <20230603233612.125879-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230603233612.125879-1-npiggin@gmail.com>
References: <20230603233612.125879-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=npiggin@gmail.com; helo=mail-oi1-x231.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

POWER book4 (implementation-specific) SPRs are sometimes in their own
functions, but in other cases are mixed with architected SPRs. Do some
spring cleaning on these.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu_init.c | 92 ++++++++++++++++++++++++++++---------------
 1 file changed, 60 insertions(+), 32 deletions(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index e9717b8169..da0f7a7159 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -5374,31 +5374,6 @@ static void register_book3s_ids_sprs(CPUPPCState *env)
                  &spr_read_generic, SPR_NOACCESS,
                  &spr_read_generic, NULL,
                  0x00000000);
-    spr_register_hv(env, SPR_HID0, "HID0",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_core_write_generic,
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
@@ -5454,11 +5429,6 @@ static void register_book3s_ids_sprs(CPUPPCState *env)
                  SPR_NOACCESS, SPR_NOACCESS,
                  &spr_read_generic, &spr_write_generic,
                  0x00000000);
-    spr_register_hv(env, SPR_LDBAR, "LDBAR",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
-                 0x00000000);
 }
 
 static void register_rmor_sprs(CPUPPCState *env)
@@ -5665,14 +5635,65 @@ static void register_power8_ic_sprs(CPUPPCState *env)
 #endif
 }
 
+/* SPRs specific to IBM POWER CPUs */
+static void register_power_common_book4_sprs(CPUPPCState *env)
+{
+#if !defined(CONFIG_USER_ONLY)
+    spr_register_hv(env, SPR_HID0, "HID0",
+                 SPR_NOACCESS, SPR_NOACCESS,
+                 SPR_NOACCESS, SPR_NOACCESS,
+                 &spr_read_generic, &spr_core_write_generic,
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
+    spr_register_hv(env, SPR_LDBAR, "LDBAR",
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
@@ -5688,10 +5709,12 @@ static void register_power7_book4_sprs(CPUPPCState *env)
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
@@ -5725,6 +5748,11 @@ static void register_power9_mmu_sprs(CPUPPCState *env)
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
 
@@ -6278,7 +6306,7 @@ static void init_proc_POWER9(CPUPPCState *env)
     register_power8_dpdes_sprs(env);
     register_vtb_sprs(env);
     register_power8_ic_sprs(env);
-    register_power8_book4_sprs(env);
+    register_power9_book4_sprs(env);
     register_power8_rpr_sprs(env);
     register_power9_mmu_sprs(env);
 
@@ -6471,7 +6499,7 @@ static void init_proc_POWER10(CPUPPCState *env)
     register_power8_dpdes_sprs(env);
     register_vtb_sprs(env);
     register_power8_ic_sprs(env);
-    register_power8_book4_sprs(env);
+    register_power9_book4_sprs(env);
     register_power8_rpr_sprs(env);
     register_power9_mmu_sprs(env);
     register_power10_hash_sprs(env);
-- 
2.40.1


