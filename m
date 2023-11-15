Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A31F17DC519
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 05:02:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxfwG-0001SZ-5z; Tue, 31 Oct 2023 00:01:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qxfw0-0001PH-W0; Tue, 31 Oct 2023 00:00:58 -0400
Received: from mail-pl1-f180.google.com ([209.85.214.180])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qxfvt-0005H7-N1; Tue, 31 Oct 2023 00:00:56 -0400
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-1cc5916d578so11442795ad.2; 
 Mon, 30 Oct 2023 21:00:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698724844; x=1699329644;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kbEmVzxDZE5CmQEe9JfdJ9IgvP2TnryCWvKabJnogaE=;
 b=c1cH4PY6xKaHHo26Ws6ZQd1ontZTU8JMYRvbm9PO8ckC+qxLHM271zve3cMc9h8eEr
 LwIqcpAewgTHIMYdQQBdKY3vXP7lOGAbSnJLdtJWidz27PDIFq3GcQlxMtWHaW/5fqZE
 C69L6X/cVZtFEB+H16ND3PV0pM4F3CBHGLJfNKNmeIis6BXznHXj9MNIo+iHiD31Oe4f
 1L4UohovCtY9Mfm6fJY047nALQmE55is2OOwtz3q21ZnWEX5/Vo6IyqOYNJcOoP8jA1L
 cewSf+bxArG9TKQJw6obi1BK0NmRUIm5IXE6hYZdxgRY/oKab9kc+sJRWl7mudYtiAp2
 Mpqw==
X-Gm-Message-State: AOJu0YzlbVcJp5Abmd7VPex7sGlQLeetYaHRySQZvZrQUKOvSJusFo3b
 KeM5utJB07Jr0tT4TVJDUtom0tJPFdxozQ==
X-Google-Smtp-Source: AGHT+IFndhTXvFc+4D27JkFCE65qTkuqJ5jB1QbNVE8cKY05P6uyknZAVIUaqLsa7fDMT1yF4osShw==
X-Received: by 2002:a17:902:c949:b0:1cc:287e:9be3 with SMTP id
 i9-20020a170902c94900b001cc287e9be3mr11990478pla.67.1698724844414; 
 Mon, 30 Oct 2023 21:00:44 -0700 (PDT)
Received: from localhost.localdomain ([2601:642:4c02:7b37:49a8:6e6e:cee6:cee7])
 by smtp.gmail.com with ESMTPSA id
 h4-20020a170902f54400b001bbfa86ca3bsm257975plf.78.2023.10.30.21.00.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 30 Oct 2023 21:00:44 -0700 (PDT)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Cc: Joelle van Dyne <j@getutm.app>, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Song Gao <gaosong@loongson.cn>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs),
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs)
Subject: [PATCH v4 11/14] tpm_crb_sysbus: introduce TPM CRB SysBus device
Date: Mon, 30 Oct 2023 21:00:14 -0700
Message-ID: <20231031040021.65582-12-j@getutm.app>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231031040021.65582-1-j@getutm.app>
References: <20231031040021.65582-1-j@getutm.app>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.214.180; envelope-from=osy86dev@gmail.com;
 helo=mail-pl1-f180.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This SysBus variant of the CRB interface supports dynamically locating
the MMIO interface so that Virt machines can use it. This interface
is currently the only one supported by QEMU that works on Windows 11
ARM64 as 'tpm-tis-device' does not work with current Windows drivers.
We largely follow that device as a template.

To try out this device with Windows 11 before OVMF is updated, you
will need to modify `sysbus-fdt.c` and change the added line from:

```c
    TYPE_BINDING(TYPE_TPM_CRB_SYSBUS, no_fdt_node),
```

to

```c
    TYPE_BINDING(TYPE_TPM_CRB_SYSBUS, add_tpm_tis_fdt_node),
```

This change was not included because it can confuse Linux (although
from testing, it seems like Linux is able to properly ignore the
device from the TPM TIS driver and recognize it from the ACPI device
in the TPM CRB driver). A proper fix would require OVMF to recognize
the ACPI device and not depend on the FDT node for recognizing TPM.

