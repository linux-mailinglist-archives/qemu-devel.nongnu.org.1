Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6819B0001
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Oct 2024 12:23:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4HS1-0003mg-Mf; Fri, 25 Oct 2024 06:21:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1t4HRz-0003m5-0R
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 06:21:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1t4HRx-0000Pg-7o
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 06:21:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729851704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MQ5jYKg0eJx5SAN7xHGW4tHNDdpBbV4ElcQD0cCn3/s=;
 b=M9qeN7UOYb4rIOa6tW2sRf8MG6kVW9DIHuBokomQ+O191RFH2NpXKyzeuvpPfNCOYEBqVC
 KSYzQNKimkJVNLHl7duMhbqmWjr+LwmjeoSxMR7+82uj7HthdwjVFeUFqva7Dyzx49Phnw
 leYuc8EN7hHj1xrhIDcWtEoQZXKt3XA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-EiC2fFUHNCueFhCbzFsMZQ-1; Fri,
 25 Oct 2024 06:21:41 -0400
X-MC-Unique: EiC2fFUHNCueFhCbzFsMZQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C514B195608C; Fri, 25 Oct 2024 10:21:39 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.194.5])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6FC5A196BB7D; Fri, 25 Oct 2024 10:21:34 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, cohuck@redhat.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvmarm@lists.linux.dev,
 peter.maydell@linaro.org, richard.henderson@linaro.org,
 alex.bennee@linaro.org, maz@kernel.org, oliver.upton@linux.dev,
 sebott@redhat.com, shameerali.kolothum.thodi@huawei.com, armbru@redhat.com,
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com
Cc: shahuang@redhat.com, mark.rutland@arm.com, philmd@linaro.org,
 pbonzini@redhat.com
Subject: [RFC 13/21] arm/cpu: Add infra to handle generated ID register
 definitions
Date: Fri, 25 Oct 2024 12:17:32 +0200
Message-ID: <20241025101959.601048-14-eric.auger@redhat.com>
In-Reply-To: <20241025101959.601048-1-eric.auger@redhat.com>
References: <20241025101959.601048-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The known ID regs are described in a new initialization function
dubbed initialize_cpu_sysreg_properties(). That code will be
automatically generated from linux arch/arm64/tools/sysreg. For the
time being let's just describe a single id reg, CTR_EL0. In this
description we only care about non RES/RAZ fields, ie. named fields.

The registers are populated in a 3x8x8 array and their fields are
added in a sorted list.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 target/arm/cpu-custom.h            | 58 ++++++++++++++++++++++++++++++
 target/arm/cpu-sysreg-properties.c | 41 +++++++++++++++++++++
 target/arm/cpu64.c                 |  2 ++
 target/arm/meson.build             |  1 +
 4 files changed, 102 insertions(+)
 create mode 100644 target/arm/cpu-custom.h
 create mode 100644 target/arm/cpu-sysreg-properties.c

