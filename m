Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B72C7739FC
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 13:59:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTLMz-0004WA-BO; Tue, 08 Aug 2023 07:59:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qTLMx-0004VZ-7w
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 07:59:23 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qTLMs-0001et-FW
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 07:59:23 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RKs8B65jKz6J73r;
 Tue,  8 Aug 2023 19:55:38 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 12:59:14 +0100
To: <qemu-devel@nongnu.org>
CC: Gavin Shan <gshan@redhat.com>, <linuxarm@huawei.com>, James Morse
 <james.morse@arm.com>, "peter . maydell @ linaro . org"
 <peter.maydell@linaro.org>, <zhao1.liu@linux.intel.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Shameerali Kolothum
 Thodi <shameerali.kolothum.thodi@huawei.com>, Yicong Yang
 <yangyicong@huawei.com>
Subject: [RFC PATCH 4/5] hw/arm: Add MPAM emulation.
Date: Tue, 8 Aug 2023 12:57:12 +0100
Message-ID: <20230808115713.2613-5-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230808115713.2613-1-Jonathan.Cameron@huawei.com>
References: <20230808115713.2613-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Note this doesn't 'do' anything other than provide an introspection
interface.  The intent here is to support work on the Linux kernel support
and for that a functional emulation of the interface is useful.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 qapi/mpam.json           |  78 ++++
 qapi/qapi-schema.json    |   1 +
 include/hw/arm/mpam.h    |  12 +
 include/hw/arm/virt.h    |   2 +
 hw/arm/mpam-qapi-stubs.c |   9 +
 hw/arm/mpam-qapi.c       |  58 +++
 hw/arm/mpam.c            | 886 +++++++++++++++++++++++++++++++++++++++
 hw/arm/Kconfig           |   4 +
 hw/arm/meson.build       |   4 +
 qapi/meson.build         |   1 +
 10 files changed, 1055 insertions(+)

diff --git a/qapi/mpam.json b/qapi/mpam.json
new file mode 100644
index 0000000000..f4990ef96b
--- /dev/null
+++ b/qapi/mpam.json
@@ -0,0 +1,78 @@
+# -*- Mode: Python -*-
+# vim: filetype=python
+
+##
+# = ARM MPAM State Introspection
+##
+
+##
+# @MpamBm:
+##
+{ 'struct': 'MpamBm',
+  'data' : { 'words' : [ 'int' ]
+           }
+}
+
+##
+# @MpamRegs:
+#
+# Per RIS Register State
+#
+##
+{ 'struct' : 'MpamRegs',
+  'data' : { 'idr' : 'int',
+             'iidr' : 'int',
+             'aidr' : 'int',
+             'cpor-idr': 'int',
+             'ccap-idr': 'int',
+             'mbw-idr': 'int',
+             'pri-idr': 'int',
+             'partid-nrw-idr': 'int',
+             'msmon-idr': 'int',
+             'csumon-idr': 'int',
+             'mbwumon-idr': 'int',
+             'ecr': 'int',
+             'esr': 'int',
+             'cfg-part-sel': 'int',
+             'cfg-cpbm': ['MpamBm']#lazy
+          }
+}
+
+##
+# @MpamCacheInfo:
+#
+# Information about MPAM Cache MSCs
+#
+# @cpu: First CPU of the set associated with the cache
+#
+# @level: Level of cache
+#
+# @type: type of cache - make an enum
+#
+# Since: 9.0
+##
+
+{ 'struct': 'MpamCacheInfo',
+  'data' : { 'cpu' : 'int',
+             'level' : 'int',
+             'type' : 'int',
+             'regs' : ['MpamRegs']
+           }
+}
+
+##
+# @query-mpam-cache:
+#
+# Get a list of MpamInfo for all Cache Related MSC
+#
+# @level: Provide a cache level to filter against
+#
+# Returns: a list of @MpamCacheInfo describing all
+#   the MPAM cache MSC instances
+#
+# Since: 9.0
+##
+{ 'command': 'query-mpam-cache',
+  'data': { '*level': 'int' },
+  'returns' : ['MpamCacheInfo'],
+  'allow-preconfig': true }
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index 6594afba31..ea3ee75841 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -79,3 +79,4 @@
 { 'include': 'virtio.json' }
 { 'include': 'cryptodev.json' }
 { 'include': 'cxl.json' }
