Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1D77FCB28
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 00:58:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r87xF-0001EJ-8b; Tue, 28 Nov 2023 18:57:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1r87xC-0001BZ-I4; Tue, 28 Nov 2023 18:57:22 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1r87x9-0007ne-TD; Tue, 28 Nov 2023 18:57:22 -0500
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3ASNq9Cg006747; Tue, 28 Nov 2023 23:57:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Q5QPCvUWlT2bF24vK27PSQjVtaz7mIpU3cyf/DNDa0k=;
 b=UCO1IfNGAbj2P5JSktc2IT/6vCwxKO34XOVqskvg09LAv4LB4zKlH+EXrUEs8I/XMvkC
 qBfU4MnjHqoxooNB4hkbT/m0fW2S8kgEIf+5FY22+ArnEh5oLq4V/nMQeUl+0Rgf8NNM
 7R93Gqo8cm3fWJEO5519WFsz52/+AYELVWZC4Jv4KcxdSP85a1IqzQ2f33D1a+92GQq1
 5uQbM9OiFTVOFnJXJ2rvHfnQrt7jekjDE7cFW3navQIem5HYOM7vsPS3/n7PkYPzYxky
 cWuN32PrajYzL4QXoZBIVgaPXfjeTajtdO8CdawvqYfMRKIip5fV/riam4qsvvK3tdTU bQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3unt8n82p4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Nov 2023 23:57:09 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ASNrwoR010172;
 Tue, 28 Nov 2023 23:57:08 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3unt8n82nr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Nov 2023 23:57:08 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3ASMi0TN018177; Tue, 28 Nov 2023 23:57:07 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ukwy1u662-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Nov 2023 23:57:07 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3ASNv6ER16384566
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Nov 2023 23:57:06 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5986258043;
 Tue, 28 Nov 2023 23:57:06 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1B51C5805E;
 Tue, 28 Nov 2023 23:57:06 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 28 Nov 2023 23:57:06 +0000 (GMT)
From: Ninad Palsule <ninad@linux.ibm.com>
To: qemu-devel@nongnu.org, clg@kaod.org, peter.maydell@linaro.org,
 andrew@codeconstruct.com.au, joel@jms.id.au, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, thuth@redhat.com,
 philmd@linaro.org, lvivier@redhat.com
Cc: Ninad Palsule <ninad@linux.ibm.com>, qemu-arm@nongnu.org
Subject: [PATCH v8 09/10] hw/fsi: Added FSI documentation
Date: Tue, 28 Nov 2023 17:56:59 -0600
Message-Id: <20231128235700.599584-10-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231128235700.599584-1-ninad@linux.ibm.com>
References: <20231128235700.599584-1-ninad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: axWqMidFERvBFT_NffQCx7lfl2aMmgYb
X-Proofpoint-ORIG-GUID: 0WEBERD9CNxXklpSZC0AKzYU78yoXrEM
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_25,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0
 spamscore=0 malwarescore=0 mlxscore=0 bulkscore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 mlxlogscore=706
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311280188
Received-SPF: pass client-ip=148.163.156.1; envelope-from=ninad@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Documentation for IBM FSI model.

Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 docs/specs/fsi.rst   | 138 +++++++++++++++++++++++++++++++++++++++++++
 docs/specs/index.rst |   1 +
 2 files changed, 139 insertions(+)
 create mode 100644 docs/specs/fsi.rst

