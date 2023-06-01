Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 97ACA71EED3
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 18:26:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4l7m-0003ez-HN; Thu, 01 Jun 2023 12:26:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1q4l7j-0003Zt-O1; Thu, 01 Jun 2023 12:26:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1q4l7h-00066y-U2; Thu, 01 Jun 2023 12:26:03 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 351GHGWU004382; Thu, 1 Jun 2023 16:25:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=ce/oCkaRePMvEAe1YlqI4oVPmWA610yYfHNBkb/YWx8=;
 b=LG7rAL9eYPE8qTw5C53IjOq+Fj9L5DPOZ/rozeehiGRc9wJIDGhNPmER5PuhhCtsCews
 D/JhEY/Adr2kP9jYz3qvY3fkBq5k6d1LnzbOOF2+4xnWdMqg38ovgx14KEt+m9RuH1fx
 AKEqJnYc8ZzdYb1fSN2Fv3Q1SJjMykLcgWu9Cn7aTQ+aW3NByS6IzW8MTZdyIhlIcIcx
 1fkAKUj6UR7OAWzZO5i+C2wdt4ls2BZi59Goe5JjKzCA65+SyI1nohlHxXPz8mT+praq
 LAnc7me8Gsda79iGiphQLyNJ9p1yqNPNhGE6bUNriUJRt3C1WwVTXeX2M7VqkUGSsqnR 1Q== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qxxqj87j7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Jun 2023 16:25:58 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 351GIrLo009244;
 Thu, 1 Jun 2023 16:25:58 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qxxqj87hm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Jun 2023 16:25:58 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 351CeEjp005447;
 Thu, 1 Jun 2023 16:25:56 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3qu9g52mwx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Jun 2023 16:25:55 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 351GPraC38142224
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 1 Jun 2023 16:25:53 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 89E532004E;
 Thu,  1 Jun 2023 16:25:53 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0A4422004B;
 Thu,  1 Jun 2023 16:25:53 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.86.130])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  1 Jun 2023 16:25:52 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Laurent Vivier <laurent@vivier.eu>, David Hildenbrand <david@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Tulio Magno Quites Machado Filho <tuliom@redhat.com>
Subject: [PATCH 4/4] linux-user: Emulate /proc/cpuinfo on s390x
Date: Thu,  1 Jun 2023 18:25:41 +0200
Message-Id: <20230601162541.689621-5-iii@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601162541.689621-1-iii@linux.ibm.com>
References: <20230601162541.689621-1-iii@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: e4Tmrv7SVBo2PeYQ0azPVldDsijVxgR5
X-Proofpoint-GUID: KRs-uS0zXwCfSLkv721Hr3xzFJkWDSgm
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-01_08,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 phishscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306010139
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H5=0.001,
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

Some s390x userspace programs are confused when seeing a foreign
/proc/cpuinfo [1]. Add the emulation for s390x; follow the respective
kernel code structure where possible.

[1] https://bugzilla.redhat.com/show_bug.cgi?id=2211472

Reported-by: Tulio Magno Quites Machado Filho <tuliom@redhat.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 linux-user/syscall.c | 106 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 105 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 3e6ed51ce62..d142e09dc70 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8339,6 +8339,109 @@ static int open_cpuinfo(CPUArchState *cpu_env, int fd)
 }
 #endif
 
