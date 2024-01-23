Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 813F9838797
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 07:39:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSARN-0003lJ-5P; Tue, 23 Jan 2024 01:39:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSARK-0003iL-Ne
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 01:39:18 -0500
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSARI-00085s-U8
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 01:39:18 -0500
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2cdebb968feso45380861fa.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 22:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705991955; x=1706596755; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ce+1xoISDEqzphDfXb+KFJwfSUtAI/2aaWKElbLspcc=;
 b=JHXiUwNszo6n9td+0KFwL4FbdF8xQC40nZfab4bz9rChyLWeEOSspcI+NDfqHLHkhX
 KtHTqmL4UleGsuCPiLJlPTo1odSI2MlyyLWPj6P8L17C0RLzhJXVRgNWb1EqfwGKtRQx
 G/4gng6nBkYlzH1UVNkyvXZwk32VS0xtz96Ly/uqF71ABnvO8A3kNOGCdmfm5tyVy1na
 YDaXh3nDf3VTeZM40sRTXgBQE3RjfqleSlRPCiE4BwFzE3VfHDsXZrbJS/CteRT13nH+
 rn9FjwRU+jthwkMLi64QEL1kjdiGQwAS8XbPfceGuzGTTzexE83JmJQ+TLoYqzM1gzSU
 WTyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705991955; x=1706596755;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ce+1xoISDEqzphDfXb+KFJwfSUtAI/2aaWKElbLspcc=;
 b=q4j+U+9nm88lcj3KY3h64nT2a/zPiIqhuTao4ZKB8/bmHzYPlUnUq4OtI+GfbW2s4E
 L6dl6nje+u8st/MpLLdnKPMq7V6tAMHwgRJw77coDU9mSpetCnwxCLcrMU801t/V+tYZ
 rH8tdt0DltJ3u1HDe8Afy1bwPxOFcFrSSCyU1Bceorni+CHSgx31pvlmbsoyOFBmCjhE
 JqYdEM/K3tYFdrMBO3jA61YWW8xRb1NSAVXpMIX1lWX7LvM2Zk6Y5//+tlC0Q+VSHHGz
 F78cQXLJDZ1e00US+AaVQ5QwkxYoj73wnEjeW8PBTG+sQUowYnPnFzHkKDR7HQ3nuX90
 lhKQ==
X-Gm-Message-State: AOJu0YxoNfxVkF8QSK5MovOfJY3AJ0LZ5gOrWzUmFz8R/UVvX/I1XVER
 DfADC7Lf4pWPUGtCgkgNMxTqu43EpOJco6boEzgbWpvvVSNBmbAZdUeTl5I3lhdKCh8dTCOvajs
 eAiA=
X-Google-Smtp-Source: AGHT+IHl0pbqLWKHoBxjvlx5Tf17dDP6DoRfRrflwwpHVy48/RhkSo6mMOqY7otpani6xs09RKPxXA==
X-Received: by 2002:ac2:46e7:0:b0:50e:885d:4d1d with SMTP id
 q7-20020ac246e7000000b0050e885d4d1dmr1893073lfo.37.1705991954947; 
 Mon, 22 Jan 2024 22:39:14 -0800 (PST)
Received: from m1x-phil.lan ([176.187.194.78])
 by smtp.gmail.com with ESMTPSA id
 vx4-20020a170907a78400b00a2d62a515e8sm11264326ejc.212.2024.01.22.22.39.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 22 Jan 2024 22:39:14 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, Gavin Shan <gshan@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-arm@nongnu.org,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Joel Stanley <joel@jms.id.au>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Rob Herring <robh@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 5/8] hw/arm/aspeed/2500: Check for CPU types in
 machine_run_board_init()
Date: Tue, 23 Jan 2024 07:38:39 +0100
Message-ID: <20240123063842.35255-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240123063842.35255-1-philmd@linaro.org>
References: <20240123063842.35255-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x230.google.com
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

Restrict MachineClass::valid_cpu_types[] to the single
valid CPU type.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/aspeed.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index e0e0877b1d..df627096d2 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -1152,6 +1152,11 @@ static const char * const ast2400_a1_valid_cpu_types[] = {
     NULL
 };
 
