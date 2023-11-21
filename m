Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0827E7F27F0
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 09:49:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5MR8-0004dk-M3; Tue, 21 Nov 2023 03:48:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r5MR6-0004T7-GE
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 03:48:48 -0500
Received: from mgamail.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r5MR3-0002Dg-8N
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 03:48:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700556525; x=1732092525;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=CodAN8dAh5o4VK2f3gSAAb1kS5E0dAh3CSKbhh8sQBU=;
 b=m6vg02HejfWwRNsN/ZHV8p+xFG+Ihppm1rEBz9vm9VdHm1xgzSQ9Y7Dz
 yNRbfyfU7VKljafYzbd0zcT2zrX01cCw0DcfRGZmyJAN/UMiINPzU/Weu
 9HD3oZAOvqHm8oq0PiwrfeJS3Ia9DL0Fl7vSRa7L0rCHbkBSK4q7cNb4y
 saW6LDjOV4vIM1cWAKdWLetoqh9OBSxLL5XVr1yqRs8YSG7i7q7XmRvnf
 RaoFUSo4HfKB4AWRqt8O3MxtexndLsJTz/Ujt7GGZUTfpJ6EZs9bTfBXl
 U7QYLm4J4mH5L6N6cDCGWpfkoVYtbfUJRyhKdihNpBIZfkY4u36+1iNpU g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="395722289"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; d="scan'208";a="395722289"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2023 00:47:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="884125140"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; d="scan'208";a="884125140"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2023 00:47:42 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com
Subject: [PATCH v7 21/27] hw/i386: Activate IOMMUFD for q35 machines
Date: Tue, 21 Nov 2023 16:44:20 +0800
Message-Id: <20231121084426.1286987-22-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231121084426.1286987-1-zhenzhong.duan@intel.com>
References: <20231121084426.1286987-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.65;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
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
Reviewed-by: Eric Auger <eric.auger@redhat.com>
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


