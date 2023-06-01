Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D51B7196C3
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 11:22:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4eU3-0007sA-W2; Thu, 01 Jun 2023 05:20:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1q4eU2-0007rp-1l
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 05:20:38 -0400
Received: from mga04.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1q4eU0-0004ef-3r
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 05:20:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685611236; x=1717147236;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=WHkyX9GWNOzTZG7CXpnECaBcnWEAHbLbVQtf0ltwM1g=;
 b=lNwee8dx3jNnR1o7coi5RgDa0eVn0C90+b/pOrD5wlhquNbLJmwmbsZz
 Sc/B27ncYCD5BjDFLftTKH6R1RY9mC3f910qbgGmwabXDWFx0TrY4Yepg
 BLniFC/I78rUsk7YJq3F7Fp2LizA9h6KFwy6MVQBT6aK8w2ocU0c6hJuB
 IqwdMZQDZqUTRDzT8EDj2pGxgVT/ngoT3TI9gk+Xbx/JRIO/mUW5n/4GD
 DFPUKS/oDJirF6ObMh1F5K71p1VTRTg9brN4aCQeFYhKgsGxWpcxiiBi2
 e/Yoo2c/bwNroEXHoyGgBKkkRdj8Y6DbJZDYjfZuLwx+ss5uCAVaWxfjE A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="354359861"
X-IronPort-AV: E=Sophos;i="6.00,209,1681196400"; d="scan'208";a="354359861"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2023 02:20:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="953995680"
X-IronPort-AV: E=Sophos;i="6.00,209,1681196400"; d="scan'208";a="953995680"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.28])
 by fmsmga006.fm.intel.com with ESMTP; 01 Jun 2023 02:20:23 -0700
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Cc: qemu-devel@nongnu.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 0/3] hw/smbios: Cleanup topology related variables
Date: Thu,  1 Jun 2023 17:29:49 +0800
Message-Id: <20230601092952.1114727-1-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.55.52.120;
 envelope-from=zhao1.liu@linux.intel.com; helo=mga04.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
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

This is my v2 patch series based on c76e7652c786 ("Revert 'python/qmp/
protocol: add open_with_socket()'").

Compared with v1 [1], v2 uses the different ways to calculate
threads_per_socket and cores_per_socket, and add the sanity check to
ensure consistency of results between these 2 ways, which can help us
not miss any future change of cpu topology.


Introduction
------------

This patchset is split from my previous hybrid topology RFC [2] for
easier review.

There are three places for topology-related cleanup:

1. Fix the use of smp.cores.

   The meaning of CPU topology members in MachineState.smp has changed
   since 003f230e37d7 ("machine: Tweak the order of topology members in
   struct CpuTopology"), but the use of smp.cores based on the original
   semantics (the number of cores in one package) has not been updated,
   so here is a cleanup.

2. Consolidate the use of MachineState.smp.

   The socket calculation can be simplified by directly using the
   MachineState.smp.sockets.

3. Fix thread count in type4.

   I also found that the definition of thread count in type4 doesn't
   match the spec (smbios 3.0.0) and cleaned it up as well.

[1]: https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg07228.html
[2]: https://mail.gnu.org/archive/html/qemu-devel/2023-02/msg03205.html


Regards,
Zhao
---
Changelog:

Since v1:
 * Rename cpus_per_socket to threads_per_socket.
 * Calculate cores_per_socket in a different way from
   threads_per_socket.
 * Add the sanity check to ensure consistency of results between these 2
   ways.

---
Zhao Liu (3):
  hw/smbios: Fix smbios_smp_sockets caculation
  hw/smbios: Fix thread count in type4
  hw/smbios: Fix core count in type4

 hw/smbios/smbios.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

-- 
2.34.1


