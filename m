Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6277C9A263F
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Oct 2024 17:16:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1SD1-00078h-MF; Thu, 17 Oct 2024 11:14:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t1SCx-00077s-6P
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 11:14:35 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t1SCv-00014r-Iu
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 11:14:34 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HFBv7A024561;
 Thu, 17 Oct 2024 15:14:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=Plx7NKWG6o8+aXxaD4xxaoc4Ah8qyprSQc9PLk5710I=; b=
 WwsQ/PquXZh8I23m79IMGler86ZwZAIWpYDiv6UOZ0xNEpqxUnYxQTeKeU18S4Ia
 ZJeb4pXpGlgFu2KOf8MP4bLOCSwAO9boB526FsnoK8EDh9aEIBvO8+AKWQVSgs8X
 qy4nap+RYEmgJPpY+e8qREV5LNIau7AF9P2jAcBHNOO0GOAeLKwhwyHsvcTzwJIf
 TYhgxLp1JeugSkTLMvpyb/BOxRJMmmKSs5N/VdBSFTzOcOgTXf7fdiyQGy4TIocE
 pIpLT/ObpXbwjGFU91kPobrY8yQYRKCqLgR2xAfaLyfwViQ7qK+FsSKe0s+jIhAG
 B2cKbJmKxg3z2s5XFpS0fA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427fhcp9f1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Oct 2024 15:14:31 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 49HF0CrK027322; Thu, 17 Oct 2024 15:14:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 427fjgy6c5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Oct 2024 15:14:30 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 49HFEHgj017147;
 Thu, 17 Oct 2024 15:14:29 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 427fjgy62e-10; Thu, 17 Oct 2024 15:14:29 +0000
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
Subject: [RFC V1 09/14] qemu-option: filtered foreach
Date: Thu, 17 Oct 2024 08:14:10 -0700
Message-Id: <1729178055-207271-10-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1729178055-207271-1-git-send-email-steven.sistare@oracle.com>
References: <1729178055-207271-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_16,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410170105
X-Proofpoint-GUID: r5jGEB_J2HRV22nNVxeL8JYINFHdAuqP
X-Proofpoint-ORIG-GUID: r5jGEB_J2HRV22nNVxeL8JYINFHdAuqP
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

Define an accessor to loop over an options list and call a function
for each element that passes a filter function.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 include/qemu/option.h |  5 +++++
 util/qemu-option.c    | 25 +++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/include/qemu/option.h b/include/qemu/option.h
index 01e673a..fe37d4c 100644
--- a/include/qemu/option.h
+++ b/include/qemu/option.h
@@ -138,9 +138,14 @@ QDict *qemu_opts_to_qdict_filtered(QemuOpts *opts, QDict *qdict,
 QDict *qemu_opts_to_qdict(QemuOpts *opts, QDict *qdict);
 bool qemu_opts_absorb_qdict(QemuOpts *opts, QDict *qdict, Error **errp);
 
+typedef bool (*qemu_opts_filterfunc)(void *opaque, QemuOpts *opts);
 typedef int (*qemu_opts_loopfunc)(void *opaque, QemuOpts *opts, Error **errp);
 int qemu_opts_foreach(QemuOptsList *list, qemu_opts_loopfunc func,
                       void *opaque, Error **errp);
+int qemu_opts_filter_foreach(QemuOptsList *list,
+                             qemu_opts_filterfunc filter,
+                             qemu_opts_loopfunc func,
+                             void *opaque, Error **errp);
 void qemu_opts_print(QemuOpts *opts, const char *sep);
 void qemu_opts_print_help(QemuOptsList *list, bool print_caption);
 void qemu_opts_free(QemuOptsList *list);
diff --git a/util/qemu-option.c b/util/qemu-option.c
index 201f7a8..f2f02d6 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -1142,6 +1142,31 @@ int qemu_opts_foreach(QemuOptsList *list, qemu_opts_loopfunc func,
     return rc;
 }
 
+int qemu_opts_filter_foreach(QemuOptsList *list,
+                             qemu_opts_filterfunc filter,
+                             qemu_opts_loopfunc func,
+                             void *opaque, Error **errp)
+{
+    Location loc;
+    QemuOpts *opts, *next;
+    int rc = 0;
+
+    loc_push_none(&loc);
+    QTAILQ_FOREACH_SAFE(opts, &list->head, next, next) {
+        if (!filter(opaque, opts)) {
+            continue;
+        }
+        loc_restore(&opts->loc);
+        rc = func(opaque, opts, errp);
+        if (rc) {
+            break;
+        }
+        assert(!errp || !*errp);
+    }
+    loc_pop(&loc);
+    return rc;
+}
+
 static size_t count_opts_list(QemuOptsList *list)
 {
     QemuOptDesc *desc = NULL;
-- 
1.8.3.1


