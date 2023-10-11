Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BDD7C59A3
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 18:55:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqcT4-0000wy-W4; Wed, 11 Oct 2023 12:53:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_svaddagi@quicinc.com>)
 id 1qqcSy-0000ra-3I; Wed, 11 Oct 2023 12:53:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_svaddagi@quicinc.com>)
 id 1qqcSv-0001Cw-SS; Wed, 11 Oct 2023 12:53:47 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39BCOvo0024483; Wed, 11 Oct 2023 16:53:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=TD0IcuYXOGyDTAmfb8Jp1TAH7LH850Q/b2N2pnmRMWg=;
 b=TlDgh+HcWmB4iBrgP04L/ZR6mUmAB5+ctGF+229urxro6/1d+fOGCekb5R1ZPD9d2hsd
 7ykatZQKJvbaN7FaptMl/WP/euZI01YVBdxCPQwzmS4KC9v7AeXf5PDClEQ9/9HGKQ6V
 /85eK2EMVMUGKM/G/ccibVu6QjT/eRA8jmPCpyLHYfc+8+wp36OZF4p5GQBfCX1fG247
 Zn9uiisQDhQTA76WOYE8E7M1Whe5QqZwPNPLbqPgUjRW0GQqnd2znNGbVPIQWGKp/YuH
 ZRuCCwELIlxk3U4uROK2f2kxnfYApHmYXTpkhR5hzNTSfHNJ1fzb+75zLZU3aGRyZSSe DQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tnmds9pvf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Oct 2023 16:53:40 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com
 [10.47.209.197])
 by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39BGrdUT031925
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Oct 2023 16:53:39 GMT
Received: from blr-ubuntu-31.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Wed, 11 Oct 2023 09:53:35 -0700
From: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
To: <peter.maydell@linaro.org>, <alex.bennee@linaro.org>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: <quic_svaddagi@quicinc.com>, <quic_tsoni@quicinc.com>,
 <quic_pheragu@quicinc.com>, <quic_eberman@quicinc.com>,
 <quic_yvasi@quicinc.com>, <quic_cvanscha@quicinc.com>,
 <quic_mnalajal@quicinc.com>
Subject: [RFC/PATCH v0 12/12] gunyah: Documentation
Date: Wed, 11 Oct 2023 16:52:34 +0000
Message-ID: <20231011165234.1323725-13-quic_svaddagi@quicinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231011165234.1323725-1-quic_svaddagi@quicinc.com>
References: <20231011165234.1323725-1-quic_svaddagi@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: ML7z_9-ZyQqFAEOIqF5QI6CbEMGFGWgL
X-Proofpoint-GUID: ML7z_9-ZyQqFAEOIqF5QI6CbEMGFGWgL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-11_12,2023-10-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 clxscore=1015 spamscore=0 phishscore=0 impostorscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310110148
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=quic_svaddagi@quicinc.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Add gunyah.rst that provide some informaiton on how to build and test
'gunyah' accelerator with open-source Gunyah hypervisor.

Signed-off-by: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
---
 MAINTAINERS                |   1 +
 docs/system/arm/gunyah.rst | 214 +++++++++++++++++++++++++++++++++++++
 2 files changed, 215 insertions(+)
 create mode 100644 docs/system/arm/gunyah.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index 5a51633d11..f2933a3683 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -518,6 +518,7 @@ F: target/arm/gunyah.c
 F: include/sysemu/gunyah.h
 F: target/arm/arm_gicv3_gunyah.c
 F: include/sysemu/gunyah_int.h
+F: docs/system/arm/gunyah.rst
 
 WHPX CPUs
 M: Sunil Muthuswamy <sunilmut@microsoft.com>
