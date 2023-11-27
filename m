Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 439EF7FA350
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 15:44:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7cqL-0001nn-1X; Mon, 27 Nov 2023 09:44:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1r7cqE-0001kT-Et
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 09:44:06 -0500
Received: from mgamail.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1r7cqA-0002Wv-AH
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 09:44:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1701096242; x=1732632242;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=nNZxlP/+mHM4INzMxUBLcc7CZFEB23k6h7iHf/i18vk=;
 b=lKBBAN1mZwYdmvGkMdVzu6ITRur3M70D+/rD/pFGk50/T082eZOgey5b
 2hU9RQsyeqr2uwMRC00jBDxoNW/D3o+potYJUdyQewYzIu0JoORvi5YLd
 LIP7TP1Dl9taNTwBPaxBlwlW/I6q2Y3jmqoP2WjlyuwYHSN/TUASnz1Ro
 r6fHzzDHXNwDYKvi8afpvN8ihXtRjyoEd0csw7BjPaNkNVDaDE2ubnf6x
 BUA1ySS7UdTCHKux5Jhas8skYzXiY2IW2W0opARDLASCTU81nfpth4trJ
 Watla+29CWE5OkyRi6RSgKLKK3CS2LJimXYuIixO4aU2ZlFDELuyIRVZW g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="396623361"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; d="scan'208";a="396623361"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2023 06:43:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="1099796686"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; d="scan'208";a="1099796686"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmsmga005.fm.intel.com with ESMTP; 27 Nov 2023 06:43:56 -0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 0/2] Cleanup unused included header in core.c & cluster.c
Date: Mon, 27 Nov 2023 22:56:09 +0800
Message-Id: <20231127145611.925817-1-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=134.134.136.65;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Remove unused header in core.c and cluster.c, and reorder the remaining
header files (except qemu/osdep.h) in alphabetical order.

Tested by "./configure" and then "make".

---
Zhao Liu (2):
  hw/cpu/core: Cleanup unused included header in core.c
  hw/cpu/cluster: Cleanup unused included header in cluster.c

 hw/cpu/cluster.c | 5 ++---
 hw/cpu/core.c    | 7 +++----
 2 files changed, 5 insertions(+), 7 deletions(-)

-- 
2.34.1


