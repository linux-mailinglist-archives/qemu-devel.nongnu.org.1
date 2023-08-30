Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6532B78D3B3
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 09:45:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbFrg-0007iD-Hr; Wed, 30 Aug 2023 03:43:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1qbFrd-0007i5-En
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 03:43:45 -0400
Received: from mgamail.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1qbFra-0003NR-M5
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 03:43:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1693381422; x=1724917422;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=FRaUx7ks4KWShp+iZDmtc1kxKAj9MJEgz0diyhGQ83k=;
 b=dfguh9O2qbHizYVI7dLQ6XHi+A9AnHZsAztOLDjauOgU80p5rtQ1NQ+V
 GZhRjq51BpIjHALMyLjgK/rGm8Ad5m2DLGD9hhwSl8y0Xn1PyeZFgZ5pf
 4tDQFFLRUVsbXCgqGSIzz+LYb5Q6wc0VKzgFQNmYisb+8nBC2D9HJ2UCf
 DwnV1by5vIXCVuPC/ufCK5YmrwGubfqENM/uLFF2VNiDxLd0Jw7d/KPz7
 /3Vmw+HLd4kijY/kv+/hnLGgRSK7L2DX4MJGJ5uyrVohLSi7hoegFA1+2
 vlw+1VtSQkwS+q8qQE2WgHsNPVn0AtaoimXBuaes/uW/FLU2ZUKAl7GuQ Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="374480057"
X-IronPort-AV: E=Sophos;i="6.02,212,1688454000"; d="scan'208";a="374480057"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2023 00:43:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="809027339"
X-IronPort-AV: E=Sophos;i="6.02,212,1688454000"; d="scan'208";a="809027339"
Received: from st-server.bj.intel.com ([10.240.193.102])
 by fmsmga004.fm.intel.com with ESMTP; 30 Aug 2023 00:43:28 -0700
From: Tao Su <tao1.su@linux.intel.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	xiaoyao.li@intel.com,
	tao1.su@linux.intel.com
Subject: [PATCH] target/i386: Add support for AMX-COMPLEX in CPUID enumeration
Date: Wed, 30 Aug 2023 15:43:24 +0800
Message-Id: <20230830074324.84059-1-tao1.su@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.55.52.120;
 envelope-from=tao1.su@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Latest Intel platform GraniteRapids-D introduces AMX-COMPLEX, which adds
two instructions to perform matrix multiplication of two tiles containing
complex elements and accumulate the results into a packed single precision
tile.

AMX-COMPLEX is enumerated via CPUID.(EAX=7,ECX=1):EDX[bit 8]. Add the CPUID
definition for AMX-COMPLEX, AMX-COMPLEX will be enabled automatically when
using '-cpu host' and KVM advertises AMX-COMPLEX to userspace.

Signed-off-by: Tao Su <tao1.su@linux.intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
KVM part of advertising AMX-COMPLEX CPUID bit already has been applied to
kvm-x86 misc.

[1/1] KVM: x86: Advertise AMX-COMPLEX CPUID to userspace
      https://github.com/kvm-x86/linux/commit/99b668545356
---
 target/i386/cpu.c | 2 +-
 target/i386/cpu.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 00f913b638..24ee67b42d 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -980,7 +980,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         .feat_names = {
             NULL, NULL, NULL, NULL,
             "avx-vnni-int8", "avx-ne-convert", NULL, NULL,
-            NULL, NULL, NULL, NULL,
+            "amx-complex", NULL, NULL, NULL,
             NULL, NULL, "prefetchiti", NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index a6000e93bd..fbb05eace5 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -930,6 +930,8 @@ uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
 #define CPUID_7_1_EDX_AVX_VNNI_INT8     (1U << 4)
 /* AVX NE CONVERT Instructions */
 #define CPUID_7_1_EDX_AVX_NE_CONVERT    (1U << 5)
+/* AMX COMPLEX Instructions */
+#define CPUID_7_1_EDX_AMX_COMPLEX       (1U << 8)
 /* PREFETCHIT0/1 Instructions */
 #define CPUID_7_1_EDX_PREFETCHITI       (1U << 14)
 

base-commit: 813bac3d8d70d85cb7835f7945eb9eed84c2d8d0
-- 
2.34.1


