Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E21149C2BBD
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Nov 2024 11:26:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9ic8-0006SO-6u; Sat, 09 Nov 2024 05:22:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9iWy-0007Kg-3c; Sat, 09 Nov 2024 05:17:25 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9iWw-00087Y-DP; Sat, 09 Nov 2024 05:17:23 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 091E6A1404;
 Sat,  9 Nov 2024 13:13:51 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9DFB8167EEF;
 Sat,  9 Nov 2024 13:14:45 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.8 31/49] net: fix build when libbpf is disabled,
 but libxdp is enabled
Date: Sat,  9 Nov 2024 13:14:22 +0300
Message-Id: <20241109101443.312701-31-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-8.2.8-20241109131339@cover.tls.msk.ru>
References: <qemu-stable-8.2.8-20241109131339@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Daniel P. Berrangé <berrange@redhat.com>

The net/af-xdp.c code is enabled when the libxdp library is present,
however, it also has direct API calls to bpf_xdp_query_id &
bpf_xdp_detach which are provided by the libbpf library.

As a result if building with --disable-libbpf, but libxdp gets
auto-detected, we'll fail to link QEMU

  /usr/bin/ld: libcommon.a.p/net_af-xdp.c.o: undefined reference to symbol 'bpf_xdp_query_id@@LIBBPF_0.7.0'

There are two bugs here

 * Since we have direct libbpf API calls, when building
   net/af-xdp.c, we must tell meson that libbpf is a
   dependancy, so that we directly link to it, rather
   than relying on indirect linkage.

 * When must skip probing for libxdp at all, when libbpf
   is not found, raising an error if --enable-libxdp was
   given explicitly.

Fixes: cb039ef3d9e3112da01e1ecd9b136ac9809ef733
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
(cherry picked from commit 1f37280b37dbf85f36748f359a9f8802c8fe7ccd)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/meson.build b/meson.build
index 79de6f7fc8..048e07a648 100644
--- a/meson.build
+++ b/meson.build
@@ -1909,8 +1909,14 @@ endif
 # libxdp
 libxdp = not_found
 if not get_option('af_xdp').auto() or have_system
-    libxdp = dependency('libxdp', required: get_option('af_xdp'),
-                        version: '>=1.4.0', method: 'pkg-config')
+    if libbpf.found()
+        libxdp = dependency('libxdp', required: get_option('af_xdp'),
+                            version: '>=1.4.0', method: 'pkg-config')
+    else
+        if get_option('af_xdp').enabled()
+            error('libxdp requested, but libbpf is not available')
+        endif
+    endif
 endif
 
 # libdw
diff --git a/net/meson.build b/net/meson.build
index ce99bd4447..7264479242 100644
--- a/net/meson.build
+++ b/net/meson.build
@@ -37,7 +37,7 @@ if have_netmap
   system_ss.add(files('netmap.c'))
 endif
 
-system_ss.add(when: libxdp, if_true: files('af-xdp.c'))
+system_ss.add(when: [libxdp, libbpf], if_true: files('af-xdp.c'))
 
 if have_vhost_net_user
   system_ss.add(when: 'CONFIG_VIRTIO_NET', if_true: files('vhost-user.c'), if_false: files('vhost-user-stub.c'))
-- 
2.39.5