+{ 'include': 'mpam.json' }
diff --git a/include/hw/arm/mpam.h b/include/hw/arm/mpam.h
new file mode 100644
index 0000000000..7bd88d57bc
--- /dev/null
+++ b/include/hw/arm/mpam.h
@@ -0,0 +1,12 @@
+#ifndef _MPAM_H_
+#define _MPAM_H_
+
+#include "qom/object.h"
+#include "qapi/qapi-commands-mpam.h"
+
+#define TYPE_MPAM_MSC_MEM "mpam-msc-mem"
+#define TYPE_MPAM_MSC_CACHE "mpam-msc-cache"
+
+void mpam_cache_fill_info(Object *obj, MpamCacheInfo *info);
+
+#endif /* _MPAM_H_ */
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index e1ddbea96b..ac015a391a 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -71,6 +71,7 @@ enum {
     VIRT_SMMU,
     VIRT_UART,
     VIRT_MMIO,
+    VIRT_MPAM_MSC,
     VIRT_RTC,
     VIRT_FW_CFG,
     VIRT_PCIE,
@@ -160,6 +161,7 @@ struct VirtMachineState {
     bool ras;
     bool mte;
     bool dtb_randomness;
+    bool mpam, mpam_min_msc;
     OnOffAuto acpi;
     VirtGICType gic_version;
     VirtIOMMUType iommu;
diff --git a/hw/arm/mpam-qapi-stubs.c b/hw/arm/mpam-qapi-stubs.c
new file mode 100644
index 0000000000..40ccb7de9a
--- /dev/null
+++ b/hw/arm/mpam-qapi-stubs.c
@@ -0,0 +1,9 @@
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qapi/qapi-commands-mpam.h"
+
+MpamCacheInfoList *qmp_query_mpam_cache(bool has_level, int64_t level, Error **errp)
+{
+    return NULL;
+}
diff --git a/hw/arm/mpam-qapi.c b/hw/arm/mpam-qapi.c
new file mode 100644
index 0000000000..cf027e0da9
--- /dev/null
+++ b/hw/arm/mpam-qapi.c
@@ -0,0 +1,58 @@
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/arm/mpam.h"
+#include "qom/object.h"
+#include "qapi/qapi-commands-mpam.h"
+
+typedef struct MPAMQueryState {
+    Error **errp;
+    MpamCacheInfoList **head;
+    bool level_filter_on;
+    int level;
+} MPAMQueryState;
+
+static int mpam_query_cache(Object *obj, void *opaque)
+{
+    MPAMQueryState *state = opaque;
+    MpamCacheInfoList *infolist;
+    MpamCacheInfo *info;
+
+    if (!object_dynamic_cast(obj, TYPE_MPAM_MSC_CACHE)) {
+        return 0;
+    }
+    if (state->level_filter_on &&
+        object_property_get_uint(obj, "cache-level", state->errp) !=
+        state->level) {
+        return 0;
+    }
+
+    infolist = g_malloc0(sizeof(*infolist));
+    info = g_malloc0(sizeof(*info));
+
+    mpam_cache_fill_info(obj, info);
+
+    infolist->value = info;
+
+    *state->head = infolist;
+    state->head = &infolist->next;
+
+    return 0;
+}
+
+MpamCacheInfoList *qmp_query_mpam_cache(bool has_level, int64_t level,
+                                        Error **errp)
+{
+
+    MpamCacheInfoList *head = NULL;
+    MPAMQueryState state = {
+        .errp = errp,
+        .head = &head,
+        .level_filter_on = has_level,
+        .level = level,
+    };
+
+    object_child_foreach_recursive(object_get_root(), mpam_query_cache, &state);
+
+    return head;
+}
diff --git a/hw/arm/mpam.c b/hw/arm/mpam.c
new file mode 100644
index 0000000000..4b645efc2e
--- /dev/null
+++ b/hw/arm/mpam.c
@@ -0,0 +1,886 @@
+/*
+ * ARM MPAM emulation
+ *
+ * Copyright (c) 2023 Huawei
+ */
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/log.h"
+#include "hw/irq.h"
+#include "hw/qdev-properties.h"
+#include "hw/registerfields.h"
+#include "hw/sysbus.h"
+#include "qom/object.h"
+#include "hw/arm/mpam.h"
+
+REG64(MPAMF_IDR, 0)
+    FIELD(MPAMF_IDR, PART_ID_MAX, 0, 16)
+    FIELD(MPAMF_IDR, PMG_MAX, 16, 8)
+    FIELD(MPAMF_IDR, HAS_CCAP_PART, 24, 1)
+    FIELD(MPAMF_IDR, HAS_CPOR_PART, 25, 1)
+    FIELD(MPAMF_IDR, HAS_MBW_PART, 26, 1)
+    FIELD(MPAMF_IDR, HAS_PRI_PART, 27, 1)
+    FIELD(MPAMF_IDR, EXT, 28, 1)
+    FIELD(MPAMF_IDR, HAS_IMPL_IDR, 29, 1)
+    FIELD(MPAMF_IDR, HAS_MSMON, 30, 1)
+    FIELD(MPAMF_IDR, HAS_PARTID_NRW, 31, 1)
+    FIELD(MPAMF_IDR, HAS_RIS, 32, 1)
+    FIELD(MPAMF_IDR, NO_IMPL_PART, 36, 1)
+    FIELD(MPAMF_IDR, NO_IMPL_MSMON, 37, 1)
+    FIELD(MPAMF_IDR, HAS_EXTD_ESR, 38, 1)
+    FIELD(MPAMF_IDR, HAS_ESR, 39, 1)
+    FIELD(MPAMF_IDR, HAS_ERR_MS, 40, 1)
+    FIELD(MPAMF_IDR, SP4, 41, 1)
+    FIELD(MPAMF_IDR, HAS_ENDIS, 42, 1)
+    FIELD(MPAMF_IDR, HAS_NFU, 43, 1)
+    FIELD(MPAMF_IDR, RIS_MAX, 56, 4)
+
+REG32(MPAMF_IIDR, 0x0018)
+    FIELD(MPAMF_IIDR, IMPLEMENTER, 0, 12)
+    FIELD(MPAMF_IIDR, REVISION, 12, 4)
+    FIELD(MPAMF_IIDR, VARIANT, 16, 4)
+    FIELD(MPAMF_IIDR, PRODUCT_ID, 20, 12)
+
+REG32(MPAMF_AIDR, 0x0020)
+    FIELD(MPAMF_AIDR, ARCH_MINOR_REV, 0, 4)
+    FIELD(MPAMF_AIDR, ARCH_MAJOR_REV, 4, 4)
+
+REG32(MPAMF_IMPL_IDR, 0x0028)
+REG32(MPAMF_CPOR_IDR, 0x0030)
+    FIELD(MPAMF_CPOR_IDR, CPBM_WD, 0, 16)
+
+REG32(MPAMF_CCAP_IDR, 0x0038)
+    FIELD(MPAMF_CCAP_IDR, CMAX_WD, 0, 6)
+    FIELD(MPAMF_CCAP_IDR, CASSOC_WD, 8, 5)
+    FIELD(MPAMF_CCAP_IDR, HAS_CASSOC, 28, 1)
+    FIELD(MPAMF_CCAP_IDR, HAS_CMIN, 29, 1)
+    FIELD(MPAMF_CCAP_IDR, NO_CMAX, 30, 1)
+    FIELD(MPAMF_CCAP_IDR, HAS_CMAX_SOFTLIM, 31, 1)
+
+REG32(MPAMF_MBW_IDR, 0x0040)
+    FIELD(MPAMF_MBW_IDR, BWA_WD, 0, 6)
+    FIELD(MPAMF_MBW_IDR, HAS_MIN, 10, 1)
+    FIELD(MPAMF_MBW_IDR, HAS_MAX, 11, 1)
+    FIELD(MPAMF_MBW_IDR, HAS_PBM, 12, 1)
+    FIELD(MPAMF_MBW_IDR, HAS_PROP, 13, 1)
+    FIELD(MPAMF_MBW_IDR, WINDWR, 14, 1)
+    FIELD(MPAMF_MBW_IDR, BWPBM_WD, 16, 13)
+
+REG32(MPAMF_PRI_IDR, 0x0048)
+    FIELD(MPAMF_PRI_IDR, HAS_INTPRI, 0, 1)
+    FIELD(MPAMF_PRI_IDR, INTPRI_0_IS_LOW, 1, 1)
+    FIELD(MPAMF_PRI_IDR, INTPRI_WD, 4, 6)
+    FIELD(MPAMF_PRI_IDR, HAS_DSPRI, 16, 1)
+    FIELD(MPAMF_PRI_IDR, DSPRI_0_IS_LOW, 17, 1)
+    FIELD(MPAMF_PRI_IDR, DSPRI_WD, 20, 6)
+
+REG32(MPAMF_PARTID_NRW_IDR, 0x0050)
+    FIELD(MPAMF_PARTID_NRW_IDR, INTPARTID_MAX, 0, 16)
+
+REG32(MPAMF_MSMON_IDR, 0x080)
+    FIELD(MPAMF_MSMON_IDR, MSMON_CSU, 16, 1)
+    FIELD(MPAMF_MSMON_IDR, MSMON_MBWU, 17, 1)
+    FIELD(MPAMF_MSMON_IDR, HAS_OFLOW_SR, 28, 1)
+    FIELD(MPAMF_MSMON_IDR, HAS_OFLW_MS, 29, 1)
+    FIELD(MPAMF_MSMON_IDR, NO_OFLW_INTR, 30, 1)
+    FIELD(MPAMF_MSMON_IDR, HAS_LOCAL_CAPT_EVNT, 31, 1)
+
+REG32(MPAMF_CSUMON_IDR, 0x0088)
+    FIELD(MPAMF_CSUMON_IDR, NUM_MON, 0, 16)
+    FIELD(MPAMF_CSUMON_IDR, HAS_OFLOW_CAPT, 24, 1)
+    FIELD(MPAMF_CSUMON_IDR, HAS_CEVNT_OFLW, 25, 1)
+    FIELD(MPAMF_CSUMON_IDR, HAS_OFSR, 26, 1)
+    FIELD(MPAMF_CSUMON_IDR, HAS_OFLOW_LNKG, 27, 1)
+    FIELD(MPAMF_CSUMON_IDR, HAS_XCL, 29, 1)
+    FIELD(MPAMF_CSUMON_IDR, CSU_RO, 30, 1)
+    FIELD(MPAMF_CSUMON_IDR, HAS_CAPTURE, 31, 1)
+
+REG32(MPAMF_MBWUMON_IDR, 0x0090)
+    FIELD(MPAMF_MBWUMON_IDR, NUM_MON, 0, 16)
+    FIELD(MPAMF_MBWUMON_IDR, SCALE, 16, 5)
+    FIELD(MPAMF_MBWUMON_IDR, HAS_OFLOW_CAPT, 24, 1)
+    FIELD(MPAMF_MBWUMON_IDR, HAS_CEVNT_OFLW, 25, 1)
+    FIELD(MPAMF_MBWUMON_IDR, HAS_OFSR, 26, 1)
+    FIELD(MPAMF_MBWUMON_IDR, HAS_OFLOW_LNKG, 27, 1)
+    FIELD(MPAMF_MBWUMON_IDR, HAS_RWBW, 28, 1)
+    FIELD(MPAMF_MBWUMON_IDR, LWD, 29, 1)
+    FIELD(MPAMF_MBWUMON_IDR, HAS_LONG, 30, 1)
+    FIELD(MPAMF_MBWUMON_IDR, HAS_CAPTURE, 31, 1)
+
+REG32(MPAMF_ERR_MSI_MPAM, 0x00dc)
+REG32(MPAMF_ERR_MSI_ADDR_L, 0x00e0)
+REG32(MPAMF_ERR_MSI_ADDR_H, 0x00e4)
+REG32(MPAMF_ERR_MSI_DATA, 0x00e8)
+REG32(MPAMF_ERR_MSI_ATTR, 0x00ec)
+
+REG32(MPAMF_ECR, 0x00f0)
+    FIELD(MPAMF_ECR, INTEN, 0, 1)
+#define MPAMF_ECR_WRITE_MASK ( \
+    R_MPAMF_ECR_INTEN_MASK)
+
+REG64(MPAMF_ESR, 0x00f8)
+    FIELD(MPAMF_ESR, PARID_MON, 0, 16)
+    FIELD(MPAMF_ESR, PMG, 16, 8)
+    FIELD(MPAMF_ESR, ERR_CODE, 24, 4)
+    FIELD(MPAMF_ESR, OVRWR, 31, 1)
+    FIELD(MPAMF_ESR, RIS, 32, 4)
+
+REG32(MPAMF_CFG_PART_SEL, 0x0100)
+    FIELD(MPAMF_CFG_PART_SEL, PARTID_SEL, 0, 16)
+    FIELD(MPAMF_CFG_PART_SEL, INTERNAL, 16, 1)
+    FIELD(MPAMF_CFG_PART_SEL, RIS, 24, 4)
+#define MPAMF_CFG_PART_SEL_WRITE_MASK ( \
+    R_MPAMF_CFG_PART_SEL_PARTID_SEL_MASK | \
+    R_MPAMF_CFG_PART_SEL_INTERNAL_MASK | \
+    R_MPAMF_CFG_PART_SEL_RIS_MASK)
+
+REG32(MPAMF_MPAMCFG_CMAX, 0x0108)
+    FIELD(MPAMF_MPAMCFG_CMAX, CMAX, 0, 16)
+    FIELD(MPAMF_MPAMCFG_CMAX, SOFTLIM, 31, 1)
+#define MPAMF_MPAMCFG_CMAX_WRITE_MASK ( \
+    R_MPAMF_MPAMCFG_CMAX_CMAX_MASK | \
+    R_MPAMF_MPAMCFG_CMAX_SOFTLIM_MASK)
+
+REG32(MPAMF_MPAMCFG_CMIN, 0x0110)
+    FIELD(MPAMF_MPAMCFG_CMIN, CMIN, 0, 16)
+#define MPAMF_MPAMCFG_CMIN_WRITE_MASK ( \
+    R_MPAMF_MPAMCFG_CMIN_CMIN_MASK)
+
+REG32(MPAMF_MPAMCFG_CASSOC, 0x0118)
+    FIELD(MPAMF_MPAMCFG_CASSOC, CASSOC, 0, 16)
+#define MPAMF_MPAMCFG_CASSOC_WRITE_MASK ( \
+    R_MPAMF_MPAMCCG_CASSOC_CASSOC_MASK)
+
+REG32(MPAMF_MPAMCFG_MBW_MIN, 0x0200)
+    FIELD(MPAMF_MPAMCFG_MBW_MIN, MIN, 0, 16)
+#define MPAMF_MPAMCFG_MBW_MIN_WRITE_MASK ( \
+    R_MPAMF_MPAMCFG_MBW_MIN_MASK)
+
+REG32(MPAMF_MPAMCFG_MBW_MAX, 0x0208)
+    FIELD(MPAMF_MPAMCFG_MBW_MAX, MAX, 0, 16)
+    FIELD(MPAMF_MPAMCFG_MBW_MAX, HARDLIM, 31, 1)
+#define MPAMF_MPAMCFG_MBW_MAX_WRITE_MASK ( \
+    R_MPAMF_MPAMCFG_MBW_MAX_MAX_MASK | \
+    R_MPAMF_MPAMCFG_MBW_MAX_HARDLIM_MASK)
+
+REG32(MPAMF_MPAMCFG_WINWD, 0x0220)
+    FIELD(MPAMF_MPAMCFG_WINWD, US_FRAC, 0, 8)
+    FIELD(MPAMF_MPAMCFG_WINWD, US_INT, 8, 16)
+#define MPAMF_MPAMCFG_WINWD_WRITE_MASK ( \
+    R_MPAMF_MPAMCFG_WINWD_US_FRAC | \
+    R_MPAMF_MPAMCFG_WINWD_US_INT)
+
+REG32(MPAMF_MPAMCFG_EN, 0x0300)
+    FIELD(MPAMF_MPAMCFG_EN, PARTID, 0, 16)
+#define MPAMF_MPAMCFG_EN_WRITE_MASK ( \
+    R_MPAMF_MPAMCFG_EN_PARTID_MASK)
+
+REG32(MPAMF_MPAMCFG_DIS, 0x0310) /* WHat is this for? */
+    FIELD(MPAMF_MPAMCFG_DIS, PARTID, 0, 16)
+    FIELD(MPAMF_MPAMCFG_DIS, NFU, 31, 1)
+#define MPAMF_MPAMCFG_DIS_WRITE_MASK ( \
+    R_MPAMF_MPAMCFG_DIS_PARTID_MASK | \
+    R_MPAMF_MPAMCFG_DIS_NFU)
+
+REG32(MPAMF_MPAMCFG_EN_FLAGS, 0x320)
+
+REG32(MPAMF_MPAMCFG_PRI, 0x400)
+    FIELD(MPAMF_MPAMCFG_PRI, INTPRI, 0, 16)
+    FIELD(MPAMF_MPAMCFG_PRI, DSPRI, 16, 16)
+#define MPAMF_MPAMCFG_PRI_WRITE_MASK ( \
+    R_MPAMF_MPAMCFG_PRI_INTPRI_MASK | \
+    R_MPAMF_MPAMCFG_PRI_DSPRI_MASK)
+
+REG32(MPAMF_MPAMCFG_MBW_PROP, 0x500)
+    FIELD(MPAMF_MPAMCFG_MBW_PROP, STRIDEM1, 0, 16)
+    FIELD(MPAMF_MPAMCFG_MBW_PROP, EN, 31, 1)
+#define MPAMF_MPAMCFG_MBW_PROP_WRITE_MASK ( \
+    R_MPAMF_MPAMCFG_MBW_PROP_STRIDEM1_MASK | \
+    R_MPAMF_MPAMCFG_MBW_PROP_EN_MASK)
+
+REG32(MPAMF_MPAMCFG_INTPARTID, 0x600)
+    FIELD(MPAMF_MPAMCFG_INTPARTID, INTPARTID, 0, 16)
+    FIELD(MPAMF_MPAMCFG_INTPARTID, INTERNAL, 16, 1)
+#define MPAMF_MPAMCFG_INTPARTID_WRITE_MASK ( \
+    R_MPAMF_MPAMCFG_INTPARTID_INTPARTID_MASK | \
+    R_MPAMF_MPAMCFG_INTPARTID_INTERNAL_MASK)
+
+REG32(MPAMF_MPAMCFG_CPBM0, 0x1000)
+
+REG32(MPAMF_MPAMCFG_MBW_PBM0, 0x2000)
+
+#define TYPE_MPAM_MSC "mpam-msc"
+#define MPAM_MBW_PART 4
+#define MPAM_CACHE_PART 32
+
+typedef struct MpamfPerNrwId {
+        uint32_t cfg_cpbm[(MPAM_CACHE_PART + 31) / 32];
+        uint32_t cfg_mbw_pbm[(MPAM_MBW_PART + 31) / 32];
+        uint32_t cfg_pri;
+        uint32_t cfg_cmax;
+        uint32_t cfg_mbw_min;
+        uint32_t cfg_mbw_max;
+        uint32_t cfg_mbw_prop;
+} MpamfPerNrwId;
+
+typedef struct Mpamf {
+    uint64_t idr;
+    uint32_t iidr;
+    uint32_t aidr;
+    uint32_t impl_idr;
+    uint32_t cpor_idr;
+    uint32_t ccap_idr;
+    uint32_t mbw_idr;
+    uint32_t pri_idr;
+    uint32_t partid_nrw_idr;
+    uint32_t msmon_idr;
+    uint32_t csumon_idr;
+    uint32_t mbwumon_idr;
+    uint32_t err_msi_mpam;
+    uint32_t err_msi_addr_l;
+    uint32_t err_msi_addr_h;
+    uint32_t err_msi_data;
+    uint32_t err_msi_attr;
+    uint32_t ecr;
+    uint32_t esr;
+    uint32_t cfg_part_sel;
+    uint32_t *cfg_intpartid;
+
+    MpamfPerNrwId *per_nrw_id;
+
+} Mpamf;
+
+typedef struct MPAMMSCState {
+    SysBusDevice parent_obj;
+
+    Mpamf *mpamf;
+
+    uint8_t ris;
+    uint16_t part_sel; /* Technically per ris, but in same reg */
+    bool internal_part_sel;
+    struct MemoryRegion mr;
+    uint32_t num_partid;
+    uint32_t num_int_partid;
+    uint8_t num_ris;
+
+} MPAMMSCState;
+
+/*
+ * ID narrowing may be in effect.  If it is there is an indirection
+ * table per RIS mapping from part_sel to the internal ID. To make things
+ * more complex, the Partition selection register can directly address
+ * internal IDs. That works for everything other than the ID map itself.
+ * This function pulls the right internal ID out of this complexity
+ * for use in accessing the per_nrw_id structures.
+ */
+static uint32_t mpam_get_nrw_id(MPAMMSCState *s)
+{
+    Mpamf *mpamf = &s->mpamf[s->ris];
+
+    if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_PARTID_NRW)) {
+        return s->part_sel;
+    }
+    if (s->internal_part_sel) {
+        return s->part_sel;
+    }
+    return mpamf->cfg_intpartid[s->part_sel];
+}
+
+typedef struct MPAMMSCMemState {
+    MPAMMSCState parent;
+} MPAMMSCMemState;
+
+typedef struct MPAMMSCCacheState {
+    MPAMMSCState parent;
+    uint8_t cache_level;
+    uint8_t cache_type;
+    uint16_t cpu;
+
+} MPAMMSCCacheState;
+
+DECLARE_INSTANCE_CHECKER(MPAMMSCState, MPAM_MSC_DEVICE, TYPE_MPAM_MSC);
+
+DECLARE_INSTANCE_CHECKER(MPAMMSCMemState, MPAM_MSC_MEM_DEVICE,
+                         TYPE_MPAM_MSC_MEM);
+
+DECLARE_INSTANCE_CHECKER(MPAMMSCCacheState, MPAM_MSC_CACHE_DEVICE,
+                         TYPE_MPAM_MSC_CACHE);
+
+void mpam_cache_fill_info(Object *obj, MpamCacheInfo *info)
+{
+    MPAMMSCCacheState *cs = MPAM_MSC_CACHE_DEVICE(obj);
+    MPAMMSCState *s = MPAM_MSC_DEVICE(obj);
+    MpamRegsList *reg_list = NULL, **r_next = &reg_list;
+    int i, p, b;
+
+    info->cpu = cs->cpu;
+    info->level = cs->cache_level;
+    info->type = cs->cache_level;
+    for (i = 0; i < s->num_ris; i++) {
+        MpamRegsList *regs;
+        MpamRegs *r;
+        MpamBmList *bm_list = NULL, **bm_next = &bm_list;
+
+        Mpamf *mpamf = &s->mpamf[i];
+
+        r = g_malloc0(sizeof(*r));
+        regs = g_malloc0(sizeof(*regs));
+        regs->value = r;
+
+        *r = (MpamRegs) {
+            .idr = mpamf->idr,
+            .iidr = mpamf->iidr,
+            .aidr = mpamf->aidr,
+            .cpor_idr = mpamf->cpor_idr,
+            .ccap_idr = mpamf->ccap_idr,
+            .mbw_idr = mpamf->mbw_idr,
+            .pri_idr = mpamf->pri_idr,
+            .partid_nrw_idr = mpamf->partid_nrw_idr,
+            .msmon_idr = mpamf->msmon_idr,
+            .csumon_idr = mpamf->csumon_idr,
+            .mbwumon_idr = mpamf->mbwumon_idr,
+            .ecr = mpamf->ecr,
+            .esr = mpamf->esr,
+            .cfg_part_sel = mpamf->cfg_part_sel, /* Garbage */
+        };
+
+        /* This is annoyingly complex */
+        for (p = 0; p < s->num_int_partid; p++) {
+            intList *w_list = NULL, **w_next = &w_list;
+            MpamBm *bm = g_malloc0(sizeof(*bm));
+            MpamBmList *bml = g_malloc0(sizeof(*bml));
+
+            bml->value = bm;
+
+            for (b = 0; b < (MPAM_CACHE_PART + 31) / 32; b++) {
+                intList *il = g_malloc0(sizeof(*il));
+
+                il->value = mpamf->per_nrw_id[p].cfg_cpbm[b];
+                *w_next = il;
+                w_next = &il->next;
+
+            }
+            *bm_next = bml;
+            bm_next = &bml->next;
+            bm->words = w_list;
+        }
+        r->cfg_cpbm = bm_list;
+        *r_next = regs;
+        r_next = &regs->next;
+    }
+    info->regs = reg_list;
+
+}
+
+static uint64_t mpam_msc_read_reg(void *opaque, hwaddr offset,
+                                  unsigned size)
+{
+    MPAMMSCState *s = MPAM_MSC_DEVICE(opaque);
+    Mpamf *mpamf = &s->mpamf[s->ris];
+    uint32_t nrw_part_sel = mpam_get_nrw_id(s);
+
+    switch (offset) {
+    case A_MPAMF_IDR:
+        switch (size) {
+        case 4:
+            return mpamf->idr & 0xffffffff;
+        case 8:
+            return mpamf->idr;
+        default:
+            qemu_log_mask(LOG_UNIMP, "MPAM: Unexpected read size\n");
+            return 0;
+        }
+    case A_MPAMF_IDR + 0x04:
+        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, EXT)) {
+            qemu_log_mask(LOG_UNIMP, "MPAM: Unexpected read of top of IDR\n");
+            return 0;
+        }
+        switch (size) {
+        case 4:
+            return mpamf->idr >> 32;
+        default:
+            qemu_log_mask(LOG_UNIMP, "MPAM: Unexpected read size\n");
+            return 0;
+        }
+    case A_MPAMF_IIDR:
+        return mpamf->iidr;
+    case A_MPAMF_AIDR:
+        return mpamf->aidr;
+    case A_MPAMF_IMPL_IDR:
+        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_IMPL_IDR)) {
+            qemu_log_mask(LOG_UNIMP,
+                "MPAM: Accessing IMPL_IDR which isn't suported\n");
+            return 0;
+        }
+        return mpamf->impl_idr;
+    case A_MPAMF_CPOR_IDR:
+        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_CPOR_PART)) {
+            qemu_log_mask(LOG_UNIMP,
+                "MPAM: Unexpected read of CPOR_IDR with no CPOR support\n");
+            return 0;
+        }
+        return mpamf->cpor_idr;
+    case A_MPAMF_CCAP_IDR:
+        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_CCAP_PART)) {
+            qemu_log_mask(LOG_UNIMP,
+                "MPAM: Unexpected read of CCAP_IDR with no CCAP support\n");
+            return 0;
+        }
+        return mpamf->ccap_idr;
+    case A_MPAMF_MBW_IDR:
+        return mpamf->mbw_idr;
+    case A_MPAMF_PRI_IDR:
+        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_PRI_PART)) {
+            qemu_log_mask(LOG_UNIMP,
+                "MPAM: Unexpected read of PRI_IDR with no PRI PART support\n");
+            return 0;
+        }
+        return mpamf->pri_idr;
+    case A_MPAMF_PARTID_NRW_IDR: {
+        return mpamf->partid_nrw_idr;
+    }
+    case A_MPAMF_MSMON_IDR:
+        return mpamf->msmon_idr;
+    case A_MPAMF_CSUMON_IDR:
+        return mpamf->csumon_idr;
+    case A_MPAMF_MBWUMON_IDR:
+        return mpamf->mbwumon_idr;
+    case A_MPAMF_ERR_MSI_MPAM:
+        return mpamf->err_msi_mpam;
+    case A_MPAMF_ERR_MSI_ADDR_L:
+        return mpamf->err_msi_addr_l;
+    case A_MPAMF_ERR_MSI_ADDR_H:
+        return mpamf->err_msi_addr_h;
+    case A_MPAMF_ERR_MSI_DATA:
+        return mpamf->err_msi_data;
+    case A_MPAMF_ERR_MSI_ATTR:
+        return mpamf->err_msi_attr;
+    case A_MPAMF_ECR:
+        return mpamf->ecr;
+    case A_MPAMF_ESR:
+        return mpamf->esr;
+    case A_MPAMF_CFG_PART_SEL:
+        return mpamf->cfg_part_sel;
+    case A_MPAMF_MPAMCFG_CMAX:
+        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_CCAP_PART)) {
+            qemu_log_mask(LOG_UNIMP,
+                "MPAM: Unexpected read of CMAX with no CCAP support\n");
+            return 0;
+        }
+        return mpamf->per_nrw_id[nrw_part_sel].cfg_cmax;
+    case A_MPAMF_MPAMCFG_MBW_MIN:
+        return mpamf->per_nrw_id[nrw_part_sel].cfg_mbw_min;
+    case A_MPAMF_MPAMCFG_MBW_MAX:
+        return mpamf->per_nrw_id[nrw_part_sel].cfg_mbw_max;
+    case A_MPAMF_MPAMCFG_PRI:
+        return mpamf->per_nrw_id[nrw_part_sel].cfg_pri;
+    case A_MPAMF_MPAMCFG_MBW_PROP:
+        return mpamf->per_nrw_id[nrw_part_sel].cfg_mbw_prop;
+    case A_MPAMF_MPAMCFG_CPBM0...
+        (A_MPAMF_MPAMCFG_CPBM0 + ((MPAM_CACHE_PART + 31) / 32 - 1) * 4):
+    {
+        uint32_t array_offset;
+
+        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_CPOR_PART)) {
+            qemu_log_mask(LOG_UNIMP,
+                "MPAM: Unexpected read of CPBM with no CPOR support\n");
+            return 0;
+        }
+        array_offset = (offset - A_MPAMF_MPAMCFG_CPBM0) / sizeof(uint32_t);
+        return mpamf->per_nrw_id[nrw_part_sel].cfg_cpbm[array_offset];
+    }
+    case A_MPAMF_MPAMCFG_MBW_PBM0...
+            (A_MPAMF_MPAMCFG_MBW_PBM0 + ((MPAM_MBW_PART + 31) / 32 - 1) * 4):
+    {
+        uint32_t array_offset;
+
+        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_MBW_PART)) {
+            qemu_log_mask(LOG_UNIMP,
+                "MPAM: Unexpected read of MBW_PBM with no MBW_PART support\n");
+            return 0;
+        }
+        array_offset = (offset - A_MPAMF_MPAMCFG_MBW_PBM0) / sizeof(uint32_t);
+        return mpamf->per_nrw_id[nrw_part_sel].cfg_mbw_pbm[array_offset];
+    }
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "MPAM: Unexpected read of %lx\n", offset);
+        return 0x0;
+    }
+}
+
+static void mpam_msc_write_reg(void *opaque, hwaddr offset, uint64_t value,
+                               unsigned size)
+{
+    MPAMMSCState *s = MPAM_MSC_DEVICE(opaque);
+    /* Update in the ris setting path */
+    Mpamf *mpamf = &s->mpamf[s->ris];
+    /* Update if cfg_intpartid being touched */
+    uint32_t nrw_part_sel = mpam_get_nrw_id(s);
+
+    switch (offset) {
+    case A_MPAMF_CFG_PART_SEL:
+        if (value & ~MPAMF_CFG_PART_SEL_WRITE_MASK) {
+            qemu_log_mask(LOG_UNIMP,
+                          "MPAM: Unexpected write to CFG_PART_SEL Mask=%x Value=%lx\n",
+                          MPAMF_CFG_PART_SEL_WRITE_MASK, value);
+        }
+        /* Field matches for all RIS */
+        if (!FIELD_EX64(mpamf->idr, MPAMF_IDR, HAS_RIS) &&
+            FIELD_EX32(value, MPAMF_CFG_PART_SEL, RIS) != 0) {
+            qemu_log_mask(LOG_UNIMP,
+                          "MPAM: Unexpected write of non 0 RIS on MSC with !HAS_RIS\n");
+            return;
+        }
+        s->ris = FIELD_EX32(value, MPAMF_CFG_PART_SEL, RIS);
+        s->part_sel = FIELD_EX32(value, MPAMF_CFG_PART_SEL, PARTID_SEL);
+        s->internal_part_sel = FIELD_EX32(value, MPAMF_CFG_PART_SEL, INTERNAL);
+        mpamf = &s->mpamf[s->ris];
+        mpamf->cfg_part_sel = value;
+        return;
+    case A_MPAMF_MPAMCFG_CMAX:
+        if (value & ~MPAMF_MPAMCFG_CMAX_WRITE_MASK) {
+            qemu_log_mask(LOG_UNIMP,
+                          "MPAM: Unexpected write to CMAX Mask=%x Value=%lx\n",
+                          MPAMF_MPAMCFG_CMAX_WRITE_MASK, value);
+        }
+        mpamf->per_nrw_id[nrw_part_sel].cfg_cmax = value;
+        return;
+    case A_MPAMF_MPAMCFG_MBW_MIN:
+        if (value & ~MPAMF_MPAMCFG_CMIN_WRITE_MASK) {
+            qemu_log_mask(LOG_UNIMP,
+                          "MPAM: Unexpected write to CMAX Mask=%x Value=%lx\n",
+                          MPAMF_MPAMCFG_CMIN_WRITE_MASK, value);
+        }
+        mpamf->per_nrw_id[nrw_part_sel].cfg_mbw_min = value;
+        return;
+    case A_MPAMF_MPAMCFG_MBW_MAX:
+        if (value & ~MPAMF_MPAMCFG_MBW_MAX_WRITE_MASK) {
+            qemu_log_mask(LOG_UNIMP,
+                          "MPAM: Unexpected write to MBW_MAX Mask=%x Value=%lx\n",
+                          MPAMF_MPAMCFG_MBW_MAX_WRITE_MASK, value);
+        }
+        mpamf->per_nrw_id[nrw_part_sel].cfg_mbw_max = value;
+        return;
+    case A_MPAMF_MPAMCFG_PRI:
+        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_PRI_PART)) {
+            qemu_log_mask(LOG_UNIMP,
+                          "MPAM: Unexpected write to CFG_PRI when !HAS_PRI_PART\n");
+        } else {
+            if (!FIELD_EX32(mpamf->pri_idr, MPAMF_PRI_IDR, HAS_DSPRI) &&
+                FIELD_EX32(value, MPAMF_MPAMCFG_PRI, DSPRI)) {
+                qemu_log_mask(LOG_UNIMP,
+                              "MPAM: Unexpected write to CFGP_PRI DSPRI when !HAS_DSPRI\n");
+            }
+            if (!FIELD_EX32(mpamf->pri_idr, MPAMF_PRI_IDR, HAS_INTPRI) &&
+                FIELD_EX32(value, MPAMF_MPAMCFG_PRI, INTPRI)) {
+                qemu_log_mask(LOG_UNIMP,
+                              "MPAM: Unexpected write to CFGP_PRI INTPRI when !HAS_INTPRI\n");
+            }
+        }
+        mpamf->per_nrw_id[nrw_part_sel].cfg_pri = value;
+        return;
+    case A_MPAMF_MPAMCFG_MBW_PROP:
+        if (value & ~MPAMF_MPAMCFG_MBW_PROP_WRITE_MASK) {
+            qemu_log_mask(LOG_UNIMP,
+                          "MPAM: Unexpected write to MBW_PROP Mask=%x Value=%lx\n",
+                          MPAMF_MPAMCFG_MBW_MAX_WRITE_MASK, value);
+        }
+        mpamf->per_nrw_id[nrw_part_sel].cfg_mbw_prop = value;
+        return;
+    case A_MPAMF_MPAMCFG_CPBM0...
+        (A_MPAMF_MPAMCFG_CPBM0 + ((MPAM_CACHE_PART + 31) / 32 - 1) * 4):
+    {
+        uint32_t array_offset;
+
+        /* TODO: Figure out write mask to check this stays in write bits */
+        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_CPOR_PART)) {
+            qemu_log_mask(LOG_UNIMP,
+                          "MPAM: Unexpected write to CPMB when !HAS_CPORT_PART\n");
+            return;
+        }
+        array_offset = (offset - A_MPAMF_MPAMCFG_CPBM0) / sizeof(uint32_t);
+        mpamf->per_nrw_id[nrw_part_sel].cfg_cpbm[array_offset] = value;
+        return;
+    }
+    case A_MPAMF_MPAMCFG_MBW_PBM0...
+        (A_MPAMF_MPAMCFG_MBW_PBM0 + ((MPAM_MBW_PART + 31) / 32 - 1) * 4):
+    {
+        uint32_t array_offset;
+
+        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_MBW_PART)) {
+            qemu_log_mask(LOG_UNIMP,
+                          "MPAM: Unexpected write to MBW_PBM when !HAS_MBW_PART\n");
+            return;
+        }
+        /* TODO: Figure out write mask to check this stays in write bits */
+        array_offset = (offset - A_MPAMF_MPAMCFG_MBW_PBM0) / sizeof(uint32_t);
+
+        mpamf->per_nrw_id[nrw_part_sel].cfg_mbw_pbm[array_offset] = value;
+        return;
+    }
+    case A_MPAMF_ECR:
+        if (value & ~MPAMF_ECR_WRITE_MASK) {
+            qemu_log_mask(LOG_UNIMP,
+                          "MPAM: Unexpected write to ECR Mask=%x Value=%lx\n",
+                          MPAMF_ECR_WRITE_MASK, value);
+        }
+        mpamf->ecr = value;
+        return;
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "MPAM: Write to unexpected register Addr %lx Value=%lx\n",
+                      offset, value);
+    }
+}
+
+static const MemoryRegionOps mpam_msc_ops = {
+    .read = mpam_msc_read_reg,
+    .write = mpam_msc_write_reg,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 8,
+        .unaligned = false,
+    },
+    .impl = {
+        .min_access_size = 1,
+        .max_access_size = 8,
+    },
+};
+
+
+static void mpam_msc_realize(DeviceState *dev, Error **errp)
+{
+    MPAMMSCState *s = MPAM_MSC_DEVICE(dev);
+    int i;
+
+    if (s->num_ris > 16) {
+        error_setg(errp, "num-ris must be <= 16");
+        return;
+    }
+    if (s->num_partid == 0) {
+        error_setg(errp, "num-ris must be <= 16");
+        return;
+    }
+    if (s->num_int_partid == 0) {
+        s->num_int_partid = s->num_partid;
+    }
+
+    s->mpamf = g_new0(Mpamf, s->num_ris);
+    for (i = 0; i < s->num_ris; i++) {
+        s->mpamf[i].per_nrw_id = g_new0(MpamfPerNrwId, s->num_int_partid);
+        s->mpamf[i].cfg_intpartid = g_new0(uint32_t, s->num_partid);
+    }
+
+    memory_region_init_io(&s->mr, OBJECT(s), &mpam_msc_ops, s, "mpam_msc",
+                          0x4000);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mr);
+}
+
+static void mpam_msc_mem_realize(DeviceState *dev, Error **errp)
+{
+
+    MPAMMSCState *s = MPAM_MSC_DEVICE(dev);
+    int i;
+
+    mpam_msc_realize(dev, errp);
+
+    for (i = 0; i < s->num_ris; i++) {
+        Mpamf *mpamf = &s->mpamf[i];
+
+        mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, PART_ID_MAX,
+                                s->num_partid - 1);
+        /* No PCMG for now */
+        mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, PMG_MAX, 0);
+        mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, EXT, 1);
+        mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, HAS_RIS, s->num_ris > 1);
+        mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, RIS_MAX,
+                                  s->num_ris > 1 ? s->num_ris - 1 : 0);
+         /* Optional - test with and without */
+        mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, HAS_ESR, 1);
+        mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, HAS_EXTD_ESR, 1);
+        mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, HAS_PARTID_NRW,
+                                s->num_int_partid < s->num_partid);
+
+        /* We won't implement any implementation specific stuff */
+        mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, NO_IMPL_PART, 1);
+        mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, NO_IMPL_MSMON, 1);
+        /* Memory specific bit */
+        mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, HAS_MBW_PART, 1);
+
+        mpamf->iidr = FIELD_DP64(mpamf->iidr, MPAMF_IIDR, IMPLEMENTER, 0x736);
+        mpamf->iidr = FIELD_DP64(mpamf->iidr, MPAMF_IIDR, REVISION, 0);
+        mpamf->iidr = FIELD_DP64(mpamf->iidr, MPAMF_IIDR, VARIANT, 0);
+        /* FIXME get allocation for this emulation */
+        mpamf->iidr = FIELD_DP64(mpamf->iidr, MPAMF_IIDR, PRODUCT_ID, 42);
+
+        mpamf->aidr = FIELD_DP64(mpamf->aidr, MPAMF_AIDR, ARCH_MINOR_REV, 1);
+        mpamf->aidr = FIELD_DP64(mpamf->aidr, MPAMF_AIDR, ARCH_MAJOR_REV, 1);
+
+        mpamf->mbw_idr = FIELD_DP32(mpamf->mbw_idr, MPAMF_MBW_IDR, BWA_WD, 16);
+        mpamf->mbw_idr = FIELD_DP32(mpamf->mbw_idr, MPAMF_MBW_IDR, HAS_MIN, 1);
+        mpamf->mbw_idr = FIELD_DP32(mpamf->mbw_idr, MPAMF_MBW_IDR, HAS_MAX, 1);
+        mpamf->mbw_idr = FIELD_DP32(mpamf->mbw_idr, MPAMF_MBW_IDR, HAS_PBM, 1);
+        mpamf->mbw_idr = FIELD_DP32(mpamf->mbw_idr, MPAMF_MBW_IDR, HAS_PROP, 1);
+
+        mpamf->mbw_idr = FIELD_DP32(mpamf->mbw_idr, MPAMF_MBW_IDR, WINDWR, 0);
+        mpamf->mbw_idr = FIELD_DP32(mpamf->mbw_idr, MPAMF_MBW_IDR,
+                                    BWPBM_WD, MPAM_MBW_PART);
+
+        if (s->num_int_partid < s->num_partid) {
+            mpamf->partid_nrw_idr = FIELD_DP32(mpamf->partid_nrw_idr,
+                                               MPAMF_PARTID_NRW_IDR,
+                                               INTPARTID_MAX,
+                                               s->num_int_partid - 1);
+        }
+    }
+}
+
+static void mpam_msc_cache_realize(DeviceState *dev, Error **errp)
+{
+    MPAMMSCState *s = MPAM_MSC_DEVICE(dev);
+    int i;
+
+    mpam_msc_realize(dev, errp);
+
+    for (i = 0; i < s->num_ris; i++) {
+        Mpamf *mpamf = &s->mpamf[i];
+
+        mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, PART_ID_MAX,
+                                s->num_partid - 1);
+        /* No PCMG for now */
+        mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, PMG_MAX, 0);
+        mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, EXT, 1);
+        mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, HAS_RIS, s->num_ris > 1);
+        mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, RIS_MAX,
+                                  s->num_ris > 1 ? s->num_ris - 1 : 0);
+
+        /* Optional - test with and without */
+        mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, HAS_ESR, 1);
+        mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, HAS_EXTD_ESR,
+                                s->num_ris > 1);
+
+        /* We won't implement any implementation specific stuff */
+        mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, NO_IMPL_PART, 1);
+        mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, NO_IMPL_MSMON, 1);
+
+        /* Need to implement for RME */
+        mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, SP4, 0);
+
+        /* Cache specific bit */
+        mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, HAS_CPOR_PART, 1);
+        mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, HAS_CCAP_PART, 1);
+        mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, HAS_PRI_PART, 1);
+        mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, HAS_PARTID_NRW,
+                                s->num_int_partid < s->num_partid);
+
+        mpamf->iidr = FIELD_DP32(mpamf->iidr, MPAMF_IIDR, IMPLEMENTER, 0x736);
+        mpamf->iidr = FIELD_DP32(mpamf->iidr, MPAMF_IIDR, REVISION, 0);
+        mpamf->iidr = FIELD_DP32(mpamf->iidr, MPAMF_IIDR, VARIANT, 0);
+        /* FIXME get allocation for this emulation */
+        mpamf->iidr = FIELD_DP32(mpamf->iidr, MPAMF_IIDR, PRODUCT_ID, 42);
+
+        mpamf->aidr = FIELD_DP32(mpamf->aidr, MPAMF_AIDR, ARCH_MINOR_REV, 1);
+        mpamf->aidr = FIELD_DP32(mpamf->aidr, MPAMF_AIDR, ARCH_MAJOR_REV, 1);
+
+        /* Portion */
+        mpamf->cpor_idr = FIELD_DP32(mpamf->cpor_idr, MPAMF_CPOR_IDR, CPBM_WD,
+                                     MPAM_CACHE_PART);
+
+        /* Priority */
+        mpamf->pri_idr = FIELD_DP32(mpamf->pri_idr, MPAMF_PRI_IDR,
+                                    HAS_INTPRI, 1);
+        mpamf->pri_idr = FIELD_DP32(mpamf->pri_idr, MPAMF_PRI_IDR,
+                                    INTPRI_0_IS_LOW, 1);
+        mpamf->pri_idr = FIELD_DP32(mpamf->pri_idr, MPAMF_PRI_IDR,
+                                    INTPRI_WD, 2);
+
+        /* Capacity Partitioning */
+        mpamf->ccap_idr = FIELD_DP32(mpamf->ccap_idr, MPAMF_CCAP_IDR,
+                                     HAS_CMAX_SOFTLIM, 1);
+        mpamf->ccap_idr = FIELD_DP32(mpamf->ccap_idr, MPAMF_CCAP_IDR,
+                                     NO_CMAX, 0);
+        mpamf->ccap_idr = FIELD_DP32(mpamf->ccap_idr, MPAMF_CCAP_IDR,
+                                     HAS_CMIN, 1);
+        mpamf->ccap_idr = FIELD_DP32(mpamf->ccap_idr, MPAMF_CCAP_IDR,
+                                     HAS_CASSOC, 1);
+        mpamf->ccap_idr = FIELD_DP32(mpamf->ccap_idr, MPAMF_CCAP_IDR,
+                                     CASSOC_WD, 4); /* Not much flex on this */
+        mpamf->ccap_idr = FIELD_DP32(mpamf->ccap_idr, MPAMF_CCAP_IDR,
+                                     CMAX_WD, 4);
+
+        if (s->num_int_partid < s->num_partid) {
+            mpamf->partid_nrw_idr = FIELD_DP32(mpamf->partid_nrw_idr,
+                                               MPAMF_PARTID_NRW_IDR,
+                                               INTPARTID_MAX,
+                                               s->num_int_partid - 1);
+        }
+        /* TODO: Initialize all on as if firmware had done it for us */
+    }
+}
+
+static Property mpam_msc_props[] = {
+    DEFINE_PROP_UINT8("num-ris", MPAMMSCState, num_ris, 1),
+    DEFINE_PROP_UINT32("num-partid", MPAMMSCState, num_partid, 1),
+    DEFINE_PROP_UINT32("num-int-partid", MPAMMSCState, num_int_partid, 0),
+    DEFINE_PROP_END_OF_LIST()
+};
+
+static Property mpam_msc_cache_props[] = {
+    DEFINE_PROP_UINT8("cache-level", MPAMMSCCacheState, cache_level, 1),
+    DEFINE_PROP_UINT8("cache-type", MPAMMSCCacheState, cache_type, 1),
+    DEFINE_PROP_UINT16("cpu", MPAMMSCCacheState, cpu, 2),
+    DEFINE_PROP_END_OF_LIST()
+};
+
+static void mpam_msc_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    device_class_set_props(dc, mpam_msc_props);
+}
+
+static void mpam_msc_mem_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = mpam_msc_mem_realize;
+}
+
+static void mpam_msc_cache_init(ObjectClass *klass, void *data)
+{
+   DeviceClass *dc = DEVICE_CLASS(klass);
+
+   dc->realize = mpam_msc_cache_realize;
+   device_class_set_props(dc, mpam_msc_cache_props);
+}
+
+static const TypeInfo mpam_msc_info = {
+    .name = TYPE_MPAM_MSC,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(MPAMMSCState),
+    .class_init = mpam_msc_init
+};
+
+static const TypeInfo mpam_msc_mem_info = {
+    .name = TYPE_MPAM_MSC_MEM,
+    .parent = TYPE_MPAM_MSC,
+    .instance_size = sizeof(MPAMMSCMemState),
+    .class_init = mpam_msc_mem_init
+};
+
+static const TypeInfo mpam_msc_cache_info = {
+    .name = TYPE_MPAM_MSC_CACHE,
+    .parent = TYPE_MPAM_MSC,
+    .instance_size = sizeof(MPAMMSCCacheState),
+    .class_init = mpam_msc_cache_init
+};
+
+static void mpam_register_types(void)
+{
+    type_register_static(&mpam_msc_info);
+    type_register_static(&mpam_msc_mem_info);
+    type_register_static(&mpam_msc_cache_info);
+}
+type_init(mpam_register_types);
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 7e68348440..e44259910c 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -32,6 +32,7 @@ config ARM_VIRT
     select VIRTIO_MEM_SUPPORTED
     select ACPI_CXL
     select ACPI_HMAT
