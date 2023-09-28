Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C327B1ED9
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 15:45:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlrJo-00015N-H5; Thu, 28 Sep 2023 09:44:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qlrJj-0000wB-8U
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:44:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qlrJT-0005GO-Ri
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:44:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695908659;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kj2D4WbyQ2y/gYlvTvzVG7JkqeV8gImVzIWrYt4H6y0=;
 b=WSPA3sOz0YP5CDUex9PmxWlsKEoO6CGBiyRz8u/v/qyx3M2CA15iXLV+LYfQIrDce6IY1A
 QLTBKDkGOXPG9x5aUnM1p6yFlqKFKdOMtcz5IzA5GBLBjCpgBaw4PqOcq8ik6mFu1B9Isc
 iuJSqVUquVGLvuRX4PBFyBOWqp7lBuw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-607-PvgyykUNPsWP2fGMFOHnzA-1; Thu, 28 Sep 2023 09:44:17 -0400
X-MC-Unique: PvgyykUNPsWP2fGMFOHnzA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CE2D31C0512E;
 Thu, 28 Sep 2023 13:44:16 +0000 (UTC)
Received: from localhost (unknown [10.39.195.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5B5EF2156702;
 Thu, 28 Sep 2023 13:44:16 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Mads Ynddal <m.ynddal@samsung.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 04/14] simpletrace: changed naming of edict and idtoname to
 improve readability
Date: Thu, 28 Sep 2023 09:43:57 -0400
Message-ID: <20230928134407.568453-5-stefanha@redhat.com>
In-Reply-To: <20230928134407.568453-1-stefanha@redhat.com>
References: <20230928134407.568453-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Readability is subjective, but I've expanded the naming of the variables
and arguments, to help with understanding for new eyes on the code.

Signed-off-by: Mads Ynddal <m.ynddal@samsung.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20230926103436.25700-5-mads@ynddal.dk
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 scripts/simpletrace.py | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/scripts/simpletrace.py b/scripts/simpletrace.py
index 283b5918a1..09511f624d 100755
--- a/scripts/simpletrace.py
+++ b/scripts/simpletrace.py
@@ -40,17 +40,17 @@ def read_header(fobj, hfmt):
         return None
     return struct.unpack(hfmt, hdr)
 
-def get_record(edict, idtoname, rechdr, fobj):
+def get_record(event_mapping, event_id_to_name, rechdr, fobj):
     """Deserialize a trace record from a file into a tuple
        (name, timestamp, pid, arg1, ..., arg6)."""
     if rechdr is None:
         return None
     if rechdr[0] != dropped_event_id:
         event_id = rechdr[0]
-        name = idtoname[event_id]
+        name = event_id_to_name[event_id]
         rec = (name, rechdr[1], rechdr[3])
         try:
-            event = edict[name]
+            event = event_mapping[name]
         except KeyError as e:
             sys.stderr.write('%s event is logged but is not declared ' \
                              'in the trace events file, try using ' \
@@ -79,10 +79,10 @@ def get_mapping(fobj):
 
     return (event_id, name)
 
-def read_record(edict, idtoname, fobj):
+def read_record(event_mapping, event_id_to_name, fobj):
     """Deserialize a trace record from a file into a tuple (event_num, timestamp, pid, arg1, ..., arg6)."""
     rechdr = read_header(fobj, rec_header_fmt)
-    return get_record(edict, idtoname, rechdr, fobj)
+    return get_record(event_mapping, event_id_to_name, rechdr, fobj)
 
 def read_trace_header(fobj):
     """Read and verify trace file header"""
@@ -103,14 +103,14 @@ def read_trace_header(fobj):
         raise ValueError('Log format %d not supported with this QEMU release!'
                          % log_version)
 
-def read_trace_records(edict, idtoname, fobj):
+def read_trace_records(event_mapping, event_id_to_name, fobj):
     """Deserialize trace records from a file, yielding record tuples (event_num, timestamp, pid, arg1, ..., arg6).
 
-    Note that `idtoname` is modified if the file contains mapping records.
+    Note that `event_id_to_name` is modified if the file contains mapping records.
 
     Args:
-        edict (str -> Event): events dict, indexed by name
-        idtoname (int -> str): event names dict, indexed by event ID
+        event_mapping (str -> Event): events dict, indexed by name
+        event_id_to_name (int -> str): event names dict, indexed by event ID
         fobj (file): input file
 
     """
@@ -122,9 +122,9 @@ def read_trace_records(edict, idtoname, fobj):
         (rectype, ) = struct.unpack('=Q', t)
         if rectype == record_type_mapping:
             event_id, name = get_mapping(fobj)
-            idtoname[event_id] = name
+            event_id_to_name[event_id] = name
         else:
-            rec = read_record(edict, idtoname, fobj)
+            rec = read_record(event_mapping, event_id_to_name, fobj)
 
             yield rec
 
@@ -201,16 +201,16 @@ def process(events, log, analyzer, read_header=True):
     frameinfo = inspect.getframeinfo(inspect.currentframe())
     dropped_event = Event.build("Dropped_Event(uint64_t num_events_dropped)",
                                 frameinfo.lineno + 1, frameinfo.filename)
-    edict = {"dropped": dropped_event}
-    idtoname = {dropped_event_id: "dropped"}
+    event_mapping = {"dropped": dropped_event}
+    event_id_to_name = {dropped_event_id: "dropped"}
 
     for event in events_list:
-        edict[event.name] = event
+        event_mapping[event.name] = event
 
     # If there is no header assume event ID mapping matches events list
     if not read_header:
         for event_id, event in enumerate(events_list):
-            idtoname[event_id] = event.name
+            event_id_to_name[event_id] = event.name
 
     def build_fn(analyzer, event):
         if isinstance(event, str):
@@ -234,9 +234,9 @@ def build_fn(analyzer, event):
 
     analyzer.begin()
     fn_cache = {}
-    for rec in read_trace_records(edict, idtoname, log):
+    for rec in read_trace_records(event_mapping, event_id_to_name, log):
         event_num = rec[0]
-        event = edict[event_num]
+        event = event_mapping[event_num]
         if event_num not in fn_cache:
             fn_cache[event_num] = build_fn(analyzer, event)
         fn_cache[event_num](event, rec)
-- 
2.41.0


