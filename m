Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD791831B22
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 15:12:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQT6U-0005E0-BM; Thu, 18 Jan 2024 09:10:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQT6J-0005CQ-4d; Thu, 18 Jan 2024 09:10:35 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQT6H-0000v0-5t; Thu, 18 Jan 2024 09:10:34 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6d9b267007fso7385769b3a.3; 
 Thu, 18 Jan 2024 06:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705587031; x=1706191831; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mKSBPWv52bR/VdmVRdHQJRMeuRKYTrFY5qPGuWj2bn4=;
 b=CF8Gyv67ozuHF3kiDzCfURFjzjTBC1f2DHssioWVN5gau7prpVEbSL9OtcPa/meyjz
 CNNjWesoEGbS8zI22S/PLfR32Se5pP7CZio34+lThbJj4j1CmeskYfOuKIeqcBMmJgRP
 LohtW5p9L8/TfaN6JHi49oqFAMoa8Wy8FEiwG+uv38zl4bevKGsWzfjz15CIM8iswbZ1
 OqO+rNor6g5QUqu07h/2ssbmB5goku3bCtdpUlwM/5BHBPy0QxENHfKaCv+HI6RDl63B
 9OZydn9CsCTj5wm4PcwAle/lbeziuDmLtgr25nPy2qX/ftVbSjjEs18nOhkyqxU4jT4o
 /5Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705587031; x=1706191831;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mKSBPWv52bR/VdmVRdHQJRMeuRKYTrFY5qPGuWj2bn4=;
 b=GqWKODF/KMe39wxR/Kyv/f89Rm7vTfLLiIb4T8p1EXzvOuBOp3ozvWGXJEQCqfqRr3
 kfpEaeP2cp4vHURxY2G4pXhXNdenXtzev3d8HcKwQdkPRwcZllWCJtPXjh6gf6LqBWWM
 Vs35yDcUPpejqFwkEeS/OkSVdh2pRPB4/AXFQLjjhyRFYH9KNKG02WHZGXln1Y8SRDey
 sA1t2iuPuDiVq8TMqRt9JkShojqvo3+rIL9PqkXFv67Dwt+HUARa6mLON8dY50/eH2ig
 MElZ9em2uCNSUzJPhu7AxlwxhxKH4f1et6CsuvkdZGinNFXlF5JP0K0BeVd/F+97xuQq
 wqMg==
X-Gm-Message-State: AOJu0YwBf7na6Ir8qjtPuv5lqoWMBQYJa356G1FxpymJUgHuUruPamN1
 9Pmmd+hC9SahW7H2aDDRNLcZTi9kanEmNVo/ibEXHzCMzAWqtvtIufuisFFu
X-Google-Smtp-Source: AGHT+IFeeKXVhjiYjPozGMCPzVXXPDFGD0bGQOfQb+KqBN11Y8M5QHAkWB/XuUoktybuNmhZ63Obbg==
X-Received: by 2002:a05:6a00:291a:b0:6d9:ecbb:8bd8 with SMTP id
 cg26-20020a056a00291a00b006d9ecbb8bd8mr884036pfb.32.1705587031003; 
 Thu, 18 Jan 2024 06:10:31 -0800 (PST)
Received: from wheely.local0.net (124-171-76-150.tpgi.com.au. [124.171.76.150])
 by smtp.gmail.com with ESMTPSA id
 l18-20020a62be12000000b006db3149eacasm3323336pff.104.2024.01.18.06.10.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 06:10:30 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: [PATCH 6/8] ppc/pnv: Permit ibm,pa-features set per machine variant
Date: Fri, 19 Jan 2024 00:09:40 +1000
Message-ID: <20240118140942.164319-7-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240118140942.164319-1-npiggin@gmail.com>
References: <20240118140942.164319-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x435.google.com
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

This allows different pa-features for powernv8/9/10.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/pnv.c | 41 +++++++++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 4969fbdb05..0a144402d7 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -133,7 +133,7 @@ static int get_cpus_node(void *fdt)
  * device tree, used in XSCOM to address cores and in interrupt
  * servers.
  */
