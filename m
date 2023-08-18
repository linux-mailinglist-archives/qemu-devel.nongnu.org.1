Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3F3780914
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 11:56:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWwBr-0003vP-CV; Fri, 18 Aug 2023 05:54:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qWwBn-0003v9-Kb
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 05:54:43 -0400
Received: from mgamail.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qWwBl-0007V6-E6
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 05:54:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1692352481; x=1723888481;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=h73zyzASLNvlG9AYCYMj6vv1Gc8rlR2ijy1Q2NU2HtU=;
 b=XWVbqKGh14b1HYPiTA216A99T3WOjF6Uouznbgybs632MLlqQJdEUs5a
 ZPY7irwmH/tl8dSQvfecSnczvVWvHd3JWTIqHOLvjDq8fwpBKflfr3aHH
 Dpfayi65B1S3Oi6nEcumstJEiWo5ysQej87V9YsZtE430cZDdbNXXF+Ms
 ga3Znz1rW8fglzk3wr2nwO4FKeHOit37LkIQMCXRwrlu3TjypRdohIUqp
 urmg6t1iFkG5cK559ZKD7N5uFCH7yGuPHw9zJi/jdlKrGCfKs/0S0gLx9
 knmHwYX7R8h5EZIisvFzCvBDNRUvWbYj17UnQsteOntRh5S5fJ2XnOq0H w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="371965562"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; d="scan'208";a="371965562"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2023 02:54:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="849234794"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; d="scan'208";a="849234794"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.46])
 by fmsmga002.fm.intel.com with ESMTP; 18 Aug 2023 02:54:35 -0700
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
Subject: [PATCH v2 03/58] target/i386: Parse TDX vm type
Date: Fri, 18 Aug 2023 05:49:46 -0400
Message-Id: <20230818095041.1973309-4-xiaoyao.li@intel.com>
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

TDX VM requires VM type KVM_X86_TDX_VM to be passed to
kvm_ioctl(KVM_CREATE_VM).

If tdx-guest object is specified to confidential-guest-support, like,

  qemu -machine ...,confidential-guest-support=tdx0 \
       -object tdx-guest,id=tdx0,...

it parses VM type as KVM_X86_TDX_VM.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/kvm/kvm.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 62f237068a3a..77f4772afe6c 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -32,6 +32,7 @@
 #include "sysemu/runstate.h"
 #include "kvm_i386.h"
 #include "sev.h"
+#include "tdx.h"
 #include "xen-emu.h"
 #include "hyperv.h"
 #include "hyperv-proto.h"
@@ -158,6 +159,7 @@ static int kvm_get_one_msr(X86CPU *cpu, int index, uint64_t *value);
 static const char* vm_type_name[] = {
     [KVM_X86_DEFAULT_VM] = "default",
     [KVM_X86_SW_PROTECTED_VM] = "sw-protected-vm",
+    [KVM_X86_TDX_VM] = "tdx",
 };
 
 int kvm_get_vm_type(MachineState *ms, const char *vm_type)
@@ -170,12 +172,18 @@ int kvm_get_vm_type(MachineState *ms, const char *vm_type)
             kvm_type = KVM_X86_DEFAULT_VM;
         } else if (!g_ascii_strcasecmp(vm_type, "sw-protected-vm")) {
             kvm_type = KVM_X86_SW_PROTECTED_VM;
-        } else {
+        } else if (!g_ascii_strcasecmp(vm_type, "tdx")) {
+            kvm_type = KVM_X86_TDX_VM;
+        }else {
             error_report("Unknown kvm-type specified '%s'", vm_type);
             exit(1);
         }
     }
 
+    if (ms->cgs && object_dynamic_cast(OBJECT(ms->cgs), TYPE_TDX_GUEST)) {
+        kvm_type = KVM_X86_TDX_VM;
+    }
+
     /*
      * old KVM doesn't support KVM_CAP_VM_TYPES and KVM_X86_DEFAULT_VM
      * is always supported
-- 
2.34.1


