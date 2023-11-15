Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9C77EBE0B
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 08:26:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3AFr-0001V7-ML; Wed, 15 Nov 2023 02:24:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1r3AF6-0000pC-M2
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 02:23:21 -0500
Received: from mgamail.intel.com ([192.55.52.115])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1r3AF4-0006UX-Tk
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 02:23:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700032998; x=1731568998;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+ro+2ine6/iGzqXVJ4kIbyKXDnfwjCSieq/UEUCuaoE=;
 b=ntX2nhCTgj9Ss7l6E2pNeBAtF894jaWcoz6Iq0JBe/KHN7/1GquAgSpX
 OWb9RQKaDL+KOmkPhHiPYwiqlZGWpUaUOisyG68oIXyo2qOyQiIn9OWvP
 i+Fx+UI41ScwC5jDpBpKynoWbHbLYZHq2s3vfU+MEVSchfbMe/1HmHydC
 rmCXC3AXuialwTcomgg8bh+R644tFWtOFNjyBCzQhby/Zs2r/Bz/pPOLf
 VkH3bRQYjb3FAk40qtpwxApBLGtkpyQIhqzBWWOBTYh1B2sKbCsGnjJo1
 1JDWFUBsAxx08XtFPRUDkaEVtPB6q2Skhk5rfLmD98jf0V0IWZX62YOH5 g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="390623571"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; d="scan'208";a="390623571"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Nov 2023 23:23:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="714800368"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; d="scan'208";a="714800368"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orsmga003.jf.intel.com with ESMTP; 14 Nov 2023 23:23:10 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, xiaoyao.li@intel.com,
 Michael Roth <michael.roth@amd.com>,
 Sean Christopherson <seanjc@google.com>,
 Claudio Fontana <cfontana@suse.de>, Gerd Hoffmann <kraxel@redhat.com>,
 Isaku Yamahata <isaku.yamahata@gmail.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>
Subject: [PATCH v3 60/70] i386/tdx: Disable SMM for TDX VMs
Date: Wed, 15 Nov 2023 02:15:09 -0500
Message-Id: <20231115071519.2864957-61-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231115071519.2864957-1-xiaoyao.li@intel.com>
References: <20231115071519.2864957-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.115; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
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

TDX doesn't support SMM and VMM cannot emulate SMM for TDX VMs because
VMM cannot manipulate TDX VM's memory.

Disable SMM for TDX VMs and error out if user requests to enable SMM.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
---
 target/i386/kvm/tdx.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 23504ba3b05e..45b587ee07c2 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -686,11 +686,19 @@ static Notifier tdx_machine_done_notify = {
 
 int tdx_kvm_init(MachineState *ms, Error **errp)
 {
+    X86MachineState *x86ms = X86_MACHINE(ms);
     TdxGuest *tdx = TDX_GUEST(OBJECT(ms->cgs));
     int r = 0;
 
     ms->require_guest_memfd = true;
 
+    if (x86ms->smm == ON_OFF_AUTO_AUTO) {
+        x86ms->smm = ON_OFF_AUTO_OFF;
+    } else if (x86ms->smm == ON_OFF_AUTO_ON) {
+        error_setg(errp, "TDX VM doesn't support SMM");
+        return -EINVAL;
+    }
+
     if (!tdx_caps) {
         r = get_tdx_capabilities(errp);
         if (r) {
-- 
2.34.1


