Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C601791555
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 11:58:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd6Kw-0005tq-J4; Mon, 04 Sep 2023 05:57:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qd6Ks-0005t3-4u
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 05:57:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qd6Kp-0006mZ-Et
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 05:57:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693821450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tF/gOVBt9Bwzbb1VjYdSOIoeRtnKVGuWbCyNBO/28Qg=;
 b=edEvwJAd5As7HHF3GsPKLhp8TCEkA8gTv79Q8s/gOH4alys1NTjq4CRLK8GkPddHdXo8LX
 32AzQ6YEhSEUm142xgPTJ5JRAi/ayCPucA9lYJNpJt7Lgz1p81a8tc9dULYOESwf+Tk1p6
 DHCgSMtLIKenDshd+3ONB1NPyIfFbYc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-uku_EiTyNjq-CnNhiDMV7g-1; Mon, 04 Sep 2023 05:57:28 -0400
X-MC-Unique: uku_EiTyNjq-CnNhiDMV7g-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3fbdf341934so7778655e9.3
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 02:57:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693821447; x=1694426247;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tF/gOVBt9Bwzbb1VjYdSOIoeRtnKVGuWbCyNBO/28Qg=;
 b=KA3eW197hZLsYOjF83rP26mJglJ9krg9kGUBy128V2qgFgWMlqxpJVUhOURxOC3VCU
 r1MBdFhMO6QXHh/SYnNblEw0nveBxyfhB02yWGOZ9gDGQrIs7ZIe0mQEghV5ika16MHS
 veGsZnISeCZtNIESajkOdWJoC9SkiO+2w8/xFxRbZ1nPAJFnltv8gFJmZgtk4IL3E2fV
 T/bEjn5MHtWv61/1KkAbbYXJNZpg+wh6Vl46RDLz+UVdeBViDwcuZar/S+84Rdtyi7Yh
 U63BV+9Lk2gM8TQ/+upqO5jAQQpMd2oMHOp5Q9TSUALz5shrOtfUFHKCKH6uPrYlQhLO
 0cig==
X-Gm-Message-State: AOJu0Yy5NWU5Fbylw1dGWQSz2Ez0mSbuYd0Wz8BZucjiYDIPht2pudW8
 +ZK4NVe1FwQjwDdqzcbPKB777ItjieI2cAMe3uwKTR5+BvBEfMfXsmJdsSma1/6MutMj/pvieKC
 +1eDsfYQ9j5ll1eTKJ26M8m9c+pQWzZeBBwM6zZGAkfFnoW6+9U2Btac0J/YOwyI/5sjNDjv72R
 8=
X-Received: by 2002:a7b:ca57:0:b0:3f9:b244:c294 with SMTP id
 m23-20020a7bca57000000b003f9b244c294mr7271843wml.35.1693821446882; 
 Mon, 04 Sep 2023 02:57:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGh6+rWFSZKRpUgAjcTCukmMTQUfRKtrrHmjxIEEk7zo/5nt5lpsshPg288090bqW1rSzJFRA==
X-Received: by 2002:a7b:ca57:0:b0:3f9:b244:c294 with SMTP id
 m23-20020a7bca57000000b003f9b244c294mr7271827wml.35.1693821446613; 
 Mon, 04 Sep 2023 02:57:26 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 m24-20020adfa3d8000000b0031753073abcsm9524307wrb.36.2023.09.04.02.57.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Sep 2023 02:57:25 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, armbru@redhat.com, peter.maydell@linaro.org,
 berrange@redhat.com
Subject: [RFC PATCH 2/3] mkvenv: assume presence of importlib.metadata
Date: Mon,  4 Sep 2023 11:57:19 +0200
Message-ID: <20230904095720.154738-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230904095720.154738-1-pbonzini@redhat.com>
References: <20230904095720.154738-1-pbonzini@redhat.com>
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


