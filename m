Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF29BE4BAD
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Oct 2025 19:00:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9RHw-0000oe-DF; Thu, 16 Oct 2025 12:57:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v9RHr-0000ms-R4
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 12:57:13 -0400
Received: from p-east2-cluster3-host7-snip4-5.eps.apple.com ([57.103.77.236]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v9RHi-0001Ys-Gb
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 12:57:11 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPS id
 94E4C18011DF; Thu, 16 Oct 2025 16:56:57 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=2o+iQBYw5OGJygArfdAEPT3ofAe32f1/RgxpAOHPkHU=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=g/o12BhYV0kSp6Lv61nvr9KSF7iE0iHCjGDbi9oMePztcxtorQD34KeUZCPQpgNNyl+Wn6gEaCp9ST6AeWaaOAIZ+lmkjF/8Ax+KcankAB4KuDRlyjWUl4XPnnXCYTmiuPWyiESvh/za4o1hJOrKU6zSW8Zc1dDiepEGudkjy1WYakcClFruKMibXLGdVweRTk2EZe1NV4DPrF5ED4vUevlx42nhjii6inI5AoRqfvuQODy5qVKHIe0MiaIHrV+x3eBZmyhS/jvPjCh1HNNPGM7rPieSQ0hf2LRbFlEPVVgvaAI3qPWfnvnOBEHBHMPQRtlIO8fsEeQj2P9/KN/y/Q==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPSA id
 C2EB41800303; Thu, 16 Oct 2025 16:55:36 +0000 (UTC)
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
 Roman Bolshakov <rbolshakov@ddn.com>
Subject: [PATCH v7 04/24] hw/arm: virt: add GICv2m for the case when ITS is
 not available
Date: Thu, 16 Oct 2025 18:55:00 +0200
Message-ID: <20251016165520.62532-5-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251016165520.62532-1-mohamed@unpredictable.fr>
References: <20251016165520.62532-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: NflitDkLeRPflpB13P4irTzFB3BRXTCM
X-Proofpoint-ORIG-GUID: NflitDkLeRPflpB13P4irTzFB3BRXTCM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDEyMiBTYWx0ZWRfX5o/RKKSk+Dk7
 YxCre0muXCXuL1hDmv0p6WGJWLQCYvFnOnvNFX3AQuMI6QBha2GaVBzHKzpQt0811sQnVytY81T
 KOG2r/JzgCIkxgB+DUkQdE+Yff5l28Ig9vKs9aIn4hPzsyGYTW6rsfE1ud+6priH3j9Z/FtV8Ti
 eSIdft/8FaX91kW/uObgfIgPkYNJBe1Ql6d5V7G1KuRnoAi5+S5Kwhln+jRBbyCo6aKHAkK3rKt
 DlqH2OqxT/7ItwIP3WNj+sSqS5opSFEuCzgnlqEbVNf14k7Pboz+AwGJxigz9JjXj3fM3IeSk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 malwarescore=0 adultscore=0 mlxscore=0 suspectscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.22.0-2506270000 definitions=main-2510160122
X-JNJ: AAAAAAAB141GGGzy1g/I+KVYGIgsxPYyTtG7ECm+jj6ITc5MLZ2H/pW8+t2T3yz+onpDsTEU+1Nhmmv96EcL1xB3LIQeT+Jj5MnY3Mjh3g3GjsVJpMIX7vxb84uOuCzSARfk9jqLYQVS1/G3huYAT7sEHsRJRYJ3VeAo6Kvs+eRr/hpG2CkZxCxj/lFEylxE8YOPIKVzY9b7rffv6tDpDGEfWgaYHYT+1W8rJvgOqoHI9nm0C3gu6GmtDRv/tYMZ1KKRifWIpzDbX8q2DAqx34orU23yMaxtw55ih75zTNhlbnmOFawGNClq9BxgCTdT+yX7fHlj6KaYD/dr17bJ8qehXAUWvmRD7BheGzo6zycbmlqC6wyyyEgM+cefnCv2ItVPNYTHIFUYmil29mYv7KIRe7VcMeUcT1QC6aTEsEi+3a8hbH2wnsPEIoXEBPlfJSr9zIAyBdrzuOrY0UU/cNWYiDW3d1KjvWpUaCm9tm06v+AZAM5jnHGTSjEcJWLKWnMoRfufaQyJrs5ULI+xzkBoSDjfB3jRb0+apJgjuBlel4EDlM/e2Ba+HI4OSL3n3UXwX/JYORFayco4x+liX7Ikt+w+xFv3CTCtequEeDWYab7yN+5aWGwnURg8IP/iJTeughoTTj1+9E+vZZeSL2pwQsjwfq04Inx4YolryJXve4frf6v7Ug1nB9kutJvIA0OQAH//7/MtFf8hb8U1If9AbIkPZ3jAYcd8PH4OGP5uoFsjtKQx8E/SQ64q/7K2aB+zZouOOZMCKw8dPMQD0yO5F1ZjmI/6Ljfra2PrIr7MVwdID74V2M0WY9EG6e7Xq7Oly77x67M1N3QkOKtPqx7QVgBGLFCmW0ortUZEHk3NKkFCOOHWY5/oYhGX3bD97rfH2A2837KufPC0I3vae/u4sVKU
Received-SPF: pass client-ip=57.103.77.236;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_SPF_HELO=1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On Hypervisor.framework for macOS and WHPX for Windows, the provided environment is a GICv3 without ITS.

As such, support a GICv3 w/ GICv2m for that scenario.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 hw/arm/virt-acpi-build.c | 4 +++-
 hw/arm/virt.c            | 8 ++++++++
 include/hw/arm/virt.h    | 2 ++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 8bb6b60515..0a6ec74aa0 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -959,7 +959,9 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
             build_append_int_noprefix(table_data, memmap[VIRT_GIC_ITS].base, 8);
             build_append_int_noprefix(table_data, 0, 4);    /* Reserved */
         }
