Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 564977A1D6F
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 13:29:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh6zd-0002Lg-0Y; Fri, 15 Sep 2023 07:28:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qh6za-0002L9-PK; Fri, 15 Sep 2023 07:28:10 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qh6zY-0008Rq-MP; Fri, 15 Sep 2023 07:28:10 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1c43166b7e5so5068625ad.3; 
 Fri, 15 Sep 2023 04:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694777287; x=1695382087; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u4pxKo28EN6eNVmjJP/msaheYD+q2Vlgd5Eur6zPdZc=;
 b=e+N+3CblN+b6tgg+G9bKS1G0B2yIGtlT0dDLUfvNFlwMAnW9cLtr5VugrPkJAMsTDI
 9c0OvYB7rryI1i61UOijl75ykzFu/XYI1nR/beoc00KCbdAAYJN5xVc389b0Cuk6dFu8
 iPZxKWmU1yc0H9HrPDrsG/QQy67ZId293i+faTHZ2j6vs2zWkyJk5xzOQk1SIRqNzm3r
 qlmqGnRDQVy59FtZcJpO8Br4jQy9FDHxCthv0fMR7vLw0GfItGFwZwN1ysMvYpJqzIjE
 LNlQ3szZvcaUWK8YHRYFL8R7+0yux8TnHD2Q8OVwvZXw8Ji/LE3NjZjedrFYp9ZfG9Lx
 k83A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694777287; x=1695382087;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u4pxKo28EN6eNVmjJP/msaheYD+q2Vlgd5Eur6zPdZc=;
 b=m2yC1vovM/o3b16RpLrGl9Bumxd3BeY+Hwf8kmzyhQLrU60tHo+KCXM/KR7Ph4r8Wl
 V2VkvMf9/S72kGZ0Rc/dp67J3z/YnOspJ0Y+Twj5CUoNfxYZ4t1RFXyMIAT7MKAs/k2W
 mj4Zh+E6WdS7KEILf1sa1SBYJthsGfLzcn2TAh7Cw6FB1CmZM4fLGoaU0clFYiraaNNh
 w/LTgyIiUCDz+bnmTUIZjd8AMhXKm9Zeu6HPbazClDw6jBd9OJWQ2TNkAMsELY3QAXZn
 1sl44mT+if5tcY12WXOSWFydKKYhu006bYCDarHaQOovDO+/PV5KGuuiharEQCU2zfqt
 GO7w==
X-Gm-Message-State: AOJu0Yw9cz7uyIFyTBLg1HekwiZgcN2uHAUajSO7U4Et5NpFitDsbhSe
 ttvH0cVzrUTAn0OM9ey6f4k=
X-Google-Smtp-Source: AGHT+IFPiEyw5Fpjjx1d3laDrBZXFkIKscPsFPwaQ2/ZAP0evtYWgid63Rk2VZQvlWM4+9GhhTnkkw==
X-Received: by 2002:a17:902:9684:b0:1b8:8af0:416f with SMTP id
 n4-20020a170902968400b001b88af0416fmr1177787plp.1.1694777286848; 
 Fri, 15 Sep 2023 04:28:06 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u1-20020a170902e5c100b001b1a2c14a4asm3277691plf.38.2023.09.15.04.28.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 04:28:06 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: lukas@wunner.de, wilfred.mallawa@wdc.com, Jonathan.Cameron@Huawei.com,
 jiewen.yao@intel.com, qemu-devel@nongnu.org, kbusch@kernel.org,
 its@irrelevant.dk, mst@redhat.com, marcel.apfelbaum@gmail.com,
 hchkuo@avery-design.com.tw, cbrowy@avery-design.com
Cc: alistair23@gmail.com, qemu-block@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 3/3] hw/nvme: Add SPDM over DOE support
Date: Fri, 15 Sep 2023 21:27:23 +1000
Message-ID: <20230915112723.2033330-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230915112723.2033330-1-alistair.francis@wdc.com>
References: <20230915112723.2033330-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Wilfred Mallawa <wilfred.mallawa@wdc.com>

Setup Data Object Exchance (DOE) as an extended capability for the NVME
controller and connect SPDM to it (CMA) to it.

Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 docs/specs/index.rst        |  1 +
 docs/specs/spdm.rst         | 56 +++++++++++++++++++++++++++++++++++++
 include/hw/pci/pci_device.h |  5 ++++
 include/hw/pci/pcie_doe.h   |  3 ++
 hw/nvme/ctrl.c              | 52 ++++++++++++++++++++++++++++++++++
 hw/nvme/trace-events        |  1 +
 6 files changed, 118 insertions(+)
 create mode 100644 docs/specs/spdm.rst

