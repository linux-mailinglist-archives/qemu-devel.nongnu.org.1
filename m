Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 724A282777F
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 19:28:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMuIq-00033c-N3; Mon, 08 Jan 2024 13:24:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rMuIo-00033E-Kx
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 13:24:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rMuIj-0002ws-ST
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 13:24:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704738281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VmYOede8aib5RPXDORPrt9o/bZ50P/Tu08pQ4JWr6+4=;
 b=SbQjSUxSEjgk7/gSsBaQfx9AiKKPlsb2UawPpEdJfv+IYYe0H12KMYXPmI8aCLAbCXpt7A
 bBQiSIlKMP1WlQibPMuu/2ZJ8fSCNJlB1Lt1tmbercAVMGq40uy6bQzNj6HJkbZ+zz2uHh
 f4xg/qQhlnJahEJ8gsSOetb5cT6jQQI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-uNeysgznMZa0jgPWMHF4VQ-1; Mon, 08 Jan 2024 13:24:39 -0500
X-MC-Unique: uNeysgznMZa0jgPWMHF4VQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DDF0C83B8E5;
 Mon,  8 Jan 2024 18:24:38 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2A0393C2F;
 Mon,  8 Jan 2024 18:24:37 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 24/29] target: adapt to new import path for qobject data type
 headers
Date: Mon,  8 Jan 2024 18:24:00 +0000
Message-ID: <20240108182405.1135436-25-berrange@redhat.com>
In-Reply-To: <20240108182405.1135436-1-berrange@redhat.com>
References: <20240108182405.1135436-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.243,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The qobject data type headers have moved from qapi/qmp/ to
qobject/.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 target/arm/arm-qmp-cmds.c             | 4 ++--
 target/i386/cpu-sysemu.c              | 2 +-
 target/i386/cpu.c                     | 2 +-
 target/i386/monitor.c                 | 2 +-
 target/loongarch/loongarch-qmp-cmds.c | 4 ++--
 target/ppc/cpu_init.c                 | 2 +-
 target/riscv/riscv-qmp-cmds.c         | 4 ++--
 target/s390x/cpu_models_sysemu.c      | 4 ++--
 8 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/target/arm/arm-qmp-cmds.c b/target/arm/arm-qmp-cmds.c
index b53d5efe13..94d28e2fc3 100644
--- a/target/arm/arm-qmp-cmds.c
+++ b/target/arm/arm-qmp-cmds.c
@@ -28,8 +28,8 @@
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qapi-commands-machine-target.h"
 #include "qapi/qapi-commands-misc-target.h"
-#include "qapi/qmp/qerror.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qerror.h"
+#include "qobject/qdict.h"
 #include "qom/qom-qobject.h"
 
 static GICCapability *gic_cap_new(int version)
diff --git a/target/i386/cpu-sysemu.c b/target/i386/cpu-sysemu.c
index 2375e48178..35d6fe4a41 100644
--- a/target/i386/cpu-sysemu.c
+++ b/target/i386/cpu-sysemu.c
@@ -24,7 +24,7 @@
 #include "sysemu/whpx.h"
 #include "qapi/error.h"
 #include "qapi/qapi-visit-run-state.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qom/qom-qobject.h"
 #include "qapi/qapi-commands-machine-target.h"
 #include "hw/qdev-properties.h"
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 95d5f16cd5..fb4a12b3e6 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -31,7 +31,7 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qapi/qapi-visit-machine.h"
-#include "qapi/qmp/qerror.h"
+#include "qobject/qerror.h"
 #include "standard-headers/asm-x86/kvm_para.h"
 #include "hw/qdev-properties.h"
 #include "hw/i386/topology.h"
diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index 950ff9ccbc..4a8db98475 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -27,7 +27,7 @@
 #include "monitor/monitor.h"
 #include "monitor/hmp-target.h"
 #include "monitor/hmp.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "sysemu/hw_accel.h"
 #include "sysemu/kvm.h"
 #include "qapi/error.h"
diff --git a/target/loongarch/loongarch-qmp-cmds.c b/target/loongarch/loongarch-qmp-cmds.c
index 645672ff59..90d579f006 100644
--- a/target/loongarch/loongarch-qmp-cmds.c
+++ b/target/loongarch/loongarch-qmp-cmds.c
@@ -10,8 +10,8 @@
 #include "qapi/error.h"
 #include "qapi/qapi-commands-machine-target.h"
 #include "cpu.h"
-#include "qapi/qmp/qerror.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qerror.h"
+#include "qobject/qdict.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qom/qom-qobject.h"
 
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 40fe14a6c2..d7986e29d0 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -31,7 +31,7 @@
 #include "qemu/module.h"
 #include "qemu/qemu-print.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qnull.h"
+#include "qobject/qnull.h"
 #include "qapi/visitor.h"
 #include "hw/qdev-properties.h"
 #include "hw/ppc/ppc.h"
diff --git a/target/riscv/riscv-qmp-cmds.c b/target/riscv/riscv-qmp-cmds.c
index 2f2dbae7c8..f0f10d6540 100644
--- a/target/riscv/riscv-qmp-cmds.c
+++ b/target/riscv/riscv-qmp-cmds.c
@@ -26,8 +26,8 @@
 
 #include "qapi/error.h"
 #include "qapi/qapi-commands-machine-target.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qerror.h"
+#include "qobject/qdict.h"
+#include "qobject/qerror.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/visitor.h"
 #include "qom/qom-qobject.h"
diff --git a/target/s390x/cpu_models_sysemu.c b/target/s390x/cpu_models_sysemu.c
index 63981bf36b..96fd83a596 100644
--- a/target/s390x/cpu_models_sysemu.c
+++ b/target/s390x/cpu_models_sysemu.c
@@ -17,9 +17,9 @@
 #include "sysemu/kvm.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
-#include "qapi/qmp/qerror.h"
+#include "qobject/qerror.h"
 #include "qapi/qobject-input-visitor.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qapi/qapi-commands-machine-target.h"
 
 static void list_add_feat(const char *name, void *opaque);
-- 
2.43.0


