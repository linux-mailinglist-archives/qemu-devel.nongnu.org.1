Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 454A27B1EDD
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 15:46:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlrJo-000152-8L; Thu, 28 Sep 2023 09:44:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qlrJi-0000vu-04
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:44:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qlrJg-0005JR-F7
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:44:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695908671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fIubrVTLv2aIB0yoYmMLr14Qh9OpvvC4aDxWE1y6kxU=;
 b=CLH+vcMA13Wzg8ctIjH8kVvCWV9pKyC0miutGTYCbM0qjhH9nAJ7xdSFCdotk9Z1udjj3+
 BrZbQTHvV1Eryz15BC0un9jJsfpsuEjvc3wP9hMxairZ2F9J2+wfqKjRGqsMSuuhuFc01F
 XqzLxxaYFdAfSk2oy8w7+/EujOJlKW4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-288-JLM-mBlmOzOD-m8WlJzGoA-1; Thu, 28 Sep 2023 09:44:28 -0400
X-MC-Unique: JLM-mBlmOzOD-m8WlJzGoA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 053373C40C03;
 Thu, 28 Sep 2023 13:44:28 +0000 (UTC)
Received: from localhost (unknown [10.39.195.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 897CE140273D;
 Thu, 28 Sep 2023 13:44:27 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Mads Ynddal <m.ynddal@samsung.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 10/14] simpletrace: move logic of process into internal function
Date: Thu, 28 Sep 2023 09:44:03 -0400
Message-ID: <20230928134407.568453-11-stefanha@redhat.com>
In-Reply-To: <20230928134407.568453-1-stefanha@redhat.com>
References: <20230928134407.568453-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
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

To avoid duplicate code depending on input types and to better handle
open/close of log with a context-manager, we move the logic of process into
_process.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Mads Ynddal <m.ynddal@samsung.com>
Message-id: 20230926103436.25700-11-mads@ynddal.dk
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
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
2.41.0


