Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BC778532A
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 10:55:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYjdr-0004Mg-TS; Wed, 23 Aug 2023 04:55:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1qYjdp-0004DD-5N
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 04:55:05 -0400
Received: from pv50p00im-tydg10021701.me.com ([17.58.6.54])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1qYjdn-0008Jl-1q
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 04:55:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 t=1692780901; bh=WJybbYg8Al1st0uItsQ36eA7qhiUWArDe/Aix+sMO1c=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=b1fljrCLJHkoFTFmY/fVYnIblyXoIz7pjgw4XBg14OlBxcAOWrrGZtg9Jgf7/uYOe
 vksk0RcrLrfDUY4+yc8POsctOkaTkJNPmgz4q7oIPpmO+e8lf8G/CLu8aIvqKYz3vC
 D+7F7YwBWcwYhAVp5qOLvumn2muEOs+01sRCYfbj7wWIw317p8FvhqO/wm6idq6lYf
 lzyqFg1NC683OmzBZfXkk9L4Gko62+dk9n6FWvUxYxqZQejoqLPb/ZrkUqNuYxXl8w
 4U8CgqwFgErMDF0F3HFiJbip+ymTvnmpF2oKHCCzAKloL9eXZjRUQwM/FFD6JZDuD5
 PhIJEbMcg/mbw==
Received: from localhost.localdomain (pv50p00im-dlb-asmtp-mailmevip.me.com
 [17.56.9.10])
 by pv50p00im-tydg10021701.me.com (Postfix) with ESMTPSA id 82E053A0B73;
 Wed, 23 Aug 2023 08:54:59 +0000 (UTC)
From: Mads Ynddal <mads@ynddal.dk>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Mads Ynddal <m.ynddal@samsung.com>
Subject: [PATCH v4 10/14] simpletrace: move logic of process into internal
 function
Date: Wed, 23 Aug 2023 10:54:25 +0200
Message-Id: <20230823085429.20519-11-mads@ynddal.dk>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230823085429.20519-1-mads@ynddal.dk>
References: <20230823085429.20519-1-mads@ynddal.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: YAo8A56RG4VI0VC7Qbue8xSWRzeTGqFo
X-Proofpoint-GUID: YAo8A56RG4VI0VC7Qbue8xSWRzeTGqFo
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.517,18.0.883,17.11.64.514.0000000_definitions?=
 =?UTF-8?Q?=3D2022-06-21=5F08:2022-06-21=5F01,2022-06-21=5F08,2022-02-23?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0
 mlxlogscore=791 clxscore=1030 bulkscore=0 adultscore=0 phishscore=0
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

To avoid duplicate code depending on input types and to better handle
open/close of log with a context-manager, we move the logic of process into
_process.

Signed-off-by: Mads Ynddal <m.ynddal@samsung.com>
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
2.38.1


