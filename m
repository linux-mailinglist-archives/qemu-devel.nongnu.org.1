Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5A078F849
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 08:00:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbxBx-0003P4-Rw; Fri, 01 Sep 2023 01:59:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xin3.li@intel.com>) id 1qbxBv-0003Ke-64
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 01:59:35 -0400
Received: from mgamail.intel.com ([192.55.52.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xin3.li@intel.com>) id 1qbxBq-0003WI-MH
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 01:59:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1693547970; x=1725083970;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=t/hrJiHeoSvdETUBrJ57ogpn4shS4G0J8qmn4d9YVVs=;
 b=F+AktUOddFpFXjmLpWqs8Heg7Tf7Y0GAJickXiV6BtzNsETaJP0Obu8N
 0S53EWLA0LHpEJwDAfz0WeORMY6l+pTMrn2SZFrqsSulKFleeovqcV9xR
 8WpbSppEYpFb6bdsqBs5BPvurv0IzViw7C6BGFAc0EQMBSgXODuUbpca7
 cAa4LkpZ1PLXSMOho/S0R+W864raQRjj8I2MyLzJfjLXdRHEbdwqUak3E
 Vc5kVMUQQnqAatiAL6/RVDFRMSjr/W6GhgAOlBqodnFdB9c5lqN7w78oI
 MvsJgDQxlQXhjh0HTdl3uDyPHBPAdDCjFoRvvyh5/ro3BZQ57e7qSg3tA Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="356456628"
X-IronPort-AV: E=Sophos;i="6.02,218,1688454000"; d="scan'208";a="356456628"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2023 22:59:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="739816152"
X-IronPort-AV: E=Sophos;i="6.02,218,1688454000"; d="scan'208";a="739816152"
Received: from unknown (HELO fred..) ([172.25.112.68])
 by orsmga002.jf.intel.com with ESMTP; 31 Aug 2023 22:59:24 -0700
From: Xin Li <xin3.li@intel.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, seanjc@google.com,
 chao.gao@intel.com, hpa@zytor.com, xiaoyao.li@intel.com,
 weijiang.yang@intel.com
Subject: [PATCH 0/4] target/i386: add support for FRED
Date: Thu, 31 Aug 2023 22:30:18 -0700
Message-Id: <20230901053022.18672-1-xin3.li@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.151; envelope-from=xin3.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This patch set adds support for the Intel flexible return and event delivery
(FRED) architecture to allow Qemu to run KVM guests with FRED enabled.

The FRED architecture defines simple new transitions that change privilege
level (ring transitions). The FRED architecture was designed with the
following goals:
1) Improve overall performance and response time by replacing event delivery
   through the interrupt descriptor table (IDT event delivery) and event
   return by the IRET instruction with lower latency transitions.
2) Improve software robustness by ensuring that event delivery establishes
   the full supervisor context and that event return establishes the full
   user context.

Search for the latest FRED spec in most search engines with this search pattern:

  site:intel.com FRED (flexible return and event delivery) specification


Xin Li (4):
  target/i386: add support for FRED in CPUID enumeration
  target/i386: mark CR4.FRED not reserved
  target/i386: enumerate VMX nested-exception support
  target/i386: add live migration support for FRED

 target/i386/cpu.c     |  7 +++++-
 target/i386/cpu.h     | 40 +++++++++++++++++++++++++++++++-
 target/i386/kvm/kvm.c | 54 +++++++++++++++++++++++++++++++++++++++++++
 target/i386/machine.c | 10 ++++++++
 4 files changed, 109 insertions(+), 2 deletions(-)

-- 
2.34.1


