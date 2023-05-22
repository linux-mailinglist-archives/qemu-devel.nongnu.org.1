Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E2970BC54
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 13:51:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q144C-0005SF-1V; Mon, 22 May 2023 07:51:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q143d-0005Bo-Dc
 for qemu-devel@nongnu.org; Mon, 22 May 2023 07:50:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q143b-0007aK-IV
 for qemu-devel@nongnu.org; Mon, 22 May 2023 07:50:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684756231;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8p0yTdOmJV24/CP57Pqp4VRWyFvcmAqGxBNcQQwP4Pg=;
 b=SlGhN3JcS9CDEfp+XPO3UOakM8/WbJ+4Xazf8E+g0sb/zvFBWecpp7BR/qIeaQPooHT2Nf
 0qHj2goB9yniCN1o3hDW0t0Dg79sZFi++dks5PN2C/5UNQkvRrJQiK92ta6t9pHESH9cap
 XObKcEoI1YspImqFSuAuGYKwKTeW9ak=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-379-EWwMCyumNkqGGalyNLWl1A-1; Mon, 22 May 2023 07:50:27 -0400
X-MC-Unique: EWwMCyumNkqGGalyNLWl1A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3A155811E85;
 Mon, 22 May 2023 11:50:27 +0000 (UTC)
Received: from thuth.com (unknown [10.39.195.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 79E762166B26;
 Mon, 22 May 2023 11:50:26 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 09/20] hw/i386: Ignore the default parallel port if it has not
 been compiled into QEMU
Date: Mon, 22 May 2023 13:50:03 +0200
Message-Id: <20230522115014.1110840-10-thuth@redhat.com>
In-Reply-To: <20230522115014.1110840-1-thuth@redhat.com>
References: <20230522115014.1110840-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Don't try to instantiate the parallel port if it has not been
enabled in the build configuration.

Message-Id: <20230512124033.502654-10-thuth@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/i386/pc_piix.c | 3 +++
 hw/i386/pc_q35.c  | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 17892ad580..d5b0dcd1fe 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -26,6 +26,7 @@
 #include CONFIG_DEVICES
 
 #include "qemu/units.h"
+#include "hw/char/parallel.h"
 #include "hw/dma/i8257.h"
 #include "hw/loader.h"
 #include "hw/i386/x86.h"
@@ -458,6 +459,7 @@ static void pc_i440fx_machine_options(MachineClass *m)
     m->default_machine_opts = "firmware=bios-256k.bin";
     m->default_display = "std";
     m->default_nic = "e1000";
+    m->no_parallel = !module_object_class_by_name(TYPE_ISA_PARALLEL);
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_RAMFB_DEVICE);
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_VMBUS_BRIDGE);
 }
@@ -886,6 +888,7 @@ static void isapc_machine_options(MachineClass *m)
     pcmc->has_reserved_memory = false;
     m->default_nic = "ne2k_isa";
     m->default_cpu_type = X86_CPU_TYPE_NAME("486");
+    m->no_parallel = !module_object_class_by_name(TYPE_ISA_PARALLEL);
 }
 
 DEFINE_PC_MACHINE(isapc, "isapc", pc_init_isa,
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 7e0f354edd..6155427e48 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -30,6 +30,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/units.h"
+#include "hw/char/parallel.h"
 #include "hw/loader.h"
 #include "hw/i2c/smbus_eeprom.h"
 #include "hw/rtc/mc146818rtc.h"
@@ -367,6 +368,7 @@ static void pc_q35_machine_options(MachineClass *m)
     m->default_nic = "e1000e";
     m->default_kernel_irqchip_split = false;
     m->no_floppy = 1;
+    m->no_parallel = !module_object_class_by_name(TYPE_ISA_PARALLEL);
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_AMD_IOMMU_DEVICE);
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_INTEL_IOMMU_DEVICE);
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_RAMFB_DEVICE);
-- 
2.31.1