diff --git a/target/arm/cpu-custom.h b/target/arm/cpu-custom.h
new file mode 100644
index 0000000000..1952095bf7
--- /dev/null
+++ b/target/arm/cpu-custom.h
@@ -0,0 +1,58 @@
+#ifndef ARM_CPU_CUSTOM_H
+#define ARM_CPU_CUSTOM_H
+
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "cpu.h"
+#include "cpu-sysregs.h"
+
+typedef struct ARM64SysRegField {
+    const char *name; /* name of the field, for instance CTR_EL0_IDC */
+    int index;
+    int lower;
+    int upper;
+} ARM64SysRegField;
+
+typedef struct ARM64SysReg {
+    const char *name;   /* name of the sysreg, for instance CTR_EL0 */
+    ARMSysReg *sysreg;
+    int index;
+    GList *fields; /* list of named fields, excluding RES* */
+} ARM64SysReg;
+
+void initialize_cpu_sysreg_properties(void);
+
+/*
+ * List of exposed ID regs (automatically populated from linux
+ * arch/arm64/tools/sysreg)
+ */
+extern ARM64SysReg arm64_id_regs[NR_ID_REGS];
+
+/* Allocate a new field and insert it at the head of the @reg list */
+static inline GList *arm64_sysreg_add_field(ARM64SysReg *reg, const char *name,
+                                     uint8_t min, uint8_t max) {
+
+     ARM64SysRegField *field = g_new0(ARM64SysRegField, 1);
+
+     field->name = name;
+     field->lower = min;
+     field->upper = max;
+     field->index = reg->index;
+
+     reg->fields = g_list_append(reg->fields, field);
+     return reg->fields;
+}
+
+static inline ARM64SysReg *
+arm64_sysreg_get(int op0, int op1, int crn, int crm, int op2)
+{
+        uint64_t index = ARM_FEATURE_ID_RANGE_IDX(op0, op1, crn, crm, op2);
+        ARM64SysReg *reg = &arm64_id_regs[index];
+
+        reg->index = index;
+        reg->sysreg = g_new(ARMSysReg, 1);
+        *reg->sysreg = sys_reg(op0, op1, crn, crm, op2);
+        return reg;
+}
+
+#endif
diff --git a/target/arm/cpu-sysreg-properties.c b/target/arm/cpu-sysreg-properties.c
new file mode 100644
index 0000000000..753e7c9127
--- /dev/null
+++ b/target/arm/cpu-sysreg-properties.c
@@ -0,0 +1,41 @@
+/*
+ * QEMU ARM CPU SYSREG PROPERTIES
+ * to be generated from linux sysreg
+ *
+ * Copyright (c) 2024, Inc. 2024
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see
+ * <http://www.gnu.org/licenses/gpl-2.0.html>
+ */
+
+#include "cpu-custom.h"
+
+ARM64SysReg arm64_id_regs[NR_ID_REGS];
+
+void initialize_cpu_sysreg_properties(void)
+{
+    memset(arm64_id_regs, 0, sizeof(ARM64SysReg) * NR_ID_REGS);
+    /* CTR_EL0 */
+    ARM64SysReg *CTR_EL0 = arm64_sysreg_get(3, 3, 0, 0, 1);
+    CTR_EL0->name = "CTR_EL0";
+    arm64_sysreg_add_field(CTR_EL0, "TMinline", 32, 37);
+    arm64_sysreg_add_field(CTR_EL0, "DIC", 29, 29);
+    arm64_sysreg_add_field(CTR_EL0, "IDC", 28, 28);
+    arm64_sysreg_add_field(CTR_EL0, "CWG", 24, 27);
+    arm64_sysreg_add_field(CTR_EL0, "ERG", 20, 23);
+    arm64_sysreg_add_field(CTR_EL0, "DMinLine", 16, 19);
+    arm64_sysreg_add_field(CTR_EL0, "L1Ip", 14, 15);
+    arm64_sysreg_add_field(CTR_EL0, "IminLine", 0, 3);
+}
+
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 57e73fdd38..9f20886668 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -34,6 +34,7 @@
 #include "internals.h"
 #include "cpu-features.h"
 #include "cpregs.h"
+#include "cpu-custom.h"
 
 void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp)
 {
@@ -844,6 +845,7 @@ static void aarch64_cpu_register_types(void)
 {
     size_t i;
 
+    initialize_cpu_sysreg_properties();
     type_register_static(&aarch64_cpu_type_info);
 
     for (i = 0; i < ARRAY_SIZE(aarch64_cpus); ++i) {
diff --git a/target/arm/meson.build b/target/arm/meson.build
index 2e10464dbb..9c7a04ee1b 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -14,6 +14,7 @@ arm_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
 arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
   'cpu64.c',
   'gdbstub64.c',
+  'cpu-sysreg-properties.c',
 ))
 
 arm_system_ss = ss.source_set()
-- 
2.41.0


