Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B1582BB21
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 07:02:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOAbN-0004gr-Jc; Fri, 12 Jan 2024 01:01:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <binbin.wu@linux.intel.com>)
 id 1rOAbH-0004gE-0S
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 01:01:03 -0500
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <binbin.wu@linux.intel.com>)
 id 1rOAbD-0001Y8-Ub
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 01:01:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705039260; x=1736575260;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=CFaXaJE8pqhFzAfuqNSjwEDriCGzZfa0L5Y2u7P2GR8=;
 b=Koi+8jWa+A+gX4h3rsy2RCnQGXnqZtHwjv67iSoCthvkN2l1UP8Q/ltF
 BF/Qgy7KQBmwYmkgxa88dPX/6FpOaQuQnsl8FAW3K0BLJpfnwJYq603s8
 /KstMbD6x6gmRDlDWOZXb716Q4fjRzaE2LmCuKkuK1TayaMlbXJtq9ozF
 uubPnF3vqqpoW/Gb6gX2/GzawtOsVo8Yp8bISNpqNbeWxKSg9ECiAQsbi
 egrk4pk0QxewBkuvbv9FseIJ0ycy1HrCugrMsBShyaWhz6jYE5yIVe4K5
 0r8JwofzwaAgIUfSWcbcGVJAZFD9MCN1PLR93Bbu5ZkaT99i9HA8YQ1OJ A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="5815748"
X-IronPort-AV: E=Sophos;i="6.04,188,1695711600"; 
   d="scan'208";a="5815748"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jan 2024 22:00:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="873274692"
X-IronPort-AV: E=Sophos;i="6.04,188,1695711600"; d="scan'208";a="873274692"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO
 binbinwu-mobl.sh.intel.com) ([10.238.2.99])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jan 2024 22:00:46 -0800
From: Binbin Wu <binbin.wu@linux.intel.com>
To: qemu-devel@nongnu.org,
	kvm@vger.kernel.org
Cc: pbonzini@redhat.com, xiaoyao.li@intel.com, chao.gao@intel.com,
 robert.hu@linux.intel.com, binbin.wu@linux.intel.com
Subject: [PATCH v4 0/2] Add support for LAM in QEMU
Date: Fri, 12 Jan 2024 14:00:40 +0800
Message-Id: <20240112060042.19925-1-binbin.wu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=198.175.65.11;
 envelope-from=binbin.wu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.467,
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

Linear-address masking (LAM) [1], modifies the checking that is applied to
*64-bit* linear addresses, allowing software to use of the untranslated
address bits for metadata and masks the metadata bits before using them as
linear addresses to access memory.

When the feature is virtualized and exposed to guest, it can be used for 
efficient
address sanitizers (ASAN) implementation and for optimizations in JITs and 
virtual machines.

The KVM patch series can be found in [2].

[1] Intel ISE https://cdrdv2.intel.com/v1/dl/getContent/671368
    Chapter Linear Address Masking (LAM)
[2] https://lore.kernel.org/kvm/20230913124227.12574-1-binbin.wu@linux.intel.com

---
Changelog
v4:
- Add a reviewed-by from Xiaoyao for patch 1.
- Mask out LAM bit on CR4 if vcpu doesn't support LAM in cpu_x86_update_cr4() (Xiaoyao)

v3:
- https://lists.gnu.org/archive/html/qemu-devel/2023-07/msg04160.html

Binbin Wu (1):
  target/i386: add control bits support for LAM

Robert Hoo (1):
  target/i386: add support for LAM in CPUID enumeration

 target/i386/cpu.c    | 2 +-
 target/i386/cpu.h    | 9 ++++++++-
 target/i386/helper.c | 4 ++++
 3 files changed, 13 insertions(+), 2 deletions(-)


base-commit: f614acb7450282a119d85d759f27eae190476058
-- 
2.25.1


