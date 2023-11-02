Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D17A7DED84
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 08:37:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qySBP-0005mT-P1; Thu, 02 Nov 2023 03:32:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qySBJ-0005EC-Ag
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 03:31:58 -0400
Received: from mgamail.intel.com ([134.134.136.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qySBH-0003PH-JZ
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 03:31:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698910315; x=1730446315;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=T+1+8hQGhVkQiItYHEuZThhC59tnU8gRzCkf2uADcnc=;
 b=AUhix5dMTbvcEV8EJjD8dRkyB2GnT7t2C0gisUrjQPYMDYC6CTP3srYK
 KsFP9+X3jUPlAezSWsCGm/JoBUvttsqEP9zsg4AgIlUgLGrqlMDLf82vW
 fIF963KBAa5z41q9VLngllCHql4bRWL9OyJUEZi1yjHa/t10M2UpA4bcJ
 014fU9F2QwC/rIKbp5KCWXuLaLAWH9qUYu5V9FWG4ffc9lUyPxyb9JHS9
 xnU3s+KcAztNbav5dzHFjpH4CSTjBW17256ofetBA/fKXBg1th7N4Wci/
 AcYUfkRi5pjcEAikUXSdyRnoeQNHZ5+ntJ8xB6oBJ+GYFULTn2LHk0tMw w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="452953576"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; d="scan'208";a="452953576"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2023 00:31:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="711055859"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; d="scan'208";a="711055859"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2023 00:31:19 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v4 41/41] vfio: Compile out iommufd for PPC target
Date: Thu,  2 Nov 2023 15:13:02 +0800
Message-Id: <20231102071302.1818071-42-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102071302.1818071-1-zhenzhong.duan@intel.com>
References: <20231102071302.1818071-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.31;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Since PPC doesn't support IOMMUFD, make iommufd related code
compiled out.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/common.c     | 2 +-
 hw/vfio/pci.c        | 2 +-
 hw/vfio/platform.c   | 2 +-
 backends/meson.build | 4 ++--
 hw/vfio/meson.build  | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 1c9203183d..000717cef3 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1504,7 +1504,7 @@ int vfio_attach_device(char *name, VFIODevice *vbasedev,
 {
     const VFIOIOMMUOps *ops;
 
-#ifdef CONFIG_IOMMUFD
+#if defined(CONFIG_IOMMUFD) && !defined(TARGET_PPC)
     if (vbasedev->iommufd) {
         ops = &vfio_iommufd_ops;
     } else
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index d8f658ea47..2287e45119 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3550,7 +3550,7 @@ static Property vfio_pci_dev_properties[] = {
                                    qdev_prop_nv_gpudirect_clique, uint8_t),
     DEFINE_PROP_OFF_AUTO_PCIBAR("x-msix-relocation", VFIOPCIDevice, msix_relo,
                                 OFF_AUTOPCIBAR_OFF),
-#ifdef CONFIG_IOMMUFD
+#if defined(CONFIG_IOMMUFD) && !defined(TARGET_PPC)
     DEFINE_PROP_LINK("iommufd", VFIOPCIDevice, vbasedev.iommufd,
                      TYPE_IOMMUFD_BACKEND, IOMMUFDBackend *),
 #endif
diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index aa0b2b9583..c8f4ae5a06 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -648,7 +648,7 @@ static Property vfio_platform_dev_properties[] = {
     DEFINE_PROP_UINT32("mmap-timeout-ms", VFIOPlatformDevice,
                        mmap_timeout, 1100),
     DEFINE_PROP_BOOL("x-irqfd", VFIOPlatformDevice, irqfd_allowed, true),
-#ifdef CONFIG_IOMMUFD
+#if defined(CONFIG_IOMMUFD) && !defined(TARGET_PPC)
     DEFINE_PROP_LINK("iommufd", VFIOPlatformDevice, vbasedev.iommufd,
                      TYPE_IOMMUFD_BACKEND, IOMMUFDBackend *),
 #endif
diff --git a/backends/meson.build b/backends/meson.build
index 05ac57ff15..9dbdfa87f7 100644
--- a/backends/meson.build
+++ b/backends/meson.build
@@ -21,9 +21,9 @@ if have_vhost_user
 endif
 system_ss.add(when: 'CONFIG_VIRTIO_CRYPTO', if_true: files('cryptodev-vhost.c'))
 if have_iommufd
-  system_ss.add(files('iommufd.c'))
+  system_ss.add(when: 'TARGET_PPC', if_false: files('iommufd.c'))
 else
-  system_ss.add(files('iommufd-stub.c'))
+  system_ss.add(when: 'TARGET_PPC', if_false: files('iommufd-stub.c'))
 endif
 if have_vhost_user_crypto
   system_ss.add(when: 'CONFIG_VIRTIO_CRYPTO', if_true: files('cryptodev-vhost-user.c'))
diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
index 9cae2c9e21..4423bb3cd4 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -8,7 +8,7 @@ vfio_ss.add(files(
   'migration.c',
 ))
 if have_iommufd
-  vfio_ss.add(files('iommufd.c'))
+  vfio_ss.add(when: 'TARGET_PPC', if_false: files('iommufd.c'))
 endif
 vfio_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
   'display.c',
-- 
2.34.1


