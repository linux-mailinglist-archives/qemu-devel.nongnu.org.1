Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 671DD775677
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 11:33:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTfVn-0004Y4-My; Wed, 09 Aug 2023 05:29:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qTfVg-0004Wc-RE
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 05:29:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qTfVe-0003a2-Sm
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 05:29:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691573381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qpPW00DDQ8RN8lC6WhZ2fk5frp42Ch9Oi3lrik8jOF8=;
 b=AJCk1W4u5Ep+OkgQQqy+MplKdrmP8CkU3X/Z2yXqdcbIAYJYrETan2lUCF5gQfgosZ8hOp
 NumOSRcBdpMi0z/2Hgvz1+H9Piz8kOFXBE/mi7NeNZ30sj5cppUWI/SNQhIzK+IvvkNjuJ
 ULnz13qHBYLouustiV+YYxljYzohPG8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-rcvNNJQMODODMbKd1hvmsg-1; Wed, 09 Aug 2023 05:29:40 -0400
X-MC-Unique: rcvNNJQMODODMbKd1hvmsg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3fe1dadb5d2so37097645e9.1
 for <qemu-devel@nongnu.org>; Wed, 09 Aug 2023 02:29:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691573378; x=1692178178;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qpPW00DDQ8RN8lC6WhZ2fk5frp42Ch9Oi3lrik8jOF8=;
 b=PPn+o8njKenCNRfL/Yt2GHahe2+ShfE907A5DLWJSaCk60CSVpA2kD9Fneau5AQJ3Q
 xV6Zf5/LMh2KB7Y8eRU36TzxXk8yPYO+Oy0XIINqmZ1NRzVYq021e5fRJNBVIQLnh2Y9
 xCbpKV/sbs/7OQFoJIHyOsBs6zElK1erPsNf5KZBSyedmlocq1sIDRW2k7LV7SyXRPDM
 s8EHHYEp0fVFSxjlYjZbGURm7medRMlEMLAZHyEZokZz0ZW0SCE5shICMkClneDxfhqS
 fucN3M/By3EggdXDBK77pBJjZibWWVGlp/dZOkQrj75j0UYU1E4WMDhr7l+CFFr5swZC
 Z37g==
X-Gm-Message-State: AOJu0Yw6f+znzw1ZFqgRvqejxbxmdxduEYFN1lgoaNZ1yAQpRzwMJzJJ
 vhoMfO+Q+AT0JCKcD07pzJRe389culEiTROtrpEM2djjJtlGrzK1rZIebgqzNIPAPAsYDc7m/MO
 IGwLscBgLJY1pkUuQR6EagPjls+AqAGhH4girgAcsSjgL1qGfufmdgNrH3l5LUJVlnPDUwowiTE
 4=
X-Received: by 2002:a7b:c3d1:0:b0:3fb:b34f:6cd6 with SMTP id
 t17-20020a7bc3d1000000b003fbb34f6cd6mr1673863wmj.41.1691573378531; 
 Wed, 09 Aug 2023 02:29:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuOvX24WdbBQi/YDfm410oqXWpr1QRrjRAtNNKANCIaV40uQdtnOmgfDRlf5LmdaHiFM1q3g==
X-Received: by 2002:a7b:c3d1:0:b0:3fb:b34f:6cd6 with SMTP id
 t17-20020a7bc3d1000000b003fbb34f6cd6mr1673845wmj.41.1691573378079; 
 Wed, 09 Aug 2023 02:29:38 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 y24-20020a05600c365800b003fe2b081661sm1382014wmq.30.2023.08.09.02.29.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Aug 2023 02:29:37 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com
Subject: [PATCH 2/9] python: mkvenv: introduce TOML-like representation of
 dependencies
Date: Wed,  9 Aug 2023 11:29:26 +0200
Message-ID: <20230809092933.761524-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809092933.761524-1-pbonzini@redhat.com>
References: <20230809092933.761524-1-pbonzini@redhat.com>
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

We would like to place all Python dependencies in the same file, so that
we can add more information without having long and complex command lines.
The plan is to have a TOML file with one entry per package, for example

  [avocado]
  avocado-framework = {
    accepted = "(>=88.1, <93.0)",
    installed = "88.1",
    canary = "avocado"
  }

Each TOML section will thus be a dictionary of dictionaries.  Modify
mkvenv.py's workhorse function, _do_ensure, to already operate on such
a data structure.  The "ensure" subcommand is modified to separate the
depspec into a name and a version part, and use the result (plus the
--diagnose argument) to build a dictionary for each command line argument.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 python/scripts/mkvenv.py | 77 +++++++++++++++++++++++++++++++---------
 1 file changed, 61 insertions(+), 16 deletions(-)

