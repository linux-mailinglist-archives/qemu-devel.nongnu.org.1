Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0C1728045
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 14:43:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7EyF-0002z3-3l; Thu, 08 Jun 2023 08:42:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1q7Ey8-0002yC-2m
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 08:42:24 -0400
Received: from pv50p00im-zteg10011501.me.com ([17.58.6.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1q7Ey4-0000EK-5F
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 08:42:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 t=1686228138; bh=SvjOE1wSVteO9a7jCIZM0X0ZH3YH3HxN3uWZIwehWM8=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=iZphT6ie4ZWyPEqjC60xxm5DSP733sk127w/2y3VTZY/0ser28N+ow9XAfFmnuA3Z
 +dPbDcLTL9RKXG47obnX4SRMeoC7iMRkl37TeKXfIG1funR16QtHhoGksNkbP+AZJq
 oWWcQeMLXuyRyAjEDt6wTh4aS5krY+EzqaNb0t98r92bjAWSoXyWV0i9AE2CUEJnTf
 HMIEyUqRehCAqM5u2eIHKj1YgwvC1P1lPjlqm4mzmAbqVzM6VlOqlM32qfI9zSXK0J
 Nl27IVQax0QYtMEUje63orHXn7NihqUNjX53ajbYUmUSnDBdHzif79a1VwEDWlcny/
 tawwyGeUhtwtQ==
Received: from localhost.localdomain (pv50p00im-dlb-asmtp-mailmevip.me.com
 [17.56.9.10])
 by pv50p00im-zteg10011501.me.com (Postfix) with ESMTPSA id 6DEAE4A02FD;
 Thu,  8 Jun 2023 12:42:16 +0000 (UTC)
From: Mads Ynddal <mads@ynddal.dk>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Cleber Rosa <crosa@redhat.com>,
 Mads Ynddal <m.ynddal@samsung.com>
Subject: [PATCH v3 09/14] simpletrace: refactor to separate responsibilities
Date: Thu,  8 Jun 2023 14:41:42 +0200
Message-Id: <20230608124147.51125-10-mads@ynddal.dk>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230608124147.51125-1-mads@ynddal.dk>
References: <20230608124147.51125-1-mads@ynddal.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: UmuzdBAQ-IAkh_clD7BQ-CZNAbBXu6ke
X-Proofpoint-ORIG-GUID: UmuzdBAQ-IAkh_clD7BQ-CZNAbBXu6ke
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

Moved event_mapping and event_id_to_name down one level in the function
call-stack to keep variable instantiation and usage closer (`process`
and `run` has no use of the variables; `read_trace_records` does).

Instead of passing event_mapping and event_id_to_name to the bottom of
the call-stack, we move their use to `read_trace_records`. This
separates responsibility and ownership of the information.

`read_record` now just reads the arguments from the file-object by
knowning the total number of bytes. Parsing it to specific arguments is
moved up to `read_trace_records`.

Special handling of dropped events removed, as they can be handled
by the general code.

Signed-off-by: Mads Ynddal <m.ynddal@samsung.com>
---
 scripts/simpletrace.py | 115 +++++++++++++++++++----------------------
 1 file changed, 53 insertions(+), 62 deletions(-)

diff --git a/scripts/simpletrace.py b/scripts/simpletrace.py
index 7f514d1577..0826aef283 100755
--- a/scripts/simpletrace.py
+++ b/scripts/simpletrace.py
@@ -31,6 +31,7 @@
 
 log_header_fmt = '=QQQ'
 rec_header_fmt = '=QQII'
+rec_header_fmt_len = struct.calcsize(rec_header_fmt)
 
 class SimpleException(Exception):
     pass
@@ -43,35 +44,6 @@ def read_header(fobj, hfmt):
         raise SimpleException('Error reading header. Wrong filetype provided?')
     return struct.unpack(hfmt, hdr)
 
-def get_record(event_mapping, event_id_to_name, rechdr, fobj):
-    """Deserialize a trace record from a file into a tuple
-       (name, timestamp, pid, arg1, ..., arg6)."""
-    event_id, timestamp_ns, length, pid = rechdr
-    if event_id != dropped_event_id:
-        name = event_id_to_name[event_id]
-        try:
-            event = event_mapping[name]
-        except KeyError as e:
-            raise SimpleException(
-                f'{e} event is logged but is not declared in the trace events'
-                'file, try using trace-events-all instead.'
-            )
-
-        rec = (name, timestamp_ns, pid)
-        for type, name in event.args:
-            if is_string(type):
-                l = fobj.read(4)
-                (len,) = struct.unpack('=L', l)
-                s = fobj.read(len)
-                rec = rec + (s,)
-            else:
-                (value,) = struct.unpack('=Q', fobj.read(8))
-                rec = rec + (value,)
-    else:
-        (dropped_count,) = struct.unpack('=Q', fobj.read(8))
-        rec = ("dropped", timestamp_ns, pid, dropped_count)
-    return rec
-
 def get_mapping(fobj):
     (event_id, ) = struct.unpack('=Q', fobj.read(8))
     (len, ) = struct.unpack('=L', fobj.read(4))
@@ -79,10 +51,11 @@ def get_mapping(fobj):
 
     return (event_id, name)
 
-def read_record(event_mapping, event_id_to_name, fobj):
-    """Deserialize a trace record from a file into a tuple (event_num, timestamp, pid, arg1, ..., arg6)."""
-    rechdr = read_header(fobj, rec_header_fmt)
-    return get_record(event_mapping, event_id_to_name, rechdr, fobj)
+def read_record(fobj):
+    """Deserialize a trace record from a file into a tuple (event_num, timestamp, pid, args)."""
+    event_id, timestamp_ns, record_length, record_pid = read_header(fobj, rec_header_fmt)
+    args_payload = fobj.read(record_length - rec_header_fmt_len)
+    return (event_id, timestamp_ns, record_pid, args_payload)
 
 def read_trace_header(fobj):
     """Read and verify trace file header"""
@@ -97,17 +70,28 @@ def read_trace_header(fobj):
     if log_version != 4:
         raise ValueError(f'Log format {log_version} not supported with this QEMU release!')
 
-def read_trace_records(event_mapping, event_id_to_name, fobj):
-    """Deserialize trace records from a file, yielding record tuples (event_num, timestamp, pid, arg1, ..., arg6).
-
-    Note that `event_id_to_name` is modified if the file contains mapping records.
+def read_trace_records(events, fobj, read_header):
+    """Deserialize trace records from a file, yielding record tuples (event, event_num, timestamp, pid, arg1, ..., arg6).
 
     Args:
         event_mapping (str -> Event): events dict, indexed by name
-        event_id_to_name (int -> str): event names dict, indexed by event ID
         fobj (file): input file
+        read_header (bool): whether headers were read from fobj
 
     """
+    frameinfo = inspect.getframeinfo(inspect.currentframe())
+    dropped_event = Event.build("Dropped_Event(uint64_t num_events_dropped)",
+                                frameinfo.lineno + 1, frameinfo.filename)
+
+    event_mapping = {e.name: e for e in events}
+    event_mapping["dropped"] = dropped_event
+    event_id_to_name = {dropped_event_id: "dropped"}
+
+    # If there is no header assume event ID mapping matches events list
+    if not read_header:
+        for event_id, event in enumerate(events):
+            event_id_to_name[event_id] = event.name
+
     while True:
         t = fobj.read(8)
         if len(t) == 0:
@@ -115,12 +99,35 @@ def read_trace_records(event_mapping, event_id_to_name, fobj):
 
         (rectype, ) = struct.unpack('=Q', t)
         if rectype == record_type_mapping:
-            event_id, name = get_mapping(fobj)
-            event_id_to_name[event_id] = name
+            event_id, event_name = get_mapping(fobj)
+            event_id_to_name[event_id] = event_name
         else:
-            rec = read_record(event_mapping, event_id_to_name, fobj)
+            event_id, timestamp_ns, pid, args_payload = read_record(fobj)
+            event_name = event_id_to_name[event_id]
+
+            try:
+                event = event_mapping[event_name]
+            except KeyError as e:
+                raise SimpleException(
+                    f'{e} event is logged but is not declared in the trace events'
+                    'file, try using trace-events-all instead.'
+                )
+
+            offset = 0
+            args = []
+            for type, _ in event.args:
+                if is_string(type):
+                    (length,) = struct.unpack_from('=L', args_payload, offset=offset)
+                    offset += 4
+                    s = args_payload[offset:offset+length]
+                    offset += length
+                    args.append(s)
+                else:
+                    (value,) = struct.unpack_from('=Q', args_payload, offset=offset)
+                    offset += 8
+                    args.append(value)
 
-            yield rec
+            yield (event_mapping[event_name], event_name, timestamp_ns, pid) + tuple(args)
 
 class Analyzer:
     """A trace file analyzer which processes trace records.
@@ -202,20 +209,6 @@ def process(events, log, analyzer, read_header=True):
     if read_header:
         read_trace_header(log)
 
-    frameinfo = inspect.getframeinfo(inspect.currentframe())
-    dropped_event = Event.build("Dropped_Event(uint64_t num_events_dropped)",
-                                frameinfo.lineno + 1, frameinfo.filename)
-    event_mapping = {"dropped": dropped_event}
-    event_id_to_name = {dropped_event_id: "dropped"}
-
-    for event in events_list:
-        event_mapping[event.name] = event
-
-    # If there is no header assume event ID mapping matches events list
-    if not read_header:
-        for event_id, event in enumerate(events_list):
-            event_id_to_name[event_id] = event.name
-
     def build_fn(analyzer, event):
         if isinstance(event, str):
             return analyzer.catchall
@@ -238,12 +231,10 @@ def build_fn(analyzer, event):
 
     with analyzer:
         fn_cache = {}
-        for rec in read_trace_records(event_mapping, event_id_to_name, log):
-            event_num = rec[0]
-            event = event_mapping[event_num]
-            if event_num not in fn_cache:
-                fn_cache[event_num] = build_fn(analyzer, event)
-            fn_cache[event_num](event, rec)
+        for event, event_id, timestamp_ns, record_pid, *rec_args in read_trace_records(events, log, read_header):
+            if event_id not in fn_cache:
+                fn_cache[event_id] = build_fn(analyzer, event)
+            fn_cache[event_id](event, (event_id, timestamp_ns, record_pid, *rec_args))
 
     if close_log:
         log.close()
-- 
2.38.1