+    select MPAM
 
 config CHEETAH
     bool
@@ -593,6 +594,9 @@ config FSL_IMX7
 config ARM_SMMUV3
     bool
 
+config MPAM
+    bool
+
 config FSL_IMX6UL
     bool
     default y
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 11eb9112f8..08f72befa1 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -67,6 +67,10 @@ arm_ss.add(when: 'CONFIG_XEN', if_true: files('xen_arm.c'))
 arm_ss.add_all(xen_ss)
 
 system_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmu-common.c'))
+system_ss.add(when: 'CONFIG_MPAM', if_true: files('mpam.c', 'mpam-qapi.c'))
+system_ss.add(when: 'CONFIG_MPAM', if_false: files('mpam-qapi-stubs.c'))
+system_ss.add(when: 'CONFIG_ALL', if_true: files('mpam-qapi-stubs.c'))
+
 system_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4_boards.c'))
 system_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_peripherals.c'))
 system_ss.add(when: 'CONFIG_TOSA', if_true: files('tosa.c'))
diff --git a/qapi/meson.build b/qapi/meson.build
index 60a668b343..8e9a45330b 100644
--- a/qapi/meson.build
+++ b/qapi/meson.build
@@ -41,6 +41,7 @@ qapi_all_modules = [
   'migration',
   'misc',
   'misc-target',
+  'mpam',
   'net',
   'pragma',
   'qom',
-- 
2.39.2


