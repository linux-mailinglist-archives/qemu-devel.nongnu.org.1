Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B159D728048
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 14:43:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7EyD-0002zE-QG; Thu, 08 Jun 2023 08:42:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1q7Ey9-0002yL-VP
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 08:42:25 -0400
Received: from pv50p00im-zteg10011501.me.com ([17.58.6.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1q7Ey6-0000Eg-NW
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 08:42:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 t=1686228141; bh=WJybbYg8Al1st0uItsQ36eA7qhiUWArDe/Aix+sMO1c=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=Urf/gmIigCIY4rWomqT1D2NtakhhzKQnTKBOglGj99iUBqZUWRYId7PYfb+uzfZ77
 dNr3dtwgNJM7+AwHKIRdU7JhQ53r+ME5sfiio8JWB/CBlaqavN+Nzey6vs2BzsPhpN
 sEOoGJbIy8Dlu2h7lBDa0uWvCa0RMyknFcE0jQix7TfWy863G0ybzc6SDAtcE//bOn
 Xt9S1hWm/k22uiUYbaV4TGNO82QktGQlx6BUms8qg/kQeQGolH/WXjD6M0asx33XIb
 8N6STPHj1lRRxdDZzYsmC0pBtOQbl/2gOgfVALXWtHFif8HzFPcuA29MzUuJsdOTXA
 cNm2twhlpkpiQ==
Received: from localhost.localdomain (pv50p00im-dlb-asmtp-mailmevip.me.com
 [17.56.9.10])
 by pv50p00im-zteg10011501.me.com (Postfix) with ESMTPSA id 667B14A0397;
 Thu,  8 Jun 2023 12:42:19 +0000 (UTC)
From: Mads Ynddal <mads@ynddal.dk>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Cleber Rosa <crosa@redhat.com>,
 Mads Ynddal <m.ynddal@samsung.com>
Subject: [PATCH v3 10/14] simpletrace: move logic of process into internal
 function
Date: Thu,  8 Jun 2023 14:41:43 +0200
Message-Id: <20230608124147.51125-11-mads@ynddal.dk>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230608124147.51125-1-mads@ynddal.dk>
References: <20230608124147.51125-1-mads@ynddal.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: YZAkaEgX6rWIedgWZTxcjLWta15SQpU9
X-Proofpoint-ORIG-GUID: YZAkaEgX6rWIedgWZTxcjLWta15SQpU9
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.517,18.0.572,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2022-06-21=5F01:2022-06-21=5F01,2020-02-14=5F11,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0
 mlxlogscore=793 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 clxscore=1030 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2306080110
Received-SPF: pass client-ip=17.58.6.42; envelope-from=mads@ynddal.dk;
 helo=pv50p00im-zteg10011501.me.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Mads Ynddal <m.ynddal@samsung.com>

To avoid duplicate code depending on input types and to better handle
open/close of log with a context-manager, we move the logic of process into
_process.

Signed-off-by: Mads Ynddal <m.ynddal@samsung.com>
---
 scripts/simpletrace.py | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/scripts/simpletrace.py b/scripts/simpletrace.py
index 0826aef283..6969fdd59a 100755
--- a/scripts/simpletrace.py
+++ b/scripts/simpletrace.py
@@ -201,13 +201,26 @@ def process(events, log, analyzer, read_header=True):
         # Treat as an already opened file-object
         events_list = read_events(events, events.name)
 
-    close_log = False
     if isinstance(log, str):
-        log = open(log, 'rb')
-        close_log = True
+        with open(log, 'rb') as log_fobj:
+            _process(events_list, log_fobj, analyzer, read_header)
+    else:
+        # Treat `log` as an already opened file-object. We will not close it,
+        # as we do not own it.
+        _process(events_list, log, analyzer, read_header)
+
+def _process(events, log_fobj, analyzer, read_header=True):
+    """Internal function for processing
+
+    Args:
+        events (list): list of events already produced by tracetool.read_events
+        log_fobj (file): file-object to read log data from
+        analyzer (Analyzer): the Analyzer to interpret the event data
+        read_header (bool, optional): Whether to read header data from the log data. Defaults to True.
+    """
 
     if read_header:
-        read_trace_header(log)
+        read_trace_header(log_fobj)
 
     def build_fn(analyzer, event):
         if isinstance(event, str):
@@ -231,14 +244,11 @@ def build_fn(analyzer, event):
 
     with analyzer:
         fn_cache = {}
-        for event, event_id, timestamp_ns, record_pid, *rec_args in read_trace_records(events, log, read_header):
+        for event, event_id, timestamp_ns, record_pid, *rec_args in read_trace_records(events, log_fobj, read_header):
             if event_id not in fn_cache:
                 fn_cache[event_id] = build_fn(analyzer, event)
             fn_cache[event_id](event, (event_id, timestamp_ns, record_pid, *rec_args))
 
-    if close_log:
-        log.close()
-
 def run(analyzer):
     """Execute an analyzer on a trace file given on the command-line.
 
-- 
2.38.1


