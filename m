Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B44F72804F
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 14:43:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7Exz-0002to-3o; Thu, 08 Jun 2023 08:42:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1q7Exx-0002tE-HP
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 08:42:13 -0400
Received: from pv50p00im-zteg10011501.me.com ([17.58.6.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1q7Exv-0000B3-Nc
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 08:42:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 t=1686228130; bh=tv8iQdRgnNjq6DBzxFJS9huknQBhYuHeuL8iwQFn9rw=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=BqtJMimNDIA/G28d300h0nY1fen4uENeoOwWzeBZKkt77GOZPPdlAzmxLTyQ1LpUv
 TlB7zxbIEg4yfUPVWZx/O8UcpFx5gzZzfV7/z86miS4YQZ667F2ri7Y5Q937zt4tAV
 Zh7GicAxUwhUd1FMMOI/g97WCm/5g64adzLs4I099EnCzNl1yMcTKybIJ5Sl8Gr3Xv
 R7vaub7gRFEqqFNijDzxWk/HzJIatFvwOekvemy9F2sAsT+7/Sb7jmJRpUUpf+cJrF
 K8RLsnXJX9fQKMS1WHQzUXEmrUaePU3eeMJDKwRcYQC0nYxXuJvgig8hBcvAfyeftB
 8oierhutnSYEw==
Received: from localhost.localdomain (pv50p00im-dlb-asmtp-mailmevip.me.com
 [17.56.9.10])
 by pv50p00im-zteg10011501.me.com (Postfix) with ESMTPSA id 713564A039A;
 Thu,  8 Jun 2023 12:42:08 +0000 (UTC)
From: Mads Ynddal <mads@ynddal.dk>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Cleber Rosa <crosa@redhat.com>,
 Mads Ynddal <m.ynddal@samsung.com>
Subject: [PATCH v3 06/14] simpletrace: improved error handling on struct unpack
Date: Thu,  8 Jun 2023 14:41:39 +0200
Message-Id: <20230608124147.51125-7-mads@ynddal.dk>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230608124147.51125-1-mads@ynddal.dk>
References: <20230608124147.51125-1-mads@ynddal.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Ldd-rNpu2EY8pJ8cxfbSgDAgfkD1GHIT
X-Proofpoint-ORIG-GUID: Ldd-rNpu2EY8pJ8cxfbSgDAgfkD1GHIT
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.517,18.0.572,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2022-06-21=5F01:2022-06-21=5F01,2020-02-14=5F11,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0
 mlxlogscore=314 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
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

A failed call to `read_header` wouldn't be handled the same for the two
different code paths (one path would try to use `None` as a list).
Changed to raise exception to be handled centrally. This also allows for
easier unpacking, as errors has been filtered out.

Signed-off-by: Mads Ynddal <m.ynddal@samsung.com>
---
 scripts/simpletrace.py | 41 ++++++++++++++++-------------------------
 1 file changed, 16 insertions(+), 25 deletions(-)

diff --git a/scripts/simpletrace.py b/scripts/simpletrace.py
index 971b2a0f6a..8aea0d169b 100755
--- a/scripts/simpletrace.py
+++ b/scripts/simpletrace.py
@@ -37,26 +37,24 @@ def read_header(fobj, hfmt):
     hlen = struct.calcsize(hfmt)
     hdr = fobj.read(hlen)
     if len(hdr) != hlen:
-        return None
+        raise ValueError('Error reading header. Wrong filetype provided?')
     return struct.unpack(hfmt, hdr)
 
 def get_record(event_mapping, event_id_to_name, rechdr, fobj):
     """Deserialize a trace record from a file into a tuple
        (name, timestamp, pid, arg1, ..., arg6)."""
-    if rechdr is None:
-        return None
-    if rechdr[0] != dropped_event_id:
-        event_id = rechdr[0]
+    event_id, timestamp_ns, length, pid = rechdr
+    if event_id != dropped_event_id:
         name = event_id_to_name[event_id]
-        rec = (name, rechdr[1], rechdr[3])
         try:
             event = event_mapping[name]
         except KeyError as e:
-            sys.stderr.write('%s event is logged but is not declared ' \
+            sys.stderr.write(f'{e} event is logged but is not declared ' \
                              'in the trace events file, try using ' \
-                             'trace-events-all instead.\n' % str(e))
+                             'trace-events-all instead.\n')
             sys.exit(1)
 
+        rec = (name, timestamp_ns, pid)
         for type, name in event.args:
             if is_string(type):
                 l = fobj.read(4)
@@ -67,9 +65,8 @@ def get_record(event_mapping, event_id_to_name, rechdr, fobj):
                 (value,) = struct.unpack('=Q', fobj.read(8))
                 rec = rec + (value,)
     else:
-        rec = ("dropped", rechdr[1], rechdr[3])
-        (value,) = struct.unpack('=Q', fobj.read(8))
-        rec = rec + (value,)
+        (dropped_count,) = struct.unpack('=Q', fobj.read(8))
+        rec = ("dropped", timestamp_ns, pid, dropped_count)
     return rec
 
 def get_mapping(fobj):
@@ -86,22 +83,16 @@ def read_record(event_mapping, event_id_to_name, fobj):
 
 def read_trace_header(fobj):
     """Read and verify trace file header"""
-    header = read_header(fobj, log_header_fmt)
-    if header is None:
-        raise ValueError('Not a valid trace file!')
-    if header[0] != header_event_id:
-        raise ValueError('Not a valid trace file, header id %d != %d' %
-                         (header[0], header_event_id))
-    if header[1] != header_magic:
-        raise ValueError('Not a valid trace file, header magic %d != %d' %
-                         (header[1], header_magic))
-
-    log_version = header[2]
+    _header_event_id, _header_magic, log_version = read_header(fobj, log_header_fmt)
+    if _header_event_id != header_event_id:
+        raise ValueError(f'Not a valid trace file, header id {_header_event_id} != {header_event_id}')
+    if _header_magic != header_magic:
+        raise ValueError(f'Not a valid trace file, header magic {_header_magic} != {header_magic}')
+
     if log_version not in [0, 2, 3, 4]:
-        raise ValueError('Unknown version of tracelog format!')
+        raise ValueError(f'Unknown version {log_version} of tracelog format!')
     if log_version != 4:
-        raise ValueError('Log format %d not supported with this QEMU release!'
-                         % log_version)
+        raise ValueError(f'Log format {log_version} not supported with this QEMU release!')
 
 def read_trace_records(event_mapping, event_id_to_name, fobj):
     """Deserialize trace records from a file, yielding record tuples (event_num, timestamp, pid, arg1, ..., arg6).
-- 
2.38.1


