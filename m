Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F5A83879C
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 07:40:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSARQ-0003lm-3m; Tue, 23 Jan 2024 01:39:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSARE-0003YF-Ba
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 01:39:12 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSARC-00085H-R0
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 01:39:12 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a308db01df6so131907166b.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 22:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705991949; x=1706596749; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TGD5FLvwAQGOZbUBjumYjpCbltGmL2kWHmZW0fC4bQw=;
 b=Wx3QmEKNfmy5DWwig7dxnedD/Y67Z+1/RP6+05kDmz+x3XPwmMgDn6eRhP95++Mch5
 tGkqY6OVS4SWk1M2XCCvJi87c+qje9O4bNGPFWkyKeyd+naSN22w4SwAfsKruQD2xe5F
 bCk7J6V8qKGnn0p5Gb8ErCEku6rtWCzccqdg+cKChc8fg6CGBudxyFcrAzyQwho8Quy/
 aczH9Lu7Oo3mXwbF17oODeyPh0eIkOCmDmgNZkg8M6b1Z8KcUHRVCsvzVNY/aMmGE8QW
 EOz5rppqAlf7dC8Pn0JC0AbhLsB8JmR9K2irBHbfZoXyHam5BdeotwZr4ctYWrql1wGj
 8fsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705991949; x=1706596749;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TGD5FLvwAQGOZbUBjumYjpCbltGmL2kWHmZW0fC4bQw=;
 b=iwmC5XMew3YTh02JGBfZ6dUrzxXzLBp4FoEYQvO4PofQIFg8k9qm9CEM2ernhZYP2h
 rHr3iTRLpm8aQhEEuviG3wog6eDhl1OGAqmgToK79+Q55+VY0Gp2onctYDD411EP9Wib
 3HO/DAplJxzI6sBLFUtduIH8ZAdLwSn2AJ4e75RSBdhGgpM4C+IzfKYRi1tNWaNEOoee
 SRtolMzw9WduJ5nFVcDcAjlmK39TDEaIN2PVjUAuB0tDRY62U0w2E8fnU0Mkq46UmVY2
 mPV/yv5EaNflV5wCc0yuiQquZajekYop3kAojACEMSrOZEBuZrgJHdh8tNKqh4YEjAKX
 Y0TA==
X-Gm-Message-State: AOJu0Yy/qScclHDrKTU1pOLHpxCwfTIco5NX2NzgmpBg4VsJLwVs+F30
 xjmWo/m+Mol7Fh96qWEbOlPnSa3GNh8zUk4VtSQVM47r9ZRuQrcyw+VDKKYRZJPzVPHwxGcGjVd
 oGek=
X-Google-Smtp-Source: AGHT+IE39a1Ddlk182Vwb1wKOGjDhDjdOIObhPFlOKYOCpJTl5rtIiky22F7ptTZXhXYN8KHljaj1A==
X-Received: by 2002:a17:906:1748:b0:a28:d1d7:c255 with SMTP id
 d8-20020a170906174800b00a28d1d7c255mr1280066eje.204.1705991949062; 
 Mon, 22 Jan 2024 22:39:09 -0800 (PST)
Received: from m1x-phil.lan ([176.187.194.78])
 by smtp.gmail.com with ESMTPSA id
 tj3-20020a170907c24300b00a30982ea105sm796938ejc.42.2024.01.22.22.39.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 22 Jan 2024 22:39:08 -0800 (PST)
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
Subject: [PATCH 4/8] hw/arm/aspeed/2400: Check for CPU types in
 machine_run_board_init()
Date: Tue, 23 Jan 2024 07:38:38 +0100
Message-ID: <20240123063842.35255-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240123063842.35255-1-philmd@linaro.org>
References: <20240123063842.35255-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
 hw/arm/aspeed.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index cc59176563..e0e0877b1d 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -1147,6 +1147,11 @@ static int aspeed_soc_num_cpus(const char *soc_name)
    return sc->num_cpus;
 }
 
+static const char * const ast2400_a1_valid_cpu_types[] = {
+    ARM_CPU_TYPE_NAME("arm926"),
+    NULL
+};
+
 static void aspeed_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -1175,6 +1180,7 @@ static void aspeed_machine_palmetto_class_init(ObjectClass *oc, void *data)
     amc->spi_model = "mx25l25635f";
     amc->num_cs    = 1;
     amc->i2c_init  = palmetto_bmc_i2c_init;
+    mc->valid_cpu_types = ast2400_a1_valid_cpu_types;
     mc->default_ram_size       = 256 * MiB;
     mc->default_cpus = mc->min_cpus = mc->max_cpus =
         aspeed_soc_num_cpus(amc->soc_name);
@@ -1192,6 +1198,7 @@ static void aspeed_machine_quanta_q71l_class_init(ObjectClass *oc, void *data)
     amc->spi_model = "mx25l25635e";
     amc->num_cs    = 1;
     amc->i2c_init  = quanta_q71l_bmc_i2c_init;
+    mc->valid_cpu_types = ast2400_a1_valid_cpu_types;
     mc->default_ram_size       = 128 * MiB;
     mc->default_cpus = mc->min_cpus = mc->max_cpus =
         aspeed_soc_num_cpus(amc->soc_name);
@@ -1211,6 +1218,7 @@ static void aspeed_machine_supermicrox11_bmc_class_init(ObjectClass *oc,
     amc->num_cs    = 1;
     amc->macs_mask = ASPEED_MAC0_ON | ASPEED_MAC1_ON;
     amc->i2c_init  = palmetto_bmc_i2c_init;
+    mc->valid_cpu_types = ast2400_a1_valid_cpu_types;
     mc->default_ram_size = 256 * MiB;
 }
 
-- 
2.41.0


