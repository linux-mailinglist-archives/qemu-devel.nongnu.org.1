Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C17B82777B
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 19:27:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMuIh-0002yq-GV; Mon, 08 Jan 2024 13:24:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rMuIV-0002v4-0X
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 13:24:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rMuIS-0002n8-5A
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 13:24:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704738263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RkAv1Fd64w/HWzqT4+pSGXtJNcdTq/1wPbsuJV4CulU=;
 b=ZZWUo2LQb053ZIMk7Jq+Zi71QbWu47sMhnTjqQ48n6zzK1gAQN3VmMF1xxBQlEUmvD/676
 3EvV+EXN4iOtn1+03daSDukDpGXbAoRJcCaSEC1UhUhx0EStg4iC2TJ/gGGYIsEGTCv686
 djqcIZscHMobKGFGRwWKM8KrJ8sUXaQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-fB5CpnXePpa3CZW8wtU1ug-1; Mon, 08 Jan 2024 13:24:20 -0500
X-MC-Unique: fB5CpnXePpa3CZW8wtU1ug-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B7E8585A588;
 Mon,  8 Jan 2024 18:24:19 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AEF303C2E;
 Mon,  8 Jan 2024 18:24:18 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 09/29] hw: adapt to new import path for qobject data type
 headers
Date: Mon,  8 Jan 2024 18:23:45 +0000
Message-ID: <20240108182405.1135436-10-berrange@redhat.com>
In-Reply-To: <20240108182405.1135436-1-berrange@redhat.com>
References: <20240108182405.1135436-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.243,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The qobject data type headers have moved from qapi/qmp/ to
qobject/.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/arm/mps2-tz.c                 | 2 +-
 hw/arm/mps2.c                    | 2 +-
 hw/arm/sbsa-ref.c                | 2 +-
 hw/arm/stellaris.c               | 2 +-
 hw/arm/vexpress.c                | 2 +-
 hw/arm/virt.c                    | 2 +-
 hw/arm/xlnx-versal.c             | 2 +-
 hw/block/xen-block.c             | 4 ++--
 hw/core/machine-hmp-cmds.c       | 2 +-
 hw/core/machine-qmp-cmds.c       | 2 +-
 hw/core/qdev-properties-system.c | 2 +-
 hw/core/qdev-properties.c        | 4 ++--
 hw/core/qdev.c                   | 4 ++--
 hw/hyperv/hv-balloon.c           | 2 +-
 hw/i386/acpi-build.c             | 2 +-
 hw/i386/kvm/xen_evtchn.c         | 2 +-
 hw/i386/pc.c                     | 2 +-
 hw/intc/openpic.c                | 2 +-
 hw/net/rocker/rocker-hmp-cmds.c  | 2 +-
 hw/net/virtio-net.c              | 2 +-
 hw/net/xen_nic.c                 | 2 +-
 hw/pci/pci-hmp-cmds.c            | 2 +-
 hw/ppc/pegasos2.c                | 2 +-
 hw/ppc/spapr_drc.c               | 2 +-
 hw/ppc/spapr_pci.c               | 2 +-
 hw/rx/rx62n.c                    | 2 +-
 hw/s390x/s390-skeys.c            | 2 +-
 hw/s390x/s390-stattrib.c         | 2 +-
 hw/usb/redirect.c                | 2 +-
 hw/usb/xen-usb.c                 | 4 ++--
 hw/vfio/pci.c                    | 2 +-
 hw/virtio/virtio-hmp-cmds.c      | 2 +-
 hw/virtio/virtio-qmp.c           | 4 ++--
 hw/xen/xen-bus.c                 | 2 +-
 34 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index 668db5ed61..b351834c5a 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -48,7 +48,7 @@
 #include "qemu/units.h"
 #include "qemu/cutils.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qlist.h"
+#include "qobject/qlist.h"
 #include "qemu/error-report.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/armv7m.h"
diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index 292a180ad2..296b814272 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -48,7 +48,7 @@
 #include "net/net.h"
 #include "hw/watchdog/cmsdk-apb-watchdog.h"
 #include "hw/qdev-clock.h"
