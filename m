Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCDD82A4D0
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 00:17:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNhoB-0007T3-13; Wed, 10 Jan 2024 18:16:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1rNho3-0007NT-6o; Wed, 10 Jan 2024 18:16:19 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1rNho0-0001oV-IV; Wed, 10 Jan 2024 18:16:18 -0500
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40AMZKT6028907; Wed, 10 Jan 2024 23:16:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=xxs6ZMK6+RJxyBu17TLrrE0NgbI4LjuVtGU9sdHJmuY=;
 b=kVS4S+f6DEvZOHIB8UBV/3fUQe0mJ5mwHxhNPWlzzaXPm70odBvl2wXrOvWeL2K2lwXv
 bkgJLYMkYpYXDzi1k/3oNP8OXLkzIzOWu3JLD8rk6WiYUSU4YrftDaqtk3kOGHyPMidd
 SXaINnoAcW0COQahEMAcpMrvo1Y/9lgZiN1sTKVwYfWS0f3JOWQJfwTDYk2/aq9B2JOE
 aNHZKWq5R5vFLhLvYlOz/sb7HLQ/RG6NXVLAS7IurUTYS+AR2sDfsD13zKicsVPdxuOE
 zbBC9qIQ55E6tnazfc6wKxNF9+IlSrD/rAVq6+RcFhNx5VdCneml4WE8sTqNuis7r+Ga ag== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vj41sh59c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 10 Jan 2024 23:16:04 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40AMmS95031826;
 Wed, 10 Jan 2024 23:16:00 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vj41sh535-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 10 Jan 2024 23:16:00 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40ANCw5i026996; Wed, 10 Jan 2024 23:15:43 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vfkw27ny1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 10 Jan 2024 23:15:43 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40ANFhqw44958114
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 10 Jan 2024 23:15:43 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EAFA05806C;
 Wed, 10 Jan 2024 23:15:42 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9A7135806A;
 Wed, 10 Jan 2024 23:15:42 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 10 Jan 2024 23:15:42 +0000 (GMT)
From: Ninad Palsule <ninad@linux.ibm.com>
To: qemu-devel@nongnu.org, clg@kaod.org, peter.maydell@linaro.org,
 andrew@codeconstruct.com.au, joel@jms.id.au, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, thuth@redhat.com,
 philmd@linaro.org, lvivier@redhat.com
Cc: Ninad Palsule <ninad@linux.ibm.com>, qemu-arm@nongnu.org
Subject: [PATCH v10 8/9] hw/fsi: Added FSI documentation
Date: Wed, 10 Jan 2024 17:15:36 -0600
Message-Id: <20240110231537.1654478-9-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240110231537.1654478-1-ninad@linux.ibm.com>
References: <20240110231537.1654478-1-ninad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vCURsMFL56PzxLmk3c16qwr7jbuOc1I1
X-Proofpoint-ORIG-GUID: GGPNX5yELEvO0rfY61ZsVQNHCQWay1vx
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-10_12,2024-01-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0
 mlxlogscore=695 clxscore=1015 impostorscore=0 mlxscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401100184
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

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
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


