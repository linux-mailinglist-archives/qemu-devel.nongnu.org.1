Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7FC8282A3
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 10:03:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rN7zC-0007ri-Lo; Tue, 09 Jan 2024 04:01:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_svaddagi@quicinc.com>)
 id 1rN7z8-0007qo-Je; Tue, 09 Jan 2024 04:01:23 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_svaddagi@quicinc.com>)
 id 1rN7z5-0003TC-Qd; Tue, 09 Jan 2024 04:01:22 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 4097nVHh013970; Tue, 9 Jan 2024 09:01:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:content-type; s=
 qcppdkim1; bh=6x6mE9k3d508GEZEb6SgEOFj6X8NdxEKlIcvjxf7yOg=; b=MR
 l/vzjAatuWijriMZcmsfYv7DPTRlNrbt7+V1nqKwq0znlt/EpOW73POgeNO0NbxA
 fkZ2X2kbko+dwNfyRrt5q8v63t0NZ54V1CsTvBWl1DPbhyAN1XOIdUwgpC+OtTfb
 hVSQ6arokj116SNQ/z5U+O0ckJipMiYSdy+LCsGbL5tVug4PBS2JfbRVwTZg8mUx
 qu3REugFJpTTR57k6ui8r7xXNSkpl6t9nC/7Y/u1jmuE749fhnohmla8P5ZoYrO1
 Z95NddAVrbGMHoWdx+lcK3Uml5UeDIU3dtaskYhtfw2g2DQZYsLTGjQGdyZ1afl6
 /oL9WBOyE+CGP3QWK3pQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vh234g4dh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Jan 2024 09:01:11 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com
 [10.47.209.197])
 by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40991B4D003523
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 9 Jan 2024 09:01:11 GMT
Received: from blr-ubuntu-31.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 9 Jan 2024 01:01:06 -0800
From: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
To: <peter.maydell@linaro.org>, <philmd@linaro.org>, <alex.bennee@linaro.org>, 
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: <quic_svaddagi@quicinc.com>, <quic_tsoni@quicinc.com>,
 <quic_pheragu@quicinc.com>, <quic_eberman@quicinc.com>,
 <quic_yvasi@quicinc.com>, <quic_cvanscha@quicinc.com>,
 <quic_mnalajal@quicinc.com>
Subject: [RFC/PATCH v1 04/11] gunyah: Support memory assignment
Date: Tue, 9 Jan 2024 09:00:32 +0000
Message-ID: <20240109090039.1636383-5-quic_svaddagi@quicinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240109090039.1636383-1-quic_svaddagi@quicinc.com>
References: <20240109090039.1636383-1-quic_svaddagi@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: 8teKF7XG4QzwWSKNlfxB8QwzWy4YDrQf
X-Proofpoint-GUID: 8teKF7XG4QzwWSKNlfxB8QwzWy4YDrQf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 bulkscore=0 phishscore=0
 mlxscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401090070
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=quic_svaddagi@quicinc.com; helo=mx0a-0031df01.pphosted.com
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

Gunyah hypervisor supports several APIs for a host VM to assign some of
its memory to the VM being created.

    Lend - assigned memory is made private to VM (host loses access)
    Share - assigned memory is shared between host and guest VM

No APIs exist however, at this time, for a protected VM to share some of its
(private) memory with host at runtime.

Since, in practice, even a protected VM may need some shared memory to
exchange information with its host, we split VM's memory into two
portions - one that is kept private (via Lend API) and other that is
shared with host (via Share API). Shared portion size is specified via
'preshmem-size' property of VM.

Note: Gunyah kernel driver from Android common kernel repository exposes
two separate ioctls for lend and share operations [1]. A subsequent
version of kernel driver that will be merged in Linux kernel repository
will combine the two ioctls into one, when this patch will be updated.

1. Refer GH_VM_ANDROID_LEND_USER_MEM and GH_VM_SET_USER_MEM_REGION in
https://android.googlesource.com/kernel/common/+/refs/heads/android14-6.1/drivers/virt/gunyah/vm_mgr.c

Signed-off-by: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
---
 accel/gunyah/gunyah-all.c   | 248 ++++++++++++++++++++++++++++++++++++
 include/sysemu/gunyah_int.h |  25 ++++
 2 files changed, 273 insertions(+)

diff --git a/accel/gunyah/gunyah-all.c b/accel/gunyah/gunyah-all.c
index 370add75f9..8b6b2d2017 100644
--- a/accel/gunyah/gunyah-all.c
+++ b/accel/gunyah/gunyah-all.c
@@ -14,12 +14,20 @@
 #include <sys/ioctl.h>
 #include "qemu/osdep.h"
 #include "qemu/typedefs.h"
+#include "qemu/units.h"
 #include "hw/core/cpu.h"
 #include "sysemu/cpus.h"
 #include "sysemu/gunyah.h"
 #include "sysemu/gunyah_int.h"
 #include "linux-headers/linux/gunyah.h"
+#include "exec/memory.h"
 #include "qemu/error-report.h"
