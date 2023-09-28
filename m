Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 580E17B1EE8
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 15:47:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlrJn-00014r-Ps; Thu, 28 Sep 2023 09:44:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qlrJk-0000yw-J0
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:44:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qlrJi-0005Jr-Pr
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:44:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695908673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7cUQJhMGVzKyq+FWndXTE7qzur1fzrM77GUDAxWgGCU=;
 b=hU3CAzrsMD0pi+5QVe2Y/dryrqSWLN2/bvXi/ZrlJ0wr/uBG/7+ylWCzIbuz/7vQ7PJQAJ
 bEu0M5tBPV5QqvUPIykI8lqaFxffYKI6OVJntHckwB7/yunoqDlf+Dp+g55TSd5v/sOg0V
 6NjdDZAKywm12E2mZwW4DPiboHFVfH4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-395-Ffqk8ggWMJe6KWoBvGeasw-1; Thu, 28 Sep 2023 09:44:30 -0400
X-MC-Unique: Ffqk8ggWMJe6KWoBvGeasw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BD9A3811E7B;
 Thu, 28 Sep 2023 13:44:29 +0000 (UTC)
Received: from localhost (unknown [10.39.195.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4EAB5167F8;
 Thu, 28 Sep 2023 13:44:29 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Mads Ynddal <m.ynddal@samsung.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 11/14] simpletrace: move event processing to Analyzer class
Date: Thu, 28 Sep 2023 09:44:04 -0400
Message-ID: <20230928134407.568453-12-stefanha@redhat.com>
In-Reply-To: <20230928134407.568453-1-stefanha@redhat.com>
References: <20230928134407.568453-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Moved event processing to the Analyzer class to separate specific analyzer
logic (like caching and function signatures) from the _process function.
This allows for new types of Analyzer-based subclasses without changing
the core code.

Note, that the fn_cache is important for performance in cases where the
analyzer is branching away from the catch-all a lot. The cache has no
measurable performance penalty.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Mads Ynddal <m.ynddal@samsung.com>
Message-id: 20230926103436.25700-12-mads@ynddal.dk
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
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
2.41.0


