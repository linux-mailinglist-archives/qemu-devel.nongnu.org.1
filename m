Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D30FAC00E67
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Oct 2025 13:51:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBtky-0002IX-2X; Thu, 23 Oct 2025 07:45:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vBtkn-0001kM-5I
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 07:45:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vBtkk-0001dA-Q8
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 07:45:12 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N7psTK027549;
 Thu, 23 Oct 2025 11:44:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=+0H0Da
 7VdCvdfrj0RFNrEHQOMPnaTngWJ/qx5eIWKFQ=; b=HfHH8JV/l5DBcWi8AGWh8n
 cSHshGH/0OhAmDRr89wdmn23xI5GAXBXzNtPQa5lndnEuVFUw+Xux4N+U7Ncdvy/
 X1iz8rb3z5dfqWktlLaYtuBFmwh/mNQnh4kSAvTAfsb2hZMwvpQEtZgBTFS163O9
 t+N+yQerWupJTyTglzRTVcQIriKvH1+vW4GhbYy/XuhJ4eKrr5doFj9fDQ1SQGB+
 W1o9SNOA9AW9eJtEA5E07olLXissRLGboFHs6Vpdgt4GWR/wfUaSOMLzodfoMM97
 oyjkLeBa1i4Rhch6/RG37oZKq1YVy76ZMv8O8F2e8ef/FmYSfiZ26j2+v21LI+2A
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v33fhx64-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 11:44:56 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59NAhERG002320;
 Thu, 23 Oct 2025 11:44:55 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vqejn9w6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 11:44:55 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59NBisCk40435984
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Oct 2025 11:44:54 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 04F2220049;
 Thu, 23 Oct 2025 11:44:54 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2546420040;
 Thu, 23 Oct 2025 11:44:53 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.ibm.com.com (unknown
 [9.124.221.73]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 23 Oct 2025 11:44:52 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 20/32] hw/ppc/pegasos2: Move hardware specific parts out of
 machine reset
Date: Thu, 23 Oct 2025 17:14:07 +0530
Message-ID: <20251023114422.3675018-21-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251023114422.3675018-1-harshpb@linux.ibm.com>
References: <20251023114422.3675018-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FMYWBuos c=1 sm=1 tr=0 ts=68fa1538 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8
 a=29-1D86bl-XE_ZHJWoEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22 a=oH34dK2VZjykjzsv8OSz:22 a=pHzHmUro8NiASowvMSCR:22
 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-GUID: FVHNL2FyZZ20jBquFvBW7MPCdF9o7_t_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX10XT0CjoRUhC
 6DicrGb8SqEFaOHkXERG2Jk50Lc6hfILXDvsmln2y1EPsSTeHhr1mGHkzE7cNRrkWVvnkUTLui3
 YNCMq0nZ9/4Ip3+LuwC+qNoXD5neV3CPlCfL8+U731Z0ShUT1vB2fAqFPg9CN69cd59ioYoU9PU
 ObxmWAttyxZxOY6FTDbsAFi3eUaHkj0OV82Ih5FzZgX1mdp+yYk5fKlu4HKMGQOhoSKLCNMIb9e
 OX+IYe7l9SGW4SPyWRiH1uze1DgQetBViolYKksUKm+sxOIc3mXs22nz/yByEQkCaP69iqBrzOe
 ajYyo+94mTmScn9xBxZ3AVJg7WeFkg737gFp+HWwoBrrjc669CD7fzuXjEWShWhywNbuARBBEOB
 5W31Gdi3rJ40Vd1OjAjmplaSrjj0dA==
X-Proofpoint-ORIG-GUID: FVHNL2FyZZ20jBquFvBW7MPCdF9o7_t_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: BALATON Zoltan <balaton@eik.bme.hu>

Move the pegasos2 specific chipset reset out from machine reset to a
separate function and move generic parts that are not pegasos2
specific from build_fdt to machine reset so now build_fdt only
contains pegasos2 specific parts and can be renamed accordingly.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/qemu-devel/f6633a68a72aad4fefb8d2373b52561f8ca8d41d.1761176219.git.balaton@eik.bme.hu
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 hw/ppc/pegasos2.c | 79 ++++++++++++++++++++++++-----------------------
 1 file changed, 41 insertions(+), 38 deletions(-)

diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
index 2f9bd3eac5..ed3070204b 100644
--- a/hw/ppc/pegasos2.c
+++ b/hw/ppc/pegasos2.c
@@ -57,10 +57,6 @@
 
 #define BUS_FREQ_HZ 133333333
 
-#define PCI0_CFG_ADDR 0xcf8
-#define PCI1_CFG_ADDR 0xc78
-#define PCI1_IO_BASE  0xfe000000
-
 #define TYPE_PEGASOS2_MACHINE  MACHINE_TYPE_NAME("pegasos2")
 OBJECT_DECLARE_TYPE(Pegasos2MachineState, MachineClass, PEGASOS2_MACHINE)
 
@@ -82,7 +78,7 @@ struct Pegasos2MachineState {
     uint64_t initrd_size;
 };
 
-static void *build_fdt(MachineState *machine, int *fdt_size);
+static void *pegasos2_build_fdt(Pegasos2MachineState *pm, int *fdt_size);
 
 static void pegasos2_cpu_reset(void *opaque)
 {
@@ -284,6 +280,9 @@ static void pegasos2_mv_reg_write(Pegasos2MachineState *pm, uint32_t addr,
                                  MEMTXATTRS_UNSPECIFIED);
 }
 