+#include "exec/address-spaces.h"
+
+static void gunyah_region_add(MemoryListener *listener,
+                           MemoryRegionSection *section);
+static void gunyah_region_del(MemoryListener *listener,
+                           MemoryRegionSection *section);
 
 static int gunyah_ioctl(int type, ...)
 {
@@ -36,9 +44,32 @@ static int gunyah_ioctl(int type, ...)
     return ioctl(s->fd, type, arg);
 }
 
+int gunyah_vm_ioctl(int type, ...)
+{
+    void *arg;
+    va_list ap;
+    GUNYAHState *s = GUNYAH_STATE(current_accel());
+
+    assert(s->vmfd);
+
+    va_start(ap, type);
+    arg = va_arg(ap, void *);
+    va_end(ap);
+
+    return ioctl(s->vmfd, type, arg);
+}
+
+static MemoryListener gunyah_memory_listener = {
+    .name = "gunyah",
+    .priority = MEMORY_LISTENER_PRIORITY_ACCEL,
+    .region_add = gunyah_region_add,
+    .region_del = gunyah_region_del,
+};
+
 int gunyah_create_vm(void)
 {
     GUNYAHState *s;
+    int i;
 
     s = GUNYAH_STATE(current_accel());
 
@@ -55,9 +86,226 @@ int gunyah_create_vm(void)
         exit(1);
     }
 
+    qemu_mutex_init(&s->slots_lock);
+    s->nr_slots = GUNYAH_MAX_MEM_SLOTS;
+    for (i = 0; i < s->nr_slots; ++i) {
+        s->slots[i].start = 0;
+        s->slots[i].size = 0;
+        s->slots[i].id = i;
+    }
+
+    memory_listener_register(&gunyah_memory_listener, &address_space_memory);
     return 0;
 }
 
