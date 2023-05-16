Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 45177704BC6
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 13:06:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pysP8-0001N5-Jm; Tue, 16 May 2023 06:59:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pysP6-0001JG-8w
 for qemu-devel@nongnu.org; Tue, 16 May 2023 06:59:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pysOi-00084e-7k
 for qemu-devel@nongnu.org; Tue, 16 May 2023 06:59:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684234755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qTw3Bd3Jy9NfUA8L6LCAlNhcg4RC5pKPciy2XM891pA=;
 b=ULwao2vUIGQAlpWGUD5kvui9g90nUsOog6J/HlAK2QM8qfkJH9NTSHmBUrtUNuF81QaoSj
 4qYWLPOJnS9/e3NNt/rTzwFZ8wbDbkLx5L9qavSCO7z63G9D8kFthBu5U5c6vpAWMjGcFC
 peUfTAbr9I4/REaawM1cmHJOxLs0Yhw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-421-4aYh2rBPOTasoC7qcb9ohA-1; Tue, 16 May 2023 06:59:13 -0400
X-MC-Unique: 4aYh2rBPOTasoC7qcb9ohA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 812C83815EE0;
 Tue, 16 May 2023 10:59:13 +0000 (UTC)
Received: from avogadro.lan (unknown [10.39.192.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7278B492B00;
 Tue, 16 May 2023 10:59:12 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com,
	philmd@linaro.org,
	berrange@redhat.com
Subject: [PATCH v2 03/27] python: add mkvenv.py
Date: Tue, 16 May 2023 12:58:44 +0200
Message-Id: <20230516105908.527838-3-pbonzini@redhat.com>
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

From: John Snow <jsnow@redhat.com>

This script will be responsible for building a lightweight Python
virtual environment at configure time. It works with Python 3.6 or
newer.

It has been designed to:
- work *offline*, no PyPI required.
- work *quickly*, The fast path is only ~65ms on my machine.
- work *robustly*, with multiple fallbacks to keep things working.
- work *cooperatively*, using system packages where possible.
  (You can use your distro's meson, no problem.)

Due to its unique position in the build chain, it exists outside of the
installable python packages in-tree and *must* be runnable without any
third party dependencies.

Under normal circumstances, the only dependency required to execute this
script is Python 3.6+ itself. The script is *faster* by several seconds
when setuptools and pip are installed in the host environment, which is
probably the case for a typical multi-purpose developer workstation.

In the event that pip/setuptools are missing or not usable, additional
dependencies may be required on some distributions which remove certain
Python stdlib modules to package them separately:

- Debian may require python3-venv to provide "ensurepip"
- NetBSD may require py310-expat to provide "pyexpat" *
  (* Or whichever version is current for NetBSD.)

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
Message-Id: <20230511035435.734312-4-jsnow@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 python/scripts/mkvenv.py | 247 +++++++++++++++++++++++++++++++++++++++
 python/setup.cfg         |   9 ++
 python/tests/flake8.sh   |   1 +
 python/tests/isort.sh    |   1 +
 python/tests/mypy.sh     |   1 +
 python/tests/pylint.sh   |   1 +
 6 files changed, 260 insertions(+)
 create mode 100644 python/scripts/mkvenv.py

diff --git a/python/scripts/mkvenv.py b/python/scripts/mkvenv.py
new file mode 100644
index 000000000000..a4534e41b52b
--- /dev/null
+++ b/python/scripts/mkvenv.py
@@ -0,0 +1,247 @@
+"""
+mkvenv - QEMU pyvenv bootstrapping utility
+
+usage: mkvenv [-h] command ...
+
+QEMU pyvenv bootstrapping utility
+
+options:
+  -h, --help  show this help message and exit
+
+Commands:
+  command     Description
+    create    create a venv
+
+--------------------------------------------------
+
+usage: mkvenv create [-h] target
+
+positional arguments:
+  target      Target directory to install virtual environment into.
+
+options:
+  -h, --help  show this help message and exit
+
+"""
+
+# Copyright (C) 2022-2023 Red Hat, Inc.
+#
+# Authors:
+#  John Snow <jsnow@redhat.com>
+#  Paolo Bonzini <pbonzini@redhat.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later. See the COPYING file in the top-level directory.
+
+import argparse
+import logging
+import os
+from pathlib import Path
+import subprocess
+import sys
+from types import SimpleNamespace
+from typing import Any, Optional, Union
+import venv
+
+
+# Do not add any mandatory dependencies from outside the stdlib:
+# This script *must* be usable standalone!
+
+DirType = Union[str, bytes, "os.PathLike[str]", "os.PathLike[bytes]"]
+logger = logging.getLogger("mkvenv")
+
+
+class Ouch(RuntimeError):
+    """An Exception class we can't confuse with a builtin."""
+
+
+class QemuEnvBuilder(venv.EnvBuilder):
+    """
+    An extension of venv.EnvBuilder for building QEMU's configure-time venv.
+
+    As of this commit, it does not yet do anything particularly
+    different than the standard venv-creation utility. The next several
+    commits will gradually change that in small commits that highlight
+    each feature individually.
+
+    Parameters for base class init:
+      - system_site_packages: bool = False
+      - clear: bool = False
+      - symlinks: bool = False
+      - upgrade: bool = False
+      - with_pip: bool = False
+      - prompt: Optional[str] = None
+      - upgrade_deps: bool = False             (Since 3.9)
+    """
+
+    def __init__(self, *args: Any, **kwargs: Any) -> None:
+        logger.debug("QemuEnvBuilder.__init__(...)")
+        super().__init__(*args, **kwargs)
+
+        # Make the context available post-creation:
+        self._context: Optional[SimpleNamespace] = None
+
+    def ensure_directories(self, env_dir: DirType) -> SimpleNamespace:
+        logger.debug("ensure_directories(env_dir=%s)", env_dir)
+        self._context = super().ensure_directories(env_dir)
+        return self._context
+
+    def get_value(self, field: str) -> str:
+        """
+        Get a string value from the context namespace after a call to build.
+
+        For valid field names, see:
+        https://docs.python.org/3/library/venv.html#venv.EnvBuilder.ensure_directories
+        """
+        ret = getattr(self._context, field)
+        assert isinstance(ret, str)
+        return ret
+
+
+def make_venv(  # pylint: disable=too-many-arguments
+    env_dir: Union[str, Path],
+    system_site_packages: bool = False,
+    clear: bool = True,
+    symlinks: Optional[bool] = None,
+    with_pip: bool = True,
+) -> None:
+    """
+    Create a venv using `QemuEnvBuilder`.
+
+    This is analogous to the `venv.create` module-level convenience
+    function that is part of the Python stdblib, except it uses
+    `QemuEnvBuilder` instead.
+
+    :param env_dir: The directory to create/install to.
+    :param system_site_packages:
+        Allow inheriting packages from the system installation.
+    :param clear: When True, fully remove any prior venv and files.
+    :param symlinks:
+        Whether to use symlinks to the target interpreter or not. If
+        left unspecified, it will use symlinks except on Windows to
+        match behavior with the "venv" CLI tool.
+    :param with_pip:
+        Whether to install "pip" binaries or not.
+    """
+    logger.debug(
+        "%s: make_venv(env_dir=%s, system_site_packages=%s, "
+        "clear=%s, symlinks=%s, with_pip=%s)",
+        __file__,
+        str(env_dir),
+        system_site_packages,
+        clear,
+        symlinks,
+        with_pip,
+    )
+
+    if symlinks is None:
+        # Default behavior of standard venv CLI
+        symlinks = os.name != "nt"
+
+    builder = QemuEnvBuilder(
+        system_site_packages=system_site_packages,
+        clear=clear,
+        symlinks=symlinks,
+        with_pip=with_pip,
+    )
+
+    style = "non-isolated" if builder.system_site_packages else "isolated"
+    print(
+        f"mkvenv: Creating {style} virtual environment"
+        f" at '{str(env_dir)}'",
+        file=sys.stderr,
+    )
+
+    try:
+        logger.debug("Invoking builder.create()")
+        try:
+            builder.create(str(env_dir))
+        except SystemExit as exc:
+            # Some versions of the venv module raise SystemExit; *nasty*!
+            # We want the exception that prompted it. It might be a subprocess
+            # error that has output we *really* want to see.
+            logger.debug("Intercepted SystemExit from EnvBuilder.create()")
+            raise exc.__cause__ or exc.__context__ or exc
+        logger.debug("builder.create() finished")
+    except subprocess.CalledProcessError as exc:
+        logger.error("mkvenv subprocess failed:")
+        logger.error("cmd: %s", exc.cmd)
+        logger.error("returncode: %d", exc.returncode)
+
+        def _stringify(data: Union[str, bytes]) -> str:
+            if isinstance(data, bytes):
+                return data.decode()
+            return data
+
+        lines = []
+        if exc.stdout:
+            lines.append("========== stdout ==========")
+            lines.append(_stringify(exc.stdout))
+            lines.append("============================")
+        if exc.stderr:
+            lines.append("========== stderr ==========")
+            lines.append(_stringify(exc.stderr))
+            lines.append("============================")
+        if lines:
+            logger.error(os.linesep.join(lines))
+
+        raise Ouch("VENV creation subprocess failed.") from exc
+
+    # print the python executable to stdout for configure.
+    print(builder.get_value("env_exe"))
+
+
+def _add_create_subcommand(subparsers: Any) -> None:
+    subparser = subparsers.add_parser("create", help="create a venv")
+    subparser.add_argument(
+        "target",
+        type=str,
+        action="store",
+        help="Target directory to install virtual environment into.",
+    )
+
+
+def main() -> int:
+    """CLI interface to make_qemu_venv. See module docstring."""
+    if os.environ.get("DEBUG") or os.environ.get("GITLAB_CI"):
+        # You're welcome.
+        logging.basicConfig(level=logging.DEBUG)
+    elif os.environ.get("V"):
+        logging.basicConfig(level=logging.INFO)
+
+    parser = argparse.ArgumentParser(
+        prog="mkvenv",
+        description="QEMU pyvenv bootstrapping utility",
+    )
+    subparsers = parser.add_subparsers(
+        title="Commands",
+        dest="command",
+        metavar="command",
+        help="Description",
+    )
+
+    _add_create_subcommand(subparsers)
+
+    args = parser.parse_args()
+    try:
+        if args.command == "create":
+            make_venv(
+                args.target,
+                system_site_packages=True,
+                clear=True,
+            )
+        logger.debug("mkvenv.py %s: exiting", args.command)
+    except Ouch as exc:
+        print("\n*** Ouch! ***\n", file=sys.stderr)
+        print(str(exc), "\n\n", file=sys.stderr)
+        return 1
+    except SystemExit:
+        raise
+    except:  # pylint: disable=bare-except
+        logger.exception("mkvenv did not complete successfully:")
+        return 2
+    return 0
+
+
+if __name__ == "__main__":
+    sys.exit(main())
diff --git a/python/setup.cfg b/python/setup.cfg
index 3f36502954e4..5b25f810fa8b 100644
--- a/python/setup.cfg
+++ b/python/setup.cfg
@@ -103,6 +103,15 @@ ignore_missing_imports = True
 [mypy-pygments]
 ignore_missing_imports = True
 
+[mypy-importlib.metadata]
+ignore_missing_imports = True
+
+[mypy-importlib_metadata]
+ignore_missing_imports = True
+
+[mypy-pkg_resources]
+ignore_missing_imports = True
+
 [pylint.messages control]
 # Disable the message, report, category or checker with the given id(s). You
 # can either give multiple identifiers separated by comma (,) or put this
diff --git a/python/tests/flake8.sh b/python/tests/flake8.sh
index 1cd7d40fad8b..e0136996453f 100755
--- a/python/tests/flake8.sh
+++ b/python/tests/flake8.sh
@@ -1,2 +1,3 @@
 #!/bin/sh -e
 python3 -m flake8 qemu/
+python3 -m flake8 scripts/
diff --git a/python/tests/isort.sh b/python/tests/isort.sh
index 4480405bfb09..66c2f7df0fdc 100755
--- a/python/tests/isort.sh
+++ b/python/tests/isort.sh
@@ -1,2 +1,3 @@
 #!/bin/sh -e
 python3 -m isort -c qemu/
+python3 -m isort -c scripts/
diff --git a/python/tests/mypy.sh b/python/tests/mypy.sh
index 5f980f563bb7..a33a3f58ab39 100755
--- a/python/tests/mypy.sh
+++ b/python/tests/mypy.sh
@@ -1,2 +1,3 @@
 #!/bin/sh -e
 python3 -m mypy -p qemu
+python3 -m mypy scripts/
diff --git a/python/tests/pylint.sh b/python/tests/pylint.sh
index 03d64705a107..2b68da90df76 100755
--- a/python/tests/pylint.sh
+++ b/python/tests/pylint.sh
@@ -1,3 +1,4 @@
 #!/bin/sh -e
 # See commit message for environment variable explainer.
 SETUPTOOLS_USE_DISTUTILS=stdlib python3 -m pylint qemu/
+SETUPTOOLS_USE_DISTUTILS=stdlib python3 -m pylint scripts/
-- 
2.40.1