diff --git a/docs/specs/index.rst b/docs/specs/index.rst
index e58be38c41..c398541388 100644
--- a/docs/specs/index.rst
+++ b/docs/specs/index.rst
@@ -24,3 +24,4 @@ guest hardware that is specific to QEMU.
    acpi_erst
    sev-guest-firmware
    fw_cfg
+   spdm
diff --git a/docs/specs/spdm.rst b/docs/specs/spdm.rst
new file mode 100644
index 0000000000..0f96d618ef
--- /dev/null
+++ b/docs/specs/spdm.rst
@@ -0,0 +1,56 @@
+======================================================
+QEMU Security Protocols and Data Models (SPDM) Support
+======================================================
+
+SPDM enables authentication, attestation and key exchange to assist in
+providing infrastructure security enablement. It's a standard published
+by the DMTF https://www.dmtf.org/standards/SPDM.
+
+Setting up a SPDM server
+========================
+
+When using QEMU with SPDM devices QEMU will connect to a server which
+implements the SPDM functionality.
+
+spdm-emu
+--------
+
+You can use spdm-emu https://github.com/dmtf/spdm-emu to model the
+SPDM responder.
+
+.. code-block:: shell
+
+    $ cd spdm-emu
+    $ git submodule init; git submodule update --recursive
+    $ mkdir build; cd build
+    $ cmake -DARCH=x64 -DTOOLCHAIN=GCC -DTARGET=Debug -DCRYPTO=openssl ..
+    $ make -j32
+    $ make copy_sample_key # Build certificates, required for SPDM authentication.
+
+The responder can then be launched with
+
+.. code-block:: shell
+
+    $ cd bin
+    $ ./spdm_responder_emu --trans PCI_DOE
+
+Connecting an SPDM NVMe device
+==============================
+
+Once a SPDM server is running we can start QEMU and connect to the server.
+
+For an NVMe device first let's setup a block we can use
+
+.. code-block:: shell
+
+    $ cd qemu-spdm/linux/image
+    $ dd if=/dev/zero of=blknvme bs=1M count=2096 # 2GB NNMe Drive
+
+Then you can add this to your QEMU command line:
+
+.. code-block:: shell
+
+    -drive file=blknvme,if=none,id=mynvme,format=raw \
+    -device nvme,drive=mynvme,serial=deadbeef,spdm=2323
+
+At which point QEMU will connect to the SPDM server.
diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
index d3dd0f64b2..b8379c78f1 100644
--- a/include/hw/pci/pci_device.h
+++ b/include/hw/pci/pci_device.h
@@ -3,6 +3,7 @@
 
 #include "hw/pci/pci.h"
 #include "hw/pci/pcie.h"
+#include "hw/pci/pcie_doe.h"
 
 #define TYPE_PCI_DEVICE "pci-device"
 typedef struct PCIDeviceClass PCIDeviceClass;
