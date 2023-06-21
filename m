Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3EE737D29
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 10:16:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBszj-0004jN-SM; Wed, 21 Jun 2023 04:15:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qBszX-0004ev-H0
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 04:15:04 -0400
Received: from mga18.intel.com ([134.134.136.126])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qBszV-0002s2-8u
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 04:15:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687335301; x=1718871301;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Yvby1xL5KE7nyNMw/+xyjbntCpFwyMIb7Sk0TIIoQOs=;
 b=Yti9RWRX6RrIQeMT9R5NOX0MUipf2wAdKpydmlJuBehMiViXnLUmVUL6
 /iJ0UmNDvCfwWF0lnzRKjeO/sc95A0YowSv6+kyOGBN0HEPbBksUSpPDg
 mOtbRuR2IH3GMBghCm6JCLNgAcxn1Ba29UXjFsw25F8KJD1hExyCU8ldL
 vAgAnFfMaPWgRHJqeHMhVGK9A+/dzD1GEyAb0SYkvVnCoegLD47ZYiKSq
 RGhf1fDAhPTS4R8jdvFvm9qEOCIdwC/Xiiq+bhkkg+uL5HDkLrDQZetnV
 lJgcuUAjhL21aux1WHn/4sGrinZZ2i5Zmx7B2F5pib33HeL1Drck1enFZ g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="344843445"
X-IronPort-AV: E=Sophos;i="6.00,259,1681196400"; d="scan'208";a="344843445"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jun 2023 01:14:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="804282278"
X-IronPort-AV: E=Sophos;i="6.00,259,1681196400"; d="scan'208";a="804282278"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jun 2023 01:14:55 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, joao.m.martins@oracle.com,
 avihaih@nvidia.com, chao.p.peng@intel.com
Subject: [PATCH v3 0/3] VFIO migration related refactor and bug fix
Date: Wed, 21 Jun 2023 16:02:01 +0800
Message-Id: <20230621080204.420723-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.126;
 envelope-from=zhenzhong.duan@intel.com; helo=mga18.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

PATCH3 refactors the VFIO migration blocker related code based on
suggestions from Joao and Cedric, so that code is simpler and
"Migration disabled" printed in right case.

But before that works, also found some hotplug bugs when testing
blocker adding failed case. PATCH1 and PATCH2 fix them.

See patch description for details.

Thanks

v3: Add PATCH1,2 to fix hotplug bug
    Fix bugs in PATCH3 Avihai and Joao pointed out

Tested vfio hotplug/unplug with vfio migration supported and unsupported cases,
including blocker adding failed case.

Zhenzhong Duan (3):
  vfio/pci: Fix resource leak in vfio_realize
  vfio/pci: Fix a segfault in vfio_realize
  vfio/migration: vfio/migration: Refactor and fix print of "Migration
    disabled"

 hw/vfio/common.c              | 54 +++++------------------------------
 hw/vfio/migration.c           | 37 +++++++++++-------------
 hw/vfio/pci.c                 |  9 ++++--
 include/hw/vfio/vfio-common.h |  7 ++---
 4 files changed, 33 insertions(+), 74 deletions(-)

-- 
2.34.1


