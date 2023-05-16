Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46400704BCA
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 13:07:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pysP8-0001NC-If; Tue, 16 May 2023 06:59:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pysP6-0001JI-9B
 for qemu-devel@nongnu.org; Tue, 16 May 2023 06:59:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pysOn-00086C-S9
 for qemu-devel@nongnu.org; Tue, 16 May 2023 06:59:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684234760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/qn6PlyQcXFRCYERcyV1KhfQHEErS0+OCHV6WwgxD0s=;
 b=ToaWDJS8Vt7nohhASi1l8gtTzxFGOVE6VXVzkWDBmIEfkR5S7/JpdSF7sgtmqYC2yIusFO
 7I8QFjLDqxm1MMUN7vwJkva6i1qdY0vVNEokXU7npVbOvg8AgJGgoCsarobVwe+pHSuaHO
 Ynz1ljJ/lzb+OASzwpYAcyk/Jj51YSk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-621-4HrD3lkMNlWEmGL1knFHmQ-1; Tue, 16 May 2023 06:59:17 -0400
X-MC-Unique: 4HrD3lkMNlWEmGL1knFHmQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1315485C073;
 Tue, 16 May 2023 10:59:17 +0000 (UTC)
Received: from avogadro.lan (unknown [10.39.192.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 300E7492B00;
 Tue, 16 May 2023 10:59:16 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com,
	philmd@linaro.org,
	berrange@redhat.com
Subject: [PATCH v2 06/27] mkvenv: add ensure subcommand
Date: Tue, 16 May 2023 12:58:47 +0200
Message-Id: <20230516105908.527838-6-pbonzini@redhat.com>
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

This command is to be used to add various packages (or ensure they're
already present) into the configure-provided venv in a modular fashion.

Examples:

mkvenv ensure --online --dir "${source_dir}/python/wheels/" "meson>=0.61.5"
mkvenv ensure --online "sphinx>=1.6.0"
mkvenv ensure "qemu.qmp==0.0.2"

It's designed to look for packages in three places, in order:

(1) In system packages, if the version installed is already good
enough. This way your distribution-provided meson, sphinx, etc are
always used as first preference.

(2) In a vendored packages directory. Here I am suggesting
qemu.git/python/wheels/ as that directory. This is intended to serve as
a replacement for vendoring the meson source for QEMU tarballs. It is
also highly likely to be extremely useful for packaging the "qemu.qmp"
package in source distributions for platforms that do not yet package
qemu.qmp separately.

(3) Online, via PyPI, ***only when "--online" is passed***. This is only
ever used as a fallback if the first two sources do not have an
appropriate package that meets the requirement. The ability to build
QEMU and run tests *completely offline* is not impinged.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
Message-Id: <20230511035435.734312-7-jsnow@redhat.com>
[Use distlib to lookup distributions. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 python/scripts/mkvenv.py | 135 ++++++++++++++++++++++++++++++++++++++-
 python/setup.cfg         |  10 +++
 python/tests/minreqs.txt |   3 +
 3 files changed, 145 insertions(+), 3 deletions(-)

diff --git a/python/scripts/mkvenv.py b/python/scripts/mkvenv.py
index 2a3d73a51db4..fd4b62c70ffa 100644
--- a/python/scripts/mkvenv.py
+++ b/python/scripts/mkvenv.py
@@ -11,6 +11,7 @@
 Commands:
   command     Description
     create    create a venv
+    ensure    Ensure that the specified package is installed.
 
 --------------------------------------------------
 
@@ -22,6 +23,18 @@
 options:
   -h, --help  show this help message and exit
 
+--------------------------------------------------
+
+usage: mkvenv ensure [-h] [--online] [--dir DIR] dep_spec...
+
+positional arguments:
+  dep_spec    PEP 508 Dependency specification, e.g. 'meson>=0.61.5'
+
+options:
+  -h, --help  show this help message and exit
+  --online    Install packages from PyPI, if necessary.
+  --dir DIR   Path to vendored packages where we may install from.
+
 """
 
 # Copyright (C) 2022-2023 Red Hat, Inc.
@@ -43,8 +56,17 @@
 import sys
 import sysconfig
 from types import SimpleNamespace
-from typing import Any, Optional, Union
+from typing import (
+    Any,
+    Optional,
+    Sequence,
+    Union,
+)
 import venv
+import warnings
+
+import distlib.database
+import distlib.version
 
 
 # Do not add any mandatory dependencies from outside the stdlib:
@@ -309,6 +331,77 @@ def _stringify(data: Union[str, bytes]) -> str:
     print(builder.get_value("env_exe"))
 
 
+def pip_install(
+    args: Sequence[str],
+    online: bool = False,
+    wheels_dir: Optional[Union[str, Path]] = None,
+) -> None:
+    """
+    Use pip to install a package or package(s) as specified in @args.
+    """
+    loud = bool(
+        os.environ.get("DEBUG")
+        or os.environ.get("GITLAB_CI")
+        or os.environ.get("V")
+    )
+
+    full_args = [
+        sys.executable,
+        "-m",
+        "pip",
+        "install",
+        "--disable-pip-version-check",
+        "-v" if loud else "-q",
+    ]
+    if not online:
+        full_args += ["--no-index"]
+    if wheels_dir:
+        full_args += ["--find-links", f"file://{str(wheels_dir)}"]
+    full_args += list(args)
+    subprocess.run(
+        full_args,
+        check=True,
+    )
+
+
+def ensure(
+    dep_specs: Sequence[str],
+    online: bool = False,
+    wheels_dir: Optional[Union[str, Path]] = None,
+) -> None:
+    """
+    Use pip to ensure we have the package specified by @dep_specs.
+
+    If the package is already installed, do nothing. If online and
+    wheels_dir are both provided, prefer packages found in wheels_dir
+    first before connecting to PyPI.
+
+    :param dep_specs:
+        PEP 508 dependency specifications. e.g. ['meson>=0.61.5'].
+    :param online: If True, fall back to PyPI.
+    :param wheels_dir: If specified, search this path for packages.
+    """
+    with warnings.catch_warnings():
+        warnings.filterwarnings(
+            "ignore", category=UserWarning, module="distlib"
+        )
+        dist_path = distlib.database.DistributionPath(include_egg=True)
+        absent = []
+        for spec in dep_specs:
+            matcher = distlib.version.LegacyMatcher(spec)
+            dist = dist_path.get_distribution(matcher.name)
+            if dist is None or not matcher.match(dist.version):
+                absent.append(spec)
+            else:
+                logger.info("found %s", dist)
+
+    if absent:
+        # Some packages are missing or aren't a suitable version,
+        # install a suitable (possibly vendored) package.
+        print(f"mkvenv: installing {', '.join(absent)}", file=sys.stderr)
+        pip_install(args=absent, online=online, wheels_dir=wheels_dir)
+
+
 def _add_create_subcommand(subparsers: Any) -> None:
     subparser = subparsers.add_parser("create", help="create a venv")
     subparser.add_argument(
@@ -319,13 +412,42 @@ def _add_create_subcommand(subparsers: Any) -> None:
     )
 
 
+def _add_ensure_subcommand(subparsers: Any) -> None:
+    subparser = subparsers.add_parser(
+        "ensure", help="Ensure that the specified package is installed."
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
         # You're welcome.
         logging.basicConfig(level=logging.DEBUG)
-    elif os.environ.get("V"):
-        logging.basicConfig(level=logging.INFO)
+    else:
+        if os.environ.get("V"):
+            logging.basicConfig(level=logging.INFO)
+
+        # These are incredibly noisy even for V=1
+        logging.getLogger("distlib.metadata").addFilter(lambda record: False)
+        logging.getLogger("distlib.database").addFilter(lambda record: False)
 
     parser = argparse.ArgumentParser(
         prog="mkvenv",
@@ -339,6 +461,7 @@ def main() -> int:
     )
 
     _add_create_subcommand(subparsers)
+    _add_ensure_subcommand(subparsers)
 
     args = parser.parse_args()
     try:
@@ -348,6 +471,12 @@ def main() -> int:
                 system_site_packages=True,
                 clear=True,
             )
+        if args.command == "ensure":
+            ensure(
+                dep_specs=args.dep_specs,
+                online=args.online,
+                wheels_dir=args.dir,
+            )
         logger.debug("mkvenv.py %s: exiting", args.command)
     except Ouch as exc:
         print("\n*** Ouch! ***\n", file=sys.stderr)
diff --git a/python/setup.cfg b/python/setup.cfg
index 5b25f810fa8b..d680374b2950 100644
--- a/python/setup.cfg
+++ b/python/setup.cfg
@@ -36,6 +36,7 @@ packages =
 # Remember to update tests/minreqs.txt if changing anything below:
 devel =
     avocado-framework >= 90.0
+    distlib >= 0.3.6
     flake8 >= 3.6.0
     fusepy >= 2.0.4
     isort >= 5.1.2
@@ -112,6 +113,15 @@ ignore_missing_imports = True
 [mypy-pkg_resources]
 ignore_missing_imports = True
 
+[mypy-distlib]
+ignore_missing_imports = True
+
+[mypy-distlib.database]
+ignore_missing_imports = True
+
+[mypy-distlib.version]
+ignore_missing_imports = True
+
 [pylint.messages control]
 # Disable the message, report, category or checker with the given id(s). You
 # can either give multiple identifiers separated by comma (,) or put this
diff --git a/python/tests/minreqs.txt b/python/tests/minreqs.txt
index dfb8abb155f4..7ecf5e7fe483 100644
--- a/python/tests/minreqs.txt
+++ b/python/tests/minreqs.txt
@@ -16,6 +16,9 @@ urwid==2.1.2
 urwid-readline==0.13
 Pygments==2.9.0
 
+# Dependencies for mkvenv
+distlib==0.3.6
+
 # Dependencies for FUSE support for qom-fuse
 fusepy==2.0.4
 
-- 
2.40.1



