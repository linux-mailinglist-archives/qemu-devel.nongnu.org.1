Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA0AB185BE
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Aug 2025 18:25:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhsYz-0006oB-Ju; Fri, 01 Aug 2025 12:24:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uhrSb-0007Dn-Ul
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 11:14:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uhrSZ-0002op-7x
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 11:14:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754061254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t83uMD9jEBkQWI1Nf8s3qDgwTL44RKgWBeKLSYfhRHw=;
 b=hCrP/qS5X3dCxfhbPx3SR0NxiOanWC7e8c62fdlFgmTaXJ6XBuJ1I7XXDBiqj599QEEQki
 HSjthCUvZhje53BZVM3F5jwC9q1Pf/TsPsyTccPFamlolTCV2trI9wympYlqYqTzkY7yMu
 Ht/TvY1ltB8aC9zm/8F4JjK2iIll6CI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-303-Drf2nZffN12x-tysv9ooCg-1; Fri,
 01 Aug 2025 11:14:09 -0400
X-MC-Unique: Drf2nZffN12x-tysv9ooCg-1
X-Mimecast-MFC-AGG-ID: Drf2nZffN12x-tysv9ooCg_1754061248
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A5B4B1800165; Fri,  1 Aug 2025 15:14:08 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.225.137])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C76481800B6A; Fri,  1 Aug 2025 15:14:05 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 22/24] tests/functional: Move x86_64 tests into
 target-specific folder
Date: Fri,  1 Aug 2025 17:12:47 +0200
Message-ID: <20250801151251.751368-23-thuth@redhat.com>
In-Reply-To: <20250801151251.751368-1-thuth@redhat.com>
References: <20250801151251.751368-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

