Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1007AEA74
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 12:35:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql5PW-00049p-1K; Tue, 26 Sep 2023 06:35:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1ql5PR-0003up-M1
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 06:35:18 -0400
Received: from mr85p00im-zteg06021501.me.com ([17.58.23.183])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1ql5PP-0001Nu-MD
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 06:35:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 t=1695724504; bh=DnKjALWbipcz/A/jhfp4bzOPKLhDEKwFH9WXhiPht4w=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=RQl0NuOxkM4cVHPaheILZrMge3td50qnwYB3zJPJajBp+GmL3LWLX9MLuj+2AdlDy
 X+qPAzeM56RLbsfY9brXTozi9CquIYD0n9BNwO2+/exbh26v4jsjojALAisL+1FdBj
 F9LiUOtVyefnRYgqJljf96xIsJSLGgyA43nGijzgi4gvn8Gh4PvcRo8XewTIn3U1wT
 bQ4iRe8x94ahH+icQebLescDg9qAC2SlsAAxORZpyVU4qJ51bn30EHWao/VrpvMtFZ
 IU1VbVxWG/n7eQbPAC2n9mzeakiw4GtbaevnROVqPnwWBVoczIg9vrUsmyRIq07Ewx
 nve0IiqK5jY6A==
Received: from localhost.localdomain (mr38p00im-dlb-asmtp-mailmevip.me.com
 [17.57.152.18])
 by mr85p00im-zteg06021501.me.com (Postfix) with ESMTPSA id 977A62793EE4;
 Tue, 26 Sep 2023 10:35:02 +0000 (UTC)
From: Mads Ynddal <mads@ynddal.dk>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Cleber Rosa <crosa@redhat.com>,
 Mads Ynddal <m.ynddal@samsung.com>
Subject: [PATCH v5 12/14] simpletrace: added simplified Analyzer2 class
Date: Tue, 26 Sep 2023 12:34:34 +0200
Message-Id: <20230926103436.25700-13-mads@ynddal.dk>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230926103436.25700-1-mads@ynddal.dk>
References: <20230926103436.25700-1-mads@ynddal.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 164nT5YhwYAQYEbQSOj9IVxw1emHv8Ei
X-Proofpoint-GUID: 164nT5YhwYAQYEbQSOj9IVxw1emHv8Ei
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.816,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-18=5F01:2022-01-14=5F01,2022-01-18=5F01,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 spamscore=0 bulkscore=0
 clxscore=1030 adultscore=0 mlxlogscore=999 phishscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309260091
Received-SPF: pass client-ip=17.58.23.183; envelope-from=mads@ynddal.dk;
 helo=mr85p00im-zteg06021501.me.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 scripts/simpletrace.py | 98 ++++++++++++++++++++++++++++++++----------
 1 file changed, 75 insertions(+), 23 deletions(-)

diff --git a/scripts/simpletrace.py b/scripts/simpletrace.py
index 4136d00600..cef81b0707 100755
--- a/scripts/simpletrace.py
+++ b/scripts/simpletrace.py
@@ -12,10 +12,11 @@
 import sys
 import struct
 import inspect
+import warnings
 from tracetool import read_events, Event
 from tracetool.backend.simple import is_string
 
-__all__ = ['Analyzer', 'process', 'run']
+__all__ = ['Analyzer', 'Analyzer2', 'process', 'run']
 
 # This is the binary format that the QEMU "simple" trace backend
 # emits. There is no specification documentation because the format is
@@ -130,7 +131,9 @@ def read_trace_records(events, fobj, read_header):
             yield (event_mapping[event_name], event_name, timestamp_ns, pid) + tuple(args)
 
 class Analyzer:
-    """A trace file analyzer which processes trace records.
+    """[Deprecated. Refer to Analyzer2 instead.]
+
+    A trace file analyzer which processes trace records.
 
     An analyzer can be passed to run() or process().  The begin() method is
     invoked, then each trace record is processed, and finally the end() method
@@ -188,6 +191,11 @@ def _build_fn(self, event):
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
@@ -211,6 +219,56 @@ def __exit__(self, exc_type, exc_val, exc_tb):
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
@@ -278,30 +336,24 @@ def run(analyzer):
         process(events_fobj, log_fobj, analyzer, read_header=not no_header)
 
 if __name__ == '__main__':
-    class Formatter(Analyzer):
+    class Formatter2(Analyzer2):
         def __init__(self):
-            self.last_timestamp = None
-
-        def catchall(self, event, rec):
-            timestamp = rec[1]
-            if self.last_timestamp is None:
-                self.last_timestamp = timestamp
-            delta_ns = timestamp - self.last_timestamp
-            self.last_timestamp = timestamp
-
-            fields = [event.name, '%0.3f' % (delta_ns / 1000.0),
-                      'pid=%d' % rec[2]]
-            i = 3
-            for type, name in event.args:
-                if is_string(type):
-                    fields.append('%s=%s' % (name, rec[i]))
-                else:
-                    fields.append('%s=0x%x' % (name, rec[i]))
-                i += 1
-            print(' '.join(fields))
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
 
     try:
-        run(Formatter())
+        run(Formatter2())
     except SimpleException as e:
         sys.stderr.write(str(e) + "\n")
         sys.exit(1)
-- 
2.38.1


