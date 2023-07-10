Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4978B74D516
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 14:19:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIpoH-0000l3-78; Mon, 10 Jul 2023 08:16:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qIpo2-0000jB-1F
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:15:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qIpnz-0003M3-2e
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:15:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688991349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jmEDEFjkdYvlep/3aZhSl8CC6Gsnqo484O6A8aTGNoo=;
 b=eMMu2z/GIE6GbtrADDQC54JqlFmur/LDXPeP0ASoS/N0Bw7YN0UPxj+pdxaseqdiw3hxSH
 Op0ITP7zlRa7eNTHQ+kQvOpWVoKrv+6JYkspRI4gS8ekylND6TeNwKzO3LwyIiJadKkclg
 YA5BzuygR1/gpAjLULgGIjvMSKCsd0w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-407-07FsdNOjM3e0fsn60v0EYw-1; Mon, 10 Jul 2023 08:15:47 -0400
X-MC-Unique: 07FsdNOjM3e0fsn60v0EYw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7D3D98B34C6;
 Mon, 10 Jul 2023 12:15:47 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.206])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 99A12F5CFA;
 Mon, 10 Jul 2023 12:15:46 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 01/21] hw/s390x: Move KVM specific PV from hw/ to
 target/s390x/kvm/
Date: Mon, 10 Jul 2023 14:15:23 +0200
Message-Id: <20230710121543.197250-2-thuth@redhat.com>
In-Reply-To: <20230710121543.197250-1-thuth@redhat.com>
References: <20230710121543.197250-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Protected Virtualization (PV) is not a real hardware device:
it is a feature of the firmware on s390x that is exposed to
userspace via the KVM interface.

Move the pv.c/pv.h files to target/s390x/kvm/ to make this clearer.