+#define PCI0_CFG_ADDR 0xcf8
+#define PCI1_CFG_ADDR 0xc78
+
 static uint32_t pegasos2_pci_config_read(Pegasos2MachineState *pm, int bus,
                                          uint32_t addr, uint32_t len)
 {
@@ -308,23 +307,12 @@ static void pegasos2_pci_config_write(Pegasos2MachineState *pm, int bus,
 
 static void pegasos2_superio_write(uint8_t addr, uint8_t val)
 {
-    cpu_physical_memory_write(PCI1_IO_BASE + 0x3f0, &addr, 1);
-    cpu_physical_memory_write(PCI1_IO_BASE + 0x3f1, &val, 1);
+    cpu_physical_memory_write(0xfe0003f0, &addr, 1);
+    cpu_physical_memory_write(0xfe0003f1, &val, 1);
 }
 
-static void pegasos2_machine_reset(MachineState *machine, ResetType type)
+static void pegasos2_chipset_reset(Pegasos2MachineState *pm)
 {
-    Pegasos2MachineState *pm = PEGASOS2_MACHINE(machine);
-    void *fdt;
-    uint64_t d[2];
-    int sz;
-
-    qemu_devices_reset(type);
-    if (!pm->vof) {
-        return; /* Firmware should set up machine so nothing to do */
-    }
-
-    /* Otherwise, set up devices that board firmware would normally do */
     pegasos2_mv_reg_write(pm, 0, 4, 0x28020ff);
     pegasos2_mv_reg_write(pm, 0x278, 4, 0xa31fc);
     pegasos2_mv_reg_write(pm, 0xf300, 4, 0x11ff0400);
@@ -387,6 +375,23 @@ static void pegasos2_machine_reset(MachineState *machine, ResetType type)
 
     pegasos2_pci_config_write(pm, 1, (PCI_DEVFN(12, 6) << 8) |
                               PCI_INTERRUPT_LINE, 2, 0x309);
+}
+
+static void pegasos2_machine_reset(MachineState *machine, ResetType type)
+{
+    Pegasos2MachineState *pm = PEGASOS2_MACHINE(machine);
+    void *fdt;
+    uint32_t c[2];
+    uint64_t d[2];
+    int sz;
+
+    qemu_devices_reset(type);
+    if (!pm->vof) {
+        return; /* Firmware should set up machine so nothing to do */
+    }
+
+    /* Otherwise, set up devices that board firmware would normally do */
+    pegasos2_chipset_reset(pm);
 
     /* Device tree and VOF set up */
     vof_init(pm->vof, machine->ram_size, &error_fatal);
@@ -405,10 +410,25 @@ static void pegasos2_machine_reset(MachineState *machine, ResetType type)
         exit(1);
     }
 
-    fdt = build_fdt(machine, &sz);
+    fdt = pegasos2_build_fdt(pm, &sz);
     if (!fdt) {
         exit(1);
     }
+
+    /* Set memory size */
+    c[0] = 0;
+    c[1] = cpu_to_be32(machine->ram_size);
+    qemu_fdt_setprop(fdt, "/memory@0", "reg", c, sizeof(c));
+
+    /* Boot parameters */
+    if (pm->initrd_addr && pm->initrd_size) {
+        qemu_fdt_setprop_cell(fdt, "/chosen", "linux,initrd-end",
+                              pm->initrd_addr + pm->initrd_size);
+        qemu_fdt_setprop_cell(fdt, "/chosen", "linux,initrd-start",
+                              pm->initrd_addr);
+    }
+    qemu_fdt_setprop_string(fdt, "/chosen", "bootargs",
+                            machine->kernel_cmdline ?: "");
     /* FIXME: VOF assumes entry is same as load address */
     d[0] = cpu_to_be64(pm->kernel_entry);
     d[1] = cpu_to_be64(pm->kernel_size - (pm->kernel_entry - pm->kernel_addr));
@@ -827,12 +847,10 @@ static void *load_dtb(const char *filename, int *fdt_size)
     return fdt;
 }
 
-static void *build_fdt(MachineState *machine, int *fdt_size)
+static void *pegasos2_build_fdt(Pegasos2MachineState *pm, int *fdt_size)
 {
-    Pegasos2MachineState *pm = PEGASOS2_MACHINE(machine);
     FDTInfo fi;
     PCIBus *pci_bus;
-    uint32_t cells[2];
     void *fdt = load_dtb("pegasos2.dtb", fdt_size);
 
     if (!fdt) {
@@ -840,21 +858,6 @@ static void *build_fdt(MachineState *machine, int *fdt_size)
     }
     qemu_fdt_setprop_string(fdt, "/", "name", "bplan,Pegasos2");
 
-    /* Set memory size */
-    cells[0] = 0;
-    cells[1] = cpu_to_be32(machine->ram_size);
-    qemu_fdt_setprop(fdt, "/memory@0", "reg", cells, 2 * sizeof(cells[0]));
-
-    /* Boot parameters */
-    if (pm->initrd_addr && pm->initrd_size) {
-        qemu_fdt_setprop_cell(fdt, "/chosen", "linux,initrd-end",
-                              pm->initrd_addr + pm->initrd_size);
-        qemu_fdt_setprop_cell(fdt, "/chosen", "linux,initrd-start",
-                              pm->initrd_addr);
-    }
-    qemu_fdt_setprop_string(fdt, "/chosen", "bootargs",
-                            machine->kernel_cmdline ?: "");
-
     add_cpu_info(fdt, pm->cpu);
 
     fi.fdt = fdt;
-- 
2.43.5


