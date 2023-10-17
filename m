Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F827CB9F3
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 07:23:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qscXK-00013V-NG; Tue, 17 Oct 2023 01:22:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qscXH-00012p-J8; Tue, 17 Oct 2023 01:22:32 -0400
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qscXF-0000Jj-DX; Tue, 17 Oct 2023 01:22:31 -0400
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-57bab4e9e1aso3286712eaf.3; 
 Mon, 16 Oct 2023 22:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697520148; x=1698124948; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zGAS6AqZ0I2IEHRUbLOj33fXVjGwvQh98Z0cWyH5ntI=;
 b=j6DdBsk0dipubFZQ+u2ULeqrZb2jbmn+Mc2BDMyQ/5Arr8oNxyYcpK+wkyMR03PyS6
 Ol5tRNEgvPnY4Y834M/VTqfI6vVu3a0aPdo/7xr2Oyjng0EltG8xoDOMnclJmSNpHIAO
 9vnIuVB2ud78uMttk5CiFZv/czwM4W1e152kVZ5aUxx7xiVzoZHwkJUKklBvA9WK6Puv
 tv9MErSlMGUG7AgqJG+PeiQfYS7JSdeNLkhruYjdjWxTu59yDVXChlZtlsbnMNOVgH/0
 kAQGKptRd9D/WbJqTEOcdRSZLCnDtC+8WdC3pzzKcpkok7omPtah75VIvkr1v6QGWLxb
 MVTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697520148; x=1698124948;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zGAS6AqZ0I2IEHRUbLOj33fXVjGwvQh98Z0cWyH5ntI=;
 b=sEqfA5GfBIC6EHQyR+BN//8Sq8irWuhGrx9Ybx6XTKumzpPxFV1uL9GB5vU0+JNHGc
 dmzHRdMcPxLx2yBFe+wEcUSM56DLcc71ulCkAULxVoEno8NLq0NbZsg1Tm8G+QKQ7jzd
 wDi97xOG1zAvHVe2pgGHccUfsR943ARiLF2Czh8Ua8gxyYRojpCp85q9bzC1RuY9NKyV
 SWFDr8ISbm+FKvXwEVYHlDkBvij1j+DUUfFwRofMPxxLFMRMr5RzYpL+cbar9OXhdpYQ
 82QoHZJHv378i6kdiY4u8YeQY9UstJiB1tMfHmVyKI3aZtvY4YKlWps8vwr3XMLPUw0c
 kPWw==
X-Gm-Message-State: AOJu0YxDmJAaB9G4Z8hAK0VWwT4BNOVxKQ/CauNqcRc6Lp2J3ImAYBEx
 5pwlwItkgt/N63v47TTHly2ocuNlyOFVMg==
X-Google-Smtp-Source: AGHT+IE+55dM1qgMM0iyOrKvrD0UuIHhtRq/urFKr9X3FH7eIRiWw9iD8ReW87exn1SGmseqxV+k+A==
X-Received: by 2002:a05:6358:ee46:b0:139:a45c:32b2 with SMTP id
 ik6-20020a056358ee4600b00139a45c32b2mr1632085rwb.11.1697520147809; 
 Mon, 16 Oct 2023 22:22:27 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 t26-20020aa7947a000000b006933e71956dsm477222pfq.9.2023.10.16.22.22.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 22:22:26 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: cbrowy@avery-design.com, wilfred.mallawa@wdc.com, mst@redhat.com,
 lukas@wunner.de, kbusch@kernel.org, hchkuo@avery-design.com.tw,
 Jonathan.Cameron@Huawei.com, its@irrelevant.dk, jiewen.yao@intel.com,
 marcel.apfelbaum@gmail.com, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, alistair23@gmail.com,
 qemu-block@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 3/3] hw/nvme: Add SPDM over DOE support
