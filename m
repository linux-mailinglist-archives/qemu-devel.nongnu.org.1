Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB35381BD1B
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 18:23:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGMif-0007aN-Sa; Thu, 21 Dec 2023 12:20:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGMid-0007ZU-27
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 12:20:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGMia-0004Uk-U7
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 12:20:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703179220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=adgA+P49tIryG72UTKIMBjU8hv7uaPLNUb4CmMR+WCw=;
 b=B9T990dw93JoE971cxRyPD1omeTlEP1Tl6scS9KF/71xi+ac73ieVlM+XVHb68Nj0KiIMW
 +PNIZOo4x9qxW+Q174ynS6ah17VNLzrHmeNq6CKAcygHoCXj2EKiuj/Tf1g6+ag8RAaPVe
 7JDJ4pApLuBiM6CISHNr9jomW2Lxv0w=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235--mAZMuAQOlyT5xoKAfXSZA-1; Thu, 21 Dec 2023 12:20:18 -0500
X-MC-Unique: -mAZMuAQOlyT5xoKAfXSZA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-33349915d3cso679002f8f.3
 for <qemu-devel@nongnu.org>; Thu, 21 Dec 2023 09:20:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703179216; x=1703784016;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=adgA+P49tIryG72UTKIMBjU8hv7uaPLNUb4CmMR+WCw=;
 b=IMPgMSp/AcYnrRf2K5LwZo3VeKFwjoXSUae+HjFaaAmMRTdqpsiJPNIwj3TYieXtaQ
 WtkQbEieFQfR4myXfUuqyYeFw2hZFSluTLsIiZIWbP13YoFtaP7n7f+wcJ/cSuBadkis
 ZcNMNj0E0B08ZWhLuxES24kixpnCV7O/gmT/MgVUz3+lRJanY8S1E0w46fAzIjf3VmZ/
 ccLl9lAlYzlYfNAaXjctPGHKNmNzNYRrKOkO2j086fzKuTmpF6GB6qEUsdTy/+ZO/ECd
 YlZIX6HwO8b3Y9XBTYC/fThqQyglYPTyNc1CvMmLdFazaHyBsUEq2Z4qLX5T0lIPrrW3
 T+Sg==
X-Gm-Message-State: AOJu0YzVsumgKuKCg+WLzZCVqmEQJuJW5AsFAqn8AeAXZmfpS00W9kF7
 TpY5xqpupYZwW2/k2ijaY5nfMWx2ImWecCKbM2CJlpp1gRxaNQHSgyuctYgdmKRd9m2N/vSGEzb
 GK0VTgZd1iwoCSrJXPdwtC1l22mudSZYZtYqfnDtl3Kz++Y6M/0HjqxDdxtdHHZ5EyTHWhBJf8H
 2dmIrvi4I=
X-Received: by 2002:a05:600c:538f:b0:40c:2dad:d394 with SMTP id
 hg15-20020a05600c538f00b0040c2dadd394mr23063wmb.149.1703179216425; 
 Thu, 21 Dec 2023 09:20:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHo5EtQer2d0/XCAUBCLV+53bUQ9YdKdxhJ8jV5z6CWYKtgYtapThAeo6idDwDwghbP6gpZ1Q==
X-Received: by 2002:a05:600c:538f:b0:40c:2dad:d394 with SMTP id
 hg15-20020a05600c538f00b0040c2dadd394mr23055wmb.149.1703179215942; 
 Thu, 21 Dec 2023 09:20:15 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:4783:a68:c1ee:15c5])
 by smtp.gmail.com with ESMTPSA id
 bi18-20020a05600c3d9200b0040d378623b1sm4006593wmb.22.2023.12.21.09.20.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 09:20:15 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/21] meson: remove OS definitions from config_targetos
Date: Thu, 21 Dec 2023 18:19:45 +0100
Message-ID: <20231221171958.59350-9-pbonzini@redhat.com>
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

CONFIG_DARWIN, CONFIG_LINUX and CONFIG_BSD are used in some rules, but
only CONFIG_LINUX has substantial use.  Convert them all to if...endif.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/tcg/meson.build  |  4 +++-
 backends/meson.build   |  4 +++-
 block/meson.build      |  4 +++-
 fsdev/meson.build      |  5 +++--
 hw/9pfs/meson.build    |  7 +++++--
 hw/display/meson.build |  7 +++++--
 hw/ppc/meson.build     |  8 +++++---
 hw/usb/meson.build     |  4 +++-
 meson.build            |  8 --------
 net/can/meson.build    |  4 +++-
 qga/meson.build        | 11 +++++------
 scsi/meson.build       |  8 +++++---
 system/meson.build     |  4 +++-
 ui/meson.build         |  7 +++----
 util/meson.build       | 14 ++++++++------
 15 files changed, 57 insertions(+), 42 deletions(-)

diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
index 8783edd06ee..1dad6bbbfbd 100644
--- a/accel/tcg/meson.build
+++ b/accel/tcg/meson.build
@@ -17,7 +17,9 @@ if get_option('plugins')
   tcg_ss.add(files('plugin-gen.c'))
 endif
 tcg_ss.add(when: libdw, if_true: files('debuginfo.c'))
-tcg_ss.add(when: 'CONFIG_LINUX', if_true: files('perf.c'))
+if targetos == 'linux'
+  tcg_ss.add(files('perf.c'))
+endif
 specific_ss.add_all(when: 'CONFIG_TCG', if_true: tcg_ss)
 
 specific_ss.add(when: ['CONFIG_SYSTEM_ONLY', 'CONFIG_TCG'], if_true: files(
diff --git a/backends/meson.build b/backends/meson.build
index 9a5cea480d1..248ce4923c6 100644
--- a/backends/meson.build
+++ b/backends/meson.build
@@ -12,7 +12,9 @@ system_ss.add([files(
 
 system_ss.add(when: 'CONFIG_POSIX', if_true: files('rng-random.c'))
 system_ss.add(when: 'CONFIG_POSIX', if_true: files('hostmem-file.c'))
-system_ss.add(when: 'CONFIG_LINUX', if_true: files('hostmem-memfd.c'))
+if targetos == 'linux'
+  system_ss.add(files('hostmem-memfd.c'))
+endif
 if keyutils.found()
     system_ss.add(keyutils, files('cryptodev-lkcf.c'))
 endif
diff --git a/block/meson.build b/block/meson.build
index 59ff6d380c0..7faed96c1e7 100644
--- a/block/meson.build
+++ b/block/meson.build
@@ -91,7 +91,9 @@ endif
 block_ss.add(when: 'CONFIG_WIN32', if_true: files('file-win32.c', 'win32-aio.c'))
 block_ss.add(when: 'CONFIG_POSIX', if_true: [files('file-posix.c'), coref, iokit])
 block_ss.add(when: libiscsi, if_true: files('iscsi-opts.c'))
-block_ss.add(when: 'CONFIG_LINUX', if_true: files('nvme.c'))
+if targetos == 'linux'
+  block_ss.add(files('nvme.c'))
+endif
 if get_option('replication').allowed()
   block_ss.add(files('replication.c'))
 endif
diff --git a/fsdev/meson.build b/fsdev/meson.build
index 1bec0659245..c76347615df 100644
--- a/fsdev/meson.build
+++ b/fsdev/meson.build
@@ -6,8 +6,9 @@ fsdev_ss.add(when: ['CONFIG_FSDEV_9P'], if_true: files(
   '9p-marshal.c',
   'qemu-fsdev.c',
 ), if_false: files('qemu-fsdev-dummy.c'))
-system_ss.add_all(when: 'CONFIG_LINUX', if_true: fsdev_ss)
-system_ss.add_all(when: 'CONFIG_DARWIN', if_true: fsdev_ss)
+if targetos in ['linux', 'darwin']
+  system_ss.add_all(fsdev_ss)
+endif
 
 if have_virtfs_proxy_helper
   executable('virtfs-proxy-helper',
diff --git a/hw/9pfs/meson.build b/hw/9pfs/meson.build
index 2944ea63c38..3eee7c268a9 100644
--- a/hw/9pfs/meson.build
+++ b/hw/9pfs/meson.build
@@ -13,8 +13,11 @@ fs_ss.add(files(
   'coth.c',
   'coxattr.c',
 ))
-fs_ss.add(when: 'CONFIG_LINUX', if_true: files('9p-util-linux.c'))
-fs_ss.add(when: 'CONFIG_DARWIN', if_true: files('9p-util-darwin.c'))
+if targetos == 'darwin'
+  fs_ss.add(files('9p-util-darwin.c'))
+elif targetos == 'linux'
+  fs_ss.add(files('9p-util-linux.c'))
+endif
 fs_ss.add(when: 'CONFIG_XEN_BUS', if_true: files('xen-9p-backend.c'))
 system_ss.add_all(when: 'CONFIG_FSDEV_9P', if_true: fs_ss)
 
diff --git a/hw/display/meson.build b/hw/display/meson.build
index 344dfe3d8c2..02b0044c9ec 100644
--- a/hw/display/meson.build
+++ b/hw/display/meson.build
@@ -69,8 +69,11 @@ if config_all_devices.has_key('CONFIG_VIRTIO_GPU')
   virtio_gpu_ss = ss.source_set()
   virtio_gpu_ss.add(when: 'CONFIG_VIRTIO_GPU',
                     if_true: [files('virtio-gpu-base.c', 'virtio-gpu.c'), pixman])
-  virtio_gpu_ss.add(when: 'CONFIG_LINUX', if_true: files('virtio-gpu-udmabuf.c'),
-                                          if_false: files('virtio-gpu-udmabuf-stubs.c'))
+  if targetos == 'linux'
+    virtio_gpu_ss.add(files('virtio-gpu-udmabuf.c'))
+  else
+    virtio_gpu_ss.add(files('virtio-gpu-udmabuf-stubs.c'))
+  endif
   virtio_gpu_ss.add(when: 'CONFIG_VHOST_USER_GPU', if_true: files('vhost-user-gpu.c'))
   hw_display_modules += {'virtio-gpu': virtio_gpu_ss}
 
diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
index ea44856d43b..3dedcf3043d 100644
--- a/hw/ppc/meson.build
+++ b/hw/ppc/meson.build
@@ -34,9 +34,11 @@ ppc_ss.add(when: ['CONFIG_PSERIES', 'CONFIG_TCG'], if_true: files(
   'spapr_softmmu.c',
 ))
 ppc_ss.add(when: 'CONFIG_SPAPR_RNG', if_true: files('spapr_rng.c'))
-ppc_ss.add(when: ['CONFIG_PSERIES', 'CONFIG_LINUX'], if_true: files(
-  'spapr_pci_vfio.c',
-))
+if targetos == 'linux'
+  ppc_ss.add(when: 'CONFIG_PSERIES', if_true: files(
+    'spapr_pci_vfio.c',
+  ))
+endif
 
 # IBM PowerNV
 ppc_ss.add(when: 'CONFIG_POWERNV', if_true: files(
diff --git a/hw/usb/meson.build b/hw/usb/meson.build
index e94149ebdeb..4b44db39cd3 100644
--- a/hw/usb/meson.build
+++ b/hw/usb/meson.build
@@ -58,7 +58,9 @@ endif
 
 # U2F
 system_ss.add(when: 'CONFIG_USB_U2F', if_true: files('u2f.c'))
-system_ss.add(when: ['CONFIG_LINUX', 'CONFIG_USB_U2F'], if_true: [libudev, files('u2f-passthru.c')])
+if targetos == 'linux'
+  system_ss.add(when: 'CONFIG_USB_U2F', if_true: [libudev, files('u2f-passthru.c')])
+endif
 if u2f.found()
   system_ss.add(when: 'CONFIG_USB_U2F', if_true: [u2f, files('u2f-emulated.c')])
 endif
diff --git a/meson.build b/meson.build
index de33e323d43..ac11adc6c13 100644
--- a/meson.build
+++ b/meson.build
@@ -2843,14 +2843,6 @@ minikconf = find_program('scripts/minikconf.py')
 config_targetos = {
   (targetos == 'windows' ? 'CONFIG_WIN32' : 'CONFIG_POSIX'): 'y'
 }
-if targetos == 'darwin'
-  config_targetos += {'CONFIG_DARWIN': 'y'}
-elif targetos == 'linux'
-  config_targetos += {'CONFIG_LINUX': 'y'}
-endif
-if targetos in bsd_oses
-  config_targetos += {'CONFIG_BSD': 'y'}
-endif
 
 config_all = {}
 config_all_devices = {}
diff --git a/net/can/meson.build b/net/can/meson.build
index 45693c82c9d..bdf6f8eee16 100644
--- a/net/can/meson.build
+++ b/net/can/meson.build
@@ -1,5 +1,7 @@
 can_ss = ss.source_set()
 can_ss.add(files('can_core.c', 'can_host.c'))
-can_ss.add(when: 'CONFIG_LINUX', if_true: files('can_socketcan.c'))
+if targetos == 'linux'
+  can_ss.add(files('can_socketcan.c'))
+endif
 
 system_ss.add_all(when: 'CONFIG_CAN_BUS', if_true: can_ss)
diff --git a/qga/meson.build b/qga/meson.build
index a6af614891a..50edaf1c3d4 100644
--- a/qga/meson.build
+++ b/qga/meson.build
@@ -72,12 +72,11 @@ qga_ss.add(when: 'CONFIG_POSIX', if_true: files(
   'commands-posix.c',
   'commands-posix-ssh.c',
 ))
-qga_ss.add(when: 'CONFIG_LINUX', if_true: files(
-  'commands-linux.c',
-))
-qga_ss.add(when: 'CONFIG_BSD', if_true: files(
-  'commands-bsd.c',
-))
+if targetos == 'linux'
+  qga_ss.add(files('commands-linux.c'))
+elif targetos in bsd_oses
+  qga_ss.add(files('commands-bsd.c'))
+endif
 qga_ss.add(when: 'CONFIG_WIN32', if_true: files(
   'channel-win32.c',
   'commands-win32.c',
diff --git a/scsi/meson.build b/scsi/meson.build
index 53f3a1f7169..0ff2b3affe0 100644
--- a/scsi/meson.build
+++ b/scsi/meson.build
@@ -1,4 +1,6 @@
 block_ss.add(files('utils.c'))
-block_ss.add(when: 'CONFIG_LINUX',
-             if_true: files('pr-manager.c', 'pr-manager-helper.c'),
-             if_false: files('pr-manager-stub.c'))
+if targetos == 'linux'
+  block_ss.add(files('pr-manager.c', 'pr-manager-helper.c'))
+else
+  block_ss.add(files('pr-manager-stub.c'))
+endif
diff --git a/system/meson.build b/system/meson.build
index 3a64dd89de1..0632a3daa8a 100644
--- a/system/meson.build
+++ b/system/meson.build
@@ -33,4 +33,6 @@ endif
 
 system_ss.add(when: seccomp, if_true: files('qemu-seccomp.c'))
 system_ss.add(when: fdt, if_true: files('device_tree.c'))
-system_ss.add(when: 'CONFIG_LINUX', if_true: files('async-teardown.c'))
+if targetos == 'linux'
+  system_ss.add('async-teardown.c')
+endif
diff --git a/ui/meson.build b/ui/meson.build
index 0ccb3387ee6..8379a788a1a 100644
--- a/ui/meson.build
+++ b/ui/meson.build
@@ -25,10 +25,9 @@ endif
 system_ss.add([spice_headers, files('spice-module.c')])
 system_ss.add(when: spice_protocol, if_true: files('vdagent.c'))
 
-system_ss.add(when: 'CONFIG_LINUX', if_true: files(
-  'input-linux.c',
-  'udmabuf.c',
-))
+if targetos == 'linux'
+  system_ss.add(files('input-linux.c', 'udmabuf.c'))
+endif
 system_ss.add(when: cocoa, if_true: files('cocoa.m'))
 
 vnc_ss = ss.source_set()
diff --git a/util/meson.build b/util/meson.build
index 174c133368a..98dd7fa5340 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -71,7 +71,9 @@ endif
 if have_system
   util_ss.add(files('crc-ccitt.c'))
   util_ss.add(when: gio, if_true: files('dbus.c'))
-  util_ss.add(when: 'CONFIG_LINUX', if_true: files('userfaultfd.c'))
+  if targetos == 'linux'
+    util_ss.add(files('userfaultfd.c'))
+  endif
 endif
 
 if have_block or have_ga
@@ -92,9 +94,6 @@ if have_block
   util_ss.add(files('iova-tree.c'))
   util_ss.add(files('iov.c', 'uri.c'))
   util_ss.add(files('nvdimm-utils.c'))
-  util_ss.add(when: 'CONFIG_LINUX', if_true: [
-    files('vhost-user-server.c'), vhost_user
-  ])
   util_ss.add(files('block-helpers.c'))
   util_ss.add(files('qemu-coroutine-sleep.c'))
   util_ss.add(files('qemu-co-shared-resource.c'))
@@ -107,8 +106,11 @@ if have_block
   else
     util_ss.add(files('filemonitor-stub.c'))
   endif
-  util_ss.add(when: 'CONFIG_LINUX', if_true: files('vfio-helpers.c'))
-  util_ss.add(when: 'CONFIG_LINUX', if_true: files('chardev_open.c'))
+  if targetos == 'linux'
+    util_ss.add(files('vhost-user-server.c'), vhost_user)
+    util_ss.add(files('vfio-helpers.c'))
+    util_ss.add(files('chardev_open.c'))
+  endif
 endif
 
 if cpu == 'aarch64'
-- 
2.43.0


