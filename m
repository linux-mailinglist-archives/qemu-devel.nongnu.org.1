Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D5F7CFB07
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:30:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtT44-0003lJ-9L; Thu, 19 Oct 2023 09:27:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1qtT3y-0003gn-6Y
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:27:46 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1qtT3v-0006ct-3q
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:27:45 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6b26a3163acso5347020b3a.2
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 06:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1697722062; x=1698326862; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SbaLv4kYEsPo1ljv3SbCsGVMAu4JZMp9PbU44stYxNc=;
 b=WtvT+885iVk4b5KKKa8SZlyxhG5X/S9YtL4HqzGZroSsDFCepkkoSpLfiVrHmHaO+V
 IQ3Z0DQZ1PsNxn0M/pwuZvsrUZrxdztu/mpTsqIwbzuG+syXHPo9FwGlT+/DjPr495JK
 HU8s0MFSsxdQx9PESuNV5+9MhcChP123y4pa6yd4hCFCJxBLxIOUm0h+cr/Ql0UBBWgn
 CikBqVYfe5Er82wShkjdOq45tWJ7+Ud/Q0UeSLch0KRdgrhPENJoUO7VSZ7wYJNj80JS
 lH877aAKw1JgOPoZNRVlU7a3ALtnp1mpwfr2OQw7CmF2E2DrFfxRpbVzNanRQaFfVFCW
 +6ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697722062; x=1698326862;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SbaLv4kYEsPo1ljv3SbCsGVMAu4JZMp9PbU44stYxNc=;
 b=cw8id0fOV817trPDL9wMm/T4cDhpi6WkmoO857bpqPTNbEZrnE86vLyjh+rBMk9vBk
 hrWSjgD99Tp53rEcIRR5m33NsrYAwKMQxdJrTpW8xW0h1VnchycFK0t8VL1N6QWPOhfD
 G6/ooPQ5sqCtyAmPagbBap9GmcW+j761uJSsZ5nXI58b7QKQVp1HLcdM/RK0Dbe58irV
 IyLhfUR1k6u9aXSMLPxP8O7y0G5gfCXXqZj60ltb921h0b9lCn3PhQzPlMlKn5U4c/4a
 hHzcBrepcNE3GjXYih4+mLBfJqly9G0CgOoLApdHrle9EFiu0AN63yMoIqxtEhT3DFpI
 DJyA==
X-Gm-Message-State: AOJu0YxrpxcaA9T1QpCVynqjUL87+nUN8GZSkx1DJYPHKjhf7DwhuXF1
 0zYJaTTdTMFt/fd1AVSBquxz+g==
X-Google-Smtp-Source: AGHT+IEBrtJmmbSoR/tTnNQvSKt0uCkbMpsv/yDTVNl2wm6F3RjPB10tV+tsRY5dUHeCv0htRn4ZHw==
X-Received: by 2002:a05:6a00:994:b0:692:822a:2250 with SMTP id
 u20-20020a056a00099400b00692822a2250mr2162885pfg.17.1697722061688; 
 Thu, 19 Oct 2023 06:27:41 -0700 (PDT)
Received: from sunil-laptop.dc1.ventanamicro.com
 ([2409:4071:6e8b:3a98:dd76:4e82:7da6:44ab])
 by smtp.gmail.com with ESMTPSA id
 f11-20020a056a00228b00b0068feb378b89sm5273113pfe.171.2023.10.19.06.27.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 06:27:41 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: qemu-riscv@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Shannon Zhao <shannon.zhaosl@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Anup Patel <apatel@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Atish Kumar Patra <atishp@rivosinc.com>, Haibo Xu <haibo1.xu@intel.com>,
 Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v3 03/12] hw/riscv: virt: Make few IMSIC macros and functions
 public
Date: Thu, 19 Oct 2023 18:56:39 +0530
Message-Id: <20231019132648.23703-4-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019132648.23703-1-sunilvl@ventanamicro.com>
References: <20231019132648.23703-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Some macros and static function related to IMSIC are defined in virt.c.
They are required in virt-acpi-build.c. So, make them public.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt.c         | 25 +------------------------
 include/hw/riscv/virt.h | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 1732c42915..085654ab2f 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -38,7 +38,6 @@
 #include "kvm/kvm_riscv.h"
 #include "hw/intc/riscv_aclint.h"
 #include "hw/intc/riscv_aplic.h"
