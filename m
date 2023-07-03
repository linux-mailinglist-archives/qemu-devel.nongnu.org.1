Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF7E745615
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 09:29:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGDyx-0006DY-81; Mon, 03 Jul 2023 03:28:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qGDyv-0006DL-Hx
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 03:28:21 -0400
Received: from mga12.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qGDyt-0003wp-Vu
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 03:28:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1688369300; x=1719905300;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TmL+HEBZmg//YXAT1wthhau6V4CBxfpWlzpevCqqaD4=;
 b=n4cH2awWIRqnF2/zZXIlcjshaiWRtLKFjKh4k7n9JrhZ9JDdeqQHyGnE
 U2NVxHndHHylK3bvfUibJyTilPGeDBAx7ZbsJhxiZ11r7N6Jg8aI2ovyF
 0tt4UegDmBD4cQ3IXxx9jVXEkIY1bm4RZLZtY3U0tJ/h0IfLqQObM2MCF
 FAbu2CSpEW+FcSvuLGk0Q2AQOe+lFtgXUFd+Tpzwg5wFlYyQYE1NQ5rHY
 efh/xIFbINjdcH8+N8qhtXWgjEmHjAmySPQ8yUs6HNDxH9QXX9/u/qgat
 ECpElgXRUNeRCrw0cAzjBnAqyFK01d0YX9sZ9o4/ZEZnAmVDcC4vbpMBX g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="342405665"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; d="scan'208";a="342405665"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2023 00:28:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="748058780"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; d="scan'208";a="748058780"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2023 00:28:16 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, joao.m.martins@oracle.com,
 avihaih@nvidia.com, chao.p.peng@intel.com
Subject: [PATCH v6 6/7] vfio/migration: Remove print of "Migration disabled"
Date: Mon,  3 Jul 2023 15:15:09 +0800
Message-Id: <20230703071510.160712-5-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230703071510.160712-1-zhenzhong.duan@intel.com>
References: <20230703071510.160712-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.136;
 envelope-from=zhenzhong.duan@intel.com; helo=mga12.intel.com
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

Property enable_migration supports [on/off/auto].
In ON mode, error pointer is passed to errp and logged.
In OFF mode, we doesn't need to log "Migration disabled" as it's intentional.
In AUTO mode, we should only ever see errors or warnings if the device
supports migration and an error or incompatibility occurs while further
probing or configuring it. Lack of support for migration shoundn't
generate an error or warning.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
---
 hw/vfio/pci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 9154dd929d07..eefd4ec330d9 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3209,7 +3209,6 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
     if (!pdev->failover_pair_id) {
         ret = vfio_migration_realize(vbasedev, errp);
         if (ret) {
-            error_report("%s: Migration disabled", vbasedev->name);
             goto out_deregister;
         }
     }
-- 
2.34.1


