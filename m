Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 005A1723B70
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 10:25:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Ryf-0001cu-6I; Tue, 06 Jun 2023 04:23:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q6Ryc-0001ck-FK
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 04:23:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q6Rya-0002dv-Sg
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 04:23:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686039815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=j9E3FzrvjU9g3p0d4x/tLkDLaJOBRE/fXRO2lBGlR/o=;
 b=Iu1EvtgiTxhH8eVXbRqeC5e8xgNeUvA6Ty3yMirckTRoMIYg6wKtlLWGKUcoMDQGHd3jtL
 M5kI/TzI7LealjoHGSlKUcKjHYfnUsh6WgSmUV3ldLPFab7wArAmxwYWGSxHz89JrAAvJm
 0F5a284r5DvjWfXQ9upaD4yPaN53w+w=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529--r_8ghkGPJOrnJxGRBMmbw-1; Tue, 06 Jun 2023 04:23:34 -0400
X-MC-Unique: -r_8ghkGPJOrnJxGRBMmbw-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-9745c72d99cso388989266b.1
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 01:23:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686039813; x=1688631813;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=j9E3FzrvjU9g3p0d4x/tLkDLaJOBRE/fXRO2lBGlR/o=;
 b=di0ZCMAO6VGQbLu6u9l2wIHIbyp7IfWn/Yjzkv5r8rv6TRxwV1ZU1XrI4ltOhWisT/
 u5ycuHAm1RsUHLHywSQYmmjpOcxGmY0H4q4x/37TDjHoUG71p8NoTpOwQtcFGtoCEBnJ
 N/WBamISmVQiIpHT2Wn3sSaSIi1fCT2ycFC8RqH1v5dbLyhnXeoFvauOdbWi+S4xuMHz
 WZbCCPQfdidE9HHZygEBa19PtYhjk44XB4gmEA4FuLZYF0lL0XKQC0m4YoA69bnyNmQ+
 YhfLN/bxocDsI0LxOWwAquGd96w0yGQ593ujdNchqIgjuDMu1aUEb9MX8kM5Es9HCCgt
 4pnw==
X-Gm-Message-State: AC+VfDwea7ptDWhaWRIAM7yMO5E0V7ujtsdV0S//u/GEdxpZ6RrdmzBJ
 lQ0lf4IqKhWH1AKLEfiFTdiut9Rky+4QEQ0Tc8ztjRPMdCF//YcwdDBwBiDS2t2qIRsUKvXTNzz
 xVI3tQHMbDzRg3rQXyZxcVNKQzydWcqCJvOvIv50umpK6QsM9QRVbZi5JzdeEMUwd67meYY8vRk
 w=
X-Received: by 2002:a17:907:6d15:b0:94f:449e:75db with SMTP id
 sa21-20020a1709076d1500b0094f449e75dbmr1576034ejc.52.1686039812883; 
 Tue, 06 Jun 2023 01:23:32 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4ijq5Wh/MldY+gNHaI966MnTB9P5dwM4K8+mObp7wtpvSAE6wMQZ5M67lewIEiEx0/64YuNQ==
X-Received: by 2002:a17:907:6d15:b0:94f:449e:75db with SMTP id
 sa21-20020a1709076d1500b0094f449e75dbmr1576019ejc.52.1686039812481; 
 Tue, 06 Jun 2023 01:23:32 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 a10-20020a17090680ca00b0096a68648329sm5173776ejx.214.2023.06.06.01.23.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 01:23:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
	John Snow <jsnow@redhat.com>
Subject: [PATCH] mkvenv: always pass locally-installed packages to pip
Date: Tue,  6 Jun 2023 10:23:30 +0200
Message-Id: <20230606082330.445790-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
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

Let pip decide whether a new version should be installed or the current
one is okay.  This ensures that the virtual environment is updated
(either upgraded or downgraded) whenever a new version of a package is
requested.

The hardest part here is figuring out if a package is installed in
the venv (which also has to be done twice to account for the presence
of either setuptools in Python <3.8, or importlib in Python >=3.8).

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Cc: John Snow <jsnow@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 python/scripts/mkvenv.py | 76 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 74 insertions(+), 2 deletions(-)

diff --git a/python/scripts/mkvenv.py b/python/scripts/mkvenv.py
index 3a9aef46a51..3957e7d6e08 100644
--- a/python/scripts/mkvenv.py
+++ b/python/scripts/mkvenv.py
@@ -553,6 +553,74 @@ def pkgname_from_depspec(dep_spec: str) -> str:
     return match.group(0)
 
 
+def _get_path_importlib(package: str) -> Optional[str]:
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
+        return str(distribution(package).locate_file("."))
+    except PackageNotFoundError:
+        return None
+
+
+def _get_path_pkg_resources(package: str) -> Optional[str]:
+    # pylint: disable=import-outside-toplevel
+    # Bundled with setuptools; has a good chance of being available.
+    import pkg_resources
+
+    try:
+        return str(pkg_resources.get_distribution(package).location)
+    except pkg_resources.DistributionNotFound:
+        return None
+
+
+def _get_path(package: str) -> Optional[str]:
+    try:
+        return _get_path_importlib(package)
+    except ImportError as exc:
+        logger.debug("%s", str(exc))
+
+    try:
+        return _get_path_pkg_resources(package)
+    except ImportError as exc:
+        logger.debug("%s", str(exc))
+        raise Ouch(
+            "Neither importlib.metadata nor pkg_resources found. "
+            "Use Python 3.8+, or install importlib-metadata or setuptools."
+        ) from exc
+
+
+def _path_is_prefix(prefix: Union[str, Path], path: Union[str, Path]) -> bool:
+    prefix = str(prefix)
+    path = str(path)
+    try:
+        return os.path.commonpath([prefix, path]) == prefix
+    except ValueError:
+        return False
+
+
+def _is_system_package(package: str) -> bool:
+    path = _get_path(package)
+    return path is not None and not (
+        _path_is_prefix(sysconfig.get_path("purelib"), path)
+        or _path_is_prefix(sysconfig.get_path("platlib"), path)
+    )
+
+
 def _get_version_importlib(package: str) -> Optional[str]:
     # pylint: disable=import-outside-toplevel
     # pylint: disable=no-name-in-module
@@ -741,8 +809,12 @@ def _do_ensure(
     for spec in dep_specs:
         matcher = distlib.version.LegacyMatcher(spec)
         ver = _get_version(matcher.name)
-        if ver is None or not matcher.match(
-            distlib.version.LegacyVersion(ver)
+        if (
+            ver is None
+            # Always pass installed package to pip, so that they can be
+            # updated if the requested version changes
+            or not _is_system_package(matcher.name)
+            or not matcher.match(distlib.version.LegacyVersion(ver))
         ):
             absent.append(spec)
         else:
-- 
2.40.1


