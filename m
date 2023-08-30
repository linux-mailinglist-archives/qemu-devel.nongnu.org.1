Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A84A078D54B
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 12:56:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbIpa-0004uI-Px; Wed, 30 Aug 2023 06:53:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qbIpY-0004ej-0W
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 06:53:48 -0400
Received: from mgamail.intel.com ([192.55.52.93])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qbIpV-0007jr-EE
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 06:53:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1693392825; x=1724928825;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HgO/BHF4jIS0HTKN9QhvMskHyXxCXX9sam8G+fC8ujw=;
 b=cYS4s2rG6Jtc5th7rJKrQDFs3tktjHZ5JQNUo2aE+2/CwbrIoN4Wxzvm
 WdJG1+OOGsbIYPfooTfx+V6AhenbQILADM+gMoiqfyp4FYi39Xx2ef7wj
 cfHgfura68VD1A9dkas5zufoXSqRaNrAuEKUS9djXT/77PN/NkfVyy2UO
 cGzpAHzbMjle/kGHscyZYh0YdH1BcIF1dwoRStut4bXABsr1nse1OSLbO
 iXYsrm+ok5rHmtSxxUmzdcnTSanGXNt/JY0ff9lXyJFL9Hupt6mlAIsAW
 C2LrLo4s+z8rK8aw0SAqN9vLQOs2KMGumJ3wJjuU8mzo2kwAx6KtnfttB Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="373016659"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; d="scan'208";a="373016659"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2023 03:53:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="715866229"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; d="scan'208";a="715866229"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2023 03:53:33 -0700
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
Subject: [PATCH v1 15/22] Add iommufd configure option
Date: Wed, 30 Aug 2023 18:37:47 +0800
Message-Id: <20230830103754.36461-16-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230830103754.36461-1-zhenzhong.duan@intel.com>
References: <20230830103754.36461-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.93;
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
index 98e68ef0b1..6526d8cc9b 100644
--- a/meson.build
+++ b/meson.build
@@ -574,6 +574,10 @@ have_tpm = get_option('tpm') \
   .require(targetos != 'windows', error_message: 'TPM emulation only available on POSIX systems') \
   .allowed()
 
+have_iommufd = get_option('iommufd') \
+  .require(targetos == 'linux', error_message: 'iommufd is supported only on Linux') \
+  .allowed()
+
 # vhost
 have_vhost_user = get_option('vhost_user') \
   .disable_auto_if(targetos != 'linux') \
@@ -2129,6 +2133,7 @@ endif
 config_host_data.set('CONFIG_SNAPPY', snappy.found())
 config_host_data.set('CONFIG_TPM', have_tpm)
 config_host_data.set('CONFIG_TSAN', get_option('tsan'))
+config_host_data.set('CONFIG_IOMMUFD', have_iommufd)
 config_host_data.set('CONFIG_USB_LIBUSB', libusb.found())
 config_host_data.set('CONFIG_VDE', vde.found())
 config_host_data.set('CONFIG_VHOST_NET', have_vhost_net)
@@ -4051,6 +4056,7 @@ summary_info += {'vhost-user-crypto support': have_vhost_user_crypto}
 summary_info += {'vhost-user-blk server support': have_vhost_user_blk_server}
 summary_info += {'vhost-vdpa support': have_vhost_vdpa}
 summary_info += {'build guest agent': have_ga}
+summary_info += {'iommufd support': have_iommufd}
 summary(summary_info, bool_yn: true, section: 'Configurable features')
 
 # Compilation information
diff --git a/meson_options.txt b/meson_options.txt
index aaea5ddd77..aed91d173b 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -105,6 +105,8 @@ option('dbus_display', type: 'feature', value: 'auto',
        description: '-display dbus support')
 option('tpm', type : 'feature', value : 'auto',
        description: 'TPM support')
+option('iommufd', type : 'feature', value : 'auto',
+       description: 'iommufd support')
 
 # Do not enable it by default even for Mingw32, because it doesn't
 # work on Wine.
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 9da3fe299b..719401ffb0 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -113,6 +113,7 @@ meson_options_help() {
   printf "%s\n" '  hax             HAX acceleration support'
   printf "%s\n" '  hvf             HVF acceleration support'
   printf "%s\n" '  iconv           Font glyph conversion support'
+  printf "%s\n" '  iommufd         iommufd support'
   printf "%s\n" '  jack            JACK sound support'
   printf "%s\n" '  keyring         Linux keyring support'
   printf "%s\n" '  kvm             KVM acceleration support'
@@ -325,6 +326,8 @@ _meson_option_parse() {
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