-    } else {
+    }
+
+    if (!(vms->gic_version != VIRT_GIC_VERSION_2 && vms->its) && !vms->no_gicv3_with_gicv2m) {
         const uint16_t spi_base = vms->irqmap[VIRT_GIC_V2M] + ARM_SPI_BASE;
 
         /* 5.2.12.16 GIC MSI Frame Structure */
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 175023897a..61d7bab803 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -956,6 +956,8 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
 
     if (vms->gic_version != VIRT_GIC_VERSION_2 && vms->its) {
         create_its(vms);
+    } else if (vms->gic_version != VIRT_GIC_VERSION_2 && !vms->no_gicv3_with_gicv2m) {
+        create_v2m(vms);
     } else if (vms->gic_version == VIRT_GIC_VERSION_2) {
         create_v2m(vms);
     }
@@ -2447,6 +2449,8 @@ static void machvirt_init(MachineState *machine)
     vms->ns_el2_virt_timer_irq = ns_el2_virt_timer_present() &&
         !vmc->no_ns_el2_virt_timer_irq;
 
+    vms->no_gicv3_with_gicv2m = vmc->no_gicv3_with_gicv2m;
+
     fdt_add_timer_nodes(vms);
     fdt_add_cpu_nodes(vms);
 
@@ -3484,6 +3488,7 @@ static void virt_instance_init(Object *obj)
     vms->its = true;
     /* Allow ITS emulation if the machine version supports it */
     vms->tcg_its = !vmc->no_tcg_its;
+    vms->no_gicv3_with_gicv2m = false;
 
     /* Default disallows iommu instantiation */
     vms->iommu = VIRT_IOMMU_NONE;
@@ -3536,9 +3541,12 @@ DEFINE_VIRT_MACHINE_AS_LATEST(10, 2)
 
 static void virt_machine_10_1_options(MachineClass *mc)
 {
+    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
+
     virt_machine_10_2_options(mc);
     mc->smbios_memory_device_size = 2047 * TiB;
     compat_props_add(mc->compat_props, hw_compat_10_1, hw_compat_10_1_len);
+    vmc->no_gicv3_with_gicv2m = true;
 }
 DEFINE_VIRT_MACHINE(10, 1)
 
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 04a09af354..d31348dd61 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -132,6 +132,7 @@ struct VirtMachineClass {
     bool no_cpu_topology;
     bool no_tcg_lpa2;
     bool no_ns_el2_virt_timer_irq;
+    bool no_gicv3_with_gicv2m;
     bool no_nested_smmu;
 };
 
@@ -180,6 +181,7 @@ struct VirtMachineState {
     char *oem_id;
     char *oem_table_id;
     bool ns_el2_virt_timer_irq;
+    bool no_gicv3_with_gicv2m;
     CXLState cxl_devices_state;
     bool legacy_smmuv3_present;
 };
-- 
2.50.1 (Apple Git-155)


