Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A767AEA94
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 12:39:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql5TI-0007eg-Mb; Tue, 26 Sep 2023 06:39:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1ql5TE-0007IR-7V; Tue, 26 Sep 2023 06:39:12 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1ql5TC-00022Z-62; Tue, 26 Sep 2023 06:39:11 -0400
Received: from lhrpeml500001.china.huawei.com (unknown [172.18.147.206])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Rvx1W66cbz6J7yR;
 Tue, 26 Sep 2023 18:34:07 +0800 (CST)
Received: from A190218597.china.huawei.com (10.126.174.16) by
 lhrpeml500001.china.huawei.com (7.191.163.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 26 Sep 2023 11:38:48 +0100
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: <salil.mehta@huawei.com>, <maz@kernel.org>, <jean-philippe@linaro.org>,
 <jonathan.cameron@huawei.com>, <lpieralisi@kernel.org>,
 <peter.maydell@linaro.org>, <richard.henderson@linaro.org>,
 <imammedo@redhat.com>, <andrew.jones@linux.dev>, <david@redhat.com>,
 <philmd@linaro.org>, <eric.auger@redhat.com>, <will@kernel.org>,
 <ardb@kernel.org>, <oliver.upton@linux.dev>, <pbonzini@redhat.com>,
 <mst@redhat.com>, <gshan@redhat.com>, <rafael@kernel.org>,
 <borntraeger@linux.ibm.com>, <alex.bennee@linaro.org>,
 <linux@armlinux.org.uk>, <darren@os.amperecomputing.com>,
 <ilkka@os.amperecomputing.com>, <vishnu@os.amperecomputing.com>,
 <karl.heubaum@oracle.com>, <miguel.luis@oracle.com>,
 <salil.mehta@opnsrc.net>, <zhukeqian1@huawei.com>,
 <wangxiongfeng2@huawei.com>, <wangyanan55@huawei.com>,
 <jiakernel2@gmail.com>, <maobibo@loongson.cn>, <lixianglai@loongson.cn>
Subject: [PATCH RFC V2 37/37] hw/arm/virt: Expose cold-booted CPUs as MADT
 GICC Enabled
Date: Tue, 26 Sep 2023 11:36:54 +0100
Message-ID: <20230926103654.34424-6-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20230926103654.34424-1-salil.mehta@huawei.com>
References: <20230926100436.28284-1-salil.mehta@huawei.com>
 <20230926103654.34424-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.126.174.16]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 lhrpeml500001.china.huawei.com (7.191.163.213)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=salil.mehta@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Salil Mehta <salil.mehta@huawei.com>
From:  Salil Mehta via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hotpluggable CPUs MUST be exposed as 'online-capable' as per the new change. But
cold booted CPUs if made 'online-capable' during boot time might not get
detected in the legacy OS. Hence, can cause compatibility problems.

Original Change Link: https://bugzilla.tianocore.org/show_bug.cgi?id=3706

Specification change might take time and hence disabling the support of
unplugging any cold booted CPUs to preserve the compatibility with legacy OS.

Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 hw/arm/virt-acpi-build.c | 19 ++++++++++++++-----
 hw/arm/virt.c            | 16 ++++++++++++++++
 include/hw/core/cpu.h    |  2 ++
 3 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 377450dd16..879c83a337 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -710,17 +710,26 @@ static uint32_t virt_acpi_get_gicc_flags(CPUState *cpu)
     }
 
     /*
-     * ARM GIC CPU Interface can be 'online-capable' or 'enabled' at boot
-     * We MUST set 'online-capable' Bit for all hotpluggable CPUs except the
-     * first/boot CPU. Cold-booted CPUs without 'Id' can also be unplugged.
-     * Though as-of-now this is only used as a debugging feature.
+     * ARM GIC CPU Interface can be 'online-capable' or 'enabled' at boot. We
+     * MUST set 'online-capable' bit for all hotpluggable CPUs.
+     * Change Link: https://bugzilla.tianocore.org/show_bug.cgi?id=3706
      *
      *   UEFI ACPI Specification 6.5
      *   Section: 5.2.12.14. GIC CPU Interface (GICC) Structure
      *   Table:   5.37 GICC CPU Interface Flags
      *   Link: https://uefi.org/specs/ACPI/6.5
+     *
+     * Cold-booted CPUs, except for the first/boot CPU, SHOULD be allowed to be
+     * hot(un)plug as well but for this to happen these MUST have
+     * 'online-capable' bit set. Later creates compatibility problem with legacy
+     * OS as it might ignore online-capable' bits during boot time and hence
+     * some CPUs might not get detected. To fix this MADT GIC CPU interface flag
+     * should be allowed to have both bits set i.e. 'online-capable' and
+     * 'Enabled' bits together. This change will require UEFI ACPI standard
+     * change. Till this happens exposing all cold-booted CPUs as 'enabled' only
+     *
      */
-    return cpu && !cpu->cpu_index ? 1 : (1 << 3);
+    return cpu && cpu->cold_booted ? 1 : (1 << 3);
 }
 
 static void
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index e46f529801..3bfe9b9db3 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3151,6 +3151,10 @@ static void virt_cpu_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
      * This shall be used during the init of ACPI Hotplug state and hot-unplug
      */
      cs->acpi_persistent = true;
+
+    if (!dev->hotplugged) {
+        cs->cold_booted = true;
+    }
 }
 
 static void virt_cpu_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
@@ -3214,6 +3218,18 @@ static void virt_cpu_unplug_request(HotplugHandler *hotplug_dev,
         return;
     }
 
+    /*
+     * UEFI ACPI standard change is required to make both 'enabled' and the
+     * 'online-capable' bit co-exist instead of being mutually exclusive.
+     * check virt_acpi_get_gicc_flags() for more details.
+     *
+     * Disable the unplugging of cold-booted vCPUs as a temporary mitigation.
+     */
+    if (cs->cold_booted) {
+        error_setg(errp, "Hot-unplug of cold-booted CPU not supported!");
+        return;
+    }
+
     if (cs->cpu_index == first_cpu->cpu_index) {
         error_setg(errp, "Boot CPU(id%d=%d:%d:%d:%d) hot-unplug not supported",
                    first_cpu->cpu_index, cpu->socket_id, cpu->cluster_id,
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index ffd815a0d8..f6b92a3285 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -441,6 +441,8 @@ struct CPUState {
     uint32_t can_do_io;
     int32_t exception_index;
 
+    bool cold_booted;
+
     AccelCPUState *accel;
     /* shared by kvm, hax and hvf */
     bool vcpu_dirty;
-- 
2.34.1


