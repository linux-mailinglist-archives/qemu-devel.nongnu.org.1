Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA1B7EBE0F
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 08:27:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3AEr-0007rO-89; Wed, 15 Nov 2023 02:23:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1r3AEa-0007gX-Q2
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 02:22:54 -0500
Received: from mgamail.intel.com ([192.55.52.115])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1r3AEY-0005LS-V5
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 02:22:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700032966; x=1731568966;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=vhVcnJA235Fj2gwGFH0mC11AUNmdkNpBg9xHCT6QPd4=;
 b=JknWKILmBo7EK3s+BC9x2skldrzwJhU9wSSb3xNZFdgSQBV7MJoUMyn6
 DDyUL5TMbCNbw0bVbNxAJ+2j3uYw7ww3cJic13VSnvqxTu6uKXktTVYYa
 fAqZTquwWKucyEzNNGpQuxs/3P6WbMd74FdeLhlu0E5gYsjzLmtsZWoz4
 li3Pu2Hp6r40UrGadlj2ivsOiTmTXf0kyNps61Q88RwBPAy7xIn1oUvdy
 znsKWc6e8ruvnZFpP9q8w6F1XQy/2ueVlmc3/cxA2q5h0DalAcY68sP90
 G+nUWd90ZKhneo63rMbb5eo1VUQnB+lv3q5s3yQGCO1exMArmIFcKIzbj A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="390623480"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; d="scan'208";a="390623480"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Nov 2023 23:22:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="714800296"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; d="scan'208";a="714800296"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orsmga003.jf.intel.com with ESMTP; 14 Nov 2023 23:22:39 -0800
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
Subject: [PATCH v3 55/70] i386/tdx: Limit the range size for MapGPA
Date: Wed, 15 Nov 2023 02:15:04 -0500
Message-Id: <20231115071519.2864957-56-xiaoyao.li@intel.com>
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

If the range for TDG.VP.VMCALL<MapGPA> is too large, process the limited
size and return retry error.  It's bad for VMM to take too long time,
e.g. second order, with blocking vcpu execution.  It results in too many
missing timer interrupts.

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/kvm/tdx.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index b17258f17fd0..96a10b0bb190 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -1061,12 +1061,16 @@ static hwaddr tdx_shared_bit(X86CPU *cpu)
     return (cpu->phys_bits > 48) ? BIT_ULL(51) : BIT_ULL(47);
 }
 
+/* 64MB at most in one call. What value is appropriate? */
+#define TDX_MAP_GPA_MAX_LEN     (64 * 1024 * 1024)
+
 static void tdx_handle_map_gpa(X86CPU *cpu, struct kvm_tdx_vmcall *vmcall)
 {
     hwaddr shared_bit = tdx_shared_bit(cpu);
     hwaddr gpa = vmcall->in_r12 & ~shared_bit;
     bool private = !(vmcall->in_r12 & shared_bit);
     hwaddr size = vmcall->in_r13;
+    bool retry = false;
     int ret = 0;
 
     vmcall->status_code = TDG_VP_VMCALL_INVALID_OPERAND;
@@ -1085,12 +1089,25 @@ static void tdx_handle_map_gpa(X86CPU *cpu, struct kvm_tdx_vmcall *vmcall)
         return;
     }
 
+    if (size > TDX_MAP_GPA_MAX_LEN) {
+        retry = true;
+        size = TDX_MAP_GPA_MAX_LEN;
+    }
+
     if (size > 0) {
         ret = kvm_convert_memory(gpa, size, private);
     }
 
     if (!ret) {
-        vmcall->status_code = TDG_VP_VMCALL_SUCCESS;
+        if (retry) {
+            vmcall->status_code = TDG_VP_VMCALL_RETRY;
+            vmcall->out_r11 = gpa + size;
+            if (!private) {
+                vmcall->out_r11 |= shared_bit;
+            }
+        } else {
+            vmcall->status_code = TDG_VP_VMCALL_SUCCESS;
+        }
     }
 }
 
-- 
2.34.1


