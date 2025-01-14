Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 05982A10DB1
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Jan 2025 18:26:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXken-0004vm-Jv; Tue, 14 Jan 2025 12:24:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tXkeg-0004rQ-M4
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 12:24:44 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tXkec-0004YS-MR
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 12:24:41 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50EC1KiK021480;
 Tue, 14 Jan 2025 17:24:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=JXd7WYOHB/FQPAur0tpiq03gTkf2SDCJXxYbme2aMps=; b=
 Aqdvke+iC3GoYtuhozQfeUIxJDnV4HD+jD6DNe5LXqIvzJu6s+PBHCLmClOxdkwK
 WwgJT97mhc+ckZQJgE1Hvrw4/ElDbvylWqTOC6nB4MMfP+c67sJBPnc1b5kANvpA
 NopMph+XTyqB9mVbzdTPREPoYFUvaallZmA9xHk5gwIzsWbRflquGqVJHEvL/ZNL
 79rnnIKcCtygCPJdsK/NJCR4dfFT90mSbG8hP/NqwTPzOpZRRo+pTZJ4fZZ3ARIK
 gARGcYqkVQArBctEGwKkwI3dxvH4Xjmb2MBMtcN6moluFBum5oMDJhXFfSUm6O6V
 oHidDncezERCmWdZe5a/yw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 443gpcpc15-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Jan 2025 17:24:21 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 50EGHH83020364; Tue, 14 Jan 2025 17:24:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 443f3eq6h7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Jan 2025 17:24:20 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 50EHNtXw013352;
 Tue, 14 Jan 2025 17:24:20 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 443f3eq5us-15; Tue, 14 Jan 2025 17:24:20 +0000
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
Subject: [PATCH V6 14/24] migration: VMSTATE_FD
Date: Tue, 14 Jan 2025 09:23:44 -0800
Message-Id: <1736875434-106563-15-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1736875434-106563-1-git-send-email-steven.sistare@oracle.com>
References: <1736875434-106563-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-14_05,2025-01-13_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 spamscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501140133
X-Proofpoint-GUID: 9OkwNareu8Yi1cWQj_M_uSw6imosbD19
X-Proofpoint-ORIG-GUID: 9OkwNareu8Yi1cWQj_M_uSw6imosbD19
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
index d70d573..0319c35 100644
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


