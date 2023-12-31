Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C82820A91
	for <lists+qemu-devel@lfdr.de>; Sun, 31 Dec 2023 09:51:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJrV0-0008HJ-6R; Sun, 31 Dec 2023 03:48:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrTD-0005Oo-Nb
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:46:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrT9-0000t9-PF
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:46:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704012410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s0GUYeMWEAuZNHXr2ou3/l5UdPWTlynLj+0ixERDlo8=;
 b=jAamp2tRWRyaGJJW8r3xAYJN2FdV0vFwnZqLmx+P2tc3Gu9JlMsBuAsYoQ5UJiRd2JbrkD
 OuvpP4NZHaxs9whVMvgt+m/GNFp82Rs4T8m/LqVlMe0znq7gMWiqkw2FGi9KLOiPE4KL/S
 NolXX2Dc4vzqEWygX/9pNzPVqFBIr7Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-MxFF9KsIP22hG5i_tQuiFQ-1; Sun, 31 Dec 2023 03:46:48 -0500
X-MC-Unique: MxFF9KsIP22hG5i_tQuiFQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-33697cbd035so4960714f8f.2
 for <qemu-devel@nongnu.org>; Sun, 31 Dec 2023 00:46:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704012407; x=1704617207;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s0GUYeMWEAuZNHXr2ou3/l5UdPWTlynLj+0ixERDlo8=;
 b=c7+szwwXcZvn0zOPivpP1etWCaWqipKm+uJXV0Ez/i+POSDTSeskdZSySCw3HDS0lB
 sS5g9SZUBWKvKJJd+yBZf3WcNiy2lLUSSsLE8sGgpbPUOnGCzmrM96q+Uo9jxd69YjYu
 GjN4/WYXBXNKwFe5IsAC2317vaqLGUoSNbVioTmTzWXWxLTqO83d3B0beuDVuJlWfJTa
 yDhVBzvXtt1Kly6ToAFZORjj5ta/KWcWdgAqkYJJ9kooQxnfGWTMi32jFXHaPL/9Ivgv
 Q+ybE904PNYzixlfHUlHAvkHja224Lxi9pZSqWsEo5nVvF0+KAOy2WscrV8FT/BB4i/n
 qygA==
X-Gm-Message-State: AOJu0YxYiCtauxZoLZH+QGce3o/JPa65M92RSB7NN5lYZS7cWUEzzMvk
 GSveiD1IFaJ/EL6zNGe4h8L+VdY3esIgsQId+H/Pj5nE5+cxn8p4Sq1xdzTg4nHL/7uWLrZJ7/x
 r/h6PqYQrwfvYg4vcCTOrirvD2mEQKEevji3TqAKdaOMcRCxB8D2EKUIfPPgAOfIqg4vGGpb95W
 QGio3SaW4=
X-Received: by 2002:a5d:6c6d:0:b0:337:3f72:3ddf with SMTP id
 r13-20020a5d6c6d000000b003373f723ddfmr79946wrz.171.1704012407156; 
 Sun, 31 Dec 2023 00:46:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHIV/VXBJdGILH4mWL/HoxFCpnpaieA5TXIFFkei1F9weRHUMoD+srr7HCaejsMETQxs3zisg==
X-Received: by 2002:a5d:6c6d:0:b0:337:3f72:3ddf with SMTP id
 r13-20020a5d6c6d000000b003373f723ddfmr79940wrz.171.1704012406716; 
 Sun, 31 Dec 2023 00:46:46 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 k4-20020a5d5244000000b003368c8d120fsm21926356wrc.7.2023.12.31.00.46.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Dec 2023 00:46:46 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 41/46] meson: remove CONFIG_POSIX and CONFIG_WIN32 from
 config_targetos
Date: Sun, 31 Dec 2023 09:44:57 +0100
Message-ID: <20231231084502.235366-42-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231231084502.235366-1-pbonzini@redhat.com>
References: <20231231084502.235366-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.667,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