The command line to try out this device with SWTPM is:

```
$ qemu-system-aarch64 \
    -chardev socket,id=chrtpm0,path=tpm.sock \
    -tpmdev emulator,id=tpm0,chardev=chrtpm0 \
    -device tpm-crb-device,tpmdev=tpm0
```

along with SWTPM:

```
$ swtpm \
    --ctrl type=unixio,path=tpm.sock,terminate \
    --tpmstate backend-uri=file://tpm.data \
    --tpm2
```

Signed-off-by: Joelle van Dyne <j@getutm.app>
---
 docs/specs/tpm.rst      |   1 +
 include/sysemu/tpm.h    |   3 +
 hw/acpi/aml-build.c     |   7 +-
 hw/arm/virt.c           |   1 +
 hw/core/sysbus-fdt.c    |   1 +
 hw/loongarch/virt.c     |   1 +
 hw/riscv/virt.c         |   1 +
 hw/tpm/tpm_crb_sysbus.c | 162 ++++++++++++++++++++++++++++++++++++++++
 hw/arm/Kconfig          |   1 +
 hw/loongarch/Kconfig    |   1 +
 hw/riscv/Kconfig        |   1 +
 hw/tpm/Kconfig          |   5 ++
 hw/tpm/meson.build      |   3 +
 13 files changed, 187 insertions(+), 1 deletion(-)
 create mode 100644 hw/tpm/tpm_crb_sysbus.c

diff --git a/docs/specs/tpm.rst b/docs/specs/tpm.rst
index 2bc29c9804..95aeb49220 100644
--- a/docs/specs/tpm.rst
+++ b/docs/specs/tpm.rst
@@ -46,6 +46,7 @@ operating system.
 QEMU files related to TPM CRB interface:
  - ``hw/tpm/tpm_crb.c``
  - ``hw/tpm/tpm_crb_common.c``
+ - ``hw/tpm/tpm_crb_sysbus.c``
 
 SPAPR interface
 ---------------
