Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F434769C82
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 18:30:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQVmV-0007N6-9P; Mon, 31 Jul 2023 12:30:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qQVmP-0007MT-Rf
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 12:29:57 -0400
Received: from [134.134.136.126] (helo=mgamail.intel.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qQVmO-00008I-8p
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 12:29:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1690820996; x=1722356996;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=OqbwFxE5zjsZMZns5dcqTBrG/GaaJmBZ5rVzXVb5HAQ=;
 b=UXASUbPXsazrkQS9Srv4BUMsUVrfAn+1y/GulWeg0fV2qaMXyhW5rGc9
 AVwyjr8zILrgIP9TqWCitSGxTroB35tATmi3WSsI62De+LTrMuLQ+Hzn4
 OrBarjPtzV8ocHmG+1TFmRvmG4v3xx+n9fIIUTelqe7hY47Dtz29eIVPE
 DMdsYHa1FL+7fXP0W7hzQ6aOuuAwSMD1mhfZSTrnhuYD+9IiSwplracJf
 K9cNoXnNqPY1766YgCGzqSVIavq0OboAc3XDr7mS7OcCh9jXm9yDvGasE
 AdPHSL1WHOiqQTNHhYR36WDLDB2+yL0x8T9xufAFm6nyYw9orR3nDTXFI A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="353993657"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; d="scan'208";a="353993657"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2023 09:26:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="757984483"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; d="scan'208";a="757984483"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.46])
 by orsmga008.jf.intel.com with ESMTP; 31 Jul 2023 09:26:15 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Chao Peng <chao.p.peng@linux.intel.com>,
 Michael Roth <michael.roth@amd.com>, isaku.yamahata@gmail.com,
 xiaoyao.li@intel.com, qemu-devel@nongnu.org, kvm@vger.kernel.org
Subject: [RFC PATCH 19/19] i386: Disable SMM mode for X86_SW_PROTECTED_VM
Date: Mon, 31 Jul 2023 12:22:01 -0400
Message-Id: <20230731162201.271114-20-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230731162201.271114-1-xiaoyao.li@intel.com>
References: <20230731162201.271114-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 134.134.136.126 (failed)
Received-SPF: pass client-ip=134.134.136.126;
 envelope-from=xiaoyao.li@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RDNS_NONE=0.793,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/kvm/kvm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index a96640512dbc..62f237068a3a 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -2654,6 +2654,13 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
 
     if (x86ms->vm_type == KVM_X86_SW_PROTECTED_VM) {
         memory_listener_register(&kvm_x86_sw_protected_vm_memory_listener, &address_space_memory);
+
+        if (x86ms->smm == ON_OFF_AUTO_AUTO) {
+            x86ms->smm = ON_OFF_AUTO_OFF;
+        } else if (x86ms->smm == ON_OFF_AUTO_ON) {
+            error_report("X86_SW_PROTECTED_VM doesn't support SMM");
+            return -EINVAL;
+        }
     }
 
     if (!kvm_check_extension(s, KVM_CAP_IRQ_ROUTING)) {
-- 
2.34.1


