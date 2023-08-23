Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF2E785326
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 10:55:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYjdg-0003uP-4E; Wed, 23 Aug 2023 04:54:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1qYjdd-0003uE-P5
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 04:54:53 -0400
Received: from pv50p00im-tydg10021701.me.com ([17.58.6.54])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1qYjdc-0008Dx-4T
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 04:54:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 t=1692780891; bh=tv8iQdRgnNjq6DBzxFJS9huknQBhYuHeuL8iwQFn9rw=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=dBbeqQoXHUh1hqUds9kCBcbuNqKInd1DUkd4H7HC1Lbs7hWC6lg/zp54ZTL+/eoTA
 skPY/KdxCMiixVSKAACd0Kyf3sc5NrkM+Z4ZWthFx9tcIM4KnvHGdIvC1pR3Y7FV41
 aoMRNNWBIOqKHIVxNduyuwpL2ZHuuCSjJWtEdfGl8tjHKHWP5A0V2LP4R2rnlsQ/ky
 ANt55dOQrCkK4dy+Hh10yPBb3QP24SRpTPOaOdZSyiERJQvPPeAunqdetbbrBq0/AJ
 5b7pTnoYkE5MwPh/OIWGCxGDV7auzLVhgrxkcOiefOKzLWlg9JoxU4ohquAujxPth9
 p5CV/WkxBJdmg==
Received: from localhost.localdomain (pv50p00im-dlb-asmtp-mailmevip.me.com
 [17.56.9.10])
 by pv50p00im-tydg10021701.me.com (Postfix) with ESMTPSA id 31D9D3A0BAE;
 Wed, 23 Aug 2023 08:54:48 +0000 (UTC)
From: Mads Ynddal <mads@ynddal.dk>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Mads Ynddal <m.ynddal@samsung.com>
Subject: [PATCH v4 06/14] simpletrace: improved error handling on struct unpack
Date: Wed, 23 Aug 2023 10:54:21 +0200
Message-Id: <20230823085429.20519-7-mads@ynddal.dk>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230823085429.20519-1-mads@ynddal.dk>
References: <20230823085429.20519-1-mads@ynddal.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: -4RPrpLXnOBi2F8ztseGgY9LxKMcEA_T
X-Proofpoint-GUID: -4RPrpLXnOBi2F8ztseGgY9LxKMcEA_T
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.517,18.0.883,17.11.64.514.0000000_definitions?=
 =?UTF-8?Q?=3D2022-06-21=5F08:2022-06-21=5F01,2022-06-21=5F08,2022-02-23?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0
 mlxlogscore=366 clxscore=1030 bulkscore=0 adultscore=0 phishscore=0
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