Date: Tue, 17 Oct 2023 15:21:55 +1000
Message-ID: <20231017052155.173577-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231017052155.173577-1-alistair.francis@wdc.com>
References: <20231017052155.173577-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c36;
 envelope-from=alistair23@gmail.com; helo=mail-oo1-xc36.google.com
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
 docs/specs/index.rst        |   1 +
 docs/specs/spdm.rst         | 114 ++++++++++++++++++++++++++++++++++++
 include/hw/pci/pci_device.h |   5 ++
 include/hw/pci/pcie_doe.h   |   3 +
 hw/nvme/ctrl.c              |  53 +++++++++++++++++
 5 files changed, 176 insertions(+)
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
index 0000000000..dfdc3cbb4d
--- /dev/null
+++ b/docs/specs/spdm.rst
@@ -0,0 +1,114 @@
+======================================================
+QEMU Security Protocols and Data Models (SPDM) Support
+======================================================
+
+SPDM enables authentication, attestation and key exchange to assist in
+providing infrastructure security enablement. It's a standard published
+by the `DMTF`_.
+
+QEMU supports connecting to a SPDM Responder implementation. This allows an
+external application to emulate the SPDM Responder logic for an SPDM device.
+
+Setting up a SPDM server
+========================
+
+When using QEMU with SPDM devices QEMU will connect to a server which
+implements the SPDM functionality.
+
+SPDM-Utils
+----------
+
+You can use `SPDM Utils`_ to emulate a Responder.
+
+SPDM-Utils is a Linux applications to manage, test and develop devices
+supporting DMTF Security Protocol and Data Model (SPDM). It is written in Rust
+and utilises libspdm.
+
+To use SPDM-Utils you will need to do the followoing:
+
+ 1. `Build SPDM Utils`_
+ 2. `Generate the certificates`_
+ 3. `Run it as a server`_
+
+spdm-emu
+--------
+
+You can use `spdm emu`_ to model the
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
+It is worth noting that the certificates should be in compliance with
+PCIe r6.1 sec 6.31.3. This means you will need to add the following to
+openssl.cnf
+
+.. code-block::
+
+    subjectAltName = otherName:2.23.147;UTF8:Vendor=1b36:Device=0010:CC=010802:REV=02:SSVID=1af4:SSID=1100
+    2.23.147 = ASN1:OID:2.23.147
+
+and then manually regenerate some certificates with:
+
+.. code-block:: shell
+
+    openssl req -nodes -newkey ec:param.pem -keyout end_responder.key -out end_responder.req -sha384 -batch -subj "/CN=DMTF libspdm ECP384 responder cert"
+    openssl x509 -req -in end_responder.req -out end_responder.cert -CA inter.cert -CAkey inter.key -sha384 -days 3650 -set_serial 3 -extensions v3_end -extfile ../openssl.cnf
+    openssl asn1parse -in end_responder.cert -out end_responder.cert.der
+    cat ca.cert.der inter.cert.der end_responder.cert.der > bundle_responder.certchain.der
+
+You can use SPDM-Utils instead as it will generate the correct certificates
+automatically.
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
+At which point QEMU will try to connect to the SPDM server.
+
+
+.. _DMTF:
+   https://www.dmtf.org/standards/SPDM
+
+.. _SPDM Utils:
+   https://github.com/westerndigitalcorporation/spdm-utils
+
+.. _spdm emu:
+   https://github.com/dmtf/spdm-emu
+
+.. _Build SPDM Utils:
+   https://github.com/westerndigitalcorporation/spdm-utils#building
+
+.. _Generate the certificates:
+   https://github.com/westerndigitalcorporation/spdm-utils#generate-mutable-certificates
+
+.. _Run it as a server:
+   https://github.com/westerndigitalcorporation/spdm-utils#qemu-spdm-device-emulation
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
index f026245d1e..661ebe3725 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -203,6 +203,7 @@
 #include "sysemu/hostmem.h"
 #include "hw/pci/msix.h"
 #include "hw/pci/pcie_sriov.h"
+#include "sysemu/spdm-socket.h"
 #include "migration/vmstate.h"
 
 #include "nvme.h"
@@ -8070,6 +8071,28 @@ static int nvme_add_pm_capability(PCIDevice *pci_dev, uint8_t offset)
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
+    return recvd != 0;
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
@@ -8126,6 +8149,24 @@ static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
 
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
+            error_setg(errp, "Failed to connect to SPDM socket");
+            return -ENOTSUP;
+        }
+    }
+
     if (n->params.cmb_size_mb) {
         nvme_init_cmb(n, pci_dev);
     }
@@ -8412,6 +8453,7 @@ static Property nvme_props[] = {
                       params.sriov_max_vi_per_vf, 0),
     DEFINE_PROP_UINT8("sriov_max_vq_per_vf", NvmeCtrl,
                       params.sriov_max_vq_per_vf, 0),
+    DEFINE_PROP_UINT16("spdm", PCIDevice, spdm_port, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -8494,10 +8536,20 @@ static void nvme_pci_write_config(PCIDevice *dev, uint32_t address,
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
@@ -8510,6 +8562,7 @@ static void nvme_class_init(ObjectClass *oc, void *data)
 
     pc->realize = nvme_realize;
     pc->config_write = nvme_pci_write_config;
+    pc->config_read = nvme_pci_read_config;
     pc->exit = nvme_exit;
     pc->class_id = PCI_CLASS_STORAGE_EXPRESS;
     pc->revision = 2;
-- 
2.41.0


