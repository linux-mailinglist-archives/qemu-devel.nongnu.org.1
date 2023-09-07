Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 882B0797294
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 15:08:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeEdn-00049I-MQ; Thu, 07 Sep 2023 09:01:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEdg-0003cB-JP
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:01:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEdc-0007RK-Io
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:01:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694091695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tF/gOVBt9Bwzbb1VjYdSOIoeRtnKVGuWbCyNBO/28Qg=;
 b=GIogjwsu03p3Crp6sbP8Oz8npp7t0y1AUt7ahDD7K5IhaXdLPbRe2w25yUYulNV0GXkOyV
 9PavX21v3D+StiJaVEWbRe/WqLtQK24AWoNfjgNG446BRv3/MLgeNwv6bt/YLXJqanETdF
 v/IPHuhTcc+G3r13qJpLsv8MJ6+H33M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-CjjcaP9ZO8ugQEAYEzylxg-1; Thu, 07 Sep 2023 09:01:34 -0400
X-MC-Unique: CjjcaP9ZO8ugQEAYEzylxg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-401b8089339so6418315e9.3
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 06:01:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694091689; x=1694696489;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tF/gOVBt9Bwzbb1VjYdSOIoeRtnKVGuWbCyNBO/28Qg=;
 b=BQTUo5zFkUqbGwR0EFYRfxCE/9Eo+j3qqlWQvXdiv/bifdONAHwk59W8ROm65W8dTk
 jXvwpWJEMdPu8dXjCV0Em6+tlMYSKVC/aGYYpQcR5Ef8ihSXXVWNNTNcjVNZKIQ90iM3
 Swi/w033IK93aLumLhe2PNYbgsJSvNMV7YyB0gX0xxb3MCzIh5mgc4r/lznqp8mOurD3
 9Ee0nnb5I7bDrqvcWlM6fqoR4qTWaoS4GheILzUdCdBkRWTIgbFMz+8h8EgdY1zFih63
 Om0jQ/48tZarXC8UtE5e71jfZQTF9tA8etJYPJWhSU80DzM1lLJeZre2bTdG/0B0C2iJ
 Rb1A==
X-Gm-Message-State: AOJu0YzCIklMgS6T6baLjyqL8A71TlJpK2ZdQryKol/iMKpkS3tz4AHk
 8suGc0wLns53Reo9XfwkviRDBtZqV0TZ1vrFuGN6OVbBlciy3B+pF6kVMLJ8cRpWHa5s9HTwHK3
 YdINF97B6zUSijiCpVAEVxnPnbsxDWuY34KOUUeAsACBbDSykpKp4ohyY4E0KUJSfb5pWrDuO32
 c=
X-Received: by 2002:a1c:4c0f:0:b0:401:b705:ebe6 with SMTP id
 z15-20020a1c4c0f000000b00401b705ebe6mr4611869wmf.32.1694091688944; 
 Thu, 07 Sep 2023 06:01:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/+DB+4d6ruqdHo7tq/RGWWhegJuvqa7JHa2bVgQyXwnMTGEyIfYxbkpr1BEaXyp12DYrkeg==
X-Received: by 2002:a1c:4c0f:0:b0:401:b705:ebe6 with SMTP id
 z15-20020a1c4c0f000000b00401b705ebe6mr4611841wmf.32.1694091688397; 
 Thu, 07 Sep 2023 06:01:28 -0700 (PDT)
Received: from [192.168.1.174] ([151.48.237.81])
 by smtp.gmail.com with ESMTPSA id
 t14-20020a05600c198e00b003fefcbe7fa8sm2488653wmq.28.2023.09.07.06.01.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 06:01:27 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 35/51] mkvenv: assume presence of importlib.metadata
Date: Thu,  7 Sep 2023 14:59:44 +0200
Message-ID: <20230907130004.500601-36-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230907130004.500601-1-pbonzini@redhat.com>
References: <20230907130004.500601-1-pbonzini@redhat.com>
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

importlib.metadata is included in Python 3.8, so there is no
need to fallback to either importlib-metadata or pkgresources
when generating console script shims.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 python/scripts/mkvenv.py | 197 ++++++---------------------------------
 python/setup.cfg         |   9 --
 2 files changed, 28 insertions(+), 178 deletions(-)

