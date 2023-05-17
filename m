Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E572707065
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 20:04:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzLGb-00041f-1W; Wed, 17 May 2023 13:48:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLE3-0007Zy-HS
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:46:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLE1-0004GR-LX
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:46:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684345568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/8sa5ey1iXBczVQw05fbQpg967ju52FxIa+kQUUZh3o=;
 b=aBk/qPg7JO/xo5CeaTG1NiTdGPwFYJDyJ3jJCz9LXg2y2C+lEFUKqX+YgmWlwbzq/fLumY
 9hHdj7fQvSloEnabDH5VGc+Vu3JhUvAdqByX/I4gV1wbT4Oc8eQF1g5nEnr39rwJfBC73v
 WQz3acJjayxsCJxV5DycWNz+/OcPE78=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-olZbirinOU6JqH6WuqwEVA-1; Wed, 17 May 2023 13:46:07 -0400
X-MC-Unique: olZbirinOU6JqH6WuqwEVA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f4fb0193c6so4462735e9.1
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 10:46:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684345565; x=1686937565;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/8sa5ey1iXBczVQw05fbQpg967ju52FxIa+kQUUZh3o=;
 b=J5Panmc6WgDlE5QdTZLZCUVt7PTiHQ2SU+Elm1yuhA+Vm397KdKoUB3mvrKKpieBEp
 HTfxt4DdwA97C58H+CQ3/3SV5ICVz0ElOPwxb/W618AKnsvwCxteos3nKHaJQ3twlOOQ
 IDq7mHE06X3QDdbyrSRn7n04ZmQcaxqSdVR50Dary6aN/4Z/qDbFuO++s1am27QMpjHf
 IcWK9pgNQqRuU/uuYXCrFJJ+tqqtvOjr4Yjb9eksKbtiCed/OQ7f+LMFfbpmYq5N0HZw
 JjdCKCm5UYkihr/8np5StHbEmV/Zpo1MCjrF+prX1/lFIyst69IbZS47iv//n6gb4hxm
 BY1w==
X-Gm-Message-State: AC+VfDzSWQeD1UYl+guICNRfG+ZO0kcAgQ9OtgWPdqc+gAQefILLUnHJ
 53OifrimdJWoRmi+ehXoNwQlww0TJxHJxCVz1EaApzcIosfDg7OLdU1kGaFHfDFILWi2dUddUni
 6WJDXKLSqwvGRrCTFe708oocgkcFLTJ5fQWLyjqWGfVUqCnN59srRLl5mgQjs1elyVZpftl9aDP
 0=
X-Received: by 2002:a1c:cc16:0:b0:3f4:24c8:f7c6 with SMTP id
 h22-20020a1ccc16000000b003f424c8f7c6mr23619261wmb.16.1684345564784; 
 Wed, 17 May 2023 10:46:04 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7OIEHteI3zSreRs4HyMRs08pQN8prg5X39/R3S+aZBS55uDoNpt4s2dUr+tH510AQgvyKTJg==
X-Received: by 2002:a1c:cc16:0:b0:3f4:24c8:f7c6 with SMTP id
 h22-20020a1ccc16000000b003f424c8f7c6mr23619245wmb.16.1684345564462; 
 Wed, 17 May 2023 10:46:04 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 c16-20020a7bc850000000b003f42d3111b8sm2895163wml.30.2023.05.17.10.46.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 10:46:03 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>
Subject: [PULL 25/68] mkvenv: add console script entry point generation
Date: Wed, 17 May 2023 19:44:37 +0200
Message-Id: <20230517174520.887405-26-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230517174520.887405-1-pbonzini@redhat.com>
References: <20230517174520.887405-1-pbonzini@redhat.com>
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

When creating a virtual environment that inherits system packages,
script entry points (like "meson", "sphinx-build", etc) are not
re-generated with the correct shebang. When you are *inside* of the
venv, this is not a problem, but if you are *outside* of it, you will
not have a script that engages the virtual environment appropriately.

Add a mechanism that generates new entry points for pre-existing
packages so that we can use these scripts to run "meson",
"sphinx-build", "pip", unambiguously inside the venv.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
Message-Id: <20230511035435.734312-9-jsnow@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 python/scripts/mkvenv.py | 114 +++++++++++++++++++++++++++++++++++++++
 python/setup.cfg         |   3 ++
 2 files changed, 117 insertions(+)

