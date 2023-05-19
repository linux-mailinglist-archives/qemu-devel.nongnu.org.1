Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE1470919B
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 10:26:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzvQB-0004di-1J; Fri, 19 May 2023 04:25:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzvQ8-0004dI-KI
 for qemu-devel@nongnu.org; Fri, 19 May 2023 04:25:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzvQ4-0003I5-Ay
 for qemu-devel@nongnu.org; Fri, 19 May 2023 04:25:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684484698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=qlgzse35/U7pJowc/LVIUcU4eodAmYKoY3TprbNdG0Y=;
 b=bgWUbbNRE/Fgu+/6NyiDsJs29/qJhf6KRZxYUVwele2KIInHImcfV+bVJb1/tevs9qev1d
 8MsvtyhZoMzLEyj1jBalmZbyVqp+pwbOKEJtZs5SvCgnGdSOIkjhN4OMCBVxtX1i0SzsbI
 WFFUHsdvMTlFjUaNYMhu6s68Rn2gUbY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-2u2cxhn2P9qcTdSRi236ng-1; Fri, 19 May 2023 04:24:55 -0400
X-MC-Unique: 2u2cxhn2P9qcTdSRi236ng-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-50bffc723c5so3018343a12.1
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 01:24:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684484694; x=1687076694;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qlgzse35/U7pJowc/LVIUcU4eodAmYKoY3TprbNdG0Y=;
 b=SYxuF9ULie4q5tX7fsABtwLBV+vv3loVLoEZDEs+2Sj9zmuaZB87Yx9jwq84E5/cQ3
 WoVT2+YCIQeqhmd3nwteKd+GC4ImXa1pSnBNOxf32kB1sE2dYQ7+w9YgE5DWfjzo5LTv
 XiIgtF8UsSFbxL3EBM+KhNlc1PQMlGz/ygEp3U2dB5cfhtDVtag/BXGOFkGOoP6a27ND
 Jnv5dv+wZahiFtVeiMsqAgcKORq56w6CEFNy1hzMcDMbT+uAaLsXBF51Es9DI/icSJpr
 2oi7ZSWY3a2a44mo8EKu5OK2yZ6EMR57yaiFRTIigpPxuNqLjpIuozH6HYIiVYZ0MG9K
 6Maw==
X-Gm-Message-State: AC+VfDwSPRxQaUx/4787oQAcCxEjB0oOdorAonO4hl+RsQRLRKNLuL4E
 eZelCWsztl7R8kUoRCWy57NsMnmzMiDeXclDKZAoBkFtd58C1m7DSOjCrqgCUVGCTMOqo/ZEFEl
 WEvDcgvVX364zWY8VaifdfNT9w6qLbp4RhfXa8MekS8wwZ0INWu05IDRuUCiFTk53bkZ898h/3B
 g=
X-Received: by 2002:a05:6402:39a:b0:502:23a2:6739 with SMTP id
 o26-20020a056402039a00b0050223a26739mr953591edv.28.1684484694210; 
 Fri, 19 May 2023 01:24:54 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ52ztK/d/w1CkT3Iow1WjmihlF6+ywAI0yagGvsoW2MMQevmIn2EwHPrx+2PLnGa4995TOC0g==
X-Received: by 2002:a05:6402:39a:b0:502:23a2:6739 with SMTP id
 o26-20020a056402039a00b0050223a26739mr953578edv.28.1684484693810; 
 Fri, 19 May 2023 01:24:53 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 x23-20020aa7dad7000000b005067d089aafsm1399283eds.11.2023.05.19.01.24.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 May 2023 01:24:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com,
	hao.xiang@bytedance.com
Subject: [PATCH] mkvenv: replace distlib.database with
 importlib.metadata/pkg_resources
Date: Fri, 19 May 2023 10:24:52 +0200
Message-Id: <20230519082452.1101992-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 LONGWORDS=2.035, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

importlib.metadata is just as good as distlib.database and a bit more
battle-proven for "egg" based distributions, and in fact that is exactly
why mkvenv.py is not using distlib.database to find entry points: it
simply does not work for eggs.

The only disadvantage of importlib.metadata is that it is not available
by default before Python 3.8, so we need a fallback to pkg_resources
(again, just like for the case of finding entry points).  Do so to
fix issues where incorrect egg metadata results in a JSONDecodeError.

While at it, reuse the new _get_version function to diagnose an incorrect
version of the package even if importlib.metadata is not available.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 python/scripts/mkvenv.py | 113 ++++++++++++++++++++++-----------------
 python/setup.cfg         |   6 ---
 2 files changed, 65 insertions(+), 54 deletions(-)

diff --git a/python/scripts/mkvenv.py b/python/scripts/mkvenv.py
index 8c036c019aaf..6c78a2c1120e 100644
--- a/python/scripts/mkvenv.py
+++ b/python/scripts/mkvenv.py
@@ -76,7 +76,6 @@
     Union,
 )
 import venv
-import warnings
 
 
 # Try to load distlib, with a fallback to pip's vendored version.
@@ -84,7 +83,6 @@
 # outside the venv or before a potential call to ensurepip in checkpip().
 HAVE_DISTLIB = True
 try:
-    import distlib.database
     import distlib.scripts
     import distlib.version
 except ImportError:
@@ -92,7 +90,6 @@
         # Reach into pip's cookie jar.  pylint and flake8 don't understand
         # that these imports will be used via distlib.xxx.
         from pip._vendor import distlib
-        import pip._vendor.distlib.database  # noqa, pylint: disable=unused-import
         import pip._vendor.distlib.scripts  # noqa, pylint: disable=unused-import
         import pip._vendor.distlib.version  # noqa, pylint: disable=unused-import
     except ImportError:
