Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F191743638
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 09:50:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF8tQ-0001ur-FR; Fri, 30 Jun 2023 03:50:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qF8tO-0001ui-0z
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:50:10 -0400
Received: from mga03.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qF8tM-0002oc-4X
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:50:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1688111408; x=1719647408;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=jxpKTAInzfx8UIcmYnemexQBA/d+xvputn2hB27MCd8=;
 b=Ejz+VvwWO2F32a1XByZ6uSIwMpGDXP2xtabJTRcKbJDk+nZDgmB0S+XI
 mjAmkuN8Tjd0uCVsepCp6axt89+z8SsPpRZYfaSvbqRa48g7Bl6csYkMR
 65oibojQjWRVxVFXslq1fV5omReBODPYyJWwcd72r1XvREreMGjpy4Cqq
 wXkhcKZZBW7DxM9YEzD9S3bEFmOe4vCxsHFZ+YX6zv1NoT33FjRJKS0iB
 mXwRHXLcsRjJ4yFNALWKVcSTWYaKXCW9ueFvPdY/kLS/1y/x2T+kNPVxs
 HWNzQikT71mmO01evotJxzDom+JhrBGhUBaNTOz0n5INnk1JoSvlgJ5ld w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="365824497"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200"; d="scan'208";a="365824497"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2023 00:50:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="841770837"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200"; d="scan'208";a="841770837"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2023 00:50:03 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, joao.m.martins@oracle.com,
 avihaih@nvidia.com, chao.p.peng@intel.com
Subject: [PATCH v5 7/7] vfio/migration: Remove print of "Migration disabled"
Date: Fri, 30 Jun 2023 15:36:37 +0800
Message-Id: <20230630073637.124234-6-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230630073637.124234-1-zhenzhong.duan@intel.com>
References: <20230630073637.124234-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.65;
 envelope-from=zhenzhong.duan@intel.com; helo=mga03.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Property enable_migration supports [on/off/auto].
In ON mode, error pointer is passed to errp and logged.
In OFF mode, we doesn't need to log "Migration disabled" as it's intentional.
In AUTO mode, we should only ever see errors or warnings if the device
supports migration and an error or incompatibility occurs while further
probing or configuring it. Lack of support for migration shoundn't
generate an error or warning.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/pci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 9cf70c1965d3..1c969fccc543 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3209,7 +3209,6 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
     if (!pdev->failover_pair_id) {
         ret = vfio_migration_realize(vbasedev, errp);
         if (!ret) {
-            error_report("%s: Migration disabled", vbasedev->name);
             goto out_deregister;
         }
     }
-- 
2.34.1