diff --git a/include/sysemu/tpm.h b/include/sysemu/tpm.h
index ffd300e607..bab30fa546 100644
--- a/include/sysemu/tpm.h
+++ b/include/sysemu/tpm.h
@@ -49,6 +49,7 @@ struct TPMIfClass {
 #define TYPE_TPM_TIS_ISA            "tpm-tis"
 #define TYPE_TPM_TIS_SYSBUS         "tpm-tis-device"
 #define TYPE_TPM_CRB                "tpm-crb"
+#define TYPE_TPM_CRB_SYSBUS         "tpm-crb-device"
 #define TYPE_TPM_SPAPR              "tpm-spapr"
 #define TYPE_TPM_TIS_I2C            "tpm-tis-i2c"
 
@@ -58,6 +59,8 @@ struct TPMIfClass {
     object_dynamic_cast(OBJECT(chr), TYPE_TPM_TIS_SYSBUS)
 #define TPM_IS_CRB(chr)                             \
     object_dynamic_cast(OBJECT(chr), TYPE_TPM_CRB)
+#define TPM_IS_CRB_SYSBUS(chr)                      \
+    object_dynamic_cast(OBJECT(chr), TYPE_TPM_CRB_SYSBUS)
 #define TPM_IS_SPAPR(chr)                           \
     object_dynamic_cast(OBJECT(chr), TYPE_TPM_SPAPR)
 #define TPM_IS_TIS_I2C(chr)                      \
diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index af66bde0f5..acc654382e 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -31,6 +31,7 @@
 #include "hw/pci/pci_bus.h"
 #include "hw/pci/pci_bridge.h"
 #include "qemu/cutils.h"
+#include "qom/object.h"
 
 static GArray *build_alloc_array(void)
 {
@@ -2218,7 +2219,7 @@ void build_tpm2(GArray *table_data, BIOSLinker *linker, GArray *tcpalog,
 {
     uint8_t start_method_params[12] = {};
     unsigned log_addr_offset;
-    uint64_t control_area_start_address;
+    uint64_t baseaddr, control_area_start_address;
     TPMIf *tpmif = tpm_find();
     uint32_t start_method;
     AcpiTable table = { .sig = "TPM2", .rev = 4,
@@ -2236,6 +2237,10 @@ void build_tpm2(GArray *table_data, BIOSLinker *linker, GArray *tcpalog,
     } else if (TPM_IS_CRB(tpmif)) {
         control_area_start_address = TPM_CRB_ADDR_CTRL;
         start_method = TPM2_START_METHOD_CRB;
+    } else if (TPM_IS_CRB_SYSBUS(tpmif)) {
+        baseaddr = object_property_get_uint(OBJECT(tpmif), "x-baseaddr", NULL);
+        control_area_start_address = baseaddr + A_CRB_CTRL_REQ;
+        start_method = TPM2_START_METHOD_CRB;
     } else {
         g_assert_not_reached();
     }
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index f1a161b0ea..22e147f71a 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2950,6 +2950,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_VFIO_PLATFORM);
 #ifdef CONFIG_TPM
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_TPM_TIS_SYSBUS);
+    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_TPM_CRB_SYSBUS);
 #endif
     mc->block_default_type = IF_VIRTIO;
     mc->no_cdrom = 1;
diff --git a/hw/core/sysbus-fdt.c b/hw/core/sysbus-fdt.c
index eebcd28f9a..9c783f88eb 100644
--- a/hw/core/sysbus-fdt.c
+++ b/hw/core/sysbus-fdt.c
@@ -493,6 +493,7 @@ static const BindingEntry bindings[] = {
 #endif
 #ifdef CONFIG_TPM
     TYPE_BINDING(TYPE_TPM_TIS_SYSBUS, add_tpm_tis_fdt_node),
+    TYPE_BINDING(TYPE_TPM_CRB_SYSBUS, no_fdt_node),
 #endif
     TYPE_BINDING(TYPE_RAMFB_DEVICE, no_fdt_node),
     TYPE_BINDING("", NULL), /* last element */
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index feed0f8bbf..9d5ad2bc8e 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -1114,6 +1114,7 @@ static void loongarch_class_init(ObjectClass *oc, void *data)
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_RAMFB_DEVICE);
 #ifdef CONFIG_TPM
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_TPM_TIS_SYSBUS);
+    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_TPM_CRB_SYSBUS);
 #endif
 }
 
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 9de578c756..c0d2cd1d60 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1702,6 +1702,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_RAMFB_DEVICE);
 #ifdef CONFIG_TPM
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_TPM_TIS_SYSBUS);
+    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_TPM_CRB_SYSBUS);
 #endif
 
 
