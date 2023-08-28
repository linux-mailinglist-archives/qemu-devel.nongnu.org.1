Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1557D78AC63
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 12:40:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaZeO-0003Mn-HJ; Mon, 28 Aug 2023 06:39:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qaZeL-0003MD-H4
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 06:39:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qaZeI-00054S-Ts
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 06:39:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693219150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7ttKvQ0lKAlC3ovyH0DF8EadfOZPfXae774xoVXz+zo=;
 b=iPcfzkKV5OUtp6LGhGrFNP3OtcM+EqqKG2BYmgOm/Icwm4j4JcmPB2L2wYyHSyU33lJHs9
 ELmO/h0QiQ1qVKLQsXnfQO+4/lM/wa9DpZ9VDE8h2uf7qTsY6SOomHj0E72UtCTreXuu7n
 nvJTjTdwRXB+tB8gdBCGYu9JSIB/YLg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-Fh0Ai_HZNCSniIlu5iLS_w-1; Mon, 28 Aug 2023 06:39:08 -0400
X-MC-Unique: Fh0Ai_HZNCSniIlu5iLS_w-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-31aef4011cfso2242647f8f.2
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 03:39:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693219147; x=1693823947;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7ttKvQ0lKAlC3ovyH0DF8EadfOZPfXae774xoVXz+zo=;
 b=IUkZr0mbuScJ9O/+segBxzGmR4qEsoveRSyVGZLaXS7QEXaut7KP8fsZdru9VlxtGl
 sESZMBV+sa9VDkEcdP0MU/3L45N9naXJQSUbuorLThzCxCGvq6iPxPjigPL1H6uVJPgp
 BtSpl5t10fIlinPu1nFVw3dTXhtLrhQAXM8hzClDDTz9hKcec+TEce+TNU+fK9AeTOAO
 DBh5ESTslzZojnzc/X/iZbB5KWhERB7YVoU6gcmrvatRLDWclCBFSYJDTfRrGvvAFuP4
 MXV56ZgF13KBfUei0UQUEvUQG1Als/1Pv3znt6Fr8PGccHPGNLI5mqcZQo0uFSI5Yr7f
 x4KA==
X-Gm-Message-State: AOJu0Ywzhrhxt/O4sKDRw6+w7e5if9h7+6AUdvB94WJMAh55izGuJs6x
 /EiQ3pk/9UxIgklRQBHaS9DNhQF9u7rhxTcaJV3DHzMzDWwQEWY27DQiS4M2kw8p7S5WYrzky2Y
 Q/EGbXgbD6FlvOzaWJx5sWuT2uEzIv6cHT0Fn2Pnbdq36z8+q9xaGU3w/XEQQCjqRgPwqu2sOyR
 A=
X-Received: by 2002:a5d:6145:0:b0:319:8c35:378 with SMTP id
 y5-20020a5d6145000000b003198c350378mr18495615wrt.44.1693219146940; 
 Mon, 28 Aug 2023 03:39:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmOxhXOczgNRaTjjNbiJzH+ptYRYplEhwYM7SEb8MObkB51B+iKqpB7aZxyhMSxpxRSmQEjA==
X-Received: by 2002:a5d:6145:0:b0:319:8c35:378 with SMTP id
 y5-20020a5d6145000000b003198c350378mr18495600wrt.44.1693219146393; 
 Mon, 28 Aug 2023 03:39:06 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 k1-20020adfe3c1000000b0031c6e1ea4c7sm10100074wrm.90.2023.08.28.03.39.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 03:39:05 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/14] python: mkvenv: add ensuregroup command
Date: Mon, 28 Aug 2023 12:38:44 +0200
Message-ID: <20230828103856.46031-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828103856.46031-1-pbonzini@redhat.com>
References: <20230828103856.46031-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
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

Introduce a new subcommand that retrieves the packages to be installed
from a TOML file. This allows being more flexible in using the system
version of a package, while at the same time using a known-good version
when installing the package.  This is important for packages that
sometimes have backwards-incompatible changes or that depend on
specific versions of their dependencies.