@@ -157,6 +158,10 @@ struct PCIDevice {
     MSIVectorReleaseNotifier msix_vector_release_notifier;
     MSIVectorPollNotifier msix_vector_poll_notifier;
 
+    /* DOE */
+    DOECap doe_spdm;
+    uint16_t spdm_port;
+
     /* ID of standby device in net_failover pair */
     char *failover_pair_id;
     uint32_t acpi_index;
diff --git a/include/hw/pci/pcie_doe.h b/include/hw/pci/pcie_doe.h
index 15d94661f9..eb8f4e393d 100644
--- a/include/hw/pci/pcie_doe.h
+++ b/include/hw/pci/pcie_doe.h
@@ -108,6 +108,9 @@ struct DOECap {
     /* Protocols and its callback response */
     DOEProtocol *protocols;
     uint16_t protocol_num;
+
+    /* Used for spdm-socket */
+    int socket;
 };
 
 void pcie_doe_init(PCIDevice *pdev, DOECap *doe_cap, uint16_t offset,
diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 90687b168a..1ff30a9ad4 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -203,6 +203,7 @@
 #include "sysemu/hostmem.h"
 #include "hw/pci/msix.h"
 #include "hw/pci/pcie_sriov.h"
+#include "sysemu/spdm-socket.h"
 #include "migration/vmstate.h"
 
 #include "nvme.h"
@@ -8077,6 +8078,28 @@ static int nvme_add_pm_capability(PCIDevice *pci_dev, uint8_t offset)
     return 0;
 }
 
+static bool pcie_doe_spdm_rsp(DOECap *doe_cap)
+{
+    void *req = pcie_doe_get_write_mbox_ptr(doe_cap);
+    uint32_t req_len = pcie_doe_get_obj_len(req) * 4;
+    void *rsp = doe_cap->read_mbox;
+    uint32_t rsp_len = SPDM_SOCKET_MAX_MESSAGE_BUFFER_SIZE;
+    uint32_t recvd;
+
+    recvd = spdm_socket_rsp(doe_cap->socket,
+                             SPDM_SOCKET_TRANSPORT_TYPE_PCI_DOE,
+                             req, req_len, rsp, rsp_len);
+    doe_cap->read_mbox_len += DIV_ROUND_UP(recvd, 4);
+
+    return (recvd == 0) ? false : true;
+}
+
+static DOEProtocol doe_spdm_prot[] = {
+    { PCI_VENDOR_ID_PCI_SIG, PCI_SIG_DOE_CMA, pcie_doe_spdm_rsp },
+    { PCI_VENDOR_ID_PCI_SIG, PCI_SIG_DOE_SECURED_CMA, pcie_doe_spdm_rsp },
+    { }
+};
+
 static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
 {
     ERRP_GUARD();
@@ -8133,6 +8156,23 @@ static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
 
     nvme_update_msixcap_ts(pci_dev, n->conf_msix_qsize);
 
+    pcie_cap_deverr_init(pci_dev);
+
+    /* DOE Initialisation */
+    if (pci_dev->spdm_port) {
+        uint16_t doe_offset = n->params.sriov_max_vfs ?
+                                  PCI_CONFIG_SPACE_SIZE + PCI_ARI_SIZEOF
+                                  : PCI_CONFIG_SPACE_SIZE;
+
+        pcie_doe_init(pci_dev, &pci_dev->doe_spdm, doe_offset, doe_spdm_prot, true, 0);
+
+        pci_dev->doe_spdm.socket = spdm_socket_connect(pci_dev->spdm_port, errp);
+
+        if (pci_dev->doe_spdm.socket < 0 ) {
+            trace_pci_cma_err_openspdm_conn();
+        }
+    }
+
     if (n->params.cmb_size_mb) {
         nvme_init_cmb(n, pci_dev);
     }
@@ -8419,6 +8459,7 @@ static Property nvme_props[] = {
                       params.sriov_max_vi_per_vf, 0),
     DEFINE_PROP_UINT8("sriov_max_vq_per_vf", NvmeCtrl,
                       params.sriov_max_vq_per_vf, 0),
+    DEFINE_PROP_UINT16("spdm", PCIDevice, spdm_port, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -8501,10 +8542,20 @@ static void nvme_pci_write_config(PCIDevice *dev, uint32_t address,
                                   uint32_t val, int len)
 {
     nvme_sriov_pre_write_ctrl(dev, address, val, len);
+    pcie_doe_write_config(&dev->doe_spdm, address, val, len);
     pci_default_write_config(dev, address, val, len);
     pcie_cap_flr_write_config(dev, address, val, len);
 }
 
+static uint32_t nvme_pci_read_config(PCIDevice *dev, uint32_t address, int len)
+{
+    uint32_t val;
+    if (pcie_doe_read_config(&dev->doe_spdm, address, len, &val)) {
+        return val;
+    }
+    return pci_default_read_config(dev, address, len);
+}
+
 static const VMStateDescription nvme_vmstate = {
     .name = "nvme",
     .unmigratable = 1,
@@ -8517,6 +8568,7 @@ static void nvme_class_init(ObjectClass *oc, void *data)
 
     pc->realize = nvme_realize;
     pc->config_write = nvme_pci_write_config;
+    pc->config_read = nvme_pci_read_config;
     pc->exit = nvme_exit;
     pc->class_id = PCI_CLASS_STORAGE_EXPRESS;
     pc->revision = 2;
diff --git a/hw/nvme/trace-events b/hw/nvme/trace-events
index 3a67680c6a..c0e2ce9fda 100644
--- a/hw/nvme/trace-events
+++ b/hw/nvme/trace-events
@@ -191,6 +191,7 @@ pci_nvme_err_startfail(void) "setting controller enable bit failed"
 pci_nvme_err_startfail_virt_state(uint16_t vq, uint16_t vi) "nvme_start_ctrl failed due to ctrl state: vi=%u vq=%u"
 pci_nvme_err_invalid_mgmt_action(uint8_t action) "action=0x%"PRIx8""
 pci_nvme_err_ignored_mmio_vf_offline(uint64_t addr, unsigned size) "addr 0x%"PRIx64" size %d"
+pci_cma_err_openspdm_conn(void) "Failed to connect to OpenSPDM, SPDM disabled"
 
 # undefined behavior
 pci_nvme_ub_mmiowr_misaligned32(uint64_t offset) "MMIO write not 32-bit aligned, offset=0x%"PRIx64""
-- 
2.41.0


