Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6004770AA9F
	for <lists+qemu-devel@lfdr.de>; Sat, 20 May 2023 21:08:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0Rug-0007FB-ES; Sat, 20 May 2023 15:06:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q0Rue-0007Eq-Q4
 for qemu-devel@nongnu.org; Sat, 20 May 2023 15:06:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q0Ruc-00007I-Fm
 for qemu-devel@nongnu.org; Sat, 20 May 2023 15:06:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684609601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qlgzse35/U7pJowc/LVIUcU4eodAmYKoY3TprbNdG0Y=;
 b=f3oBINTDMTRF6ISd7KMnj7LxxtsLfDqqcxfICXfemfEQYC5l2M+SlgcT6z11RGV0AMNLC3
 4GeY92Q6l+/Sbg4++JD0OrqwIpfg9u2iokA8/zW13A3lXXc3M2cIPNV/pRU43USBk0yW2s
 IFd+UKssEYrCezjDd+PyoucVUgmOa9A=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-5HFXBGuzMnWPgl2ZitATmQ-1; Sat, 20 May 2023 15:06:39 -0400
X-MC-Unique: 5HFXBGuzMnWPgl2ZitATmQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-94a34a0b75eso449228066b.1
 for <qemu-devel@nongnu.org>; Sat, 20 May 2023 12:06:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684609598; x=1687201598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qlgzse35/U7pJowc/LVIUcU4eodAmYKoY3TprbNdG0Y=;
 b=H763vCzP1ibjsFEZ04kh+w2CMV00ldUdv9J5r/BsQJJZ9Loq/NeX7Hh2IY4yqDOBKh
 TAEExVirG+koQj7G9IMaTNEyo5fNx5KMzKYYuhbNLEkcVibj5jkmDPWyo80w4QcwbdCf
 573pRPpzKsxIxki0ZqDUCBuHnvizmeqi4o2O+NQ4Cf5QlayIDrAPgheC+mRrAxx2VLs5
 6S0BGrTZzxe7/pu+i1qcaz62ADdSXsyPIo66z6R8icwO19NwDGSTQCMLpgVbgDXcVdRB
 E+gy6dmNvybVmpWI+pffGtdJCR4/syscCFA1959t2z7dVNs5Urvms0Hzf0Ftowj6udjE
 YJsg==
X-Gm-Message-State: AC+VfDz/VtkTBZtmBKqwjh1EOXIYHlI8v5LhrVuFyOC29I0DfzdXZ1Z1
 hZy1HlWsBLCAubNPBJTlUkmpwkm8ZkEqK0Fg2a9RLwzrKLjFKbJAFqzYNSXMOkTWTfXAsU0Kuf/
 uZ9doX/u3ww3PgjwBAPzjBJoje7sRv5qAMpOL5dPr4g3emi5n37QYhrIDCVArqZu3lEazCWtGCL
 w=
X-Received: by 2002:a17:907:6288:b0:96a:316f:8abf with SMTP id
 nd8-20020a170907628800b0096a316f8abfmr5747220ejc.20.1684609597941; 
 Sat, 20 May 2023 12:06:37 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Dfhq1GB4O3ltKQYP0Ijh7yV/1DzMx4wpSgZS021nMfOlZT4Kp19UZN7Y4EpqiDG3iPRcDZw==
X-Received: by 2002:a17:907:6288:b0:96a:316f:8abf with SMTP id
 nd8-20020a170907628800b0096a316f8abfmr5747209ejc.20.1684609597537; 
 Sat, 20 May 2023 12:06:37 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 mj14-20020a170906af8e00b009659fa6eeddsm1059894ejb.196.2023.05.20.12.06.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 May 2023 12:06:36 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/7] mkvenv: replace distlib.database with
 importlib.metadata/pkg_resources
Date: Sat, 20 May 2023 21:06:27 +0200
Message-Id: <20230520190632.7491-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230520190632.7491-1-pbonzini@redhat.com>
References: <20230520190632.7491-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 LONGWORDS=2.035, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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


