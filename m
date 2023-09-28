Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A9B7B1EE5
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 15:47:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlrJa-0000uD-EV; Thu, 28 Sep 2023 09:44:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qlrJV-0000sI-4r
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:44:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qlrJT-0005GL-Ec
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:44:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695908658;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vm5kLZlRphXSSqt2nLmBq/ePitBZl+I2AcJc1D6gMJc=;
 b=Z8selqDyXBFvziEapkpw/mIWK+hjDoFUW0QUSyWdCWtig9RQ0IDEcjM+wQZ4HyQCbLs5kT
 +zBNggrBk6ovEZEX3d9Sv8s7X69ifROJhbQqrhsZL2dVKt6XZqGfTfRhvasKSk3FqieMkO
 5AbNSSMz9SkFLiYIO0buXi9VvMH6zOI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-562-YsH-DfREN5e3G-yEWCsnGg-1; Thu, 28 Sep 2023 09:44:15 -0400
X-MC-Unique: YsH-DfREN5e3G-yEWCsnGg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 11B54280BC9E;
 Thu, 28 Sep 2023 13:44:15 +0000 (UTC)
Received: from localhost (unknown [10.39.195.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8FF90167F8;
 Thu, 28 Sep 2023 13:44:14 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Mads Ynddal <m.ynddal@samsung.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 03/14] simpletrace: improve parsing of sys.argv;
 fix files never closed.
Date: Thu, 28 Sep 2023 09:43:56 -0400
Message-ID: <20230928134407.568453-4-stefanha@redhat.com>
In-Reply-To: <20230928134407.568453-1-stefanha@redhat.com>
References: <20230928134407.568453-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The arguments extracted from `sys.argv` named and unpacked to make it
clear what the arguments are and what they're used for.

The two input files were opened, but never explicitly closed. File usage
changed to use `with` statement to take care of this. At the same time,
ownership of the file-object is moved up to `run` function. Added option
to process to support file-like objects.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Mads Ynddal <m.ynddal@samsung.com>
Message-id: 20230926103436.25700-4-mads@ynddal.dk
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 scripts/simpletrace.py | 48 +++++++++++++++++++++++++++++-------------
 1 file changed, 33 insertions(+), 15 deletions(-)

diff --git a/scripts/simpletrace.py b/scripts/simpletrace.py
index 5c230a1b74..283b5918a1 100755
--- a/scripts/simpletrace.py
+++ b/scripts/simpletrace.py
@@ -9,6 +9,7 @@
 #
 # For help see docs/devel/tracing.rst
 
+import sys
 import struct
 import inspect
 from tracetool import read_events, Event
@@ -51,7 +52,6 @@ def get_record(edict, idtoname, rechdr, fobj):
         try:
             event = edict[name]
         except KeyError as e:
-            import sys
             sys.stderr.write('%s event is logged but is not declared ' \
                              'in the trace events file, try using ' \
                              'trace-events-all instead.\n' % str(e))
@@ -172,11 +172,28 @@ def end(self):
         pass
 
 def process(events, log, analyzer, read_header=True):
-    """Invoke an analyzer on each event in a log."""
+    """Invoke an analyzer on each event in a log.
+    Args:
+        events (file-object or list or str): events list or file-like object or file path as str to read event data from
+        log (file-object or str): file-like object or file path as str to read log data from
+        analyzer (Analyzer): Instance of Analyzer to interpret the event data
+        read_header (bool, optional): Whether to read header data from the log data. Defaults to True.
+    """
+
     if isinstance(events, str):
-        events = read_events(open(events, 'r'), events)
+        with open(events, 'r') as f:
+            events_list = read_events(f, events)
+    elif isinstance(events, list):
+        # Treat as a list of events already produced by tracetool.read_events
+        events_list = events
+    else:
+        # Treat as an already opened file-object
+        events_list = read_events(events, events.name)
+
+    close_log = False
     if isinstance(log, str):
         log = open(log, 'rb')
+        close_log = True
 
     if read_header:
         read_trace_header(log)
@@ -187,12 +204,12 @@ def process(events, log, analyzer, read_header=True):
     edict = {"dropped": dropped_event}
     idtoname = {dropped_event_id: "dropped"}
 
-    for event in events:
+    for event in events_list:
         edict[event.name] = event
 
     # If there is no header assume event ID mapping matches events list
     if not read_header:
-        for event_id, event in enumerate(events):
+        for event_id, event in enumerate(events_list):
             idtoname[event_id] = event.name
 
     def build_fn(analyzer, event):
@@ -225,24 +242,25 @@ def build_fn(analyzer, event):
         fn_cache[event_num](event, rec)
     analyzer.end()
 
+    if close_log:
+        log.close()
+
 def run(analyzer):
     """Execute an analyzer on a trace file given on the command-line.
 
     This function is useful as a driver for simple analysis scripts.  More
     advanced scripts will want to call process() instead."""
-    import sys
 
-    read_header = True
-    if len(sys.argv) == 4 and sys.argv[1] == '--no-header':
-        read_header = False
-        del sys.argv[1]
-    elif len(sys.argv) != 3:
-        sys.stderr.write('usage: %s [--no-header] <trace-events> ' \
-                         '<trace-file>\n' % sys.argv[0])
+    try:
+        # NOTE: See built-in `argparse` module for a more robust cli interface
+        *no_header, trace_event_path, trace_file_path = sys.argv[1:]
+        assert no_header == [] or no_header == ['--no-header'], 'Invalid no-header argument'
+    except (AssertionError, ValueError):
+        sys.stderr.write(f'usage: {sys.argv[0]} [--no-header] <trace-events> <trace-file>\n')
         sys.exit(1)
 
-    events = read_events(open(sys.argv[1], 'r'), sys.argv[1])
-    process(events, sys.argv[2], analyzer, read_header=read_header)
+    with open(trace_event_path, 'r') as events_fobj, open(trace_file_path, 'rb') as log_fobj:
+        process(events_fobj, log_fobj, analyzer, read_header=not no_header)
 
 if __name__ == '__main__':
     class Formatter(Analyzer):
-- 
2.41.0


