Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D89EF7B1EDB
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 15:45:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlrJq-00016S-D4; Thu, 28 Sep 2023 09:44:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qlrJn-000154-PX
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:44:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qlrJi-0005Jj-1b
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:44:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695908673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OpTmq6yG7OMEAB3IGMTVF1Y8c3kIz/JqAYZLwbYMckI=;
 b=TzcDu8shqA1goCC5RY13VFbcj8X+l9UGI4ZSzdEwMkZ6A55xhy+5RvkPi96cUp2hxlSP88
 gJbrs/y2DrS8/PohrVR8Ne0BhkPdaoadCBCHOQ2u8nqPQOYmPZz1KgJ4GHiUlNIvKmPD1o
 SM0vH6gNyOdCUy8+iwtC4MjPUr6OTQ4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-532-qYP5yZaDP_Gad6THlYcrow-1; Thu, 28 Sep 2023 09:44:32 -0400
X-MC-Unique: qYP5yZaDP_Gad6THlYcrow-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B8E073C40C06;
 Thu, 28 Sep 2023 13:44:31 +0000 (UTC)
Received: from localhost (unknown [10.39.195.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 43C4240C6E76;
 Thu, 28 Sep 2023 13:44:31 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Mads Ynddal <m.ynddal@samsung.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 12/14] simpletrace: added simplified Analyzer2 class
Date: Thu, 28 Sep 2023 09:44:05 -0400
Message-ID: <20230928134407.568453-13-stefanha@redhat.com>
In-Reply-To: <20230928134407.568453-1-stefanha@redhat.com>
References: <20230928134407.568453-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Message-id: 20230926103436.25700-13-mads@ynddal.dk
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 scripts/simpletrace.py | 94 ++++++++++++++++++++++++++++++++----------
 1 file changed, 73 insertions(+), 21 deletions(-)

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
+            self.last_timestamp_ns = None
 
-        def catchall(self, event, rec):
-            timestamp = rec[1]
-            if self.last_timestamp is None:
-                self.last_timestamp = timestamp
-            delta_ns = timestamp - self.last_timestamp
-            self.last_timestamp = timestamp
+        def catchall(self, *rec_args, event, timestamp_ns, pid, event_id):
+            if self.last_timestamp_ns is None:
+                self.last_timestamp_ns = timestamp_ns
+            delta_ns = timestamp_ns - self.last_timestamp_ns
+            self.last_timestamp_ns = timestamp_ns
 
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
2.41.0


