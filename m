Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59539737264
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 19:12:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBesr-0003T6-HR; Tue, 20 Jun 2023 13:11:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qBeso-0003Rz-WB
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 13:11:11 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qBesm-0002bp-7W
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 13:11:10 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35KGESSF018780; Tue, 20 Jun 2023 17:11:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=LRuiYWImmqQ2SuPV8mquPR+XcHhX1BXRZuoccypIuFo=;
 b=dpxVDZFmgfRGlauRrOIJ3zFx/4rr9SJduMlSarFfAern3eIJ8QX6gcajXd9mSNZPhFe/
 zlWqbW24BSO0hn4mXUwFGWxvUlLGban0RNeGVEaFNlBTs5eq7vs7BnAmObnPqLsgac2p
 TrNC7CW7GxhhsY0em5CXynKoBtfKEONO0gaqK5DDoNMjIAp2pr5Yq4SdORNS7OzrKpjO
 cf4WyujdehM5IDZIbaNKE+5cbj7+2+NZQ79YT76V2j+1Ou74DqS9s19xubwgayRAosVa
 WHUPYy1dh9q/WjXa9n9poXH7ggMWtEKwuDayHiDRp64lFXbhsLxIthV6nd1KBVen2PBD UQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r94qa584n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 Jun 2023 17:11:05 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35KFsxEX038648; Tue, 20 Jun 2023 17:11:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3r9394vxkh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 Jun 2023 17:11:03 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35KH6wVV025035;
 Tue, 20 Jun 2023 17:11:03 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 3r9394vxha-5; Tue, 20 Jun 2023 17:11:03 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V3 4/4] util: strList unit tests
Date: Tue, 20 Jun 2023 10:10:59 -0700
Message-Id: <1687281059-111268-5-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: eEPW81pBgVgT-1dMjdW9pNPXS67U2SgK
X-Proofpoint-ORIG-GUID: eEPW81pBgVgT-1dMjdW9pNPXS67U2SgK
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
 tests/unit/meson.build    |  1 +
 tests/unit/test-strList.c | 80 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 81 insertions(+)
 create mode 100644 tests/unit/test-strList.c

diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index 93977cc..972f2e6 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -34,6 +34,7 @@ tests = {
   'test-rcu-simpleq': [],
   'test-rcu-tailq': [],
   'test-rcu-slist': [],
+  'test-strList': [],
   'test-qdist': [],
   'test-qht': [],
   'test-qtree': [],
diff --git a/tests/unit/test-strList.c b/tests/unit/test-strList.c
new file mode 100644
index 0000000..56df52b
--- /dev/null
+++ b/tests/unit/test-strList.c
@@ -0,0 +1,80 @@
+/*
+ * Copyright (c) 2022, 2023 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/strList.h"
+
+static strList *make_list(int length)
+{
+    strList *head = 0, *list, **prev = &head;
+
+    while (length--) {
+        list = *prev = g_new0(strList, 1);
+        list->value = g_strdup("aaa");
+        prev = &list->next;
+    }
+    return head;
+}
+
+static void test_length(void)
+{
+    strList *list;
+    int i;
+
+    for (i = 0; i < 5; i++) {
+        list = make_list(i);
+        g_assert_cmpint(i, ==, QAPI_LIST_LENGTH(list));
+        qapi_free_strList(list);
+    }
+}
+
+struct {
+    const char *string;
+    const char *delim;
+    const char *args[5];
+} list_data[] = {
+    { 0, ",", { 0 } },
+    { "", ",", { 0 } },
+    { "a", ",", { "a", 0 } },
+    { "a,b", ",", { "a", "b", 0 } },
+    { "a,b,c", ",", { "a", "b", "c", 0 } },
+    { "first last", " ", { "first", "last", 0 } },
+    { "a:", ":", { "a", "", 0 } },
+    { "a::b", ":", { "a", "", "b", 0 } },
+    { ":", ":", { "", "", 0 } },
+    { ":a", ":", { "", "a", 0 } },
+    { "::a", ":", { "", "", "a", 0 } },
+};
+
+static void test_strv(void)
+{
+    int i, j;
+    const char **expect;
+    strList *list;
+    GStrv args;
+
+    for (i = 0; i < ARRAY_SIZE(list_data); i++) {
+        expect = list_data[i].args;
+        list = strList_from_string(list_data[i].string, list_data[i].delim);
+        args = strv_from_strList(list);
+        qapi_free_strList(list);
+        for (j = 0; expect[j] && args[j]; j++) {
+            g_assert_cmpstr(expect[j], ==, args[j]);
+        }
+        g_assert_null(expect[j]);
+        g_assert_null(args[j]);
+        g_strfreev(args);
+    }
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+    g_test_add_func("/test-string/length", test_length);
+    g_test_add_func("/test-string/strv", test_strv);
+    return g_test_run();
+}
-- 
1.8.3.1


