Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C154C728053
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 14:44:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7EyM-00030U-Ab; Thu, 08 Jun 2023 08:42:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1q7EyF-0002zy-Ly
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 08:42:32 -0400
Received: from pv50p00im-zteg10011501.me.com ([17.58.6.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1q7EyD-0000GW-Aw
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 08:42:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 t=1686228146; bh=wpTpceLrJtf6IBDpt8rJaGu6r/WeIZFdIbhp4O7zWr0=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=Vz9OT7yj8BeSt1hvPwZyjiR9wn7ISHFhDwpWBtAy7WqD+oUONjKI+3q8q3mPE7hJY
 +fpyTM4IU1sUyAA9mAI/nUUepVoV8G9OW85PACswkBWukJymCJk9Gc1lt8I5uYXEeM
 kkNQSr2BPYlotvdSWKGM8Jxr0u8DHCvRwrmEvyu4pcUJlBAi77lilQ/fmII+/iQkMq
 Ja4wCdTezFn5vVp3N48C8Nu2SN+qz3dhFh4RrSTE71MeB3lR7UlOy+xUSG8hc4NflU
 tfYbwX9iGl++UNBDMpmYc2HGhQVNZH+iqyvVc1iqOZ6a4jNXgJxagEYIgQyzS4QcZS
 dKX0+6QwixBZw==
Received: from localhost.localdomain (pv50p00im-dlb-asmtp-mailmevip.me.com
 [17.56.9.10])
 by pv50p00im-zteg10011501.me.com (Postfix) with ESMTPSA id 6AC484A026A;
 Thu,  8 Jun 2023 12:42:24 +0000 (UTC)
From: Mads Ynddal <mads@ynddal.dk>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Cleber Rosa <crosa@redhat.com>,
 Mads Ynddal <m.ynddal@samsung.com>
Subject: [PATCH v3 12/14] simpletrace: added simplified Analyzer2 class
Date: Thu,  8 Jun 2023 14:41:45 +0200
Message-Id: <20230608124147.51125-13-mads@ynddal.dk>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230608124147.51125-1-mads@ynddal.dk>
References: <20230608124147.51125-1-mads@ynddal.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: aKzLeLHbexzM7lNJiJt8HzffvYndG5-o
X-Proofpoint-ORIG-GUID: aKzLeLHbexzM7lNJiJt8HzffvYndG5-o
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

By moving the dynamic argument construction to keyword-arguments,
we can remove all of the specialized handling, and streamline it.
If a tracing method wants to access these, they can define the
kwargs, or ignore it be placing `**kwargs` at the end of the
function's arguments list.

Added deprecation warning to Analyzer class to make users aware
of the Analyzer2 class. No removal date is planned.

Signed-off-by: Mads Ynddal <m.ynddal@samsung.com>
---
 scripts/simpletrace.py | 72 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/scripts/simpletrace.py b/scripts/simpletrace.py
index 4136d00600..ca982c9b54 100755
--- a/scripts/simpletrace.py
+++ b/scripts/simpletrace.py
@@ -12,6 +12,7 @@
 import sys
 import struct
 import inspect
+import warnings
 from tracetool import read_events, Event
 from tracetool.backend.simple import is_string
 
@@ -188,6 +189,11 @@ def _build_fn(self, event):
             return lambda _, rec: fn(*rec[3:3 + event_argcount])
 
     def _process_event(self, rec_args, *, event, event_id, timestamp_ns, pid, **kwargs):
+        warnings.warn(
+            "Use of deprecated Analyzer class. Refer to Analyzer2 instead.",
+            DeprecationWarning,
+        )
+
         if not hasattr(self, '_fn_cache'):
             # NOTE: Cannot depend on downstream subclasses to have
             # super().__init__() because of legacy.
@@ -211,6 +217,56 @@ def __exit__(self, exc_type, exc_val, exc_tb):
             self.end()
         return False
 
+class Analyzer2(Analyzer):
+    """A trace file analyzer which processes trace records.
+
+    An analyzer can be passed to run() or process().  The begin() method is
+    invoked, then each trace record is processed, and finally the end() method
+    is invoked. When Analyzer is used as a context-manager (using the `with`
+    statement), begin() and end() are called automatically.
+
+    If a method matching a trace event name exists, it is invoked to process
+    that trace record.  Otherwise the catchall() method is invoked.
+
+    The methods are called with a set of keyword-arguments. These can be ignored
+    using `**kwargs` or defined like any keyword-argument.
+
+    The following keyword-arguments are available, but make sure to have an
+    **kwargs to allow for unmatched arguments in the future:
+        event: Event object of current trace
+        event_id: The id of the event in the current trace file
+        timestamp_ns: The timestamp in nanoseconds of the trace
+        pid: The process id recorded for the given trace
+
+    Example:
+    The following method handles the runstate_set(int new_state) trace event::
+
+      def runstate_set(self, new_state, **kwargs):
+          ...
+
+    The method can also explicitly take a timestamp keyword-argument with the
+    trace event arguments::
+
+      def runstate_set(self, new_state, *, timestamp_ns, **kwargs):
+          ...
+
+    Timestamps have the uint64_t type and are in nanoseconds.
+
+    The pid can be included in addition to the timestamp and is useful when
+    dealing with traces from multiple processes:
+
+      def runstate_set(self, new_state, *, timestamp_ns, pid, **kwargs):
+          ...
+    """
+
+    def catchall(self, *rec_args, event, timestamp_ns, pid, event_id, **kwargs):
+        """Called if no specific method for processing a trace event has been found."""
+        pass
+
+    def _process_event(self, rec_args, *, event, **kwargs):
+        fn = getattr(self, event.name, self.catchall)
+        fn(*rec_args, event=event, **kwargs)
+
 def process(events, log, analyzer, read_header=True):
     """Invoke an analyzer on each event in a log.
     Args:
@@ -300,6 +356,22 @@ def catchall(self, event, rec):
                 i += 1
             print(' '.join(fields))
 
+    class Formatter2(Analyzer2):
+        def __init__(self):
+            self.last_timestamp_ns = None
+
+        def catchall(self, *rec_args, event, timestamp_ns, pid, event_id):
+            if self.last_timestamp_ns is None:
+                self.last_timestamp_ns = timestamp_ns
+            delta_ns = timestamp_ns - self.last_timestamp_ns
+            self.last_timestamp_ns = timestamp_ns
+
+            fields = [
+                f'{name}={r}' if is_string(type) else f'{name}=0x{r:x}'
+                for r, (type, name) in zip(rec_args, event.args)
+            ]
+            print(f'{event.name} {delta_ns / 1000:0.3f} {pid=} ' + ' '.join(fields))
+
     try:
         run(Formatter())
     except SimpleException as e:
-- 
2.38.1


