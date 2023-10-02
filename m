Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A705B7B4CE1
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 09:54:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnDje-0000Tx-6L; Mon, 02 Oct 2023 03:52:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xin3.li@intel.com>) id 1qnDjc-0000TH-17
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 03:52:56 -0400
Received: from mgamail.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xin3.li@intel.com>) id 1qnDjZ-0007db-Ti
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 03:52:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1696233173; x=1727769173;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=pSWoR1MlRMPnZFuNIN0WY2ctP+02pePH9fE5cmYxCCE=;
 b=UC2S950/aMTXOXBVjfdk8qH9HBUhJLQJMor2NRHhUeBtyBAs9ysjfJ0B
 Y0sUrCKmzeZlJjcDcFoGlh7vLhsJn2wwGN107KcZfTEzktdLSS96NWzEr
 mw5EtWCncPjDvsmPBojQMykraz+sct/QXBQ3ptkv784sebe0Slop4lvRn
 5AQ/bVJgYkvPvAXVZNIsd1ziB3tFZ5UyrB4z4OgpOpk+6CYAVylxdRLqo
 pCh3ibNZ/0KteizynY/PSXqVbYvyRREGHfuKCnFtaTJjpMeMLmlx97j03
 hXFEMhJNRvE/DQ0vdiEuqxi4BsMGuN1++CsuchIbIcjMp2qlZofsxjPyS Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="361975559"
X-IronPort-AV: E=Sophos;i="6.03,193,1694761200"; d="scan'208";a="361975559"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2023 00:52:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="750511621"
X-IronPort-AV: E=Sophos;i="6.03,193,1694761200"; d="scan'208";a="750511621"
Received: from unknown (HELO fred..) ([172.25.112.68])
 by orsmga002.jf.intel.com with ESMTP; 02 Oct 2023 00:52:48 -0700
From: Xin Li <xin3.li@intel.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, richard.henderson@linaro.org, pbonzini@redhat.com,
 eduardo@habkost.net, seanjc@google.com, chao.gao@intel.com, hpa@zytor.com,
 xiaoyao.li@intel.com, weijiang.yang@intel.com
Subject: [PATCH v2 0/4] target/i386: add support for FRED
Date: Mon,  2 Oct 2023 00:23:09 -0700
Message-Id: <20231002072313.17603-1-xin3.li@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.136; envelope-from=xin3.li@intel.com;
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


---
Changelog
v2:
- Add VMX nested-exception support to scripts/kvm/vmxcap (Paolo Bonzini).
- Move FRED MSRs from basic x86_cpu part to .subsections part (Weijiang Yang).


Xin Li (4):
  target/i386: add support for FRED in CPUID enumeration
  target/i386: mark CR4.FRED not reserved
  target/i386: enumerate VMX nested-exception support
  target/i386: Add get/set/migrate support for FRED MSRs

 scripts/kvm/vmxcap    |  1 +
 target/i386/cpu.c     |  7 +++++-
 target/i386/cpu.h     | 43 +++++++++++++++++++++++++++++++++-
 target/i386/kvm/kvm.c | 54 +++++++++++++++++++++++++++++++++++++++++++
 target/i386/machine.c | 29 +++++++++++++++++++++++
 5 files changed, 132 insertions(+), 2 deletions(-)

-- 
2.34.1


