Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AB0704B98
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 13:03:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pysR4-00058h-Cx; Tue, 16 May 2023 07:01:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pysPL-0001cj-D1
 for qemu-devel@nongnu.org; Tue, 16 May 2023 07:00:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pysP6-00086b-0c
 for qemu-devel@nongnu.org; Tue, 16 May 2023 06:59:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684234763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5paFJb263ntQ+dWuL7ErVVAlIRwtYtVLGtVyv/kx0Gw=;
 b=Sn5CO+qb4fGLXeIvRaI9a165THpjAt527TfqdFX644JwAJ/drYTxrwhKH978ErPteILqyr
 B8IqQueTUl+EdDzsgojyFsbtwoCWtL/EFzyan/gS2GF/18/sc0BnWiZNiDJ5vnZQP+lpoN
 xyjyEeCButXrtAiF4qTNwh6nMK9FE48=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-605-aSb3IQqIM8Cv5-vEg7FoGw-1; Tue, 16 May 2023 06:59:22 -0400
X-MC-Unique: aSb3IQqIM8Cv5-vEg7FoGw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A9FC987DC00;
 Tue, 16 May 2023 10:59:21 +0000 (UTC)
Received: from avogadro.lan (unknown [10.39.192.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C7D65492B00;
 Tue, 16 May 2023 10:59:20 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com,
	philmd@linaro.org,
	berrange@redhat.com
Subject: [PATCH v2 10/27] mkvenv: avoid ensurepip if pip is installed
Date: Tue, 16 May 2023 12:58:51 +0200
Message-Id: <20230516105908.527838-10-pbonzini@redhat.com>
In-Reply-To: <20230516105908.527838-1-pbonzini@redhat.com>
References: <20230516105908.527838-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: John Snow <jsnow@redhat.com>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 python/scripts/mkvenv.py | 67 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 64 insertions(+), 3 deletions(-)

diff --git a/python/scripts/mkvenv.py b/python/scripts/mkvenv.py
index 9e50bfb1778b..7fc30dc1b3e8 100644
--- a/python/scripts/mkvenv.py
+++ b/python/scripts/mkvenv.py
@@ -11,6 +11,8 @@
 Commands:
   command     Description
     create    create a venv
+    post_init
+              post-venv initialization
     ensure    Ensure that the specified package is installed.
 
 --------------------------------------------------
@@ -25,6 +27,13 @@
 
 --------------------------------------------------
 
+usage: mkvenv post_init [-h]
+
+options:
+  -h, --help         show this help message and exit
+
+--------------------------------------------------
+
 usage: mkvenv ensure [-h] [--online] [--dir DIR] dep_spec...
 
 positional arguments:
@@ -111,7 +120,9 @@ class QemuEnvBuilder(venv.EnvBuilder):
 
     The primary difference is that it emulates a "nested" virtual
     environment when invoked from inside of an existing virtual
-    environment by including packages from the parent.
+    environment by including packages from the parent.  Also,
+    "ensurepip" is replaced if possible with just recreating pip's
+    console_scripts inside the virtual environment.
 
     Parameters for base class init:
       - system_site_packages: bool = False
@@ -138,8 +149,19 @@ def __init__(self, *args: Any, **kwargs: Any) -> None:
             # The venv we are currently in, also does so.
             kwargs["system_site_packages"] = sys.base_prefix in site.PREFIXES
 
-        if kwargs["with_pip"]:
-            check_ensurepip()
+        # ensurepip is slow: venv creation can be very fast for cases where
+        # we allow the use of system_site_packages. Therefore, ensurepip is
+        # replaced with our own script generation once the virtual environment
+        # is setup.
+        self.want_pip = kwargs.get("with_pip", False)
+        if self.want_pip:
+            if (
+                kwargs.get("system_site_packages", False)
+                and not need_ensurepip()
+            ):
+                kwargs["with_pip"] = False
+            else:
+                check_ensurepip()
 
         super().__init__(*args, **kwargs)
 
@@ -211,6 +233,14 @@ def post_post_setup(self, context: SimpleNamespace) -> None:
             with open(pth_file, "w", encoding="UTF-8") as file:
                 file.write(parent_libpath + os.linesep)
 
+        if self.want_pip:
+            args = [
+                context.env_exe,
+                __file__,
+                "post_init",
+            ]
+            subprocess.run(args, check=True)
+
     def get_value(self, field: str) -> str:
         """
         Get a string value from the context namespace after a call to build.
@@ -223,6 +253,19 @@ def get_value(self, field: str) -> str:
         return ret
 
 
+def need_ensurepip() -> bool:
+    """
+    Tests for the presence of setuptools and pip.
+
+    :return: `True` if we do not detect both packages.
+    """
+    # Don't try to actually import them, it's fraught with danger:
+    # https://github.com/pypa/setuptools/issues/2993
+    if find_spec("setuptools") and find_spec("pip"):
+        return False
+    return True
+
+
 def check_ensurepip() -> None:
     """
     Check that we have ensurepip.
@@ -693,6 +736,17 @@ def ensure(
         raise SystemExit(f"\n{msg}\n\n") from exc
 
 
+def post_venv_setup() -> None:
+    """
+    This is intended to be run *inside the venv* after it is created.
+    """
+    logger.debug("post_venv_setup()")
+    # Generate a 'pip' script so the venv is usable in a normal
+    # way from the CLI. This only happens when we inherited pip from a
+    # parent/system-site and haven't run ensurepip in some way.
+    generate_console_scripts(["pip"])
+
+
 def _add_create_subcommand(subparsers: Any) -> None:
     subparser = subparsers.add_parser("create", help="create a venv")
     subparser.add_argument(
@@ -703,6 +757,10 @@ def _add_create_subcommand(subparsers: Any) -> None:
     )
 
 
+def _add_post_init_subcommand(subparsers: Any) -> None:
+    subparsers.add_parser("post_init", help="post-venv initialization")
+
+
 def _add_ensure_subcommand(subparsers: Any) -> None:
     subparser = subparsers.add_parser(
         "ensure", help="Ensure that the specified package is installed."
@@ -761,6 +819,7 @@ def main() -> int:
     )
 
     _add_create_subcommand(subparsers)
+    _add_post_init_subcommand(subparsers)
     _add_ensure_subcommand(subparsers)
 
     args = parser.parse_args()
@@ -771,6 +830,8 @@ def main() -> int:
                 system_site_packages=True,
                 clear=True,
             )
+        if args.command == "post_init":
+            post_venv_setup()
         if args.command == "ensure":
             ensure(
                 dep_specs=args.dep_specs,
-- 
2.40.1