Suggested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230624200644.23931-1-philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                                 | 2 --
 {include/hw/s390x => target/s390x/kvm}/pv.h | 0
 hw/s390x/ipl.c                              | 2 +-
 hw/s390x/s390-pci-kvm.c                     | 2 +-
 hw/s390x/s390-virtio-ccw.c                  | 2 +-
 hw/s390x/tod-kvm.c                          | 2 +-
 target/s390x/arch_dump.c                    | 2 +-
 target/s390x/cpu-sysemu.c                   | 2 +-
 target/s390x/cpu_features.c                 | 2 +-
 target/s390x/cpu_models.c                   | 2 +-
 target/s390x/diag.c                         | 2 +-
 target/s390x/helper.c                       | 2 +-
 target/s390x/ioinst.c                       | 2 +-
 target/s390x/kvm/kvm.c                      | 2 +-
 {hw/s390x => target/s390x/kvm}/pv.c         | 2 +-
 hw/s390x/meson.build                        | 1 -
 target/s390x/kvm/meson.build                | 1 +
 17 files changed, 14 insertions(+), 16 deletions(-)
 rename {include/hw/s390x => target/s390x/kvm}/pv.h (100%)
 rename {hw/s390x => target/s390x/kvm}/pv.c (99%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1817cfc62f..43bd9afc19 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -452,8 +452,6 @@ S: Supported
 F: target/s390x/kvm/
 F: target/s390x/machine.c
 F: target/s390x/sigp.c
-F: hw/s390x/pv.c
-F: include/hw/s390x/pv.h
 F: gdb-xml/s390*.xml
 T: git https://github.com/borntraeger/qemu.git s390-next
 L: qemu-s390x@nongnu.org
diff --git a/include/hw/s390x/pv.h b/target/s390x/kvm/pv.h
similarity index 100%
rename from include/hw/s390x/pv.h
rename to target/s390x/kvm/pv.h
diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 8612684d48..515dcf51b5 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -26,7 +26,7 @@
 #include "hw/s390x/vfio-ccw.h"
 #include "hw/s390x/css.h"
 #include "hw/s390x/ebcdic.h"
-#include "hw/s390x/pv.h"
+#include "target/s390x/kvm/pv.h"
 #include "hw/scsi/scsi.h"
 #include "hw/virtio/virtio-net.h"
 #include "ipl.h"
diff --git a/hw/s390x/s390-pci-kvm.c b/hw/s390x/s390-pci-kvm.c
index 9134fe185f..ff41e4106d 100644
--- a/hw/s390x/s390-pci-kvm.c
+++ b/hw/s390x/s390-pci-kvm.c
@@ -14,7 +14,7 @@
 #include <linux/kvm.h>
 
 #include "kvm/kvm_s390x.h"
-#include "hw/s390x/pv.h"
+#include "target/s390x/kvm/pv.h"
 #include "hw/s390x/s390-pci-bus.h"
 #include "hw/s390x/s390-pci-kvm.h"
 #include "hw/s390x/s390-pci-inst.h"
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 2dece8eab8..4516d73ff5 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -42,7 +42,7 @@
 #include "hw/s390x/tod.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/cpus.h"
-#include "hw/s390x/pv.h"
+#include "target/s390x/kvm/pv.h"
 #include "migration/blocker.h"
 #include "qapi/visitor.h"
 
diff --git a/hw/s390x/tod-kvm.c b/hw/s390x/tod-kvm.c
index e2202dae2d..9588b90f2b 100644
--- a/hw/s390x/tod-kvm.c
+++ b/hw/s390x/tod-kvm.c
@@ -13,7 +13,7 @@
 #include "qemu/module.h"
 #include "sysemu/runstate.h"
 #include "hw/s390x/tod.h"
-#include "hw/s390x/pv.h"
+#include "target/s390x/kvm/pv.h"
 #include "kvm/kvm_s390x.h"
 
 static void kvm_s390_get_tod_raw(S390TOD *tod, Error **errp)
diff --git a/target/s390x/arch_dump.c b/target/s390x/arch_dump.c
index cb98f4894d..51a2116515 100644
--- a/target/s390x/arch_dump.c
+++ b/target/s390x/arch_dump.c
@@ -17,8 +17,8 @@
 #include "s390x-internal.h"
 #include "elf.h"
 #include "sysemu/dump.h"
-#include "hw/s390x/pv.h"
 #include "kvm/kvm_s390x.h"
+#include "target/s390x/kvm/pv.h"
 
 struct S390xUserRegsStruct {
     uint64_t psw[2];
diff --git a/target/s390x/cpu-sysemu.c b/target/s390x/cpu-sysemu.c
index 97d6c760a8..8112561e5e 100644
--- a/target/s390x/cpu-sysemu.c
+++ b/target/s390x/cpu-sysemu.c
@@ -33,7 +33,7 @@
 #include "qapi/qapi-visit-run-state.h"
 #include "sysemu/hw_accel.h"
 
-#include "hw/s390x/pv.h"
+#include "target/s390x/kvm/pv.h"
 #include "hw/boards.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/tcg.h"
diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
index 2e4e11d264..ebb155ce1c 100644
--- a/target/s390x/cpu_features.c
+++ b/target/s390x/cpu_features.c
@@ -15,7 +15,7 @@
 #include "qemu/module.h"
 #include "cpu_features.h"
 #ifndef CONFIG_USER_ONLY
-#include "hw/s390x/pv.h"
+#include "target/s390x/kvm/pv.h"
 #endif
 
 #define DEF_FEAT(_FEAT, _NAME, _TYPE, _BIT, _DESC) \
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index ae8880e81d..42b52afdb4 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -24,7 +24,7 @@
 #include "qemu/qemu-print.h"
 #ifndef CONFIG_USER_ONLY
 #include "sysemu/sysemu.h"
-#include "hw/s390x/pv.h"
+#include "target/s390x/kvm/pv.h"
 #endif
 
 #define CPUDEF_INIT(_type, _gen, _ec_ga, _mha_pow, _hmfai, _name, _desc) \
diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index e5f0df19e7..8ce18e08f3 100644
--- a/target/s390x/diag.c
+++ b/target/s390x/diag.c
@@ -19,9 +19,9 @@
 #include "sysemu/cpus.h"
 #include "hw/s390x/ipl.h"
 #include "hw/s390x/s390-virtio-ccw.h"
-#include "hw/s390x/pv.h"
 #include "sysemu/kvm.h"
 #include "kvm/kvm_s390x.h"
+#include "target/s390x/kvm/pv.h"
 #include "qemu/error-report.h"
 
 
diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index 2b363aa959..d76c06381b 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -24,7 +24,7 @@
 #include "gdbstub/helpers.h"
 #include "qemu/timer.h"
 #include "hw/s390x/ioinst.h"
-#include "hw/s390x/pv.h"
+#include "target/s390x/kvm/pv.h"
 #include "sysemu/hw_accel.h"
 #include "sysemu/runstate.h"
 
diff --git a/target/s390x/ioinst.c b/target/s390x/ioinst.c
index 053aaabb5a..bbe45a497a 100644
--- a/target/s390x/ioinst.c
+++ b/target/s390x/ioinst.c
@@ -16,7 +16,7 @@
 #include "hw/s390x/ioinst.h"
 #include "trace.h"
 #include "hw/s390x/s390-pci-bus.h"
-#include "hw/s390x/pv.h"
+#include "target/s390x/kvm/pv.h"
 
 /* All I/O instructions but chsc use the s format */
 static uint64_t get_address_from_regs(CPUS390XState *env, uint32_t ipb,
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index 3ac7ec9acf..a9e5880349 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -50,7 +50,7 @@
 #include "exec/memattrs.h"
 #include "hw/s390x/s390-virtio-ccw.h"
 #include "hw/s390x/s390-virtio-hcall.h"
-#include "hw/s390x/pv.h"
+#include "target/s390x/kvm/pv.h"
 
 #ifndef DEBUG_KVM
 #define DEBUG_KVM  0
diff --git a/hw/s390x/pv.c b/target/s390x/kvm/pv.c
similarity index 99%
rename from hw/s390x/pv.c
rename to target/s390x/kvm/pv.c
index b63f3784c6..6a69be7e5c 100644
--- a/hw/s390x/pv.c
+++ b/target/s390x/kvm/pv.c
@@ -21,9 +21,9 @@
 #include "qom/object_interfaces.h"
 #include "exec/confidential-guest-support.h"
 #include "hw/s390x/ipl.h"
-#include "hw/s390x/pv.h"
 #include "hw/s390x/sclp.h"
 #include "target/s390x/kvm/kvm_s390x.h"
+#include "target/s390x/kvm/pv.h"
 
 static bool info_valid;
 static struct kvm_s390_pv_info_vm info_vm;
diff --git a/hw/s390x/meson.build b/hw/s390x/meson.build
index f291016fee..6fd096813a 100644
--- a/hw/s390x/meson.build
+++ b/hw/s390x/meson.build
@@ -22,7 +22,6 @@ s390x_ss.add(when: 'CONFIG_KVM', if_true: files(
   'tod-kvm.c',
   's390-skeys-kvm.c',
   's390-stattrib-kvm.c',
-  'pv.c',
   's390-pci-kvm.c',
 ))
 s390x_ss.add(when: 'CONFIG_TCG', if_true: files(
diff --git a/target/s390x/kvm/meson.build b/target/s390x/kvm/meson.build
index 37253f75bf..d6aca590ae 100644
--- a/target/s390x/kvm/meson.build
+++ b/target/s390x/kvm/meson.build
@@ -1,5 +1,6 @@
 
 s390x_ss.add(when: 'CONFIG_KVM', if_true: files(
+  'pv.c',
   'kvm.c'
 ), if_false: files(
   'stubs.c'
-- 
2.39.3


