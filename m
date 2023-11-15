Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 888687EBECB
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 09:49:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3BZ3-0003H6-TF; Wed, 15 Nov 2023 03:48:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r3BZ1-0003Gy-9S
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 03:47:59 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r3BYz-0007nA-BV
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 03:47:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700038078; x=1731574078;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=4y5Q+AKLYx0ykMorV4LLRUZ7z4Tg7TmYo44QApsnJjE=;
 b=TfkbbVPerqTzLFCxI5gu9lOTldFWk3C4o3WGdw11LYbL9H1wh7xUsN2P
 Ro8IyZM38LdWOVQSlyd2YHenyVWVAUcef8F3o3pVK7FqCDgWULvLY/7fC
 fYs5logKb+CKosHTIemi8+0QZ/xn/ev9rCEzlfqVwrASeWX+oLKVyRN4h
 fn+NlbdIxd9TnXJvskt7HsQ/XcUU9us25d50fH7ifBN89GDAzDiFNmmYI
 Q4j6/7ifYBGxa61OZlvGnPQuvUUiT6qKySYKTt1DZPrhDwtNCqPZkdRWx
 E7W4HM48Rbzfm1EBNKSgIjZFRDYR5Y2HJZuyn/3feTa00HxluIK9orTiW g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="12385036"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; d="scan'208";a="12385036"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2023 00:47:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="1012199404"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; d="scan'208";a="1012199404"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2023 00:47:50 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH 0/4] VFIO device init cleanup
Date: Wed, 15 Nov 2023 16:32:14 +0800
Message-Id: <20231115083218.1973627-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.7;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
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

Hi,

This is a clean up based on Cedric's suggestion at
https://lists.gnu.org/archive/html/qemu-devel/2023-11/msg02722.html

VFIO device initializations are all moved from realize to instance_init.

Based on https://github.com/legoater/qemu/commits/vfio-8.2

Thanks
Zhenzhong

Zhenzhong Duan (4):
  vfio/pci: Move VFIODevice initializations in vfio_instance_init
  vfio/platform: Move VFIODevice initializations in
    vfio_platform_instance_init
  vfio/ap: Move VFIODevice initializations in vfio_ap_instance_init
  vfio/ccw: Move VFIODevice initializations in vfio_ccw_instance_init

 hw/vfio/ap.c       | 26 +++++++++++++-------------
 hw/vfio/ccw.c      | 30 +++++++++++++++---------------
 hw/vfio/pci.c      | 10 ++++++----
 hw/vfio/platform.c | 10 +++++-----
 4 files changed, 39 insertions(+), 37 deletions(-)

-- 
2.34.1