+static const char * const ast2500_a1_valid_cpu_types[] = {
+    ARM_CPU_TYPE_NAME("arm1176"),
+    NULL
+};
+
 static void aspeed_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -1236,6 +1241,7 @@ static void aspeed_machine_supermicro_x11spi_bmc_class_init(ObjectClass *oc,
     amc->num_cs    = 1;
     amc->macs_mask = ASPEED_MAC0_ON | ASPEED_MAC1_ON;
     amc->i2c_init  = palmetto_bmc_i2c_init;
+    mc->valid_cpu_types = ast2500_a1_valid_cpu_types;
     mc->default_ram_size = 512 * MiB;
     mc->default_cpus = mc->min_cpus = mc->max_cpus =
         aspeed_soc_num_cpus(amc->soc_name);
@@ -1253,6 +1259,7 @@ static void aspeed_machine_ast2500_evb_class_init(ObjectClass *oc, void *data)
     amc->spi_model = "mx25l25635f";
     amc->num_cs    = 1;
     amc->i2c_init  = ast2500_evb_i2c_init;
+    mc->valid_cpu_types = ast2500_a1_valid_cpu_types;
     mc->default_ram_size       = 512 * MiB;
     mc->default_cpus = mc->min_cpus = mc->max_cpus =
         aspeed_soc_num_cpus(amc->soc_name);
@@ -1271,6 +1278,7 @@ static void aspeed_machine_yosemitev2_class_init(ObjectClass *oc, void *data)
     amc->spi_model = "mx25l25635e";
     amc->num_cs    = 2;
     amc->i2c_init  = yosemitev2_bmc_i2c_init;
+    mc->valid_cpu_types = ast2500_a1_valid_cpu_types;
     mc->default_ram_size       = 512 * MiB;
     mc->default_cpus = mc->min_cpus = mc->max_cpus =
         aspeed_soc_num_cpus(amc->soc_name);
@@ -1288,6 +1296,7 @@ static void aspeed_machine_romulus_class_init(ObjectClass *oc, void *data)
     amc->spi_model = "mx66l1g45g";
     amc->num_cs    = 2;
     amc->i2c_init  = romulus_bmc_i2c_init;
+    mc->valid_cpu_types = ast2500_a1_valid_cpu_types;
     mc->default_ram_size       = 512 * MiB;
     mc->default_cpus = mc->min_cpus = mc->max_cpus =
         aspeed_soc_num_cpus(amc->soc_name);
@@ -1306,6 +1315,7 @@ static void aspeed_machine_tiogapass_class_init(ObjectClass *oc, void *data)
     amc->spi_model = "mx25l25635e";
     amc->num_cs    = 2;
     amc->i2c_init  = tiogapass_bmc_i2c_init;
+    mc->valid_cpu_types = ast2500_a1_valid_cpu_types;
     mc->default_ram_size       = 1 * GiB;
     mc->default_cpus = mc->min_cpus = mc->max_cpus =
         aspeed_soc_num_cpus(amc->soc_name);
@@ -1324,6 +1334,7 @@ static void aspeed_machine_sonorapass_class_init(ObjectClass *oc, void *data)
     amc->spi_model = "mx66l1g45g";
     amc->num_cs    = 2;
     amc->i2c_init  = sonorapass_bmc_i2c_init;
+    mc->valid_cpu_types = ast2500_a1_valid_cpu_types;
     mc->default_ram_size       = 512 * MiB;
     mc->default_cpus = mc->min_cpus = mc->max_cpus =
         aspeed_soc_num_cpus(amc->soc_name);
@@ -1341,6 +1352,7 @@ static void aspeed_machine_witherspoon_class_init(ObjectClass *oc, void *data)
     amc->spi_model = "mx66l1g45g";
     amc->num_cs    = 2;
     amc->i2c_init  = witherspoon_bmc_i2c_init;
+    mc->valid_cpu_types = ast2500_a1_valid_cpu_types;
     mc->default_ram_size = 512 * MiB;
     mc->default_cpus = mc->min_cpus = mc->max_cpus =
         aspeed_soc_num_cpus(amc->soc_name);
@@ -1398,6 +1410,7 @@ static void aspeed_machine_g220a_class_init(ObjectClass *oc, void *data)
     amc->num_cs    = 2;
     amc->macs_mask  = ASPEED_MAC0_ON | ASPEED_MAC1_ON;
     amc->i2c_init  = g220a_bmc_i2c_init;
+    mc->valid_cpu_types = ast2500_a1_valid_cpu_types;
     mc->default_ram_size = 1024 * MiB;
     mc->default_cpus = mc->min_cpus = mc->max_cpus =
         aspeed_soc_num_cpus(amc->soc_name);
@@ -1416,6 +1429,7 @@ static void aspeed_machine_fp5280g2_class_init(ObjectClass *oc, void *data)
     amc->num_cs    = 2;
     amc->macs_mask  = ASPEED_MAC0_ON | ASPEED_MAC1_ON;
     amc->i2c_init  = fp5280g2_bmc_i2c_init;
+    mc->valid_cpu_types = ast2500_a1_valid_cpu_types;
     mc->default_ram_size = 512 * MiB;
     mc->default_cpus = mc->min_cpus = mc->max_cpus =
         aspeed_soc_num_cpus(amc->soc_name);
-- 
2.41.0


