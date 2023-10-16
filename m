Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D306C7CAD85
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 17:28:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsPVA-0001QJ-8S; Mon, 16 Oct 2023 11:27:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qsPV7-0001Q1-QL
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 11:27:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qsPV6-0003OU-5S
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 11:27:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697470042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6Nh+Hgzz6TwYSV/cRzWHk1PKRYK1opIAdVs73vT5Crg=;
 b=VO2N3jPgMtlKV3hmMSN06o+l9grqy8bXFK4k/sUHHuusaD6SD76zRD+8Gb66wpRy27mE/g
 QffNYIgjYPlMM8B1na6xEUb8zM6Fojb1yXzKJYT1B3STCIfQDziAH0+lkqChtB/GahSGz5
 42fqp8MBPm2U1poNwp/P49VR4jSdudk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-659-5LkYgF8PPS6eJvyHwlgWxw-1; Mon, 16 Oct 2023 11:27:11 -0400
X-MC-Unique: 5LkYgF8PPS6eJvyHwlgWxw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A930A1023111
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 15:27:10 +0000 (UTC)
Received: from tapioca.redhat.com (unknown [10.45.225.170])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 308CD20296DB;
 Mon, 16 Oct 2023 15:27:08 +0000 (UTC)
From: Victor Toso <victortoso@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>
Subject: [PATCH v2 02/11] scripts: qapi: black format main.py
Date: Mon, 16 Oct 2023 17:26:55 +0200
Message-ID: <20231016152704.221611-3-victortoso@redhat.com>
In-Reply-To: <20231016152704.221611-1-victortoso@redhat.com>
References: <20231016152704.221611-1-victortoso@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=victortoso@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

flake8 complained:
    ./main.py:60:1: E302 expected 2 blank lines, found 1

Which is simple enough. My vim has black [0] enabled by default, so it
did some extra formatting. I'm proposing to follow it.

[0] https://black.readthedocs.io/en/stable/

Signed-off-by: Victor Toso <victortoso@redhat.com>
---
 scripts/qapi/main.py | 76 ++++++++++++++++++++++++++++----------------
 1 file changed, 48 insertions(+), 28 deletions(-)

diff --git a/scripts/qapi/main.py b/scripts/qapi/main.py
index 316736b6a2..fe65c1a17a 100644
--- a/scripts/qapi/main.py
+++ b/scripts/qapi/main.py
@@ -22,18 +22,20 @@
 
 
 def invalid_prefix_char(prefix: str) -> Optional[str]:
-    match = must_match(r'([A-Za-z_.-][A-Za-z0-9_.-]*)?', prefix)
+    match = must_match(r"([A-Za-z_.-][A-Za-z0-9_.-]*)?", prefix)
     if match.end() != len(prefix):
         return prefix[match.end()]
     return None
 
 
-def generate(schema_file: str,
-             output_dir: str,
-             prefix: str,
-             unmask: bool = False,
-             builtins: bool = False,
-             gen_tracing: bool = False) -> None:
+def generate(
+    schema_file: str,
+    output_dir: str,
+    prefix: str,
+    unmask: bool = False,
+    builtins: bool = False,
+    gen_tracing: bool = False,
+) -> None:
     """
     Generate C code for the given schema into the target directory.
 
@@ -63,25 +65,41 @@ def main() -> int:
     :return: int, 0 on success, 1 on failure.
     """
     parser = argparse.ArgumentParser(
-        description='Generate code from a QAPI schema')
-    parser.add_argument('-b', '--builtins', action='store_true',
-                        help="generate code for built-in types")
-    parser.add_argument('-o', '--output-dir', action='store',
-                        default='',
-                        help="write output to directory OUTPUT_DIR")
-    parser.add_argument('-p', '--prefix', action='store',
-                        default='',
-                        help="prefix for symbols")
-    parser.add_argument('-u', '--unmask-non-abi-names', action='store_true',
-                        dest='unmask',
-                        help="expose non-ABI names in introspection")
+        description="Generate code from a QAPI schema"
+    )
+    parser.add_argument(
+        "-b",
+        "--builtins",
+        action="store_true",
+        help="generate code for built-in types",
+    )
+    parser.add_argument(
+        "-o",
+        "--output-dir",
+        action="store",
+        default="",
+        help="write output to directory OUTPUT_DIR",
+    )
+    parser.add_argument(
+        "-p", "--prefix", action="store", default="", help="prefix for symbols"
+    )
+    parser.add_argument(
+        "-u",
+        "--unmask-non-abi-names",
+        action="store_true",
+        dest="unmask",
+        help="expose non-ABI names in introspection",
+    )
 
     # Option --suppress-tracing exists so we can avoid solving build system
     # problems.  TODO Drop it when we no longer need it.
-    parser.add_argument('--suppress-tracing', action='store_true',
-                        help="suppress adding trace events to qmp marshals")
+    parser.add_argument(
+        "--suppress-tracing",
+        action="store_true",
+        help="suppress adding trace events to qmp marshals",
+    )
 
-    parser.add_argument('schema', action='store')
+    parser.add_argument("schema", action="store")
     args = parser.parse_args()
 
     funny_char = invalid_prefix_char(args.prefix)
@@ -91,12 +109,14 @@ def main() -> int:
         return 1
 
     try:
-        generate(args.schema,
-                 output_dir=args.output_dir,
-                 prefix=args.prefix,
-                 unmask=args.unmask,
-                 builtins=args.builtins,
-                 gen_tracing=not args.suppress_tracing)
+        generate(
+            args.schema,
+            output_dir=args.output_dir,
+            prefix=args.prefix,
+            unmask=args.unmask,
+            builtins=args.builtins,
+            gen_tracing=not args.suppress_tracing,
+        )
     except QAPIError as err:
         print(err, file=sys.stderr)
         return 1
-- 
2.41.0


