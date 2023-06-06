Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B27724466
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 15:29:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6WjL-0008Go-FT; Tue, 06 Jun 2023 09:28:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1q6WjC-00089O-TU; Tue, 06 Jun 2023 09:28:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1q6WjA-0003sT-8r; Tue, 06 Jun 2023 09:28:02 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 356DLGbX003133; Tue, 6 Jun 2023 13:27:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=V55L8oLu++u0quixVVDzBN7/PotCahthoiOidjx/0sQ=;
 b=Xc37LsERTI7DP0S5JrC1IJJkAzoZ/9jW18wqezB51GrF4aAiU/bVGt3XITwmEV4FX5ku
 THN0QFAstKGqWzuNZpvDSJl7slUqMGG0AmbdMjLISPpKntgpIs/6jvslB7v1gGzqOMPC
 5zvuHN3ESneSqanIxe5Rj1rhgVIpUoaNwBsVe7zueSYMfy7WGZ3O3Z7V3W/aIP2I80ns
 45vRIsvg4nsL5BUeaYGBWBXEztqA03r7PZzrvTVG6zjqOIyvKIR7sen1xfUJrQaOjBl9
 bn1iHsKPdVxBaVsIEGFCqDsrxJw3nYZvfLkqKl+VRQP/ESZ1Hikdg/5bnWWYp+glhA7U cA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r25kr05we-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Jun 2023 13:27:57 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 356DNvsM012672;
 Tue, 6 Jun 2023 13:27:57 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.72])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r25kr05vu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Jun 2023 13:27:57 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
 by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 356CjOVH016459;
 Tue, 6 Jun 2023 13:27:55 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3qyx5q9hud-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Jun 2023 13:27:55 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 356DRqv320316804
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 6 Jun 2023 13:27:52 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ADCFC20040;
 Tue,  6 Jun 2023 13:27:52 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6C3E520043;
 Tue,  6 Jun 2023 13:27:52 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.155.209.184])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  6 Jun 2023 13:27:52 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v3 3/8] linux-user: Emulate /proc/self/smaps
Date: Tue,  6 Jun 2023 15:27:38 +0200
Message-Id: <20230606132743.1386003-4-iii@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230606132743.1386003-1-iii@linux.ibm.com>
References: <20230606132743.1386003-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qPYUydcvbwPaD_iVuKzDXC4XLUcu4F3f
X-Proofpoint-GUID: gyh5TgK_QloDXicl0iQPT3eCPCpmYO5_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-06_08,2023-06-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 mlxlogscore=999 clxscore=1015 adultscore=0 phishscore=0 malwarescore=0
 mlxscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306060110
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

/proc/self/smaps is an extension of /proc/self/maps: it provides the
same lines, plus additional information about each range.

GDB uses /proc/self/smaps when available, which means that
generate-core-file tries it first before falling back to
/proc/self/maps. This, in turn, causes it to dump the host mappings,
since /proc/self/smaps is not emulated and is just passed through.

Fix by emulating /proc/self/smaps. Provide true values only for
Size, KernelPageSize, MMUPageSize and VmFlags. Leave all other values
at 0, which is a valid conservative estimate.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 linux-user/syscall.c | 58 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 28a0b1f7882..c1045ea7925 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8042,7 +8042,36 @@ static int open_self_cmdline(CPUArchState *cpu_env, int fd)
     return 0;
 }
 
-static int open_self_maps(CPUArchState *cpu_env, int fd)
+static void show_smaps(int fd, unsigned long size)
+{
+    unsigned long page_size_kb = TARGET_PAGE_SIZE >> 10;
+    unsigned long size_kb = size >> 10;
+
+    dprintf(fd, "Size:                  %lu kB\n"
+                "KernelPageSize:        %lu kB\n"
+                "MMUPageSize:           %lu kB\n"
+                "Rss:                   0 kB\n"
+                "Pss:                   0 kB\n"
+                "Pss_Dirty:             0 kB\n"
+                "Shared_Clean:          0 kB\n"
+                "Shared_Dirty:          0 kB\n"
+                "Private_Clean:         0 kB\n"
+                "Private_Dirty:         0 kB\n"
+                "Referenced:            0 kB\n"
+                "Anonymous:             0 kB\n"
+                "LazyFree:              0 kB\n"
+                "AnonHugePages:         0 kB\n"
+                "ShmemPmdMapped:        0 kB\n"
+                "FilePmdMapped:         0 kB\n"
+                "Shared_Hugetlb:        0 kB\n"
+                "Private_Hugetlb:       0 kB\n"
+                "Swap:                  0 kB\n"
+                "SwapPss:               0 kB\n"
+                "Locked:                0 kB\n"
+                "THPeligible:    0\n", size_kb, page_size_kb, page_size_kb);
+}
+
+static int open_self_maps_1(CPUArchState *cpu_env, int fd, bool smaps)
 {
     CPUState *cpu = env_cpu(cpu_env);
     TaskState *ts = cpu->opaque;
@@ -8089,6 +8118,18 @@ static int open_self_maps(CPUArchState *cpu_env, int fd)
             } else {
                 dprintf(fd, "\n");
             }
+            if (smaps) {
+                show_smaps(fd, max - min);
+                dprintf(fd, "VmFlags:%s%s%s%s%s%s%s%s\n",
+                        (flags & PAGE_READ) ? " rd" : "",
+                        (flags & PAGE_WRITE_ORG) ? " wr" : "",
+                        (flags & PAGE_EXEC) ? " ex" : "",
+                        e->is_priv ? "" : " sh",
+                        (flags & PAGE_READ) ? " mr" : "",
+                        (flags & PAGE_WRITE_ORG) ? " mw" : "",
+                        (flags & PAGE_EXEC) ? " me" : "",
+                        e->is_priv ? "" : " ms");
+            }
         }
     }
 
@@ -8103,11 +8144,25 @@ static int open_self_maps(CPUArchState *cpu_env, int fd)
                     " --xp 00000000 00:00 0",
                     TARGET_VSYSCALL_PAGE, TARGET_VSYSCALL_PAGE + TARGET_PAGE_SIZE);
     dprintf(fd, "%*s%s\n", 73 - count, "",  "[vsyscall]");
+    if (smaps) {
+        show_smaps(fd, TARGET_PAGE_SIZE);
+        dprintf(fd, "VmFlags: ex\n");
+    }
 #endif
 
     return 0;
 }
 
+static int open_self_maps(CPUArchState *cpu_env, int fd)
+{
+    return open_self_maps_1(cpu_env, fd, false);
+}
+
+static int open_self_smaps(CPUArchState *cpu_env, int fd)
+{
+    return open_self_maps_1(cpu_env, fd, true);
+}
+
 static int open_self_stat(CPUArchState *cpu_env, int fd)
 {
     CPUState *cpu = env_cpu(cpu_env);
@@ -8459,6 +8514,7 @@ int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *pathname,
     const struct fake_open *fake_open;
     static const struct fake_open fakes[] = {
         { "maps", open_self_maps, is_proc_myself },
+        { "smaps", open_self_smaps, is_proc_myself },
         { "stat", open_self_stat, is_proc_myself },
         { "auxv", open_self_auxv, is_proc_myself },
         { "cmdline", open_self_cmdline, is_proc_myself },
-- 
2.40.1


