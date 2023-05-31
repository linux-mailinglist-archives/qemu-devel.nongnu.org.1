Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E146717A82
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 10:46:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4HSw-0006NW-0Z; Wed, 31 May 2023 04:45:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1q4HQS-00026t-K4
 for qemu-devel@nongnu.org; Wed, 31 May 2023 04:43:24 -0400
Received: from mga06b.intel.com ([134.134.136.31] helo=mga06.intel.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1q4HQP-0005fJ-ED
 for qemu-devel@nongnu.org; Wed, 31 May 2023 04:43:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685522601; x=1717058601;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=+5VxqSApDTybbRqSSES1+Ai8coKoe4+HzHFHHa8plf8=;
 b=fy/HuMvIJ/fje69UnslRcGvaXK91LCpIVcT1zfVc1ELK16lyLvXjCax3
 LJjrZH39Y14f9GibeY74oNyya+Zz1enGDkB07FIKdWvrdbyNPKg8+vraC
 AEESv8mqwcnKMZe6yzP/ubDsD9cxvY0EiUldR3a4YdjFHSgvFBvow9LCA
 hnrTFXja162DmZrU5uEpipd/WkykPPfWOQ8XI3/peYWhFC3lZbX+unAqY
 K1bO8+cCGR4aO4rbxNNovjaKmPkm0N7eUSavkeGEAoZ8mezrHJXowhxBg
 YeKiNwt5dwzUFqqEOQD/ADDxIUYYVxzEWb1te7FekYWEKULXH7vKZMQ7H w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="418669228"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; d="scan'208";a="418669228"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 May 2023 01:43:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="1036956390"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; d="scan'208";a="1036956390"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.46])
 by fmsmga005.fm.intel.com with ESMTP; 31 May 2023 01:43:15 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Chenyi Qiang <chenyi.qiang@intel.com>, lei4.wang@intel.com
Subject: [PATCH v4 0/8] i386: Make Intel PT configurable 
Date: Wed, 31 May 2023 04:43:03 -0400
Message-Id: <20230531084311.3807277-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.31; envelope-from=xiaoyao.li@intel.com;
 helo=mga06.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Initial virtualization of Intel PT was added by making it as fixed
feature set of ICX's capabilities. However, it breaks the Intel PT exposure
on SPR machine because SPR has less PT capabilities of
CPUID(0x14,1):EBX[15:0].

This series aims to make Intel PT configurable that named CPU model can
define its own PT feature set and "-cpu host/max" can use host pass-through
feature set of Intel PT.

At the same time, it also ensures existing named CPU model to generate
the same PT CPUID set as before to not break live migration.

Changes in v4:
- rebase to 51bdb0b57a2d "Merge tag 'pull-tcg-20230530' of https://gitlab.com/rth7680/qemu into staging"
- cleanup Patch 6 by updating the commit message and remove unnecessary
  handlng;

v3: https://lore.kernel.org/qemu-devel/20221208062513.2589476-1-xiaoyao.li@intel.com/
- rebase to v7.2.0-rc4
- Add bit 7 and 8 of FEAT_14_0_EBX in Patch 3

v2: https://lore.kernel.org/qemu-devel/20220808085834.3227541-1-xiaoyao.li@intel.com/
Changes in v2:
- split out 3 patches (per Eduardo's comment)
- determine if the named cpu model uses default Intel PT capabilities (to
  be compatible with the old behavior) by condition that all PT feature
  leaves are all zero.

v1: https://lore.kernel.org/qemu-devel/20210909144150.1728418-1-xiaoyao.li@intel.com/


Xiaoyao Li (8):
  target/i386: Print CPUID subleaf info for unsupported feature
  target/i386/intel-pt: Fix INTEL_PT_ADDR_RANGES_NUM_MASK
  target/i386/intel-pt: Introduce FeatureWordInfo for Intel PT CPUID
    leaf 0x14
  target/i386/intel-pt: print special message for
    INTEL_PT_ADDR_RANGES_NUM
  target/i386/intel-pt: Rework/rename the default INTEL-PT feature set
  target/i386/intel-pt: Enable host pass through of Intel PT
  target/i386/intel-pt: Define specific PT feature set for
    IceLake-server, Snowridge and SapphireRapids
  target/i386/intel-pt: Access MSR_IA32_RTIT_ADDRn based on guest CPUID
    configuration

 target/i386/cpu.c     | 293 +++++++++++++++++++++++++++++++-----------
 target/i386/cpu.h     |  39 +++++-
 target/i386/kvm/kvm.c |   8 +-
 3 files changed, 261 insertions(+), 79 deletions(-)

-- 
2.34.1


