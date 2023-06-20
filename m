Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B868B737260
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 19:12:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBesp-0003SG-Sz; Tue, 20 Jun 2023 13:11:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qBeso-0003RM-1v
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 13:11:10 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qBesl-0002bY-OF
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 13:11:09 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35KGETg5018869; Tue, 20 Jun 2023 17:11:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=xCHkRH728dnGUUL4kehOSFDx04GAKvPw7FNnaPepA1A=;
 b=19KULylNYtSnEZQPEu4+C59ONJONz6pSlBlp9Ut79N/p/9XbGMLZNDDrU+TZ3AnMdHuv
 tpdhjAzOpQisZ1zcEqIzdmNc3TllckOROrRqzQfgJ4h/PajBPjTOpAk+S1hcUIFXUdsc
 +sWoQ5olKGGRhdhJKQdGswhGMBgVhorFwNqDMFzpoZ4HCInxsX5wAy9cNvxFIKUmfXSE
 DJSAMZ5juXGyngtS6aVWNH1yQFtbqljnkglNEGErAhB34Sn9qm0H+4T6TboRYT7e+bPB
 G+0T5md3AOARPM1xWoaU7O/P1HxI2acagets4J/5rw/3/j1JCN3oQWjgeukjoitYL0iz Ig== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r94qa584j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 Jun 2023 17:11:04 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35KG8qr0038638; Tue, 20 Jun 2023 17:11:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3r9394vxk3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 Jun 2023 17:11:03 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35KH6wVT025035;
 Tue, 20 Jun 2023 17:11:02 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 3r9394vxha-4; Tue, 20 Jun 2023 17:11:02 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V3 3/4] util: strv_from_strList
Date: Tue, 20 Jun 2023 10:10:58 -0700
Message-Id: <1687281059-111268-4-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1687281059-111268-1-git-send-email-steven.sistare@oracle.com>
References: <1687281059-111268-1-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-20_12,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 suspectscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306200155
X-Proofpoint-GUID: xlzX8-h8WFkS9wqqmB6g7tjG65TL_-xV
X-Proofpoint-ORIG-GUID: xlzX8-h8WFkS9wqqmB6g7tjG65TL_-xV
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/qemu/strList.h |  6 ++++++
 util/strList.c         | 14 ++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/qemu/strList.h b/include/qemu/strList.h
index 1f4c11d..629d76b 100644
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
index 217746e..be40e02 100644
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


