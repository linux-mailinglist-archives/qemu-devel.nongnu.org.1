Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9BC769CA2
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 18:34:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQVpe-0002vI-R8; Mon, 31 Jul 2023 12:33:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qQVpJ-00027I-MI
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 12:33:03 -0400
Received: from [134.134.136.126] (helo=mgamail.intel.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qQVpH-0001Fx-W7
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 12:32:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1690821175; x=1722357175;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=KrHq5Q0AGZhu0U92WRZt5YMhM+0kmJOGaYAi4j7AhxI=;
 b=fx6f3JGq2KS0LXKh+2HSMJ1YQEK8jBzR7zpisq0dB0yR35SGvDe5hEE5
 n8AD1YCesiyhh6c8D/QDwi3WMxWwVPwYJuFIDC22hnd8M6WWWmBYJuOL6
 YBJD2yr8754nnapqKCc2nwm76C5T27Z3Q2ukvVReE++SvBklXEniKJnhq
 U/3L2JVzjbd8jRiihTnM7ABrYeyq/AYHjDBY546Mr/5hzEzGsiShjCk+1
 Uy4TCj2fyLC9mcP7P884mQ9grbj/J+nkBYXpgoQKGPZjuPpDEMy5CTlZI
 oiWFQ0ExhJi2Q9p3EsxkH/XCXDVgF4ppPzHwo13sf5CHOt/kX4EUctU+X A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="353993444"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; d="scan'208";a="353993444"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2023 09:25:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="757984123"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; d="scan'208";a="757984123"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.46])
 by orsmga008.jf.intel.com with ESMTP; 31 Jul 2023 09:25:15 -0700
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
Subject: [RFC PATCH 06/19] i386/pc: Drop pc_machine_kvm_type()
Date: Mon, 31 Jul 2023 12:21:48 -0400
Message-Id: <20230731162201.271114-7-xiaoyao.li@intel.com>
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

pc_machine_kvm_type() was introduced by commit e21be724eaf5 ("i386/xen:
add pc_machine_kvm_type to initialize XEN_EMULATE mode") to do Xen
specific initialization by utilizing kvm_type method.

commit eeedfe6c6316 ("hw/xen: Simplify emulated Xen platform init")
moves the Xen specific initialization to pc_basic_device_init().

There is no need to keep the PC specific kvm_type() implementation
anymore. On the other hand, later patch will implement kvm_type()
method for all x86/i386 machines to support KVM_X86_SW_PROTECTED_VM.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
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


