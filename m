Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B4349820A97
	for <lists+qemu-devel@lfdr.de>; Sun, 31 Dec 2023 09:52:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJrUO-0005tb-8m; Sun, 31 Dec 2023 03:48:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrT6-0005GQ-DK
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:46:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrSy-0000rW-Kv
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:46:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704012398;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3U8zEYHQuGzz9UZjhWbHUnV1lnoPQnL3dTGBl2Dkros=;
 b=R4q3c67rwbzr5qrEqsPcIEPqKa6bvFtpLD37gZLoVMpLldgDS38M0AybfsPMLAaNsk6F4T
 lFp2RTACe9UGGWNTN3JFwadxNx74GjEUtkUlQOh6krgKBO1rYVYdRJf9sLWybmTZIo/U9/
 Ildx3Hjts4LV+jdq74r6NjD6uVPLI+8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-l4MJnsHOMQyjhxhjobWVrA-1; Sun, 31 Dec 2023 03:46:35 -0500
X-MC-Unique: l4MJnsHOMQyjhxhjobWVrA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3368698f0caso5818660f8f.1
 for <qemu-devel@nongnu.org>; Sun, 31 Dec 2023 00:46:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704012394; x=1704617194;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3U8zEYHQuGzz9UZjhWbHUnV1lnoPQnL3dTGBl2Dkros=;
 b=QC4XwK/Gop6XZarUd3+/SA+7AHh2Wjmf8FDZDaQhtffcNpGka3W6nOEsSi+0k7sL29
 dTvqAYigb8vFBgqFm2Jxs7He9lSxM9XQ1AkPNR6MVPTpNrIJLOtifB2dzyJmAzFU0T3W
 ZY5uDPE7K5QSI1JHpV2VlLalxVf93Hx8j4pzDlu/pb1ZKtd80WweO568ABNbWOtTXhHX
 9Qg8v0ELNHjOsg0CWy9YDY9XTy2sGZ+/oci37gc9WTV6AvDs49En7IJeLD03aytcZyY+
 UDSlmA+x+iIm1K2y/PueN+R5lgxltafeVgSJifnKHuS/95QSvVCS934KYmyik7KvdrAd
 Ar/Q==
X-Gm-Message-State: AOJu0YwTTonJ1dOGSqommflhTxkreb0GQjUgjUR6tZt/88UrkbabHAtz
 alrvscdhaPxtNkHzfhDkZ402q93KllKGqGwbP/v4BAIwWI494eguwjgjiGzTFDde7BIWjLbNhbW
 MzvZqQMlb9JSHADe4IL5RDJH7EuKwV/uNfiLVhTAUwDCFJgG/J9++cpBkx6cGSqJwwPQI85QSnP
 V/Z7fSvP8=
X-Received: by 2002:a05:6000:4ea:b0:336:d086:84d4 with SMTP id
 cr10-20020a05600004ea00b00336d08684d4mr2434494wrb.119.1704012394095; 
 Sun, 31 Dec 2023 00:46:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGfP8h/lXCUZ9+Tb1O4ioI9PagAC/qToLP3rgHW0dYzTbUAqGH9MCox5xqUcuP59oLpykxkNw==
X-Received: by 2002:a05:6000:4ea:b0:336:d086:84d4 with SMTP id
 cr10-20020a05600004ea00b00336d08684d4mr2434487wrb.119.1704012393717; 
 Sun, 31 Dec 2023 00:46:33 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 a6-20020adffb86000000b003372befd19bsm4298031wrr.104.2023.12.31.00.46.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Dec 2023 00:46:33 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 34/46] meson: move accelerator dependency checks together
Date: Sun, 31 Dec 2023 09:44:50 +0100
Message-ID: <20231231084502.235366-35-pbonzini@redhat.com>
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 175 +++++++++++++++++++++++++++-------------------------
 1 file changed, 91 insertions(+), 84 deletions(-)

diff --git a/meson.build b/meson.build
index 2c6f09352c9..1867e0428b1 100644
--- a/meson.build
+++ b/meson.build
@@ -602,7 +602,10 @@ if sparse.found()
                        '-Wno-non-pointer-null'])
 endif
 
-# Target-specific libraries and flags
+#####################################
+# Host-specific libraries and flags #
+#####################################
+
 libm = cc.find_library('m', required: false)
 threads = dependency('threads')
 util = cc.find_library('util', required: false)
@@ -612,8 +615,6 @@ version_res = []
 coref = []
 iokit = []
 emulator_link_args = []
-nvmm =not_found
-hvf = not_found
 midl = not_found
 widl = not_found
 pathcch = not_found