Compared to JSON, TOML is more human readable and easier to edit.  A
parser is available in 3.11 but also available as a small (12k) package
for older versions, tomli.  While tomli is bundled with pip, this is only
true of recent versions of pip.  Of all the supported OSes pretty much
only FreeBSD has a recent enough version of pip while staying on Python
<3.11.  So we cannot use the same trick that is in place for distlib.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 python/scripts/mkvenv.py | 126 ++++++++++++++++++++++++++++++++++++++-
 python/setup.cfg         |   6 ++
 pythondeps.toml          |  17 ++++++
 3 files changed, 148 insertions(+), 1 deletion(-)
 create mode 100644 pythondeps.toml

diff --git a/python/scripts/mkvenv.py b/python/scripts/mkvenv.py
index 96f506d7e22..02bcd9a8c92 100644
--- a/python/scripts/mkvenv.py
+++ b/python/scripts/mkvenv.py
@@ -14,6 +14,8 @@
     post_init
               post-venv initialization
     ensure    Ensure that the specified package is installed.
+    ensuregroup
+              Ensure that the specified package group is installed.
 
 --------------------------------------------------
 
@@ -44,6 +46,19 @@
   --online    Install packages from PyPI, if necessary.
   --dir DIR   Path to vendored packages where we may install from.
 
+--------------------------------------------------
+
+usage: mkvenv ensuregroup [-h] [--online] [--dir DIR] file group...
+
+positional arguments:
+  file        pointer to a TOML file
+  group       section name in the TOML file
+
+options:
+  -h, --help  show this help message and exit
+  --online    Install packages from PyPI, if necessary.
+  --dir DIR   Path to vendored packages where we may install from.
+
 """
 
 # The duplication between importlib and pkg_resources does not help
@@ -99,6 +114,18 @@
     except ImportError:
         HAVE_DISTLIB = False
 
+# Try to load tomllib, with a fallback to tomli.
+# HAVE_TOMLLIB is checked below, just-in-time, so that mkvenv does not fail
+# outside the venv or before a potential call to ensurepip in checkpip().
+HAVE_TOMLLIB = True
+try:
+    import tomllib
+except ImportError:
+    try:
+        import tomli as tomllib
+    except ImportError:
+        HAVE_TOMLLIB = False
+
 # Do not add any mandatory dependencies from outside the stdlib:
 # This script *must* be usable standalone!
 
@@ -837,6 +864,7 @@ def _do_ensure(
     for name, info in group.items():
         constraint = _make_version_constraint(info, False)
         matcher = distlib.version.LegacyMatcher(name + constraint)
+        print(f"mkvenv: checking for {matcher}", file=sys.stderr)
         ver = _get_version(name)
         if (
             ver is None
@@ -898,7 +926,6 @@ def ensure(
         be presented to the user. e.g., 'sphinx-build' can be used as a
         bellwether for the presence of 'sphinx'.
     """
-    print(f"mkvenv: checking for {', '.join(dep_specs)}", file=sys.stderr)
 
     if not HAVE_DISTLIB:
         raise Ouch("a usable distlib could not be found, please install it")
