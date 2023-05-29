Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA518714E7B
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 18:35:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3fpC-0003Lh-8F; Mon, 29 May 2023 12:34:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1q3fp5-0003L2-Nz
 for qemu-devel@nongnu.org; Mon, 29 May 2023 12:34:19 -0400
Received: from mga03.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1q3fp3-00075s-GZ
 for qemu-devel@nongnu.org; Mon, 29 May 2023 12:34:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685378057; x=1716914057;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=/2Jz9GmE+9VKQhEUG9DNVbWL2ZjPLMav1NlJuSKwKPc=;
 b=NZZF11uGc5lDqBhaZ1uTJFV2Cs8wFWQRWilYDxWG3Gu8Y1EU8McMuizS
 0MHV2v6tHvVyNWBWQ9VqshIPyQkqB27xp0po6MVarMxgQfkZPgFaRZc9P
 pxkBhRVTKshRHZwb24hRMHRTzYXOc6RAvN73JGmW+hi3Kiopd0xWd/rq/
 gaxFKKsKkwI2TtW/uDgQcYr5X6b8C+raHB6lO4ZbH13dfqtBWeEmPnhqG
 9ZJYG5XnKlnl055B72+RLjtTkiGbDI9v9ZCXidPrAUuewU1Gv5ZkikmAw
 BGST7/1qkWLrqZ+blzCff5k112hUP7WpbYqBfZz/pmmD1iXubl3BDVN/v A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="357991685"
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; d="scan'208";a="357991685"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2023 09:34:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="771215604"
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; d="scan'208";a="771215604"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.28])
 by fmsmga008.fm.intel.com with ESMTP; 29 May 2023 09:34:12 -0700
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Cc: qemu-devel@nongnu.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 0/3] hw/smbios: Cleanup topology related variables
Date: Tue, 30 May 2023 00:43:40 +0800
Message-Id: <20230529164343.467793-1-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=134.134.136.65;
 envelope-from=zhao1.liu@linux.intel.com; helo=mga03.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.16,
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

This patchset is split from my previous hybrid topology RFC [1] for
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

[1]: https://mail.gnu.org/archive/html/qemu-devel/2023-02/msg03205.html


Regards,
Zhao

---
Zhao Liu (3):
  hw/smbios: Fix smbios_smp_sockets caculation
  hw/smbios: Fix thread count in type4
  hw/smbios: Fix core count in type4

 hw/smbios/smbios.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

-- 
2.34.1