The tests/functional folder has become quite crowded, thus move the
x86_64 tests into a target-specific subfolder.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                                   | 30 +++++++--------
 tests/functional/meson.build                  | 37 +------------------
 tests/functional/x86_64/meson.build           | 37 +++++++++++++++++++
 .../functional/{ => x86_64}/test_acpi_bits.py |  0
 .../test_cpu_model_versions.py}               |  0
 .../{ => x86_64}/test_cpu_queries.py          |  0
 .../test_hotplug_blk.py}                      |  0
 .../test_hotplug_cpu.py}                      |  0
 .../{ => x86_64}/test_intel_iommu.py          |  0
 .../test_kvm_xen.py}                          |  0
 .../{ => x86_64}/test_linux_initrd.py         |  0
 .../{ => x86_64}/test_mem_addr_space.py       |  0
 tests/functional/{ => x86_64}/test_memlock.py |  0
 .../test_migration.py}                        |  0
 .../test_multiprocess.py}                     |  0
 .../{ => x86_64}/test_netdev_ethtool.py       |  0
 .../{ => x86_64}/test_pc_cpu_hotplug_props.py |  0
 .../test_replay.py}                           |  0
 .../test_reverse_debug.py}                    |  0
 .../test_tuxrun.py}                           |  0
 .../{ => x86_64}/test_virtio_balloon.py       |  0
 .../{ => x86_64}/test_virtio_gpu.py           |  0
 .../{ => x86_64}/test_virtio_version.py       |  0
 23 files changed, 53 insertions(+), 51 deletions(-)
 create mode 100644 tests/functional/x86_64/meson.build
 rename tests/functional/{ => x86_64}/test_acpi_bits.py (100%)
 rename tests/functional/{test_x86_cpu_model_versions.py => x86_64/test_cpu_model_versions.py} (100%)
 rename tests/functional/{ => x86_64}/test_cpu_queries.py (100%)
 rename tests/functional/{test_x86_64_hotplug_blk.py => x86_64/test_hotplug_blk.py} (100%)
 rename tests/functional/{test_x86_64_hotplug_cpu.py => x86_64/test_hotplug_cpu.py} (100%)
 rename tests/functional/{ => x86_64}/test_intel_iommu.py (100%)
 rename tests/functional/{test_x86_64_kvm_xen.py => x86_64/test_kvm_xen.py} (100%)
 rename tests/functional/{ => x86_64}/test_linux_initrd.py (100%)
 rename tests/functional/{ => x86_64}/test_mem_addr_space.py (100%)
 rename tests/functional/{ => x86_64}/test_memlock.py (100%)
 rename tests/functional/{test_x86_64_migration.py => x86_64/test_migration.py} (100%)
 rename tests/functional/{test_x86_64_multiprocess.py => x86_64/test_multiprocess.py} (100%)
 rename tests/functional/{ => x86_64}/test_netdev_ethtool.py (100%)
 rename tests/functional/{ => x86_64}/test_pc_cpu_hotplug_props.py (100%)
 rename tests/functional/{test_x86_64_replay.py => x86_64/test_replay.py} (100%)
 rename tests/functional/{test_x86_64_reverse_debug.py => x86_64/test_reverse_debug.py} (100%)
 rename tests/functional/{test_x86_64_tuxrun.py => x86_64/test_tuxrun.py} (100%)
 rename tests/functional/{ => x86_64}/test_virtio_balloon.py (100%)
 rename tests/functional/{ => x86_64}/test_virtio_gpu.py (100%)
 rename tests/functional/{ => x86_64}/test_virtio_version.py (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1a9fd4a03f2..20538ba9fe7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -481,7 +481,7 @@ F: docs/system/i386/sgx.rst
 F: target/i386/kvm/
 F: target/i386/sev*
 F: scripts/kvm/vmxcap
-F: tests/functional/test_x86_64_hotplug_cpu.py
+F: tests/functional/x86_64/test_hotplug_cpu.py
 
 Xen emulation on X86 KVM CPUs
 M: David Woodhouse <dwmw2@infradead.org>
@@ -490,7 +490,7 @@ S: Supported
 F: include/system/kvm_xen.h
 F: target/i386/kvm/xen*
 F: hw/i386/kvm/xen*
-F: tests/functional/test_x86_64_kvm_xen.py
+F: tests/functional/x86_64/test_kvm_xen.py
 
 Guest CPU Cores (other accelerators)
 ------------------------------------
@@ -1890,11 +1890,11 @@ F: include/hw/isa/apm.h
 F: tests/unit/test-x86-topo.c
 F: tests/qtest/test-x86-cpuid-compat.c
 F: tests/functional/i386/test_tuxrun.py
-F: tests/functional/test_linux_initrd.py
-F: tests/functional/test_mem_addr_space.py
-F: tests/functional/test_pc_cpu_hotplug_props.py
-F: tests/functional/test_x86_64_tuxrun.py
-F: tests/functional/test_x86_cpu_model_versions.py
+F: tests/functional/x86_64/test_linux_initrd.py
+F: tests/functional/x86_64/test_mem_addr_space.py
+F: tests/functional/x86_64/test_pc_cpu_hotplug_props.py
+F: tests/functional/x86_64/test_tuxrun.py
+F: tests/functional/x86_64/test_cpu_model_versions.py
 
 PC Chipset
 M: Michael S. Tsirkin <mst@redhat.com>
@@ -1970,7 +1970,7 @@ F: include/hw/boards.h
 F: include/hw/core/cpu.h
 F: include/hw/cpu/cluster.h
 F: include/system/numa.h
-F: tests/functional/test_cpu_queries.py
+F: tests/functional/x86_64/test_cpu_queries.py
 F: tests/functional/test_empty_cpu_model.py
 F: tests/unit/test-smp-parse.c
 T: git https://gitlab.com/ehabkost/qemu.git machine-next
@@ -2155,7 +2155,7 @@ M: Ani Sinha <anisinha@redhat.com>
 M: Michael S. Tsirkin <mst@redhat.com>
 S: Supported
 F: tests/functional/acpi-bits/*
-F: tests/functional/test_acpi_bits.py
+F: tests/functional/x86_64/test_acpi_bits.py
 F: docs/devel/testing/acpi-bits.rst
 
 ACPI/HEST/GHES
@@ -2339,7 +2339,7 @@ F: net/vhost-user.c
 F: include/hw/virtio/
 F: docs/devel/virtio*
 F: docs/devel/migration/virtio.rst
-F: tests/functional/test_virtio_version.py
+F: tests/functional/x86_64/test_virtio_version.py
 
 virtio-balloon
 M: Michael S. Tsirkin <mst@redhat.com>
@@ -2351,7 +2351,7 @@ F: include/hw/virtio/virtio-balloon.h
 F: system/balloon.c
 F: include/system/balloon.h
 F: tests/qtest/virtio-balloon-test.c
-F: tests/functional/test_virtio_balloon.py
+F: tests/functional/x86_64/test_virtio_balloon.py
 
 virtio-9p
 M: Christian Schoenebeck <qemu_oss@crudebyte.com>
@@ -2374,7 +2374,7 @@ F: hw/block/virtio-blk.c
 F: hw/block/dataplane/*
 F: include/hw/virtio/virtio-blk-common.h
 F: tests/qtest/virtio-blk-test.c
-F: tests/functional/test_x86_64_hotplug_blk.py
+F: tests/functional/x86_64/test_hotplug_blk.py
 T: git https://github.com/stefanha/qemu.git block
 
 virtio-ccw
@@ -2598,7 +2598,7 @@ R: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
 S: Odd Fixes
 F: docs/system/devices/igb.rst
 F: hw/net/igb*
-F: tests/functional/test_netdev_ethtool.py
+F: tests/functional/x86_64/test_netdev_ethtool.py
 F: tests/qtest/igb-test.c
 F: tests/qtest/libqos/igb.c
 
@@ -3850,7 +3850,7 @@ S: Supported
 F: hw/i386/intel_iommu.c
 F: hw/i386/intel_iommu_internal.h
 F: include/hw/i386/intel_iommu.h
-F: tests/functional/test_intel_iommu.py
+F: tests/functional/x86_64/test_intel_iommu.py
 F: tests/qtest/intel-iommu-test.c
 
 AMD-Vi Emulation
@@ -4324,7 +4324,7 @@ F: scripts/ci/
 F: tests/docker/
 F: tests/vm/
 F: tests/lcitool/
-F: tests/functional/test_*_tuxrun.py
+F: tests/functional/*/test_tuxrun.py
 F: scripts/archive-source.sh
 F: docs/devel/testing/ci*
 F: docs/devel/testing/main.rst
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 00d18dba3ce..34e30239a6b 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -34,15 +34,7 @@ subdir('sh4')
 subdir('sh4eb')
 subdir('sparc')
 subdir('sparc64')
-
-test_x86_64_timeouts = {
-  'acpi_bits' : 420,
-  'intel_iommu': 300,
-  'netdev_ethtool' : 180,
-  'virtio_balloon': 120,
-  'x86_64_kvm_xen' : 180,
-  'x86_64_replay' : 480,
-}
+subdir('x86_64')
 
 tests_generic_system = [
   'empty_cpu_model',
@@ -56,33 +48,6 @@ tests_generic_linuxuser = [
 tests_generic_bsduser = [
 ]
 
-tests_x86_64_system_quick = [
-  'cpu_queries',
-  'mem_addr_space',
-  'x86_64_migration',
-  'pc_cpu_hotplug_props',
-  'virtio_version',
-  'x86_cpu_model_versions',
-  'vnc',
-  'memlock',
-]
-
-tests_x86_64_system_thorough = [
-  'acpi_bits',
-  'intel_iommu',
-  'linux_initrd',
-  'x86_64_multiprocess',
-  'netdev_ethtool',
-  'virtio_balloon',
-  'virtio_gpu',
-  'x86_64_hotplug_blk',
-  'x86_64_hotplug_cpu',
-  'x86_64_kvm_xen',
-  'x86_64_replay',
-  'x86_64_reverse_debug',
-  'x86_64_tuxrun',
-]
-
 tests_xtensa_system_thorough = [
   'xtensa_lx60',
   'xtensa_replay',
diff --git a/tests/functional/x86_64/meson.build b/tests/functional/x86_64/meson.build
new file mode 100644
index 00000000000..696a9ecab42
--- /dev/null
+++ b/tests/functional/x86_64/meson.build
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+test_x86_64_timeouts = {
+  'acpi_bits' : 420,
+  'intel_iommu': 300,
+  'kvm_xen' : 180,
+  'netdev_ethtool' : 180,
+  'replay' : 480,
+  'virtio_balloon': 120,
+}
+
+tests_x86_64_system_quick = [
+  'cpu_model_versions',
+  'cpu_queries',
+  'mem_addr_space',
+  'migration',
+  'pc_cpu_hotplug_props',
+  'virtio_version',
+  'vnc',
+  'memlock',
+]
+
+tests_x86_64_system_thorough = [
+  'acpi_bits',
+  'hotplug_blk',
+  'hotplug_cpu',
+  'intel_iommu',
+  'kvm_xen',
+  'linux_initrd',
+  'multiprocess',
+  'netdev_ethtool',
+  'replay',
+  'reverse_debug',
+  'tuxrun',
+  'virtio_balloon',
+  'virtio_gpu',
+]
diff --git a/tests/functional/test_acpi_bits.py b/tests/functional/x86_64/test_acpi_bits.py
similarity index 100%
rename from tests/functional/test_acpi_bits.py
rename to tests/functional/x86_64/test_acpi_bits.py
diff --git a/tests/functional/test_x86_cpu_model_versions.py b/tests/functional/x86_64/test_cpu_model_versions.py
similarity index 100%
rename from tests/functional/test_x86_cpu_model_versions.py
rename to tests/functional/x86_64/test_cpu_model_versions.py
diff --git a/tests/functional/test_cpu_queries.py b/tests/functional/x86_64/test_cpu_queries.py
similarity index 100%
rename from tests/functional/test_cpu_queries.py
rename to tests/functional/x86_64/test_cpu_queries.py
diff --git a/tests/functional/test_x86_64_hotplug_blk.py b/tests/functional/x86_64/test_hotplug_blk.py
similarity index 100%
rename from tests/functional/test_x86_64_hotplug_blk.py
rename to tests/functional/x86_64/test_hotplug_blk.py
diff --git a/tests/functional/test_x86_64_hotplug_cpu.py b/tests/functional/x86_64/test_hotplug_cpu.py
similarity index 100%
rename from tests/functional/test_x86_64_hotplug_cpu.py
rename to tests/functional/x86_64/test_hotplug_cpu.py
diff --git a/tests/functional/test_intel_iommu.py b/tests/functional/x86_64/test_intel_iommu.py
similarity index 100%
rename from tests/functional/test_intel_iommu.py
rename to tests/functional/x86_64/test_intel_iommu.py
diff --git a/tests/functional/test_x86_64_kvm_xen.py b/tests/functional/x86_64/test_kvm_xen.py
similarity index 100%
rename from tests/functional/test_x86_64_kvm_xen.py
rename to tests/functional/x86_64/test_kvm_xen.py
diff --git a/tests/functional/test_linux_initrd.py b/tests/functional/x86_64/test_linux_initrd.py
similarity index 100%
rename from tests/functional/test_linux_initrd.py
rename to tests/functional/x86_64/test_linux_initrd.py
diff --git a/tests/functional/test_mem_addr_space.py b/tests/functional/x86_64/test_mem_addr_space.py
similarity index 100%
rename from tests/functional/test_mem_addr_space.py
rename to tests/functional/x86_64/test_mem_addr_space.py
diff --git a/tests/functional/test_memlock.py b/tests/functional/x86_64/test_memlock.py
similarity index 100%
rename from tests/functional/test_memlock.py
rename to tests/functional/x86_64/test_memlock.py
diff --git a/tests/functional/test_x86_64_migration.py b/tests/functional/x86_64/test_migration.py
similarity index 100%
rename from tests/functional/test_x86_64_migration.py
rename to tests/functional/x86_64/test_migration.py
diff --git a/tests/functional/test_x86_64_multiprocess.py b/tests/functional/x86_64/test_multiprocess.py
similarity index 100%
rename from tests/functional/test_x86_64_multiprocess.py
rename to tests/functional/x86_64/test_multiprocess.py
diff --git a/tests/functional/test_netdev_ethtool.py b/tests/functional/x86_64/test_netdev_ethtool.py
similarity index 100%
rename from tests/functional/test_netdev_ethtool.py
rename to tests/functional/x86_64/test_netdev_ethtool.py
diff --git a/tests/functional/test_pc_cpu_hotplug_props.py b/tests/functional/x86_64/test_pc_cpu_hotplug_props.py
similarity index 100%
rename from tests/functional/test_pc_cpu_hotplug_props.py
rename to tests/functional/x86_64/test_pc_cpu_hotplug_props.py
diff --git a/tests/functional/test_x86_64_replay.py b/tests/functional/x86_64/test_replay.py
similarity index 100%
rename from tests/functional/test_x86_64_replay.py
rename to tests/functional/x86_64/test_replay.py
diff --git a/tests/functional/test_x86_64_reverse_debug.py b/tests/functional/x86_64/test_reverse_debug.py
similarity index 100%
rename from tests/functional/test_x86_64_reverse_debug.py
rename to tests/functional/x86_64/test_reverse_debug.py
diff --git a/tests/functional/test_x86_64_tuxrun.py b/tests/functional/x86_64/test_tuxrun.py
similarity index 100%
rename from tests/functional/test_x86_64_tuxrun.py
rename to tests/functional/x86_64/test_tuxrun.py
diff --git a/tests/functional/test_virtio_balloon.py b/tests/functional/x86_64/test_virtio_balloon.py
similarity index 100%
rename from tests/functional/test_virtio_balloon.py
rename to tests/functional/x86_64/test_virtio_balloon.py
diff --git a/tests/functional/test_virtio_gpu.py b/tests/functional/x86_64/test_virtio_gpu.py
similarity index 100%
rename from tests/functional/test_virtio_gpu.py
rename to tests/functional/x86_64/test_virtio_gpu.py
diff --git a/tests/functional/test_virtio_version.py b/tests/functional/x86_64/test_virtio_version.py
similarity index 100%
rename from tests/functional/test_virtio_version.py
rename to tests/functional/x86_64/test_virtio_version.py
-- 
2.50.1


