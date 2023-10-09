Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E097BD1F6
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 04:23:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpfuw-0004C1-FA; Sun, 08 Oct 2023 22:22:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qpfun-00044U-6v; Sun, 08 Oct 2023 22:22:38 -0400
Received: from mgamail.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qpful-0003d1-2t; Sun, 08 Oct 2023 22:22:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1696818155; x=1728354155;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=WpD24aY/1O0I3X7nIIfb/SaSIgAF9Qk8sOfLfVoBqjY=;
 b=bWfhk5eTkoxjvc/45Hqo7eGnK1WD1EbMykfqpOEkziTxmxzPpJj7NoBq
 BODluolHLDlJibgiGTrBqDmJaX4ROWICW7vSTIfriBXfd6ZpwmsnKA7qP
 oXgvTBLoLLOu8nqLu3/gGJqGQSjr66blxqyDqcck0Tqj6vOsshJjlG7bH
 NyajqtvFCRJNPoCjWtR17jTUpPKfcJaF1oAYDCWHmq+nb+tF8ADmse+zs
 SotaRH/KazOZ9u66nxNBrNXISpCTIEU7zOV2xVcFZIYdAkAQJlGbTSzu1
 Y8yO5EnXJ7Lb0o5xfvQHo3hsT4m9YJW3Hkf+1Xi+S2lT5k45StB8YQ5hB w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="387916681"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; d="scan'208";a="387916681"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2023 19:22:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="752860875"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; d="scan'208";a="752860875"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2023 19:22:29 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, thuth@redhat.com,
 akrowiak@linux.ibm.com, pasic@linux.ibm.com, jjherne@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, borntraeger@linux.ibm.com,
 aik@ozlabs.ru, eric.auger@redhat.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, qemu-s390x@nongnu.org
Subject: [PATCH 3/3] vfio/ccw: Remove redundant definition of TYPE_VFIO_CCW
Date: Mon,  9 Oct 2023 10:20:48 +0800
Message-Id: <20231009022048.35475-4-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231009022048.35475-1-zhenzhong.duan@intel.com>
References: <20231009022048.35475-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.65;
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

No functional changes.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/s390x/vfio-ccw.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/hw/s390x/vfio-ccw.h b/include/hw/s390x/vfio-ccw.h
index 63a909eb7e..4209d27657 100644
--- a/include/hw/s390x/vfio-ccw.h
+++ b/include/hw/s390x/vfio-ccw.h
@@ -22,6 +22,4 @@
 #define TYPE_VFIO_CCW "vfio-ccw"
 OBJECT_DECLARE_SIMPLE_TYPE(VFIOCCWDevice, VFIO_CCW)
 
-#define TYPE_VFIO_CCW "vfio-ccw"
-
 #endif
-- 
2.34.1


