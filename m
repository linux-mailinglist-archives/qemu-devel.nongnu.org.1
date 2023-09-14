Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C559679F938
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 05:54:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgdOa-0006Ac-Mz; Wed, 13 Sep 2023 23:52:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qgdOY-0005xQ-Fx
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 23:51:58 -0400
Received: from mgamail.intel.com ([134.134.136.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qgdOW-0000r7-Ob
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 23:51:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1694663516; x=1726199516;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=FG1fIIQsL7KuIyJ5EhfyBMqHsFgdwKABD8LZczmIAnc=;
 b=PyNw6cSHFQ35uOy18lfxKMIZXZPY48DxxSGc6kDgBbWPeNOCQwC9+MEB
 B5UyV/WCjfuC02zuXaOqZrmTgIadwxUdt4JbUVGqQcezggXz58tX7RVTj
 HGORQe5cuXYBtfZFIawXMzH1R2cXr6yZtW15wx7ZR02W6tt/57K1D+OkE
 kcN5cWbaAFZvAIZ0iPXR7tBqtmDV5JKABFmazWIOHVR3CUJsdaMFpY3mV
 JAdPe6oUvphdK4Axrb1l0KL3bPFvzhivQKb04x/XD/Ihn5+JBRGpkHiTt
 jDukPPlGypyhecsnImdj+ow6Xb1B8SVWB7Vk55dVavxeywkj9TlSFg/zC g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="381528393"
X-IronPort-AV: E=Sophos;i="6.02,144,1688454000"; d="scan'208";a="381528393"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Sep 2023 20:51:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="814500592"
X-IronPort-AV: E=Sophos;i="6.02,144,1688454000"; d="scan'208";a="814500592"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmsmga004.fm.intel.com with ESMTP; 13 Sep 2023 20:51:51 -0700
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
Subject: [RFC PATCH v2 07/21] i386/pc: Drop pc_machine_kvm_type()
Date: Wed, 13 Sep 2023 23:51:03 -0400
Message-Id: <20230914035117.3285885-8-xiaoyao.li@intel.com>
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

pc_machine_kvm_type() was introduced by commit e21be724eaf5 ("i386/xen:
add pc_machine_kvm_type to initialize XEN_EMULATE mode") to do Xen
specific initialization by utilizing kvm_type method.

commit eeedfe6c6316 ("hw/xen: Simplify emulated Xen platform init")
moves the Xen specific initialization to pc_basic_device_init().

There is no need to keep the PC specific kvm_type() implementation
anymore. On the other hand, later patch will implement kvm_type()
method for all x86/i386 machines to support KVM_X86_SW_PROTECTED_VM.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Isaku Yamahata <isaku.yamahata@intel.com>
---
 hw/i386/pc.c         | 5 -----
 include/hw/i386/pc.h | 3 ---
 2 files changed, 8 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 3109d5e0e035..abeadd903827 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1794,11 +1794,6 @@ static void pc_machine_initfn(Object *obj)
     cxl_machine_init(obj, &pcms->cxl_devices_state);
 }
 
-int pc_machine_kvm_type(MachineState *machine, const char *kvm_type)
-{
-    return 0;
-}
-
 static void pc_machine_reset(MachineState *machine, ShutdownCause reason)
 {
     CPUState *cs;
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index d54e8b1101e4..c98d628a76f3 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -296,15 +296,12 @@ extern const size_t pc_compat_1_5_len;
 extern GlobalProperty pc_compat_1_4[];
 extern const size_t pc_compat_1_4_len;
 
-int pc_machine_kvm_type(MachineState *machine, const char *vm_type);
-
 #define DEFINE_PC_MACHINE(suffix, namestr, initfn, optsfn) \
     static void pc_machine_##suffix##_class_init(ObjectClass *oc, void *data) \
     { \
         MachineClass *mc = MACHINE_CLASS(oc); \
         optsfn(mc); \
         mc->init = initfn; \
-        mc->kvm_type = pc_machine_kvm_type; \
     } \
     static const TypeInfo pc_machine_type_##suffix = { \
         .name       = namestr TYPE_MACHINE_SUFFIX, \
-- 
2.34.1


