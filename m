Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C0A979F93B
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 05:54:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgdPn-0001kv-9Q; Wed, 13 Sep 2023 23:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qgdPl-0001YM-2D
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 23:53:13 -0400
Received: from mgamail.intel.com ([134.134.136.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qgdPi-0000r7-Lo
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 23:53:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1694663590; x=1726199590;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=h2VTCw5i0cKuV38BdOMgzq2DUKXjm2pDKAxaCdcmMTA=;
 b=g1R2EO5V9iUP2br22YMAbqYL8wgukS57TUib01liyJpEGvTT1kn0RztG
 5LffrE4Tge9BnbOdEj8GjXBHWahTW66snEHWSP7SIHWsaomhMX9/qQlME
 qBArX4JUcSzk9ZNjLLc5QRd97l6aIBwY6g96HNzoG5gpAfX8Hg24prGe3
 PEHSOT0M67xCrojTBqoWTF5Ou+NIuGsiVKMFm/44jD6O+K4Fey7UAsyk0
 kk+3Q8+Uimq8XER45y46GaluC1QVkqU9lbdryBLKlD9za3l0f6+CkAKCB
 0pOH1kz+tme7b8ButvoN8eFFftCMB+f9jLXdNztnaO1ehcAuTMKnTpH4t A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="381528608"
X-IronPort-AV: E=Sophos;i="6.02,144,1688454000"; d="scan'208";a="381528608"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Sep 2023 20:52:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="814500731"
X-IronPort-AV: E=Sophos;i="6.02,144,1688454000"; d="scan'208";a="814500731"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmsmga004.fm.intel.com with ESMTP; 13 Sep 2023 20:52:54 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, xiaoyao.li@intel.com,
 Michael Roth <michael.roth@amd.com>, isaku.yamahata@gmail.com,
 Sean Christopherson <seanjc@google.com>, Claudio Fontana <cfontana@suse.de>
Subject: [RFC PATCH v2 21/21] i386: Disable SMM mode for X86_SW_PROTECTED_VM
Date: Wed, 13 Sep 2023 23:51:17 -0400
Message-Id: <20230914035117.3285885-22-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230914035117.3285885-1-xiaoyao.li@intel.com>
References: <20230914035117.3285885-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.24; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/kvm/sw-protected-vm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/i386/kvm/sw-protected-vm.c b/target/i386/kvm/sw-protected-vm.c
index f47ac383e1dd..65347067aa03 100644
--- a/target/i386/kvm/sw-protected-vm.c
+++ b/target/i386/kvm/sw-protected-vm.c
@@ -34,10 +34,18 @@ static MemoryListener kvm_x86_sw_protected_vm_memory_listener = {
 int sw_protected_vm_kvm_init(MachineState *ms, Error **errp)
 {
     SwProtectedVm *spvm = SW_PROTECTED_VM(OBJECT(ms->cgs));
+    X86MachineState *x86ms = X86_MACHINE(ms);
 
     memory_listener_register(&kvm_x86_sw_protected_vm_memory_listener,
                              &address_space_memory);
 
+    if (x86ms->smm == ON_OFF_AUTO_AUTO) {
+        x86ms->smm = ON_OFF_AUTO_OFF;
+    } else if (x86ms->smm == ON_OFF_AUTO_ON) {
+        error_setg(errp, "X86_SW_PROTECTED_VM doesn't support SMM");
+        return -EINVAL;
+    }
+
     spvm->parent_obj.ready = true;
     return 0;
 }
-- 
2.34.1


