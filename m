Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B28DFACED92
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Jun 2025 12:28:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN7ob-0001cZ-U1; Thu, 05 Jun 2025 06:27:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uN7oS-0001aJ-B2
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 06:27:08 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uN7oO-00053b-QA
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 06:27:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749119225; x=1780655225;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=NdsHWVBZvwONxKrSYwF7thoYUxadts4jiZByy5b/hFo=;
 b=Ft19CUmmHW9nQuo8RdlgkbWxez0DlnaMPQm3E9VABEgB8c84S+RWjrJz
 VGS48fDoqUaqAGBcVqRkgX0tRLyVpGjxQ0b8vbz87qsJVH7wcUHlnF1yj
 7/rWTa7scVk8OcWUlBaw/dU0etelqsZxx1zwzdT4FHAeUlebL1QMFzH/D
 fJ9j/sE6LGxQaxK4cSXPQdf0Duz0tyeoFbMBXMWVNyMhFYB+tMezLUxva
 E5fp7PL2cPVnMWSYlhRzkgBJ1ifyP2exIsiYvm+bW6M7TklkIybau8n1O
 tXH0gsqs47jxQkYRFTW9WEMp12Kl5eIZxMGRMxmUAF9n5TQ0H6v3unGyC Q==;
X-CSE-ConnectionGUID: /0TnjewuSc+rdDQMWardkA==
X-CSE-MsgGUID: MPu1IyshTsWsIEAMz0MK2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="51325304"
X-IronPort-AV: E=Sophos;i="6.16,211,1744095600"; d="scan'208";a="51325304"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2025 03:27:03 -0700
X-CSE-ConnectionGUID: pmbFuLxDTkyuKMw1T0qTQw==
X-CSE-MsgGUID: 9D7J1E5lSLykGE+Tdn1N/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,211,1744095600"; d="scan'208";a="145808631"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2025 03:27:01 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: chao.p.peng@intel.com, david@redhat.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v3 2/5] virtio-pmem: Fix definition of VirtIOPMEMClass
Date: Thu,  5 Jun 2025 18:23:08 +0800
Message-Id: <20250605102311.148171-3-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250605102311.148171-1-zhenzhong.duan@intel.com>
References: <20250605102311.148171-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

VirtIOPMEMClass's parent is VirtioDeviceClass rather than VirtIODevice.

Fixes: 5f503cd9f388 ("virtio-pmem: add virtio device")
Closes: https://lists.gnu.org/archive/html/qemu-devel/2025-06/msg00586.html
Reported-by: David Hildenbrand <david@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/virtio/virtio-pmem.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/virtio/virtio-pmem.h b/include/hw/virtio/virtio-pmem.h
index fc4fd1f7fe..9cce600d0b 100644
--- a/include/hw/virtio/virtio-pmem.h
+++ b/include/hw/virtio/virtio-pmem.h
@@ -36,7 +36,7 @@ struct VirtIOPMEM {
 
 struct VirtIOPMEMClass {
     /* private */
-    VirtIODevice parent;
+    VirtioDeviceClass parent_class;
 
     /* public */
     void (*fill_device_info)(const VirtIOPMEM *pmem, VirtioPMEMDeviceInfo *vi);
-- 
2.34.1


