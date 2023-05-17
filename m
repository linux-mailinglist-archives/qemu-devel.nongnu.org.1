Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A06D2706FFD
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 19:51:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzLEY-000059-Lk; Wed, 17 May 2023 13:46:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLE2-0007YR-VU
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:46:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLE0-0004GB-70
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:46:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684345567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lkzMnyG/yk3jOYlnZDLrqP+HbKCXIYSIMttPCZPZl5g=;
 b=KxWZUFFKAMbKT/VJQiZMvKq/D6x5XpSYMpSGlsEwl1+R1PlGsCexeAWyWj4qlI3BlU9gyY
 lp4+ePG3tcq1FQe63Az3mAcSL6SSqSJrgedJWaTwsA9GN8zLF00TONjqynWr4sxjuarqYi
 S8OaVWVX0JqHI5a8TNkHz4majT1PX5c=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-55jvs1LZMdC-0tWj-u7XNA-1; Wed, 17 May 2023 13:46:05 -0400
X-MC-Unique: 55jvs1LZMdC-0tWj-u7XNA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f426ffdbc6so6545865e9.3
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 10:46:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684345563; x=1686937563;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lkzMnyG/yk3jOYlnZDLrqP+HbKCXIYSIMttPCZPZl5g=;
 b=jHF8G9n9qDruXfV28NUxphMmMnE9nDbALJsSLY+9BMttiLTiKJQt4b2hs3Vz1eCAaS
 e27YHOYl/cOqDc/cXlD4UK8ek3dnOsSs6zFYzRCF3KQ7ymJo485SGp5fZS+xMdePUyi2
 QXSe6y1HuD+7zGpoBmT0f4nwjUjpLh+beVwtpNuxThlZU/Q7RU7wPJqKDJRIvWkiHnhR
 v++8YUuCcCzH44jpiQTr6D4+X4nopFy7lROTZ3EClVeqSRtCmv3AnH5WnL7+iNZG1XtN
 wgpSMKnSwV4jJPSsd0gYNAvcSPik5J4hR70LKsoYkCpMxlWFTJ9bzkzl7Peeh/4ioAAl
 hyPg==
X-Gm-Message-State: AC+VfDypEuzlohmhzQvdncdWFaMN3KqeBAMjZHJTS9aP6/ZHM1Ve//6D
 1gLZ1gsxlwcqslFoyQRMgkq8j4YekueFatvr/93CYJTvRl59dGtxPxtvJ/lnkHlQgzUxQYqvDAB
 f18Ci+NxErZQQ9I4z+J0ukQn/UD9wf8tzn1Cu/BdfLdaNwUI+74ds2Lc/7buNS0Sh6e95AMjP90
 U=
X-Received: by 2002:adf:df0b:0:b0:306:8f5b:1b49 with SMTP id
 y11-20020adfdf0b000000b003068f5b1b49mr1422304wrl.47.1684345563253; 
 Wed, 17 May 2023 10:46:03 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6lF0UgXidq71/eH8Qx9VS0MtYRlQxdm6VlDro4ydt2eoGgFo5fEacE9PwVsyHAh4ZGosCN1A==
X-Received: by 2002:adf:df0b:0:b0:306:8f5b:1b49 with SMTP id
 y11-20020adfdf0b000000b003068f5b1b49mr1422282wrl.47.1684345562812; 
 Wed, 17 May 2023 10:46:02 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 m9-20020a7bca49000000b003f3157988f8sm2902494wml.26.2023.05.17.10.46.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 10:46:01 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>
Subject: [PULL 24/68] mkvenv: add --diagnose option to explain "ensure"
 failures
Date: Wed, 17 May 2023 19:44:36 +0200
Message-Id: <20230517174520.887405-25-pbonzini@redhat.com>
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

This is a routine that is designed to print some usable info for human
beings back out to the terminal if/when "mkvenv ensure" fails to locate
or install a package during configure time, such as meson or sphinx.

Since we are requiring that "meson" and "sphinx" are installed to the
same Python environment as QEMU is configured to build with, this can
produce some surprising failures when things are mismatched. This method
is here to try and ease that sting by offering some actionable
diagnosis.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-Id: <20230511035435.734312-8-jsnow@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 python/scripts/mkvenv.py | 170 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 169 insertions(+), 1 deletion(-)

diff --git a/python/scripts/mkvenv.py b/python/scripts/mkvenv.py
index f6c4f37f84dd..2dbbc7020b48 100644
--- a/python/scripts/mkvenv.py
+++ b/python/scripts/mkvenv.py
@@ -51,6 +51,8 @@
 import logging
 import os
 from pathlib import Path
+import re
+import shutil
 import site
 import subprocess
 import sys
@@ -60,6 +62,7 @@
     Any,
     Optional,
     Sequence,
+    Tuple,
     Union,
 )
 import venv
@@ -331,6 +334,128 @@ def _stringify(data: Union[str, bytes]) -> str:
     print(builder.get_value("env_exe"))
 
 
