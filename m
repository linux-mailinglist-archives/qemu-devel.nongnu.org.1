Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B247E1FED
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 12:25:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzxTR-0006lW-1E; Mon, 06 Nov 2023 06:08:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzxTB-0006Y8-GC
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:08:37 -0500
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzxT9-0005CT-Dc
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:08:37 -0500
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-507962561adso5645149e87.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 03:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699268913; x=1699873713; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pKMRzxqRYnKl/hVlIV0E2OCjWVD0Ib40S0FzpaLqDMw=;
 b=NKSYDOvuhkJsddQPlbYAg46fie7ZY7IY5Ht9U/fAf10ILiDj/rBGdwnxqJ+xTGdY3L
 oA5YZUrKsTEfFCzewum3zugwX7+BujAHKPuZHNDvpSbR1eYrQpxMv3/L8MzY3Jiej9MW
 tzlsN+BmMUYWjnPeJXDqklmLQq3XgCH4dtqzku8tYhAcucRYv8KhbISavJwuOgID4kyz
 1kCWBo3kT4NRdP0uxFxnhyEQtiVpxee/vGYAJwFwVqBTjx/RxQSFVexM1qiLGAH6aiKd
 apP2Da7X0FQleXSp88WP7pSIn7Fb9zu/VlnqL3EPKiboBVXR6DrfYNUlHN7Ny8i6PnnG
 v1EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699268913; x=1699873713;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pKMRzxqRYnKl/hVlIV0E2OCjWVD0Ib40S0FzpaLqDMw=;
 b=TX38Wh4AnD1Fjkh97+cSO3PHxhYiSdTh1Zw+1jqA7KXfc42xTKbSy2H0LbWQjApX7D
 s9ZYJsCu/JsfB5yXkmelaa3ybmW3frZcOQu2oVE96nZGnWulImueIhhzrjGU3XXRU1od
 BSgRGhuUp+kM58oQjXz2HZDciKR0Vf6OPLU2Qdg2AndMeOeOMMNJCI315vgp0OtOW9V7
 cPYh56bHZdFYyzHbBM7yVG6VwRPTr1QwJzje92c0AUnFq67UE2adi6REizOqgrhAa/C+
 HfsD6kRTYYQhn0YQvlkV7ywMBWZaA5C/JxCCIdXqghSdXdcSD8sgRaYNE2nF0TUn/6r1
 1NWw==
X-Gm-Message-State: AOJu0YwqZFMBJsxPn1XULcPyiL+eMMZs1tCcL48sNrZfQs5UVs+bu1VM
 g2k9C6fXw+0eplWNGLPR92Iteg88hNtY2Vi3R1Q=
X-Google-Smtp-Source: AGHT+IGMI9IHWBGUOo6/TSzJ7f5lWu5csZyUwrcaXQuq2CyxKG8+98G9h0M8RSeKlrf4DHh1XI1+uQ==
X-Received: by 2002:ac2:5e6d:0:b0:504:4165:54ab with SMTP id
 a13-20020ac25e6d000000b00504416554abmr19292506lfr.56.1699268913486; 
 Mon, 06 Nov 2023 03:08:33 -0800 (PST)
Received: from m1x-phil.lan (176-131-220-199.abo.bbox.fr. [176.131.220.199])
 by smtp.gmail.com with ESMTPSA id
 k8-20020a05600c1c8800b004081a011c0esm11883242wms.12.2023.11.06.03.08.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 Nov 2023 03:08:33 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-s390x@nongnu.org, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Xiaoyao Li <xiaoyao.li@Intel.com>,
 Babu Moger <babu.moger@amd.com>, Yongwei Ma <yongwei.ma@intel.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 43/60] hw/i386: Fix comment style in topology.h
Date: Mon,  6 Nov 2023 12:03:15 +0100
Message-ID: <20231106110336.358-44-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231106110336.358-1-philmd@linaro.org>
References: <20231106110336.358-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

For function comments in this file, keep the comment style consistent
with other files in the directory.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Yanan Wang <wangyanan55@huawei.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@Intel.com>
Reviewed-by: Babu Moger <babu.moger@amd.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Tested-by: Yongwei Ma <yongwei.ma@intel.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20231024090323.1859210-2-zhao1.liu@linux.intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/i386/topology.h | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
index 380cb27ded..d4eeb7ab82 100644
--- a/include/hw/i386/topology.h
+++ b/include/hw/i386/topology.h
@@ -24,7 +24,8 @@
 #ifndef HW_I386_TOPOLOGY_H
 #define HW_I386_TOPOLOGY_H
 
