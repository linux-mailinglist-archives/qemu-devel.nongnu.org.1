Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 005529FC00D
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Dec 2024 17:19:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQ7bW-0003Sr-0Y; Tue, 24 Dec 2024 11:17:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tQ7b7-0003DI-W4
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 11:17:30 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tQ7b6-0003Dy-CZ
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 11:17:29 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BOEfabe003831;
 Tue, 24 Dec 2024 16:17:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=pdWx7H/17ATBvFu+JQKPrEiDe4qDsmeSn/q16+5CRsE=; b=
 isIw7tcZTqkKUFy985LLDNjnIa70iyBsz5pqCpJYCO34BnYtM+zr99a7ttOFNfSS
 w39TmkXWaC+ZrUvpXvNyNa+F0ckn/hiBtCH/BY1IoKMMvoXNaaWPsK+71JdVkHwx
 fBFAlRkdM1UQixevOttwLtCn2JeNyiRveJwmqZ0CES6c/sWt+yvOqho4kL7iVQea
 SD6/ckdhSwj83stVQNeDQjZI9apqbQ44gl0xtt6C1cwivS/w8J2cIkkqxebshgfR
 9E+SotdkZA+8muKu5c+glv8HBlhOfttg8hhmMEPusQBsPHUI8EW9uq3yudzl/5xi
 ZExTH7U/lRzhbjp/2gGubQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43nqd5mg0a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Dec 2024 16:17:24 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4BOExGBF022541; Tue, 24 Dec 2024 16:17:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 43nm484gpa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Dec 2024 16:17:24 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4BOGH9Xw021973;
 Tue, 24 Dec 2024 16:17:23 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 43nm484ggj-22; Tue, 24 Dec 2024 16:17:23 +0000
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
Subject: [PATCH V5 21/23] tests/qtest: assert qmp_ready
Date: Tue, 24 Dec 2024 08:17:06 -0800
Message-Id: <1735057028-308595-22-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1735057028-308595-1-git-send-email-steven.sistare@oracle.com>
References: <1735057028-308595-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-24_06,2024-12-24_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412240141
X-Proofpoint-GUID: t-t4ifoidho_V12xpnh87Is746fNlugY
X-Proofpoint-ORIG-GUID: t-t4ifoidho_V12xpnh87Is746fNlugY
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

Set qmp_ready when the handshake is complete, and assert it when we
communicate with the monitor.

Suggested-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 tests/qtest/libqtest.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 2f44d3c..43ee92f 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -77,6 +77,7 @@ struct QTestState
     int qmp_fd;
     int sock;
     int qmpsock;
+    bool qmp_ready;
     pid_t qemu_pid;  /* our child QEMU process */
     int wstatus;
 #ifdef _WIN32
@@ -552,14 +553,23 @@ void qtest_connect(QTestState *s)
 
 QTestState *qtest_init_without_qmp_handshake(const char *extra_args)
 {
-    return qtest_init_internal(qtest_qemu_binary(NULL), extra_args, true);
+    QTestState *s = qtest_init_internal(qtest_qemu_binary(NULL), extra_args,
+                                        true);
+
+    /* Not really ready, but callers need it to test handshakes */
+    s->qmp_ready = true;
+    return s;
 }
 
 void qtest_qmp_handshake(QTestState *s)
 {
+    g_autoptr(QDict) greeting = NULL;
+
+    /* Set ready first because functions called below assert it */
+    s->qmp_ready = true;
+
     /* Read the QMP greeting and then do the handshake */
-    QDict *greeting = qtest_qmp_receive(s);
-    qobject_unref(greeting);
+    greeting = qtest_qmp_receive(s);
     qobject_unref(qtest_qmp(s, "{ 'execute': 'qmp_capabilities' }"));
 }
 
@@ -786,6 +796,7 @@ QDict *qtest_qmp_receive(QTestState *s)
 
 QDict *qtest_qmp_receive_dict(QTestState *s)
 {
+    g_assert(s->qmp_ready);
     return qmp_fd_receive(s->qmp_fd);
 }
 
@@ -813,12 +824,14 @@ int qtest_socket_server(const char *socket_path)
 void qtest_qmp_vsend_fds(QTestState *s, int *fds, size_t fds_num,
                          const char *fmt, va_list ap)
 {
+    g_assert(s->qmp_ready);
     qmp_fd_vsend_fds(s->qmp_fd, fds, fds_num, fmt, ap);
 }
 #endif
 
 void qtest_qmp_vsend(QTestState *s, const char *fmt, va_list ap)
 {
+    g_assert(s->qmp_ready);
     qmp_fd_vsend(s->qmp_fd, fmt, ap);
 }
 
@@ -879,6 +892,7 @@ void qtest_qmp_send_raw(QTestState *s, const char *fmt, ...)
 {
     va_list ap;
 
+    g_assert(s->qmp_ready);
     va_start(ap, fmt);
     qmp_fd_vsend_raw(s->qmp_fd, fmt, ap);
     va_end(ap);
-- 
1.8.3.1


