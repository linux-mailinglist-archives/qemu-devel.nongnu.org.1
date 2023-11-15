Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A927EBD97
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 08:18:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3A9M-0007jO-Qt; Wed, 15 Nov 2023 02:17:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1r3A9H-0007LH-Uu
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 02:17:20 -0500
Received: from mgamail.intel.com ([192.55.52.115])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1r3A9G-0002JU-Bf
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 02:17:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700032638; x=1731568638;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2DXsVL99TAo2oH2QjWpmYGGPXjhsdpW2NL2gA0U62WE=;
 b=Ey6AqUBodF+bP+EdsyPgNK88mJEswJbpyPwqwXmOa2haxI0P/t8bHmKt
 B5DWr5k4jeUw35v1LjzGQ9Xvo3oijodXTcTJkjrH5yQQF+Cn4Ym3Uz/MO
 MXxdQX2+cgviNZnlhD8bRp4J47KliXxidQY1J1HB4heS3X3D8fu5SPQY9
 6beQNOHOMbaEflhs9y0QjH70O1DPUwSQyWXIVWaDekiJyXhQHFIWaNLGe
 H4ve9qkK+udKXB2FH/BySut0vwkdo5eXTk0WAmo7UZcutjA7w75jK9YN1
 a4rQ6rlKi9A9/PKf7gVXIPv/P7DXDhdn4RReDoLmdfiPDfsHSgAwpqxW9 g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="390622414"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; d="scan'208";a="390622414"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Nov 2023 23:17:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="714797653"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; d="scan'208";a="714797653"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orsmga003.jf.intel.com with ESMTP; 14 Nov 2023 23:17:11 -0800
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
Subject: [PATCH v3 15/70] target/i386: Parse TDX vm type
Date: Wed, 15 Nov 2023 02:14:24 -0500
Message-Id: <20231115071519.2864957-16-xiaoyao.li@intel.com>
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

TDX VM requires VM type KVM_X86_TDX_VM to be passed to
kvm_ioctl(KVM_CREATE_VM).

If tdx-guest object is specified to confidential-guest-support, like,

  qemu -machine ...,confidential-guest-support=tdx0 \
       -object tdx-guest,id=tdx0,...

it parses VM type as KVM_X86_TDX_VM.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/kvm/kvm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 2e47fda25f95..c4050cbf998e 100644
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
@@ -164,12 +165,17 @@ static int kvm_get_one_msr(X86CPU *cpu, int index, uint64_t *value);
 static const char* vm_type_name[] = {
     [KVM_X86_DEFAULT_VM] = "default",
     [KVM_X86_SW_PROTECTED_VM] = "sw-protected-vm",
+    [KVM_X86_TDX_VM] = "tdx",
 };
 
 int kvm_get_vm_type(MachineState *ms, const char *vm_type)
 {
     int kvm_type = KVM_X86_DEFAULT_VM;
 
+    if (ms->cgs && object_dynamic_cast(OBJECT(ms->cgs), TYPE_TDX_GUEST)) {
+        kvm_type = KVM_X86_TDX_VM;
+    }
+
     /*
      * old KVM doesn't support KVM_CAP_VM_TYPES and KVM_X86_DEFAULT_VM
      * is always supported
-- 
2.34.1


