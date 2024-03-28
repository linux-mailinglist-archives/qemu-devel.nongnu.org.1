Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3794D877A1B
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Mar 2024 04:29:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjWJw-00068t-QU; Sun, 10 Mar 2024 23:27:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rjWJi-0005oU-8C; Sun, 10 Mar 2024 23:27:10 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rjWJg-0008EJ-6M; Sun, 10 Mar 2024 23:27:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710127628; x=1741663628;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=PuuITxi/LVf2InU1mM00W7NeqQ6+dk76QqfYGUwraxs=;
 b=HP0ziY8ajKZSIK6KKBMgvUgVjCkaZzPe5iH2o7pXrEPAr7TiTcLxQWEe
 k9MkIKbq7H/nRPXqRkfy4JpQ5gT0mfhX4bCn+n5/UoDxPYne3RVcmKdDp
 U7AZ2OXkgduUzZfMMEqG9iQPC64h6k8sXLvuYlJZiT3jguxXAthFNzpml
 E+L1e9MgJzS2WQuWdL6lu8LVPbGenAuAr/GNZxtyukCPWnuPUrrrYl9Z7
 T/mbUCl2zwdklW4iOtyrRDaHn/QOmD1cuPnnWlq7+5aAJICJabG7aB1zP
 kwWNBVL00Xlg+ZV8eF/IRsLz4o3Cy5HvYny0Xj7+z09/UWAbosZEOM7hu A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="22229857"
X-IronPort-AV: E=Sophos;i="6.07,115,1708416000"; d="scan'208";a="22229857"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2024 20:26:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,115,1708416000"; d="scan'208";a="15594096"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa003.fm.intel.com with ESMTP; 10 Mar 2024 20:26:03 -0700
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Jason Wang <jasowang@redhat.com>
Subject: [PATCH v2 28/29] net/vhost-vdpa: Fix missing ERRP_GUARD() for
 error_prepend()
Date: Mon, 11 Mar 2024 11:38:21 +0800
Message-Id: <20240311033822.3142585-29-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240311033822.3142585-1-zhao1.liu@linux.intel.com>
References: <20240311033822.3142585-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=198.175.65.10;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.945,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

As the comment in qapi/error, passing @errp to error_prepend() requires
ERRP_GUARD():

* = Why, when and how to use ERRP_GUARD() =
*
* Without ERRP_GUARD(), use of the @errp parameter is restricted:
...
* - It should not be passed to error_prepend(), error_vprepend() or
*   error_append_hint(), because that doesn't work with &error_fatal.
* ERRP_GUARD() lifts these restrictions.
*
* To use ERRP_GUARD(), add it right at the beginning of the function.
* @errp can then be used without worrying about the argument being
* NULL or &error_fatal.

ERRP_GUARD() could avoid the case when @errp is &error_fatal, the user
can't see this additional information, because exit() happens in
error_setg earlier than information is added [1].

The net_init_vhost_vdpa() passes @errp to error_prepend(), and as a
member of net_client_init_fun[], it's called in net_client_init1() and
gets @errp from this caller.

But because netdev_init_modern() passes &error_fatal to
net_client_init1(), then @errp parameter of net_init_vhost_vdpa() would
point to @error_fatal. This causes the error message in error_prepend()
to be lost because of the above issue.

To fix this, add missing ERRP_GUARD() at the beginning of this function.

[1]: Issue description in the commit message of commit ae7c80a7bd73
     ("error: New macro ERRP_GUARD()").

Cc: Jason Wang <jasowang@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 net/vhost-vdpa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index e6bdb4562dde..d81baecbc1a3 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -1751,6 +1751,7 @@ static int vhost_vdpa_get_max_queue_pairs(int fd, uint64_t features,
 int net_init_vhost_vdpa(const Netdev *netdev, const char *name,
                         NetClientState *peer, Error **errp)
 {
+    ERRP_GUARD();
     const NetdevVhostVDPAOptions *opts;
     uint64_t features;
     int vdpa_device_fd;
-- 
2.34.1


