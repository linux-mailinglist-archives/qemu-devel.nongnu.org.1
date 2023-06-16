Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9F07325D6
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Jun 2023 05:24:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qA03a-0000Co-O3; Thu, 15 Jun 2023 23:23:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1qA03Y-0000CM-7I
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 23:23:24 -0400
Received: from mga04.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1qA03V-0002DE-Sr
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 23:23:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1686885801; x=1718421801;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=rlNTsVCaatfIFBVH1l3umSPwm8ZAZWtGZY47EXMH0p0=;
 b=Zpn2jaYZYGghUyZlc4UuNYfnwM+Zvjy0ys5hLfQVRSn5tZ+MG+Iz498E
 ablsMCRJuy5+v+KLMakAqlh0CzUHa/WCCPYokd0o48ZhyvhDRtp1Xq/vu
 LLiDXkFl+iVfs9tlDsod5DnzuddIaeAtXYxE7jZpmtZZi+DC3rojguKu7
 n+6+iA7WF8OUAh3fLgiqHnqO7U5Lk4HshCPDEsWA6e1qg3erpXIDtG2gm
 a4rlLPvPhCPzBDYoQjt33dxPsxn3jMk11VNwRjxuOsrlPD0/UPD8Nq+39
 pxz29KmtQ83ke6B3MZeoD1ikVj5VXoyiL2pufds7WmXdIFXM7AbfONOsH w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="357979145"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; d="scan'208";a="357979145"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jun 2023 20:23:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="715845976"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; d="scan'208";a="715845976"
Received: from st-server.bj.intel.com ([10.240.193.102])
 by fmsmga007.fm.intel.com with ESMTP; 15 Jun 2023 20:23:15 -0700
From: Tao Su <tao1.su@linux.intel.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, xiaoyao.li@intel.com, lei4.wang@intel.com,
 qian.wen@intel.com, imammedo@redhat.com, tao1.su@linux.intel.com
Subject: [PATCH 0/7] Add new CPU model EmeraldRapids and GraniteRapids
Date: Fri, 16 Jun 2023 11:23:04 +0800
Message-Id: <20230616032311.19137-1-tao1.su@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.55.52.120;
 envelope-from=tao1.su@linux.intel.com; helo=mga04.intel.com
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

This patch series mainly updates SapphireRapids CPU model and adds
new CPU model EmeraldRapids and GraniteRapids.

Bit 13 (ARCH_CAP_FBSDP_NO), bit 14 (ARCH_CAP_FBSDP_NO) and bit 15
(ARCH_CAP_PSDP_NO) of MSR_IA32_ARCH_CAPABILITIES are enumerated starting
from latest SapphireRapids, which are missed in current SapphireRapids
CPU model, so add a new version for SapphireRapids CPU model to expose
these bits.

Add EmeraldRapids CPU model to this series, since EmeraldRapids also
enumerates these bits. The original patch of EmeraldRapids CPU model is
in [1].

GraniteRapids is Intel's successor to EmeraldRapids, an Intel 3 process
microarchitecture for enthusiasts and servers, which adds new features
based on SapphireRapids and EmeraldRapids.

[1]
https://lore.kernel.org/qemu-devel/20230515025308.1050277-1-qian.wen@intel.com/

Lei Wang (1):
  target/i386: Add few security fix bits in ARCH_CAPABILITIES into
    SapphireRapids CPU model

Qian Wen (1):
  target/i386: Add new CPU model EmeraldRapids

Tao Su (5):
  target/i386: Add FEAT_7_1_EDX to adjust feature level
  target/i386: Add support for MCDT_NO in CPUID enumeration
  target/i386: Allow MCDT_NO if host supports
  target/i386: Add new bit definitions of MSR_IA32_ARCH_CAPABILITIES
  target/i386: Add new CPU model GraniteRapids

 target/i386/cpu.c     | 303 +++++++++++++++++++++++++++++++++++++++++-
 target/i386/cpu.h     |   8 ++
 target/i386/kvm/kvm.c |   5 +
 3 files changed, 314 insertions(+), 2 deletions(-)


base-commit: 7efd65423ab22e6f5890ca08ae40c84d6660242f
-- 
2.34.1


