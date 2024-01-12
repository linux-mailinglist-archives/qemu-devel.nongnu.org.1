Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BFD482C76D
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 23:50:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOQLE-0001hu-EA; Fri, 12 Jan 2024 17:49:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rOQLB-0001h3-3U
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 17:49:29 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rOQL7-0006UM-Au
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 17:49:27 -0500
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40CMLhAq029774; Fri, 12 Jan 2024 22:49:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=AbkU3PwamaUqj0zOyCmUxvX/Xa5Cspscrzyan8FoC8I=;
 b=OFCjbb1CDkGT8rYyFWrXmIKPfNc4FhfTw0/Tcy6dMtMLh4iSs+Zr/n5SAReY6hhPEpbM
 WtAb4u7gtkpg5RAUNu2q+7H6Ord4b/1P1bBhVXJSeRcAQkPxl1MrfxiOwEK+0Dy/SfKZ
 68R5T6LXDCsGirbzM+6pbT/iyChS3TRnzlIQhpcdqHVexPnLamnmSTdecnHkKM4SH+2R
 TN+aifHlZP1LUW7+tzHE6w0cV1XYXzkFkvLlQa4D2ZnKKORpmjp0r3Vz0LXSb/Tqh2ri
 m0f3l9f8j4zwlamhyn6uvH0mKXrxKTHZodQICFOWG2BKet942BaltcxpsFJsMfLZESPg QQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vkcs2r5uk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Jan 2024 22:49:21 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 40CLNMRK008682; Fri, 12 Jan 2024 22:49:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3vfuuqay73-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Jan 2024 22:49:20 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40CMnIrw004223;
 Fri, 12 Jan 2024 22:49:20 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3vfuuqay5t-4; Fri, 12 Jan 2024 22:49:20 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V4 3/5] util: strv_from_strList
Date: Fri, 12 Jan 2024 14:49:16 -0800
Message-Id: <1705099758-211963-4-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1705099758-211963-1-git-send-email-steven.sistare@oracle.com>
References: <1705099758-211963-1-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-12_12,2024-01-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 phishscore=0 mlxscore=0
 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401120178
X-Proofpoint-GUID: _nRR_s6tIsaIOQTjcGjYuxuKTDQq4u03
X-Proofpoint-ORIG-GUID: _nRR_s6tIsaIOQTjcGjYuxuKTDQq4u03
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/qemu/strList.h |  6 ++++++
 util/strList.c         | 14 ++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/qemu/strList.h b/include/qemu/strList.h
index 010237f..4b86aa6 100644
--- a/include/qemu/strList.h
+++ b/include/qemu/strList.h
@@ -21,4 +21,10 @@
  */
 strList *strList_from_string(const char *in, const char *delim);
 
+/*
+ * Produce and return a NULL-terminated array of strings from @args.
+ * The result is g_malloc'd and all strings are g_strdup'd.
+ */
+GStrv strv_from_strList(const strList *args);
+
 #endif
diff --git a/util/strList.c b/util/strList.c
index 7991de3..bad4187 100644
--- a/util/strList.c
+++ b/util/strList.c
@@ -22,3 +22,17 @@ strList *strList_from_string(const char *str, const char *delim)
 
     return res;
 }
+
+GStrv strv_from_strList(const strList *args)
+{
+    const strList *arg;
+    int i = 0;
+    GStrv argv = g_new(char *, QAPI_LIST_LENGTH(args) + 1);
+
+    for (arg = args; arg != NULL; arg = arg->next) {
+        argv[i++] = g_strdup(arg->value);
+    }
+    argv[i] = NULL;
+
+    return argv;
+}
-- 
1.8.3.1


