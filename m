Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A9D705D9A
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 05:01:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz7Nr-0001xP-Bh; Tue, 16 May 2023 22:59:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1pz7Np-0001x4-26
 for qemu-devel@nongnu.org; Tue, 16 May 2023 22:59:21 -0400
Received: from mga01.intel.com ([192.55.52.88])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1pz7Nm-0006nI-SK
 for qemu-devel@nongnu.org; Tue, 16 May 2023 22:59:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1684292358; x=1715828358;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Spr/pz6jp58URbpbwXjxPwoMCRRTGUMW008RTsKVYLc=;
 b=LV2HoFljpCErW6l6LCARVSZdZOM8NYC2iH56FsmNLd/23niHXG8VpgHS
 Ccbuv9zGAowWPALSXyJRQ5Fb5hvjTVOTdNhdxne24fRV5fFT3vFYo0Ra0
 NudtnJxqDKx4Nf8OONunwkll5dBNVR8N4Hlm1v6hW9/VwR+OnfVXMDY6i
 GnTkCcyTtg0FsZAF7M9wBzkHVrH5mp6Wo+0UbjUnnA2VvgzGxqsNPQHv4
 7Z2NEYJajqa/CgZOEFK1Fh1tI1wzFcgPBtKntEQyUxv6brILIPPEBHJrn
 12PPA0ryFeNWQ/O22mZCDqYWtqTtzLOn3c5ottGeH6d5Ni37z/ENnDaVc Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="379836935"
X-IronPort-AV: E=Sophos;i="5.99,280,1677571200"; d="scan'208";a="379836935"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 May 2023 19:59:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="948093988"
X-IronPort-AV: E=Sophos;i="5.99,280,1677571200"; d="scan'208";a="948093988"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 May 2023 19:59:09 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: minwoo.im@samsung.com, alex.williamson@redhat.com, clg@redhat.com,
 chao.p.peng@intel.com
Subject: [PATCH v2] vfio/pci: Fix a use-after-free issue
Date: Wed, 17 May 2023 10:46:51 +0800
Message-Id: <20230517024651.82248-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.88;
 envelope-from=zhenzhong.duan@intel.com; helo=mga01.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

vbasedev->name is freed wrongly which leads to garbage VFIO trace log.
Fix it by allocating a dup of vbasedev->name and then free the dup.

Fixes: 2dca1b37a7 ("vfio/pci: add support for VF token")
Suggested-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
v2: "toke" -> "token", Cedric
    Update with Alex suggested change

 hw/vfio/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index bf27a3990564..73874a94de12 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2994,7 +2994,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
         qemu_uuid_unparse(&vdev->vf_token, uuid);
         name = g_strdup_printf("%s vf_token=%s", vbasedev->name, uuid);
     } else {
-        name = vbasedev->name;
+        name = g_strdup(vbasedev->name);
     }
 
     ret = vfio_get_device(group, name, vbasedev, errp);
-- 
2.34.1


