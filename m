Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FFD72370A
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 07:59:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Pgi-0004u0-P5; Tue, 06 Jun 2023 01:57:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q6Pgg-0004tV-Fz
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 01:56:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q6Pge-0004CW-Jt
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 01:56:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686031016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5IeASP+feAXEMJEqRk06AP6n/Wy3o7p7DE/u+5rC0+s=;
 b=CKN61bYISxjJ4CwU6F1PZJgn3xNYXzMhpXEcxO6kGiHkJzFmYBxE5xEbJjcX3vKUpqRAQZ
 kHgbVCwRdN/cHe36ImzqJN76cVVjJQJbc7b7RsffOwNJ9+Ow8AzogrtQKmZWCCtyocQv9c
 3xbKQNJbCXNKhPJf59QCbIBvEpnzA+Q=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-214--5e0aIMUOquseExzcEpREA-1; Tue, 06 Jun 2023 01:56:52 -0400
X-MC-Unique: -5e0aIMUOquseExzcEpREA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 84E6B299E74A;
 Tue,  6 Jun 2023 05:56:52 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.52])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2319A2166B25;
 Tue,  6 Jun 2023 05:56:51 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 Tulio Magno Quites Machado Filho <tuliom@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: [PULL 18/18] linux-user: Emulate /proc/cpuinfo on s390x
Date: Tue,  6 Jun 2023 07:56:21 +0200
Message-Id: <20230606055621.523175-19-thuth@redhat.com>
In-Reply-To: <20230606055621.523175-1-thuth@redhat.com>
References: <20230606055621.523175-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

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
Message-Id: <20230605113950.1169228-5-iii@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 linux-user/syscall.c | 106 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 104 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 89b58b386b..83685f0aa5 100644
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
@@ -8363,7 +8464,8 @@ static int do_openat(CPUArchState *cpu_env, int dirfd, const char *pathname, int
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
2.31.1


