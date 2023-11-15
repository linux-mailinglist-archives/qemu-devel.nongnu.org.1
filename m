Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB407EBDD0
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 08:21:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3ACD-0006AG-Nt; Wed, 15 Nov 2023 02:20:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1r3AC6-0005it-EG
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 02:20:17 -0500
Received: from mgamail.intel.com ([192.55.52.115])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1r3AC4-0004Bh-OI
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 02:20:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700032812; x=1731568812;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=v8TW188sEZGLI1koy2qyEbj6fW8WJb8DnDVD4pa2nWQ=;
 b=BD7labzPj3sSPIkBNM0EEIIi5BAhTiTCVk022DY2ypW2Pkssd4eUM+27
 pP7DW8yeydLqxmrnwW7eSmCBbvuJzTF+cLTtHj2HGz+GczTJP6ETaFMg+
 6Xcu/92vFuqeSjHTrymPa7x75h3cJWMOraiCWIbnAsvaYvn1ipQyJl6YT
 EjWO+BhtzMkV0wyhQorCU8aLioRFiqDXhj40vgIhSN0n2KHYjYqMW8MG7
 Dpmma5kBqk4xQhnUdFIDyvefng2iVs8sDAZbEF0yF/lG1PMIP1Mg4xmzO
 afrTu3keNu8K+4tsRSB3aEmeH2aSTiZK0Sg43ai5M1CXmNlD4U5dlxxtV w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="390623088"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; d="scan'208";a="390623088"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Nov 2023 23:20:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="714799565"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; d="scan'208";a="714799565"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orsmga003.jf.intel.com with ESMTP; 14 Nov 2023 23:20:00 -0800
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
Subject: [PATCH v3 37/70] kvm/tdx: Ignore memory conversion to shared of
 unassigned region
Date: Wed, 15 Nov 2023 02:14:46 -0500
Message-Id: <20231115071519.2864957-38-xiaoyao.li@intel.com>
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

From: Isaku Yamahata <isaku.yamahata@intel.com>

TDX requires vMMIO region to be shared.  For KVM, MMIO region is the region
which kvm memslot isn't assigned to (except in-kernel emulation).
qemu has the memory region for vMMIO at each device level.

While OVMF issues MapGPA(to-shared) conservatively on 32bit PCI MMIO
region, qemu doesn't find corresponding vMMIO region because it's before
PCI device allocation and memory_region_find() finds the device region, not
PCI bus region.  It's safe to ignore MapGPA(to-shared) because when guest
accesses those region they use GPA with shared bit set for vMMIO.  Ignore
memory conversion request of non-assigned region to shared and return
success.  Otherwise OVMF is confused and panics there.

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 accel/kvm/kvm-all.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 5e862db4af41..89e7183a2738 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2942,6 +2942,18 @@ static int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
     section = memory_region_find(get_system_memory(), start, size);
     mr = section.mr;
     if (!mr) {
+        /*
+         * Ignore converting non-assigned region to shared.
+         *
+         * TDX requires vMMIO region to be shared to inject #VE to guest.
+         * OVMF issues conservatively MapGPA(shared) on 32bit PCI MMIO region,
+         * and vIO-APIC 0xFEC00000 4K page.
+         * OVMF assigns 32bit PCI MMIO region to
+         * [top of low memory: typically 2GB=0xC000000,  0xFC00000)
+         */
+        if (!to_private) {
+            ret = 0;
+        }
         return ret;
     }
 
-- 
2.34.1


