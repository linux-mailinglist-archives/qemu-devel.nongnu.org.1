Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7335EAB3C4A
	for <lists+qemu-devel@lfdr.de>; Mon, 12 May 2025 17:37:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEVBZ-00089d-3z; Mon, 12 May 2025 11:35:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uEV9n-0004hz-LV
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:33:31 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uEV9k-0006hd-2I
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:33:31 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CC9ffN018643;
 Mon, 12 May 2025 15:33:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=B9/g46ZvoKRHHmAe7FwRk1gNIB+zt+riOUzNYBy00O8=; b=
 OS0TpW5UqtkwpOXXD2mJi9AYlipG6+P7bC+AiRwCzk4MOMXfjkNUWcfpNoxSAiP/
 GL6nWDWDPoSOYb54srKIvSKh9w6o4lb/kXpk/515b3DF2djMxs6TOIJAW4choLXo
 J522ggsQNg2ys54nAihD7FuY7RPW0aIk4FYGim3sgwiw3m79HwBg4hErKksLVyKo
 lJalaIrbsp0yxofKMkXLVjWUOyKHBUFQxga65Spyd8ba57z6pbnVxVkgzCD7WBcp
 Nt+gzQ6SCj76lW97p18z6mgu0BLrLzPDO9sYtTsD+qu2XDBVFaE7Uiksph3eRHoq
 1nXefBvJ8h0uCXXu3L0+Gw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j13r2se9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 15:33:14 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54CEBOeJ002837; Mon, 12 May 2025 15:33:14 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46jwx366n3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 15:33:14 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54CFWk5S030605;
 Mon, 12 May 2025 15:33:13 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 46jwx36627-26; Mon, 12 May 2025 15:33:13 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V3 25/42] migration: cpr_get_fd_param helper
Date: Mon, 12 May 2025 08:32:36 -0700
Message-Id: <1747063973-124548-26-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_05,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505120161
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE2MSBTYWx0ZWRfX5BF3sVVOSPmQ
 EDK25Od8jq0RaFNAtZfhYadyqStuIj/eSEO+xo6p0nm2yYzRo8trE3LKWplgjyt49gR/GMzSrLI
 jt6vekZqqJcKO6yShsR2ao8uiXsrDEQyyBd20y9VxDFAScM75XSlWf96TLSJOi4uedZdmd/8ISH
 XVlUMh0j9t1sz+B2Z7fy8xO0F3HM0RgrNqtWPyQV0HCIVAl/UXren5d8nsebULBZZ2t2KqzY4X7
 8xG+DEOcwR9EjS1qPFvHUXzp4onUdafaAiFMBCNt9JT0sGmjFWGKxnB/U1OaUpj1hXPt33Tkawj
 DVGzQjItk0xk7eMwdlzuuTH8816TQ9dUB4P6EP00B9YxX4lnX295Gyuwazs15hznZU8jEO58wxk
 KsvycMZxLGWAgbyTi+Uah2iHJj7bXbU2CEHQC68u+1vVrE6l8GVlr1HxXT7pAU9tkTI9yb1F
X-Proofpoint-GUID: aiL65rtTnSE2jWr9U_BgEdFNfUbWE0dk
X-Proofpoint-ORIG-GUID: aiL65rtTnSE2jWr9U_BgEdFNfUbWE0dk
X-Authority-Analysis: v=2.4 cv=M6hNKzws c=1 sm=1 tr=0 ts=682214bb b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=xj5pLq7tU-gV2qsf3bMA:9
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.499,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Add the helper function cpr_get_fd_param, to use when preserving
a file descriptor that is opened externally and passed to QEMU.
cpr_get_fd_param returns a descriptor number either from a QEMU
command-line parameter, from a getfd command, or from CPR state.

When a descriptor is passed to new QEMU via SCM_RIGHTS, its number
changes.  Hence, during CPR, the command-line parameter is ignored
in new QEMU, and over-ridden by the value found in CPR state.

Similarly, if the descriptor was originally specified by a getfd
command in old QEMU, the fd number is not known outside of QEMU,
and it changes when sent to new QEMU via SCM_RIGHTS.  Hence the
user cannot send getfd to new QEMU, but when the user sends a
hotplug command that references the fd, cpr_get_fd_param finds
its value in CPR state.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 include/migration/cpr.h |  2 ++
 migration/cpr.c         | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/include/migration/cpr.h b/include/migration/cpr.h
index 5f1ff10..353fd34 100644
--- a/include/migration/cpr.h
+++ b/include/migration/cpr.h
@@ -32,6 +32,8 @@ struct QIOChannel *cpr_state_ioc(void);
 
 bool cpr_needed_for_reuse(void *opaque);
 void cpr_kvm_close(void);
+int cpr_get_fd_param(const char *name, const char *fdname, int index,
+                     bool *reused, Error **errp);
 
 void cpr_transfer_init(void);
 QEMUFile *cpr_transfer_output(MigrationChannel *channel, Error **errp);
diff --git a/migration/cpr.c b/migration/cpr.c
index 6102d04..179aed1 100644
--- a/migration/cpr.c
+++ b/migration/cpr.c
@@ -14,6 +14,7 @@
 #include "migration/qemu-file.h"
 #include "migration/savevm.h"
 #include "migration/vmstate.h"
+#include "monitor/monitor.h"
 #include "system/kvm.h"
 #include "system/runstate.h"
 #include "trace.h"
@@ -260,3 +261,42 @@ void cpr_kvm_close(void)
     kvm_close();
     vfio_kvm_device_close();
 }
+
+/*
+ * cpr_get_fd_param: find a descriptor and return its value.
+ *
+ * @name: CPR name for the descriptor
+ * @fdname: An integer-valued string, or a name passed to a getfd command
+ * @index: CPR index of the descriptor
+ * @reused: returns true if the fd is found in CPR state, else false.
+ * @errp: returned error message
+ *
+ * If CPR is not being performed, then use @fdname to find the fd.
+ * If CPR is being performed, then ignore @fdname, and look for @name
+ * and @index in CPR state.
+ *
+ * On success returns the fd value, else returns -1.
+ */
+int cpr_get_fd_param(const char *name, const char *fdname, int index,
+                     bool *reused, Error **errp)
+{
+    ERRP_GUARD();
+    int fd;
+
+    if (cpr_is_incoming()) {
+        fd = cpr_find_fd(name, index);
+        if (fd < 0) {
+            error_setg(errp, "cannot find saved value for fd %s", fdname);
+        }
+        *reused = true;
+    } else {
+        fd = monitor_fd_param(monitor_cur(), fdname, errp);
+        if (fd >= 0) {
+            cpr_save_fd(name, index, fd);
+        } else {
+            error_prepend(errp, "Could not parse object fd %s:", fdname);
+        }
+        *reused = false;
+    }
+    return fd;
+}
-- 
1.8.3.1


