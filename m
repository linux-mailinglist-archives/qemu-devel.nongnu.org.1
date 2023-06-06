Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E23724626
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 16:33:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Xit-0005S9-SX; Tue, 06 Jun 2023 10:31:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q6Xim-0005AF-7F
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 10:31:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q6Xik-0001H8-CV
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 10:31:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686061897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=snbjKiGCVkmSnpzphIqvKnweusS7BHB5lXHlF1VeWLY=;
 b=eWZfAdU6SJ4HcQpqISJWofAr6eP8hcNeTbX7i5vlpcoxhjNSOaqPs+LQRsI17XzunTHEfA
 QT6XFoDIS0kQqI+N/Ue5si0QYxo2pOel0l3m/Rjv+Q02b9kuBSLDMHTw0/98gfMY4L2VLH
 M2p+DyVxDH036exzeb9foVmbk/OxLsw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-L2c5LHyRPLWtDYLpDxvn6A-1; Tue, 06 Jun 2023 10:31:36 -0400
X-MC-Unique: L2c5LHyRPLWtDYLpDxvn6A-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-9744659b7b5so521302366b.3
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 07:31:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686061894; x=1688653894;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=snbjKiGCVkmSnpzphIqvKnweusS7BHB5lXHlF1VeWLY=;
 b=QDG9qj8hHo8hqhLz1API7sv02IRjXApT4XqUt/5iaHT7TKmWUeYQTEbkvhCqDPId2r
 CAVygS+gCAu3gqKRNaSxhuKkAq5ONSkm4sulnTG4MzGgQX7Kbh5Dcy/CzvHhC1HZ2JSy
 HU4TxwOruzLvejzmYdtKKiFwOXydj9qmr0sSnJGmOMXq07MVE6d7aZp7jYwX2z/pRQQH
 P62eyPm+lxpCchplD+/hwSRXdcEq4uUgMdVvF2ehwqHRC5wusMqj0qkYjLZvkSVJfNud
 3DJelbUSPa4FIUDGt4c6RZPD1mUMQuQOLdSXSeB/+vAhvCdrMK94jpCbgK+nQbLUolN/
 vJXA==
X-Gm-Message-State: AC+VfDxuFl0vRLXyLu8rW1IebMmG9JTeXewnrL0cRN7wSidlCTMMolhb
 ixhnPGbZi+F1lphgdkOqlQjf0lOgi++M6mss05sASD1ZOfs67BOYPxT3hqG5wvKCVOyBku1MqXP
 W3S3edTSAxLB6P+zmdUxRt9DcMPZRXRR/1YeLwmIg6+hG04YPbB6LbgtNlRRv5qR/+wADNNuFdk
 0=
X-Received: by 2002:a17:907:6eaa:b0:96f:e7cf:5015 with SMTP id
 sh42-20020a1709076eaa00b0096fe7cf5015mr2537426ejc.17.1686061894578; 
 Tue, 06 Jun 2023 07:31:34 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5jxsf/CK4KKfoFcYmXPgyHeq18QfEpUkJSTl9C4Lv/ChpWVP+Ry5SGfzXQ44Q7LDCrUHdN1Q==
X-Received: by 2002:a17:907:6eaa:b0:96f:e7cf:5015 with SMTP id
 sh42-20020a1709076eaa00b0096fe7cf5015mr2537405ejc.17.1686061894242; 
 Tue, 06 Jun 2023 07:31:34 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 fx22-20020a170906b75600b00977da5d3350sm2634967ejb.107.2023.06.06.07.31.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 07:31:33 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
	John Snow <jsnow@redhat.com>
Subject: [PULL 11/21] mkvenv: always pass locally-installed packages to pip
Date: Tue,  6 Jun 2023 16:31:06 +0200
Message-Id: <20230606143116.685644-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230606143116.685644-1-pbonzini@redhat.com>
References: <20230606143116.685644-1-pbonzini@redhat.com>
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
index 3a9aef46a51..a47f1eaf5d6 100644
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
+def _path_is_prefix(prefix: Optional[str], path: str) -> bool:
+    try:
+        return (
+            prefix is not None and os.path.commonpath([prefix, path]) == prefix
+        )
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