-#include "hw/intc/riscv_imsic.h"
 #include "hw/intc/sifive_plic.h"
 #include "hw/misc/sifive_test.h"
 #include "hw/platform-bus.h"
@@ -54,28 +53,6 @@
 #include "hw/acpi/aml-build.h"
 #include "qapi/qapi-visit-common.h"
 
-/*
- * The virt machine physical address space used by some of the devices
- * namely ACLINT, PLIC, APLIC, and IMSIC depend on number of Sockets,
- * number of CPUs, and number of IMSIC guest files.
- *
- * Various limits defined by VIRT_SOCKETS_MAX_BITS, VIRT_CPUS_MAX_BITS,
- * and VIRT_IRQCHIP_MAX_GUESTS_BITS are tuned for maximum utilization
- * of virt machine physical address space.
- */
-
-#define VIRT_IMSIC_GROUP_MAX_SIZE      (1U << IMSIC_MMIO_GROUP_MIN_SHIFT)
-#if VIRT_IMSIC_GROUP_MAX_SIZE < \
-    IMSIC_GROUP_SIZE(VIRT_CPUS_MAX_BITS, VIRT_IRQCHIP_MAX_GUESTS_BITS)
-#error "Can't accommodate single IMSIC group in address space"
-#endif
-
-#define VIRT_IMSIC_MAX_SIZE            (VIRT_SOCKETS_MAX * \
-                                        VIRT_IMSIC_GROUP_MAX_SIZE)
-#if 0x4000000 < VIRT_IMSIC_MAX_SIZE
-#error "Can't accommodate all IMSIC groups in address space"
-#endif
-
 /* KVM AIA only supports APLIC MSI. APLIC Wired is always emulated by QEMU. */
 static bool virt_use_kvm_aia(RISCVVirtState *s)
 {
@@ -512,7 +489,7 @@ static void create_fdt_socket_plic(RISCVVirtState *s,
     g_free(plic_cells);
 }
 
-static uint32_t imsic_num_bits(uint32_t count)
+uint32_t imsic_num_bits(uint32_t count)
 {
     uint32_t ret = 0;
 
diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index e5c474b26e..5b03575ed3 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -23,6 +23,7 @@
 #include "hw/riscv/riscv_hart.h"
 #include "hw/sysbus.h"
 #include "hw/block/flash.h"
+#include "hw/intc/riscv_imsic.h"
 
 #define VIRT_CPUS_MAX_BITS             9
 #define VIRT_CPUS_MAX                  (1 << VIRT_CPUS_MAX_BITS)
@@ -127,4 +128,28 @@ enum {
 
 bool virt_is_acpi_enabled(RISCVVirtState *s);
 void virt_acpi_setup(RISCVVirtState *vms);
+uint32_t imsic_num_bits(uint32_t count);
+
+/*
+ * The virt machine physical address space used by some of the devices
+ * namely ACLINT, PLIC, APLIC, and IMSIC depend on number of Sockets,
+ * number of CPUs, and number of IMSIC guest files.
+ *
+ * Various limits defined by VIRT_SOCKETS_MAX_BITS, VIRT_CPUS_MAX_BITS,
+ * and VIRT_IRQCHIP_MAX_GUESTS_BITS are tuned for maximum utilization
+ * of virt machine physical address space.
+ */
+
+#define VIRT_IMSIC_GROUP_MAX_SIZE      (1U << IMSIC_MMIO_GROUP_MIN_SHIFT)
+#if VIRT_IMSIC_GROUP_MAX_SIZE < \
+    IMSIC_GROUP_SIZE(VIRT_CPUS_MAX_BITS, VIRT_IRQCHIP_MAX_GUESTS_BITS)
+#error "Can't accomodate single IMSIC group in address space"
+#endif
+
+#define VIRT_IMSIC_MAX_SIZE            (VIRT_SOCKETS_MAX * \
+                                        VIRT_IMSIC_GROUP_MAX_SIZE)
+#if 0x4000000 < VIRT_IMSIC_MAX_SIZE
+#error "Can't accomodate all IMSIC groups in address space"
+#endif
+
 #endif
-- 
2.34.1