diff --git a/python/scripts/mkvenv.py b/python/scripts/mkvenv.py
index 57a24948031..6797e12e349 100644
--- a/python/scripts/mkvenv.py
+++ b/python/scripts/mkvenv.py
@@ -61,7 +61,6 @@
 
 """
 
-# The duplication between importlib and pkg_resources does not help
 # pylint: disable=too-many-lines
 
 # Copyright (C) 2022-2023 Red Hat, Inc.
@@ -74,6 +73,13 @@
 # later. See the COPYING file in the top-level directory.
 
 import argparse
+from importlib.metadata import (
+    Distribution,
+    EntryPoint,
+    PackageNotFoundError,
+    distribution,
+    version,
+)
 from importlib.util import find_spec
 import logging
 import os
@@ -428,25 +434,7 @@ def _stringify(data: Union[str, bytes]) -> str:
     print(builder.get_value("env_exe"))
 
 
-def _gen_importlib(packages: Sequence[str]) -> Iterator[str]:
-    # pylint: disable=import-outside-toplevel
-    # pylint: disable=no-name-in-module
-    # pylint: disable=import-error
-    try:
-        # First preference: Python 3.8+ stdlib
-        from importlib.metadata import (  # type: ignore
-            EntryPoint,
-            PackageNotFoundError,
-            distribution,
-        )
-    except ImportError as exc:
-        logger.debug("%s", str(exc))
-        # Second preference: Commonly available PyPI backport
-        from importlib_metadata import (  # type: ignore
-            EntryPoint,
-            PackageNotFoundError,
-            distribution,
-        )
+def _get_entry_points(packages: Sequence[str]) -> Iterator[str]:
 
     def _generator() -> Iterator[str]:
         for package in packages:
@@ -468,24 +456,6 @@ def _generator() -> Iterator[str]:
     return _generator()
 
 
-def _gen_pkg_resources(packages: Sequence[str]) -> Iterator[str]:
-    # pylint: disable=import-outside-toplevel
-    # Bundled with setuptools; has a good chance of being available.
-    import pkg_resources
-
-    def _generator() -> Iterator[str]:
-        for package in packages:
-            try:
-                eps = pkg_resources.get_entry_map(package, "console_scripts")
-            except pkg_resources.DistributionNotFound:
-                continue
-
-            for entry_point in eps.values():
-                yield str(entry_point)
-
-    return _generator()
-
-
 def generate_console_scripts(
     packages: Sequence[str],
     python_path: Optional[str] = None,
@@ -510,30 +480,11 @@ def generate_console_scripts(
     if not packages:
         return
 
-    def _get_entry_points() -> Iterator[str]:
-        """Python 3.7 compatibility shim for iterating entry points."""
-        # Python 3.8+, or Python 3.7 with importlib_metadata installed.
-        try:
-            return _gen_importlib(packages)
-        except ImportError as exc:
-            logger.debug("%s", str(exc))
-
-        # Python 3.7 with setuptools installed.
-        try:
-            return _gen_pkg_resources(packages)
-        except ImportError as exc:
-            logger.debug("%s", str(exc))
-            raise Ouch(
-                "Neither importlib.metadata nor pkg_resources found, "
-                "can't generate console script shims.\n"
-                "Use Python 3.8+, or install importlib-metadata or setuptools."
-            ) from exc
-
     maker = distlib.scripts.ScriptMaker(None, bin_path)
     maker.variants = {""}
     maker.clobber = False
 
-    for entry_point in _get_entry_points():
+    for entry_point in _get_entry_points(packages):
         for filename in maker.make(entry_point):
             logger.debug("wrote console_script '%s'", filename)
 
@@ -587,57 +538,6 @@ def pkgname_from_depspec(dep_spec: str) -> str:
     return match.group(0)
 
 
-def _get_path_importlib(package: str) -> Optional[str]:
-    # pylint: disable=import-outside-toplevel
-    # pylint: disable=no-name-in-module
-    # pylint: disable=import-error
-    try:
-        # First preference: Python 3.8+ stdlib
-        from importlib.metadata import (  # type: ignore
-            PackageNotFoundError,
-            distribution,
-        )
-    except ImportError as exc:
-        logger.debug("%s", str(exc))
-        # Second preference: Commonly available PyPI backport
-        from importlib_metadata import (  # type: ignore
-            PackageNotFoundError,
-            distribution,
-        )
-
-    try:
-        return str(distribution(package).locate_file("."))
-    except PackageNotFoundError:
-        return None
-
-
-def _get_path_pkg_resources(package: str) -> Optional[str]:
-    # pylint: disable=import-outside-toplevel
-    # Bundled with setuptools; has a good chance of being available.
-    import pkg_resources
-
-    try:
-        return str(pkg_resources.get_distribution(package).location)
-    except pkg_resources.DistributionNotFound:
-        return None
-
-
-def _get_path(package: str) -> Optional[str]:
-    try:
-        return _get_path_importlib(package)
-    except ImportError as exc:
-        logger.debug("%s", str(exc))
-
-    try:
-        return _get_path_pkg_resources(package)
-    except ImportError as exc:
-        logger.debug("%s", str(exc))
-        raise Ouch(
-            "Neither importlib.metadata nor pkg_resources found. "
-            "Use Python 3.8+, or install importlib-metadata or setuptools."
-        ) from exc
-
-
 def _path_is_prefix(prefix: Optional[str], path: str) -> bool:
     try:
         return (
@@ -647,65 +547,14 @@ def _path_is_prefix(prefix: Optional[str], path: str) -> bool:
         return False
 
 
-def _is_system_package(package: str) -> bool:
-    path = _get_path(package)
-    return path is not None and not (
+def _is_system_package(dist: Distribution) -> bool:
+    path = str(dist.locate_file("."))
+    return not (
         _path_is_prefix(sysconfig.get_path("purelib"), path)
         or _path_is_prefix(sysconfig.get_path("platlib"), path)
     )
 
 
-def _get_version_importlib(package: str) -> Optional[str]:
-    # pylint: disable=import-outside-toplevel
-    # pylint: disable=no-name-in-module
-    # pylint: disable=import-error
-    try:
-        # First preference: Python 3.8+ stdlib
-        from importlib.metadata import (  # type: ignore
-            PackageNotFoundError,
-            distribution,
-        )
-    except ImportError as exc:
-        logger.debug("%s", str(exc))
-        # Second preference: Commonly available PyPI backport
-        from importlib_metadata import (  # type: ignore
-            PackageNotFoundError,
-            distribution,
-        )
-
-    try:
-        return str(distribution(package).version)
-    except PackageNotFoundError:
-        return None
-
-
-def _get_version_pkg_resources(package: str) -> Optional[str]:
-    # pylint: disable=import-outside-toplevel
-    # Bundled with setuptools; has a good chance of being available.
-    import pkg_resources
-
-    try:
-        return str(pkg_resources.get_distribution(package).version)
-    except pkg_resources.DistributionNotFound:
-        return None
-
-
-def _get_version(package: str) -> Optional[str]:
-    try:
-        return _get_version_importlib(package)
-    except ImportError as exc:
-        logger.debug("%s", str(exc))
-
-    try:
-        return _get_version_pkg_resources(package)
-    except ImportError as exc:
-        logger.debug("%s", str(exc))
-        raise Ouch(
-            "Neither importlib.metadata nor pkg_resources found. "
-            "Use Python 3.8+, or install importlib-metadata or setuptools."
-        ) from exc
-
-
 def diagnose(
     dep_spec: str,
     online: bool,
@@ -731,7 +580,11 @@ def diagnose(
     bad = False
 
     pkg_name = pkgname_from_depspec(dep_spec)
-    pkg_version = _get_version(pkg_name)
+    pkg_version: Optional[str] = None
+    try:
+        pkg_version = version(pkg_name)
+    except PackageNotFoundError:
+        pass
 
     lines = []
 
@@ -868,19 +721,25 @@ def _do_ensure(
         constraint = _make_version_constraint(info, False)
         matcher = distlib.version.LegacyMatcher(name + constraint)
         print(f"mkvenv: checking for {matcher}", file=sys.stderr)
-        ver = _get_version(name)
+
+        dist: Optional[Distribution] = None
+        try:
+            dist = distribution(matcher.name)
+        except PackageNotFoundError:
+            pass
+
         if (
-            ver is None
+            dist is None
             # Always pass installed package to pip, so that they can be
             # updated if the requested version changes
-            or not _is_system_package(name)
-            or not matcher.match(distlib.version.LegacyVersion(ver))
+            or not _is_system_package(dist)
+            or not matcher.match(distlib.version.LegacyVersion(dist.version))
         ):
             absent.append(name + _make_version_constraint(info, True))
             if len(absent) == 1:
                 canary = info.get("canary", None)
         else:
-            logger.info("found %s %s", name, ver)
+            logger.info("found %s %s", name, dist.version)
             present.append(name)
 
     if present:
diff --git a/python/setup.cfg b/python/setup.cfg
index f6d2d8a1362..8c67dce4579 100644
--- a/python/setup.cfg
+++ b/python/setup.cfg
@@ -108,15 +108,6 @@ ignore_missing_imports = True
 [mypy-pygments]
 ignore_missing_imports = True
 
-[mypy-importlib.metadata]
-ignore_missing_imports = True
-
-[mypy-importlib_metadata]
-ignore_missing_imports = True
-
-[mypy-pkg_resources]
-ignore_missing_imports = True
-
 [mypy-distlib]
 ignore_missing_imports = True
 
-- 
2.41.0


