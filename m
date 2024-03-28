Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EAA4877A1C
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Mar 2024 04:29:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjWJX-00042W-6A; Sun, 10 Mar 2024 23:26:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rjWJU-0003i8-Cl; Sun, 10 Mar 2024 23:26:56 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rjWJE-0008BV-QC; Sun, 10 Mar 2024 23:26:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710127600; x=1741663600;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=GIq3Lmcu3fjMp0gf1ukU2dID2kj7OKhxGKif5k51WEs=;
 b=c2lydNVViTF4FzJyl3lFUybJF/4C6ILohmS2jgpq1/xFFN0nI2ezdORu
 KoV0swQonM9Ci/lU4WGuZAdzWw3HXPn+3FBDkEAKfzAUNglLp3fOz0BnM
 g3qfVEumdLsnB6IawKM4O2/aXDKLE1CLirlCJZPiGqtGMlLhJqF1vctVg
 /mAqYHVJFlY+cjSaAmx5SGa66n5ZRUDqALn757tZm9rFC9BZztiMHbGYm
 cQDGLeLRpaaRR7pEc3HRG2GhXFXzCMsihN34DR5CLWAh6GJwIDe1WX4Zy
 T8zhyCfDZxUOzuTerbD8MzJopRsX7WFyF+PUQxAM0Ek0oKqjGRu6sbvyI w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="22229830"
X-IronPort-AV: E=Sophos;i="6.07,115,1708416000"; d="scan'208";a="22229830"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2024 20:25:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,115,1708416000"; d="scan'208";a="15594068"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa003.fm.intel.com with ESMTP; 10 Mar 2024 20:25:52 -0700
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2 24/29] hw/vfio/platform: Fix missing ERRP_GUARD() for
 error_prepend()
Date: Mon, 11 Mar 2024 11:38:17 +0800
Message-Id: <20240311033822.3142585-25-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240311033822.3142585-1-zhao1.liu@linux.intel.com>
References: <20240311033822.3142585-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=198.175.65.10;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.945,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

As the comment in qapi/error, passing @errp to error_prepend() requires
ERRP_GUARD():

* = Why, when and how to use ERRP_GUARD() =
*
* Without ERRP_GUARD(), use of the @errp parameter is restricted:
...
* - It should not be passed to error_prepend(), error_vprepend() or
*   error_append_hint(), because that doesn't work with &error_fatal.
* ERRP_GUARD() lifts these restrictions.
*
* To use ERRP_GUARD(), add it right at the beginning of the function.
* @errp can then be used without worrying about the argument being
* NULL or &error_fatal.

ERRP_GUARD() could avoid the case when @errp is &error_fatal, the user
can't see this additional information, because exit() happens in
error_setg earlier than information is added [1].

The vfio_platform_realize() passes @errp to error_prepend(), and as a
DeviceClass.realize method, there are too many possible callers to check
the impact of this defect; it may or may not be harmless. Thus it is
necessary to protect @errp with ERRP_GUARD().

To avoid the issue like [1] said, add missing ERRP_GUARD() at the
beginning of this function.

[1]: Issue description in the commit message of commit ae7c80a7bd73
     ("error: New macro ERRP_GUARD()").

Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: "Cédric Le Goater" <clg@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
v2: Use Markus' sentence to polish commit message. (Markus)
---
 hw/vfio/platform.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index a8d9b7da633e..dcd2365fb353 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -576,6 +576,7 @@ static int vfio_base_device_init(VFIODevice *vbasedev, Error **errp)
  */
 static void vfio_platform_realize(DeviceState *dev, Error **errp)
 {
+    ERRP_GUARD();
     VFIOPlatformDevice *vdev = VFIO_PLATFORM_DEVICE(dev);
     SysBusDevice *sbdev = SYS_BUS_DEVICE(dev);
     VFIODevice *vbasedev = &vdev->vbasedev;
-- 
2.34.1