For consistency with other OSes, use if...endif for rules that are
target-independent.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 backends/meson.build |  6 ++++--
 block/meson.build    |  7 +++++--
 chardev/meson.build  | 26 ++++++++++++++------------
 hw/usb/meson.build   |  4 +++-
 meson.build          | 11 ++++++-----
 qga/meson.build      | 33 ++++++++++++++++++---------------
 ui/meson.build       |  8 ++++++--
 util/meson.build     | 44 +++++++++++++++++++++++---------------------
 8 files changed, 79 insertions(+), 60 deletions(-)

diff --git a/backends/meson.build b/backends/meson.build
index 248ce4923c6..6dee4e9203b 100644
--- a/backends/meson.build
+++ b/backends/meson.build
@@ -10,8 +10,10 @@ system_ss.add([files(
   'confidential-guest-support.c',
 ), numa])
 
-system_ss.add(when: 'CONFIG_POSIX', if_true: files('rng-random.c'))
-system_ss.add(when: 'CONFIG_POSIX', if_true: files('hostmem-file.c'))
+if targetos != 'windows'
+  system_ss.add(files('rng-random.c'))
+  system_ss.add(files('hostmem-file.c'))
+endif
 if targetos == 'linux'
   system_ss.add(files('hostmem-memfd.c'))
 endif
diff --git a/block/meson.build b/block/meson.build
index 7faed96c1e7..ddea1e40070 100644
--- a/block/meson.build
+++ b/block/meson.build
@@ -88,8 +88,11 @@ if get_option('parallels').allowed()
   block_ss.add(files('parallels.c', 'parallels-ext.c'))
 endif
 
-block_ss.add(when: 'CONFIG_WIN32', if_true: files('file-win32.c', 'win32-aio.c'))
-block_ss.add(when: 'CONFIG_POSIX', if_true: [files('file-posix.c'), coref, iokit])
+if targetos == 'windows'
+  block_ss.add(files('file-win32.c', 'win32-aio.c'))
+else
+  block_ss.add(files('file-posix.c'), coref, iokit)
+endif
 block_ss.add(when: libiscsi, if_true: files('iscsi-opts.c'))
 if targetos == 'linux'
   block_ss.add(files('nvme.c'))
diff --git a/chardev/meson.build b/chardev/meson.build
index 6d56ad32fdb..9564ace868b 100644
--- a/chardev/meson.build
+++ b/chardev/meson.build
@@ -12,20 +12,22 @@ chardev_ss.add(files(
   'char-udp.c',
   'char.c',
 ))
-chardev_ss.add(when: 'CONFIG_POSIX', if_true: [files(
-  'char-fd.c',
-  'char-pty.c',
-), util])
-if targetos in ['linux', 'gnu/kfreebsd', 'freebsd', 'dragonfly']
-  chardev_ss.add(files('char-parallel.c'))
+if targetos == 'windows'
+  chardev_ss.add(files(
+    'char-console.c',
+    'char-win-stdio.c',
+    'char-win.c',
+  ))
+else
+  chardev_ss.add(files(
+      'char-fd.c',
+      'char-pty.c',
+    ), util)
+  if targetos in ['linux', 'gnu/kfreebsd', 'freebsd', 'dragonfly']
+    chardev_ss.add(files('char-parallel.c'))
+  endif
 endif
 
