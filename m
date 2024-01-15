Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F54A82D622
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 10:37:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPJOA-0002rX-Dm; Mon, 15 Jan 2024 04:36:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rPJO7-0002rH-GX
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 04:36:11 -0500
Received: from mgamail.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rPJO3-00082h-H8
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 04:36:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705311367; x=1736847367;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=yUPoyDwmgDpk4vzQZr8FNwvtLjL9n2SabEr72j6S6QM=;
 b=VJLGxy1MoEXlU1D17+jj64I8RqrTcT+6St39sy/PnoVHReK38SPsO64U
 o8v2MEyDTCfNYgNmOsLgO+nzwjmYgK/SHCf3iGhFflifGKS1sRBo5GfcR
 B0E1JMdfbqb5LcKk96Xopy8MR74bx+XXIOzzwTXwcvwfpQ3a92JcfmwwK
 wZjOCNzkgWzlCm+TtGb4lBdiG3pzzAPiS7Vccfp+ld3ajarra/sxrKsmr
 BU3NE0VHviuNX2r55KrYbhi0gdIVeSrrPTOoe+as8sYRdjQsRuuNQ9oGV
 ZlGBbugLS2EF0iGmaCOs5pRHmxY7MZPSjB4oiWx/tS3dwiclYiQ+3jzBL w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="398439696"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; d="scan'208";a="398439696"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2024 01:36:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="1030594134"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; d="scan'208";a="1030594134"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmsmga006.fm.intel.com with ESMTP; 15 Jan 2024 01:36:02 -0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 00/11] hw/core: Cleanup and reorder headers
Date: Mon, 15 Jan 2024 17:48:41 +0800
Message-Id: <20240115094852.3597165-1-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.55.52.120;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.758,
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

Identify unused headers by full compilation (tested by "./configure" and
then "make") and reorder headers in alphabetical order.

In addition, update a file entry in MAINTAINERS file.

Zhao Liu (11):
  MAINTAINERS: Update hw/core/cpu.c entry
  hw/core: Cleanup unused included headers in cpu-common.c
  hw/core: Reorder included headers in cpu-common.c
  hw/core: Reorder included headers in cpu-sysemu.c
  hw/core: Cleanup unused included headers in machine-qmp-cmds.c
  hw/core: Cleanup unused included header in machine.c
  hw/core: Reorder included header in machine.c
  hw/core: Cleanup unnecessary included header in null-machine.c
  hw/core: Reorder included headers in null-machine.c
  hw/core: Cleanup unused included headers in numa.c
  hw/core: Reorder included headers in numa.c

 MAINTAINERS                |  3 ++-
 hw/core/cpu-common.c       | 17 ++++++-----------
 hw/core/cpu-sysemu.c       |  3 ++-
 hw/core/machine-qmp-cmds.c |  4 +---
 hw/core/machine.c          | 22 +++++++++++-----------
 hw/core/null-machine.c     |  6 +++---
 hw/core/numa.c             | 20 +++++++-------------
 7 files changed, 32 insertions(+), 43 deletions(-)

-- 
2.34.1