+def pkgname_from_depspec(dep_spec: str) -> str:
+    """
+    Parse package name out of a PEP-508 depspec.
+
+    See https://peps.python.org/pep-0508/#names
+    """
+    match = re.match(
+        r"^([A-Z0-9]([A-Z0-9._-]*[A-Z0-9])?)", dep_spec, re.IGNORECASE
+    )
+    if not match:
+        raise ValueError(
+            f"dep_spec '{dep_spec}'"
+            " does not appear to contain a valid package name"
+        )
+    return match.group(0)
+
+
+def diagnose(
+    dep_spec: str,
+    online: bool,
+    wheels_dir: Optional[Union[str, Path]],
+    prog: Optional[str],
+) -> Tuple[str, bool]:
+    """
+    Offer a summary to the user as to why a package failed to be installed.
+
+    :param dep_spec: The package we tried to ensure, e.g. 'meson>=0.61.5'
+    :param online: Did we allow PyPI access?
+    :param prog:
+        Optionally, a shell program name that can be used as a
+        bellwether to detect if this program is installed elsewhere on
+        the system. This is used to offer advice when a program is
+        detected for a different python version.
+    :param wheels_dir:
+        Optionally, a directory that was searched for vendored packages.
+    """
+    # pylint: disable=too-many-branches
+
+    # Some errors are not particularly serious
+    bad = False
+
+    pkg_name = pkgname_from_depspec(dep_spec)
+    pkg_version = None
+
+    has_importlib = False
+    try:
+        # Python 3.8+ stdlib
+        # pylint: disable=import-outside-toplevel
+        # pylint: disable=no-name-in-module
+        # pylint: disable=import-error
+        from importlib.metadata import (  # type: ignore
+            PackageNotFoundError,
+            version,
+        )
+
+        has_importlib = True
+        try:
+            pkg_version = version(pkg_name)
+        except PackageNotFoundError:
+            pass
+    except ModuleNotFoundError:
+        pass
+
+    lines = []
+
+    if pkg_version:
+        lines.append(
+            f"Python package '{pkg_name}' version '{pkg_version}' was found,"
+            " but isn't suitable."
+        )
+    elif has_importlib:
+        lines.append(
+            f"Python package '{pkg_name}' was not found nor installed."
+        )
+    else:
+        lines.append(
+            f"Python package '{pkg_name}' is either not found or"
+            " not a suitable version."
+        )
+
+    if wheels_dir:
+        lines.append(
+            "No suitable version found in, or failed to install from"
+            f" '{wheels_dir}'."
+        )
+        bad = True
+
+    if online:
+        lines.append("A suitable version could not be obtained from PyPI.")
+        bad = True
+    else:
+        lines.append(
+            "mkvenv was configured to operate offline and did not check PyPI."
+        )
+
+    if prog and not pkg_version:
+        which = shutil.which(prog)
+        if which:
+            if sys.base_prefix in site.PREFIXES:
+                pypath = Path(sys.executable).resolve()
+                lines.append(
+                    f"'{prog}' was detected on your system at '{which}', "
+                    f"but the Python package '{pkg_name}' was not found by "
+                    f"this Python interpreter ('{pypath}'). "
+                    f"Typically this means that '{prog}' has been installed "
+                    "against a different Python interpreter on your system."
+                )
+            else:
+                lines.append(
+                    f"'{prog}' was detected on your system at '{which}', "
+                    "but the build is using an isolated virtual environment."
+                )
+            bad = True
+
+    lines = [f" • {line}" for line in lines]
+    if bad:
+        lines.insert(0, f"Could not provide build dependency '{dep_spec}':")
+    else:
+        lines.insert(0, f"'{dep_spec}' not found:")
+    return os.linesep.join(lines), bad
+
+
 def pip_install(
     args: Sequence[str],
     online: bool = False,
@@ -364,7 +489,7 @@ def pip_install(
     )
 
 
-def ensure(
+def _do_ensure(
     dep_specs: Sequence[str],
     online: bool = False,
     wheels_dir: Optional[Union[str, Path]] = None,
@@ -402,6 +527,39 @@ def ensure(
         pip_install(args=absent, online=online, wheels_dir=wheels_dir)
 
 
+def ensure(
+    dep_specs: Sequence[str],
+    online: bool = False,
+    wheels_dir: Optional[Union[str, Path]] = None,
+    prog: Optional[str] = None,
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
+    :param prog:
+        If specified, use this program name for error diagnostics that will
+        be presented to the user. e.g., 'sphinx-build' can be used as a
+        bellwether for the presence of 'sphinx'.
+    """
+    print(f"mkvenv: checking for {', '.join(dep_specs)}", file=sys.stderr)
+    try:
+        _do_ensure(dep_specs, online, wheels_dir)
+    except subprocess.CalledProcessError as exc:
+        # Well, that's not good.
+        msg, bad = diagnose(dep_specs[0], online, wheels_dir, prog)
+        if bad:
+            raise Ouch(msg) from exc
+        raise SystemExit(f"\n{msg}\n\n") from exc
+
+
 def _add_create_subcommand(subparsers: Any) -> None:
     subparser = subparsers.add_parser("create", help="create a venv")
     subparser.add_argument(
@@ -427,6 +585,15 @@ def _add_ensure_subcommand(subparsers: Any) -> None:
         action="store",
         help="Path to vendored packages where we may install from.",
     )
+    subparser.add_argument(
+        "--diagnose",
+        type=str,
+        action="store",
+        help=(
+            "Name of a shell utility to use for "
+            "diagnostics if this command fails."
+        ),
+    )
     subparser.add_argument(
         "dep_specs",
         type=str,
@@ -476,6 +643,7 @@ def main() -> int:
                 dep_specs=args.dep_specs,
                 online=args.online,
                 wheels_dir=args.dir,
+                prog=args.diagnose,
             )
         logger.debug("mkvenv.py %s: exiting", args.command)
     except Ouch as exc:
-- 
2.40.1


