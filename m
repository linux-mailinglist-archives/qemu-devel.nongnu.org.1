Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1AE78532F
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 10:56:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYjdu-0004U8-V9; Wed, 23 Aug 2023 04:55:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1qYjdr-0004O4-Au
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 04:55:07 -0400
Received: from pv50p00im-tydg10021701.me.com ([17.58.6.54])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1qYjdp-000051-AM
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 04:55:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 t=1692780903; bh=IU4eVSgFHWDP+jifjfGdkBe+orZ14DeYHyLKEqxQd3o=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=eBFZPj/+QRjOlp0Jdbscy36waqUe5sjFsWU+MmSJ4SzJ9Cv7qPiAhB8x5Oa3I5IcE
 2BqeRv5upE57h2tgiF7O1pQF6HUhxaj7ZPE9il1K7pDJoo4zfgOPlUobDQrbnIzww1
 ueKxG36/7VPnxmClfCoRVpG7sz7wauQBYoC626fJFF/p1Fu515l6HNmCsa0BJtMC6J
 OKCjBx1Bop6UlesuLH8BC8uXxowVENPIjkV6atLkrxhJJegTmPoUNrMBiNeX/Tb5gr
 zgjef10nGQCHzItYSj0Qz194tTorN+WHL3AeE1Nt2Gou7CdPmmF4TRYil4mJBtfj2M
 B29UZYE3omtdw==
Received: from localhost.localdomain (pv50p00im-dlb-asmtp-mailmevip.me.com
 [17.56.9.10])
 by pv50p00im-tydg10021701.me.com (Postfix) with ESMTPSA id 044763A0B91;
 Wed, 23 Aug 2023 08:55:01 +0000 (UTC)
From: Mads Ynddal <mads@ynddal.dk>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Mads Ynddal <m.ynddal@samsung.com>
Subject: [PATCH v4 11/14] simpletrace: move event processing to Analyzer class
Date: Wed, 23 Aug 2023 10:54:26 +0200
Message-Id: <20230823085429.20519-12-mads@ynddal.dk>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230823085429.20519-1-mads@ynddal.dk>
References: <20230823085429.20519-1-mads@ynddal.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: guMPptZvj-eM39Vgg2ucavEE4OC-PvId
X-Proofpoint-GUID: guMPptZvj-eM39Vgg2ucavEE4OC-PvId
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.517,18.0.883,17.11.64.514.0000000_definitions?=
 =?UTF-8?Q?=3D2022-06-21=5F08:2022-06-21=5F01,2022-06-21=5F08,2022-02-23?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0
 mlxlogscore=999 clxscore=1030 bulkscore=0 adultscore=0 phishscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2308230080
Received-SPF: pass client-ip=17.58.6.54; envelope-from=mads@ynddal.dk;
 helo=pv50p00im-tydg10021701.me.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