-chardev_ss.add(when: 'CONFIG_WIN32', if_true: files(
-  'char-console.c',
-  'char-win-stdio.c',
-  'char-win.c',
-))
-
 chardev_ss = chardev_ss.apply(config_targetos, strict: false)
 
 system_ss.add(files(
diff --git a/hw/usb/meson.build b/hw/usb/meson.build
index 4b44db39cd3..b7755b638fc 100644
--- a/hw/usb/meson.build
+++ b/hw/usb/meson.build
@@ -44,7 +44,9 @@ system_ss.add(when: 'CONFIG_USB_STORAGE_UAS', if_true: files('dev-uas.c'))
 system_ss.add(when: 'CONFIG_USB_AUDIO', if_true: files('dev-audio.c'))
 system_ss.add(when: 'CONFIG_USB_SERIAL', if_true: files('dev-serial.c'))
 system_ss.add(when: 'CONFIG_USB_NETWORK', if_true: files('dev-network.c'))
-system_ss.add(when: ['CONFIG_POSIX', 'CONFIG_USB_STORAGE_MTP'], if_true: files('dev-mtp.c'))
+if targetos != 'windows'
+  system_ss.add(when: 'CONFIG_USB_STORAGE_MTP', if_true: files('dev-mtp.c'))
+endif
 
 # smartcard
 system_ss.add(when: 'CONFIG_USB_SMARTCARD', if_true: files('dev-smartcard-reader.c'))
diff --git a/meson.build b/meson.build
index cf224e252c6..e37ab286c23 100644
--- a/meson.build
+++ b/meson.build
@@ -2885,9 +2885,7 @@ endif
 ########################
 
 minikconf = find_program('scripts/minikconf.py')
-config_targetos = {
-  (targetos == 'windows' ? 'CONFIG_WIN32' : 'CONFIG_POSIX'): 'y'
-}
+config_targetos = {}
 
 config_all = {}
 config_all_devices = {}
@@ -3480,8 +3478,11 @@ if have_block
 
   # os-posix.c contains POSIX-specific functions used by qemu-storage-daemon,
   # os-win32.c does not
-  blockdev_ss.add(when: 'CONFIG_POSIX', if_true: files('os-posix.c'))
-  system_ss.add(when: 'CONFIG_WIN32', if_true: [files('os-win32.c')])
+  if targetos == 'windows'
+    system_ss.add(files('os-win32.c'))
+  else
+    blockdev_ss.add(files('os-posix.c'))
+  endif
 endif
 
 common_ss.add(files('cpu-common.c'))
diff --git a/qga/meson.build b/qga/meson.build
index 50edaf1c3d4..1113e7c7fae 100644
--- a/qga/meson.build
+++ b/qga/meson.build
@@ -67,22 +67,25 @@ qga_ss.add(files(
   'main.c',
   'cutils.c',
 ))
-qga_ss.add(when: 'CONFIG_POSIX', if_true: files(
-  'channel-posix.c',
-  'commands-posix.c',
-  'commands-posix-ssh.c',
-))
-if targetos == 'linux'
-  qga_ss.add(files('commands-linux.c'))
-elif targetos in bsd_oses
-  qga_ss.add(files('commands-bsd.c'))
+if targetos == 'windows'
+  qga_ss.add(files(
+    'channel-win32.c',
+    'commands-win32.c',
+    'service-win32.c',
+    'vss-win32.c'
+  ))
+else
+  qga_ss.add(files(
+    'channel-posix.c',
+    'commands-posix.c',
+    'commands-posix-ssh.c',
+  ))
+  if targetos == 'linux'
+    qga_ss.add(files('commands-linux.c'))
+  elif targetos in bsd_oses
+    qga_ss.add(files('commands-bsd.c'))
+  endif
 endif
-qga_ss.add(when: 'CONFIG_WIN32', if_true: files(
-  'channel-win32.c',
-  'commands-win32.c',
-  'service-win32.c',
-  'vss-win32.c'
-))
 
 qga_ss = qga_ss.apply(config_targetos, strict: false)
 
diff --git a/ui/meson.build b/ui/meson.build
index 8379a788a1a..a370494c4ab 100644
--- a/ui/meson.build
+++ b/ui/meson.build
@@ -105,7 +105,9 @@ if dbus_display
 endif
 
 if gtk.found()
-  system_ss.add(when: 'CONFIG_WIN32', if_true: files('win32-kbd-hook.c'))
+  if targetos == 'windows'
+    system_ss.add(files('win32-kbd-hook.c'))
+  endif
 
   gtk_ss = ss.source_set()
   gtk_ss.add(gtk, vte, pixman, files('gtk.c'))
@@ -119,7 +121,9 @@ if gtk.found()
 endif
 
 if sdl.found()
-  system_ss.add(when: 'CONFIG_WIN32', if_true: files('win32-kbd-hook.c'))
+  if targetos == 'windows'
+    system_ss.add(files('win32-kbd-hook.c'))
+  endif
 
   sdl_ss = ss.source_set()
   sdl_ss.add(sdl, sdl_image, pixman, glib, files(
diff --git a/util/meson.build b/util/meson.build
index 98dd7fa5340..4e970d2b488 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -3,28 +3,31 @@ util_ss.add(files('thread-context.c'), numa)
 if not config_host_data.get('CONFIG_ATOMIC64')
   util_ss.add(files('atomic64.c'))
 endif
-util_ss.add(when: 'CONFIG_POSIX', if_true: files('aio-posix.c'))
-util_ss.add(when: 'CONFIG_POSIX', if_true: files('fdmon-poll.c'))
-if config_host_data.get('CONFIG_EPOLL_CREATE1')
-  util_ss.add(files('fdmon-epoll.c'))
+if targetos != 'windows'
+  util_ss.add(files('aio-posix.c'))
+  util_ss.add(files('fdmon-poll.c'))
+  if config_host_data.get('CONFIG_EPOLL_CREATE1')
+    util_ss.add(files('fdmon-epoll.c'))
+  endif
+  util_ss.add(files('compatfd.c'))
+  util_ss.add(files('event_notifier-posix.c'))
+  util_ss.add(files('mmap-alloc.c'))
+  freebsd_dep = []
+  if targetos == 'freebsd'
+    freebsd_dep = util
+  endif
+  util_ss.add(files('oslib-posix.c'), freebsd_dep)
+  util_ss.add(files('qemu-thread-posix.c'))
+  util_ss.add(files('memfd.c'))
+  util_ss.add(files('drm.c'))
+else
+  util_ss.add(files('aio-win32.c'))
+  util_ss.add(files('event_notifier-win32.c'))
+  util_ss.add(files('oslib-win32.c'))
+  util_ss.add(files('qemu-thread-win32.c'))
+  util_ss.add(winmm, pathcch)
 endif
 util_ss.add(when: linux_io_uring, if_true: files('fdmon-io_uring.c'))
-util_ss.add(when: 'CONFIG_POSIX', if_true: files('compatfd.c'))
-util_ss.add(when: 'CONFIG_POSIX', if_true: files('event_notifier-posix.c'))
-util_ss.add(when: 'CONFIG_POSIX', if_true: files('mmap-alloc.c'))
-freebsd_dep = []
-if targetos == 'freebsd'
-  freebsd_dep = util
-endif
-util_ss.add(when: 'CONFIG_POSIX', if_true: [files('oslib-posix.c'), freebsd_dep])
-util_ss.add(when: 'CONFIG_POSIX', if_true: files('qemu-thread-posix.c'))
-util_ss.add(when: 'CONFIG_POSIX', if_true: files('memfd.c'))
-util_ss.add(when: 'CONFIG_WIN32', if_true: files('aio-win32.c'))
-util_ss.add(when: 'CONFIG_WIN32', if_true: files('event_notifier-win32.c'))
-util_ss.add(when: 'CONFIG_WIN32', if_true: files('oslib-win32.c'))
-util_ss.add(when: 'CONFIG_WIN32', if_true: files('qemu-thread-win32.c'))
-util_ss.add(when: 'CONFIG_WIN32', if_true: winmm)
-util_ss.add(when: 'CONFIG_WIN32', if_true: pathcch)
 if glib_has_gslice
   util_ss.add(files('qtree.c'))
 endif
@@ -56,7 +59,6 @@ util_ss.add(files('reserved-region.c'))
 util_ss.add(files('stats64.c'))
 util_ss.add(files('systemd.c'))
 util_ss.add(files('transactions.c'))
-util_ss.add(when: 'CONFIG_POSIX', if_true: files('drm.c'))
 util_ss.add(files('guest-random.c'))
 util_ss.add(files('yank.c'))
 util_ss.add(files('int128.c'))
-- 
2.43.0


