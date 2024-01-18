Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D296831C12
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 16:11:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQU0y-0001IW-G8; Thu, 18 Jan 2024 10:09:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQU0O-0000Ks-Bo; Thu, 18 Jan 2024 10:08:33 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQU0L-0008A0-Uh; Thu, 18 Jan 2024 10:08:32 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1d427518d52so6939825ad.0; 
 Thu, 18 Jan 2024 07:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705590507; x=1706195307; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JJIc+EJrE9+5ke7mgaiI4ZbSb27QLrdfcHGBJZ+qj3g=;
 b=ZPDQ7mApA52UL9CXTW3Il/3y0sJsfpl4/ULIuEocK8GkPotovXRIct4KmdBxqbojSn
 vkiBy8vkJvadTu9qMsxaPPFw3HgMPMZ3viZHkY9WguOdofO3jjEGa/0AZdzZN2mRQOq4
 JCxM4heCzuF1HJxX+foPTykSqiTfAiSl3Us2YW2SBnxhdAiIiQfkA+2Ogz8Ywn6q6sON
 RxJvBPdqgkbjo/V9mvyOOt1kj1NKLFtKW4+yDLK22Rhp4mL3qGQHPJk6nO2BjSyWhxBW
 u9CtDWPwoWy8oWwTh7S2COODFGilrbuldeHTZuOOqaZdbKrHrjiEEmcJcoqv2HOsS+2v
 +b4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705590507; x=1706195307;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JJIc+EJrE9+5ke7mgaiI4ZbSb27QLrdfcHGBJZ+qj3g=;
 b=Wr7gzzUUYWGtx/4iBWWjAbggwEjI2qPpPxjlry/IV8JJKbuzz8jnb/ssF3pTPSto1b
 tvtUjP5d+M/FaxAcIO80FJur0tyikRmM1t6hPOPo/YSH6v1GOhnJLIGJNRJZs//x+BW4
 Uiy6w7ai4ZDGsCYy5HrYLZ3h3jlxXI31LROnTinfTnsOwirNTHZvKd0GjI70T2gPMdmk
 H+H3PxIExfbPQTWfMTQAx6L18Nt+ejTz5cjx8e+vARso2iP7cdkpFYyojrSrsMA7cFMG
 Dd54nPc8aOL7EZgav6Q+YLPp185EuubAf+BpUtXzzPAAqyBa8BAqB639JNWIl3gYvKIZ
 QMyw==
X-Gm-Message-State: AOJu0YzMFF0k6j7MMuUBswal6CbGGwFZAU90j8/7SYicQUXnU6PYDVAz
 tl4V8LsK7N5hXh61uic4jpYHqpWohkVhlwU03PFvNsvDK+asAmqL1dlnwicU
X-Google-Smtp-Source: AGHT+IGnZPLFeImNKJprb9OSo2SodFcmxivfUpeoFhFEY3r6kPrO4oVWYynlKkMKaaNVzBdSYdXzpQ==
X-Received: by 2002:a17:902:d885:b0:1d5:6b6c:1ace with SMTP id
 b5-20020a170902d88500b001d56b6c1acemr1294393plz.18.1705590507601; 
 Thu, 18 Jan 2024 07:08:27 -0800 (PST)
Received: from wheely.local0.net (124-171-76-150.tpgi.com.au. [124.171.76.150])
 by smtp.gmail.com with ESMTPSA id
 e17-20020a170902cf5100b001d052d1aaf2sm1509401plg.101.2024.01.18.07.08.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 07:08:27 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: [PATCH 20/26] target/ppc: Add PPR32 SPR
Date: Fri, 19 Jan 2024 01:06:38 +1000
Message-ID: <20240118150644.177371-21-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240118150644.177371-1-npiggin@gmail.com>
References: <20240118150644.177371-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62b.google.com
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

PPR32 provides access to the upper half of PPR.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu.h        |  1 +
 target/ppc/spr_common.h |  2 ++
 target/ppc/cpu_init.c   | 12 ++++++++++++
 target/ppc/translate.c  | 16 ++++++++++++++++
 4 files changed, 31 insertions(+)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index acaf39f365..8397ddaf18 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -2110,6 +2110,7 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define SPR_POWER_MMCRS       (0x37E)
 #define SPR_WORT              (0x37F)
 #define SPR_PPR               (0x380)
