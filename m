Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1D4A77CE1
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Apr 2025 15:54:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzbwk-00035O-Az; Tue, 01 Apr 2025 09:46:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tzbuY-0000jM-2X
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 09:44:18 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tzbuW-0006ZP-2B
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 09:44:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743515052; x=1775051052;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=GpbiAevDOu7dBEajhCo3Fos/R3B4WgEf7uAd71HM9uI=;
 b=NReaV5hg0XphAAa3bbn8oj8uZlcTon3Kql7ktWm8aqdIXUg3Tvxy6wP3
 XqAH2nk33BbIi+np0HSn/adrj57qrtq+P5RCBh/AyIB8hDDD/Ka+Cz8oZ
 RFQTEEZ7ahP5rzTSQ/3b8sluuc1SXQl6VzyHR8b/1fNoB5E1cBDjRNUpU
 UYyA/59A7nuqNbtWWI5GXdbjgsS7CpoKKMVZcjeI39EiDerYviNgj2BzM
 kNT2Y4ss7ocHobIbY2n9g7N2w3WdK5DtZUXiBVawbmXEFaBHjygbBCyOA
 nD4HQqX8ItCX93+9Vzt4uuUbUXduEVxk7d2v/vCu7po+skgV9Xz0XhQ2v w==;
X-CSE-ConnectionGUID: agh/lOzoTOu5jWkdDJefFg==
X-CSE-MsgGUID: LPZTZNDNS0eevMFDP52N5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11391"; a="32433509"
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; d="scan'208";a="32433509"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2025 06:42:57 -0700
X-CSE-ConnectionGUID: GdIZvIZeQ4azEMUoy6dnpg==
X-CSE-MsgGUID: ZMAkU/4dR6S9PizJhF3uHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; d="scan'208";a="126640177"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa008.fm.intel.com with ESMTP; 01 Apr 2025 06:42:55 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH v8 42/55] cpu: Don't set vcpu_dirty when guest_state_protected
Date: Tue,  1 Apr 2025 09:01:52 -0400
Message-Id: <20250401130205.2198253-43-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250401130205.2198253-1-xiaoyao.li@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.16; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

QEMU calls kvm_arch_put_registers() when vcpu_dirty is true in
kvm_vcpu_exec(). However, for confidential guest, like TDX, putting
registers is disallowed due to guest state is protected.

Only set vcpu_dirty to true with guest state is not protected when
creating the vcpu.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
Changes in v7:
 - new patch to replace "i386/tdx: Don't get/put guest state for TDX VMs"
   in v6;
---
 accel/kvm/kvm-all.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 5835d840f3ad..9862d8ff1d38 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -466,7 +466,9 @@ int kvm_create_vcpu(CPUState *cpu)
 
     cpu->kvm_fd = kvm_fd;
     cpu->kvm_state = s;
-    cpu->vcpu_dirty = true;
+    if (!s->guest_state_protected) {
+        cpu->vcpu_dirty = true;
+    }
     cpu->dirty_pages = 0;
     cpu->throttle_us_per_full = 0;
 
-- 
2.34.1