diff --git a/docs/system/arm/gunyah.rst b/docs/system/arm/gunyah.rst
new file mode 100644
index 0000000000..4b3a792310
--- /dev/null
+++ b/docs/system/arm/gunyah.rst
@@ -0,0 +1,214 @@
+'gunyah' accelerator (``gunyah``)
+=================================
+
+Gunyah is a high performance, scalable and flexible hypervisor built for
+demanding battery powered, real-time, safety and security use cases.
+
+The Gunyah Hypervisor open source project provides a reference Type-1 hypervisor
+configuration suitable for general purpose hosting of multiple trusted and
+dependent VMs. Further information on open-source version of Gunyah Hypervisor
+can be obtained from:
+
+https://github.com/quic/gunyah-hypervisor
+
+To get started with open-source version of Gunyah Hypervisor, refer to the
+instructions available at:
+
+https://github.com/quic/gunyah-support-scripts
+
+Build and testing
+-----------------
+
+Patch and build Gunyah hypervisor
+`````````````````````````````````
+
+Refer to the information present in **Quick Start** guide to get sources for
+Gunyah open-source hypervisor:
+
+https://github.com/quic/gunyah-support-scripts/blob/develop/quickstart.md
+
+Resource Manager VM (RM) is a privileged VM that acts as an extension of Gunyah
+hypervisor. It assists the hypervisor in various tasks related to creation and
+management of VMs. More information on RM is provided at:
+
+https://github.com/quic/gunyah-resource-manager
+
+Instructions provided in **Quick Start** guide will include cloning the sources
+for RM (under 'resource-manager' directory) and hypervisor (under 'hyp'
+directory). These directories will be found inside the docker image created as
+part of steps provided under **Building the Docker Image**.
+
+Before building hypervisor, as described under **Building a Gunyah Hypervisor
+image** section of **Quick Start** guide, apply below changes to hypervisor and
+RM on which 'gunyah' accelerator currently depends. These changes are being
+discussed with maintainers and if accepted this document will be modified
+appropriately.
+
+RM patch (in 'resource-manager' directory):
+
+.. code-block:: bash
+
+	diff --git a/src/vm_creation/vm_creation.c b/src/vm_creation/vm_creation.c
+	index df8edfb..b73b37e 100644
+	--- a/src/vm_creation/vm_creation.c
+	+++ b/src/vm_creation/vm_creation.c
+	@@ -510,7 +510,10 @@ process_dtb(vm_t *vm)
+	        // Estimate a final dtb size after applying the overlay.
+	        size_t original_dtb_size =
+	                util_balign_up(fdt_totalsize(temp_addr), sizeof(uint32_t));
+	-       size_t final_dtb_size = original_dtb_size + dtbo_ret.size;
+	+       size_t final_dtb_size = util_balign_up(original_dtb_size + dtbo_ret.size, 8);
+
+
+Hypervisor patch (in 'hyp' directory):
+
+.. code-block:: bash
+
+	diff --git a/config/platform/qemu.conf b/config/platform/qemu.conf
+	index bc612f2..9a292a4 100644
+	--- a/config/platform/qemu.conf
+	+++ b/config/platform/qemu.conf
+	@@ -35,7 +35,7 @@ configs HLOS_RAM_FS_BASE=0x40800000
+	 configs PLATFORM_HEAP_PRIVATE_SIZE=0x200000
+	 configs PLATFORM_RW_DATA_SIZE=0x200000
+	 configs PLATFORM_ROOTVM_LMA_BASE=0x80480000U
+	-configs PLATFORM_ROOTVM_LMA_SIZE=0xa0000U
+	+configs PLATFORM_ROOTVM_LMA_SIZE=0x100000U
+	 configs PLATFORM_PHYS_ADDRESS_BITS=36
+	 configs PLATFORM_VM_ADDRESS_SPACE_BITS=36
+	 configs PLATFORM_PGTABLE_4K_GRANULE=1
+
+Build Gunyah hypervisor (including RM) as per the instructions provided in
+**Quick Start** guide, viz:
+
+.. code-block:: bash
+
+        cd ~/share
+        build-gunyah.sh qemu
+
+
+Patch and build Linux kernel
+````````````````````````````
+
+**Building the Docker Image** step of **Quick Start** guide would have cloned
+the sources for Linux kernel (under '~/linux/src/linux' directory in docker
+image) and also applied below patches.
+
+https://lore.kernel.org/lkml/20230613172054.3959700-1-quic_eberman@quicinc.com/
+
+Above patches provide a kernel driver that interacts with Gunyah hypervisor and
+assists a VMM (like Qemu) in creation and management of a VM. Apply below patch
+to Linux kernel, as the 'gunyah' accelerator in Qemu depends on it.
+
+.. code-block:: bash
+
+	diff --git a/drivers/virt/gunyah/gunyah_ioeventfd.c b/drivers/virt/gunyah/gunyah_ioeventfd.c
+	index 5b1b9fd9a..7bfb67800 100644
+	--- a/drivers/virt/gunyah/gunyah_ioeventfd.c
+	+++ b/drivers/virt/gunyah/gunyah_ioeventfd.c
+	@@ -88,6 +88,7 @@ static long gh_ioeventfd_bind(struct gh_vm_function_instance *f)
+	        }
+	        iofd->io_handler.addr = args->addr;
+	        iofd->io_handler.ops = &io_ops;
+	+       iofd->io_handler.fd = args->fd;
+
+	        ret = gh_vm_add_io_handler(f->ghvm, &iofd->io_handler);
+	        if (ret)
+	@@ -120,7 +121,7 @@ static bool gh_ioevent_compare(const struct gh_vm_function_instance *f,
+	        if (sizeof(*other) != size)
+	                return false;
+
+	-       return instance->addr == other->addr;
+	+       return instance->addr == other->addr && instance->fd == other->fd;
+	 }
+
+	 DECLARE_GH_VM_FUNCTION_INIT(ioeventfd, GH_FN_IOEVENTFD, 3,
+	diff --git a/drivers/virt/gunyah/vm_mgr.c b/drivers/virt/gunyah/vm_mgr.c
+	index afea49238..c4604d4e9 100644
+	--- a/drivers/virt/gunyah/vm_mgr.c
+	+++ b/drivers/virt/gunyah/vm_mgr.c
+	@@ -291,6 +291,10 @@ static int _gh_vm_io_handler_compare(const struct rb_node *node, const struct rb
+	                return -1;
+	        if (n->len > p->len)
+	                return 1;
+	+       if (n->fd > p->fd)
+	+               return 1;
+	+       if (n->fd < p->fd)
+	+               return -1;
+	        /* one of the io handlers doesn't have datamatch and the other does.
+	         * For purposes of comparison, that makes them identical since the
+	         * one that doesn't have datamatch will cover the same handler that
+	diff --git a/include/linux/gunyah_vm_mgr.h b/include/linux/gunyah_vm_mgr.h
+	index 527e94624..b2e95d02c 100644
+	--- a/include/linux/gunyah_vm_mgr.h
+	+++ b/include/linux/gunyah_vm_mgr.h
+	@@ -136,6 +136,7 @@ struct gh_vm_io_handler {
+	        bool datamatch;
+	        u8 len;
+	        u64 data;
+	+       int fd;
+	        struct gh_vm_io_handler_ops *ops;
+	 };
+
+Run 'build-linux.sh' inside the docker container to build Linux kernel, which
+provides the image for host kernel.
+
+.. code-block:: bash
+
+        $ cd ~/
+        $ build-linux.sh
+
+
+This will result in Linux kernel binary (Image) and an initrd image (initrd.img)
+being created and copied to '~/tools/qemu/imgs' directory. Those images can be
+used for both host kernel as well as for a VM.
+
+
+Configure and build Qemu
+````````````````````````
+
+Apply the proposed patches for 'gunyah' accelerator support in Qemu and build
+it.
+
+.. code-block:: bash
+
+        $ ./configure --target-list=aarch64-softmmu --enable-debug --enable-gunyah --static
+        $ make -j4
+
+Incorporate Qemu image in root disk
+```````````````````````````````````
+
+Copy over the resulting Qemu static binary ('qemu-system-aarch64') into the
+docker image. In addition, copy 'efi-virtio.rom' and 'en-us' (from Qemu
+repository) into the docker image.
+
+Follow the instructions under **SVM booting Linux** to prepare a virtual disk
+that can host the required images. Since Qemu is going to be used in place of
+CrosVM, ignore the CrosVM related steps, and instead copy these files to
+'~/share/docker-share/rootfs/usr/gunyah' folder before running
+'~/utils/bldextfs.sh' script to build root image.
+
+qemu-system-aarch64, efi-virtio.rom, en-us, Image, initrd.img
+
+The root disk created ('rootfs-extfs-disk.img') will have above files under
+/usr/gunyah folder.
+
+Running VM
+``````````
+
+.. code-block:: bash
+
+        $ cd /usr/gunyah
+        $ ./qemu-system-aarch64 -cpu cortex-a57 -nographic -m 256M --accel gunyah \
+        -machine virt,highmem=off -initrd ./initrd.img -append \
+        "rw root=/dev/ram rdinit=/sbin/init earlyprintk=serial panic=0"
+        -kernel ./Image
+
+Limitations
+-----------
+
+Below features are not yet supported.
+
+* SMP (PSCI support needs to be added)
+* virtio-pci (support for which in Qemu seems to rely heavily on KVM, which
+  needs to be made multi-hypervisor friendly).
-- 
2.25.1


