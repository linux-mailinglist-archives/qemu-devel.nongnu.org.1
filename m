Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7910C81BCFC
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 18:21:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGMik-0007bM-4n; Thu, 21 Dec 2023 12:20:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGMii-0007ax-Ob
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 12:20:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGMig-0004Vb-DF
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 12:20:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703179225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hv5JlMMu+kt6QWVUatqaPVLHyGybXwKvJleBgwjh6E0=;
 b=cArRNGgROsoLunlARuNM1X+vrHZ1inemfK+WVtPvkMb3xJ+I7EH28wIY9zlHwNSifvAMr2
 bn9Mk4qNstLiycdkVBHV7qCBmauBpztzPY5a0ScLCSZ54cpdV04vqSBQI2xN+6Z2zZFSHy
 lXzKTBGu9o8p0pbjPQECXm5EJE8j7hY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-cL-DjsxIO2qQbOGi002-ZQ-1; Thu, 21 Dec 2023 12:20:23 -0500
X-MC-Unique: cL-DjsxIO2qQbOGi002-ZQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-40d3eabab1eso5759855e9.2
 for <qemu-devel@nongnu.org>; Thu, 21 Dec 2023 09:20:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703179222; x=1703784022;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hv5JlMMu+kt6QWVUatqaPVLHyGybXwKvJleBgwjh6E0=;
 b=OChsZ618LybvNsBNiHH7ysq/GYufkRLeg9fPmGO/5JfoMb4m5Ymb9q8HMm2QTcZHNj
 TLNCQWACgThVlNLh2E9n0VXEgCIBfbAhRjUJO9mJhgH8zkT/DTO8zkfJI5OMs+2vG92R
 CociGqnxq90XYZBEnTuQXFLNlR8Zc/KmEy+ZIw+AZmaoy1Qd88eWh7RuG26pkxV+9HGD
 oJUUzMcmebB/XRhJMxyP0UhF1QpcLfXYeT82M2cIenpWAPwvtgbpq0MUHfnF/bRz2M7B
 CRIwoCzYpJsP6Dba8XpNz9g8nwOrIK8X+kDIeVhblbrAoDtvlxt9iLbH6okF5ZdnTi8b
 P5Kg==
X-Gm-Message-State: AOJu0Yy/tRrzXhdQu7qDcbzIKUl4XH4uUOBSIZkBGVplyH3MmpUVRAX7
 Ita+V5ix+i1jT1Wot/7uuX9ujk4W/C5ihZUcRFqsgaRe6c8yZ0KWrJoNDK3s3HVfuBUbGfysxR+
 wrXZLM2HXgK5MdASxzHPybEkXbImjaN1+ql1LdejPjb8omWCnWFpzqPqLZ/0+2AaowBcildLIrZ
 l4q1TveCg=
X-Received: by 2002:a05:600c:4f56:b0:40c:69dc:18ac with SMTP id
 m22-20020a05600c4f5600b0040c69dc18acmr41702wmq.59.1703179221654; 
 Thu, 21 Dec 2023 09:20:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEiJrU/8amStlbHPKIySQfVpITIPNAVCT9o6ACnpahWp045cQJTqqO8nPvdlZQxEi17mCBOxQ==
X-Received: by 2002:a05:600c:4f56:b0:40c:69dc:18ac with SMTP id
 m22-20020a05600c4f5600b0040c69dc18acmr41695wmq.59.1703179221190; 
 Thu, 21 Dec 2023 09:20:21 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:4783:a68:c1ee:15c5])
 by smtp.gmail.com with ESMTPSA id
 g3-20020a05600c310300b0040c6b2c8fa9sm11862842wmo.41.2023.12.21.09.20.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 09:20:19 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/21] meson: remove CONFIG_ALL
Date: Thu, 21 Dec 2023 18:19:48 +0100
Message-ID: <20231221171958.59350-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221171958.59350-1-pbonzini@redhat.com>
References: <20231221171958.59350-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.061,
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

