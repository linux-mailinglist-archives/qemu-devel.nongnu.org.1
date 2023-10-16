Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 121D17CA24C
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 10:48:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsJH9-0000T4-8v; Mon, 16 Oct 2023 04:48:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qsJH7-0000Dd-6e
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 04:48:33 -0400
Received: from mgamail.intel.com ([192.55.52.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qsJH4-0001FN-7e
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 04:48:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697446110; x=1728982110;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wtDPIDhWCjBFycD/ZAY0meL+/Wa9UYfvM5F/A6wiee0=;
 b=c70cyj+C30LNksjO8f5n/4MXTMNzK3EyTYTeXz5Op/oLRq5uM2Il9tbh
 th8Q9vvYC010/xxfJhyNXoE8KagAsN4wddqlckfd1QyqoNv5LGKQ4aCSz
 byQgqiS92zoJ9XnPGx1nEsuEIBO8xO+eqdeu9oPxk1Q8tOlUiVJXiQQdz
 jU9qc3tmnmZGkHHt+kzkMccCjz71LqUtR5qpIRCusRY7OKc0bAuaHhE9/
 OHzpzLZiFEjZofOBTvtK4FPeS5JtBD3U4klUSR8AMhD5wjF1+T66NWJ3Y
 odCmy6lsdPCCvVBQ4KbyE/cK3IWKf+Ak/LBqCJ6P6dWbHy6CQVdddEZ1q A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="365737664"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; d="scan'208";a="365737664"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2023 01:48:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="749222970"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; d="scan'208";a="749222970"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2023 01:48:23 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 16/27] Add iommufd configure option
Date: Mon, 16 Oct 2023 16:32:12 +0800
Message-Id: <20231016083223.1519410-17-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016083223.1519410-1-zhenzhong.duan@intel.com>
References: <20231016083223.1519410-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.151;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This adds "--enable-iommufd/--disable-iommufd" to enable or disable
iommufd support, enabled by default.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 meson.build                   | 6 ++++++
 meson_options.txt             | 2 ++
 scripts/meson-buildoptions.sh | 3 +++
 3 files changed, 11 insertions(+)

diff --git a/meson.build b/meson.build
index 79aef19bdc..e8d285aa5b 100644
--- a/meson.build
+++ b/meson.build
@@ -560,6 +560,10 @@ have_tpm = get_option('tpm') \
   .require(targetos != 'windows', error_message: 'TPM emulation only available on POSIX systems') \
   .allowed()
 
+have_iommufd = get_option('iommufd') \
+  .require(targetos == 'linux', error_message: 'iommufd is supported only on Linux') \
+  .allowed()
+
 # vhost
 have_vhost_user = get_option('vhost_user') \
   .disable_auto_if(targetos != 'linux') \
@@ -2126,6 +2130,7 @@ if get_option('tcg').allowed()
 endif
 config_host_data.set('CONFIG_TPM', have_tpm)
 config_host_data.set('CONFIG_TSAN', get_option('tsan'))
+config_host_data.set('CONFIG_IOMMUFD', have_iommufd)
 config_host_data.set('CONFIG_USB_LIBUSB', libusb.found())
 config_host_data.set('CONFIG_VDE', vde.found())
 config_host_data.set('CONFIG_VHOST_NET', have_vhost_net)
@@ -4061,6 +4066,7 @@ summary_info += {'vhost-user-crypto support': have_vhost_user_crypto}
 summary_info += {'vhost-user-blk server support': have_vhost_user_blk_server}
 summary_info += {'vhost-vdpa support': have_vhost_vdpa}
 summary_info += {'build guest agent': have_ga}
+summary_info += {'iommufd support': have_iommufd}
 summary(summary_info, bool_yn: true, section: 'Configurable features')
 
 # Compilation information
diff --git a/meson_options.txt b/meson_options.txt
index 6a17b90968..62bd75284b 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -107,6 +107,8 @@ option('dbus_display', type: 'feature', value: 'auto',
        description: '-display dbus support')
 option('tpm', type : 'feature', value : 'auto',
        description: 'TPM support')
+option('iommufd', type : 'feature', value : 'auto',
+       description: 'iommufd support')
 
 # Do not enable it by default even for Mingw32, because it doesn't
 # work on Wine.
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 2a74b0275b..86909dc2cc 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -114,6 +114,7 @@ meson_options_help() {
   printf "%s\n" '  guest-agent-msi Build MSI package for the QEMU Guest Agent'
   printf "%s\n" '  hvf             HVF acceleration support'
   printf "%s\n" '  iconv           Font glyph conversion support'
+  printf "%s\n" '  iommufd         iommufd support'
   printf "%s\n" '  jack            JACK sound support'
   printf "%s\n" '  keyring         Linux keyring support'
   printf "%s\n" '  kvm             KVM acceleration support'
@@ -327,6 +328,8 @@ _meson_option_parse() {
     --enable-install-blobs) printf "%s" -Dinstall_blobs=true ;;
     --disable-install-blobs) printf "%s" -Dinstall_blobs=false ;;
     --interp-prefix=*) quote_sh "-Dinterp_prefix=$2" ;;
+    --enable-iommufd) printf "%s" -Diommufd=enabled ;;
+    --disable-iommufd) printf "%s" -Diommufd=disabled ;;
     --enable-jack) printf "%s" -Djack=enabled ;;
     --disable-jack) printf "%s" -Djack=disabled ;;
     --enable-keyring) printf "%s" -Dkeyring=enabled ;;
-- 
2.34.1


