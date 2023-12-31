Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CBD820AA0
	for <lists+qemu-devel@lfdr.de>; Sun, 31 Dec 2023 09:54:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJrUq-0007x7-Mz; Sun, 31 Dec 2023 03:48:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrTB-0005Ji-A7
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:46:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrT8-0000sw-Es
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:46:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704012409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AxGwFo1qj4k45OEkCwl/PjR9YwnxbrqDCz72PvJQCz8=;
 b=Oe8QRvijCaLMBytTDl/80OETUS9C/wIlPlXOqKm9ZELq8hdieYC6BRptXJ3RUISj/111A2
 ECBEpCGqSVNy2h75XehaaSozci7XLa5UyTwO4eHeT7yyjXE0R9/8c9d0dDLLY66Be8siwW
 DdbCKdIKmXPyQXg0zQCfKDHA90LzCpQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-Pu847ntgPUih_7kGbXNllQ-1; Sun, 31 Dec 2023 03:46:47 -0500
X-MC-Unique: Pu847ntgPUih_7kGbXNllQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3368698f0caso5818688f8f.1
 for <qemu-devel@nongnu.org>; Sun, 31 Dec 2023 00:46:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704012405; x=1704617205;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AxGwFo1qj4k45OEkCwl/PjR9YwnxbrqDCz72PvJQCz8=;
 b=dAvwU0HE8S0xf7saloWLRAxe7Mr3hOSPL9C6ESp1E+oCrYjseY0YrqK45N78zCXLZE
 a/BoExChJIUpNfPnyzZC7ImijA7McjU3b9fpzaas5TOv23ezlSSYWJfrk3Rpab7vR6Bz
 oQpvWt+kDxsuBEG/vLh3LFEUs98hKek/hQt1Kz2wf00iV5XuvZg4rw1hDjg7MbzDd1aq
 x68vsstmFDXw0qk7t6WxivD9dom5X5DTTW8HlBO51Xn0smfOAUIwBhs06eSES88XmmiH
 CBUT/ynUK67f/ODygdpbHy7vXGZQch9Lf+3Wrjhp+otE0gRksY86jtoApXnf3u5+A/x9
 gukQ==
X-Gm-Message-State: AOJu0YxuuER5CS7Zi7nrux3gdnyhr+ciHvlTihqNtOOTu+J9FRvjsSwQ
 HwwCUC18d0WIzBM7ShjzyMPnUbCPoADE9xcyI9L7stgF5pYT/azpSnMypEfC4Cl7WBD3AcGqIeS
 8Ly2DecdcvOUer0ydNy7x0iw49WTyCTLxthxqxzfqYF6mWgjvVY0asXogC3EAOWnfmKmqeisd7H
 XHOiwsDF4=
X-Received: by 2002:adf:eed0:0:b0:337:eec:62e3 with SMTP id
 a16-20020adfeed0000000b003370eec62e3mr1300348wrp.17.1704012405429; 
 Sun, 31 Dec 2023 00:46:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEHej7sMwFdUtw3Gtw+xyK40Edgm41vp3fPfNaKNslVS3IiiMp0HFwmjw9JfEYeHRUAazgozw==
X-Received: by 2002:adf:eed0:0:b0:337:eec:62e3 with SMTP id
 a16-20020adfeed0000000b003370eec62e3mr1300345wrp.17.1704012405031; 
 Sun, 31 Dec 2023 00:46:45 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 y17-20020adff151000000b003366aad3564sm23308395wro.30.2023.12.31.00.46.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Dec 2023 00:46:44 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 40/46] meson: remove OS definitions from config_targetos
Date: Sun, 31 Dec 2023 09:44:56 +0100
Message-ID: <20231231084502.235366-41-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231231084502.235366-1-pbonzini@redhat.com>
References: <20231231084502.235366-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.667,
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
index 7344e363826..cf224e252c6 100644
--- a/meson.build
+++ b/meson.build
@@ -2888,14 +2888,6 @@ minikconf = find_program('scripts/minikconf.py')
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


