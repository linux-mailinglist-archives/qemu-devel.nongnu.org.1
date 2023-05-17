Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE50970701C
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 19:55:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzLED-0008ED-Qf; Wed, 17 May 2023 13:46:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLE0-0007PT-F4
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:46:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLDy-0004FZ-Ev
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:46:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684345565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3gHJKq6jYQjX4YhOcV7zRqLE5WmNW1w8pnBwgnMBv+M=;
 b=f6hyxeoRawX3X3Uh62PrBhUfPQykNoazp8AKdKa+5NAwOEh6zb9zq+9oqGIlxLlszsZ1Wl
 40NsHwv4cKxWfcswTY0w8DuvFbmXbYo2k/l0VgHyhfXtffTjNPmrncNzz1VaqPZskaf8kp
 gt0uC/v83WNiyXGBGBKMe7hHAqaOUKY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-UNIW7RMiM5G4qfhdsSHY6A-1; Wed, 17 May 2023 13:46:04 -0400
X-MC-Unique: UNIW7RMiM5G4qfhdsSHY6A-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f42b36733aso4438195e9.3
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 10:46:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684345561; x=1686937561;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3gHJKq6jYQjX4YhOcV7zRqLE5WmNW1w8pnBwgnMBv+M=;
 b=cO8g4mny6Gxw4ZnwyuCxamY0bGH0UP1eKjTGHbFlhtiv9MwfhFeEPJDSMhEAP+0qjJ
 B4d2Eii+OJIfDc5TD/zmil+UA1MiDKrqNWuRlJxS8ARDbeuV/vTsX6QMyHjrXsX2KhxR
 nyDzwGT3yBvFktF7HChxXk1G/kWWFrGVPVru3GAs8vpfve3kqL7sZEY6HZliq1C3X3te
 ay3a4aFOz00UL+0ib4iJieM39oW8eXCpeDjJQ8Hck0fihTnGJjyF6fpOomYXiVMMGDX0
 Vv/Jxoi75yzFRg8CHjB0upeCHpZPpJx/6sTATR7wUhDBV2fL/vOKGs4ZmpfH8zWu6q17
 7E1g==
X-Gm-Message-State: AC+VfDwtTpHvM2zMWHzw2LIl4EyDEGZRnK3/YdhcAAXNd1+16/CwvgWv
 OC69WrE+0b714Lf4rcxf7PusH6FGFTOl9kceixpuChLnFtJrV2Ak0ZPPJdl0eALO1rG3WO+To8y
 kC/87KKOjzEacsmb5+YFnHyiielMm0A4i8ElKBOKDkhegAcFXsI5UG9nAnZ8CgaUuWAhAMqW7Fk
 k=
X-Received: by 2002:a05:600c:22ca:b0:3f4:2158:289b with SMTP id
 10-20020a05600c22ca00b003f42158289bmr27581622wmg.18.1684345561588; 
 Wed, 17 May 2023 10:46:01 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4v9WkxxR46+kwPIueTZk7CL+iQ5bPiFAeLmN/jHpdMKpz9pv0bJsXe/6ZcEKF/IRq0x7VLmg==
X-Received: by 2002:a05:600c:22ca:b0:3f4:2158:289b with SMTP id
 10-20020a05600c22ca00b003f42158289bmr27581604wmg.18.1684345561043; 
 Wed, 17 May 2023 10:46:01 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 o14-20020a5d58ce000000b0030629536e64sm3384478wrf.30.2023.05.17.10.45.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 10:46:00 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>
Subject: [PULL 23/68] mkvenv: add ensure subcommand
Date: Wed, 17 May 2023 19:44:35 +0200
Message-Id: <20230517174520.887405-24-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230517174520.887405-1-pbonzini@redhat.com>
References: <20230517174520.887405-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
index 1c1dd89a9afd..f6c4f37f84dd 100644
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