CONFIG_ALL is tricky to use and was ported over to Meson from the
recursive processing of Makefile variables.  Meson sourcesets
however have all_sources() and all_dependencies() methods that
remove the need for it.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/build-system.rst | 15 ---------------
 fsdev/meson.build           |  1 -
 hw/acpi/meson.build         |  5 -----
 hw/cxl/meson.build          |  2 --
 hw/display/meson.build      |  1 -
 hw/mem/meson.build          |  1 -
 hw/net/meson.build          |  2 --
 hw/pci-bridge/meson.build   |  2 --
 hw/pci/meson.build          |  1 -
 hw/remote/meson.build       |  1 -
 hw/smbios/meson.build       |  5 -----
 hw/virtio/meson.build       |  2 --
 meson.build                 | 32 +++++++-------------------------
 net/meson.build             |  2 --
 14 files changed, 7 insertions(+), 65 deletions(-)

diff --git a/docs/devel/build-system.rst b/docs/devel/build-system.rst
index 43d6005881e..09caf2f8e19 100644
--- a/docs/devel/build-system.rst
+++ b/docs/devel/build-system.rst
@@ -256,21 +256,6 @@ Target-independent emulator sourcesets:
   ``system_ss`` only in system emulators, ``user_ss`` only in user-mode
   emulators.
 
-  Target-independent sourcesets must exercise particular care when using
-  ``if_false`` rules.  The ``if_false`` rule will be used correctly when linking
-  emulator binaries; however, when *compiling* target-independent files
-  into .o files, Meson may need to pick *both* the ``if_true`` and
-  ``if_false`` sides to cater for targets that want either side.  To
-  achieve that, you can add a special rule using the ``CONFIG_ALL``
-  symbol::
-
-    # Some targets have CONFIG_ACPI, some don't, so this is not enough
-    system_ss.add(when: 'CONFIG_ACPI', if_true: files('acpi.c'),
-                                        if_false: files('acpi-stub.c'))
-
-    # This is required as well:
-    system_ss.add(when: 'CONFIG_ALL', if_true: files('acpi-stub.c'))
-
 Target-dependent emulator sourcesets:
   In the target-dependent set lives CPU emulation, some device emulation and
   much glue code. This sometimes also has to be compiled multiple times,
diff --git a/fsdev/meson.build b/fsdev/meson.build
index c76347615df..db67530d7f2 100644
--- a/fsdev/meson.build
+++ b/fsdev/meson.build
@@ -1,6 +1,5 @@
 fsdev_ss = ss.source_set()
 fsdev_ss.add(files('qemu-fsdev-opts.c', 'qemu-fsdev-throttle.c'))