@@ -928,6 +955,64 @@ def ensure(
         raise SystemExit(f"\n{result[0]}\n\n")
 
 
+def _parse_groups(file: str) -> Dict[str, Dict[str, Any]]:
+    if not HAVE_TOMLLIB:
+        if sys.version_info < (3, 11):
+            raise Ouch("found no usable tomli, please install it")
+
+        raise Ouch(
+            "Python >=3.11 does not have tomllib... what have you done!?"
+        )
+
+    try:
+        # Use loads() to support both tomli v1.2.x (Ubuntu 22.04,
+        # Debian bullseye-backports) and v2.0.x
+        with open(file, "r", encoding="ascii") as depfile:
+            contents = depfile.read()
+            return tomllib.loads(contents)  # type: ignore
+    except tomllib.TOMLDecodeError as exc:
+        raise Ouch(f"parsing {file} failed: {exc}") from exc
+
+
+def ensure_group(
+    file: str,
+    groups: Sequence[str],
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
+
+    if not HAVE_DISTLIB:
+        raise Ouch("found no usable distlib, please install it")
+
+    parsed_deps = _parse_groups(file)
+
+    to_install: Dict[str, Dict[str, str]] = {}
+    for group in groups:
+        try:
+            to_install.update(parsed_deps[group])
+        except KeyError as exc:
+            raise Ouch(f"group {group} not defined") from exc
+
+    result = _do_ensure(to_install, online, wheels_dir)
+    if result:
+        # Well, that's not good.
+        if result[1]:
+            raise Ouch(result[0])
+        raise SystemExit(f"\n{result[0]}\n\n")
+
+
 def post_venv_setup() -> None:
     """
     This is intended to be run *inside the venv* after it is created.
@@ -955,6 +1040,37 @@ def _add_post_init_subcommand(subparsers: Any) -> None:
     subparsers.add_parser("post_init", help="post-venv initialization")
 
 
+def _add_ensuregroup_subcommand(subparsers: Any) -> None:
+    subparser = subparsers.add_parser(
+        "ensuregroup",
+        help="Ensure that the specified package group is installed.",
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
+        "file",
+        type=str,
+        action="store",
+        help=("Path to a TOML file describing package groups"),
+    )
+    subparser.add_argument(
+        "group",
+        type=str,
+        action="store",
+        help="One or more package group names",
+        nargs="+",
+    )
+
+
 def _add_ensure_subcommand(subparsers: Any) -> None:
     subparser = subparsers.add_parser(
         "ensure", help="Ensure that the specified package is installed."
@@ -1012,6 +1128,7 @@ def main() -> int:
     _add_create_subcommand(subparsers)
     _add_post_init_subcommand(subparsers)
     _add_ensure_subcommand(subparsers)
+    _add_ensuregroup_subcommand(subparsers)
 
     args = parser.parse_args()
     try:
@@ -1030,6 +1147,13 @@ def main() -> int:
                 wheels_dir=args.dir,
                 prog=args.diagnose,
             )
+        if args.command == "ensuregroup":
+            ensure_group(
+                file=args.file,
+                groups=args.group,
+                online=args.online,
+                wheels_dir=args.dir,
+            )
         logger.debug("mkvenv.py %s: exiting", args.command)
     except Ouch as exc:
         print("\n*** Ouch! ***\n", file=sys.stderr)
diff --git a/python/setup.cfg b/python/setup.cfg
index 5d7e95f5d24..e74b58a8c24 100644
--- a/python/setup.cfg
+++ b/python/setup.cfg
@@ -94,6 +94,12 @@ allow_subclassing_any = True
 [mypy-fuse]
 ignore_missing_imports = True
 
+[mypy-tomli]
+ignore_missing_imports = True
+
+[mypy-tomllib]
+ignore_missing_imports = True
+
 [mypy-urwid]
 ignore_missing_imports = True
 
diff --git a/pythondeps.toml b/pythondeps.toml
new file mode 100644
index 00000000000..362f63ff2c9
--- /dev/null
+++ b/pythondeps.toml
@@ -0,0 +1,17 @@
+# This file describes Python package requirements to be
+# installed in the pyvenv Python virtual environment.
+#
+# Packages are placed in groups, which are installed using
+# the ensuregroup subcommand of python/scripts/mkvenv.py.
+# Each group forms a TOML section and each entry in the
+# section is a TOML key-value list describing a package.
+# All fields are optional; valid fields are:
+#
+# - accepted: accepted versions when using a system package
+# - installed: fixed version to install in the virtual environment
+#              if a system package is not found; if not specified,
+#              the minimum and maximum
+# - canary: if specified, use this program name to present more
+#           precise error diagnostics to the user.  For example,
+#           'sphinx-build' can be used as a bellwether for the
+#           presence of 'sphinx' in the system.
-- 
2.41.0


