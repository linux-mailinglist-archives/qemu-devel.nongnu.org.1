Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FE17BD1F4
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 04:23:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpfug-0003y2-H6; Sun, 08 Oct 2023 22:22:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qpfud-0003xX-5G; Sun, 08 Oct 2023 22:22:27 -0400
Received: from mgamail.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qpfua-0003cV-RX; Sun, 08 Oct 2023 22:22:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1696818144; x=1728354144;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=P9Tb3yMXV/Mtz+gmogGvcCj8ZZMWG9M2dsnD6Id3F4Y=;
 b=VDc6i3/lFNysJFTi9Umyj3klFSP3VqwPal+Gc3KhmfcpYzPGwYJIYO67
 iU8rbLMUJAf2RtmZUBAvS1RAsclyf6DUsS8RS3QlJSU+p0lAixPt/HuuU
 +Ro2gM9+AW+Qzpyh/8ham5D1Jo8vXzmQTotOs5vPYD1Af1/ezmTadOIj+
 MQQSbW3rtk4k65PAUUCeyUjqfg0uazs7AfGyjWzZjI/3hqlp7VzCiKiQH
 8vW3cS0e4ptaNXqJ+dHUBXdHk50xu3o4nvhz4mP2kf18xZLOwHljbmYBy
 lw/IaCI+36Gnt343vPjiJxbCqQVHtYalhkOBICp2eh/oZVbuQmKYQyMW1 A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="387916661"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; d="scan'208";a="387916661"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2023 19:22:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="752860813"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; d="scan'208";a="752860813"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2023 19:22:17 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, thuth@redhat.com,
 akrowiak@linux.ibm.com, pasic@linux.ibm.com, jjherne@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, borntraeger@linux.ibm.com,
 aik@ozlabs.ru, eric.auger@redhat.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, qemu-s390x@nongnu.org
Subject: [PATCH 0/3] vfio: memory leak fix and code cleanup
Date: Mon,  9 Oct 2023 10:20:45 +0800
Message-Id: <20231009022048.35475-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
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

Hi,

This trivial patchset fixes a incremental memory leak in rare case,
and some cleanup on ap/ccw.

This patchset is based on vfio-next.

Thanks
Zhenzhong

Zhenzhong Duan (3):
  vfio/pci: Fix a potential memory leak in vfio_listener_region_add
  vfio/ap: Remove pointless apdev variable
  vfio/ccw: Remove redundant definition of TYPE_VFIO_CCW

 hw/vfio/ap.c                | 9 +++------
 hw/vfio/common.c            | 2 +-
 include/hw/s390x/vfio-ccw.h | 2 --
 3 files changed, 4 insertions(+), 9 deletions(-)

-- 
2.34.1