diff --git a/docs/specs/fsi.rst b/docs/specs/fsi.rst
new file mode 100644
index 0000000000..05a6b6347a
--- /dev/null
+++ b/docs/specs/fsi.rst
@@ -0,0 +1,138 @@
+======================================
+IBM's Flexible Service Interface (FSI)
+======================================
+
+The QEMU FSI emulation implements hardware interfaces between ASPEED SOC, FSI
+master/slave and the end engine.
+
+FSI is a point-to-point two wire interface which is capable of supporting
+distances of up to 4 meters. FSI interfaces have been used successfully for
+many years in IBM servers to attach IBM Flexible Support Processors(FSP) to
+CPUs and IBM ASICs.
+
+FSI allows a service processor access to the internal buses of a host POWER
+processor to perform configuration or debugging. FSI has long existed in POWER
+processes and so comes with some baggage, including how it has been integrated
+into the ASPEED SoC.
+
+Working backwards from the POWER processor, the fundamental pieces of interest
+for the implementation are: (see the `FSI specification`_ for more details)
+
+1. The Common FRU Access Macro (CFAM), an address space containing various
+   "engines" that drive accesses on buses internal and external to the POWER
+   chip. Examples include the SBEFIFO and I2C masters. The engines hang off of
+   an internal Local Bus (LBUS) which is described by the CFAM configuration
+   block.
+
+2. The FSI slave: The slave is the terminal point of the FSI bus for FSI
+   symbols addressed to it. Slaves can be cascaded off of one another. The
+   slave's configuration registers appear in address space of the CFAM to
+   which it is attached.
+
+3. The FSI master: A controller in the platform service processor (e.g. BMC)
+   driving CFAM engine accesses into the POWER chip. At the hardware level
+   FSI is a bit-based protocol supporting synchronous and DMA-driven accesses
+   of engines in a CFAM.
+
+4. The On-Chip Peripheral Bus (OPB): A low-speed bus typically found in POWER
+   processors. This now makes an appearance in the ASPEED SoC due to tight
+   integration of the FSI master IP with the OPB, mainly the existence of an
+   MMIO-mapping of the CFAM address straight onto a sub-region of the OPB
+   address space.
+
+5. An APB-to-OPB bridge enabling access to the OPB from the ARM core in the
+   AST2600. Hardware limitations prevent the OPB from being directly mapped
+   into APB, so all accesses are indirect through the bridge.
+
+The LBUS is modelled to maintain the qdev bus hierarchy and to take advantages
+of the object model to automatically generate the CFAM configuration block.
+The configuration block presents engines in the order they are attached to the
+CFAM's LBUS. Engine implementations should subclass the LBusDevice and set the
+'config' member of LBusDeviceClass to match the engine's type.
+
+CFAM designs offer a lot of flexibility, for instance it is possible for a
+CFAM to be simultaneously driven from multiple FSI links. The modeling is not
+so complete; it's assumed that each CFAM is attached to a single FSI slave (as
+a consequence the CFAM subclasses the FSI slave).
+
+As for FSI, its symbols and wire-protocol are not modelled at all. This is not
+necessary to get FSI off the ground thanks to the mapping of the CFAM address
+space onto the OPB address space - the models follow this directly and map the
+CFAM memory region into the OPB's memory region.
+
+QEMU files related to FSI interface:
+ - ``hw/fsi/aspeed-apb2opb.c``
+ - ``include/hw/fsi/aspeed-apb2opb.h``
+ - ``hw/fsi/opb.c``
+ - ``include/hw/fsi/opb.h``
+ - ``hw/fsi/fsi.c``
+ - ``include/hw/fsi/fsi.h``
+ - ``hw/fsi/fsi-master.c``
+ - ``include/hw/fsi/fsi-master.h``
+ - ``hw/fsi/fsi-slave.c``
+ - ``include/hw/fsi/fsi-slave.h``
+ - ``hw/fsi/cfam.c``
+ - ``include/hw/fsi/cfam.h``
+ - ``hw/fsi/engine-scratchpad.c``
+ - ``include/hw/fsi/engine-scratchpad.h``
+ - ``include/hw/fsi/lbus.h``
+
+The following commands start the rainier machine with built-in FSI model.
+There are no model specific arguments.
+
+.. code-block:: console
+
+  qemu-system-arm -M rainier-bmc -nographic \
+  -kernel fitImage-linux.bin \
+  -dtb aspeed-bmc-ibm-rainier.dtb \
+  -initrd obmc-phosphor-initramfs.rootfs.cpio.xz \
+  -drive file=obmc-phosphor-image.rootfs.wic.qcow2,if=sd,index=2 \
+  -append "rootwait console=ttyS4,115200n8 root=PARTLABEL=rofs-a"
+
+The implementation appears as following in the qemu device tree:
+
+.. code-block:: console
+
+  (qemu) info qtree
+  bus: main-system-bus
+    type System
+    ...
+    dev: aspeed.apb2opb, id ""
+      gpio-out "sysbus-irq" 1
+      mmio 000000001e79b000/0000000000001000
+      bus: opb.1
+        type opb
+        dev: fsi.master, id ""
+          bus: fsi.bus.1
+            type fsi.bus
+            dev: cfam.config, id ""
+            dev: cfam, id ""
+              bus: lbus.1
+                type lbus
+                dev: scratchpad, id ""
+                  address = 0 (0x0)
+      bus: opb.0
+        type opb
+        dev: fsi.master, id ""
+          bus: fsi.bus.0
+            type fsi.bus
+            dev: cfam.config, id ""
+            dev: cfam, id ""
+              bus: lbus.0
+                type lbus
+                dev: scratchpad, id ""
+                  address = 0 (0x0)
+
+pdbg is a simple application to allow debugging of the host POWER processors
+from the BMC. (see the `pdbg source repository`_ for more details)
+
+.. code-block:: console
+
+  root@p10bmc:~# pdbg -a getcfam 0x0
+  p0: 0x0 = 0xc0022d15
+
+.. _FSI specification:
+   https://openpowerfoundation.org/specifications/fsi/
+
+.. _pdbg source repository:
+   https://github.com/open-power/pdbg
diff --git a/docs/specs/index.rst b/docs/specs/index.rst
index b3f482b0aa..1484e3e760 100644
--- a/docs/specs/index.rst
+++ b/docs/specs/index.rst
@@ -24,6 +24,7 @@ guest hardware that is specific to QEMU.
    acpi_erst
    sev-guest-firmware
    fw_cfg
+   fsi
    vmw_pvscsi-spec
    edu
    ivshmem-spec
-- 
2.39.2


