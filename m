Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 495D8831B2C
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 15:13:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQT6V-0005Fz-12; Thu, 18 Jan 2024 09:10:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQT6O-0005Es-QG; Thu, 18 Jan 2024 09:10:41 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQT6M-0000vf-TV; Thu, 18 Jan 2024 09:10:40 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6d9b13fe9e9so9396928b3a.2; 
 Thu, 18 Jan 2024 06:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705587035; x=1706191835; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JxSsIMWIjG+FA8eKVyzES24tcAp+iTv4zsAB6Y5sWTQ=;
 b=gQUMiNQalUQnXFhGr0mJgcqkeZ0FjKD9DRKuaOTgwR3QP7DKk0kYrhM2BQljQbKh09
 flp1AsDVWfuvXEnLFWjqhigV3EPhM0aJA1BgvvBeQkRSOKwmWscjGLL1eNqGWSofyXq0
 Dm4TqzFVilGRLgWeJKdNFJZwCR9JsbMNQUajoOpMzvC4vqwYHHHG3S1HO3AS2Vjqs0/a
 sQSzb+Rf6lWhWLsABatgMEZI4Es8DoHanXeWH8jEENkT9/E7SSKllDayLDKe1J1jJYO2
 CwhZtB8ZFKao8QMNY77EM4oDaELpPjqsqg5yBqvuXKQFW6Ub4+MhvWY4zYVdimzScrME
 rHDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705587035; x=1706191835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JxSsIMWIjG+FA8eKVyzES24tcAp+iTv4zsAB6Y5sWTQ=;
 b=eMUlFy0vBhguWVoOEsyo/r1P8Q2sGD/Jcr6GZuXfWGfEaCRBQMO/etlEofwx8e1yKQ
 pZKneLLda7wpgCbT9rwo2LMB7tqgdEB7BT9nHBC7R9kMh6hi9us3d0pJL9DWO1jv7J5k
 INNUrTHRTfN9Dxn78+AoCbgP+1HocZ6zZzJwMDJC2cOulbqPSBbHmP4LiFtbCyPNz7Hn
 HmEK2e6IJ7E+i+izyErsAM9pHp+xJCuO+Xqa9SjKWLb+uA0IAokTogpEo7n/SzJkLkx9
 e81Krt0tlUFkGjR4yAUu7tLIj1QyZE9cZcMryJj4O8UUJpTcJ2PRlWGqrSz+x7ZySCjM
 15sA==
X-Gm-Message-State: AOJu0YxQf9Nq0Wx57zUCze+l7RzhD7KGrUUpC9OOkbapAAUuX76xD96Z
 aA2+XfUbhjIDb5vJgQmcrT8M026cj0DfA4NxgHu/TZZnNciwjUEbAZeh+a94
X-Google-Smtp-Source: AGHT+IFzuouUvx8Kax5/sT2grNCGR4NRWW/ZQkp9dB2VDTGrowTpIezsM623FZpur3s27I+v+iQOHA==
X-Received: by 2002:a05:6a20:8e16:b0:199:9013:1980 with SMTP id
 y22-20020a056a208e1600b0019990131980mr1054257pzj.58.1705587035362; 
 Thu, 18 Jan 2024 06:10:35 -0800 (PST)
Received: from wheely.local0.net (124-171-76-150.tpgi.com.au. [124.171.76.150])
 by smtp.gmail.com with ESMTPSA id
 l18-20020a62be12000000b006db3149eacasm3323336pff.104.2024.01.18.06.10.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 06:10:35 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: [PATCH 7/8] ppc/pnv: Set POWER9, POWER10 ibm,pa-features bits
Date: Fri, 19 Jan 2024 00:09:41 +1000
Message-ID: <20240118140942.164319-8-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240118140942.164319-1-npiggin@gmail.com>
References: <20240118140942.164319-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x431.google.com
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

Copy the pa-features arrays from spapr, adjusting slightly as
described in comments.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/pnv.c   | 68 ++++++++++++++++++++++++++++++++++++++++++++++++--
 hw/ppc/spapr.c |  1 +
 2 files changed, 67 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 0a144402d7..9db8fcd19e 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -337,6 +337,36 @@ static void pnv_chip_power8_dt_populate(PnvChip *chip, void *fdt)
     }
 }
 
