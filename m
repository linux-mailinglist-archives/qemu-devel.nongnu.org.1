Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C7CC01266
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Oct 2025 14:33:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBuM3-0008DD-1u; Thu, 23 Oct 2025 08:23:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vBuGW-0001Qd-A9
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 08:18:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vBuGT-0006V2-5l
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 08:18:00 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N9bRog030017
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 12:17:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=re1vd8/1Y7prOt3uK
 PfK5x3KjnvSzaWw1Duzi0t8l50=; b=I1nimCCsBSXldcEkOM0hPAS90YmF6WyTr
 fgrsxgsM5govj3+qsIGHHoHjypPwsjdRY6suc+phKEOKHOjdrDF+WEPcuZ0TqIA9
 dEi9gwdICyMSMb5aLazRuKZTrH0LzrmuE2V4m9aousEHSpwdAizq54lVfQrYv9Xe
 HnZsrvJfQ9ZBgNreLYPSs9DBLv/6t/uErIlgqXXOtl6I2yUuGAEGUeXD9VyYXWOP
 Pt45cayTkoks5hPt/DU+CoNJcAEbj+/uK4uW4u+T/L4mRBMb+mLBKurHb3Qsw3nX
 uB6ZVOx6wfmvn2zOW74Rla1DY3F8QdBi/iFMcjkRgJSxW2pl+QT2A==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31sa1em-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 12:17:45 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59NAY0dG032099
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 12:17:44 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vp7n5k0w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 12:17:44 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59NCHeKh30343616
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Oct 2025 12:17:40 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3BC9420043;
 Thu, 23 Oct 2025 12:17:40 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 25E6D20040;
 Thu, 23 Oct 2025 12:17:39 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.ibm.com.com (unknown
 [9.124.221.73]) by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 23 Oct 2025 12:17:38 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Aditya Gupta <adityag@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>
Subject: [PULL 30/32] hw/ppc: Enable fadump for PSeries
Date: Thu, 23 Oct 2025 17:46:49 +0530
Message-ID: <20251023121653.3686015-31-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251023121653.3686015-1-harshpb@linux.ibm.com>
References: <20251023121653.3686015-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: eKaAUmVy-_SDuRpryIgU8unoMa-DfvuW
X-Proofpoint-GUID: eKaAUmVy-_SDuRpryIgU8unoMa-DfvuW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfXzti4sIW4tpOy
 qmuTk/APAKk3OiTSKe6nYzda8Qol4DInUdMxZRN6iPdcw6eUeKBy4fedUJn0ObF49sz8pFQVAWq
 c6g8hI9BIdq2V9C1Y8AK+vaR40K77WVgEzWZk7VR43PowhY1wC4CyY5vHa/wVp3AFURzEzFYKJq
 OwlPWGw69+zdTrOjKTFuSayYKN7RoV4c5IZjIH9xXVmRZOpqA3OndN0XOpU/xjNYAReYND+B1Hj
 dWIHmaiz181uqD43rKGHj03/VPb2lHUyFKrRBzU0AYA21O6q+iRdJxJn8wb+sBjRRmm8Cj8oWHh
 9uc3wHLH/3iZ6a6xNctw0UVgjQ4qjeqH0pTP/bvCKzRZ3i627uu48wR1npSKwW4uankX/dKl6MK
 2Wkm8u2/aBNPLFyOokFxkPd2wZ1F6Q==
X-Authority-Analysis: v=2.4 cv=IJYPywvG c=1 sm=1 tr=0 ts=68fa1ce9 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=x6icFKpwvdMA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=B08fgxTpJCymiiQPXHEA:9
 a=oH34dK2VZjykjzsv8OSz:22 a=pHzHmUro8NiASowvMSCR:22 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
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

From: Aditya Gupta <adityag@linux.ibm.com>

With all support in place for preserving memory regions, enable fadump by
exporting the "ibm,kernel-dump" property in the device tree, representing
the fadump dump information, in case of a crash.

Currently "ibm,configure-kernel-dump" RTAS call is already registered,
which tells the kernel that the platform (QEMU) supports fadump.

Now, in case of a crash, if fadump was registered, we also pass
"ibm,kernel-dump" in device tree, which tells the kernel that the fadump
dump is active.

Pass "fadump=on" to enable Linux to use firmware assisted dump.

