Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0019680F28B
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 17:30:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD5dr-0000qA-Sn; Tue, 12 Dec 2023 11:29:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD5dn-0000pW-0j
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 11:29:51 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD5dl-0006x6-8M
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 11:29:50 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a1e35c2807fso782194066b.3
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 08:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702398587; x=1703003387; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5LE88JwgY2y1IWpLN7sGqf0VCLp2wC33lSYw5ePt+UY=;
 b=b4LlBkNfYNdiIPsSP5DJATsEuaydfYIN6POSs/30b+rNy9NuOy8YbTCXvBxdy9s/rU
 tg1iDozWceGtVhpnSEk2viHwR+nAkehECChv2pX4G5v0ImA6KidVOiGUwY56C0yq/Cm8
 vMSwenjzcuDqBJnnISijtUo89/FBUZoie7TqmLVxckVt6iyXSA9pPuXt5g1tFUOLtL8v
 xju4lDJIAWHsZvSMALuZMqJGQgq59eHyMxMwm9sTMVmgduFuomdoWOHWXaPWiv54imD+
 IZVgD/+taXt6sRhih3Xxm00eRnqKyK29iXURM1v0I5bnHH9gnjHWunGDRT8eHCwAQ+K3
 EY4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702398587; x=1703003387;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5LE88JwgY2y1IWpLN7sGqf0VCLp2wC33lSYw5ePt+UY=;
 b=OKMfxbXK7sxCgDegu2PwzckJL69go1Yg9ILjcpBscggCCtsS/d6YDDlUGd0yX9sFWs
 lqkm+f9tCbzx3KdNZU2EuJ0SJ7g+I1QU/ieM9YMbaHyFweIcZv6RlMc+YFEjmSX0mJct
 k34OyIgCXlR4gzUT9OxzV8vF5St7CUhxnklcM66wRqJkwtN9MoReVjxqrtR23J7l93Sa
 UNU86AyFpIJSePj7c4EPCUtRZi++FmuFeyuASalfNSfGV7jP2kb5lIsy/z7A1gEVjIUZ
 7KUPEbDYSQQ1Fh304RFk5xCbF92szkGauhI3f1lhXBG1E3DMpv6ehZ6r36fhEEOR1cUC
 ngyw==
X-Gm-Message-State: AOJu0YxO2EGgM/JI2zDpdCd0X7H9eWEoMKFtVIWs39Ef5DO1jv5Z6Pev
 lZZZk8bgSZTRW40tklaG8bY++Hsq+gSgfmsWSLA=
X-Google-Smtp-Source: AGHT+IEOz/3cPUYqj6E9+MY5U0yMjwZ0gN3IV8bI14iEHt40pSfIVR1T2gW74N0fBanDA7gfEviJEA==
X-Received: by 2002:a17:906:414f:b0:a00:b4ab:cb6d with SMTP id
 l15-20020a170906414f00b00a00b4abcb6dmr2946269ejk.69.1702398587565; 
 Tue, 12 Dec 2023 08:29:47 -0800 (PST)
Received: from m1x-phil.lan ([176.176.175.193])
 by smtp.gmail.com with ESMTPSA id
 vs6-20020a170907a58600b00a1f99e749dasm3754142ejc.210.2023.12.12.08.29.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Dec 2023 08:29:47 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Tyrone Ting <kfting@nuvoton.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>, Anton Johansson <anjo@rev.ng>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Hao Wu <wuhaotsh@google.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Rob Herring <robh@kernel.org>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 01/33] hw/arm/boot: Propagate vCPU to arm_load_dtb()
Date: Tue, 12 Dec 2023 17:29:01 +0100
Message-ID: <20231212162935.42910-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231212162935.42910-1-philmd@linaro.org>
References: <20231212162935.42910-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
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

In heterogeneous setup the first vCPU might not be
the one expected, better pass it explicitly.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/arm/boot.h |  4 +++-
 hw/arm/boot.c         | 11 ++++++-----
 hw/arm/virt.c         |  2 +-
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/include/hw/arm/boot.h b/include/hw/arm/boot.h
index 80c492d742..b12bf61ca8 100644
--- a/include/hw/arm/boot.h
+++ b/include/hw/arm/boot.h
@@ -160,6 +160,7 @@ AddressSpace *arm_boot_address_space(ARMCPU *cpu,
  * @binfo:      struct describing the boot environment
  * @addr_limit: upper limit of the available memory area at @addr
  * @as:         address space to load image to
+ * @cpu:        ARM CPU object
  *
  * Load a device tree supplied by the machine or by the user  with the
  * '-dtb' command line option, and put it at offset @addr in target
@@ -176,7 +177,8 @@ AddressSpace *arm_boot_address_space(ARMCPU *cpu,
  * Note: Must not be called unless have_dtb(binfo) is true.
  */
 int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
-                 hwaddr addr_limit, AddressSpace *as, MachineState *ms);
+                 hwaddr addr_limit, AddressSpace *as, MachineState *ms,
+                 ARMCPU *cpu);
 
 /* Write a secure board setup routine with a dummy handler for SMCs */
 void arm_write_secure_board_setup_dummy_smc(ARMCPU *cpu,
diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 84ea6a807a..334e4640fd 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -432,13 +432,12 @@ out:
     return ret;
 }
 
-static void fdt_add_psci_node(void *fdt)
+static void fdt_add_psci_node(void *fdt, ARMCPU *armcpu)
 {
     uint32_t cpu_suspend_fn;
     uint32_t cpu_off_fn;
     uint32_t cpu_on_fn;
     uint32_t migrate_fn;
-    ARMCPU *armcpu = ARM_CPU(qemu_get_cpu(0));
     const char *psci_method;
     int64_t psci_conduit;
     int rc;
@@ -512,7 +511,8 @@ static void fdt_add_psci_node(void *fdt)
 }
 
 int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
-                 hwaddr addr_limit, AddressSpace *as, MachineState *ms)
+                 hwaddr addr_limit, AddressSpace *as, MachineState *ms,
+                 ARMCPU *cpu)
 {
     void *fdt = NULL;
     int size, rc, n = 0;
@@ -655,7 +655,7 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
         }
     }
 
-    fdt_add_psci_node(fdt);
+    fdt_add_psci_node(fdt, cpu);
 
     if (binfo->modify_dtb) {
         binfo->modify_dtb(binfo, fdt);
@@ -1321,7 +1321,8 @@ void arm_load_kernel(ARMCPU *cpu, MachineState *ms, struct arm_boot_info *info)
      * decided whether to enable PSCI and set the psci-conduit CPU properties.
      */
     if (!info->skip_dtb_autoload && have_dtb(info)) {
-        if (arm_load_dtb(info->dtb_start, info, info->dtb_limit, as, ms) < 0) {
+        if (arm_load_dtb(info->dtb_start, info, info->dtb_limit,
+                         as, ms, cpu) < 0) {
             exit(1);
         }
     }
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index be2856c018..4a1d1550f5 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1678,7 +1678,7 @@ void virt_machine_done(Notifier *notifier, void *data)
                                        vms->memmap[VIRT_PLATFORM_BUS].size,
                                        vms->irqmap[VIRT_PLATFORM_BUS]);
     }
-    if (arm_load_dtb(info->dtb_start, info, info->dtb_limit, as, ms) < 0) {
+    if (arm_load_dtb(info->dtb_start, info, info->dtb_limit, as, ms, cpu) < 0) {
         exit(1);
     }
 
-- 
2.41.0


