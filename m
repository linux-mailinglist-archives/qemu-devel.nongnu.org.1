Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E60E78AC65
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 12:40:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaZeM-0003MH-GF; Mon, 28 Aug 2023 06:39:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qaZeJ-0003LP-J4
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 06:39:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qaZeH-00054A-6c
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 06:39:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693219148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qpPW00DDQ8RN8lC6WhZ2fk5frp42Ch9Oi3lrik8jOF8=;
 b=bGXziDW/mQvKN5nMG0X7di5KAOmkEiJRFbWff2KsIJQSYDOgJ4XTYDeaXBlcfxCJN17fDC
 TIT/fkzkyDHQ2OE9vZUfq+7J3E5XrJx/Z0FLL2MIjiOKI1nGFy47HiJbnSBJUOg8EqFK28
 4+a2/tzVBVFsv2dYUtK4DkyZjKCOdLQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-UN8-kOOROsuMfKBMG6toGA-1; Mon, 28 Aug 2023 06:39:06 -0400
X-MC-Unique: UN8-kOOROsuMfKBMG6toGA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-401b0ff0f39so18627245e9.1
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 03:39:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693219145; x=1693823945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qpPW00DDQ8RN8lC6WhZ2fk5frp42Ch9Oi3lrik8jOF8=;
 b=I5xJYWFXDhbOmtvDCcbAGVhOHia4JEvqZr3dwrJq8VkR4C/VmrQyIebwWSllTfkFI3
 d/c4FxmjbgQbIr3fUS0/Frh9Gs3GWQbcPZs3jkeYQxyKdCHR+itQdxxTd/A8vyDBG9ps
 PVzDi4V/XDHLpoxRsusdypcEcCN9NJ2yhPdiwEw9EfZ2bPz8wLQuj1/khFdhR3nq+UcQ
 DUERM/hddEgFaKwkLGsEnDvZRQBfT/TrFVFD71323GkNJUylsN+khqVJnBmKO+F30IGT
 f2EIjUebtAa1Oe6JZheH9nJ/Tk0xJl1KcYAFqaXHrBudprjR25Jdoo9BlBNGQFZV6GuM
 p8Yw==
X-Gm-Message-State: AOJu0YxRjH93QmZnGXylSDYJjXOPxeCrbdwEGTFcdjM57r6VEWsxEjJt
 uXX7K4LpCybcV0VIaw+4B15WwimJEO7sMTeGw9V6zF4iwje0t6nv0IKHB3TIpWIvJ/UBVOIkD1G
 oZVJSto6fSnsRnSpmOOB6Gu+/hO9ssXno2qExxWGiNBUzIgsu8ZvzVFrQMlb7HdBFQ0KERyLpYf
 A=
X-Received: by 2002:a05:600c:3b92:b0:3fe:f4b0:634a with SMTP id
 n18-20020a05600c3b9200b003fef4b0634amr15932859wms.19.1693219145241; 
 Mon, 28 Aug 2023 03:39:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnDLijwzduN4EvAzVVeD1S9ehg/rPloRd7Was0Q0GJ6TYJWev8HpUprgUw1nGCTLYe14pWtQ==
X-Received: by 2002:a05:600c:3b92:b0:3fe:f4b0:634a with SMTP id
 n18-20020a05600c3b9200b003fef4b0634amr15932843wms.19.1693219144741; 
 Mon, 28 Aug 2023 03:39:04 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 p8-20020adfe608000000b003197efd1e7bsm10168560wrm.114.2023.08.28.03.39.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 03:39:04 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/14] python: mkvenv: introduce TOML-like representation of
 dependencies
Date: Mon, 28 Aug 2023 12:38:43 +0200
Message-ID: <20230828103856.46031-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828103856.46031-1-pbonzini@redhat.com>
References: <20230828103856.46031-1-pbonzini@redhat.com>
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


