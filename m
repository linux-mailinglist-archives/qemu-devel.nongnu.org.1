Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9E97AEA7B
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 12:36:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql5PA-0003Tb-VT; Tue, 26 Sep 2023 06:35:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1ql5P9-0003T9-Hz
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 06:34:59 -0400
Received: from mr85p00im-zteg06021501.me.com ([17.58.23.183])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1ql5P7-0001Bm-Ut
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 06:34:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 t=1695724496; bh=y2nmdttjidRoS1xj35Eh2CiUadmbk0qliUJWvkQLMUc=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=VGD68KPTfrdhBvMOropY4oVxq6+SCGXLYt4robGcefVde17B+XxiJTd/APe6GR1ZN
 1o8yVE9kT+jUzGbFuAjpd1ptOGLnudPhuJqA7N6BpIn8ljkOy0qfn6LmjllCqjBcBm
 U1sMd+lAH3h0ZYeqV9wvYGxNG4AhmDCwWevQTGkAHWs4qquIDuJ8wrFnPnXl9XodA3
 Fyo7pJahlfIric8/3HGjAwVcFL6Zr2zcWlYjjRjfnpJNsPaey6s1t9KEFTDK/ogE04
 /RkizsDpt5JR/ZFRIXkbtxylTq56XKEuiTfpn3GvpdxokHICoqR1Mv003DCW8N//v8
 FdakavHz0ut0w==
Received: from localhost.localdomain (mr38p00im-dlb-asmtp-mailmevip.me.com
 [17.57.152.18])
 by mr85p00im-zteg06021501.me.com (Postfix) with ESMTPSA id 5EFC02793EBB;
 Tue, 26 Sep 2023 10:34:55 +0000 (UTC)
From: Mads Ynddal <mads@ynddal.dk>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Cleber Rosa <crosa@redhat.com>,
 Mads Ynddal <m.ynddal@samsung.com>
Subject: [PATCH v5 08/14] simpletrace: made Analyzer into context-manager
Date: Tue, 26 Sep 2023 12:34:30 +0200
Message-Id: <20230926103436.25700-9-mads@ynddal.dk>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230926103436.25700-1-mads@ynddal.dk>
References: <20230926103436.25700-1-mads@ynddal.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: H3SxdCE8n3o_nzcLRDG3_XoYaaWjSI-1
X-Proofpoint-GUID: H3SxdCE8n3o_nzcLRDG3_XoYaaWjSI-1
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.816,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-18=5F01:2022-01-14=5F01,2022-01-18=5F01,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 spamscore=0 bulkscore=0
 clxscore=1030 adultscore=0 mlxlogscore=910 phishscore=0 mlxscore=0
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

Instead of explicitly calling `begin` and `end`, we can change the class
to use the context-manager paradigm. This is mostly a styling choice,
used in modern Python code. But it also allows for more advanced analyzers
to handle exceptions gracefully in the `__exit__` method (not
demonstrated here).

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Mads Ynddal <m.ynddal@samsung.com>
---
 scripts/simpletrace.py | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/scripts/simpletrace.py b/scripts/simpletrace.py
index 229b10aa99..7f514d1577 100755
--- a/scripts/simpletrace.py
+++ b/scripts/simpletrace.py
@@ -122,12 +122,13 @@ def read_trace_records(event_mapping, event_id_to_name, fobj):
 
             yield rec
 
-class Analyzer(object):
+class Analyzer:
     """A trace file analyzer which processes trace records.
 
     An analyzer can be passed to run() or process().  The begin() method is
     invoked, then each trace record is processed, and finally the end() method
-    is invoked.
+    is invoked. When Analyzer is used as a context-manager (using the `with`
+    statement), begin() and end() are called automatically.
 
     If a method matching a trace event name exists, it is invoked to process
     that trace record.  Otherwise the catchall() method is invoked.
@@ -165,6 +166,15 @@ def end(self):
         """Called at the end of the trace."""
         pass
 
+    def __enter__(self):
+        self.begin()
+        return self
+
+    def __exit__(self, exc_type, exc_val, exc_tb):
+        if exc_type is None:
+            self.end()
+        return False
+
 def process(events, log, analyzer, read_header=True):
     """Invoke an analyzer on each event in a log.
     Args:
@@ -226,15 +236,14 @@ def build_fn(analyzer, event):
             # Just arguments, no timestamp or pid
             return lambda _, rec: fn(*rec[3:3 + event_argcount])
 
-    analyzer.begin()
-    fn_cache = {}
-    for rec in read_trace_records(event_mapping, event_id_to_name, log):
-        event_num = rec[0]
-        event = event_mapping[event_num]
-        if event_num not in fn_cache:
-            fn_cache[event_num] = build_fn(analyzer, event)
-        fn_cache[event_num](event, rec)
-    analyzer.end()
+    with analyzer:
+        fn_cache = {}
+        for rec in read_trace_records(event_mapping, event_id_to_name, log):
+            event_num = rec[0]
+            event = event_mapping[event_num]
+            if event_num not in fn_cache:
+                fn_cache[event_num] = build_fn(analyzer, event)
+            fn_cache[event_num](event, rec)
 
     if close_log:
         log.close()
-- 
2.38.1


