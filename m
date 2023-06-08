Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FA4728044
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 14:43:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7EyL-00030A-B6; Thu, 08 Jun 2023 08:42:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1q7EyD-0002zd-PR
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 08:42:30 -0400
Received: from pv50p00im-zteg10011501.me.com ([17.58.6.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1q7Ey9-0000FP-Nv
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 08:42:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 t=1686228143; bh=IU4eVSgFHWDP+jifjfGdkBe+orZ14DeYHyLKEqxQd3o=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=fDUTgc29WkRH9Qr/GwfRT4XHiqYBQ6pablQICaFht8faX2ohv1dHQwBHWqq50fGHy
 kT7dJvUZwxw5xKPob1yjnz6HCxFXD2jseQ46JkmsGTQY9u+w1ADg9HyH6zvEbisKEY
 DTQ+m+aHN/x1p0/FUsLNL5g9Gd1D1V7sypzyb8ixIyQuOskQJsa9tGz5IZf+Nx3W3g
 Lv8zuU42NR6xFc+a5F1QIQjc77LwBEtt1S0ojWLw4sgYv3hJv0LdCZINGfC262baDG
 2gN0a5D2jCEy3LZ7rgmOG2iOqDBy5lrJVQPgKTMKgVMwkcXZabTUVB5/eBdtGOOsdf
 bjx0CHjo8SsLg==
Received: from localhost.localdomain (pv50p00im-dlb-asmtp-mailmevip.me.com
 [17.56.9.10])
 by pv50p00im-zteg10011501.me.com (Postfix) with ESMTPSA id F05594A0391;
 Thu,  8 Jun 2023 12:42:21 +0000 (UTC)
From: Mads Ynddal <mads@ynddal.dk>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Cleber Rosa <crosa@redhat.com>,
 Mads Ynddal <m.ynddal@samsung.com>
Subject: [PATCH v3 11/14] simpletrace: move event processing to Analyzer class
Date: Thu,  8 Jun 2023 14:41:44 +0200
Message-Id: <20230608124147.51125-12-mads@ynddal.dk>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230608124147.51125-1-mads@ynddal.dk>
References: <20230608124147.51125-1-mads@ynddal.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: dZX8MaBbliyKLsTn82E-nQzkxvsHuB83
X-Proofpoint-ORIG-GUID: dZX8MaBbliyKLsTn82E-nQzkxvsHuB83
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.517,18.0.572,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2022-06-21=5F01:2022-06-21=5F01,2020-02-14=5F11,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
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

Moved event processing to the Analyzer class to separate specific analyzer
logic (like caching and function signatures) from the _process function.
This allows for new types of Analyzer-based subclasses without changing
the core code.

Note, that the fn_cache is important for performance in cases where the
analyzer is branching away from the catch-all a lot. The cache has no
measurable performance penalty.

Signed-off-by: Mads Ynddal <m.ynddal@samsung.com>
---
 scripts/simpletrace.py | 60 +++++++++++++++++++++++++-----------------
 1 file changed, 36 insertions(+), 24 deletions(-)

diff --git a/scripts/simpletrace.py b/scripts/simpletrace.py
index 6969fdd59a..4136d00600 100755
--- a/scripts/simpletrace.py
+++ b/scripts/simpletrace.py
@@ -169,6 +169,35 @@ def catchall(self, event, rec):
         """Called if no specific method for processing a trace event has been found."""
         pass
 
+    def _build_fn(self, event):
+        fn = getattr(self, event.name, None)
+        if fn is None:
+            # Return early to avoid costly call to inspect.getfullargspec
+            return self.catchall
+
+        event_argcount = len(event.args)
+        fn_argcount = len(inspect.getfullargspec(fn)[0]) - 1
+        if fn_argcount == event_argcount + 1:
+            # Include timestamp as first argument
+            return lambda _, rec: fn(*(rec[1:2] + rec[3:3 + event_argcount]))
+        elif fn_argcount == event_argcount + 2:
+            # Include timestamp and pid
+            return lambda _, rec: fn(*rec[1:3 + event_argcount])
+        else:
+            # Just arguments, no timestamp or pid
+            return lambda _, rec: fn(*rec[3:3 + event_argcount])
+
+    def _process_event(self, rec_args, *, event, event_id, timestamp_ns, pid, **kwargs):
+        if not hasattr(self, '_fn_cache'):
+            # NOTE: Cannot depend on downstream subclasses to have
+            # super().__init__() because of legacy.
+            self._fn_cache = {}
+
+        rec = (event_id, timestamp_ns, pid, *rec_args)
+        if event_id not in self._fn_cache:
+            self._fn_cache[event_id] = self._build_fn(event)
+        self._fn_cache[event_id](event, rec)
+
     def end(self):
         """Called at the end of the trace."""
         pass
@@ -222,32 +251,15 @@ def _process(events, log_fobj, analyzer, read_header=True):
     if read_header:
         read_trace_header(log_fobj)
 
-    def build_fn(analyzer, event):
-        if isinstance(event, str):
-            return analyzer.catchall
-
-        fn = getattr(analyzer, event.name, None)
-        if fn is None:
-            return analyzer.catchall
-
-        event_argcount = len(event.args)
-        fn_argcount = len(inspect.getfullargspec(fn)[0]) - 1
-        if fn_argcount == event_argcount + 1:
-            # Include timestamp as first argument
-            return lambda _, rec: fn(*(rec[1:2] + rec[3:3 + event_argcount]))
-        elif fn_argcount == event_argcount + 2:
-            # Include timestamp and pid
-            return lambda _, rec: fn(*rec[1:3 + event_argcount])
-        else:
-            # Just arguments, no timestamp or pid
-            return lambda _, rec: fn(*rec[3:3 + event_argcount])
-
     with analyzer:
-        fn_cache = {}
         for event, event_id, timestamp_ns, record_pid, *rec_args in read_trace_records(events, log_fobj, read_header):
-            if event_id not in fn_cache:
-                fn_cache[event_id] = build_fn(analyzer, event)
-            fn_cache[event_id](event, (event_id, timestamp_ns, record_pid, *rec_args))
+            analyzer._process_event(
+                rec_args,
+                event=event,
+                event_id=event_id,
+                timestamp_ns=timestamp_ns,
+                pid=record_pid,
+            )
 
 def run(analyzer):
     """Execute an analyzer on a trace file given on the command-line.
-- 
2.38.1


