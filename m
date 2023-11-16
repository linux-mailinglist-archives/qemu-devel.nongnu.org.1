Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 56FA27EDCBA
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 09:16:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3XWQ-0004gP-CG; Thu, 16 Nov 2023 03:14:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r3XWO-0004fy-AW
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 03:14:44 -0500
Received: from mgamail.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r3XWL-0008V3-S1
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 03:14:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700122481; x=1731658481;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=fZFsAmj1I5cMSRzJNbdIkMHOY1L/H3g1nDkmvZX8kX0=;
 b=F2Il0K+lRG+2fT2Mv6WoangdJcXBaJFP9OLw0e4es18NYw/zIk8V6BNf
 Z8mfsW3YwX7eJbktRF0IIKsRWKTsi2KTtQTuxaHX3PkasFNUt+soEYJZ0
 +QELr2UZxNqYaB9d4DzX0y4mr7PvmosYI43c85A3+Vf0QDDZCkVPR8K1b
 qvifMOzc6ysSfJvDsmC2MCUDOFGGPG0zsBwU2wsrVtzorF72RHKWTJrJF
 OublwpBH8QGr0Sc1XKGeyTB0Oo7QNzkMJxqI7lBAyNc3x5pEZAZVWjMW+
 87oA0vw3efVOb6sXZrZanMUxb/XB8Dib/cTYTYkpcQJyMTj/gkw83NQgb A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="389898177"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; d="scan'208";a="389898177"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2023 00:14:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="768846127"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; d="scan'208";a="768846127"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2023 00:14:34 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 0/5] VFIO device init cleanup
Date: Thu, 16 Nov 2023 15:59:04 +0800
Message-Id: <20231116075909.1987656-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.120;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
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

Hi,

This is a cleanup based on Cédric's suggestion at
https://lists.gnu.org/archive/html/qemu-devel/2023-11/msg02722.html

VFIO device initializations are all moved from realize to instance_init.

Based on https://github.com/legoater/qemu/commits/vfio-8.2

Thanks
Zhenzhong

Changelog:
v2: Append a new patch to introduce vfio_device_init (Cédric)
    Add RB

Zhenzhong Duan (5):
  vfio/pci: Move VFIODevice initializations in vfio_instance_init
  vfio/platform: Move VFIODevice initializations in
    vfio_platform_instance_init
  vfio/ap: Move VFIODevice initializations in vfio_ap_instance_init
  vfio/ccw: Move VFIODevice initializations in vfio_ccw_instance_init
  vfio: Introduce a helper function to initialize VFIODevice

 include/hw/vfio/vfio-common.h |  2 ++
 hw/vfio/ap.c                  | 22 +++++++++-------------
 hw/vfio/ccw.c                 | 26 +++++++++++---------------
 hw/vfio/helpers.c             | 11 +++++++++++
 hw/vfio/pci.c                 |  8 ++++----
 hw/vfio/platform.c            |  8 +++-----
 6 files changed, 40 insertions(+), 37 deletions(-)

-- 
2.34.1


