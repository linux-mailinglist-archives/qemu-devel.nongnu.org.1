Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACAF81BCB1
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 18:12:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGMa4-0004AV-CB; Thu, 21 Dec 2023 12:11:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rGMa0-0004A9-TG; Thu, 21 Dec 2023 12:11:29 -0500
Received: from mgamail.intel.com ([192.55.52.93])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rGMZx-0002Ye-7e; Thu, 21 Dec 2023 12:11:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1703178685; x=1734714685;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=E/2T3A7sjEbYG4zd9wZYMl0Sv+XXSrPrkOYyhvyEiZg=;
 b=UZJIbAPyDat/qb44BEuA4jCMbYInuY5fDmHm/p5WUk5JTFfY/R+msCeA
 S8vyKyxrEcC1ouuMXWYBJV1V2myVMDpFZ2EjI9xrVwlDaVJEMMw1yhx4o
 RpDEmF6/Z3theKpjhoSKz30wfVa5gNIdzB62zNd1fVB3evT0NO+Fu1Le9
 ug7lGQ9+zsU+iy87ooGgRIUtZae+P2OXhlOz2pOveRccj3w8P4ztuir8e
 5mpxjkRveZo1Q2a1mtgJK96FLme3J1s53JwaWDk3szMwwPJn46nKPeWzr
 RYVoPjtYKplVgzFWz4xYMnxOzUAQdId5nJOYHBCC6PeVsyFeT3CAUkQhf g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="393170594"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; d="scan'208";a="393170594"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Dec 2023 09:06:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="726488811"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; d="scan'208";a="726488811"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orsmga003.jf.intel.com with ESMTP; 21 Dec 2023 09:06:44 -0800
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
Subject: [PATCH 0/2] hw/s390x/ccw: Cleanup basename() and dirname()
Date: Fri, 22 Dec 2023 01:19:19 +0800
Message-Id: <20231221171921.57784-1-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
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
said, g_path_get_basename() and g_path_get_dirname() should be preferred
over basename() and dirname(), since g_path_get_basename() and
g_path_get_dirname() are portable utility functions that have the
advantage of not modifing the string argument.

But commit 3e015d815b3f missed a use of dirname() and basename() in
hw/s390x/ccw.

And basename() (in vfio/container) caused compile breakage with the Musl
C library [1].

To avoid similar breakage and improve portability, replace basename()
and dirname() with g_path_get_basename() and g_path_get_dirname().

[1]: https://lore.kernel.org/all/20231212010228.2701544-1-raj.khem@gmail.com/

---
Zhao Liu (2):
  hw/s390x/ccw: Replace basename() with g_path_get_basename()
  hw/s390x/ccw: Replace dirname() with g_path_get_dirname()

 hw/s390x/s390-ccw.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

-- 
2.34.1