+#define gunyah_slots_lock(s)    qemu_mutex_lock(&s->slots_lock)
+#define gunyah_slots_unlock(s)  qemu_mutex_unlock(&s->slots_lock)
+
+static gunyah_slot *gunyah_find_overlap_slot(GUNYAHState *s,
+                uint64_t start, uint64_t size)
+{
+    gunyah_slot *slot;
+    int i;
+
+    for (i = 0; i < s->nr_slots; ++i) {
+        slot = &s->slots[i];
+        if (slot->size && start < (slot->start + slot->size) &&
+            (start + size) > slot->start) {
+            return slot;
+        }
+    }
+
+    return NULL;
+}
+
+/* Called with s->slots_lock held */
+static gunyah_slot *gunyah_get_free_slot(GUNYAHState *s)
+{
+    int i;
+
+    for (i = 0; i < s->nr_slots; i++) {
+        if (s->slots[i].size == 0) {
+            return &s->slots[i];
+        }
+    }
+
+    return NULL;
+}
+
+static void gunyah_add_mem(GUNYAHState *s, MemoryRegionSection *section,
+        bool lend, enum gh_mem_flags flags)
+{
+    gunyah_slot *slot;
+    MemoryRegion *area = section->mr;
+    struct gh_userspace_memory_region gumr;
+    int ret;
+
+    slot = gunyah_get_free_slot(s);
+    if (!slot) {
+        error_report("No free slots to add memory!");
+        exit(1);
+    }
+
+    slot->size = int128_get64(section->size);
+    slot->mem = memory_region_get_ram_ptr(area) + section->offset_within_region;
+    slot->start = section->offset_within_address_space;
+    slot->lend = lend;
+
+    gumr.label = slot->id;
+    gumr.flags = flags;
+    gumr.guest_phys_addr = slot->start;
+    gumr.memory_size = slot->size;
+    gumr.userspace_addr = (__u64) slot->mem;
+
+    /*
+     * GH_VM_ANDROID_LEND_USER_MEM is temporary, until
+     * GH_VM_SET_USER_MEM_REGION is enhanced to support lend option also.
+     */
+    if (lend) {
+        ret = gunyah_vm_ioctl(GH_VM_ANDROID_LEND_USER_MEM, &gumr);
+    } else {
+        ret = gunyah_vm_ioctl(GH_VM_SET_USER_MEM_REGION, &gumr);
+    }
+
+    if (ret) {
+        error_report("failed to add mem (%s)", strerror(errno));
+        exit(1);
+    }
+}
+
+/*
+ * Check if memory of a protected VM needs to be split into two portions - one
+ * private to it and other shared with host.
+ */
+static bool split_mem(GUNYAHState *s,
+        MemoryRegion *area, MemoryRegionSection *section)
+{
+    bool writeable = !area->readonly && !area->rom_device;
+
+    /*
+     * Do not split if its not a protected VM OR if the shared mem size is not
+     * specified.
+     */
+    if (!s->is_protected_vm || !s->preshmem_size) {
+        return false;
+    }
+
+    /* Split only memory that can be written to by guest */
+    if (!memory_region_is_ram(area) || !writeable) {
+        return false;
+    }
+
+    /* Have we reserved already? */
+    if (qatomic_read(&s->preshmem_reserved)) {
+        return false;
+    }
+
+    /* Do we have enough available memory? */
+    if (section->size <= s->preshmem_size) {
+        return false;
+    }
+
+    return true;
+}
+
+static void gunyah_set_phys_mem(GUNYAHState *s,
+        MemoryRegionSection *section, bool add)
+{
+    MemoryRegion *area = section->mr;
+    bool writable = !area->readonly && !area->rom_device;
+    enum gh_mem_flags flags = 0;
+    uint64_t page_size = qemu_real_host_page_size();
+    MemoryRegionSection mrs = *section;
+    bool lend = s->is_protected_vm, split = false;
+    struct gunyah_slot *slot;
+
+    /*
+     * Gunyah hypervisor, at this time, does not support mapping memory
+     * at low address (< 1GiB). Below code will be updated once
+     * that limitation is addressed.
+     */
+    if (section->offset_within_address_space < GiB) {
+        return;
+    }
+
+    if (!memory_region_is_ram(area)) {
+        if (writable) {
+            return;
+        } else if (!memory_region_is_romd(area)) {
+            /*
+             * If the memory device is not in romd_mode, then we actually want
+             * to remove the gunyah memory slot so all accesses will trap.
+             */
+             add = false;
+        }
+    }
+
+    if (!QEMU_IS_ALIGNED(int128_get64(section->size), page_size) ||
+        !QEMU_IS_ALIGNED(section->offset_within_address_space, page_size)) {
+        error_report("Not page aligned");
+        add = false;
+    }
+
+    gunyah_slots_lock(s);
+
+    slot = gunyah_find_overlap_slot(s,
+            section->offset_within_address_space,
+            int128_get64(section->size));
+
+    if (!add) {
+        if (slot) {
+            error_report("Memory slot removal not yet supported!");
+            exit(1);
+        }
+        /* Nothing to be done as address range was not previously registered */
+        goto done;
+    } else {
+        if (slot) {
+            error_report("Overlapping slot registration not supported!");
+            exit(1);
+        }
+    }
+
+    if (area->readonly ||
+        (!memory_region_is_ram(area) && memory_region_is_romd(area))) {
+        flags = GH_MEM_ALLOW_READ | GH_MEM_ALLOW_EXEC;
+    } else {
+        flags = GH_MEM_ALLOW_READ | GH_MEM_ALLOW_WRITE | GH_MEM_ALLOW_EXEC;
+    }
+
+    split = split_mem(s, area, &mrs);
+    if (split) {
+        mrs.size -= s->preshmem_size;
+        gunyah_add_mem(s, &mrs, true, flags);
+        lend = false;
+        mrs.offset_within_region += mrs.size;
+        mrs.offset_within_address_space += mrs.size;
+        mrs.size = s->preshmem_size;
+        qatomic_set(&s->preshmem_reserved, true);
+    }
+
+    gunyah_add_mem(s, &mrs, lend, flags);
+
+done:
+    gunyah_slots_unlock(s);
+}
+
+static void gunyah_region_add(MemoryListener *listener,
+                           MemoryRegionSection *section)
+{
+    GUNYAHState *s = GUNYAH_STATE(current_accel());
+
+    gunyah_set_phys_mem(s, section, true);
+}
+
+static void gunyah_region_del(MemoryListener *listener,
+                           MemoryRegionSection *section)
+{
+    GUNYAHState *s = GUNYAH_STATE(current_accel());
+
+    gunyah_set_phys_mem(s, section, false);
+}
+
 void *gunyah_cpu_thread_fn(void *arg)
 {
     CPUState *cpu = arg;
diff --git a/include/sysemu/gunyah_int.h b/include/sysemu/gunyah_int.h
index b1fd7f9ea2..17b4ef9920 100644
--- a/include/sysemu/gunyah_int.h
+++ b/include/sysemu/gunyah_int.h
@@ -13,17 +13,42 @@
 
 #include "qemu/accel.h"
 #include "qemu/typedefs.h"
+#include "qemu/thread.h"
+
+typedef struct gunyah_slot {
+    uint64_t start;
+    uint64_t size;
+    uint8_t *mem;
+    uint32_t id;
+    uint32_t flags;
+
+    /*
+     * @lend indicates if memory was lent.
+     *
+     * This flag is temporarily used until the upstream Gunyah kernel driver
+     * patches are updated to support indication of lend vs share via flags
+     * field of GH_SET_USER_MEM_API interface.
+     */
+    bool lend;
+} gunyah_slot;
+
+#define GUNYAH_MAX_MEM_SLOTS    32
 
 struct GUNYAHState {
     AccelState parent_obj;
 
+    QemuMutex slots_lock;
+    gunyah_slot slots[GUNYAH_MAX_MEM_SLOTS];
+    uint32_t nr_slots;
     int fd;
     int vmfd;
     bool is_protected_vm;
+    bool preshmem_reserved;
     uint32_t preshmem_size;
 };
 
 int gunyah_create_vm(void);
+int gunyah_vm_ioctl(int type, ...);
 void *gunyah_cpu_thread_fn(void *arg);
 
 #endif    /* GUNYAH_INT_H */
-- 
2.25.1


