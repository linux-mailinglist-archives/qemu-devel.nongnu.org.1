Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB8079A79E
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 13:27:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qff4c-0000kY-PF; Mon, 11 Sep 2023 07:27:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qff4a-0000j5-Bz
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 07:27:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qff4Y-0007Rx-7z
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 07:27:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694431637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P+tvacQu5hZfeUsgCdgM+W92SovZWWWUWdcPncNQai0=;
 b=M33FRETGFhPvmeap1FXkbZhZF+nSZSAiTROk8hyDjWCl1TH3bw6m2vxmjDkPCpMY+b5QwX
 YcxO9HRnFV8qpEVibPVUl8M4y0+9ieQcTf44/X76eeEI5DcgWYRhpRlpIwIfTO1VsJmZeG
 If2Yck81NDtjy3QQx0Itxmih4bqZR8k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-66-6Udqbm91OEGjL_9kpEjtsg-1; Mon, 11 Sep 2023 07:27:15 -0400
X-MC-Unique: 6Udqbm91OEGjL_9kpEjtsg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 98DDF182C5E5
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 11:27:15 +0000 (UTC)
Received: from tapioca.lan (unknown [10.45.225.203])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 05D5B2027045
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 11:27:14 +0000 (UTC)
From: Victor Toso <victortoso@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 10/11] qapi: meson: add test flag to allow skip generators
Date: Mon, 11 Sep 2023 13:27:12 +0200
Message-ID: <20230911112713.78008-1-victortoso@redhat.com>
In-Reply-To: <20230911104017.65397-1-victortoso@redhat.com>
References: <20230911104017.65397-1-victortoso@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=victortoso@redhat.com; helo=us-smtp-delivery-124.mimecast.com
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

The next patch adds a generator that also validates qapi
documentation. We don't want to execute it with a test schema.

Signed-off-by: Victor Toso <victortoso@redhat.com>
---
 scripts/qapi/main.py | 4 ++++
 tests/meson.build    | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/scripts/qapi/main.py b/scripts/qapi/main.py
index 316736b6a2..7efdcc6b8d 100644
--- a/scripts/qapi/main.py
+++ b/scripts/qapi/main.py
@@ -33,6 +33,7 @@ def generate(schema_file: str,
              prefix: str,
              unmask: bool = False,
              builtins: bool = False,
+             test_schema: bool = False,
              gen_tracing: bool = False) -> None:
     """
     Generate C code for the given schema into the target directory.
@@ -75,6 +76,8 @@ def main() -> int:
     parser.add_argument('-u', '--unmask-non-abi-names', action='store_true',
                         dest='unmask',
                         help="expose non-ABI names in introspection")
+    parser.add_argument('-t', '--tests', action='store_true',
+                        help="flag generator that is running with a test schema")
 
     # Option --suppress-tracing exists so we can avoid solving build system
     # problems.  TODO Drop it when we no longer need it.
@@ -96,6 +99,7 @@ def main() -> int:
                  prefix=args.prefix,
                  unmask=args.unmask,
                  builtins=args.builtins,
+                 test_schema=args.tests,
                  gen_tracing=not args.suppress_tracing)
     except QAPIError as err:
         print(err, file=sys.stderr)
diff --git a/tests/meson.build b/tests/meson.build
index debaa4505e..ed0844a6a0 100644
--- a/tests/meson.build
+++ b/tests/meson.build
@@ -43,7 +43,7 @@ test_qapi_files = custom_target('Test QAPI files',
                                              'qapi-schema/include/sub-module.json',
                                              'qapi-schema/sub-sub-module.json'),
                                 command: [ qapi_gen, '-o', meson.current_build_dir(),
-                                           '-b', '-p', 'test-', '@INPUT0@',
+                                           '-t', '-b', '-p', 'test-', '@INPUT0@',
                                            '--suppress-tracing' ],
                                 depend_files: qapi_gen_depends)
 
-- 
2.41.0