@@ -556,6 +553,57 @@ def pkgname_from_depspec(dep_spec: str) -> str:
     return match.group(0)
 
 
+def _get_version_importlib(package: str) -> Optional[str]:
+    # pylint: disable=import-outside-toplevel
+    # pylint: disable=no-name-in-module
+    # pylint: disable=import-error
+    try:
+        # First preference: Python 3.8+ stdlib
+        from importlib.metadata import (  # type: ignore
+            PackageNotFoundError,
+            distribution,
+        )
+    except ImportError as exc:
+        logger.debug("%s", str(exc))
+        # Second preference: Commonly available PyPI backport
+        from importlib_metadata import (  # type: ignore
+            PackageNotFoundError,
+            distribution,
+        )
+
+    try:
+        return str(distribution(package).version)
+    except PackageNotFoundError:
+        return None
+
+
+def _get_version_pkg_resources(package: str) -> Optional[str]:
+    # pylint: disable=import-outside-toplevel
+    # Bundled with setuptools; has a good chance of being available.
+    import pkg_resources
+
+    try:
+        return str(pkg_resources.get_distribution(package).version)
+    except pkg_resources.DistributionNotFound:
+        return None
+
+
+def _get_version(package: str) -> Optional[str]:
+    try:
+        return _get_version_importlib(package)
+    except ImportError as exc:
+        logger.debug("%s", str(exc))
+
+    try:
+        return _get_version_pkg_resources(package)
+    except ImportError as exc:
+        logger.debug("%s", str(exc))
+        raise Ouch(
+            "Neither importlib.metadata nor pkg_resources found. "
+            "Use Python 3.8+, or install importlib-metadata or setuptools."
+        ) from exc
+
+
 def diagnose(
     dep_spec: str,
     online: bool,
@@ -581,26 +629,7 @@ def diagnose(
     bad = False
 
     pkg_name = pkgname_from_depspec(dep_spec)
-    pkg_version = None
-
-    has_importlib = False
-    try:
-        # Python 3.8+ stdlib
-        # pylint: disable=import-outside-toplevel
-        # pylint: disable=no-name-in-module
-        # pylint: disable=import-error
-        from importlib.metadata import (  # type: ignore
-            PackageNotFoundError,
-            version,
-        )
-
-        has_importlib = True
-        try:
-            pkg_version = version(pkg_name)
-        except PackageNotFoundError:
-            pass
-    except ModuleNotFoundError:
-        pass
+    pkg_version = _get_version(pkg_name)
 
     lines = []
 
@@ -609,14 +638,9 @@ def diagnose(
             f"Python package '{pkg_name}' version '{pkg_version}' was found,"
             " but isn't suitable."
         )
-    elif has_importlib:
-        lines.append(
-            f"Python package '{pkg_name}' was not found nor installed."
-        )
     else:
         lines.append(
-            f"Python package '{pkg_name}' is either not found or"
-            " not a suitable version."
+            f"Python package '{pkg_name}' was not found nor installed."
         )
 
     if wheels_dir:
@@ -711,21 +735,18 @@ def _do_ensure(
     :param online: If True, fall back to PyPI.
     :param wheels_dir: If specified, search this path for packages.
     """
-    with warnings.catch_warnings():
-        warnings.filterwarnings(
-            "ignore", category=UserWarning, module="distlib"
-        )
-        dist_path = distlib.database.DistributionPath(include_egg=True)
-        absent = []
-        present = []
-        for spec in dep_specs:
-            matcher = distlib.version.LegacyMatcher(spec)
-            dist = dist_path.get_distribution(matcher.name)
-            if dist is None or not matcher.match(dist.version):
-                absent.append(spec)
-            else:
-                logger.info("found %s", dist)
-                present.append(matcher.name)
+    absent = []
+    present = []
+    for spec in dep_specs:
+        matcher = distlib.version.LegacyMatcher(spec)
+        ver = _get_version(matcher.name)
+        if ver is None or not matcher.match(
+            distlib.version.LegacyVersion(ver)
+        ):
+            absent.append(spec)
+        else:
+            logger.info("found %s %s", matcher.name, ver)
+            present.append(matcher.name)
 
     if present:
         generate_console_scripts(present)
@@ -843,10 +864,6 @@ def main() -> int:
         if os.environ.get("V"):
             logging.basicConfig(level=logging.INFO)
 
-        # These are incredibly noisy even for V=1
-        logging.getLogger("distlib.metadata").addFilter(lambda record: False)
-        logging.getLogger("distlib.database").addFilter(lambda record: False)
-
     parser = argparse.ArgumentParser(
         prog="mkvenv",
         description="QEMU pyvenv bootstrapping utility",
diff --git a/python/setup.cfg b/python/setup.cfg
index 5abb7d30ad42..42f0b0be07d1 100644
--- a/python/setup.cfg
+++ b/python/setup.cfg
@@ -115,9 +115,6 @@ ignore_missing_imports = True
 [mypy-distlib]
 ignore_missing_imports = True
 
-[mypy-distlib.database]
-ignore_missing_imports = True
-
 [mypy-distlib.scripts]
 ignore_missing_imports = True
 
@@ -127,9 +124,6 @@ ignore_missing_imports = True
 [mypy-pip._vendor.distlib]
 ignore_missing_imports = True
 
-[mypy-pip._vendor.distlib.database]
-ignore_missing_imports = True
-
 [mypy-pip._vendor.distlib.scripts]
 ignore_missing_imports = True
 
-- 
2.40.1