@@ -649,7 +650,10 @@ elif targetos == 'openbsd'
   endif
 endif
 
-# Target-specific configuration of accelerators
+###############################################
+# Host-specific configuration of accelerators #
+###############################################
+
 accelerators = []
 if get_option('kvm').allowed() and targetos == 'linux'
   accelerators += 'CONFIG_KVM'
@@ -662,6 +666,8 @@ if get_option('whpx').allowed() and targetos == 'windows'
     accelerators += 'CONFIG_WHPX'
   endif
 endif
+
+hvf = not_found
 if get_option('hvf').allowed()
   hvf = dependency('appleframeworks', modules: 'Hypervisor',
                    required: get_option('hvf'))
@@ -669,6 +675,8 @@ if get_option('hvf').allowed()
     accelerators += 'CONFIG_HVF'
   endif
 endif
+
+nvmm = not_found
 if targetos == 'netbsd'
   nvmm = cc.find_library('nvmm', required: get_option('nvmm'))
   if nvmm.found()
@@ -716,6 +724,85 @@ if 'CONFIG_WHPX' not in accelerators and get_option('whpx').enabled()
   error('WHPX not available on this platform')
 endif
 
+xen = not_found
+if get_option('xen').enabled() or (get_option('xen').auto() and have_system)
+  xencontrol = dependency('xencontrol', required: false,
+                          method: 'pkg-config')
+  if xencontrol.found()
+    xen_pc = declare_dependency(version: xencontrol.version(),
+      dependencies: [
+        xencontrol,
+        # disabler: true makes xen_pc.found() return false if any is not found
+        dependency('xenstore', required: false,
+                   method: 'pkg-config',
+                   disabler: true),
+        dependency('xenforeignmemory', required: false,
+                   method: 'pkg-config',
+                   disabler: true),
+        dependency('xengnttab', required: false,
+                   method: 'pkg-config',
+                   disabler: true),
+        dependency('xenevtchn', required: false,
+                   method: 'pkg-config',
+                   disabler: true),
+        dependency('xendevicemodel', required: false,
+                   method: 'pkg-config',
+                   disabler: true),
+        # optional, no "disabler: true"
+        dependency('xentoolcore', required: false,
+                   method: 'pkg-config')])
+    if xen_pc.found()
+      xen = xen_pc
+    endif
+  endif
+  if not xen.found()
+    xen_tests = [ '4.11.0', '4.10.0', '4.9.0', '4.8.0', '4.7.1' ]
+    xen_libs = {
+      '4.11.0': [ 'xenstore', 'xenctrl', 'xendevicemodel', 'xenforeignmemory', 'xengnttab', 'xenevtchn', 'xentoolcore' ],
+      '4.10.0': [ 'xenstore', 'xenctrl', 'xendevicemodel', 'xenforeignmemory', 'xengnttab', 'xenevtchn', 'xentoolcore' ],
+      '4.9.0': [ 'xenstore', 'xenctrl', 'xendevicemodel', 'xenforeignmemory', 'xengnttab', 'xenevtchn' ],
+      '4.8.0': [ 'xenstore', 'xenctrl', 'xenforeignmemory', 'xengnttab', 'xenevtchn' ],
+      '4.7.1': [ 'xenstore', 'xenctrl', 'xenforeignmemory', 'xengnttab', 'xenevtchn' ],
+    }
+    xen_deps = {}
+    foreach ver: xen_tests
+      # cache the various library tests to avoid polluting the logs
+      xen_test_deps = []
+      foreach l: xen_libs[ver]
+        if l not in xen_deps
+          xen_deps += { l: cc.find_library(l, required: false) }
+        endif
+        xen_test_deps += xen_deps[l]
+      endforeach
+
+      # Use -D to pick just one of the test programs in scripts/xen-detect.c
+      xen_version = ver.split('.')
+      xen_ctrl_version = xen_version[0] + \
+        ('0' + xen_version[1]).substring(-2) + \
+        ('0' + xen_version[2]).substring(-2)
+      if cc.links(files('scripts/xen-detect.c'),
+                  args: '-DCONFIG_XEN_CTRL_INTERFACE_VERSION=' + xen_ctrl_version,
+                  dependencies: xen_test_deps)
+        xen = declare_dependency(version: ver, dependencies: xen_test_deps)
+        break
+      endif
+    endforeach
+  endif
+  if xen.found()
+    accelerators += 'CONFIG_XEN'
+  elif get_option('xen').enabled()
+    error('could not compile and link Xen test program')
+  endif
+endif
+have_xen_pci_passthrough = get_option('xen_pci_passthrough') \
+  .require(xen.found(),
+           error_message: 'Xen PCI passthrough requested but Xen not enabled') \
+  .require(targetos == 'linux',
+           error_message: 'Xen PCI passthrough not available on this platform') \
+  .require(cpu == 'x86'  or cpu == 'x86_64',
+           error_message: 'Xen PCI passthrough not available on this platform') \
+  .allowed()
+
 ################
 # Dependencies #
 ################
