Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D918082C76B
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 23:50:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOQLB-0001gu-TG; Fri, 12 Jan 2024 17:49:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rOQL8-0001gO-Om
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 17:49:26 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rOQL5-0006Tg-8N
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 17:49:25 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40CMkqQT023245; Fri, 12 Jan 2024 22:49:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=0Cyb/yyyPFJneYKBffi/RWX8RaIaY3JpCn7BbCajCa8=;
 b=cl2UPB8cZPpKUNcUKogSy2qzAWp+8NBB5WaYTukCuxXeT7swGC3Vie2uUZ+fa/HBui+F
 KSbRlpwgD9QEsjxW+kCfcngNmClJz9AbaBVbZZ30XLituV/kV8JaiiRI5SHcrXWmjM6r
 Ch75v4uxX97Va5sF1ksQpy1GaGDdz54kdh7mTUo/OoqtvLiTZzGIUGH54vkoSMaPZiPo
 SNkrTpnGfZw39MKXAuegIsER6LKk/q1zWI+nUbCP8NKE3JTLOfyqpkQjfu6T864tPP2C
 VPcEarppz9ScTJykVT/SwrtKwRHOHzTXwaXwoyPpjUm0/ieWQqQSHx7kIs6QZf46u5bE Og== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vk7bgrx94-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Jan 2024 22:49:20 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 40CLgRpd008684; Fri, 12 Jan 2024 22:49:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3vfuuqay6n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Jan 2024 22:49:19 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40CMnIrs004223;
 Fri, 12 Jan 2024 22:49:19 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3vfuuqay5t-2; Fri, 12 Jan 2024 22:49:19 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V4 1/5] util: strList_from_string
Date: Fri, 12 Jan 2024 14:49:14 -0800
Message-Id: <1705099758-211963-2-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1705099758-211963-1-git-send-email-steven.sistare@oracle.com>
References: <1705099758-211963-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-12_12,2024-01-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 phishscore=0 mlxscore=0
 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401120178
X-Proofpoint-ORIG-GUID: PDe58u8Cl2MEF22Ku2rBmj7VJCFiqZNm
X-Proofpoint-GUID: PDe58u8Cl2MEF22Ku2rBmj7VJCFiqZNm
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Generalize hmp_split_at_comma() to take any delimiter string, rename
as strList_from_string(), and move it to util/strList.c.

No functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 include/monitor/hmp.h  |  1 -
 include/qemu/strList.h | 24 ++++++++++++++++++++++++
 monitor/hmp-cmds.c     | 19 -------------------
 net/net-hmp-cmds.c     |  3 ++-
 stats/stats-hmp-cmds.c |  3 ++-
 util/meson.build       |  1 +
 util/strList.c         | 24 ++++++++++++++++++++++++
 7 files changed, 53 insertions(+), 22 deletions(-)
 create mode 100644 include/qemu/strList.h
 create mode 100644 util/strList.c

diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index 13f9a2d..2df661e 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -19,7 +19,6 @@
 
 bool hmp_handle_error(Monitor *mon, Error *err);
 void hmp_help_cmd(Monitor *mon, const char *name);
-strList *hmp_split_at_comma(const char *str);
 
 void hmp_info_name(Monitor *mon, const QDict *qdict);
 void hmp_info_version(Monitor *mon, const QDict *qdict);
diff --git a/include/qemu/strList.h b/include/qemu/strList.h
new file mode 100644
index 0000000..010237f
--- /dev/null
+++ b/include/qemu/strList.h
@@ -0,0 +1,24 @@
+/*
+ * Copyright (c) 2022 - 2024 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef QEMU_STR_LIST_H
+#define QEMU_STR_LIST_H
+
+#include "qapi/qapi-builtin-types.h"
+
+/*
+ * Break @in into a strList using the delimiter string @delim.
+ * The delimiter is not included in the result.
+ * Return NULL if @in is NULL or an empty string.
+ * A leading, trailing, or consecutive delimiter produces an
+ * empty string at that position in the output.
+ * All strings are g_strdup'd, and the result can be freed
+ * using qapi_free_strList.
+ */
+strList *strList_from_string(const char *in, const char *delim);
+
+#endif
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 871898a..66b68a0 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -38,25 +38,6 @@ bool hmp_handle_error(Monitor *mon, Error *err)
     return false;
 }
 
