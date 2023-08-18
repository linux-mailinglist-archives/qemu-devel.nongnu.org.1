Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 82593780DB9
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 16:13:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX05s-0004zw-JX; Fri, 18 Aug 2023 10:04:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qWwGg-0004uP-3s
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 05:59:46 -0400
Received: from mgamail.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qWwGF-0000In-J2
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 05:59:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1692352759; x=1723888759;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=uKwQoSbXr//1D14dA3RTbpiv2x0ORbeCziyXZilF0wo=;
 b=P7Tos/xo38a/HeiKyuLOjcMO+PP7u4inZzvKgy39k/SfFasacOQWjdJq
 cU+MyjAF9yaIY42yDK1+/oQVv5i5H9jn132DGx2I+QylwBVzI9qSUIgul
 20+P5xWhhkF01yqGU5XtXBMVZvfztzwz0qeh3gxxrGMcaHR/MRAnXbsWf
 2VQ3ypu9Lg1b4zQ2/TcvLtVdexVJygi8iBAG/442Hh1BVv2soKB/vWddI
 d0sI4PuDCgH8t/eqyNi6wqQ9JFqdvOKmELHV9BOB9wUSdqLZgFjgORkgI
 jAhzEQG70TE1BMYlpBBvFMrwUyDy5Nb+YKUDTxENLEMPQwWMkfO9Ax5TS A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="371966724"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; d="scan'208";a="371966724"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2023 02:58:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="849235532"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; d="scan'208";a="849235532"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.46])
 by fmsmga002.fm.intel.com with ESMTP; 18 Aug 2023 02:58:16 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Eduardo Habkost <eduardo@habkost.net>, Laszlo Ersek <lersek@redhat.com>,
 xiaoyao.li@intel.com, Isaku Yamahata <isaku.yamahata@gmail.com>,
 erdemaktas@google.com, Chenyi Qiang <chenyi.qiang@intel.com>
Subject: [PATCH v2 45/58] i386/tdx: Limit the range size for MapGPA
Date: Fri, 18 Aug 2023 05:50:28 -0400
Message-Id: <20230818095041.1973309-46-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818095041.1973309-1-xiaoyao.li@intel.com>
References: <20230818095041.1973309-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.120; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.021,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index 0c43c1f7759f..ced55be506d1 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -994,12 +994,16 @@ static hwaddr tdx_shared_bit(X86CPU *cpu)
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
@@ -1018,12 +1022,25 @@ static void tdx_handle_map_gpa(X86CPU *cpu, struct kvm_tdx_vmcall *vmcall)
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


