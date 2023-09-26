Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FAC67AEA80
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 12:36:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql5P1-0003Lj-K8; Tue, 26 Sep 2023 06:34:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1ql5Oz-0003Ku-7K
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 06:34:49 -0400
Received: from mr85p00im-zteg06021501.me.com ([17.58.23.183])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1ql5Ox-00018s-GW
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 06:34:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 t=1695724486; bh=6uATgJUVIjGmWTu33IvdbmCf9GucgSEjOkNSC9vkNHM=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=L3G3zAXpgU7PM22U/Qaji3xBS98MsPHH8j0MWigRR99+yjT5428DclzzWa2Yr7UQu
 TylutRxl1x3GND/B9fdpY51ilOoKWbOLmOtaWn74z8bKvHq/zf/5QpyXIHC0HafDj4
 rFKa9PGNmqhQVrCjOKAv2lk9amxNq8i/FlljXHja89MhiIKeTvxb5+qtZIRdXnPIj0
 GpILLCPsBno3QhXwxPobu/CbxpTZF9/EzO11S+aaSsUaSjy1S4/TUEk0V9jNU1Wojl
 tiio9GOcCYnMeN06A1EIwiUIOt1BI3MgmtPMlHT6qFh+VtAZn0+Iilvpj74WBNCD+n
 7u6UszLdhs5nw==
Received: from localhost.localdomain (mr38p00im-dlb-asmtp-mailmevip.me.com
 [17.57.152.18])
 by mr85p00im-zteg06021501.me.com (Postfix) with ESMTPSA id 201C02793EB0;
 Tue, 26 Sep 2023 10:34:44 +0000 (UTC)
From: Mads Ynddal <mads@ynddal.dk>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Cleber Rosa <crosa@redhat.com>,
 Mads Ynddal <m.ynddal@samsung.com>
Subject: [PATCH v5 03/14] simpletrace: improve parsing of sys.argv;
 fix files never closed.
Date: Tue, 26 Sep 2023 12:34:25 +0200
Message-Id: <20230926103436.25700-4-mads@ynddal.dk>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230926103436.25700-1-mads@ynddal.dk>
References: <20230926103436.25700-1-mads@ynddal.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 8h4ajl2favycgfo6dr5NUTQR6rq-kY7S
X-Proofpoint-GUID: 8h4ajl2favycgfo6dr5NUTQR6rq-kY7S
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.816,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-18=5F01:2022-01-14=5F01,2022-01-18=5F01,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 spamscore=0 bulkscore=0
 clxscore=1030 adultscore=0 mlxlogscore=855 phishscore=0 mlxscore=0
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

The arguments extracted from `sys.argv` named and unpacked to make it
clear what the arguments are and what they're used for.

The two input files were opened, but never explicitly closed. File usage
changed to use `with` statement to take care of this. At the same time,
ownership of the file-object is moved up to `run` function. Added option
to process to support file-like objects.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Mads Ynddal <m.ynddal@samsung.com>
---
 scripts/simpletrace.py | 50 ++++++++++++++++++++++++++++--------------
 1 file changed, 34 insertions(+), 16 deletions(-)

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
-
-    read_header = True
-    if len(sys.argv) == 4 and sys.argv[1] == '--no-header':
-        read_header = False
-        del sys.argv[1]
-    elif len(sys.argv) != 3:
-        sys.stderr.write('usage: %s [--no-header] <trace-events> ' \
-                         '<trace-file>\n' % sys.argv[0])
+
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
2.38.1


