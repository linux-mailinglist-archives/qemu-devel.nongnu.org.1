Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C049E0398
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Dec 2024 14:35:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI6Zy-0005Oq-8V; Mon, 02 Dec 2024 08:35:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tI6Lo-00081m-O8
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:20:41 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tI6Lj-0005nw-5X
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:20:30 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B26X0YZ008619;
 Mon, 2 Dec 2024 13:20:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=7OQmLlx/PoPLowHM1tzFKaWQQg/KV0GS0o4j8Vd8xL0=; b=
 JlwHAyXfXuj7MYbpLxfW5WGSB/kEy7XVH4whlSSNSr1ypcFjbJyjQcgtc4ptP9Yk
 4LUT/TcUYgRGwK4vmevurtpWCSRMRiYFzp56IwS7r0jwEJ5CLBxtE/ygi2tI1YjD
 rmqBu8vtHSphCDysf3xc/oqcRiTzDoeAE2DK1igVwRLMb+wgRzTBtipV6OMhYd7s
 40+hzyFEJheOCqpJaCdouSdA9Om0PpxfBxlZKAwYRNSr+5v+rVHHDRVR93BlwkCk
 Kid7TI8T8MIvGGx9EsUyRr6tpLfwItNr6XirvsNa2Qt6j6S907vHCdMAIsXySDg7
 d+uDPOT4kofXcJOVWrEORA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437s9ytymk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 02 Dec 2024 13:20:23 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4B2CFJhN032114; Mon, 2 Dec 2024 13:20:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 437s56jts5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 02 Dec 2024 13:20:22 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4B2DKCEv032806;
 Mon, 2 Dec 2024 13:20:22 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 437s56jthv-13; Mon, 02 Dec 2024 13:20:21 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V4 12/19] migration: VMSTATE_FD
Date: Mon,  2 Dec 2024 05:20:04 -0800
Message-Id: <1733145611-62315-13-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1733145611-62315-1-git-send-email-steven.sistare@oracle.com>
References: <1733145611-62315-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-02_09,2024-12-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999
 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412020116
X-Proofpoint-GUID: M2o9xaSHQbRZAE62WGbzUFVWho6UTEfi
X-Proofpoint-ORIG-GUID: M2o9xaSHQbRZAE62WGbzUFVWho6UTEfi
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Define VMSTATE_FD for declaring a file descriptor field in a
VMStateDescription.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 include/migration/vmstate.h |  9 +++++++++
 migration/vmstate-types.c   | 23 +++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index f313f2f..a1dfab4 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -230,6 +230,7 @@ extern const VMStateInfo vmstate_info_uint8;
 extern const VMStateInfo vmstate_info_uint16;
 extern const VMStateInfo vmstate_info_uint32;
 extern const VMStateInfo vmstate_info_uint64;
+extern const VMStateInfo vmstate_info_fd;
 
 /** Put this in the stream when migrating a null pointer.*/
 #define VMS_NULLPTR_MARKER (0x30U) /* '0' */
@@ -902,6 +903,9 @@ extern const VMStateInfo vmstate_info_qlist;
 #define VMSTATE_UINT64_V(_f, _s, _v)                                  \
     VMSTATE_SINGLE(_f, _s, _v, vmstate_info_uint64, uint64_t)
 
+#define VMSTATE_FD_V(_f, _s, _v)                                  \
+    VMSTATE_SINGLE(_f, _s, _v, vmstate_info_fd, int32_t)
+
 #ifdef CONFIG_LINUX
 
 #define VMSTATE_U8_V(_f, _s, _v)                                   \
@@ -936,6 +940,9 @@ extern const VMStateInfo vmstate_info_qlist;
 #define VMSTATE_UINT64(_f, _s)                                        \
     VMSTATE_UINT64_V(_f, _s, 0)
 
+#define VMSTATE_FD(_f, _s)                                            \
+    VMSTATE_FD_V(_f, _s, 0)
+
 #ifdef CONFIG_LINUX
 
 #define VMSTATE_U8(_f, _s)                                         \
@@ -1009,6 +1016,8 @@ extern const VMStateInfo vmstate_info_qlist;
 #define VMSTATE_UINT64_TEST(_f, _s, _t)                                  \
     VMSTATE_SINGLE_TEST(_f, _s, _t, 0, vmstate_info_uint64, uint64_t)
 
+#define VMSTATE_FD_TEST(_f, _s, _t)                                            \
+    VMSTATE_SINGLE_TEST(_f, _s, _t, 0, vmstate_info_fd, int32_t)
 
 #define VMSTATE_TIMER_PTR_TEST(_f, _s, _test)                             \
     VMSTATE_POINTER_TEST(_f, _s, _test, vmstate_info_timer, QEMUTimer *)
diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
index e83bfcc..f31deb3 100644
--- a/migration/vmstate-types.c
+++ b/migration/vmstate-types.c
@@ -314,6 +314,29 @@ const VMStateInfo vmstate_info_uint64 = {
     .put  = put_uint64,
 };
 
+/* File descriptor communicated via SCM_RIGHTS */
+
+static int get_fd(QEMUFile *f, void *pv, size_t size,
+                  const VMStateField *field)
+{
+    int32_t *v = pv;
+    *v = qemu_file_get_fd(f);
+    return 0;
+}
+
+static int put_fd(QEMUFile *f, void *pv, size_t size,
+                  const VMStateField *field, JSONWriter *vmdesc)
+{
+    int32_t *v = pv;
+    return qemu_file_put_fd(f, *v);
+}
+
+const VMStateInfo vmstate_info_fd = {
+    .name = "fd",
+    .get  = get_fd,
+    .put  = put_fd,
+};
+
 static int get_nullptr(QEMUFile *f, void *pv, size_t size,
                        const VMStateField *field)
 
-- 
1.8.3.1


