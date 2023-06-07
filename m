Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB87D72599F
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 11:09:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6pAK-00062q-FH; Wed, 07 Jun 2023 05:09:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lingshan.zhu@intel.com>)
 id 1q6pAI-00062X-52
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 05:09:14 -0400
Received: from mga06b.intel.com ([134.134.136.31] helo=mga06.intel.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lingshan.zhu@intel.com>)
 id 1q6pA4-0000tR-7o
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 05:09:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1686128940; x=1717664940;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=EAl+D5GD7UqhA418zYVMgAIsNRjJQy93tpbLPhL4oj4=;
 b=CHWVYc/qMuvOxWD92t6bS0yU/dGcTc54ZyhCnd80aSQndP+nY0TLB46F
 LJaO/2bZG8UmYLQKMHbGTyUfC2iUQl51IRh4v31EP7vBgdsttjhoR1Kj1
 cWlWCvA5GrOBBtG26cDSqc2alYU1SyySLyhKmnyvs1d93KcqRAtAa6A8I
 0dJOMvGCHbuyMTnPBcLS1xHrUalHL0jHtrvUTnYchFBCEzbyX/943hIlc
 ZuJXloBD49qMM07970KXEIsAdjrhxb/4TveeTX918e7bv3O4fZfP1l/tk
 aIAALk/PuBdjaiagZygGqgX6oS6/ligg72y4iXN76JIPa6IMA3g9tun+b g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="420488834"
X-IronPort-AV: E=Sophos;i="6.00,223,1681196400"; d="scan'208";a="420488834"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jun 2023 02:08:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="883657587"
X-IronPort-AV: E=Sophos;i="6.00,223,1681196400"; d="scan'208";a="883657587"
Received: from lingshan-icx.bj.intel.com ([10.240.192.125])
 by orsmga005.jf.intel.com with ESMTP; 07 Jun 2023 02:08:53 -0700
From: Zhu Lingshan <lingshan.zhu@intel.com>
To: jasowang@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	Zhu Lingshan <lingshan.zhu@intel.com>
Subject: [PATCH] vdpa: dont check vhost_vdpa->suspended when unsupported
Date: Thu,  8 Jun 2023 01:08:42 +0800
Message-Id: <20230607170842.488489-1-lingshan.zhu@intel.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.31;
 envelope-from=lingshan.zhu@intel.com; helo=mga06.intel.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DATE_IN_FUTURE_06_12=1.947,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
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

When read the state of a virtqueue, vhost_vdpa need
to check whether the device is suspended.

This commit verifies whether VHOST_BACKEND_F_SUSPEND is
negotiated when checking vhost_vdpa->suspended.

Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
---
 hw/virtio/vhost-vdpa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index b3094e8a8b..ae176c06dd 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -1397,7 +1397,7 @@ static int vhost_vdpa_get_vring_base(struct vhost_dev *dev,
         return 0;
     }
 
-    if (!v->suspended) {
+    if ((dev->backend_cap & BIT_ULL(VHOST_BACKEND_F_SUSPEND)) && (!v->suspended)) {
         /*
          * Cannot trust in value returned by device, let vhost recover used
          * idx from guest.
-- 
2.39.1


