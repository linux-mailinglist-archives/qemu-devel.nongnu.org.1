Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 944FF7D813D
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 12:53:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvxvE-00040w-4J; Thu, 26 Oct 2023 06:49:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qvxuS-0002Gu-RU
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 06:48:26 -0400
Received: from mgamail.intel.com ([134.134.136.126])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qvxuP-0001Nv-Vi
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 06:48:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698317293; x=1729853293;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=yr99guRhnxIYZzeV6x6Oum0jvei4Z/eHaYV4XkfxTGQ=;
 b=oGTOMNBaQVkgm5sg/Y0V56C9sMGA5QBFnTe/890gwLaT4+OYNDiHxAYj
 xqX24674SIMc3VoJQYSkefSRD6onWMob2U8PzcofnDuo5A7OJ42rYcOB2
 MfmcS/mhl3jxnw8Hz863BrLxR1bexVN8YJ64nrBrU0ssJ/U2xTo/sPl49
 GQWPgtTehHRdPyMt6Gr0F9fFmFafmpe5Yu9YBbFmWqAUIujjZaH63taxb
 T/HxUIQMVcNnga3Lw4gO13H7Jhb+qlvRAcXRmOkmMn6d/dk25NUHZX2lP
 QeXlS+9jiEwDF5wICPVu2BmtWVnlonSnUs0lil1FrHxLNOMQYmWTGM8J2 w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="372563664"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; d="scan'208";a="372563664"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2023 03:47:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="463765"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2023 03:47:29 -0700
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
Subject: [PATCH v3 23/37] Add iommufd configure option
Date: Thu, 26 Oct 2023 18:30:50 +0800
Message-Id: <20231026103104.1686921-24-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026103104.1686921-1-zhenzhong.duan@intel.com>
References: <20231026103104.1686921-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.126;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

This adds "--enable-iommufd/--disable-iommufd" to enable or disable
iommufd support, enabled by default.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 meson.build                   | 6 ++++++
 meson_options.txt             | 2 ++
 scripts/meson-buildoptions.sh | 3 +++
 3 files changed, 11 insertions(+)

diff --git a/meson.build b/meson.build
index 4961c82a6b..a8b0edf7b1 100644
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
@@ -2133,6 +2137,7 @@ if get_option('tcg').allowed()
 endif
 config_host_data.set('CONFIG_TPM', have_tpm)
 config_host_data.set('CONFIG_TSAN', get_option('tsan'))
+config_host_data.set('CONFIG_IOMMUFD', have_iommufd)
 config_host_data.set('CONFIG_USB_LIBUSB', libusb.found())
 config_host_data.set('CONFIG_VDE', vde.found())
 config_host_data.set('CONFIG_VHOST_NET', have_vhost_net)
@@ -4074,6 +4079,7 @@ summary_info += {'vhost-user-crypto support': have_vhost_user_crypto}
 summary_info += {'vhost-user-blk server support': have_vhost_user_blk_server}
 summary_info += {'vhost-vdpa support': have_vhost_vdpa}
 summary_info += {'build guest agent': have_ga}
+summary_info += {'iommufd support': have_iommufd}
 summary(summary_info, bool_yn: true, section: 'Configurable features')
 
 # Compilation information
diff --git a/meson_options.txt b/meson_options.txt
index 3c7398f3c6..91bb958cae 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -109,6 +109,8 @@ option('dbus_display', type: 'feature', value: 'auto',
        description: '-display dbus support')
 option('tpm', type : 'feature', value : 'auto',
        description: 'TPM support')
+option('iommufd', type : 'feature', value : 'auto',
+       description: 'iommufd support')
 
 # Do not enable it by default even for Mingw32, because it doesn't
 # work on Wine.
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 7ca4b77eae..1effc46f7d 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -125,6 +125,7 @@ meson_options_help() {
   printf "%s\n" '  guest-agent-msi Build MSI package for the QEMU Guest Agent'
   printf "%s\n" '  hvf             HVF acceleration support'
   printf "%s\n" '  iconv           Font glyph conversion support'
+  printf "%s\n" '  iommufd         iommufd support'
   printf "%s\n" '  jack            JACK sound support'
   printf "%s\n" '  keyring         Linux keyring support'
   printf "%s\n" '  kvm             KVM acceleration support'
@@ -342,6 +343,8 @@ _meson_option_parse() {
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