-/* This file implements the APIC-ID-based CPU topology enumeration logic,
+/*
+ * This file implements the APIC-ID-based CPU topology enumeration logic,
  * documented at the following document:
  *   Intel® 64 Architecture Processor Topology Enumeration
  *   http://software.intel.com/en-us/articles/intel-64-architecture-processor-topology-enumeration/
@@ -41,7 +42,8 @@
 
 #include "qemu/bitops.h"
 
-/* APIC IDs can be 32-bit, but beware: APIC IDs > 255 require x2APIC support
+/*
+ * APIC IDs can be 32-bit, but beware: APIC IDs > 255 require x2APIC support
  */
 typedef uint32_t apic_id_t;
 
@@ -58,8 +60,7 @@ typedef struct X86CPUTopoInfo {
     unsigned threads_per_core;
 } X86CPUTopoInfo;
 
-/* Return the bit width needed for 'count' IDs
- */
+/* Return the bit width needed for 'count' IDs */
 static unsigned apicid_bitwidth_for_count(unsigned count)
 {
     g_assert(count >= 1);
@@ -67,15 +68,13 @@ static unsigned apicid_bitwidth_for_count(unsigned count)
     return count ? 32 - clz32(count) : 0;
 }
 
-/* Bit width of the SMT_ID (thread ID) field on the APIC ID
- */
+/* Bit width of the SMT_ID (thread ID) field on the APIC ID */
 static inline unsigned apicid_smt_width(X86CPUTopoInfo *topo_info)
 {
     return apicid_bitwidth_for_count(topo_info->threads_per_core);
 }
 
-/* Bit width of the Core_ID field
- */
+/* Bit width of the Core_ID field */
 static inline unsigned apicid_core_width(X86CPUTopoInfo *topo_info)
 {
     return apicid_bitwidth_for_count(topo_info->cores_per_die);
@@ -87,8 +86,7 @@ static inline unsigned apicid_die_width(X86CPUTopoInfo *topo_info)
     return apicid_bitwidth_for_count(topo_info->dies_per_pkg);
 }
 
-/* Bit offset of the Core_ID field
- */
+/* Bit offset of the Core_ID field */
 static inline unsigned apicid_core_offset(X86CPUTopoInfo *topo_info)
 {
     return apicid_smt_width(topo_info);
@@ -100,14 +98,14 @@ static inline unsigned apicid_die_offset(X86CPUTopoInfo *topo_info)
     return apicid_core_offset(topo_info) + apicid_core_width(topo_info);
 }
 
-/* Bit offset of the Pkg_ID (socket ID) field
- */
+/* Bit offset of the Pkg_ID (socket ID) field */
 static inline unsigned apicid_pkg_offset(X86CPUTopoInfo *topo_info)
 {
     return apicid_die_offset(topo_info) + apicid_die_width(topo_info);
 }
 
-/* Make APIC ID for the CPU based on Pkg_ID, Core_ID, SMT_ID
+/*
+ * Make APIC ID for the CPU based on Pkg_ID, Core_ID, SMT_ID
  *
  * The caller must make sure core_id < nr_cores and smt_id < nr_threads.
  */
@@ -120,7 +118,8 @@ static inline apic_id_t x86_apicid_from_topo_ids(X86CPUTopoInfo *topo_info,
            topo_ids->smt_id;
 }
 
-/* Calculate thread/core/package IDs for a specific topology,
+/*
+ * Calculate thread/core/package IDs for a specific topology,
  * based on (contiguous) CPU index
  */
 static inline void x86_topo_ids_from_idx(X86CPUTopoInfo *topo_info,
@@ -137,7 +136,8 @@ static inline void x86_topo_ids_from_idx(X86CPUTopoInfo *topo_info,
     topo_ids->smt_id = cpu_index % nr_threads;
 }
 
-/* Calculate thread/core/package IDs for a specific topology,
+/*
+ * Calculate thread/core/package IDs for a specific topology,
  * based on APIC ID
  */
 static inline void x86_topo_ids_from_apicid(apic_id_t apicid,
@@ -155,7 +155,8 @@ static inline void x86_topo_ids_from_apicid(apic_id_t apicid,
     topo_ids->pkg_id = apicid >> apicid_pkg_offset(topo_info);
 }
 
-/* Make APIC ID for the CPU 'cpu_index'
+/*
+ * Make APIC ID for the CPU 'cpu_index'
  *
  * 'cpu_index' is a sequential, contiguous ID for the CPU.
  */
-- 
2.41.0


