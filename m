Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD9EA888BE
	for <lists+qemu-devel@lfdr.de>; Mon, 14 Apr 2025 18:41:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4MrG-0004rE-Gv; Mon, 14 Apr 2025 12:40:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1u4Mqa-0004hl-6v
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 12:39:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1u4MqV-0005v6-QK
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 12:39:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744648781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ST/Epdwc6K7kU2DxufZKND7JF8yJCWJgqDVNPy8cEvo=;
 b=WDgSr+x5Z2BAjSmlMXLf5lHhpXCk1+9X1GjvhjQWT5mmlIXsJr8HcsEqrn1NcAvJzc3QuF
 FjsiC6TvOqxlk3lUzQOHb8i6E+D+KcHMpoI4uubHc2zC9FQxQpbxz4ltvu+Bx6/WEQdMPi
 ue7buYvx7NWoY8CUVW9Frm9V7hGvvDI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-20-amOgVnpCMKCnzCTnfgOphQ-1; Mon,
 14 Apr 2025 12:39:33 -0400
X-MC-Unique: amOgVnpCMKCnzCTnfgOphQ-1
X-Mimecast-MFC-AGG-ID: amOgVnpCMKCnzCTnfgOphQ_1744648771
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 164381956087; Mon, 14 Apr 2025 16:39:30 +0000 (UTC)
Received: from gondolin.redhat.com (unknown [10.67.24.14])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9D4AD180AF7C; Mon, 14 Apr 2025 16:39:14 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, peter.maydell@linaro.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 oliver.upton@linux.dev, sebott@redhat.com,
 shameerali.kolothum.thodi@huawei.com, armbru@redhat.com,
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com
Cc: agraf@csgraf.de, shahuang@redhat.com, mark.rutland@arm.com,
 philmd@linaro.org, pbonzini@redhat.com, Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH v3 01/10] arm/cpu: Add infra to handle generated ID register
 definitions
Date: Mon, 14 Apr 2025 18:38:40 +0200
Message-ID: <20250414163849.321857-2-cohuck@redhat.com>
In-Reply-To: <20250414163849.321857-1-cohuck@redhat.com>
References: <20250414163849.321857-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Eric Auger <eric.auger@redhat.com>

The known ID regs are described in a new initialization function
dubbed initialize_cpu_sysreg_properties(). That code will be
automatically generated from linux arch/arm64/tools/sysreg. For the
time being let's just describe a single id reg, CTR_EL0. In this
description we only care about non RES/RAZ fields, ie. named fields.

The registers are populated in an array indexed by ARMIDRegisterIdx
and their fields are added in a sorted list.

[CH: adapted to reworked register storage]
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/arm/cpu-custom.h            | 60 ++++++++++++++++++++++++++++++
 target/arm/cpu-sysreg-properties.c | 41 ++++++++++++++++++++
 target/arm/cpu64.c                 |  2 +
 target/arm/meson.build             |  1 +
 4 files changed, 104 insertions(+)
 create mode 100644 target/arm/cpu-custom.h
 create mode 100644 target/arm/cpu-sysreg-properties.c

diff --git a/target/arm/cpu-custom.h b/target/arm/cpu-custom.h
new file mode 100644
index 000000000000..615347376e56
--- /dev/null
+++ b/target/arm/cpu-custom.h
@@ -0,0 +1,60 @@
+/*
+ * handle ID registers and their fields
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
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
+    ARMSysRegs sysreg;
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
+extern ARM64SysReg arm64_id_regs[NUM_ID_IDX];
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
+static inline ARM64SysReg *arm64_sysreg_get(ARMIDRegisterIdx index)
+{
+        ARM64SysReg *reg = &arm64_id_regs[index];
+
+        reg->index = index;
+        reg->sysreg = id_register_sysreg[index];
+        return reg;
+}
+
+#endif
diff --git a/target/arm/cpu-sysreg-properties.c b/target/arm/cpu-sysreg-properties.c
new file mode 100644
index 000000000000..8b7ef5badfb9
--- /dev/null
+++ b/target/arm/cpu-sysreg-properties.c
@@ -0,0 +1,41 @@
+/*
+ * QEMU ARM CPU SYSREG PROPERTIES
+ * to be generated from linux sysreg
+ *
+ * Copyright (c) Red Hat, Inc. 2024
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
+ARM64SysReg arm64_id_regs[NUM_ID_IDX];
+
+void initialize_cpu_sysreg_properties(void)
+{
+    memset(arm64_id_regs, 0, sizeof(ARM64SysReg) * NUM_ID_IDX);
+    /* CTR_EL0 */
+    ARM64SysReg *CTR_EL0 = arm64_sysreg_get(CTR_EL0_IDX);
+    CTR_EL0->name = "CTR_EL0";
+    arm64_sysreg_add_field(CTR_EL0, "TminLine", 32, 37);
+    arm64_sysreg_add_field(CTR_EL0, "DIC", 29, 29);
+    arm64_sysreg_add_field(CTR_EL0, "IDC", 28, 28);
+    arm64_sysreg_add_field(CTR_EL0, "CWG", 24, 27);
+    arm64_sysreg_add_field(CTR_EL0, "ERG", 20, 23);
+    arm64_sysreg_add_field(CTR_EL0, "DminLine", 16, 19);
+    arm64_sysreg_add_field(CTR_EL0, "L1Ip", 14, 15);
+    arm64_sysreg_add_field(CTR_EL0, "IminLine", 0, 3);
+}
+
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 9769401a8585..839442745ea4 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -35,6 +35,7 @@
 #include "internals.h"
 #include "cpu-features.h"
 #include "cpregs.h"
+#include "cpu-custom.h"
 
 /* convert between <register>_IDX and SYS_<register> */
 #define DEF(NAME, OP0, OP1, CRN, CRM, OP2)      \
@@ -891,6 +892,7 @@ static void aarch64_cpu_register_types(void)
 {
     size_t i;
 
+    initialize_cpu_sysreg_properties();
     type_register_static(&aarch64_cpu_type_info);
 
     for (i = 0; i < ARRAY_SIZE(aarch64_cpus); ++i) {
diff --git a/target/arm/meson.build b/target/arm/meson.build
index 3065081d241d..1c97c1ef7580 100644
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
2.49.0


