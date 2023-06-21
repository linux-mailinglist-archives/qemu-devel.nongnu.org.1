Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C43B73782B
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 02:23:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBlbY-00041e-Au; Tue, 20 Jun 2023 20:21:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qBlbW-00040E-DF
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 20:21:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qBlbQ-00006p-S8
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 20:21:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687306898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IbqHUNUUzyICKNg1KPxJjBeG4KgfXfoJFkJJCGALlEY=;
 b=ZmTQiTt8acOVh0uDev7e8vrV9DozVoAP4sm0eog7V4HLF4sqEKaPiYxgNJgt/8JUOSKFEy
 yDYp6F+qRrvJdfD+uqSSrzG9giZh4Ow3MR+8PkGj0ec0BcUcwPhqmrgB/lfN74a8GkpjD3
 30AgjbIbHJhDOT7pZimStsZR2PzDm3s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-88-ZTshDb7HOiuNIGhGbmf0XQ-1; Tue, 20 Jun 2023 20:21:35 -0400
X-MC-Unique: ZTshDb7HOiuNIGhGbmf0XQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 851048D6E26;
 Wed, 21 Jun 2023 00:21:35 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.32.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2E7F8112132C;
 Wed, 21 Jun 2023 00:21:35 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 Beraldo Leal <bleal@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH RFC 1/6] experiment: add mkvenv install
Date: Tue, 20 Jun 2023 20:21:16 -0400
Message-Id: <20230621002121.1609612-2-jsnow@redhat.com>
In-Reply-To: <20230621002121.1609612-1-jsnow@redhat.com>
References: <20230621002121.1609612-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

This is just so I can do "mkvenv install './python'" or "mkvenv install
file:python" to install the in-tree packages to pyvenv.

It probably isn't quite appropriate to bypass do_ensure in its entirety
like this because we miss out on a lot of error handling, but as a quick
proof of concept it works just fine.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/scripts/mkvenv.py | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/python/scripts/mkvenv.py b/python/scripts/mkvenv.py
index a47f1eaf5d..ea8df34111 100644
--- a/python/scripts/mkvenv.py
+++ b/python/scripts/mkvenv.py
@@ -940,6 +940,35 @@ def _add_ensure_subcommand(subparsers: Any) -> None:
     )
 
 
+def _add_install_subcommand(subparsers: Any) -> None:
+    subparser = subparsers.add_parser(
+        "install", help="Install the specified package."
+    )
+    subparser.add_argument(
+        "--online",
+        action="store_true",
+        help="Install packages from PyPI, if necessary.",
+    )
+    subparser.add_argument(
+        "--dir",
+        type=str,
+        action="store",
+        help="Path to vendored packages where we may install from.",
+    )
+    subparser.add_argument(
+        '--editable',
+        action="store_true",
+        help="Should package(s) be installed in editable mode?"
+    )
+    subparser.add_argument(
+        "dep_specs",
+        type=str,
+        action="store",
+        help="PEP 508 Dependency specification, e.g. 'meson>=0.61.5'",
+        nargs="+",
+    )
+
+
 def main() -> int:
     """CLI interface to make_qemu_venv. See module docstring."""
     if os.environ.get("DEBUG") or os.environ.get("GITLAB_CI"):
@@ -964,6 +993,7 @@ def main() -> int:
     _add_create_subcommand(subparsers)
     _add_post_init_subcommand(subparsers)
     _add_ensure_subcommand(subparsers)
+    _add_install_subcommand(subparsers)
 
     args = parser.parse_args()
     try:
@@ -982,6 +1012,16 @@ def main() -> int:
                 wheels_dir=args.dir,
                 prog=args.diagnose,
             )
+        if args.command == "install":
+            print(f"mkvenv: installing {', '.join(args.dep_specs)}", file=sys.stderr)
+            pip_args = list(args.dep_specs)
+            if args.editable:
+                pip_args.insert(0, "--editable")
+            pip_install(
+                args=pip_args,
+                online=args.online,
+                wheels_dir=args.dir
+            )
         logger.debug("mkvenv.py %s: exiting", args.command)
     except Ouch as exc:
         print("\n*** Ouch! ***\n", file=sys.stderr)
-- 
2.40.1


