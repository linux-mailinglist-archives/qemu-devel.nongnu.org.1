Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D1579844F
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 10:43:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeX4z-0003Le-1T; Fri, 08 Sep 2023 04:43:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qeX4t-000353-2q
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 04:42:59 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qeX4p-0004wa-MF
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 04:42:58 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-31f4a286ae1so1622074f8f.3
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 01:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694162573; x=1694767373; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WC5kdXoVXf7OSQC2004JIGL0JZd5FaBQWvQofN2yKyw=;
 b=pxHe083QqzCq9MPjusPOAzFYCgFpB+v9LiS6kt/+3FVpDO/uQc3u8yCGAm6BgAwodt
 ECSwBOEn9bQtq+mnH8TAuZR2ot/00owOpMuKTmu6ZzgImZ9TjSk2o6hwE4/snkGYpjlF
 2qIlJ+8ZkhCzom/HKSfUT2nTEIqxMjDT55YG5fUgt/92OgQv8V5EwU8BFkILWZ2bHThP
 1cTSDAUjWJvEWZEKdedEK//ljhisxN+qplVUJ/AJKrIg8rkcL2/dn7DKZv8wRMEIKWLl
 hdV7fcaznhFYRPxqYOzccMxhr2zeC8h5aOi+gf6OljJWKMGXIrz8Ft0bUSerMn8YJw2z
 dkXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694162573; x=1694767373;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WC5kdXoVXf7OSQC2004JIGL0JZd5FaBQWvQofN2yKyw=;
 b=Qg9D88jCVdoCwNUGqpXr9ygB/7zsrpOFj3DDLStc3DVTNYjA8JI0Ac4i1C7SxBNmDc
 +Pyc+Yj0kSKdatxHsCHmqm6NxuVlhIiSal7tGunxomNVCMA9urfPq+v8Y5T0pwq/wnU9
 dAz1DgGXKEwhchzK1VAHrOxkEYJ2rg4kIMhfaL4jpFbw9/xuLCi1LVxIst5DjxO7KoPP
 ttaj8UktLNCI7hatnsnK/WxZu7vIt27XJ4ljj3lYUYNjnfNR1AN/iz/iynf2x8aFhZUr
 NRYqLMmZTKTzUZUf/U47DfErsihpxeLMWlQJkz2WDDDqG3f8edLKer0SLoMaB6azTyGy
 cvGw==
X-Gm-Message-State: AOJu0YxHAjZ9Mx595qE4u4KDdS5GYQ2dZx1TOjtLEUPGcbckaeMcC6TA
 0MlkGohthDh6ifdAY13fsTpZ9BOQEm0=
X-Google-Smtp-Source: AGHT+IGQ4nZpYZZw3lw7eJboDRLTVvvCXPU+D/mcwQy+9BN56zgV9+C31VfNBni04zaakrlaxnWQJg==
X-Received: by 2002:adf:e987:0:b0:31d:cd2f:4a4b with SMTP id
 h7-20020adfe987000000b0031dcd2f4a4bmr1455516wrm.50.1694162573027; 
 Fri, 08 Sep 2023 01:42:53 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-078-054-093-170.78.54.pool.telefonica.de. [78.54.93.170])
 by smtp.gmail.com with ESMTPSA id
 h17-20020a056000001100b003197c2316ecsm1462139wrx.112.2023.09.08.01.42.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 01:42:52 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Aurelien Jarno <aurelien@aurel32.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 8/8] hw/acpi/core: Trace enable and status registers of GPE
 separately
Date: Fri,  8 Sep 2023 10:42:34 +0200
Message-ID: <20230908084234.17642-9-shentey@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230908084234.17642-1-shentey@gmail.com>
References: <20230908084234.17642-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The bit positions of both registers are related. Tracing the registers
independently results in the same offsets across these registers which
eases debugging.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/acpi/core.c       | 10 +++++++---
 hw/acpi/trace-events |  6 ++++--
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/hw/acpi/core.c b/hw/acpi/core.c
index c561845a4a..ec5e127d17 100644
--- a/hw/acpi/core.c
+++ b/hw/acpi/core.c
@@ -687,13 +687,13 @@ void acpi_gpe_ioport_writeb(ACPIREGS *ar, uint32_t addr, uint32_t val)
 {
     uint8_t *cur;
 
-    trace_acpi_gpe_ioport_writeb(addr, val);
-
     cur = acpi_gpe_ioport_get_ptr(ar, addr);
     if (addr < ar->gpe.len / 2) {
+        trace_acpi_gpe_sts_ioport_writeb(addr, val);
         /* GPE_STS */
         *cur = (*cur) & ~val;
     } else if (addr < ar->gpe.len) {
+        trace_acpi_gpe_en_ioport_writeb(addr - (ar->gpe.len / 2), val);
         /* GPE_EN */
         *cur = val;
     } else {
@@ -712,7 +712,11 @@ uint32_t acpi_gpe_ioport_readb(ACPIREGS *ar, uint32_t addr)
         val = *cur;
     }
 
-    trace_acpi_gpe_ioport_readb(addr, val);
+    if (addr < ar->gpe.len / 2) {
+        trace_acpi_gpe_sts_ioport_readb(addr, val);
+    } else {
+        trace_acpi_gpe_en_ioport_readb(addr - (ar->gpe.len / 2), val);
+    }
 
     return val;
 }
diff --git a/hw/acpi/trace-events b/hw/acpi/trace-events
index 159937ddb9..edc93e703c 100644
--- a/hw/acpi/trace-events
+++ b/hw/acpi/trace-events
@@ -18,8 +18,10 @@ mhp_acpi_pc_dimm_deleted(uint32_t slot) "slot[0x%"PRIx32"] pc-dimm deleted"
 mhp_acpi_pc_dimm_delete_failed(uint32_t slot) "slot[0x%"PRIx32"] pc-dimm delete failed"
 
 # core.c
-acpi_gpe_ioport_readb(uint32_t addr, uint8_t val) "addr: 0x%" PRIx32 " ==> 0x%" PRIx8
-acpi_gpe_ioport_writeb(uint32_t addr, uint8_t val) "addr: 0x%" PRIx32 " <== 0x%" PRIx8
+acpi_gpe_en_ioport_readb(uint32_t addr, uint8_t val) "addr: 0x%" PRIx32 " ==> 0x%02" PRIx8
+acpi_gpe_en_ioport_writeb(uint32_t addr, uint8_t val) "addr: 0x%" PRIx32 " <== 0x%02" PRIx8
+acpi_gpe_sts_ioport_readb(uint32_t addr, uint8_t val) "addr: 0x%" PRIx32 " ==> 0x%02" PRIx8
+acpi_gpe_sts_ioport_writeb(uint32_t addr, uint8_t val) "addr: 0x%" PRIx32 " <== 0x%02" PRIx8
 
 # cpu.c
 cpuhp_acpi_invalid_idx_selected(uint32_t idx) "0x%"PRIx32
-- 
2.42.0


