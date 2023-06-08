Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E92C72804A
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 14:43:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7Ext-0002pu-O5; Thu, 08 Jun 2023 08:42:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1q7Exs-0002of-5X
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 08:42:08 -0400
Received: from pv50p00im-zteg10011501.me.com ([17.58.6.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1q7Exq-0000A8-8V
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 08:42:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 t=1686228125; bh=P9WjvnEfg+gRxF9hXm33GvQAhcZGvYrETbTjf9cgSgk=;
 h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
 b=f76o2qXZ3oErEw6cclkmBdv3isYZ9eODoWRiruaC8tdfYRAcPicVAjZEhBvQyPrDP
 iHUdKDW2dlb5Z9sjpXhI641RtqKK9CHku9vjvRiE2A8SDnphAHmigODOeMZxr8tycT
 rExucFV3bbGZxGkzn3clNYbhcPI8+whaXHOCuTMGHqSZR3LvYXtjLPaRN7cHKBCN8t
 D2xw0D86tL73nVHbYxWuhCMxnjY309hk8ljasoz6EVLdDJWb9GXiRfa9E9owZF4Iph
 z7HqbqnveGfdDShz+5+d5IEprhWm37E1v8Yi8WvWiAD/l9oEIGAWRUnAYge+PoIsKJ
 YwD+zFFqR0Eng==
Received: from localhost.localdomain (pv50p00im-dlb-asmtp-mailmevip.me.com
 [17.56.9.10])
 by pv50p00im-zteg10011501.me.com (Postfix) with ESMTPSA id 21FB84A03A3;
 Thu,  8 Jun 2023 12:42:02 +0000 (UTC)
From: Mads Ynddal <mads@ynddal.dk>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Cleber Rosa <crosa@redhat.com>,
 Mads Ynddal <m.ynddal@samsung.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 04/14] simpletrace: changed naming of edict and idtoname to
 improve readability
Date: Thu,  8 Jun 2023 14:41:37 +0200
Message-Id: <20230608124147.51125-5-mads@ynddal.dk>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230608124147.51125-1-mads@ynddal.dk>
References: <20230608124147.51125-1-mads@ynddal.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: kNvxn5E00cVhDyQPR1UScSoDIuCvIl25
X-Proofpoint-ORIG-GUID: kNvxn5E00cVhDyQPR1UScSoDIuCvIl25
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.517,18.0.572,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2022-06-21=5F01:2022-06-21=5F01,2020-02-14=5F11,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0
 mlxlogscore=775 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
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

Readability is subjective, but I've expanded the naming of the variables
and arguments, to help with understanding for new eyes on the code.

Signed-off-by: Mads Ynddal <m.ynddal@samsung.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
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
2.38.1


