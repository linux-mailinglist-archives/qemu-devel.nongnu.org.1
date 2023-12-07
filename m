Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0A98083BD
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 10:03:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBAGz-0002Dp-E8; Thu, 07 Dec 2023 04:02:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rBAGl-0002Ad-6t
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 04:02:08 -0500
Received: from mgamail.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rBAGh-00061v-Ac
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 04:02:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1701939723; x=1733475723;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=r7EYI1ufLFFP1XtnWOrwmSb/zRHEopbGjzJeGM0h1CE=;
 b=OuJl+XjF0Hp1schPIjymH4PEB1MEpq9pkf+ncZdGHRU+b1gajP6xXDfr
 QMBf4NA0IOtCsxf/cHl4u6mJXtqnEa+uFMRL5J9DafKl6KpcFmNd3LZcB
 Oul7aNBHKkdLypglWgZMQZHq04E4gSEDUeUXPCzjg4N+d90Gr3DCO/3mt
 8/Vq/oRmoO02EOpk1bBzjuFNjxPlEYruO37/dtpxQE7HEKmzK113PREZ2
 K08Pgh2RA4bTPwbqu0n1Cz7jFxhmSbpzXNEQ7DvEBNRxmRgfdd5yDMZlh
 5JbpSVnkw13yraVgon/cf6ZltnVoq3Tuqg0H2QKrYNcRn/1fAG8kjKth7 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="393071087"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; d="scan'208";a="393071087"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Dec 2023 01:01:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="775335181"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; d="scan'208";a="775335181"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Dec 2023 01:01:58 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH] system: Fix location print in axexit notifier callback
Date: Thu,  7 Dec 2023 16:46:09 +0800
Message-Id: <20231207084609.2288573-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.120;
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

Some exit notifier callbacks call error_report_err if it fails
to do the cleanup. If this happens on QEMU command line parse
stage, i.e. there is fatal error, the location printed in
error_report_err is totally unrelated to exit notifier itself.
Set location to none to avoid such confusing.

Before fix:
qemu-system-x86_64: -device intel-iommu,device-iotlb=on,x-pasid-mode=on: PASID based device IOTLB is not supported
qemu-system-x86_64: -device intel-iommu,device-iotlb=on,x-pasid-mode=on: network script /root/qemu/build/qemu-bundle/usr/local/etc/qemu-ifdown failed with status 256

After fix:
qemu-system-x86_64: -device intel-iommu,device-iotlb=on,x-pasid-mode=on: PASID based device IOTLB is not supported
qemu-system-x86_64: network script /root/qemu/build/qemu-bundle/usr/local/etc/qemu-ifdown failed with status 256

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 system/runstate.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/system/runstate.c b/system/runstate.c
index ea9d6c2a32a4..32e9e9b541aa 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -797,6 +797,15 @@ void qemu_remove_exit_notifier(Notifier *notify)
 
 static void qemu_run_exit_notifiers(void)
 {
+    /*
+     * Some exit notifier callbacks call error_report_err if it fails
+     * to do the cleanup. If this happens on QEMU command line parse
+     * stage, i.e. there is fatal error, the location printed in
+     * error_report_err is totally unrelated to exit notifier itself.
+     * Set location to none to avoid such confusing.
+     */
+    loc_set_none();
+
     notifier_list_notify(&exit_notifiers, NULL);
 }
 
-- 
2.34.1


