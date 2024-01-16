Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B8182EA1B
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 08:35:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPdxm-0000NL-7b; Tue, 16 Jan 2024 02:34:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rPdxV-0008UX-9j
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 02:34:06 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rPdxR-000469-5G
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 02:34:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705390441; x=1736926441;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=WyZ+iwNbCP783imzu9dZEKxLynpHrwAVFr/ycd/qN0Y=;
 b=O4IQyzUr8jU52WeVzYiNVDOrBe/KqeEn1I6cOJKjaFkeDdGvkOiXOrIR
 AcF+VrNpvUNePuyv4+kA9v0rX8nBurGOSdf5LrnpDqBPWb6sjS8LqclnA
 vkPIL/Oc414wJRr7HhskpCiTKY287Gtyr0o4ZR20uxy57AXmxno5jfzAl
 fErtKxmp547P4/ZqqqGmpdeXiCCKZhHXNV4MBo5jNabSDpiNLmlASjzZ0
 7goG68lndTxDoke3VZWYdb21SUu8UzmQZi9BMP15nO5KzGpKbGdaP/Bqt
 zjBlW+pBkNuuUWXMlf3hzyhlzEVS6KrxXqIZEj3rKSoiLvB3gi82uY0Rf w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="6875706"
X-IronPort-AV: E=Sophos;i="6.04,198,1695711600"; 
   d="scan'208";a="6875706"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2024 23:33:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="854266392"
X-IronPort-AV: E=Sophos;i="6.04,198,1695711600"; d="scan'208";a="854266392"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmsmga004.fm.intel.com with ESMTP; 15 Jan 2024 23:33:50 -0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 0/9] hw/core: Cleanup and reorder headers
Date: Tue, 16 Jan 2024 15:46:38 +0800
Message-Id: <20240116074647.3644821-1-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=198.175.65.13;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.531,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
then "make") and manually checking if it is a direct inclusion.

Then reorder headers in alphabetical order.

In addition, update a file entry in MAINTAINERS file.

---
Changelog:

v1: Per Peter and Philippe's comments in v1, keep directly included
    headers to avoid implicit header inclusions [1].

[1]: https://lore.kernel.org/qemu-devel/06d4179f-76b8-42f0-b147-f4bc2d1f06bd@linaro.org/#t

---
Zhao Liu (9):
  MAINTAINERS: Update hw/core/cpu.c entry
  hw/core: Cleanup unused included headers in cpu-common.c
  hw/core: Reorder included headers in cpu-common.c
  hw/core: Reorder included headers in cpu-sysemu.c
  hw/core: Cleanup unused included header in machine-qmp-cmds.c
  hw/core: Reorder included header in machine.c
  hw/core: Reorder included headers in null-machine.c
  hw/core: Cleanup unused included headers in numa.c
  hw/core: Reorder included headers in numa.c

 MAINTAINERS                |  3 ++-
 hw/core/cpu-common.c       | 17 +++++++----------
 hw/core/cpu-sysemu.c       |  3 ++-
 hw/core/machine-qmp-cmds.c |  2 +-
 hw/core/machine.c          | 21 +++++++++++----------
 hw/core/null-machine.c     |  5 +++--
 hw/core/numa.c             | 22 ++++++++++------------
 7 files changed, 36 insertions(+), 37 deletions(-)

-- 
2.34.1


