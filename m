Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 358AC7EAE08
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 11:28:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2qdm-0006DZ-2P; Tue, 14 Nov 2023 05:27:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r2qdZ-0005bE-Mo
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 05:27:17 -0500
Received: from mgamail.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r2qdW-0007rn-NX
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 05:27:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1699957634; x=1731493634;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=uAiLwZBVoB2283ODF/W1km9gijtCWMu83BRnwvnJuBY=;
 b=VaV+eJxxH3de17qR5VH3laFCis5Qz8ynVKkie9T3/oiSEI3NxPtJidkZ
 2DESZcC8W8xM6G+WtoQuOtsTE51O/FoM4qphHwccQGtqutvNtZMN0VpAs
 gpjuBxKs4kNy/+Ga6XsLzBV9ScMDkzDc87fkUOoPqZnjAh6edMmGSBq9i
 qxLXYocB4PuHoodHBvqzdPkBsKuP2yHeMsw0368iVM5R2Yiz18uLM+YyD
 PVE4cS7t/5yR+0dIzrsaFMgWqiutoGCLm4jQ/dtZ2wR315vX1Tmb4Pq+t
 yxEfC+Yiu1SAUtGc2kmcNYD3jsJDh61NoUbv4nnD/mOEM4UUx4nbIH2xF Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="394543751"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; d="scan'208";a="394543751"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Nov 2023 02:27:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="888213236"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; d="scan'208";a="888213236"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Nov 2023 02:27:03 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v6 21/21] hw/i386: Activate IOMMUFD for q35 machines
Date: Tue, 14 Nov 2023 18:09:55 +0800
Message-Id: <20231114100955.1961974-22-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231114100955.1961974-1-zhenzhong.duan@intel.com>
References: <20231114100955.1961974-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.65;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
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

From: Cédric Le Goater <clg@redhat.com>

Signed-off-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index 55850791df..a1846be6f7 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -95,6 +95,7 @@ config Q35
     imply E1000E_PCI_EXPRESS
     imply VMPORT
     imply VMMOUSE
+    imply IOMMUFD
     select PC_PCI
     select PC_ACPI
     select PCI_EXPRESS_Q35
-- 
2.34.1


