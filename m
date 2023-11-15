Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B14B97EBDCB
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 08:21:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3ACt-0000zP-1P; Wed, 15 Nov 2023 02:21:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1r3ACk-0000pj-95
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 02:20:54 -0500
Received: from mgamail.intel.com ([192.55.52.115])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1r3ACi-00055Q-Dg
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 02:20:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700032852; x=1731568852;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=NSwmIu8UsZHitrm84OISXkxJVRD1Uex17Zz6ujuxL34=;
 b=fSiNaxo/G6vUc5mD9H1i3SLieOFCqNXLP00Nrq4tlR3Fkw3xA7JIJDnU
 ylck71EiAvDcxDC3/XxmCC0aiToHWmG7zShfhb30QswIl2IGXSK+OXqhA
 IwTKqNJH799VkmhWmKXHkRf3QG+nnMTPzZLViGID9ZYrFITmcK+nzeRej
 MqTDUC02avL8gJ/ulz23lKkEESL+rdc91AAVbDyaSqjygw3tIeYelunFg
 MuM4ITA2Ed384HpLwAUUmdTPclFRMtpepBeT4wKLxHI05BvordpHn/LY6
 rjLKaNEGhkQRZIqxxDT8PbyW5I0M0ebtwfNYX1LAL+1jDoo1+NlZprf9N w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="390623218"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; d="scan'208";a="390623218"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Nov 2023 23:20:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="714799922"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; d="scan'208";a="714799922"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orsmga003.jf.intel.com with ESMTP; 14 Nov 2023 23:20:37 -0800
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
Subject: [PATCH v3 41/70] i386/tdx: Don't initialize pc.rom for TDX VMs
Date: Wed, 15 Nov 2023 02:14:50 -0500
Message-Id: <20231115071519.2864957-42-xiaoyao.li@intel.com>
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

For TDX, the address below 1MB are entirely general RAM. No need to
initialize pc.rom memory region for TDs.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
This is more as a workaround of the issue that for q35 machine type, the
real memslot update (which requires memslot deletion )for pc.rom happens
after tdx_init_memory_region. It leads to the private memory ADD'ed
before get lost. I haven't work out a good solution to resolve the
order issue. So just skip the pc.rom setup to avoid memslot deletion.
---
 hw/i386/pc.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index cf0afc15a558..91d8243e1dd6 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -43,6 +43,7 @@
 #include "sysemu/xen.h"
 #include "sysemu/reset.h"
 #include "kvm/kvm_i386.h"
+#include "kvm/tdx.h"
 #include "hw/xen/xen.h"
 #include "qapi/qmp/qlist.h"
 #include "qemu/error-report.h"
@@ -1036,16 +1037,18 @@ void pc_memory_init(PCMachineState *pcms,
     /* Initialize PC system firmware */
     pc_system_firmware_init(pcms, rom_memory);
 
-    option_rom_mr = g_malloc(sizeof(*option_rom_mr));
-    memory_region_init_ram(option_rom_mr, NULL, "pc.rom", PC_ROM_SIZE,
-                           &error_fatal);
-    if (pcmc->pci_enabled) {
-        memory_region_set_readonly(option_rom_mr, true);
+    if (!is_tdx_vm()) {
+        option_rom_mr = g_malloc(sizeof(*option_rom_mr));
+        memory_region_init_ram(option_rom_mr, NULL, "pc.rom", PC_ROM_SIZE,
+                            &error_fatal);
+        if (pcmc->pci_enabled) {
+            memory_region_set_readonly(option_rom_mr, true);
+        }
+        memory_region_add_subregion_overlap(rom_memory,
+                                            PC_ROM_MIN_VGA,
+                                            option_rom_mr,
+                                            1);
     }
-    memory_region_add_subregion_overlap(rom_memory,
-                                        PC_ROM_MIN_VGA,
-                                        option_rom_mr,
-                                        1);
 
     fw_cfg = fw_cfg_arch_create(machine,
                                 x86ms->boot_cpus, x86ms->apic_id_limit);
-- 
2.34.1