-fsdev_ss.add(when: 'CONFIG_ALL', if_true: files('qemu-fsdev-dummy.c'))
 fsdev_ss.add(when: ['CONFIG_FSDEV_9P'], if_true: files(
   '9p-iov-marshal.c',
   '9p-marshal.c',
diff --git a/hw/acpi/meson.build b/hw/acpi/meson.build
index fc1b952379a..5441c9b1e4c 100644
--- a/hw/acpi/meson.build
+++ b/hw/acpi/meson.build
@@ -33,9 +33,4 @@ endif
 system_ss.add(when: 'CONFIG_ACPI', if_false: files('acpi-stub.c', 'aml-build-stub.c', 'ghes-stub.c', 'acpi_interface.c'))
 system_ss.add(when: 'CONFIG_ACPI_PCI_BRIDGE', if_false: files('pci-bridge-stub.c'))
 system_ss.add_all(when: 'CONFIG_ACPI', if_true: acpi_ss)
-system_ss.add(when: 'CONFIG_ALL', if_true: files('acpi-stub.c', 'aml-build-stub.c',
-                                                  'acpi-x86-stub.c', 'ipmi-stub.c', 'ghes-stub.c',
-                                                  'acpi-mem-hotplug-stub.c', 'acpi-cpu-hotplug-stub.c',
-                                                  'acpi-pci-hotplug-stub.c', 'acpi-nvdimm-stub.c',
-                                                  'cxl-stub.c', 'pci-bridge-stub.c'))
 system_ss.add(files('acpi-qmp-cmds.c'))
diff --git a/hw/cxl/meson.build b/hw/cxl/meson.build
index ea0aebf6e3c..3e375f61a98 100644
--- a/hw/cxl/meson.build
+++ b/hw/cxl/meson.build
@@ -11,5 +11,3 @@ system_ss.add(when: 'CONFIG_CXL',
                if_false: files(
                    'cxl-host-stubs.c',
                ))
-
-system_ss.add(when: 'CONFIG_ALL', if_true: files('cxl-host-stubs.c'))
diff --git a/hw/display/meson.build b/hw/display/meson.build
index 02b0044c9ec..ac0159c516e 100644
--- a/hw/display/meson.build
+++ b/hw/display/meson.build
@@ -143,5 +143,4 @@ endif
 
 system_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_lcdc.c'))
 
-system_ss.add(when: 'CONFIG_ALL', if_true: files('acpi-vga-stub.c'))
 modules += { 'hw-display': hw_display_modules }
diff --git a/hw/mem/meson.build b/hw/mem/meson.build
index ec26ef55443..faee1fe9360 100644
--- a/hw/mem/meson.build
+++ b/hw/mem/meson.build
@@ -5,7 +5,6 @@ mem_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx_mc.c'))
 mem_ss.add(when: 'CONFIG_NVDIMM', if_true: files('nvdimm.c'))
 mem_ss.add(when: 'CONFIG_CXL_MEM_DEVICE', if_true: files('cxl_type3.c'))
 system_ss.add(when: 'CONFIG_CXL_MEM_DEVICE', if_false: files('cxl_type3_stubs.c'))
-system_ss.add(when: 'CONFIG_ALL', if_true: files('cxl_type3_stubs.c'))
 
 system_ss.add_all(when: 'CONFIG_MEM_DEVICE', if_true: mem_ss)
 
diff --git a/hw/net/meson.build b/hw/net/meson.build
index f64651c467e..9afceb06191 100644
--- a/hw/net/meson.build
+++ b/hw/net/meson.build
@@ -50,7 +50,6 @@ specific_ss.add(when: 'CONFIG_VIRTIO_NET', if_true: files('virtio-net.c'))
 
 if have_vhost_net
   system_ss.add(when: 'CONFIG_VIRTIO_NET', if_true: files('vhost_net.c'), if_false: files('vhost_net-stub.c'))
-  system_ss.add(when: 'CONFIG_ALL', if_true: files('vhost_net-stub.c'))
 else
   system_ss.add(files('vhost_net-stub.c'))
 endif
@@ -69,7 +68,6 @@ system_ss.add(when: 'CONFIG_ROCKER', if_true: files(
   'rocker/rocker_of_dpa.c',
   'rocker/rocker_world.c',
 ), if_false: files('rocker/qmp-norocker.c'))
-system_ss.add(when: 'CONFIG_ALL', if_true: files('rocker/qmp-norocker.c'))
 system_ss.add(files('rocker/rocker-hmp-cmds.c'))
 
 subdir('can')
diff --git a/hw/pci-bridge/meson.build b/hw/pci-bridge/meson.build
index 6d5ad9f37b2..f2a60434dda 100644
--- a/hw/pci-bridge/meson.build
+++ b/hw/pci-bridge/meson.build
@@ -13,5 +13,3 @@ pci_ss.add(when: 'CONFIG_CXL', if_true: files('cxl_root_port.c', 'cxl_upstream.c
 pci_ss.add(when: 'CONFIG_SIMBA', if_true: files('simba.c'))
 
 system_ss.add_all(when: 'CONFIG_PCI', if_true: pci_ss)
-
-system_ss.add(when: 'CONFIG_ALL', if_true: files('pci_expander_bridge_stubs.c'))
diff --git a/hw/pci/meson.build b/hw/pci/meson.build
index b1855452f5b..b9c34b2acfe 100644
--- a/hw/pci/meson.build
+++ b/hw/pci/meson.build
@@ -20,4 +20,3 @@ system_ss.add(when: 'CONFIG_PCI_EXPRESS', if_true: files('pcie_port.c', 'pcie_ho
 system_ss.add_all(when: 'CONFIG_PCI', if_true: pci_ss)
 
 system_ss.add(when: 'CONFIG_PCI', if_false: files('pci-stub.c'))
-system_ss.add(when: 'CONFIG_ALL', if_true: files('pci-stub.c'))
diff --git a/hw/remote/meson.build b/hw/remote/meson.build
index a3aa29aaf17..41eb4971d98 100644
--- a/hw/remote/meson.build
+++ b/hw/remote/meson.build
@@ -11,7 +11,6 @@ remote_ss.add(when: 'CONFIG_MULTIPROCESS', if_true: files('iommu.c'))
 remote_ss.add(when: 'CONFIG_VFIO_USER_SERVER', if_true: libvfio_user_dep)
 remote_ss.add(when: 'CONFIG_VFIO_USER_SERVER', if_true: files('vfio-user-obj.c'),
               if_false: files('vfio-user-obj-stub.c'))
-remote_ss.add(when: 'CONFIG_ALL', if_true: files('vfio-user-obj-stub.c'))
 
 specific_ss.add(when: 'CONFIG_MULTIPROCESS', if_true: files('memory.c'))
 specific_ss.add(when: 'CONFIG_MULTIPROCESS', if_true: files('proxy-memory-listener.c'))
diff --git a/hw/smbios/meson.build b/hw/smbios/meson.build
index 6eeae4b35c2..70469674621 100644
--- a/hw/smbios/meson.build
+++ b/hw/smbios/meson.build
@@ -6,8 +6,3 @@ smbios_ss.add(when: 'CONFIG_IPMI',
 
 system_ss.add_all(when: 'CONFIG_SMBIOS', if_true: smbios_ss)
 system_ss.add(when: 'CONFIG_SMBIOS', if_false: files('smbios-stub.c'))
-
-system_ss.add(when: 'CONFIG_ALL', if_true: files(
-  'smbios-stub.c',
-  'smbios_type_38-stub.c',
-))
diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index c0055a78326..c8c1001451d 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -74,8 +74,6 @@ specific_virtio_ss.add_all(when: 'CONFIG_VIRTIO_PCI', if_true: virtio_pci_ss)
 system_ss.add_all(when: 'CONFIG_VIRTIO', if_true: system_virtio_ss)
 system_ss.add(when: 'CONFIG_VIRTIO', if_false: files('vhost-stub.c'))
 system_ss.add(when: 'CONFIG_VIRTIO', if_false: files('virtio-stub.c'))
-system_ss.add(when: 'CONFIG_ALL', if_true: files('vhost-stub.c'))
-system_ss.add(when: 'CONFIG_ALL', if_true: files('virtio-stub.c'))
 system_ss.add(files('virtio-hmp-cmds.c'))
 
 specific_ss.add_all(when: 'CONFIG_VIRTIO', if_true: specific_virtio_ss)
diff --git a/meson.build b/meson.build
index 48d619e0611..49cc1886bb2 100644
--- a/meson.build
+++ b/meson.build
@@ -2843,7 +2843,6 @@ minikconf = find_program('scripts/minikconf.py')
 
 config_all = {}
 config_all_devices = {}
-config_all_disas = {}
 config_devices_mak_list = []
 config_devices_h = {}
 config_target_h = {}
@@ -2969,7 +2968,6 @@ foreach target : target_dirs
     if host_arch.startswith(k) or config_target['TARGET_BASE_ARCH'].startswith(k)
       foreach sym: v
         config_target += { sym: 'y' }
-        config_all_disas += { sym: 'y' }
       endforeach
     endif
   endforeach
@@ -3028,24 +3026,6 @@ foreach target : target_dirs
 endforeach
 target_dirs = actual_target_dirs
 
-# This configuration is used to build files that are shared by
-# multiple binaries, and then extracted out of the "common"
-# static_library target.
-#
-# We do not use all_sources()/all_dependencies(), because it would
-# build literally all source files, including devices only used by
-# targets that are not built for this compilation.  The CONFIG_ALL
-# pseudo symbol replaces it.
-
-config_all += config_all_devices
-config_all += config_all_disas
-config_all += {
-  'CONFIG_XEN': xen.found(),
-  'CONFIG_SYSTEM_ONLY': have_system,
-  'CONFIG_USER_ONLY': have_user,
-  'CONFIG_ALL': true,
-}
-
 target_configs_h = []
 foreach target: target_dirs
   target_configs_h += config_target_h[target]
@@ -3532,7 +3512,7 @@ foreach d, list : modules
 
   foreach m, module_ss : list
     if enable_modules
-      module_ss = module_ss.apply(config_all, strict: false)
+      module_ss = module_ss.apply(config_all_devices, strict: false)
       sl = static_library(d + '-' + m, [genh, module_ss.sources()],
                           dependencies: [modulecommon, module_ss.dependencies()], pic: true)
       if d == 'block'
@@ -3727,13 +3707,15 @@ common_ss.add(qom, qemuutil)
 common_ss.add_all(when: 'CONFIG_SYSTEM_ONLY', if_true: [system_ss])
 common_ss.add_all(when: 'CONFIG_USER_ONLY', if_true: user_ss)
 
-common_all = common_ss.apply(config_all, strict: false)
+# Note that this library is never used directly (only through extract_objects)
+# and is not built by default; therefore, source files not used by the build
+# configuration will be in build.ninja, but are never built by default.
 common_all = static_library('common',
                             build_by_default: false,
-                            sources: common_all.sources() + genh,
+                            sources: common_ss.all_sources() + genh,
                             include_directories: common_user_inc,
                             implicit_include_directories: false,
-                            dependencies: common_all.dependencies(),
+                            dependencies: common_ss.all_dependencies(),
                             name_suffix: 'fa')
 
 feature_to_c = find_program('scripts/feature_to_c.py')
@@ -4206,7 +4188,7 @@ if have_system
   if xen.found()
     summary_info += {'xen ctrl version':  xen.version()}
   endif
-  summary_info += {'Xen emulation':     config_all.has_key('CONFIG_XEN_EMU')}
+  summary_info += {'Xen emulation':     config_all_devices.has_key('CONFIG_XEN_EMU')}
 endif
 summary_info += {'TCG support':       config_all.has_key('CONFIG_TCG')}
 if config_all.has_key('CONFIG_TCG')
diff --git a/net/meson.build b/net/meson.build
index ce99bd4447f..a53f18ad7b4 100644
--- a/net/meson.build
+++ b/net/meson.build
@@ -41,7 +41,6 @@ system_ss.add(when: libxdp, if_true: files('af-xdp.c'))
 
 if have_vhost_net_user
   system_ss.add(when: 'CONFIG_VIRTIO_NET', if_true: files('vhost-user.c'), if_false: files('vhost-user-stub.c'))
-  system_ss.add(when: 'CONFIG_ALL', if_true: files('vhost-user-stub.c'))
 endif
 
 if targetos == 'windows'
@@ -57,7 +56,6 @@ else
 endif
 if have_vhost_net_vdpa
   system_ss.add(when: 'CONFIG_VIRTIO_NET', if_true: files('vhost-vdpa.c'), if_false: files('vhost-vdpa-stub.c'))
-  system_ss.add(when: 'CONFIG_ALL', if_true: files('vhost-vdpa-stub.c'))
 endif
 
 vmnet_files = files(
-- 
2.43.0


