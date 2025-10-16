Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE6ABE4BC5
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Oct 2025 19:00:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9RIi-0001An-DA; Thu, 16 Oct 2025 12:58:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v9RId-00018w-2w
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 12:58:00 -0400
Received: from p-east2-cluster1-host8-snip4-1.eps.apple.com ([57.103.76.74]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v9RIB-0001cW-VI
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 12:57:58 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPS id
 C2BB918015F8; Thu, 16 Oct 2025 16:57:16 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=X4HLxeIyHK0KKw8PIa5chPyq98xB5PG+vYgn4ck2iWM=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=WaUUM4rOXYwsLYRKRibENDznsdNteeNfjjfJr37poxWVT25X9OB6YBGHMhRdQE5pVGYJsrN4J1RhjbcrEgoRnD3jr9swjwIhXdRvFQqd0JB00a2hrrdH2NOJjjDEGMIFld33WTMRb5X7ZHqhyOe2ZEQf/JrZmq/EIPpBj46plMEUkWJsEsS4voHvjhJEl773PiMmI8FAnry/nonkQoTUYMVMQ9cadfm7KKZwwSwxeEPghGUjjOj+buwn+ZzawFDqtTXnHoSFYzM2tkRBOuSAOBW1JONW+psouKErIsClMgw9wXUDp93ADFfezZJCp9fNPJcVuydI3FmCJCMK7uixBA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPSA id
 8A89F1800317; Thu, 16 Oct 2025 16:56:07 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Mads Ynddal <mads@ynddal.dk>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Eduardo Habkost <eduardo@habkost.net>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 13/24] whpx: copy over memory management logic from hvf
Date: Thu, 16 Oct 2025 18:55:09 +0200
Message-ID: <20251016165520.62532-14-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251016165520.62532-1-mohamed@unpredictable.fr>
References: <20251016165520.62532-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: RW90amPd7TnaVi7O2M9X-eJZ3T1_GCLi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDEyMiBTYWx0ZWRfX+eHzf3Mr8o8d
 1Mt6HZTElluV+7BDfo3l7pJqg0SVJtAElcIr050CGPLayKXXeZVgMpSWNky0/YoQXquKRPbXA/5
 p842yni4mkVJdEXfwUkIhtimezDYDdjc5ocQuGnuIMRRfdNYkCT6lWkFjNnjPWEydqGABS1k95W
 qJdRLOISEG75LDL9JRP+Osj+85LvekJ23J1VVfbiKmflubIrXBk8P2p1bPwx/fts+PyqMMzz9bn
 0K6imtqHiVPmWZRW8DPMvvNMkMMlXP933v/Qv1RU/NMZbD718uDu4cTEbMw7chuU7aNISD6Yw=
X-Proofpoint-GUID: RW90amPd7TnaVi7O2M9X-eJZ3T1_GCLi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 spamscore=0 suspectscore=0 clxscore=1030
 bulkscore=0
 malwarescore=0 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2510160122
X-JNJ: AAAAAAABfrdvjvZJJ5ozzleXQcFPKI8f/YqTj0Civ6EZ1+mHY1v7KuYOAbxkMsu6uRNUBxrADLDH20vpgjY/S/aaynNAD7GotOADl21uStPLJN1U9sEcWVmjXr+sqPSrxsYREWtXLh/B0V48CdIYTSAGDMQ9RvpDGRMzgSq8IT1e2oKw+LRiAZThQN7H//P15DNyTw4dzCqtKa2GzrrdvmmfKp4+9Sct+gQpTRgC7qzGmRIVlkuKblD+3vjpzgyq/a84AuHhx7S4uAz6ADFxBpo5ct1zGNTtg7npZdFYSmBZlBK4sYJjoDhgMkw3Ij9ui7ix/J5sX474iVleB7LaderN1RF/1M+Ckkit9JjuRm+A53I5KWikhoUmh/ls+sVXPPPGVXJHQ5CMpcrQ6SHwx+6jXA7AxWslgKlg2vLBBx6Va+U0+jA+SDNToR3dn6RKla91gLV2bx1JTcvxyH9krOVrvaEtOSS6h+yZ9c246FXaU0R6J5v0GXjXt/1C8sWZrVdr3OEGVldkMcH+cX3hT8rG0ku6wwZ6tqJkSb0qip9KZMAOyXN/1KMXB4o/8/kncZF+ca/oOmNSpoX+eIRePJnp5fERmMtqpziexO94N/aVdZrLEXnML66/jhxeZZBfrjLkTUXpUbOHbyiVRAo16K/BiM3GRw3CR07nuq6S8CuQ7DESt8Jw+NC2NHGModI+3ly2iH4AFCIAgID/7wYKO35XIKcAdHSnKKys+28fK1PB9jynp2BtY+JIqsN5HQ7FPbTsvWtEP8Ry7Uk5u4rKMZ+EtifmnoTIP2h2h/F6AdNUVLUn/p4+K82mZWQExEyw60avK+hn5phn2DMK64xUC9/QTulM7igtC00HCN0tXCaDC5CAHjz5YzxUVYw6EWXfEFG72UFum7L21shwsgwPW4nwdXJs9WOVQvG4GcxkKLDQvMJtL8mQNg==
Received-SPF: pass client-ip=57.103.76.74;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This allows edk2 to work, although u-boot is still not functional.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 accel/whpx/whpx-common.c | 201 ++++++++++++++++++++++++++++-----------
 1 file changed, 147 insertions(+), 54 deletions(-)

diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
index c69792e638..f324f5c146 100644
--- a/accel/whpx/whpx-common.c
+++ b/accel/whpx/whpx-common.c
@@ -258,89 +258,174 @@ void whpx_vcpu_kick(CPUState *cpu)
  * Memory support.
  */
 
-static void whpx_update_mapping(hwaddr start_pa, ram_addr_t size,
-                                void *host_va, int add, int rom,
-                                const char *name)
+ /* whpx_slot flags */
+#define WHPX_SLOT_LOG (1 << 0)
+typedef struct whpx_slot {
+    uint64_t start;
+    uint64_t size;
+    uint8_t *mem;
+    int slot_id;
+    uint32_t flags;
+    MemoryRegion *region;
+} whpx_slot;
+
+typedef struct WHPXState {
+    whpx_slot slots[32];
+    int num_slots;
+} WHPXState;
+
+ WHPXState *whpx_state;
+
+ struct mac_slot {
+    int present;
+    uint64_t size;
+    uint64_t gpa_start;
+    uint64_t gva;
+};
+
+struct mac_slot mac_slots[32];
+
+static int do_whpx_set_memory(whpx_slot *slot, WHV_MAP_GPA_RANGE_FLAGS flags)
 {
     struct whpx_state *whpx = &whpx_global;
+    struct mac_slot *macslot;
     HRESULT hr;
 
-    /*
-    if (add) {
-        printf("WHPX: ADD PA:%p Size:%p, Host:%p, %s, '%s'\n",
-               (void*)start_pa, (void*)size, host_va,
-               (rom ? "ROM" : "RAM"), name);
-    } else {
-        printf("WHPX: DEL PA:%p Size:%p, Host:%p,      '%s'\n",
-               (void*)start_pa, (void*)size, host_va, name);
+    macslot = &mac_slots[slot->slot_id];
+
+    if (macslot->present) {
+        if (macslot->size != slot->size) {
+            macslot->present = 0;
+            hr = whp_dispatch.WHvUnmapGpaRange(whpx->partition,
+                 macslot->gpa_start, macslot->size);
+            if (FAILED(hr)) {
+                abort();
+            }
+        }
     }
-    */
-
-    if (add) {
-        hr = whp_dispatch.WHvMapGpaRange(whpx->partition,
-                                         host_va,
-                                         start_pa,
-                                         size,
-                                         (WHvMapGpaRangeFlagRead |
-                                          WHvMapGpaRangeFlagExecute |
-                                          (rom ? 0 : WHvMapGpaRangeFlagWrite)));
-    } else {
-        hr = whp_dispatch.WHvUnmapGpaRange(whpx->partition,
-                                           start_pa,
-                                           size);
+
+    if (!slot->size) {
+        return 0;
     }
 
-    if (FAILED(hr)) {
-        error_report("WHPX: Failed to %s GPA range '%s' PA:%p, Size:%p bytes,"
-                     " Host:%p, hr=%08lx",
-                     (add ? "MAP" : "UNMAP"), name,
-                     (void *)(uintptr_t)start_pa, (void *)size, host_va, hr);
+    macslot->present = 1;
+    macslot->gpa_start = slot->start;
+    macslot->size = slot->size;
+    hr = whp_dispatch.WHvMapGpaRange(whpx->partition,
+         slot->mem, slot->start, slot->size, flags);
+    return 0;
+}
+
+static whpx_slot *whpx_find_overlap_slot(uint64_t start, uint64_t size)
+{
+    whpx_slot *slot;
+    int x;
+    for (x = 0; x < whpx_state->num_slots; ++x) {
+        slot = &whpx_state->slots[x];
+        if (slot->size && start < (slot->start + slot->size) &&
+            (start + size) > slot->start) {
+            return slot;
+        }
     }
+    return NULL;
 }
 
-static void whpx_process_section(MemoryRegionSection *section, int add)
+static void whpx_set_phys_mem(MemoryRegionSection *section, bool add)
 {
-    MemoryRegion *mr = section->mr;
-    hwaddr start_pa = section->offset_within_address_space;
-    ram_addr_t size = int128_get64(section->size);
-    unsigned int delta;
-    uint64_t host_va;
+    whpx_slot *mem;
+    MemoryRegion *area = section->mr;
+    bool writable = !area->readonly && !area->rom_device;
+    WHV_MAP_GPA_RANGE_FLAGS flags;
+    uint64_t page_size = qemu_real_host_page_size();
+
+    if (!memory_region_is_ram(area)) {
+        if (writable) {
+            return;
+        } else if (!memory_region_is_romd(area)) {
+            /*
+             * If the memory device is not in romd_mode, then we actually want
+             * to remove the whpx memory slot so all accesses will trap.
+             */
+             add = false;
+        }
+    }
 
-    if (!memory_region_is_ram(mr)) {
-        return;
+    if (!QEMU_IS_ALIGNED(int128_get64(section->size), page_size) ||
+        !QEMU_IS_ALIGNED(section->offset_within_address_space, page_size)) {
+        /* Not page aligned, so we can not map as RAM */
+        add = false;
     }
 
-    delta = qemu_real_host_page_size() - (start_pa & ~qemu_real_host_page_mask());
-    delta &= ~qemu_real_host_page_mask();
-    if (delta > size) {
-        return;
+    mem = whpx_find_overlap_slot(
+            section->offset_within_address_space,
+            int128_get64(section->size));
+
+    if (mem && add) {
+        if (mem->size == int128_get64(section->size) &&
+            mem->start == section->offset_within_address_space &&
+            mem->mem == (memory_region_get_ram_ptr(area) +
+            section->offset_within_region)) {
+            return; /* Same region was attempted to register, go away. */
+        }
+    }
+
+    /* Region needs to be reset. set the size to 0 and remap it. */
+    if (mem) {
+        mem->size = 0;
+        if (do_whpx_set_memory(mem, 0)) {
+            error_report("Failed to reset overlapping slot");
+            abort();
+        }
     }
-    start_pa += delta;
-    size -= delta;
-    size &= qemu_real_host_page_mask();
-    if (!size || (start_pa & ~qemu_real_host_page_mask())) {
+
+    if (!add) {
         return;
     }
 
-    host_va = (uintptr_t)memory_region_get_ram_ptr(mr)
-            + section->offset_within_region + delta;
+    if (area->readonly ||
+        (!memory_region_is_ram(area) && memory_region_is_romd(area))) {
+        flags = WHvMapGpaRangeFlagRead | WHvMapGpaRangeFlagExecute;
+    } else {
+        flags = WHvMapGpaRangeFlagRead | WHvMapGpaRangeFlagWrite
+         | WHvMapGpaRangeFlagExecute;
+    }
+
+    /* Now make a new slot. */
+    int x;
+
+    for (x = 0; x < whpx_state->num_slots; ++x) {
+        mem = &whpx_state->slots[x];
+        if (!mem->size) {
+            break;
+        }
+    }
+
+    if (x == whpx_state->num_slots) {
+        error_report("No free slots");
+        abort();
+    }
 
-    whpx_update_mapping(start_pa, size, (void *)(uintptr_t)host_va, add,
-                        memory_region_is_rom(mr), mr->name);
+    mem->size = int128_get64(section->size);
+    mem->mem = memory_region_get_ram_ptr(area) + section->offset_within_region;
+    mem->start = section->offset_within_address_space;
+    mem->region = area;
+
+    if (do_whpx_set_memory(mem, flags)) {
+        error_report("Error registering new memory slot");
+        abort();
+    }
 }
 
 static void whpx_region_add(MemoryListener *listener,
                            MemoryRegionSection *section)
 {
-    memory_region_ref(section->mr);
-    whpx_process_section(section, 1);
+    whpx_set_phys_mem(section, true);
 }
 
 static void whpx_region_del(MemoryListener *listener,
                            MemoryRegionSection *section)
 {
-    whpx_process_section(section, 0);
-    memory_region_unref(section->mr);
+    whpx_set_phys_mem(section, false);
 }
 
 static void whpx_transaction_begin(MemoryListener *listener)
@@ -524,6 +609,14 @@ static void whpx_accel_instance_init(Object *obj)
     memset(whpx, 0, sizeof(struct whpx_state));
     /* Turn on kernel-irqchip, by default */
     whpx->kernel_irqchip_allowed = true;
+
+    int x;
+    whpx_state = malloc(sizeof(WHPXState));
+    whpx_state->num_slots = ARRAY_SIZE(whpx_state->slots);
+    for (x = 0; x < whpx_state->num_slots; ++x) {
+        whpx_state->slots[x].size = 0;
+        whpx_state->slots[x].slot_id = x;
+    }
 }
 
 static const TypeInfo whpx_accel_type = {
-- 
2.50.1 (Apple Git-155)