diff --git a/python/scripts/mkvenv.py b/python/scripts/mkvenv.py
index 399659b22f1..96f506d7e22 100644
--- a/python/scripts/mkvenv.py
+++ b/python/scripts/mkvenv.py
@@ -46,6 +46,9 @@
 
 """
 
+# The duplication between importlib and pkg_resources does not help
+# pylint: disable=too-many-lines
+
 # Copyright (C) 2022-2023 Red Hat, Inc.
 #
 # Authors:
@@ -69,6 +72,7 @@
 from types import SimpleNamespace
 from typing import (
     Any,
+    Dict,
     Iterator,
     Optional,
     Sequence,
@@ -786,43 +790,67 @@ def pip_install(
     )
 
 
+def _make_version_constraint(info: Dict[str, str], install: bool) -> str:
+    """
+    Construct the version constraint part of a PEP 508 dependency
+    specification (for example '>=0.61.5') from the accepted and
+    installed keys of the provided dictionary.
+
+    :param info: A dictionary corresponding to a TOML key-value list.
+    :param install: True generates install constraints, False generates
+        presence constraints
+    """
+    if install and "installed" in info:
+        return "==" + info["installed"]
+
+    dep_spec = info.get("accepted", "")
+    dep_spec = dep_spec.strip()
+    # Double check that they didn't just use a version number
+    if dep_spec and dep_spec[0] not in "!~><=(":
+        raise Ouch(
+            "invalid dependency specifier " + dep_spec + " in dependency file"
+        )
+
+    return dep_spec
+
+
 def _do_ensure(
-    dep_specs: Sequence[str],
+    group: Dict[str, Dict[str, str]],
     online: bool = False,
     wheels_dir: Optional[Union[str, Path]] = None,
-    prog: Optional[str] = None,
 ) -> Optional[Tuple[str, bool]]:
     """
-    Use pip to ensure we have the package specified by @dep_specs.
+    Use pip to ensure we have the packages specified in @group.
 
-    If the package is already installed, do nothing. If online and
+    If the packages are already installed, do nothing. If online and
     wheels_dir are both provided, prefer packages found in wheels_dir
     first before connecting to PyPI.
 
-    :param dep_specs:
-        PEP 508 dependency specifications. e.g. ['meson>=0.61.5'].
+    :param group: A dictionary of dictionaries, corresponding to a
+        section in a pythondeps.toml file.
     :param online: If True, fall back to PyPI.
     :param wheels_dir: If specified, search this path for packages.
     """
     absent = []
     present = []
     canary = None
-    for spec in dep_specs:
-        matcher = distlib.version.LegacyMatcher(spec)
-        ver = _get_version(matcher.name)
+    for name, info in group.items():
+        constraint = _make_version_constraint(info, False)
+        matcher = distlib.version.LegacyMatcher(name + constraint)
+        ver = _get_version(name)
         if (
             ver is None
             # Always pass installed package to pip, so that they can be
             # updated if the requested version changes
-            or not _is_system_package(matcher.name)
+            or not _is_system_package(name)
             or not matcher.match(distlib.version.LegacyVersion(ver))
         ):
-            absent.append(spec)
-            if spec == dep_specs[0]:
-                canary = prog
+            absent.append(name + _make_version_constraint(info, True))
+            if len(absent) == 1:
+                canary = info.get("canary", None)
         else:
-            logger.info("found %s %s", matcher.name, ver)
-            present.append(matcher.name)
+            logger.info("found %s %s", name, ver)
+            present.append(name)
 
     if present:
         generate_console_scripts(present)
@@ -875,7 +903,24 @@ def ensure(
     if not HAVE_DISTLIB:
         raise Ouch("a usable distlib could not be found, please install it")
 
-    result = _do_ensure(dep_specs, online, wheels_dir, prog)
+    # Convert the depspecs to a dictionary, as if they came
+    # from a section in a pythondeps.toml file
+    group: Dict[str, Dict[str, str]] = {}
+    for spec in dep_specs:
+        name = distlib.version.LegacyMatcher(spec).name
+        group[name] = {}
+
+        spec = spec.strip()
+        pos = len(name)
+        ver = spec[pos:].strip()
+        if ver:
+            group[name]["accepted"] = ver
+
+        if prog:
+            group[name]["canary"] = prog
+            prog = None
+
+    result = _do_ensure(group, online, wheels_dir)
     if result:
         # Well, that's not good.
         if result[1]:
-- 
2.41.0


