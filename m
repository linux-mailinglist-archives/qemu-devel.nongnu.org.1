Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 264E99765A2
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Sep 2024 11:32:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sog9z-0007H4-5d; Thu, 12 Sep 2024 05:30:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1sog9k-0006vi-7V
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 05:30:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1sog9g-0004LV-7T
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 05:30:25 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48C9Fj1m003520;
 Thu, 12 Sep 2024 09:30:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=pp1; bh=
 ZBw8sjq6PQLHkvAQ60B4YsQnBd3LLJBvBMXzOt5br1k=; b=A4dgkhfu3LiiGLLg
 98zhAyxEmsnzvYBUK7g+CMuXUHaA1m1uf0BrfGspUMUbdJbnpTIuf1/nGHyOKim0
 bmMq+2xJbPsqWtK/dK6igDa+FzL7vag9fz5mnbZlJ6DpVjRx9sYdOVbugNW0umRr
 kw2zSH4CM0pFTuzFVsWB67fhR8aWJRuoyEMtiMqBgfOW2UTcgorl0jbBEnfQLL6b
 UBKEHXiYAShnJxCV3LoQ55blGd3zQk9W6lAkeLAR9z+88n/7gtIzR3sjLc0WH9gt
 UBS872E6zL9UU5rFlE85iLH5Id0N3XtAWBUF3/7XqMF67KkQ4kjKhYD/4ZHjZj3a
 9vqS2A==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gc8qjwt1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Sep 2024 09:30:21 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48C9UKdq015191;
 Thu, 12 Sep 2024 09:30:20 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gc8qjwsv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Sep 2024 09:30:20 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48C6rOu9032103;
 Thu, 12 Sep 2024 09:30:20 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41h2nmxx48-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Sep 2024 09:30:19 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48C9UHFU51708392
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Sep 2024 09:30:17 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D1A0D2004B;
 Thu, 12 Sep 2024 09:30:17 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 71B6320040;
 Thu, 12 Sep 2024 09:30:17 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.24.155])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 12 Sep 2024 09:30:17 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 5/5] tests/tcg: Run test-proc-mappings.py on i386
Date: Thu, 12 Sep 2024 11:28:24 +0200
Message-ID: <20240912093012.402366-6-iii@linux.ibm.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240912093012.402366-1-iii@linux.ibm.com>
References: <20240912093012.402366-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pAtDUcozYHkNs4-F1YtkOaoiN0hO44h_
X-Proofpoint-ORIG-GUID: lXpdHqJWcschkpFKnjVIuQeOSh5g_xBY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-12_01,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 clxscore=1015 mlxlogscore=999 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409120063
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Now that orig_ax is exposed and GDB is happy, don't skip
test-proc-mappings.py on i386. In fact, it's broken only on
m68k now, so skip only this architecture.

Acked-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 .../tcg/multiarch/gdbstub/test-proc-mappings.py | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/tests/tcg/multiarch/gdbstub/test-proc-mappings.py b/tests/tcg/multiarch/gdbstub/test-proc-mappings.py
index 564613fabf0..0f687f3284a 100644
--- a/tests/tcg/multiarch/gdbstub/test-proc-mappings.py
+++ b/tests/tcg/multiarch/gdbstub/test-proc-mappings.py
@@ -8,17 +8,12 @@
 
 def run_test():
     """Run through the tests one by one"""
-    try:
-        mappings = gdb.execute("info proc mappings", False, True)
-    except gdb.error as exc:
-        exc_str = str(exc)
-        if "Not supported on this target." in exc_str:
-            # Detect failures due to an outstanding issue with how GDB handles
-            # the x86_64 QEMU's target.xml, which does not contain the
-            # definition of orig_rax. Skip the test in this case.
-            print("SKIP: {}".format(exc_str))
-            return
-        raise
+    if gdb.selected_inferior().architecture().name() == "m68k":
+        # m68k GDB supports only GDB_OSABI_SVR4, but GDB_OSABI_LINUX is
+        # required for the info proc support (see set_gdbarch_info_proc()).
+        print("SKIP: m68k GDB does not support GDB_OSABI_LINUX")
+        exit(0)
+    mappings = gdb.execute("info proc mappings", False, True)
     report(isinstance(mappings, str), "Fetched the mappings from the inferior")
     # Broken with host page size > guest page size
     # report("/sha1" in mappings, "Found the test binary name in the mappings")
-- 
2.46.0


