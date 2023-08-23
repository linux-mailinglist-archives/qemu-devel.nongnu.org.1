Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 29843785341
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 10:57:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYjeM-0005Bp-R9; Wed, 23 Aug 2023 04:55:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1qYje4-0004oG-5A
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 04:55:23 -0400
Received: from pv50p00im-tydg10021701.me.com ([17.58.6.54])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1qYje1-00006s-NQ
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 04:55:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 t=1692780906; bh=A1z+bpLi9INQ8yEVKt1RtbSbm6CFFHNePYE+j7k4KDU=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=OI2sb9NRUDJtSBZrvcnrSUv5FNqkAzeeRi1/XDBk67JaH6MRQIyB/SblsebZOCJgf
 SLT8Wh74mwKidwXEXZXb/4Bx/T7uP1/vWDcUN4UtS404sqVzcxWja2mH/h2aH/z7Gf
 Dd8ZhgzBb4Xe6hvta3GtycJ9DzFbrx+YDCn+I5czoVyDBhaHtHV5CeVKL/OVsyOHP/
 CYnMMoYApR3At8LO1vroiO0TeXPtcZl+SvPq7Nuc1dJhGwip2ryL5KHoMzCWW78TCn
 8iL1/v7IfMBuPyXPnHY7n6b90ZZ6ZFTahXgKGiATex0GEtBsowqslTwhRq8xi4c4cp
 rgM6DZKuISPmg==
Received: from localhost.localdomain (pv50p00im-dlb-asmtp-mailmevip.me.com
 [17.56.9.10])
 by pv50p00im-tydg10021701.me.com (Postfix) with ESMTPSA id 6ED973A0B5F;
 Wed, 23 Aug 2023 08:55:04 +0000 (UTC)
From: Mads Ynddal <mads@ynddal.dk>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Mads Ynddal <m.ynddal@samsung.com>
Subject: [PATCH v4 12/14] simpletrace: added simplified Analyzer2 class
Date: Wed, 23 Aug 2023 10:54:27 +0200
Message-Id: <20230823085429.20519-13-mads@ynddal.dk>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230823085429.20519-1-mads@ynddal.dk>
References: <20230823085429.20519-1-mads@ynddal.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: vqzlbXczv9uul3SwpoloWbDsp9FVGnml
X-Proofpoint-GUID: vqzlbXczv9uul3SwpoloWbDsp9FVGnml
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.517,18.0.883,17.11.64.514.0000000_definitions?=
 =?UTF-8?Q?=3D2022-06-21=5F08:2022-06-21=5F01,2022-06-21=5F08,2022-02-23?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0
 mlxlogscore=885 clxscore=1030 bulkscore=0 adultscore=0 phishscore=0
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

By moving the dynamic argument construction to keyword-arguments,
we can remove all of the specialized handling, and streamline it.
If a tracing method wants to access these, they can define the
kwargs, or ignore it be placing `**kwargs` at the end of the
function's arguments list.

Added deprecation warning to Analyzer class to make users aware
of the Analyzer2 class. No removal date is planned.

Signed-off-by: Mads Ynddal <m.ynddal@samsung.com>
---
 scripts/simpletrace-benchmark.zip | Bin 0 -> 4809 bytes
 scripts/simpletrace.py            |  78 +++++++++++++++++++++++++++++-
 2 files changed, 76 insertions(+), 2 deletions(-)
 create mode 100644 scripts/simpletrace-benchmark.zip

diff --git a/scripts/simpletrace-benchmark.zip b/scripts/simpletrace-benchmark.zip
new file mode 100644
index 0000000000000000000000000000000000000000..1d696a8d5c49d4725c938af8bf25a59090192986
GIT binary patch
literal 4809
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
DD^M;a

literal 0
HcmV?d00001

diff --git a/scripts/simpletrace.py b/scripts/simpletrace.py
index 4136d00600..fdeeed7cd6 100755
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
@@ -300,6 +358,22 @@ def catchall(self, event, rec):
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