diff --git a/hw/tpm/tpm_crb_sysbus.c b/hw/tpm/tpm_crb_sysbus.c
new file mode 100644
index 0000000000..7edeae3665
--- /dev/null
+++ b/hw/tpm/tpm_crb_sysbus.c
@@ -0,0 +1,162 @@
+/*
+ * tpm_crb_sysbus.c - QEMU's TPM CRB interface emulator
+ *
+ * Copyright (c) 2018 Red Hat, Inc.
+ *
+ * Authors:
+ *   Marc-André Lureau <marcandre.lureau@redhat.com>
+ *   Joelle van Dyne <j@getutm.app>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ * tpm_crb is a device for TPM 2.0 Command Response Buffer (CRB) Interface
+ * as defined in TCG PC Client Platform TPM Profile (PTP) Specification
+ * Family “2.0” Level 00 Revision 01.03 v22
+ */
+
+#include "qemu/osdep.h"
+#include "hw/acpi/acpi_aml_interface.h"
+#include "hw/acpi/tpm.h"
+#include "hw/qdev-properties.h"
+#include "migration/vmstate.h"
+#include "tpm_prop.h"
+#include "hw/sysbus.h"
+#include "qapi/visitor.h"
+#include "qom/object.h"
+#include "sysemu/tpm_util.h"
+#include "trace.h"
+#include "tpm_crb.h"
+
+struct TPMCRBStateSysBus {
+    /*< private >*/
+    SysBusDevice parent_obj;
+
+    /*< public >*/
+    TPMCRBState state;
+    uint64_t baseaddr;
+    uint64_t size;
+};
+
+OBJECT_DECLARE_SIMPLE_TYPE(TPMCRBStateSysBus, TPM_CRB_SYSBUS)
+
+static void tpm_crb_sysbus_request_completed(TPMIf *ti, int ret)
+{
+    TPMCRBStateSysBus *s = TPM_CRB_SYSBUS(ti);
+
+    return tpm_crb_request_completed(&s->state, ret);
+}
+
+static enum TPMVersion tpm_crb_sysbus_get_tpm_version(TPMIf *ti)
+{
+    TPMCRBStateSysBus *s = TPM_CRB_SYSBUS(ti);
+
+    return tpm_crb_get_version(&s->state);
+}
+
+static int tpm_crb_sysbus_pre_save(void *opaque)
+{
+    TPMCRBStateSysBus *s = opaque;
+
+    return tpm_crb_pre_save(&s->state);
+}
+
+static const VMStateDescription vmstate_tpm_crb_sysbus = {
+    .name = "tpm-crb-sysbus",
+    .pre_save = tpm_crb_sysbus_pre_save,
+    .fields = (VMStateField[]) {
+        VMSTATE_END_OF_LIST(),
+    }
+};
+
+static Property tpm_crb_sysbus_properties[] = {
+    DEFINE_PROP_TPMBE("tpmdev", TPMCRBStateSysBus, state.tpmbe),
+    DEFINE_PROP_UINT64("x-baseaddr", TPMCRBStateSysBus,
+                       baseaddr, TPM_CRB_ADDR_BASE),
+    DEFINE_PROP_UINT64("x-size", TPMCRBStateSysBus,
+                       size, TPM_CRB_ADDR_SIZE),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void tpm_crb_sysbus_initfn(Object *obj)
+{
+    TPMCRBStateSysBus *s = TPM_CRB_SYSBUS(obj);
+
+    tpm_crb_init_memory(obj, &s->state, NULL);
+
+    vmstate_register_ram(&s->state.mmio, DEVICE(obj));
+
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->state.mmio);
+}
+
+static void tpm_crb_sysbus_reset(DeviceState *dev)
+{
+    TPMCRBStateSysBus *s = TPM_CRB_SYSBUS(dev);
+
+    return tpm_crb_reset(&s->state, s->baseaddr);
+}
+
+static void tpm_crb_sysbus_realizefn(DeviceState *dev, Error **errp)
+{
+    TPMCRBStateSysBus *s = TPM_CRB_SYSBUS(dev);
+
+    if (!tpm_find()) {
+        error_setg(errp, "at most one TPM device is permitted");
+        return;
+    }
+
+    if (!s->state.tpmbe) {
+        error_setg(errp, "'tpmdev' property is required");
+        return;
+    }
+
+    if (tpm_crb_sysbus_get_tpm_version(TPM_IF(s)) != TPM_VERSION_2_0) {
+        error_setg(errp, "TPM CRB only supports TPM 2.0 backends");
+        return;
+    }
+}
+
+static void build_tpm_crb_sysbus_aml(AcpiDevAmlIf *adev, Aml *scope)
+{
+    TPMCRBStateSysBus *s = TPM_CRB_SYSBUS(adev);
+
+    tpm_crb_build_aml(TPM_IF(adev), scope, s->baseaddr, s->size, false);
+}
+
+static void tpm_crb_sysbus_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    TPMIfClass *tc = TPM_IF_CLASS(klass);
+    AcpiDevAmlIfClass *adevc = ACPI_DEV_AML_IF_CLASS(klass);
+
+    device_class_set_props(dc, tpm_crb_sysbus_properties);
+    dc->vmsd  = &vmstate_tpm_crb_sysbus;
+    tc->model = TPM_MODEL_TPM_CRB;
+    dc->realize = tpm_crb_sysbus_realizefn;
+    dc->user_creatable = true;
+    dc->reset = tpm_crb_sysbus_reset;
+    tc->request_completed = tpm_crb_sysbus_request_completed;
+    tc->get_version = tpm_crb_sysbus_get_tpm_version;
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    adevc->build_dev_aml = build_tpm_crb_sysbus_aml;
+}
+
+static const TypeInfo tpm_crb_sysbus_info = {
+    .name = TYPE_TPM_CRB_SYSBUS,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(TPMCRBStateSysBus),
+    .instance_init = tpm_crb_sysbus_initfn,
+    .class_init  = tpm_crb_sysbus_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_TPM_IF },
+        { TYPE_ACPI_DEV_AML_IF },
+        { }
+    }
+};
+
+static void tpm_crb_sysbus_register(void)
+{
+    type_register_static(&tpm_crb_sysbus_info);
+}
+
+type_init(tpm_crb_sysbus_register)
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 7e68348440..efe1beaa7b 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -5,6 +5,7 @@ config ARM_VIRT
     imply VFIO_AMD_XGBE
     imply VFIO_PLATFORM
     imply VFIO_XGMAC
