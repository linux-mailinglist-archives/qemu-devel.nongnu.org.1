Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 889D87CFB60
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:40:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtTEx-0000nK-RX; Thu, 19 Oct 2023 09:39:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1qtNyg-0003AX-GM
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 04:02:01 -0400
Received: from mgamail.intel.com ([192.55.52.93])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1qtNyd-0006LX-4s
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 04:01:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697702515; x=1729238515;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=t9BdIS+sJlH+qsQMBb7HkqEKoFxNHzvd5KGj9Dty4l8=;
 b=HcTlZ4rQD9ODJ2F21eZOpOTXwzeOSjTFgKu5CzpYI557+cWER5389fEA
 75OV8zA/aXd+bAZ0ncaW/sv9jKxNB5ra8jfWhFkCAT6Gm0xmCZjdTOGS3
 OAVPCCoXKby17miLoOkqG37VeOLHEcDI3du5L9rAAvidLxCS51RuQfD8E
 yFzpSr74WqkzJce2x5U6VwY/jxhCOCZfbKA0zSJZrKN7M2iAugIHkV5PY
 zQx0iv5UaGDZH7X2FgOCMErT6VxDE/bYSBM1T7ehWSF9719/JnrNT0szy
 bb04hkagR9IYQkUqDcRionqe9Z8LbmyzuqSZ28ITp8TapaqirOOsnPKLi A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="383418456"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; d="scan'208";a="383418456"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2023 01:01:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="1004134839"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; d="scan'208";a="1004134839"
Received: from sae-gw02.sh.intel.com (HELO localhost) ([10.239.45.110])
 by fmsmga006.fm.intel.com with ESMTP; 19 Oct 2023 01:01:50 -0700
From: Yuan Liu <yuan1.liu@intel.com>
To: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
Cc: qemu-devel@nongnu.org,
	yuan1.liu@intel.com,
	nanhai.zou@intel.com
Subject: [PATCH 1/5] configure: add qpl meson option
Date: Thu, 19 Oct 2023 06:12:20 +0800
Message-Id: <20231018221224.599065-2-yuan1.liu@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231018221224.599065-1-yuan1.liu@intel.com>
References: <20231018221224.599065-1-yuan1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.93; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 19 Oct 2023 09:38:19 -0400
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

Intel Query Processing Library (QPL) is an open-source library that
supports features of the new Intel In-Memory Analytics Accelerator (IAA)
available on Intel Xeon Sapphire Rapids processors, including
high-throughput compression and decompression.

add --enable-qpl and --disable-qpl options for data (de)compression
using IAA during the live migration process.

Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>
---
 meson.build                   | 9 ++++++++-
 meson_options.txt             | 2 ++
 scripts/meson-buildoptions.sh | 3 +++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 79aef19bdc..0a69bf68cf 100644
--- a/meson.build
+++ b/meson.build
@@ -1032,6 +1032,11 @@ if not get_option('zstd').auto() or have_block
                     required: get_option('zstd'),
                     method: 'pkg-config')
 endif
+qpl = not_found
+if not get_option('qpl').auto()
+    qpl = dependency('libqpl', required: get_option('qpl'),
+                     method: 'pkg-config')
+endif
 virgl = not_found
 
 have_vhost_user_gpu = have_tools and targetos == 'linux' and pixman.found()
@@ -2158,6 +2163,7 @@ config_host_data.set('CONFIG_MALLOC_TRIM', has_malloc_trim)
 config_host_data.set('CONFIG_STATX', has_statx)
 config_host_data.set('CONFIG_STATX_MNT_ID', has_statx_mnt_id)
 config_host_data.set('CONFIG_ZSTD', zstd.found())
+config_host_data.set('CONFIG_QPL', qpl.found())
 config_host_data.set('CONFIG_FUSE', fuse.found())
 config_host_data.set('CONFIG_FUSE_LSEEK', fuse_lseek.found())
 config_host_data.set('CONFIG_SPICE_PROTOCOL', spice_protocol.found())
@@ -3616,7 +3622,7 @@ libmigration = static_library('migration', sources: migration_files + genh,
                               name_suffix: 'fa',
                               build_by_default: false)
 migration = declare_dependency(link_with: libmigration,
-                               dependencies: [zlib, qom, io])
+                               dependencies: [zlib, qom, io, qpl])
 system_ss.add(migration)
 
 block_ss = block_ss.apply(config_targetos, strict: false)
@@ -4281,6 +4287,7 @@ summary_info += {'blkio support':     blkio}
 summary_info += {'curl support':      curl}
 summary_info += {'Multipath support': mpathpersist}
 summary_info += {'Linux AIO support': libaio}
+summary_info += {'Query Processing Library support': qpl}
 summary_info += {'Linux io_uring support': linux_io_uring}
 summary_info += {'ATTR/XATTR support': libattr}
 summary_info += {'RDMA support':      rdma}
diff --git a/meson_options.txt b/meson_options.txt
index 6a17b90968..e8e7e37893 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -251,6 +251,8 @@ option('xkbcommon', type : 'feature', value : 'auto',
        description: 'xkbcommon support')
 option('zstd', type : 'feature', value : 'auto',
        description: 'zstd compression support')
+option('qpl', type : 'feature', value : 'auto',
+       description: 'Query Processing Library support')
 option('fuse', type: 'feature', value: 'auto',
        description: 'FUSE block device export')
 option('fuse_lseek', type : 'feature', value : 'auto',
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 2a74b0275b..e2adb13ce5 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -206,6 +206,7 @@ meson_options_help() {
   printf "%s\n" '                  Xen PCI passthrough support'
   printf "%s\n" '  xkbcommon       xkbcommon support'
   printf "%s\n" '  zstd            zstd compression support'
+  printf "%s\n" '  qpl             Query Processing Library support'
 }
 _meson_option_parse() {
   case $1 in
@@ -417,6 +418,8 @@ _meson_option_parse() {
     --disable-qga-vss) printf "%s" -Dqga_vss=disabled ;;
     --enable-qom-cast-debug) printf "%s" -Dqom_cast_debug=true ;;
     --disable-qom-cast-debug) printf "%s" -Dqom_cast_debug=false ;;
+    --enable-qpl) printf "%s" -Dqpl=enabled ;;
+    --disable-qpl) printf "%s" -Dqpl=disabled ;;
     --enable-rbd) printf "%s" -Drbd=enabled ;;
     --disable-rbd) printf "%s" -Drbd=disabled ;;
     --enable-rdma) printf "%s" -Drdma=enabled ;;
-- 
2.39.3


