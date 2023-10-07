Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EBB7BC549
	for <lists+qemu-devel@lfdr.de>; Sat,  7 Oct 2023 09:00:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qp1Gm-00021L-L4; Sat, 07 Oct 2023 02:58:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qp1Gk-00020y-7W
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 02:58:34 -0400
Received: from mgamail.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qp1Gi-0000dY-A7
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 02:58:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1696661912; x=1728197912;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=6BDBjyX0kNotqsIS/akAnigZVh6Cv15BNMnub9Pf6hY=;
 b=Uen+lfLBdb92zGcN+2cxNQwHNzEZtxNpy87mNJ3YRA34bQreAdLNEHLm
 EPWBc8CPcyiQQYGiKWbDr1504SlFS2fcH3EZTmIbD6WEmWpiyD2o92XER
 MMm18VuJ8uSwWsf0nMlCUxGf8eznXfEYudWFmd2P/tovTw5uNub+47sfn
 Dtv/h0dEZR1AMD6zje7kxSn1HDNCAvea2qLaQVzErwaCLPg9QD5FS6GWb
 nKOBxAYrBu8GEnMt5XUgXzG3Ci3mRggybEWYb1RlkmmJIvmWJnRHHTMvS
 TPCqy0+5zCNjpHoQgdLhN76cvKYo0mHZjeFKyu/feRhHl4W7c841R/a9V Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="382766365"
X-IronPort-AV: E=Sophos;i="6.03,205,1694761200"; d="scan'208";a="382766365"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2023 23:58:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="822766048"
X-IronPort-AV: E=Sophos;i="6.03,205,1694761200"; d="scan'208";a="822766048"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmsmga004.fm.intel.com with ESMTP; 06 Oct 2023 23:58:23 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>,
 David Woodhouse <dwmw@amazon.co.uk>, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH] i386/pc: Drop pc_machine_kvm_type()
Date: Sat,  7 Oct 2023 02:58:19 -0400
Message-Id: <20231007065819.27498-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.120; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=1, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
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

pc_machine_kvm_type() was introduced by commit e21be724eaf5 ("i386/xen:
add pc_machine_kvm_type to initialize XEN_EMULATE mode") to do Xen
specific initialization by utilizing kvm_type method.

commit eeedfe6c6316 ("hw/xen: Simplify emulated Xen platform init")
moves the Xen specific initialization to pc_basic_device_init().

There is no need to keep the PC specific kvm_type() implementation
anymore. So we'll fallback to kvm_arch_get_default_type(), which
simply returns 0.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Isaku Yamahata <isaku.yamahata@intel.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Acked-by: David Woodhouse <dwmw@amazon.co.uk>
---
 hw/i386/pc.c         | 5 -----
 include/hw/i386/pc.h | 3 ---
 2 files changed, 8 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index aad7e8ccd1d7..41783b137b9a 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1730,11 +1730,6 @@ static void pc_machine_initfn(Object *obj)
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
index bec38cb92cf7..ad7149cb10b5 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -305,15 +305,12 @@ extern const size_t pc_compat_1_5_len;
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

base-commit: 2f3913f4b2ad74baeb5a6f1d36efbd9ecdf1057d
-- 
2.34.1