-#include "qapi/qmp/qlist.h"
+#include "qobject/qlist.h"
 #include "qom/object.h"
 
 typedef enum MPS2FPGAType {
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index f3c9704693..38f6276cee 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -48,7 +48,7 @@
 #include "hw/char/pl011.h"
 #include "hw/watchdog/sbsa_gwdt.h"
 #include "net/net.h"
-#include "qapi/qmp/qlist.h"
+#include "qobject/qlist.h"
 #include "qom/object.h"
 
 #define RAMLIMIT_GB 8192
diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index 729a8bf569..c4463284e9 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -31,7 +31,7 @@
 #include "hw/timer/stellaris-gptm.h"
 #include "hw/qdev-clock.h"
 #include "qom/object.h"
-#include "qapi/qmp/qlist.h"
+#include "qobject/qlist.h"
 #include "ui/input.h"
 
 #define GPIO_A 0
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index fd981f4c33..ddc8934f5f 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -43,7 +43,7 @@
 #include "hw/cpu/a15mpcore.h"
 #include "hw/i2c/arm_sbcon_i2c.h"
 #include "hw/sd/sd.h"
-#include "qapi/qmp/qlist.h"
+#include "qobject/qlist.h"
 #include "qom/object.h"
 #include "audio/audio.h"
 
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 8b69aba189..f769bdfa44 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -69,7 +69,7 @@
 #include "hw/firmware/smbios.h"
 #include "qapi/visitor.h"
 #include "qapi/qapi-visit-common.h"
-#include "qapi/qmp/qlist.h"
+#include "qobject/qlist.h"
 #include "standard-headers/linux/input.h"
 #include "hw/arm/smmuv3.h"
 #include "hw/acpi/acpi.h"
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 9600551c44..2855c8831f 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -12,7 +12,7 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qlist.h"
+#include "qobject/qlist.h"
 #include "qemu/module.h"
 #include "hw/sysbus.h"
 #include "net/net.h"
diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index aed1d5c330..5c5a5fec19 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -16,8 +16,8 @@
 #include "qapi/qapi-visit-block-core.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/visitor.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qdict.h"
+#include "qobject/qstring.h"
 #include "qom/object_interfaces.h"
 #include "hw/block/xen_blkif.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/core/machine-hmp-cmds.c b/hw/core/machine-hmp-cmds.c
index a6ff6a4875..d5fcff53a5 100644
--- a/hw/core/machine-hmp-cmds.c
+++ b/hw/core/machine-hmp-cmds.c
@@ -19,7 +19,7 @@
 #include "qapi/error.h"
 #include "qapi/qapi-builtin-visit.h"
 #include "qapi/qapi-commands-machine.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qapi/string-output-visitor.h"
 #include "qemu/error-report.h"
 #include "sysemu/numa.h"
diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index 3860a50c3b..edb4d9298b 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -16,7 +16,7 @@
 #include "qapi/error.h"
 #include "qapi/qapi-builtin-visit.h"
 #include "qapi/qapi-commands-machine.h"
-#include "qapi/qmp/qobject.h"
+#include "qobject/qobject.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/type-helpers.h"
 #include "qemu/main-loop.h"
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 1a396521d5..2685ec76c5 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -19,7 +19,7 @@
 #include "qapi/qapi-types-machine.h"
 #include "qapi/qapi-types-migration.h"
 #include "qapi/qapi-visit-virtio.h"
-#include "qapi/qmp/qerror.h"
+#include "qobject/qerror.h"
 #include "qemu/ctype.h"
 #include "qemu/cutils.h"
 #include "qemu/units.h"
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 7d6fa726fd..68ed53d86f 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -2,8 +2,8 @@
 #include "hw/qdev-properties.h"
 #include "qapi/error.h"
 #include "qapi/qapi-types-misc.h"
-#include "qapi/qmp/qerror.h"
-#include "qapi/qmp/qlist.h"
+#include "qobject/qerror.h"
+#include "qobject/qlist.h"
 #include "qemu/ctype.h"
 #include "qemu/error-report.h"
 #include "qapi/visitor.h"
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 43d863b0c5..c76c5393fb 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -28,8 +28,8 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qapi/qapi-events-qdev.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qerror.h"
+#include "qobject/qdict.h"
+#include "qobject/qerror.h"
 #include "qapi/visitor.h"
 #include "qemu/error-report.h"
 #include "qemu/option.h"
diff --git a/hw/hyperv/hv-balloon.c b/hw/hyperv/hv-balloon.c
index 66f297c1d7..1f93101873 100644
--- a/hw/hyperv/hv-balloon.c
+++ b/hw/hyperv/hv-balloon.c
@@ -25,7 +25,7 @@
 #include "qapi/qapi-commands-machine.h"
 #include "qapi/qapi-events-machine.h"
 #include "qapi/qapi-types-machine.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qapi/visitor.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index edc979379c..fe945c9172 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -22,7 +22,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qnum.h"
+#include "qobject/qnum.h"
 #include "acpi-build.h"
 #include "acpi-common.h"
 #include "qemu/bitmap.h"
diff --git a/hw/i386/kvm/xen_evtchn.c b/hw/i386/kvm/xen_evtchn.c
index 9a5f3caa24..368ef10d20 100644
--- a/hw/i386/kvm/xen_evtchn.c
+++ b/hw/i386/kvm/xen_evtchn.c
@@ -20,7 +20,7 @@
 #include "monitor/hmp.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-misc-target.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qom/object.h"
 #include "exec/target_page.h"
 #include "exec/address-spaces.h"
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 496498df3a..d3824f7718 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -44,7 +44,7 @@
 #include "sysemu/reset.h"
 #include "kvm/kvm_i386.h"
 #include "hw/xen/xen.h"
-#include "qapi/qmp/qlist.h"
+#include "qobject/qlist.h"
 #include "qemu/error-report.h"
 #include "hw/acpi/cpu_hotplug.h"
 #include "acpi-build.h"
diff --git a/hw/intc/openpic.c b/hw/intc/openpic.c
index 9792a11224..59844289ff 100644
--- a/hw/intc/openpic.c
+++ b/hw/intc/openpic.c
@@ -41,7 +41,7 @@
 #include "hw/pci/msi.h"
 #include "qapi/error.h"
 #include "qemu/bitops.h"
-#include "qapi/qmp/qerror.h"
+#include "qobject/qerror.h"
 #include "qemu/module.h"
 #include "qemu/timer.h"
 #include "qemu/error-report.h"
diff --git a/hw/net/rocker/rocker-hmp-cmds.c b/hw/net/rocker/rocker-hmp-cmds.c
index 197c6e28dc..df40991f6d 100644
--- a/hw/net/rocker/rocker-hmp-cmds.c
+++ b/hw/net/rocker/rocker-hmp-cmds.c
@@ -18,7 +18,7 @@
 #include "monitor/monitor.h"
 #include "net/eth.h"
 #include "qapi/qapi-commands-rocker.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 
 void hmp_rocker(Monitor *mon, const QDict *qdict)
 {
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 7a2846fa1c..aad6fde6f4 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -26,7 +26,7 @@
 #include "qemu/option.h"
 #include "qemu/option_int.h"
 #include "qemu/config-file.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "hw/virtio/virtio-net.h"
 #include "net/vhost_net.h"
 #include "net/announce.h"
diff --git a/hw/net/xen_nic.c b/hw/net/xen_nic.c
index 1e2b3baeb1..78fbf2983b 100644
--- a/hw/net/xen_nic.c
+++ b/hw/net/xen_nic.c
@@ -24,7 +24,7 @@
 #include "qemu/cutils.h"
 #include "qemu/log.h"
 #include "qemu/qemu-print.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qapi/error.h"
 
 #include <sys/socket.h>
diff --git a/hw/pci/pci-hmp-cmds.c b/hw/pci/pci-hmp-cmds.c
index b09fce9377..d59075edd7 100644
--- a/hw/pci/pci-hmp-cmds.c
+++ b/hw/pci/pci-hmp-cmds.c
@@ -20,7 +20,7 @@
 #include "monitor/monitor.h"
 #include "pci-internal.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qapi/qapi-commands-pci.h"
 #include "qemu/cutils.h"
 
diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
index 3203a4a728..f3adccc98b 100644
--- a/hw/ppc/pegasos2.c
+++ b/hw/ppc/pegasos2.c
@@ -32,7 +32,7 @@
 #include "kvm_ppc.h"
 #include "exec/address-spaces.h"
 #include "qom/qom-qobject.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "trace.h"
 #include "qemu/datadir.h"
 #include "sysemu/device_tree.h"
diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 1484e3209d..4b3dec6e50 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -12,7 +12,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qnull.h"
+#include "qobject/qnull.h"
 #include "qemu/cutils.h"
 #include "hw/ppc/spapr_drc.h"
 #include "qom/object.h"
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 25e0295d6f..6c790a3307 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -39,7 +39,7 @@
 #include "trace.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
-#include "qapi/qmp/qerror.h"
+#include "qobject/qerror.h"
 #include "hw/ppc/fdt.h"
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/pci_bus.h"
diff --git a/hw/rx/rx62n.c b/hw/rx/rx62n.c
index 4dc44afd9d..1d10bdbd39 100644
--- a/hw/rx/rx62n.c
+++ b/hw/rx/rx62n.c
@@ -28,7 +28,7 @@
 #include "hw/sysbus.h"
 #include "hw/qdev-properties.h"
 #include "sysemu/sysemu.h"
-#include "qapi/qmp/qlist.h"
+#include "qobject/qlist.h"
 #include "qom/object.h"
 
 /*
diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
index 8f5159d85d..04b944e770 100644
--- a/hw/s390x/s390-skeys.c
+++ b/hw/s390x/s390-skeys.c
@@ -16,7 +16,7 @@
 #include "hw/s390x/storage-keys.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-misc-target.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qemu/error-report.h"
 #include "sysemu/memory_mapping.h"
 #include "exec/address-spaces.h"
diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
index c483b62a9b..aa25fac6f3 100644
--- a/hw/s390x/s390-stattrib.c
+++ b/hw/s390x/s390-stattrib.c
@@ -18,7 +18,7 @@
 #include "qemu/error-report.h"
 #include "exec/ram_addr.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 
 /* 512KiB cover 2GB of guest memory */
 #define CMMA_BLOCK_SIZE  (512 * KiB)
diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index 636eb98e41..6c87ced39d 100644
--- a/hw/usb/redirect.c
+++ b/hw/usb/redirect.c
@@ -32,7 +32,7 @@
 #include "qemu/timer.h"
 #include "sysemu/runstate.h"
 #include "sysemu/sysemu.h"
-#include "qapi/qmp/qerror.h"
+#include "qobject/qerror.h"
 #include "qemu/error-report.h"
 #include "qemu/iov.h"
 #include "qemu/module.h"
diff --git a/hw/usb/xen-usb.c b/hw/usb/xen-usb.c
index 09ec326aea..e305d69882 100644
--- a/hw/usb/xen-usb.c
+++ b/hw/usb/xen-usb.c
@@ -30,8 +30,8 @@
 #include "hw/xen/xen-legacy-backend.h"
 #include "monitor/qdev.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qdict.h"
+#include "qobject/qstring.h"
 
 #include "hw/xen/interface/io/usbif.h"
 
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 9f838978be..eb847a7e9c 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -30,7 +30,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "migration/vmstate.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
diff --git a/hw/virtio/virtio-hmp-cmds.c b/hw/virtio/virtio-hmp-cmds.c
index 477c97dea2..7d8677bcf0 100644
--- a/hw/virtio/virtio-hmp-cmds.c
+++ b/hw/virtio/virtio-hmp-cmds.c
@@ -9,7 +9,7 @@
 #include "monitor/hmp.h"
 #include "monitor/monitor.h"
 #include "qapi/qapi-commands-virtio.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 
 
 static void hmp_virtio_dump_protocols(Monitor *mon,
diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
index 1dd96ed20f..71316362cd 100644
--- a/hw/virtio/virtio-qmp.c
+++ b/hw/virtio/virtio-qmp.c
@@ -15,8 +15,8 @@
 #include "qapi/error.h"
 #include "qapi/qapi-commands-virtio.h"
 #include "qapi/qapi-commands-qom.h"
-#include "qapi/qmp/qobject.h"
-#include "qapi/qmp/qjson.h"
+#include "qobject/qobject.h"
+#include "qobject/qjson.h"
 #include "hw/virtio/vhost-user.h"
 
 #include "standard-headers/linux/virtio_ids.h"
diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
index 4973e7d9c9..ed0788d08f 100644
--- a/hw/xen/xen-bus.c
+++ b/hw/xen/xen-bus.c
@@ -17,7 +17,7 @@
 #include "hw/xen/xen-bus-helper.h"
 #include "monitor/monitor.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "sysemu/sysemu.h"
 #include "trace.h"
 
-- 
2.43.0


