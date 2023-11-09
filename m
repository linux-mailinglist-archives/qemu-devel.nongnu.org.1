Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5569B7E64C3
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 08:52:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0zoJ-0007Ib-Jn; Thu, 09 Nov 2023 02:50:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xin3.li@intel.com>) id 1r0zoF-0007HY-8Q
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 02:50:39 -0500
Received: from mgamail.intel.com ([192.55.52.43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xin3.li@intel.com>) id 1r0zo9-0001o2-5A
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 02:50:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1699516233; x=1731052233;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=sFrdaYDqHcmeMwI+r91s4Pu9byCxYPzQ4VEuUXb9rxI=;
 b=LL3aUutqosdjmjV2p4RDcAy8oDfy4sjsrDDw7HMo3SlV0rsrWsW7Y3he
 W6xgchJC65E64EdVUO7fefQ2QuKu53GUnh5V2wiqqFjeM2TMnyLyxuvGG
 X4/L8qyw4rwSbMExPKJY1DY9uJVrrpOgSEmPxzCyiTkAkGDD49IewehRr
 84oNdhNSoMPklGRCIeVQsKCSiQg/2XOyQjwTfRuEWkRSGuKR7FpBtbMm7
 7XJ8Sf21H7pJ13qxKYw29pudlQGmDKXKPn0+AsJUSAHCrHGOiLar06nQw
 iU9m2TnmqGhBgOthDt6ocV0kO/EivIAcXjolbqfkYzWu6d1C6hOnmrnP7 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="476165122"
X-IronPort-AV: E=Sophos;i="6.03,288,1694761200"; d="scan'208";a="476165122"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Nov 2023 23:50:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="763329260"
X-IronPort-AV: E=Sophos;i="6.03,288,1694761200"; d="scan'208";a="763329260"
Received: from unknown (HELO fred..) ([172.25.112.68])
 by orsmga002.jf.intel.com with ESMTP; 08 Nov 2023 23:50:21 -0800
From: Xin Li <xin3.li@intel.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, richard.henderson@linaro.org, pbonzini@redhat.com,
 eduardo@habkost.net, seanjc@google.com, chao.gao@intel.com, hpa@zytor.com,
 xiaoyao.li@intel.com, weijiang.yang@intel.com
Subject: [PATCH v3 0/6] target/i386: add support for FRED
Date: Wed,  8 Nov 2023 23:20:06 -0800
Message-ID: <20231109072012.8078-1-xin3.li@intel.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.43; envelope-from=xin3.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Intel VMX architecture is extended to run FRED guests, and the changes
are majorly:
1) New VMCS fields for FRED context management, which includes two new
   event data VMCS fields, eight new guest FRED context VMCS fields and
   eight new host FRED context VMCS fields.
2) VMX nested-Exception support for proper virtualization of stack
   levels introduced with FRED architecture.

Search for the latest FRED spec in most search engines with this search pattern:

  site:intel.com FRED (flexible return and event delivery) specification

The counterpart KVM patch set is at:
https://lore.kernel.org/kvm/20231108183003.5981-1-xin3.li@intel.com/T/#m77876e22876f41c5ec677c0834a46113a4987d31


---
Changelog
v3:
- Add WRMSRNS as a baseline feature for FRED.
- Add the secondary VM exit controls MSR.
- Add FRED VMX controls to VM exit/entry feature words and
  scripts/kvm/vmxcap.
- Do not set/get FRED SSP0 MSR, i.e. PL0_SSP MSR, with FRED, leave it to
  KVM CET.

v2:
- Add VMX nested-exception support to scripts/kvm/vmxcap (Paolo Bonzini).
- Move FRED MSRs from basic x86_cpu part to .subsections part (Weijiang Yang).


Xin Li (6):
  target/i386: add support for FRED in CPUID enumeration
  target/i386: mark CR4.FRED not reserved
  target/i386: add the secondary VM exit controls MSR
  target/i386: add support for VMX FRED controls
  target/i386: enumerate VMX nested-exception support
  target/i386: Add get/set/migrate support for FRED MSRs

 scripts/kvm/vmxcap    | 13 ++++++++++++
 target/i386/cpu.c     | 15 ++++++++++---
 target/i386/cpu.h     | 42 ++++++++++++++++++++++++++++++++++++-
 target/i386/kvm/kvm.c | 49 +++++++++++++++++++++++++++++++++++++++++++
 target/i386/machine.c | 28 +++++++++++++++++++++++++
 5 files changed, 143 insertions(+), 4 deletions(-)


base-commit: a3c3aaa846ad61b801e7196482dcf4afb8ba34e4
-- 
2.42.0


