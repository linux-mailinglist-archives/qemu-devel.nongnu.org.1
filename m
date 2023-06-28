Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3A97412D8
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 15:46:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEVTe-0005B4-Cp; Wed, 28 Jun 2023 09:44:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qEVTc-0005Aj-B5
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 09:44:56 -0400
Received: from mga07.intel.com ([134.134.136.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qEVTZ-000885-P2
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 09:44:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687959893; x=1719495893;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=3SJPsmsN03QrP8lm8DTQ9wE5qq+rO6qVFYNMPhYSNhI=;
 b=B4ZSqAU4Soz2jk3k0RsrJUb5armLX7a4jOX+zdgRUkumN7EwlcdL8LBj
 PoKHRibbhsUTRXlz0J/E1jNa+9xkYCOW4semxn8AcnHy6Sgw+2q0Cc+4r
 qc9BqTVTEfvrERo5AL5ze0NKCsqPZSDjyikSTDSpa5Xj6HINoHWFqeuBx
 QdFjcKv1RAE4qZetVTdbjdObcMJRJHj2dYaCOzqlzZQSGnHzTgfg1NQip
 b1q/3rQ2L5OtXJOBb5a5vbPvM438lWbZdXwQk6niW0lvGCv0MeqLgeK3i
 C0MaTP3FitvBhTq2SJ8KiO/+9XVpuMhqKORXaQDPen8pm4XgDPj5t/tCJ g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="427854108"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; d="scan'208";a="427854108"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jun 2023 06:44:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="806905447"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; d="scan'208";a="806905447"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.28])
 by FMSMGA003.fm.intel.com with ESMTP; 28 Jun 2023 06:44:39 -0700
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Yongwei Ma <yongwei.ma@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v4 0/4] hw/smbios: Cleanup topology related variables
Date: Wed, 28 Jun 2023 21:54:33 +0800
Message-Id: <20230628135437.1145805-1-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=134.134.136.100;
 envelope-from=zhao1.liu@linux.intel.com; helo=mga07.intel.com
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

Hi all,

This is my v4 patch series based on b111569da9f8 ("Merge tag 'ui-pull-
request' of https://gitlab.com/marcandre.lureau/qemu into staging").

This v4 is a quick refresh to address Igor's comment in v3 [1] about the
location of the new two helpers.

About the 2 newly added helpers, they can also be used in i386 code [2].
I will follow up to do the cleanup after another i386 cluster support
patch series.


Introduction
============

This patchset is split from my previous hybrid topology RFC [3].

This patchset adds 2 new helpers to wrap the threads/cores per sockets
calculation to avoid errors caused by other modules miss topology
changes.

Additionally, there are three places for topology-related cleanup in
smbios:

1. Fix the calculation of the number of sockets.

   Due to the misuse of the smp.cpus variable and the change in the
   meaning of smp.cores, the calculation of socket number in smbios is
   incorrect. This can be fixed by using smp.sockets directly.

2. Fix core count in type4.

   The meaning of smp.cores changed so that the calculation of cores
   per socket became wrong.

   v3 introduces the helper "machine_topo_get_cores_per_socket()" to
   wrap the calculation of cores per socket. This can help other modules
   avoid calculation error caused by missing topology changes.

3. Fix thread count in type4.

   I also found that the definition of thread count in type4 doesn't
   match the spec (smbios 3.0.0) and cleaned it up as well.

   Similar to core count, also use a new helper to fix this.

[1]: https://lists.gnu.org/archive/html/qemu-devel/2023-06/msg05402.html
[2]: https://lists.gnu.org/archive/html/qemu-devel/2023-06/msg06071.html
[3]: https://mail.gnu.org/archive/html/qemu-devel/2023-02/msg03205.html


Regards,
Zhao
---
Zhao Liu (4):
  machine: Add helpers to get cores/threads per socket
  hw/smbios: Fix smbios_smp_sockets caculation
  hw/smbios: Fix thread count in type4
  hw/smbios: Fix core count in type4

 hw/core/machine-smp.c | 10 ++++++++++
 hw/smbios/smbios.c    | 16 ++++++++++------
 include/hw/boards.h   |  2 ++
 3 files changed, 22 insertions(+), 6 deletions(-)

-- 
2.34.1


