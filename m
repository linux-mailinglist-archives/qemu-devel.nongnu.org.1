Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE4DE7052FE
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 18:01:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyx5r-00030X-En; Tue, 16 May 2023 12:00:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <1a67e07fe984e3bc9fe4b25a212e879b02e114cb@lizzy.crudebyte.com>)
 id 1pyx5o-00030C-7l
 for qemu-devel@nongnu.org; Tue, 16 May 2023 12:00:04 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <1a67e07fe984e3bc9fe4b25a212e879b02e114cb@lizzy.crudebyte.com>)
 id 1pyx5m-0004rR-F0
 for qemu-devel@nongnu.org; Tue, 16 May 2023 12:00:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=EgiLUeOgq0HzT+OLgbl6alLee7zcXQUjYHHtRXqSfZM=; b=Ualsl
 laMlZhtbA/KIFkUUmwKA8loYAtuuz9GkFVjcoHEgwvX0RIlB9Wc9jjCJGkkx+17LsqstESBBojs8x
 Sj/qSlQLGADV+JSj2opSSsapkwnbcPGbnqLNYng3nw33X+f7fitCkm8ryveCSKevuCWph8QpT9umN
 SqWFvmxZgtQSsb1eNuen8vY2VwE06aGYOTWFg86sLkpBKB+N4LbJ33ilbz4FbquD4wabk5ytpEwED
 4YVhtvbmKSmW/oOtgz8LM0GrRreiXICOtBdwPI2XMGNPwQE0NPP02F4O899RMGOKidE3cFP86k2in
 Ki3zK4qt4x/7/gFqX4VESI6NG5x6w==;
Message-Id: <1a67e07fe984e3bc9fe4b25a212e879b02e114cb.1684250463.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1684250463.git.qemu_oss@crudebyte.com>
References: <cover.1684250463.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Tue, 16 May 2023 17:21:04 +0200
Subject: [PULL 1/4] Don't require libcap-ng for virtfs support
To: qemu-devel@nongnu.org,
    Peter Maydell <peter.maydell@linaro.org>
Cc: Greg Kurz <groug@kaod.org>,
    Peter Foley <pefoley@google.com>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=1a67e07fe984e3bc9fe4b25a212e879b02e114cb@lizzy.crudebyte.com;
 helo=lizzy.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Peter Foley <pefoley@google.com>

It's only required for the proxy helper.

Add a new option for the proxy helper rather than enabling it
implicitly.

Change-Id: I95b73fca625529e99d16b0a64e01c65c0c1d43f2
Signed-off-by: Peter Foley <pefoley@google.com>
Message-Id: <20230503130757.863824-1-pefoley@google.com>
[C.S.: - Resolve merge conflict. ]
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 meson.build                   | 12 +++++++++---
 meson_options.txt             |  2 ++
 scripts/meson-buildoptions.sh |  4 ++++
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/meson.build b/meson.build
index 25a4b9f2c1..c6b05149e9 100644
--- a/meson.build
+++ b/meson.build
@@ -1766,12 +1766,17 @@ have_virtfs = get_option('virtfs') \
              error_message: 'virtio-9p (virtfs) requires Linux or macOS') \
     .require(targetos == 'linux' or cc.has_function('pthread_fchdir_np'),
              error_message: 'virtio-9p (virtfs) on macOS requires the presence of pthread_fchdir_np') \
-    .require(targetos == 'darwin' or (libattr.found() and libcap_ng.found()),
-             error_message: 'virtio-9p (virtfs) on Linux requires libcap-ng-devel and libattr-devel') \
+    .require(targetos == 'darwin' or libattr.found(),
+             error_message: 'virtio-9p (virtfs) on Linux requires libattr-devel') \
     .disable_auto_if(not have_tools and not have_system) \
     .allowed()
 
-have_virtfs_proxy_helper = targetos != 'darwin' and have_virtfs and have_tools
+have_virtfs_proxy_helper = get_option('virtfs_proxy_helper') \
+    .require(targetos != 'darwin', error_message: 'the virtfs proxy helper is incompatible with macOS') \
+    .require(have_virtfs, error_message: 'the virtfs proxy helper requires that virtfs is enabled') \
+    .disable_auto_if(not have_tools) \
+    .require(libcap_ng.found(), error_message: 'the virtfs proxy helper requires libcap-ng') \
+    .allowed()
 
 if get_option('block_drv_ro_whitelist') == ''
   config_host_data.set('CONFIG_BDRV_RO_WHITELIST', '')
@@ -3926,6 +3931,7 @@ if have_block
   summary_info += {'Block whitelist (ro)': get_option('block_drv_ro_whitelist')}
   summary_info += {'Use block whitelist in tools': get_option('block_drv_whitelist_in_tools')}
   summary_info += {'VirtFS support':    have_virtfs}
+  summary_info += {'VirtFS Proxy Helper support': have_virtfs_proxy_helper}
   summary_info += {'Live block migration': config_host_data.get('CONFIG_LIVE_BLOCK_MIGRATION')}
   summary_info += {'replication support': config_host_data.get('CONFIG_REPLICATION')}
   summary_info += {'bochs support':     get_option('bochs').allowed()}
diff --git a/meson_options.txt b/meson_options.txt
index d8330a1f71..11aec2a441 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -274,6 +274,8 @@ option('vhost_user_blk_server', type: 'feature', value: 'auto',
        description: 'build vhost-user-blk server')
 option('virtfs', type: 'feature', value: 'auto',
        description: 'virtio-9p support')
+option('virtfs_proxy_helper', type: 'feature', value: 'auto',
+       description: 'virtio-9p proxy helper support')
 option('libvduse', type: 'feature', value: 'auto',
        description: 'build VDUSE Library')
 option('vduse_blk_export', type: 'feature', value: 'auto',
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 2805d1c145..52fb079a60 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -181,6 +181,8 @@ meson_options_help() {
   printf "%s\n" '  vhost-vdpa      vhost-vdpa kernel backend support'
   printf "%s\n" '  virglrenderer   virgl rendering support'
   printf "%s\n" '  virtfs          virtio-9p support'
+  printf "%s\n" '  virtfs-proxy-helper'
+  printf "%s\n" '                  virtio-9p proxy helper support'
   printf "%s\n" '  vmdk            vmdk image format support'
   printf "%s\n" '  vmnet           vmnet.framework network backend support'
   printf "%s\n" '  vnc             VNC server'
@@ -474,6 +476,8 @@ _meson_option_parse() {
     --disable-virglrenderer) printf "%s" -Dvirglrenderer=disabled ;;
     --enable-virtfs) printf "%s" -Dvirtfs=enabled ;;
     --disable-virtfs) printf "%s" -Dvirtfs=disabled ;;
+    --enable-virtfs-proxy-helper) printf "%s" -Dvirtfs_proxy_helper=enabled ;;
+    --disable-virtfs-proxy-helper) printf "%s" -Dvirtfs_proxy_helper=disabled ;;
     --enable-vmdk) printf "%s" -Dvmdk=enabled ;;
     --disable-vmdk) printf "%s" -Dvmdk=disabled ;;
     --enable-vmnet) printf "%s" -Dvmnet=enabled ;;
-- 
2.30.2