diff --git a/python/scripts/mkvenv.py b/python/scripts/mkvenv.py
index 2dbbc7020b48..f17c3d3606ba 100644
--- a/python/scripts/mkvenv.py
+++ b/python/scripts/mkvenv.py
@@ -60,6 +60,7 @@
 from types import SimpleNamespace
 from typing import (
     Any,
+    Iterator,
     Optional,
     Sequence,
     Tuple,
@@ -69,6 +70,7 @@
 import warnings
 
 import distlib.database
+import distlib.scripts
 import distlib.version
 
 
@@ -334,6 +336,113 @@ def _stringify(data: Union[str, bytes]) -> str:
     print(builder.get_value("env_exe"))
 
 
+def _gen_importlib(packages: Sequence[str]) -> Iterator[str]:
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
+    def _generator() -> Iterator[str]:
+        for package in packages:
+            try:
+                entry_points = distribution(package).entry_points
+            except PackageNotFoundError:
+                continue
+
+            # The EntryPoints type is only available in 3.10+,
+            # treat this as a vanilla list and filter it ourselves.
+            entry_points = filter(
+                lambda ep: ep.group == "console_scripts", entry_points
+            )
+
+            for entry_point in entry_points:
+                yield f"{entry_point.name} = {entry_point.value}"
+
+    return _generator()
+
+
+def _gen_pkg_resources(packages: Sequence[str]) -> Iterator[str]:
+    # pylint: disable=import-outside-toplevel
+    # Bundled with setuptools; has a good chance of being available.
+    import pkg_resources
+
+    def _generator() -> Iterator[str]:
+        for package in packages:
+            try:
+                eps = pkg_resources.get_entry_map(package, "console_scripts")
+            except pkg_resources.DistributionNotFound:
+                continue
+
+            for entry_point in eps.values():
+                yield str(entry_point)
+
+    return _generator()
+
+
+def generate_console_scripts(
+    packages: Sequence[str],
+    python_path: Optional[str] = None,
+    bin_path: Optional[str] = None,
+) -> None:
+    """
+    Generate script shims for console_script entry points in @packages.
+    """
+    if python_path is None:
+        python_path = sys.executable
+    if bin_path is None:
+        bin_path = sysconfig.get_path("scripts")
+        assert bin_path is not None
+
+    logger.debug(
+        "generate_console_scripts(packages=%s, python_path=%s, bin_path=%s)",
+        packages,
+        python_path,
+        bin_path,
+    )
+
+    if not packages:
+        return
+
+    def _get_entry_points() -> Iterator[str]:
+        """Python 3.7 compatibility shim for iterating entry points."""
+        # Python 3.8+, or Python 3.7 with importlib_metadata installed.
+        try:
+            return _gen_importlib(packages)
+        except ImportError as exc:
+            logger.debug("%s", str(exc))
+
+        # Python 3.7 with setuptools installed.
+        try:
+            return _gen_pkg_resources(packages)
+        except ImportError as exc:
+            logger.debug("%s", str(exc))
+            raise Ouch(
+                "Neither importlib.metadata nor pkg_resources found, "
+                "can't generate console script shims.\n"
+                "Use Python 3.8+, or install importlib-metadata or setuptools."
+            ) from exc
+
+    maker = distlib.scripts.ScriptMaker(None, bin_path)
+    maker.variants = {""}
+    maker.clobber = False
+
+    for entry_point in _get_entry_points():
+        for filename in maker.make(entry_point):
+            logger.debug("wrote console_script '%s'", filename)
+
+
 def pkgname_from_depspec(dep_spec: str) -> str:
     """
     Parse package name out of a PEP-508 depspec.
@@ -512,6 +621,7 @@ def _do_ensure(
         )
         dist_path = distlib.database.DistributionPath(include_egg=True)
         absent = []
+        present = []
         for spec in dep_specs:
             matcher = distlib.version.LegacyMatcher(spec)
             dist = dist_path.get_distribution(matcher.name)
@@ -519,6 +629,10 @@ def _do_ensure(
                 absent.append(spec)
             else:
                 logger.info("found %s", dist)
+                present.append(matcher.name)
+
+    if present:
+        generate_console_scripts(present)
 
     if absent:
         # Some packages are missing or aren't a suitable version,
diff --git a/python/setup.cfg b/python/setup.cfg
index d680374b2950..826a2771ba5d 100644
--- a/python/setup.cfg
+++ b/python/setup.cfg
@@ -119,6 +119,9 @@ ignore_missing_imports = True
 [mypy-distlib.database]
 ignore_missing_imports = True
 
+[mypy-distlib.scripts]
+ignore_missing_imports = True
+
 [mypy-distlib.version]
 ignore_missing_imports = True
 
-- 
2.40.1


