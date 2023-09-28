Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ACBB07B1EDE
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 15:46:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlrJk-0000vL-7L; Thu, 28 Sep 2023 09:44:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qlrJc-0000uq-5X
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:44:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qlrJZ-0005Gy-Rv
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:44:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695908665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J48OycNztKVj3b0x6e/yZdSeR6A0hYpyBUdSd50kql4=;
 b=BcCVLBPNKdvIAJSoqQ2epzM59/82GD0NN28SmweBLakjYz7gJ2/vvXFNG+IcjnHu80DWVL
 Avpace4yaVO0if3jaoSfPfAVnAyo+9tLMuPIeBcsZKfCr4y1jBt6PnBHeDKwnETlY1xdAm
 o6RO6kyHA0OvpQUmCwg0enf5Dxk6qV4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-654-xIsF8zuGMluIjQyUP_kR8g-1; Thu, 28 Sep 2023 09:44:21 -0400
X-MC-Unique: xIsF8zuGMluIjQyUP_kR8g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A4856811E7D;
 Thu, 28 Sep 2023 13:44:20 +0000 (UTC)
Received: from localhost (unknown [10.39.195.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 30D6740C2064;
 Thu, 28 Sep 2023 13:44:19 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Mads Ynddal <m.ynddal@samsung.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 06/14] simpletrace: improved error handling on struct unpack
Date: Thu, 28 Sep 2023 09:43:59 -0400
Message-ID: <20230928134407.568453-7-stefanha@redhat.com>
In-Reply-To: <20230928134407.568453-1-stefanha@redhat.com>
References: <20230928134407.568453-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

A failed call to `read_header` wouldn't be handled the same for the two
different code paths (one path would try to use `None` as a list).
Changed to raise exception to be handled centrally. This also allows for
easier unpacking, as errors has been filtered out.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Mads Ynddal <m.ynddal@samsung.com>
Message-id: 20230926103436.25700-7-mads@ynddal.dk
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 scripts/simpletrace.py | 39 +++++++++++++++------------------------
 1 file changed, 15 insertions(+), 24 deletions(-)

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
+    _header_event_id, _header_magic, log_version = read_header(fobj, log_header_fmt)
+    if _header_event_id != header_event_id:
+        raise ValueError(f'Not a valid trace file, header id {_header_event_id} != {header_event_id}')
+    if _header_magic != header_magic:
+        raise ValueError(f'Not a valid trace file, header magic {_header_magic} != {header_magic}')
 
-    log_version = header[2]
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
2.41.0