@@ -1689,86 +1776,6 @@ if not get_option('rdma').auto() or have_system
   endforeach
 endif
 
-xen = not_found
-if get_option('xen').enabled() or (get_option('xen').auto() and have_system)
-  xencontrol = dependency('xencontrol', required: false,
-                          method: 'pkg-config')
-  if xencontrol.found()
-    xen_pc = declare_dependency(version: xencontrol.version(),
-      dependencies: [
-        xencontrol,
-        # disabler: true makes xen_pc.found() return false if any is not found
-        dependency('xenstore', required: false,
-                   method: 'pkg-config',
-                   disabler: true),
-        dependency('xenforeignmemory', required: false,
-                   method: 'pkg-config',
-                   disabler: true),
-        dependency('xengnttab', required: false,
-                   method: 'pkg-config',
-                   disabler: true),
-        dependency('xenevtchn', required: false,
-                   method: 'pkg-config',
-                   disabler: true),
-        dependency('xendevicemodel', required: false,
-                   method: 'pkg-config',
-                   disabler: true),
-        # optional, no "disabler: true"
-        dependency('xentoolcore', required: false,
-                   method: 'pkg-config')])
-    if xen_pc.found()
-      xen = xen_pc
-    endif
-  endif
-  if not xen.found()
-    xen_tests = [ '4.11.0', '4.10.0', '4.9.0', '4.8.0', '4.7.1' ]
-    xen_libs = {
-      '4.11.0': [ 'xenstore', 'xenctrl', 'xendevicemodel', 'xenforeignmemory', 'xengnttab', 'xenevtchn', 'xentoolcore' ],
-      '4.10.0': [ 'xenstore', 'xenctrl', 'xendevicemodel', 'xenforeignmemory', 'xengnttab', 'xenevtchn', 'xentoolcore' ],
-      '4.9.0': [ 'xenstore', 'xenctrl', 'xendevicemodel', 'xenforeignmemory', 'xengnttab', 'xenevtchn' ],
-      '4.8.0': [ 'xenstore', 'xenctrl', 'xenforeignmemory', 'xengnttab', 'xenevtchn' ],
-      '4.7.1': [ 'xenstore', 'xenctrl', 'xenforeignmemory', 'xengnttab', 'xenevtchn' ],
-    }
-    xen_deps = {}
-    foreach ver: xen_tests
-      # cache the various library tests to avoid polluting the logs
-      xen_test_deps = []
-      foreach l: xen_libs[ver]
-        if l not in xen_deps
-          xen_deps += { l: cc.find_library(l, required: false) }
-        endif
-        xen_test_deps += xen_deps[l]
-      endforeach
-
-      # Use -D to pick just one of the test programs in scripts/xen-detect.c
-      xen_version = ver.split('.')
-      xen_ctrl_version = xen_version[0] + \
-        ('0' + xen_version[1]).substring(-2) + \
-        ('0' + xen_version[2]).substring(-2)
-      if cc.links(files('scripts/xen-detect.c'),
-                  args: '-DCONFIG_XEN_CTRL_INTERFACE_VERSION=' + xen_ctrl_version,
-                  dependencies: xen_test_deps)
-        xen = declare_dependency(version: ver, dependencies: xen_test_deps)
-        break
-      endif
-    endforeach
-  endif
-  if xen.found()
-    accelerators += 'CONFIG_XEN'
-  elif get_option('xen').enabled()
-    error('could not compile and link Xen test program')
-  endif
-endif
-have_xen_pci_passthrough = get_option('xen_pci_passthrough') \
-  .require(xen.found(),
-           error_message: 'Xen PCI passthrough requested but Xen not enabled') \
-  .require(targetos == 'linux',
-           error_message: 'Xen PCI passthrough not available on this platform') \
-  .require(cpu == 'x86'  or cpu == 'x86_64',
-           error_message: 'Xen PCI passthrough not available on this platform') \
-  .allowed()
-
-
 cacard = not_found
 if not get_option('smartcard').auto() or have_system
   cacard = dependency('libcacard', required: get_option('smartcard'),
-- 
2.43.0


