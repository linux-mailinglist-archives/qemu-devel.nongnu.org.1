Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C59C5AAFEBC
	for <lists+qemu-devel@lfdr.de>; Thu,  8 May 2025 17:15:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD2pt-0004B8-T6; Thu, 08 May 2025 11:06:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uD2pk-0003lK-H2
 for qemu-devel@nongnu.org; Thu, 08 May 2025 11:06:50 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uD2pi-0007RW-HJ
 for qemu-devel@nongnu.org; Thu, 08 May 2025 11:06:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746716806; x=1778252806;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pIWAPu28XGKIr7qPx6xnPgm+joe07aUW8TauRVAgp7g=;
 b=lf2NhhR6hIRZdfajZEYaqpS1FKReDJigBy7YNfX54K8nAtozmyRAU91Q
 f6DY7yoWfp4OeVksSYwr3xWDNqiyt6R3LUVsp0TBU4ebSHDdCeG5BljWr
 7A2GFk2lKW9SN6nWEHpzy0bKFR3jq2OpiLSCxXhBpPGLnDsjZviMFrrfY
 HiEg9eemxeajbNjureEWQ3QmLu96uyRWjnDuL+KFUF5/leAsWz6yWTEn4
 XKdFRHOuQPbw6VDORyyoLayV+8yXA0gloNR1oM1Sg/3rPJxTdvhbuF7ob
 /6gzbE7OcYF7QFx1srZnv1Uu3fFX2VkHvMcVNsBP4Qg4exPIm2X7S4QZN g==;
X-CSE-ConnectionGUID: 51IKnpu8TImnPJj1mdItIw==
X-CSE-MsgGUID: bX3ItWXYSye8NGyS6SzCaQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="73888211"
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; d="scan'208";a="73888211"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2025 08:06:15 -0700
X-CSE-ConnectionGUID: fexHkJ1pQOWpS7fH0Xl8zQ==
X-CSE-MsgGUID: Bg36XUWRRn6puNEh9shJyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; d="scan'208";a="141440058"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa005.jf.intel.com with ESMTP; 08 May 2025 08:06:13 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH v9 26/55] i386/tdx: Finalize TDX VM
Date: Thu,  8 May 2025 10:59:32 -0400
Message-ID: <20250508150002.689633-27-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250508150002.689633-1-xiaoyao.li@intel.com>
References: <20250508150002.689633-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.7; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Invoke KVM_TDX_FINALIZE_VM to finalize the TD's measurement and make
the TD vCPUs runnable once machine initialization is complete.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/kvm/tdx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 31b288382fc8..b0ee50d76208 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -360,6 +360,9 @@ static void tdx_finalize_vm(Notifier *notifier, void *unused)
      */
     ram_block = tdx_guest->tdvf_mr->ram_block;
     ram_block_discard_range(ram_block, 0, ram_block->max_length);
+
+    tdx_vm_ioctl(KVM_TDX_FINALIZE_VM, 0, NULL, &error_fatal);
+    CONFIDENTIAL_GUEST_SUPPORT(tdx_guest)->ready = true;
 }
 
 static Notifier tdx_machine_done_notify = {
-- 
2.43.0


