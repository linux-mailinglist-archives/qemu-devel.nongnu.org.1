Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E11AF831C00
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 16:08:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQTzE-0007Lt-Mu; Thu, 18 Jan 2024 10:07:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQTzC-0007L9-TI; Thu, 18 Jan 2024 10:07:18 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQTzB-0007zZ-47; Thu, 18 Jan 2024 10:07:18 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1d6ff29293dso10364755ad.0; 
 Thu, 18 Jan 2024 07:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705590435; x=1706195235; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=asRvM/Q9k3Q6cIUYYKXr/1aGuqfUD6qMUFcQ4wVHFu8=;
 b=PrBaqkn+Ay5wB28mHs6XN7aDXmReFQV/BDqzRM1Oo6nIYZbQDfuR3WjLDfLsn8QXc7
 IlBx4oQw1FGl9riZIaMBhTtJJK+MYiA1fhg35NHcMfSzphO17mbxRxVha+odnzK+M+EY
 OLnkav2zmOIJbxY8Yd0RehtPtzedOmA1zt+NinPJ19WphOIfWHPnbc6XPpfUwMQYzJ3b
 70fELceI8OAmywpBURZ/kwDaoq2DbLNS7yOvQe3T4WDKhEdGrW1Pth8Y73Ki9svaG35Y
 dfUb7HMN7ypnV0yhSeBbbUf/KsRAXLsrUIZ6jdwZP5WllN7gjogAEukEhNBoeoM8riqx
 DBbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705590435; x=1706195235;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=asRvM/Q9k3Q6cIUYYKXr/1aGuqfUD6qMUFcQ4wVHFu8=;
 b=ow75/gAxi77cUMqOjQ/yTDPvqujwoGVIcoRVhdkPn168UXO1lSVyrwuA3ShXAPDrbC
 jBZMOU0NrBY00bm4i4JEb4e0+YNhlA3v9dUEOkCpD9uBRwyUpT63UKz5JDm0DJJV01XY
 O5/qw1VBcQlzJa+NOAm/rUv25qPxPKDooM9HqPBJnKEwO1W+VUj9qKecCUv5GJu6A3cT
 8AIO2I44SmQEEsQyYSjxuDlgmmJoyEsYcQdKOsVO5vrzF5j4C6JvXlAlrUiNPs6ROpxD
 xU0aVCZ5wVnDVDa6mOwwceI3VqxrxjLiW8w/7e04tJ6I5plPRbUB1jUX+20yPymfb8nt
 8RFA==
X-Gm-Message-State: AOJu0Ywwk1OH5s+mXQjZh9LYvOFGxWJcNT3Jr1irtX+Zwbe9cb6fWw4t
 0ujHd3gqag3WcvY4Uy4zK1cwB3Si/gcMK1qn4poj8s/dHVsI4eKvWCfDfLsB
X-Google-Smtp-Source: AGHT+IHJXau2c5w//8Yq0FOJvyiY++oy67wh7gswycDR+d9g5qrTMsdboCeAIkeVGCdbfDpy6gzPMA==
X-Received: by 2002:a17:902:7d92:b0:1d3:fa3f:6688 with SMTP id
 a18-20020a1709027d9200b001d3fa3f6688mr868803plm.61.1705590435005; 
 Thu, 18 Jan 2024 07:07:15 -0800 (PST)
Received: from wheely.local0.net (124-171-76-150.tpgi.com.au. [124.171.76.150])
 by smtp.gmail.com with ESMTPSA id
 e17-20020a170902cf5100b001d052d1aaf2sm1509401plg.101.2024.01.18.07.07.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 07:07:14 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: [PATCH 04/26] target/ppc: Rename registers to match ISA
Date: Fri, 19 Jan 2024 01:06:22 +1000
Message-ID: <20240118150644.177371-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240118150644.177371-1-npiggin@gmail.com>
References: <20240118150644.177371-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62c.google.com
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

Several registers have names that don't match the ISA (or convention
with other QEMU PPC registers), making them unintuitive to use with
GDB.

Fortunately most of these registers are obscure and/or have not been
correctly implemented in the gdb server (e.g., DEC, TB, CFAR), so risk
of breaking users should be low.

