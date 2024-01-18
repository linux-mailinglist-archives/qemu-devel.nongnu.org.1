Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B5A831B85
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 15:38:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQTWs-0004xw-Ck; Thu, 18 Jan 2024 09:38:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rQTWd-0004uj-3L
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 09:37:47 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rQTWV-0004Sm-Ch
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 09:37:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705588659; x=1737124659;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=8/+g3OdWXcDG5ncCrIfNkXVwOEiBgYQqrPPfXHUH510=;
 b=WCeQHY4dlByTVejP7YD2Nq80txJtJpq9YbAdX4XkcyD3O4qDG9so0L8O
 3XYOvuqBfIWUnyHVzhL8kpdjQ0c/bCklP80tQhucb+tt/rGzi5xj3Tbxd
 1ip+6K7Pom9gCkKv9OBO1u/WauOWsLDXLOWtVhCO5d7WwBRG0EdONiJWJ
 SlSricySmiYp0yuBPAysJIkhU2xZtDlvJthwm9CBgW/dEJIMDqBZSo9Zz
 l3dZ7MlQqWU/7tJW5MeXUqOrsmmzEzxcUxho5XnSFgE+k79OF/YJrNezy
 W96QPNH4HCZw7knxs2IZsug9RIbr0sWgMMraqzDyOyqAQDHPV/W+qbpBn A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="19057019"
X-IronPort-AV: E=Sophos;i="6.05,203,1701158400"; d="scan'208";a="19057019"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jan 2024 06:36:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,203,1701158400"; 
   d="scan'208";a="329230"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orviesa005.jf.intel.com with ESMTP; 18 Jan 2024 06:36:06 -0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
Cc: qemu-devel@nongnu.org, Xiaoling Song <xiaoling.song@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 0/8] tests/unit/test-smp-parse.c: Add more CPU topology test
 cases
Date: Thu, 18 Jan 2024 22:48:49 +0800
Message-Id: <20240118144857.2124034-1-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=198.175.65.9;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
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

Hi list,

Currently, test-smp-parse lacks the following cases:
* The case to cover drawer and book parameters parsing in -smp.
* The case to cover the full topology (with total 7 levels) to ensure
  that the topology-related calculations are correct.
* The case to check smp_props.has_clusters of MachineClass.

Thus, add the above cases to improve test coverage.

In addition, people is trying to bump max_cpus to 4096 for PC machine
[1]. Without considering other changes, it's only a matter of time
before the maximum CPUs is raised. Therefore, aslo bump max_cpus to 4096
in -smp related test cases as a start.

[1]: https://lore.kernel.org/qemu-devel/20231208122611.32311-1-anisinha@redhat.com/

Regards,
Zhao

---
Zhao Liu (8):
  tests/unit/test-smp-parse.c: Use CPU number macros in invalid topology
    case
  tests/unit/test-smp-parse.c: Bump max_cpus to 4096
  tests/unit/test-smp-parse.c: Make test cases aware of the book/drawer
  tests/unit/test-smp-parse.c: Test "books" parameter in -smp
  tests/unit/test-smp-parse.c: Test "drawers" parameter in -smp
  tests/unit/test-smp-parse.c: Test "drawers" and "books" combination
    case
  tests/unit/test-smp-parse.c: Test the full 7-levels topology hierarchy
  tests/unit/test-smp-parse.c: Test smp_props.has_clusters

 tests/unit/test-smp-parse.c | 515 ++++++++++++++++++++++++++++++++++--
 1 file changed, 494 insertions(+), 21 deletions(-)

-- 
2.34.1


