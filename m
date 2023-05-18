Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC9D708362
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 15:59:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pze8A-0004aq-OR; Thu, 18 May 2023 09:57:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1pze89-0004aP-GT
 for qemu-devel@nongnu.org; Thu, 18 May 2023 09:57:21 -0400
Received: from mga12.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1pze87-0002T5-RT
 for qemu-devel@nongnu.org; Thu, 18 May 2023 09:57:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1684418239; x=1715954239;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hNy0EL7LNfaBhcec/LSO+OfhCuDllSqA/YNjUll1Ck0=;
 b=dYex0jg50C9agdISKQUwZQpj+zP4bK6DpFp9gf/v/6/rYCnL6hQc/rTK
 a0/QzzJI1Cfwz5tva1SGuHj5nJxlE9l3fJdhAEiEaRirrOqRkoEhqyzLu
 fhlg7fvCiWlmBhb3eATidO/5r+TDBOJ1G9QPekuQdpGAn9PE8wZT36QQp
 IhwadOeSMdG+BaVOWdOOOlb7kp0bEeWDwPGBR+GBhw/D2Jyt9MsCfLyYZ
 MntYHy/ISn/SiVXARiSgAudfEJ13IMNtkq6sdUxFoo4+AlyBr3fkLzvrK
 BUazevpcoGkvKcR1w2Z9tMHVlRWHfDi9OGMujWLg/k2de1T1OpWwNtGmt Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="331685914"
X-IronPort-AV: E=Sophos;i="5.99,285,1677571200"; d="scan'208";a="331685914"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2023 06:57:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="876428871"
X-IronPort-AV: E=Sophos;i="5.99,285,1677571200"; d="scan'208";a="876428871"
Received: from wufei-optiplex-7090.sh.intel.com ([10.238.200.247])
 by orsmga005.jf.intel.com with ESMTP; 18 May 2023 06:57:16 -0700
From: Fei Wu <fei2.wu@intel.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 alex.bennee@linaro.org, fei2.wu@intel.com
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v12 14/15] configure: remove the final bits of --profiler
 support
Date: Thu, 18 May 2023 21:57:56 +0800
Message-Id: <20230518135757.1442654-15-fei2.wu@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230518135757.1442654-1-fei2.wu@intel.com>
References: <20230518135757.1442654-1-fei2.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.136; envelope-from=fei2.wu@intel.com;
 helo=mga12.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

From: Alex Bennée <alex.bennee@linaro.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Fei Wu <fei2.wu@intel.com>
---
 meson.build                   | 2 --
 meson_options.txt             | 2 --
 scripts/meson-buildoptions.sh | 3 ---
 3 files changed, 7 deletions(-)

diff --git a/meson.build b/meson.build
index 4dddccb890..4be21c9d57 100644
--- a/meson.build
+++ b/meson.build
@@ -1888,7 +1888,6 @@ if numa.found()
                                        dependencies: numa))
 endif
 config_host_data.set('CONFIG_OPENGL', opengl.found())
-config_host_data.set('CONFIG_PROFILER', get_option('profiler'))
 config_host_data.set('CONFIG_RBD', rbd.found())
 config_host_data.set('CONFIG_RDMA', rdma.found())
 config_host_data.set('CONFIG_SDL', sdl.found())
@@ -3859,7 +3858,6 @@ if 'objc' in all_languages
   summary_info += {'QEMU_OBJCFLAGS':    ' '.join(qemu_objcflags)}
 endif
 summary_info += {'QEMU_LDFLAGS':      ' '.join(qemu_ldflags)}
-summary_info += {'profiler':          get_option('profiler')}
 summary_info += {'link-time optimization (LTO)': get_option('b_lto')}
 summary_info += {'PIE':               get_option('b_pie')}
 summary_info += {'static build':      config_host.has_key('CONFIG_STATIC')}
diff --git a/meson_options.txt b/meson_options.txt
index 11aec2a441..9692fa7cdc 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -332,8 +332,6 @@ option('qom_cast_debug', type: 'boolean', value: true,
 option('gprof', type: 'boolean', value: false,
        description: 'QEMU profiling with gprof',
        deprecated: true)
-option('profiler', type: 'boolean', value: false,
-       description: 'profiler support')
 option('slirp_smbd', type : 'feature', value : 'auto',
        description: 'use smbd (at path --smbd=*) in slirp networking')
 
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 52fb079a60..28c7d21a15 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -38,7 +38,6 @@ meson_options_help() {
   printf "%s\n" '                           jemalloc/system/tcmalloc)'
   printf "%s\n" '  --enable-module-upgrades try to load modules from alternate paths for'
   printf "%s\n" '                           upgrades'
-  printf "%s\n" '  --enable-profiler        profiler support'
   printf "%s\n" '  --enable-rng-none        dummy RNG, avoid using /dev/(u)random and'
   printf "%s\n" '                           getrandom()'
   printf "%s\n" '  --enable-strip           Strip targets on install'
@@ -386,8 +385,6 @@ _meson_option_parse() {
     --with-pkgversion=*) quote_sh "-Dpkgversion=$2" ;;
     --enable-png) printf "%s" -Dpng=enabled ;;
     --disable-png) printf "%s" -Dpng=disabled ;;
-    --enable-profiler) printf "%s" -Dprofiler=true ;;
-    --disable-profiler) printf "%s" -Dprofiler=false ;;
     --enable-pvrdma) printf "%s" -Dpvrdma=enabled ;;
     --disable-pvrdma) printf "%s" -Dpvrdma=disabled ;;
     --enable-qcow1) printf "%s" -Dqcow1=enabled ;;
-- 
2.25.1