-/*
- * Split @str at comma.
- * A null @str defaults to "".
- */
-strList *hmp_split_at_comma(const char *str)
-{
-    char **split = g_strsplit(str ?: "", ",", -1);
-    strList *res = NULL;
-    strList **tail = &res;
-    int i;
-
-    for (i = 0; split[i]; i++) {
-        QAPI_LIST_APPEND(tail, split[i]);
-    }
-
-    g_free(split);
-    return res;
-}
-
 void hmp_info_name(Monitor *mon, const QDict *qdict)
 {
     NameInfo *info;
diff --git a/net/net-hmp-cmds.c b/net/net-hmp-cmds.c
index 41d326b..e893801 100644
--- a/net/net-hmp-cmds.c
+++ b/net/net-hmp-cmds.c
@@ -26,6 +26,7 @@
 #include "qemu/config-file.h"
 #include "qemu/help_option.h"
 #include "qemu/option.h"
+#include "qemu/strList.h"
 
 void hmp_info_network(Monitor *mon, const QDict *qdict)
 {
@@ -72,7 +73,7 @@ void hmp_announce_self(Monitor *mon, const QDict *qdict)
                                             migrate_announce_params());
 
     qapi_free_strList(params->interfaces);
-    params->interfaces = hmp_split_at_comma(interfaces_str);
+    params->interfaces = strList_from_string(interfaces_str, ",");
     params->has_interfaces = params->interfaces != NULL;
     params->id = g_strdup(id);
     qmp_announce_self(params, NULL);
diff --git a/stats/stats-hmp-cmds.c b/stats/stats-hmp-cmds.c
index 1f91bf8..428c0e6 100644
--- a/stats/stats-hmp-cmds.c
+++ b/stats/stats-hmp-cmds.c
@@ -10,6 +10,7 @@
 #include "monitor/hmp.h"
 #include "monitor/monitor.h"
 #include "qemu/cutils.h"
+#include "qemu/strList.h"
 #include "hw/core/cpu.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/error.h"
@@ -176,7 +177,7 @@ static StatsFilter *stats_filter(StatsTarget target, const char *names,
             request->provider = provider_idx;
             if (names && !g_str_equal(names, "*")) {
                 request->has_names = true;
-                request->names = hmp_split_at_comma(names);
+                request->names = strList_from_string(names, ",");
             }
             QAPI_LIST_PREPEND(request_list, request);
         }
diff --git a/util/meson.build b/util/meson.build
index af3bf56..e1d1e1f 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -1,4 +1,5 @@
 util_ss.add(files('osdep.c', 'cutils.c', 'unicode.c', 'qemu-timer-common.c'))
+util_ss.add(files('strList.c'))
 util_ss.add(files('thread-context.c'), numa)
 if not config_host_data.get('CONFIG_ATOMIC64')
   util_ss.add(files('atomic64.c'))
diff --git a/util/strList.c b/util/strList.c
new file mode 100644
index 0000000..7991de3
--- /dev/null
+++ b/util/strList.c
@@ -0,0 +1,24 @@
+/*
+ * Copyright (c) 2023 Red Hat, Inc.
+ * Copyright (c) 2022 - 2024 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/strList.h"
+
+strList *strList_from_string(const char *str, const char *delim)
+{
+    g_autofree char **split = g_strsplit(str ?: "", delim, -1);
+    strList *res = NULL;
+    strList **tail = &res;
+    int i;
+
+    for (i = 0; split[i]; i++) {
+        QAPI_LIST_APPEND(tail, split[i]);
+    }
+
+    return res;
+}
-- 
1.8.3.1


