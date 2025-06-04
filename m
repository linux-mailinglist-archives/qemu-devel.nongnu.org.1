Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B1EACDD55
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Jun 2025 13:59:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMmkx-0005ET-1z; Wed, 04 Jun 2025 07:58:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uMmku-0005E5-R2; Wed, 04 Jun 2025 07:58:04 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uMmkt-0000nv-0N; Wed, 04 Jun 2025 07:58:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749038283; x=1780574283;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=rfwYVDGlNpbzEzjq775sd9js/uc2F1Sn7IF6JJk8KZM=;
 b=B1DAmIMmplz9yq1Pn+MZDbOp7d+BU9ZOZm7djDuU91uoDNbspiv48lK6
 JqA0kEL3WFDp2yN8fLtnxdnX6XFf0KPDXUsZC8flpizEdIl7H9PBS9hD4
 Y/c00WUzs/CHcHFG0DQGsGuwO/tBDgIpW9I3lCMIaVuNNLHZ847BqlKr/
 c8GkfVMM+JdNB9GEGTpNoOHr3Lx6rClJLmKaytcvoJq2ahQ9ZskmlyUNf
 PcqI0881h3ujW8t5huZcwK2oC3Zim1cDBGSF0/tHqakCp3yAhVdQhK2I1
 h1cRe6qjpQ+lv+4Q+mRRuyk+KMmYAYMapjG1wkEo9a4nXsRaJd5MIDOfe g==;
X-CSE-ConnectionGUID: BUq6P3dsS/qVFQoBu5qv4A==
X-CSE-MsgGUID: PbpjoLvlRsmUuKaQah3MqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="54915388"
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; d="scan'208";a="54915388"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2025 04:58:01 -0700
X-CSE-ConnectionGUID: JVKkhhfTRQmFMYHAETW9Yw==
X-CSE-MsgGUID: foIAhaxjTRmHCouE/9Ix1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; d="scan'208";a="150048321"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2025 04:57:58 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: chao.p.peng@intel.com, david@redhat.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs)
Subject: [PATCH v2 5/5] hw/riscv/riscv-iommu: Remove definition of
 RISCVIOMMU[Pci|Sys]Class
Date: Wed,  4 Jun 2025 19:54:00 +0800
Message-Id: <20250604115400.98905-6-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250604115400.98905-1-zhenzhong.duan@intel.com>
References: <20250604115400.98905-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

RISCVIOMMUPciClass and RISCVIOMMUSysClass are defined with missed
parent class, this may lead to corruption of parent class fields.

It's lucky enough that parent_realize and parent_phases are not
initialized or used until now, so just remove the definitions.
They can be added back when really necessary.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/riscv/iommu.h   | 6 ++----
 hw/riscv/riscv-iommu-pci.c | 6 ------
 hw/riscv/riscv-iommu-sys.c | 6 ------
 3 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/include/hw/riscv/iommu.h b/include/hw/riscv/iommu.h
index b03339d75c..8a8acfc3f0 100644
--- a/include/hw/riscv/iommu.h
+++ b/include/hw/riscv/iommu.h
@@ -30,14 +30,12 @@ typedef struct RISCVIOMMUState RISCVIOMMUState;
 typedef struct RISCVIOMMUSpace RISCVIOMMUSpace;
 
 #define TYPE_RISCV_IOMMU_PCI "riscv-iommu-pci"
-OBJECT_DECLARE_TYPE(RISCVIOMMUStatePci, RISCVIOMMUPciClass, RISCV_IOMMU_PCI)
+OBJECT_DECLARE_SIMPLE_TYPE(RISCVIOMMUStatePci, RISCV_IOMMU_PCI)
 typedef struct RISCVIOMMUStatePci RISCVIOMMUStatePci;
-typedef struct RISCVIOMMUPciClass RISCVIOMMUPciClass;
 
 #define TYPE_RISCV_IOMMU_SYS "riscv-iommu-device"
-OBJECT_DECLARE_TYPE(RISCVIOMMUStateSys, RISCVIOMMUSysClass, RISCV_IOMMU_SYS)
+OBJECT_DECLARE_SIMPLE_TYPE(RISCVIOMMUStateSys, RISCV_IOMMU_SYS)
 typedef struct RISCVIOMMUStateSys RISCVIOMMUStateSys;
-typedef struct RISCVIOMMUSysClass RISCVIOMMUSysClass;
 
 #define FDT_IRQ_TYPE_EDGE_LOW 1
 
diff --git a/hw/riscv/riscv-iommu-pci.c b/hw/riscv/riscv-iommu-pci.c
index 1f44eef74e..cdb4a7a8f0 100644
--- a/hw/riscv/riscv-iommu-pci.c
+++ b/hw/riscv/riscv-iommu-pci.c
@@ -68,12 +68,6 @@ typedef struct RISCVIOMMUStatePci {
     RISCVIOMMUState  iommu;   /* common IOMMU state */
 } RISCVIOMMUStatePci;
 
-struct RISCVIOMMUPciClass {
-    /*< public >*/
-    DeviceRealize parent_realize;
-    ResettablePhases parent_phases;
-};
-
 /* interrupt delivery callback */
 static void riscv_iommu_pci_notify(RISCVIOMMUState *iommu, unsigned vector)
 {
diff --git a/hw/riscv/riscv-iommu-sys.c b/hw/riscv/riscv-iommu-sys.c
index 74e76b94a5..e34d00aef6 100644
--- a/hw/riscv/riscv-iommu-sys.c
+++ b/hw/riscv/riscv-iommu-sys.c
@@ -53,12 +53,6 @@ struct RISCVIOMMUStateSys {
     uint8_t *msix_pba;
 };
 
-struct RISCVIOMMUSysClass {
-    /*< public >*/
-    DeviceRealize parent_realize;
-    ResettablePhases parent_phases;
-};
-
 static uint64_t msix_table_mmio_read(void *opaque, hwaddr addr,
                                      unsigned size)
 {
-- 
2.34.1


