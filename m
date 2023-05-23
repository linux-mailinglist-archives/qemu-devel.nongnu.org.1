Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0289C70D43C
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 08:45:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Ll1-0001uP-HN; Tue, 23 May 2023 02:44:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1Lkw-0001tU-M9
 for qemu-devel@nongnu.org; Tue, 23 May 2023 02:44:27 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1Lku-0002fT-Si
 for qemu-devel@nongnu.org; Tue, 23 May 2023 02:44:26 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3f607dc98cdso10150235e9.1
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 23:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684824263; x=1687416263;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gPBH60YOMI3nzrM9MwhgMu04H1kPb+OX0SImhK5mfvI=;
 b=RcOJBU55r0Sut0VxWK0l9bLSNdcBC1Q3Z5hIkFEWKkKRC3zVn2D8KaKQMJPUSuuCJT
 ixhTImi4FafW5e0jtcC4xBrmMZUDMMKbymKzVsb6RdkXpBS4g/nDqnm1zxN2TR9KWfcf
 VNA/zyvgEfjMrZVnAjsD5ozJydqFstLfDQ0Q8RcmEIUGF9A+cvXCK1pC0iSyb5xvOVBF
 wIS4Vd5C4TIFvkkb0kyzP3dCIEx1ZeXEOjYzAl+xsT2+BXlTQPCPmnQT2TxV3Euo2Bbq
 qadUWz/b8jz4bv2sgqKVFDpF1nwbr2rQpxcAge5dwen26gQ7uBs+ZTV5B7phbzRz1Ymw
 5E+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684824263; x=1687416263;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gPBH60YOMI3nzrM9MwhgMu04H1kPb+OX0SImhK5mfvI=;
 b=AxlxX1AT12jlW5JDW8a0EXg/n8PSnOl5+Ob09pssenZsk/ETNQj2yMPxLM9mrVxagY
 98rbnkNhjVqKPKo6hDCJfndYHvvunzYqnr2DDOSG7aOkhZbAG/W3SZXJ3wUVG4JFphNX
 WAhJPp8eweSxtYFu0CBnia8/YmfGTroeUlDVRj3jA/zao/yqt/RBJFfHVEdj96cMhTeC
 pNFihekvw8aTjokggJ7XESAytJTiicmXcGsyJGSX6sao4NQs4C9atijVs6z4NHSR4aLC
 nT8GYsq3bxb+vsowCMA19p8yBi1/JiNIBQEqvxmi7Z3jbBoIl8DKJXGMMxpsqaBjcWT6
 f05Q==
X-Gm-Message-State: AC+VfDyJ9SCKM3StILMBM7SqFgsbcPxBPp9aX2vp56sNHA12vyztLdqY
 paSKlIevxoMCVM60zu/soCbYS76dAsxacgJhd/U=
X-Google-Smtp-Source: ACHHUZ4nY5SkfIJWixLkLhnfifbsIA94PhEi9T+06XW7Zl8iPiAs+MQl37OoxRifgbq8+aey8BMoIw==
X-Received: by 2002:a7b:cd11:0:b0:3f6:91c:4e86 with SMTP id
 f17-20020a7bcd11000000b003f6091c4e86mr1333117wmj.3.1684824263027; 
 Mon, 22 May 2023 23:44:23 -0700 (PDT)
Received: from localhost.localdomain
 (vil69-h02-176-184-48-94.dsl.sta.abo.bbox.fr. [176.184.48.94])
 by smtp.gmail.com with ESMTPSA id
 f4-20020a1c6a04000000b003f1978bbcd6sm1421092wmc.3.2023.05.22.23.44.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 22 May 2023 23:44:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-ppc@nongnu.org,
 Titus Rwantare <titusr@google.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stuart Yoder <stuart.yoder@freescale.com>, Alexander Graf <agraf@csgraf.de>
Subject: [PATCH 2/3] hw/ppc/e500plat: Fix modifying QOM class internal state
 from instance
Date: Tue, 23 May 2023 08:44:07 +0200
Message-Id: <20230523064408.57941-3-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230523064408.57941-1-philmd@linaro.org>
References: <20230523064408.57941-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

QOM object instance should not modify its class state (because
all other objects instanciated from this class get affected).

Instead of modifying the PPCE500MachineClass 'mpic_version' field
in the instance machine_init() handler, set it in the machine
class init handler (e500plat_machine_class_init).

Inspired-by: Bernhard Beschow <shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/e500plat.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/hw/ppc/e500plat.c b/hw/ppc/e500plat.c
index 3032bd3f6d..c3b0ed01cf 100644
--- a/hw/ppc/e500plat.c
+++ b/hw/ppc/e500plat.c
@@ -30,18 +30,6 @@ static void e500plat_fixup_devtree(void *fdt)
                      sizeof(compatible));
 }
 
-static void e500plat_init(MachineState *machine)
-{
-    PPCE500MachineClass *pmc = PPCE500_MACHINE_GET_CLASS(machine);
-    /* Older KVM versions don't support EPR which breaks guests when we announce
-       MPIC variants that support EPR. Revert to an older one for those */
-    if (kvm_enabled() && !kvmppc_has_cap_epr()) {
-        pmc->mpic_version = OPENPIC_MODEL_FSL_MPIC_20;
-    }
-
-    ppce500_init(machine);
-}
-
 static void e500plat_machine_device_plug_cb(HotplugHandler *hotplug_dev,
                                             DeviceState *dev, Error **errp)
 {
@@ -81,7 +69,6 @@ static void e500plat_machine_class_init(ObjectClass *oc, void *data)
     pmc->pci_first_slot = 0x1;
     pmc->pci_nr_slots = PCI_SLOT_MAX - 1;
     pmc->fixup_devtree = e500plat_fixup_devtree;
-    pmc->mpic_version = OPENPIC_MODEL_FSL_MPIC_42;
     pmc->has_mpc8xxx_gpio = true;
     pmc->has_esdhc = true;
     pmc->platform_bus_base = 0xf00000000ULL;
@@ -94,8 +81,18 @@ static void e500plat_machine_class_init(ObjectClass *oc, void *data)
     pmc->pci_mmio_bus_base = 0xE0000000ULL;
     pmc->spin_base = 0xFEF000000ULL;
 
+    if (kvm_enabled() && !kvmppc_has_cap_epr()) {
+        /*
+         * Older KVM versions don't support EPR which breaks guests when
+         * we announce MPIC variants that support EPR. Revert to an older
+         * one for those.
+         */
+        pmc->mpic_version = OPENPIC_MODEL_FSL_MPIC_20;
+    } else {
+        pmc->mpic_version = OPENPIC_MODEL_FSL_MPIC_42;
+    }
+
     mc->desc = "generic paravirt e500 platform";
-    mc->init = e500plat_init;
     mc->max_cpus = 32;
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("e500v2_v30");
     mc->default_ram_id = "mpc8544ds.ram";
-- 
2.38.1