-static void pnv_dt_core(PnvChip *chip, PnvCore *pc, void *fdt)
+static int pnv_dt_core(PnvChip *chip, PnvCore *pc, void *fdt)
 {
     PowerPCCPU *cpu = pc->threads[0];
     CPUState *cs = CPU(cpu);
@@ -149,11 +149,6 @@ static void pnv_dt_core(PnvChip *chip, PnvCore *pc, void *fdt)
     uint32_t cpufreq = 1000000000;
     uint32_t page_sizes_prop[64];
     size_t page_sizes_prop_size;
-    const uint8_t pa_features[] = { 24, 0,
-                                    0xf6, 0x3f, 0xc7, 0xc0, 0x80, 0xf0,
-                                    0x80, 0x00, 0x00, 0x00, 0x00, 0x00,
-                                    0x00, 0x00, 0x00, 0x00, 0x80, 0x00,
-                                    0x80, 0x00, 0x80, 0x00, 0x80, 0x00 };
     int offset;
     char *nodename;
     int cpus_offset = get_cpus_node(fdt);
@@ -241,15 +236,14 @@ static void pnv_dt_core(PnvChip *chip, PnvCore *pc, void *fdt)
                            page_sizes_prop, page_sizes_prop_size)));
     }
 
-    _FDT((fdt_setprop(fdt, offset, "ibm,pa-features",
-                       pa_features, sizeof(pa_features))));
-
     /* Build interrupt servers properties */
     for (i = 0; i < smt_threads; i++) {
         servers_prop[i] = cpu_to_be32(pc->pir + i);
     }
     _FDT((fdt_setprop(fdt, offset, "ibm,ppc-interrupt-server#s",
                        servers_prop, sizeof(*servers_prop) * smt_threads)));
+
+    return offset;
 }
 
 static void pnv_dt_icp(PnvChip *chip, void *fdt, uint32_t pir,
@@ -304,6 +298,17 @@ PnvChip *pnv_chip_add_phb(PnvChip *chip, PnvPHB *phb)
     return chip;
 }
 
+/*
+ * Same as spapr pa_features_207 except pnv always enables CI largepages bit.
+ * HTM is always enabled because TCG does implement HTM, it's just a
+ * degenerate implementation.
+ */
+static const uint8_t pa_features_207[] = { 24, 0,
+                 0xf6, 0x3f, 0xc7, 0xc0, 0x80, 0xf0,
+                 0x80, 0x00, 0x00, 0x00, 0x00, 0x00,
+                 0x00, 0x00, 0x00, 0x00, 0x80, 0x00,
+                 0x80, 0x00, 0x80, 0x00, 0x80, 0x00 };
+
 static void pnv_chip_power8_dt_populate(PnvChip *chip, void *fdt)
 {
     static const char compat[] = "ibm,power8-xscom\0ibm,xscom";
@@ -316,8 +321,12 @@ static void pnv_chip_power8_dt_populate(PnvChip *chip, void *fdt)
 
     for (i = 0; i < chip->nr_cores; i++) {
         PnvCore *pnv_core = chip->cores[i];
+        int offset;
+
+        offset = pnv_dt_core(chip, pnv_core, fdt);
 
-        pnv_dt_core(chip, pnv_core, fdt);
+        _FDT((fdt_setprop(fdt, offset, "ibm,pa-features",
+                           pa_features_207, sizeof(pa_features_207))));
 
         /* Interrupt Control Presenters (ICP). One per core. */
         pnv_dt_icp(chip, fdt, pnv_core->pir, CPU_CORE(pnv_core)->nr_threads);
@@ -340,8 +349,12 @@ static void pnv_chip_power9_dt_populate(PnvChip *chip, void *fdt)
 
     for (i = 0; i < chip->nr_cores; i++) {
         PnvCore *pnv_core = chip->cores[i];
+        int offset;
 
-        pnv_dt_core(chip, pnv_core, fdt);
+        offset = pnv_dt_core(chip, pnv_core, fdt);
+
+        _FDT((fdt_setprop(fdt, offset, "ibm,pa-features",
+                           pa_features_207, sizeof(pa_features_207))));
     }
 
     if (chip->ram_size) {
@@ -363,8 +376,12 @@ static void pnv_chip_power10_dt_populate(PnvChip *chip, void *fdt)
 
     for (i = 0; i < chip->nr_cores; i++) {
         PnvCore *pnv_core = chip->cores[i];
+        int offset;
+
+        offset = pnv_dt_core(chip, pnv_core, fdt);
 
-        pnv_dt_core(chip, pnv_core, fdt);
+        _FDT((fdt_setprop(fdt, offset, "ibm,pa-features",
+                           pa_features_207, sizeof(pa_features_207))));
     }
 
     if (chip->ram_size) {
-- 
2.42.0


