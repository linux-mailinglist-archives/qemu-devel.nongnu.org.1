Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE8D785325
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 10:55:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYjdh-0003uq-JO; Wed, 23 Aug 2023 04:54:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1qYjdg-0003uh-7J
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 04:54:56 -0400
Received: from pv50p00im-tydg10021701.me.com ([17.58.6.54])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1qYjde-0008Ey-Nj
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 04:54:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 t=1692780893; bh=W83Ca9yBFXSN52i0UPeLf92nJZuoNUL362rz88h/WN4=;
 h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
 b=em+v1+5U/ZU12COjuos8Yhd9JdUZ9UeiRscZ3+cTrpc40a4FRkG5DMERzJWhPNK+a
 tixEPp70RQ3ie9knPMDkmLjKwnAaiBcFbIBKsywVBgnPFLSysIOP45EVMlCmWtwv1o
 3GuVI0JIkwUe1m5uQiZgDTdiDIkNMqG+mnbOC+z4hiOWmee4JNLssuvAEhCaSnuqE1
 ieXWez8o2sj2EeRUTwkV5e/bzK3j24UuFniRsTNcwycL1POCDmWpB/MstSNE3YIuO4
 NLjGlpGg2RnFAC/XzkPfXEdjAvOw9bdyqpQA8jdmJwTxaV6Ndp0RX4xqAy5+XJAG/W
 joboAlJSP6y5Q==
Received: from localhost.localdomain (pv50p00im-dlb-asmtp-mailmevip.me.com
 [17.56.9.10])
 by pv50p00im-tydg10021701.me.com (Postfix) with ESMTPSA id 9B8613A0B7A;
 Wed, 23 Aug 2023 08:54:51 +0000 (UTC)
From: Mads Ynddal <mads@ynddal.dk>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Mads Ynddal <m.ynddal@samsung.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 07/14] simpletrace: define exception and add handling
Date: Wed, 23 Aug 2023 10:54:22 +0200
Message-Id: <20230823085429.20519-8-mads@ynddal.dk>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230823085429.20519-1-mads@ynddal.dk>
References: <20230823085429.20519-1-mads@ynddal.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: _o6R2X_eXKb8Xn-HxNpjaBJaEb-ZS-q-
X-Proofpoint-GUID: _o6R2X_eXKb8Xn-HxNpjaBJaEb-ZS-q-
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.517,18.0.883,17.11.64.514.0000000_definitions?=
 =?UTF-8?Q?=3D2022-06-21=5F08:2022-06-21=5F01,2022-06-21=5F08,2022-02-23?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0
 mlxlogscore=690 clxscore=1030 bulkscore=0 adultscore=0 phishscore=0
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

Define `SimpleException` to differentiate our exceptions from generic
exceptions (IOError, etc.). Adapted simpletrace to support this and
output to stderr.

Signed-off-by: Mads Ynddal <m.ynddal@samsung.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 scripts/simpletrace.py | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/scripts/simpletrace.py b/scripts/simpletrace.py
index 8aea0d169b..229b10aa99 100755
--- a/scripts/simpletrace.py
+++ b/scripts/simpletrace.py
@@ -32,12 +32,15 @@
 log_header_fmt = '=QQQ'
 rec_header_fmt = '=QQII'
 
+class SimpleException(Exception):
+    pass
+
 def read_header(fobj, hfmt):
     '''Read a trace record header'''
     hlen = struct.calcsize(hfmt)
     hdr = fobj.read(hlen)
     if len(hdr) != hlen:
-        raise ValueError('Error reading header. Wrong filetype provided?')
+        raise SimpleException('Error reading header. Wrong filetype provided?')
     return struct.unpack(hfmt, hdr)
 
 def get_record(event_mapping, event_id_to_name, rechdr, fobj):
@@ -49,10 +52,10 @@ def get_record(event_mapping, event_id_to_name, rechdr, fobj):
         try:
             event = event_mapping[name]
         except KeyError as e:
-            sys.stderr.write(f'{e} event is logged but is not declared ' \
-                             'in the trace events file, try using ' \
-                             'trace-events-all instead.\n')
-            sys.exit(1)
+            raise SimpleException(
+                f'{e} event is logged but is not declared in the trace events'
+                'file, try using trace-events-all instead.'
+            )
 
         rec = (name, timestamp_ns, pid)
         for type, name in event.args:
@@ -247,8 +250,7 @@ def run(analyzer):
         *no_header, trace_event_path, trace_file_path = sys.argv[1:]
         assert no_header == [] or no_header == ['--no-header'], 'Invalid no-header argument'
     except (AssertionError, ValueError):
-        sys.stderr.write(f'usage: {sys.argv[0]} [--no-header] <trace-events> <trace-file>\n')
-        sys.exit(1)
+        raise SimpleException(f'usage: {sys.argv[0]} [--no-header] <trace-events> <trace-file>\n')
 
     with open(trace_event_path, 'r') as events_fobj, open(trace_file_path, 'rb') as log_fobj:
         process(events_fobj, log_fobj, analyzer, read_header=not no_header)
@@ -276,4 +278,8 @@ def catchall(self, event, rec):
                 i += 1
             print(' '.join(fields))
 
-    run(Formatter())
+    try:
+        run(Formatter())
+    except SimpleException as e:
+        sys.stderr.write(str(e) + "\n")
+        sys.exit(1)
-- 
2.38.1