Logs of a linux boot with firmware assisted dump:

    $ ./build/qemu-system-ppc64 -M pseries,x-vof=on --cpu power10 --smp 4 -m 4G -kernel some-vmlinux -initrd some-initrd -append "debug fadump=on crashkernel=1G" -nographic

    [    0.000000] fadump: Reserved 1024MB of memory at 0x00000040000000 (System RAM: 4096MB)
    [    0.000000] fadump: Initialized 0x40000000 bytes cma area at 1024MB from 0x400102a8 bytes of memory reserved for firmware-assisted dump
    ...
    [    1.084686] rtas fadump: Registration is successful!
    ...
    # cat /sys/kernel/debug/powerpc/fadump_region
    CPU :[0x00000040000000-0x000000400013df] 0x13e0 bytes, Dumped: 0x0
    HPTE:[0x000000400013e0-0x000000400013df] 0x0 bytes, Dumped: 0x0
    DUMP: Src: 0x00000000000000, Dest: 0x00000040010000, Size: 0x40000000, Dumped: 0x0 bytes

    [0x0000000921a000-0x0000000921a7ff]: cmdline append: ''
    # echo c > /proc/sysrq-trigger

The fadump boot after crash:

    [    0.000000] rtas fadump: Firmware-assisted dump is active.
    [    0.000000] fadump: Updated cmdline: debug fadump=on crashkernel=1G
    [    0.000000] fadump: Firmware-assisted dump is active.
    [    0.000000] fadump: Reserving 3072MB of memory at 0x00000040000000 for preserving crash data
    ....
    # file /proc/vmcore
    /proc/vmcore: ELF 64-bit LSB core file, 64-bit PowerPC or cisco 7500, OpenPOWER ELF V2 ABI, version 1 (SYSV), SVR4-style

Analysing the vmcore with crash-utility:

          KERNEL: vmlinux-6.14-rc2
        DUMPFILE: vmcore-fc92fb373aa0
            CPUS: 4
            DATE: Wed Mar 12 23:39:23 CDT 2025
          UPTIME: 00:00:22
    LOAD AVERAGE: 0.13, 0.03, 0.01
           TASKS: 95
        NODENAME: buildroot
         RELEASE: 6.12.0-rc4+
         VERSION: #1 SMP Fri Jan  3 00:15:17 IST 2025
         MACHINE: ppc64le  (1000 Mhz)
          MEMORY: 4 GB
           PANIC: "Kernel panic - not syncing: sysrq triggered crash"
             PID: 269
         COMMAND: "sh"
            TASK: c00000000a050b00  [THREAD_INFO: c00000000a050b00]
             CPU: 0
           STATE: TASK_RUNNING (PANIC)

Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Tested-by: Shivang Upadhyay <shivangu@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20251021134823.1861675-7-adityag@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 hw/ppc/spapr.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index d6cfb9acbc..6764730beb 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -904,6 +904,8 @@ static void spapr_dt_rtas_fadump(SpaprMachineState *spapr, void *fdt, int rtas)
 {
     MachineState *ms = MACHINE(spapr);
     MachineClass *mc = MACHINE_GET_CLASS(ms);
+    FadumpMemStruct *fdm = &spapr->registered_fdm;
+    uint16_t dump_status_flag;
 
     uint32_t max_possible_cpus = mc->possible_cpu_arch_ids(ms)->len;
     uint64_t fadump_cpu_state_size = 0;
@@ -953,6 +955,16 @@ static void spapr_dt_rtas_fadump(SpaprMachineState *spapr, void *fdt, int rtas)
                     fadump_versions, sizeof(fadump_versions))));
     _FDT((fdt_setprop(fdt, rtas, "ibm,configure-kernel-dump-sizes",
                     fadump_rgn_sizes, sizeof(fadump_rgn_sizes))));
+
+    dump_status_flag = be16_to_cpu(fdm->header.dump_status_flag);
+    if (dump_status_flag & FADUMP_STATUS_DUMP_TRIGGERED) {
+        uint64_t fdm_size =
+            sizeof(struct FadumpSectionHeader) +
+            (be16_to_cpu(fdm->header.dump_num_sections) *
+            sizeof(struct FadumpSection));
+
+        _FDT((fdt_setprop(fdt, rtas, "ibm,kernel-dump", fdm, fdm_size)));
+    }
 }
 
 static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
-- 
2.43.5