+/*
+ * Same as spapr pa_features_300 except pnv always enables CI largepages bit,
+ * always disables copy/paste.
+ */
+static const uint8_t pa_features_300[] = { 66, 0,
+    /* 0: MMU|FPU|SLB|RUN|DABR|NX, 1: CILRG|fri[nzpm]|DABRX|SPRG3|SLB0|PP110 */
+    /* 2: VPM|DS205|PPR|DS202|DS206, 3: LSD|URG, 5: LE|CFAR|EB|LSQ */
+    0xf6, 0x3f, 0xc7, 0xc0, 0x00, 0xf0, /* 0 - 5 */
+    /* 6: DS207 */
+    0x80, 0x00, 0x00, 0x00, 0x00, 0x00, /* 6 - 11 */
+    /* 16: Vector */
+    0x00, 0x00, 0x00, 0x00, 0x80, 0x00, /* 12 - 17 */
+    /* 18: Vec. Scalar, 20: Vec. XOR, 22: HTM */
+    0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 18 - 23 */
+    /* 24: Ext. Dec, 26: 64 bit ftrs, 28: PM ftrs */
+    0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 24 - 29 */
+    /* 32: LE atomic, 34: EBB + ext EBB */
+    0x00, 0x00, 0x80, 0x00, 0xC0, 0x00, /* 30 - 35 */
+    /* 40: Radix MMU */
+    0x00, 0x00, 0x00, 0x00, 0x80, 0x00, /* 36 - 41 */
+    /* 42: PM, 44: PC RA, 46: SC vec'd */
+    0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 42 - 47 */
+    /* 48: SIMD, 50: QP BFP, 52: String */
+    0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 48 - 53 */
+    /* 54: DecFP, 56: DecI, 58: SHA */
+    0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 54 - 59 */
+    /* 60: NM atomic, 62: RNG */
+    0x80, 0x00, 0x80, 0x00, 0x00, 0x00, /* 60 - 65 */
+};
+
 static void pnv_chip_power9_dt_populate(PnvChip *chip, void *fdt)
 {
     static const char compat[] = "ibm,power9-xscom\0ibm,xscom";
@@ -354,7 +384,7 @@ static void pnv_chip_power9_dt_populate(PnvChip *chip, void *fdt)
         offset = pnv_dt_core(chip, pnv_core, fdt);
 
         _FDT((fdt_setprop(fdt, offset, "ibm,pa-features",
-                           pa_features_207, sizeof(pa_features_207))));
+                           pa_features_300, sizeof(pa_features_300))));
     }
 
     if (chip->ram_size) {
@@ -364,6 +394,40 @@ static void pnv_chip_power9_dt_populate(PnvChip *chip, void *fdt)
     pnv_dt_lpc(chip, fdt, 0, PNV9_LPCM_BASE(chip), PNV9_LPCM_SIZE);
 }
 
+/*
+ * Same as spapr pa_features_31 except pnv always enables CI largepages bit,
+ * always disables copy/paste.
+ */
+static const uint8_t pa_features_31[] = { 74, 0,
+    /* 0: MMU|FPU|SLB|RUN|DABR|NX, 1: CILRG|fri[nzpm]|DABRX|SPRG3|SLB0|PP110 */
+    /* 2: VPM|DS205|PPR|DS202|DS206, 3: LSD|URG, 5: LE|CFAR|EB|LSQ */
+    0xf6, 0x3f, 0xc7, 0xc0, 0x00, 0xf0, /* 0 - 5 */
+    /* 6: DS207 */
+    0x80, 0x00, 0x00, 0x00, 0x00, 0x00, /* 6 - 11 */
+    /* 16: Vector */
+    0x00, 0x00, 0x00, 0x00, 0x80, 0x00, /* 12 - 17 */
+    /* 18: Vec. Scalar, 20: Vec. XOR */
+    0x80, 0x00, 0x80, 0x00, 0x00, 0x00, /* 18 - 23 */
+    /* 24: Ext. Dec, 26: 64 bit ftrs, 28: PM ftrs */
+    0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 24 - 29 */
+    /* 32: LE atomic, 34: EBB + ext EBB */
+    0x00, 0x00, 0x80, 0x00, 0xC0, 0x00, /* 30 - 35 */
+    /* 40: Radix MMU */
+    0x00, 0x00, 0x00, 0x00, 0x80, 0x00, /* 36 - 41 */
+    /* 42: PM, 44: PC RA, 46: SC vec'd */
+    0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 42 - 47 */
+    /* 48: SIMD, 50: QP BFP, 52: String */
+    0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 48 - 53 */
+    /* 54: DecFP, 56: DecI, 58: SHA */
+    0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 54 - 59 */
+    /* 60: NM atomic, 62: RNG */
+    0x80, 0x00, 0x80, 0x00, 0x00, 0x00, /* 60 - 65 */
+    /* 68: DEXCR[SBHE|IBRTPDUS|SRAPD|NPHIE|PHIE] */
+    0x00, 0x00, 0xce, 0x00, 0x00, 0x00, /* 66 - 71 */
+    /* 72: Hash Check */
+    0x80, 0x00, /* 73 */
+};
+
 static void pnv_chip_power10_dt_populate(PnvChip *chip, void *fdt)
 {
     static const char compat[] = "ibm,power10-xscom\0ibm,xscom";
@@ -381,7 +445,7 @@ static void pnv_chip_power10_dt_populate(PnvChip *chip, void *fdt)
         offset = pnv_dt_core(chip, pnv_core, fdt);
 
         _FDT((fdt_setprop(fdt, offset, "ibm,pa-features",
-                           pa_features_207, sizeof(pa_features_207))));
+                           pa_features_31, sizeof(pa_features_31))));
     }
 
     if (chip->ram_size) {
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 2f58d8f292..40fdbd5d12 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -233,6 +233,7 @@ static void spapr_dt_pa_features(SpaprMachineState *spapr,
                                  PowerPCCPU *cpu,
                                  void *fdt, int offset)
 {
+    /* These should be kept in sync with pnv */
     uint8_t pa_features_206[] = { 6, 0,
         0xf6, 0x1f, 0xc7, 0x00, 0x80, 0xc0 };
     uint8_t pa_features_207[] = { 24, 0,
-- 
2.42.0


