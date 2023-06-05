Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA1C7224D1
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 13:41:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q68aS-0000WZ-VA; Mon, 05 Jun 2023 07:41:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1q68ZG-0008OC-5F; Mon, 05 Jun 2023 07:40:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1q68ZD-0001bZ-QQ; Mon, 05 Jun 2023 07:40:09 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 355BUZbo006635; Mon, 5 Jun 2023 11:40:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=AAuuJnKEslDmxDQKLZ3cyieSto90/UiEsNBezbigGx8=;
 b=rUXjd24hBlSOH8q1T41/FesfpKZacLnbHhB0pEoGm8+eymXUJxelG8MNM4ivdfn74CrZ
 RAMV3UPupTfq8EEaAdhKwosE7JlqlJOwHBecJpAe0fBXjQs++eS//aBKGjKoX27jrAdV
 97s2Sx7bGNlMjN/K/6sXbMqgru320dYRnHJceI6EUasK3DkW5fJLCh/TpFq2heM/k8HD
 yCdny9famoMxELCfrbVjI4yJauWvJ6G9X184zOYDqRRaVKlc0BX4g1IVpv764FLhGiuw
 A3bvQ6Ihop2maFxOAm47q1p/oKGT2A/91+YzNIsAeZ5vL2HdATk4o1kSWHTHkMx9grR0 TA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r1evxr87g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Jun 2023 11:40:04 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 355BVBKW007139;
 Mon, 5 Jun 2023 11:40:04 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.70])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r1evxr84v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Jun 2023 11:40:04 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
 by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3554ReQ9019802;
 Mon, 5 Jun 2023 11:40:00 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3qyxahh1p7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Jun 2023 11:40:00 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 355BdwfX44630448
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 5 Jun 2023 11:39:58 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 26C5020043;
 Mon,  5 Jun 2023 11:39:58 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DD0C820040;
 Mon,  5 Jun 2023 11:39:57 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.155.209.184])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  5 Jun 2023 11:39:57 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Laurent Vivier <laurent@vivier.eu>, David Hildenbrand <david@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Tulio Magno Quites Machado Filho <tuliom@redhat.com>
Subject: [PATCH v2 4/4] linux-user: Emulate /proc/cpuinfo on s390x
Date: Mon,  5 Jun 2023 13:39:50 +0200
Message-Id: <20230605113950.1169228-5-iii@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230605113950.1169228-1-iii@linux.ibm.com>
References: <20230605113950.1169228-1-iii@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6-jaX_WEmRGHYD6ibZsvog5ONWJ7zOUA
X-Proofpoint-GUID: 5mtk1-YDN3o4_ugwplUWO02hpysGc-W5
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-03_08,2023-06-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 adultscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306050103
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

Output example:

	vendor_id       : IBM/S390
	# processors    : 12
	bogomips per cpu: 13370.00
	max thread id   : 0
	features	: esan3 zarch stfle msa
	facilities      : 0 1 2 3 4 7 9 16 17 18 19 21 22 24 25 27 30 31 32 33 34 35 37 40 41 45 49 51 52 53 57 58 61 69 71 72 75 76 77 129 130 131 135 138 146 148
	processor 0: version = 00,  identification = 000000,  machine = 8561
	processor 1: version = 00,  identification = 100000,  machine = 8561
	[...]

	cpu number      : 0
	version         : 00
	identification  : 000000
	machine         : 8561

	cpu number      : 1
	version         : 00
	identification  : 100000
	machine         : 8561
	[...]

[1] https://bugzilla.redhat.com/show_bug.cgi?id=2211472

Reported-by: Tulio Magno Quites Machado Filho <tuliom@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 linux-user/syscall.c | 106 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 104 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 3e6ed51ce62..2d3070cfd62 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8232,7 +8232,7 @@ void target_exception_dump(CPUArchState *env, const char *fmt, int code)
 
 #if HOST_BIG_ENDIAN != TARGET_BIG_ENDIAN || \
     defined(TARGET_SPARC) || defined(TARGET_M68K) || defined(TARGET_HPPA) || \
-    defined(TARGET_RISCV)
+    defined(TARGET_RISCV) || defined(TARGET_S390X)
 static int is_proc(const char *filename, const char *entry)
 {
     return strcmp(filename, entry) == 0;
@@ -8339,6 +8339,107 @@ static int open_cpuinfo(CPUArchState *cpu_env, int fd)
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
+    dprintf(fd, "\ncpu number      : %ld\n", n);
+    show_cpu_ids(cpu_env, fd, n);
+}
+
+static int open_cpuinfo(CPUArchState *cpu_env, int fd)
+{
+    int num_cpus = sysconf(_SC_NPROCESSORS_ONLN);
+    int i;
+
+    show_cpu_summary(cpu_env, fd);
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
@@ -8364,7 +8465,8 @@ int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *pathname,
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