+#if defined(TARGET_S390X)
+/*
+ * Emulate what a Linux kernel running in qemu-system-s390x -M accel=tcg would
+ * show in /proc/cpuinfo.
+ *
+ * Skip the following in order to match the missing support in op_ecag():
+ * - show_cacheinfo().
+ * - show_cpu_topology().
+ * - show_cpu_mhz().
+ *
+ * Use fixed values for certain fields:
+ * - bogomips per cpu - from a qemu-system-s390x run.
+ * - max thread id = 0, since SMT / SIGP_SET_MULTI_THREADING is not supported.
+ *
+ * Keep the code structure close to arch/s390/kernel/processor.c.
+ */
+
+static void show_facilities(int fd)
+{
+    size_t sizeof_stfl_bytes = 2048;
+    g_autofree uint8_t *stfl_bytes = g_new0(uint8_t, sizeof_stfl_bytes);
+    unsigned int bit;
+
+    dprintf(fd, "facilities      :");
+    s390_get_feat_block(S390_FEAT_TYPE_STFL, stfl_bytes);
+    for (bit = 0; bit < sizeof_stfl_bytes * 8; bit++) {
+        if (test_be_bit(bit, stfl_bytes)) {
+            dprintf(fd, " %d", bit);
+        }
+    }
+    dprintf(fd, "\n");
+}
+
+static int cpu_ident(unsigned long n)
+{
+    return deposit32(0, CPU_ID_BITS - CPU_PHYS_ADDR_BITS, CPU_PHYS_ADDR_BITS,
+                     n);
+}
+
+static void show_cpu_summary(CPUArchState *cpu_env, int fd)
+{
+    S390CPUModel *model = env_archcpu(cpu_env)->model;
+    int num_cpus = sysconf(_SC_NPROCESSORS_ONLN);
+    uint32_t elf_hwcap = get_elf_hwcap();
+    const char *hwcap_str;
+    int i;
+
+    dprintf(fd, "vendor_id       : IBM/S390\n"
+                "# processors    : %i\n"
+                "bogomips per cpu: 13370.00\n",
+            num_cpus);
+    dprintf(fd, "max thread id   : 0\n");
+    dprintf(fd, "features\t: ");
+    for (i = 0; i < sizeof(elf_hwcap) * 8; i++) {
+        if (!(elf_hwcap & (1 << i))) {
+            continue;
+        }
+        hwcap_str = elf_hwcap_str(i);
+        if (hwcap_str) {
+            dprintf(fd, "%s ", hwcap_str);
+        }
+    }
+    dprintf(fd, "\n");
+    show_facilities(fd);
+    for (i = 0; i < num_cpus; i++) {
+        dprintf(fd, "processor %d: "
+               "version = %02X,  "
+               "identification = %06X,  "
+               "machine = %04X\n",
+               i, model->cpu_ver, cpu_ident(i), model->def->type);
+    }
+}
+
+static void show_cpu_ids(CPUArchState *cpu_env, int fd, unsigned long n)
+{
+    S390CPUModel *model = env_archcpu(cpu_env)->model;
+
+    dprintf(fd, "version         : %02X\n", model->cpu_ver);
+    dprintf(fd, "identification  : %06X\n", cpu_ident(n));
+    dprintf(fd, "machine         : %04X\n", model->def->type);
+}
+
+static void show_cpuinfo(CPUArchState *cpu_env, int fd, unsigned long n)
+{
+    if (n == 0) {
+        show_cpu_summary(cpu_env, fd);
+    }
+    dprintf(fd, "\ncpu number      : %ld\n", n);
+    show_cpu_ids(cpu_env, fd, n);
+}
+
+static int open_cpuinfo(CPUArchState *cpu_env, int fd)
+{
+    int num_cpus = sysconf(_SC_NPROCESSORS_ONLN);
+    int i;
+
+    for (i = 0; i < num_cpus; i++) {
+        show_cpuinfo(cpu_env, fd, i);
+    }
+    return 0;
+}
+#endif
+
 #if defined(TARGET_M68K)
 static int open_hardware(CPUArchState *cpu_env, int fd)
 {
@@ -8364,7 +8467,8 @@ int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *pathname,
 #if HOST_BIG_ENDIAN != TARGET_BIG_ENDIAN
         { "/proc/net/route", open_net_route, is_proc },
 #endif
-#if defined(TARGET_SPARC) || defined(TARGET_HPPA) || defined(TARGET_RISCV)
+#if defined(TARGET_SPARC) || defined(TARGET_HPPA) || \
+    defined(TARGET_RISCV) || defined(TARGET_S390X)
         { "/proc/cpuinfo", open_cpuinfo, is_proc },
 #endif
 #if defined(TARGET_M68K)
-- 
2.40.1