+#define SPR_PPR32             (0x382)
 #define SPR_750_GQR0          (0x390)
 #define SPR_440_DNV0          (0x390)
 #define SPR_750_GQR1          (0x391)
diff --git a/target/ppc/spr_common.h b/target/ppc/spr_common.h
index eb2561f593..9e40b3b608 100644
--- a/target/ppc/spr_common.h
+++ b/target/ppc/spr_common.h
@@ -203,6 +203,8 @@ void spr_read_tfmr(DisasContext *ctx, int gprn, int sprn);
 void spr_write_tfmr(DisasContext *ctx, int sprn, int gprn);
 void spr_write_lpcr(DisasContext *ctx, int sprn, int gprn);
 void spr_read_dexcr_ureg(DisasContext *ctx, int gprn, int sprn);
+void spr_read_ppr32(DisasContext *ctx, int sprn, int gprn);
+void spr_write_ppr32(DisasContext *ctx, int sprn, int gprn);
 #endif
 
 void register_low_BATs(CPUPPCState *env);
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index b732a1b06e..a479c122d3 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -5534,6 +5534,14 @@ static void register_HEIR64_spr(CPUPPCState *env)
                  0x00000000);
 }
 
+static void register_power7_common_sprs(CPUPPCState *env)
+{
+    spr_register(env, SPR_PPR32, "PPR32",
+                 &spr_read_ppr32, &spr_write_ppr32,
+                 &spr_read_ppr32, &spr_write_ppr32,
+                 0x00000000);
+}
+
 static void register_power8_tce_address_control_sprs(CPUPPCState *env)
 {
     spr_register_kvm(env, SPR_TAR, "TAR",
@@ -6027,6 +6035,7 @@ static void init_proc_POWER7(CPUPPCState *env)
     register_power6_common_sprs(env);
     register_HEIR32_spr(env);
     register_power6_dbg_sprs(env);
+    register_power7_common_sprs(env);
     register_power7_book4_sprs(env);
 
     /* env variables */
@@ -6172,6 +6181,7 @@ static void init_proc_POWER8(CPUPPCState *env)
     register_power6_common_sprs(env);
     register_HEIR32_spr(env);
     register_power6_dbg_sprs(env);
+    register_power7_common_sprs(env);
     register_power8_tce_address_control_sprs(env);
     register_power8_ids_sprs(env);
     register_power8_ebb_sprs(env);
@@ -6338,6 +6348,7 @@ static void init_proc_POWER9(CPUPPCState *env)
     register_power6_common_sprs(env);
     register_HEIR32_spr(env);
     register_power6_dbg_sprs(env);
+    register_power7_common_sprs(env);
     register_power8_tce_address_control_sprs(env);
     register_power8_ids_sprs(env);
     register_power8_ebb_sprs(env);
@@ -6535,6 +6546,7 @@ static void init_proc_POWER10(CPUPPCState *env)
     register_power6_common_sprs(env);
     register_HEIR64_spr(env);
     register_power6_dbg_sprs(env);
+    register_power7_common_sprs(env);
     register_power8_tce_address_control_sprs(env);
     register_power8_ids_sprs(env);
     register_power8_ebb_sprs(env);
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 0d36a553d3..c5089f90f6 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -1351,6 +1351,22 @@ void spr_read_dexcr_ureg(DisasContext *ctx, int gprn, int sprn)
     gen_load_spr(t0, sprn + 16);
     tcg_gen_ext32u_tl(cpu_gpr[gprn], t0);
 }
+
+/* The PPR32 SPR accesses the upper 32-bits of PPR */
+void spr_read_ppr32(DisasContext *ctx, int sprn, int gprn)
+{
+    gen_load_spr(cpu_gpr[gprn], SPR_PPR);
+    tcg_gen_shri_tl(cpu_gpr[gprn], cpu_gpr[gprn], 32);
+}
+
+void spr_write_ppr32(DisasContext *ctx, int sprn, int gprn)
+{
+    TCGv t0 = tcg_temp_new();
+
+    tcg_gen_shli_tl(t0, cpu_gpr[gprn], 32);
+    gen_store_spr(SPR_PPR, t0);
+    spr_store_dump_spr(SPR_PPR);
+}
 #endif
 
 #define GEN_HANDLER(name, opc1, opc2, opc3, inval, type)                      \
-- 
2.42.0


