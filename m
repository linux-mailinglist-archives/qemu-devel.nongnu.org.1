Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C558881BCB2
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 18:12:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGMa7-0004Bz-3O; Thu, 21 Dec 2023 12:11:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rGMa4-0004Ba-Ic; Thu, 21 Dec 2023 12:11:32 -0500
Received: from mgamail.intel.com ([192.55.52.93])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rGMa1-0002Ye-WC; Thu, 21 Dec 2023 12:11:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1703178690; x=1734714690;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=f+D2TgM3xmuW9/oGq31Ico4D2XznPPyfCUDyYI4vs5s=;
 b=iLLbnLUTCWmXj6RkonT05v9yArKE/rCDl1I8gAptiAwdQ2EKJmlK/6DB
 TpMhvJX9+u6MGOwpLIaVtTd4Z3nzuly2hPttAaHjPwl8bLRCxvvSrNXZV
 /Z0EvbkBM96VXEOKgcfwa4IhbPZ+CF/HRjnvh6YD7qld32R6sVeLqzGAH
 A2TI1KCCINuzNYPNuO/JXTSSJ/HyJWXITx0YqkwIuSKFMlZbyvtyPigUg
 z8MqyGissBDaRgOuxBKCeCuzqb2cF5wFPuClUgZb1sa5AZpiv4Hk1QxO9
 mI9sTUMNThzDsWgMZLvJzTi37g/IQxa+uFQKP3LnqfsWHimxxnDVaVrTx w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="393170635"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; d="scan'208";a="393170635"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Dec 2023 09:06:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="726488834"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; d="scan'208";a="726488834"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orsmga003.jf.intel.com with ESMTP; 21 Dec 2023 09:06:51 -0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 2/2] hw/s390x/ccw: Replace dirname() with g_path_get_dirname()
Date: Fri, 22 Dec 2023 01:19:21 +0800
Message-Id: <20231221171921.57784-3-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221171921.57784-1-zhao1.liu@linux.intel.com>
References: <20231221171921.57784-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.55.52.93;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.061,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

As commit 3e015d815b3f ("use g_path_get_basename instead of basename")
said, g_path_get_dirname() should be preferred over dirname() since
the former is a portable utility function that has the advantage of not
modifing the string argument.

Replace dirname() with g_path_get_dirname().

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Suggested by credit:
  Cédric: Referred his words for g_path_get_basename() and
          g_path_get_dirname() has the same advantage.
---
 hw/s390x/s390-ccw.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/s390-ccw.c b/hw/s390x/s390-ccw.c
index ab7022a3abe8..5261e66724f1 100644
--- a/hw/s390x/s390-ccw.c
+++ b/hw/s390x/s390-ccw.c
@@ -77,6 +77,7 @@ static void s390_ccw_get_dev_info(S390CCWDevice *cdev,
 {
     unsigned int cssid, ssid, devid;
     char dev_path[PATH_MAX] = {0};
+    g_autofree char *tmp_dir = NULL;
     g_autofree char *tmp = NULL;
 
     if (!sysfsdev) {
@@ -93,7 +94,8 @@ static void s390_ccw_get_dev_info(S390CCWDevice *cdev,
 
     cdev->mdevid = g_path_get_basename(dev_path);
 
-    tmp = g_path_get_basename(dirname(dev_path));
+    tmp_dir = g_path_get_dirname(dev_path);
+    tmp = g_path_get_basename(tmp_dir);
     if (sscanf(tmp, "%2x.%1x.%4x", &cssid, &ssid, &devid) != 3) {
         error_setg_errno(errp, errno, "Failed to read %s", tmp);
         return;
-- 
2.34.1


