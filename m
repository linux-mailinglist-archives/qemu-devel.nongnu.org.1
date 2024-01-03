Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C2136823B0C
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 04:17:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLEDT-0005WI-LO; Wed, 03 Jan 2024 22:16:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rLEDB-0005V2-A3
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 22:16:02 -0500
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rLED8-000397-Ih
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 22:16:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1704338159; x=1735874159;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=AQpouSi14xYJdnTly7KkaayQzY3h55nSTOJfkbeUxu8=;
 b=Z8TLczdoq0JC6KQ9+DkWkuX07TLQsVyucS6jAcKAX/wzfGxSxbybmeTI
 VVHv7PI/45ZmsibGCOQWjCmj2wD+vtikiAAZnbfghMPbA0qWK5yJS7Grx
 m/7q6/F/LmcSvL5kgX7cBpFKWoxIA222OmwtThkoGbdZeEUthCXeJObGL
 QVn31YQUh180m2Wzggl5ab70gNk9FW98oOkVgVGQe8dR1jSEuLNp58mKl
 K6d0xZzUSYHnSrIJHyoLf3mR/mkif+d25VbHFMxIaJhII9409wjSQJYL/
 l3uZ5nRpZD2Pg3FJjHXx0cxQ7mTqrU1H5sxOjaCMy6HTUWX+Pa9VcMsu0 A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="3873418"
X-IronPort-AV: E=Sophos;i="6.04,329,1695711600"; 
   d="scan'208";a="3873418"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jan 2024 19:15:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="846079432"
X-IronPort-AV: E=Sophos;i="6.04,329,1695711600"; d="scan'208";a="846079432"
Received: from sae-gw02.sh.intel.com (HELO localhost) ([10.239.45.110])
 by fmsmga008.fm.intel.com with ESMTP; 03 Jan 2024 19:15:52 -0800
From: Yuan Liu <yuan1.liu@intel.com>
To: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
Cc: qemu-devel@nongnu.org,
	yuan1.liu@intel.com,
	nanhai.zou@intel.com
Subject: [PATCH v3 3/4] configure: add qpl option
Date: Wed,  3 Jan 2024 19:28:50 +0800
Message-Id: <20240103112851.908082-4-yuan1.liu@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240103112851.908082-1-yuan1.liu@intel.com>
References: <20240103112851.908082-1-yuan1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.11; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-2.601, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

the Query Processing Library (QPL) is an open-source library that
supports data compression and decompression features.

add --enable-qpl and --disable-qpl options to enable and disable
the QPL compression accelerator. The QPL compression accelerator
can accelerate the Zlib compression algorithm during the live migration.

Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>
---
 meson.build                   | 18 ++++++++++++++++++
 meson_options.txt             |  2 ++
 scripts/meson-buildoptions.sh |  3 +++
 3 files changed, 23 insertions(+)

diff --git a/meson.build b/meson.build
index 259dc5f308..f2bb81f9cb 100644
--- a/meson.build
+++ b/meson.build
@@ -1032,6 +1032,22 @@ if not get_option('zstd').auto() or have_block
                     required: get_option('zstd'),
                     method: 'pkg-config')
 endif
+qpl = not_found
+if not get_option('qpl').auto()
+  libqpl = cc.find_library('qpl', required: false)
+  if not libqpl.found()
+    error('libqpl not found, please install it from ' +
+    'https://intel.github.io/qpl/documentation/get_started_docs/installation.html')
+  endif
+  libaccel = cc.find_library('accel-config', required: false)
+  if not libaccel.found()
+    error('libaccel-config not found, please install it from ' +
+    'https://github.com/intel/idxd-config')
+  endif
+  qpl = declare_dependency(dependencies: [libqpl, libaccel,
+        cc.find_library('dl', required: get_option('qpl'))],
+        link_args: ['-lstdc++'])
+endif
 virgl = not_found
 
 have_vhost_user_gpu = have_tools and targetos == 'linux' and pixman.found()
@@ -2165,6 +2181,7 @@ config_host_data.set('CONFIG_MALLOC_TRIM', has_malloc_trim)
 config_host_data.set('CONFIG_STATX', has_statx)
 config_host_data.set('CONFIG_STATX_MNT_ID', has_statx_mnt_id)
 config_host_data.set('CONFIG_ZSTD', zstd.found())
+config_host_data.set('CONFIG_QPL', qpl.found())
 config_host_data.set('CONFIG_FUSE', fuse.found())
 config_host_data.set('CONFIG_FUSE_LSEEK', fuse_lseek.found())
 config_host_data.set('CONFIG_SPICE_PROTOCOL', spice_protocol.found())
@@ -4325,6 +4342,7 @@ summary_info += {'snappy support':    snappy}
 summary_info += {'bzip2 support':     libbzip2}
 summary_info += {'lzfse support':     liblzfse}
 summary_info += {'zstd support':      zstd}
+summary_info += {'Query Processing Library support': qpl}
 summary_info += {'NUMA host support': numa}
 summary_info += {'capstone':          capstone}
 summary_info += {'libpmem support':   libpmem}
diff --git a/meson_options.txt b/meson_options.txt
index 3c7398f3c6..71cd533985 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -255,6 +255,8 @@ option('xkbcommon', type : 'feature', value : 'auto',
        description: 'xkbcommon support')
 option('zstd', type : 'feature', value : 'auto',
        description: 'zstd compression support')
+option('qpl', type : 'feature', value : 'auto',
+       description: 'Query Processing Library support')
 option('fuse', type: 'feature', value: 'auto',
        description: 'FUSE block device export')
 option('fuse_lseek', type : 'feature', value : 'auto',
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 7ca4b77eae..0909d1d517 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -220,6 +220,7 @@ meson_options_help() {
   printf "%s\n" '                  Xen PCI passthrough support'
   printf "%s\n" '  xkbcommon       xkbcommon support'
   printf "%s\n" '  zstd            zstd compression support'
+  printf "%s\n" '  qpl             Query Processing Library support'
 }
 _meson_option_parse() {
   case $1 in
@@ -556,6 +557,8 @@ _meson_option_parse() {
     --disable-xkbcommon) printf "%s" -Dxkbcommon=disabled ;;
     --enable-zstd) printf "%s" -Dzstd=enabled ;;
     --disable-zstd) printf "%s" -Dzstd=disabled ;;
+    --enable-qpl) printf "%s" -Dqpl=enabled ;;
+    --disable-qpl) printf "%s" -Dqpl=disabled ;;
     *) return 1 ;;
   esac
 }
-- 
2.39.3


