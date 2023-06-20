Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA9F736957
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 12:31:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBYd4-0005ye-8W; Tue, 20 Jun 2023 06:30:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qBYd1-0005xp-Mg
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 06:30:27 -0400
Received: from mga06b.intel.com ([134.134.136.31] helo=mga06.intel.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qBYcz-00023J-BE
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 06:30:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687257025; x=1718793025;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=1Wse39LDo7hK0+nVPaYo8+DNDgFHN1y5GekDfRmWNF8=;
 b=B8Jna5VAJfyYWbwvENFv0ntniXzo9Dttg0vmro6i3+BOcR9f1RKFPIDx
 /nDIyf8Ou7mUoS+DmWQ9qUaplYjx5TFq279Bn3LDkjKNi+iVQIx+RWXyc
 AxVNhK4jtK09zbLzycsOs0SfD9tBZLBGchzZEs4tuPAeD0zDraYxPia4p
 nMrkMT5l8lgGh+F6qJWd2RAY5vysJXofL0iT02BzMZCyTVJTR/OoJC6m8
 nClO+ewW0TzMkQDzs5Umm83rLuXwmN889Uuz2DuOrWlFk1OZMnpkT32zu
 ZoOxDfsce7wipu/ynUvc1K9EyEfW+8XwPTaZS37CigrVog/gdACXjTKiY A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="423488448"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; d="scan'208";a="423488448"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2023 03:30:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="714002226"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; d="scan'208";a="714002226"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.28])
 by orsmga002.jf.intel.com with ESMTP; 20 Jun 2023 03:30:17 -0700
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v3 0/4] hw/smbios: Cleanup topology related variables
Date: Tue, 20 Jun 2023 18:39:54 +0800
Message-Id: <20230620103958.3907565-1-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=134.134.136.31;
 envelope-from=zhao1.liu@linux.intel.com; helo=mga06.intel.com
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

This is my v3 patch series based on 48ab886d3da4f ("Merge tag 'pull-
target-arm-20230619' of https://git.linaro.org/people/pmaydell/qemu-arm
into staging").

Compared with v2 [1], v3 introduces 2 helpers to wrap the calculation of
threads/cores per socket so that smbios can use these 2 helpers directly
to avoid calculation error caused by missing topology changes.

Also due to the introduction of these two helpers, I involve more people
for review of this v3.


Introduction
============

This patchset is split from my previous hybrid topology RFC [2].

There are three places for topology-related cleanup:

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

   Similar to core count, v3 uses a new helper to fix this.

[1]: https://lists.gnu.org/archive/html/qemu-devel/2023-06/msg00072.html
[2]: https://mail.gnu.org/archive/html/qemu-devel/2023-02/msg03205.html


Regards,
Zhao

---
Zhao Liu (4):
  machine: Add helpers to get cores/threads per socket
  hw/smbios: Fix smbios_smp_sockets caculation
  hw/smbios: Fix thread count in type4
  hw/smbios: Fix core count in type4

 hw/smbios/smbios.c  | 16 ++++++++++------
 include/hw/boards.h | 12 ++++++++++++
 2 files changed, 22 insertions(+), 6 deletions(-)

-- 
2.34.1