QEMU should follow the ISA for register name convention (where there is
no established GDB name).

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu_init.c    | 20 ++++++++++----------
 target/ppc/helper_regs.c |  2 +-
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 6b5f07bde1..5c1d0adca8 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -5062,7 +5062,7 @@ static void register_970_hid_sprs(CPUPPCState *env)
 
 static void register_970_hior_sprs(CPUPPCState *env)
 {
-    spr_register(env, SPR_HIOR, "SPR_HIOR",
+    spr_register(env, SPR_HIOR, "HIOR",
                  SPR_NOACCESS, SPR_NOACCESS,
                  &spr_read_hior, &spr_write_hior,
                  0x00000000);
@@ -5070,11 +5070,11 @@ static void register_970_hior_sprs(CPUPPCState *env)
 
 static void register_book3s_ctrl_sprs(CPUPPCState *env)
 {
-    spr_register(env, SPR_CTRL, "SPR_CTRL",
+    spr_register(env, SPR_CTRL, "CTRL",
                  SPR_NOACCESS, SPR_NOACCESS,
                  SPR_NOACCESS, &spr_write_CTRL,
                  0x00000000);
-    spr_register(env, SPR_UCTRL, "SPR_UCTRL",
+    spr_register(env, SPR_UCTRL, "UCTRL",
                  &spr_read_ureg, SPR_NOACCESS,
                  &spr_read_ureg, SPR_NOACCESS,
                  0x00000000);
@@ -5465,7 +5465,7 @@ static void register_book3s_purr_sprs(CPUPPCState *env)
 static void register_power6_dbg_sprs(CPUPPCState *env)
 {
 #if !defined(CONFIG_USER_ONLY)
-    spr_register(env, SPR_CFAR, "SPR_CFAR",
+    spr_register(env, SPR_CFAR, "CFAR",
                  SPR_NOACCESS, SPR_NOACCESS,
                  &spr_read_cfar, &spr_write_cfar,
                  0x00000000);
@@ -5483,7 +5483,7 @@ static void register_power5p_common_sprs(CPUPPCState *env)
 static void register_power6_common_sprs(CPUPPCState *env)
 {
 #if !defined(CONFIG_USER_ONLY)
-    spr_register_kvm(env, SPR_DSCR, "SPR_DSCR",
+    spr_register_kvm(env, SPR_DSCR, "DSCR",
                      SPR_NOACCESS, SPR_NOACCESS,
                      &spr_read_generic, &spr_write_generic,
                      KVM_REG_PPC_DSCR, 0x00000000);
@@ -5695,7 +5695,7 @@ static void register_power8_book4_sprs(CPUPPCState *env)
                      &spr_read_generic, &spr_write_generic,
                      KVM_REG_PPC_ACOP, 0);
     /* PID is only in BookE in ISA v2.07 */
-    spr_register_kvm(env, SPR_BOOKS_PID, "PID",
+    spr_register_kvm(env, SPR_BOOKS_PID, "PIDR",
                      SPR_NOACCESS, SPR_NOACCESS,
                      &spr_read_generic, &spr_write_pidr,
                      KVM_REG_PPC_PID, 0);
@@ -5716,7 +5716,7 @@ static void register_power7_book4_sprs(CPUPPCState *env)
                      &spr_read_generic, &spr_write_generic,
                      KVM_REG_PPC_ACOP, 0);
     /* PID is only in BookE in ISA v2.06 */
-    spr_register_kvm(env, SPR_BOOKS_PID, "PID",
+    spr_register_kvm(env, SPR_BOOKS_PID, "PIDR",
                      SPR_NOACCESS, SPR_NOACCESS,
                      &spr_read_generic, &spr_write_generic32,
                      KVM_REG_PPC_PID, 0);
@@ -5750,7 +5750,7 @@ static void register_power9_mmu_sprs(CPUPPCState *env)
                     &spr_read_generic, &spr_write_generic,
                     0x0000000000000000);
     /* PID is part of the BookS ISA from v3.0 */
-    spr_register_kvm(env, SPR_BOOKS_PID, "PID",
+    spr_register_kvm(env, SPR_BOOKS_PID, "PIDR",
                      SPR_NOACCESS, SPR_NOACCESS,
                      &spr_read_generic, &spr_write_pidr,
                      KVM_REG_PPC_PID, 0);
@@ -5791,7 +5791,7 @@ static void register_power10_dexcr_sprs(CPUPPCState *env)
             &spr_read_generic, &spr_write_generic32,
             0);
 
-    spr_register(env, SPR_UDEXCR, "DEXCR",
+    spr_register(env, SPR_UDEXCR, "UDEXCR",
             &spr_read_dexcr_ureg, SPR_NOACCESS,
             &spr_read_dexcr_ureg, SPR_NOACCESS,
             0);
@@ -5802,7 +5802,7 @@ static void register_power10_dexcr_sprs(CPUPPCState *env)
             &spr_read_generic, &spr_write_generic32,
             0);
 
-    spr_register(env, SPR_UHDEXCR, "HDEXCR",
+    spr_register(env, SPR_UHDEXCR, "UHDEXCR",
             &spr_read_dexcr_ureg, SPR_NOACCESS,
             &spr_read_dexcr_ureg, SPR_NOACCESS,
             0);
diff --git a/target/ppc/helper_regs.c b/target/ppc/helper_regs.c
index bd17c14136..3aea8ff8ac 100644
--- a/target/ppc/helper_regs.c
+++ b/target/ppc/helper_regs.c
@@ -495,7 +495,7 @@ void register_non_embedded_sprs(CPUPPCState *env)
                      &spr_read_generic, &spr_write_generic,
                      KVM_REG_PPC_DAR, 0x00000000);
     /* Timer */
-    spr_register(env, SPR_DECR, "DECR",
+    spr_register(env, SPR_DECR, "DEC",
                  SPR_NOACCESS, SPR_NOACCESS,
                  &spr_read_decr, &spr_write_decr,
                  0x00000000);
-- 
2.42.0