+    imply TPM_CRB_SYSBUS
     imply TPM_TIS_SYSBUS
     imply TPM_TIS_I2C
     imply NVDIMM
diff --git a/hw/loongarch/Kconfig b/hw/loongarch/Kconfig
index 25da190ffc..70544f3ce5 100644
--- a/hw/loongarch/Kconfig
+++ b/hw/loongarch/Kconfig
@@ -6,6 +6,7 @@ config LOONGARCH_VIRT
     imply PCI_DEVICES
     imply NVDIMM
     imply TPM_TIS_SYSBUS
+    imply TPM_CRB_SYSBUS
     select SERIAL
     select VIRTIO_PCI
     select PLATFORM_BUS
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index b6a5eb4452..d824cb58f9 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -29,6 +29,7 @@ config RISCV_VIRT
     imply PCI_DEVICES
     imply VIRTIO_VGA
     imply TEST_DEVICES
+    imply TPM_CRB_SYSBUS
     imply TPM_TIS_SYSBUS
     select RISCV_NUMA
     select GOLDFISH_RTC
diff --git a/hw/tpm/Kconfig b/hw/tpm/Kconfig
index a46663288c..28139c456a 100644
--- a/hw/tpm/Kconfig
+++ b/hw/tpm/Kconfig
@@ -25,6 +25,11 @@ config TPM_CRB
     depends on TPM && PC
     select TPM_BACKEND
 
+config TPM_CRB_SYSBUS
+    bool
+    depends on TPM
+    select TPM_BACKEND
+
 config TPM_SPAPR
     bool
     default y
diff --git a/hw/tpm/meson.build b/hw/tpm/meson.build
index 3060ac05e8..f2536c99e3 100644
--- a/hw/tpm/meson.build
+++ b/hw/tpm/meson.build
@@ -5,6 +5,9 @@ system_ss.add(when: 'CONFIG_TPM_TIS_SYSBUS', if_true: files('tpm-sysbus.c'))
 system_ss.add(when: 'CONFIG_TPM_TIS_I2C', if_true: files('tpm_tis_i2c.c'))
 system_ss.add(when: 'CONFIG_TPM_CRB', if_true: files('tpm_crb.c'))
 system_ss.add(when: 'CONFIG_TPM_CRB', if_true: files('tpm_crb_common.c'))
+system_ss.add(when: 'CONFIG_TPM_CRB_SYSBUS', if_true: files('tpm_crb_sysbus.c'))
+system_ss.add(when: 'CONFIG_TPM_CRB_SYSBUS', if_true: files('tpm_crb_common.c'))
+system_ss.add(when: 'CONFIG_TPM_CRB_SYSBUS', if_true: files('tpm-sysbus.c'))
 system_ss.add(when: 'CONFIG_TPM_TIS', if_true: files('tpm_ppi.c'))
 system_ss.add(when: 'CONFIG_TPM_CRB', if_true: files('tpm_ppi.c'))
 
-- 
2.41.0


