Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 52203707043
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 19:59:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzLEb-0000kX-Vt; Wed, 17 May 2023 13:46:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLDy-0007Nz-UR
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:46:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLDv-0004Eu-NC
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:46:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684345563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r32waci+7msiLYjT0xk6Q0YNKNwf8HVaX33ysEpRnWc=;
 b=LaOIfTNNFuyH6QNpWsNrlPSEZ0Nu7N20wN3iQPFxuFJ5JruvXkRBAqwihh/SotTy74unU2
 AaZlN7e1d4lm44RZpAbi3KmSjATVr6b5BBeFR11/LHEF/Sl1RzA9zAcfoKusazYIHX1YM3
 +ccc0TgOdfFCmpNWOrIHDvN5lsNzNAs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-oz0eh5JjO32UosaLeFi0IA-1; Wed, 17 May 2023 13:46:01 -0400
X-MC-Unique: oz0eh5JjO32UosaLeFi0IA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f426514683so4393905e9.1
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 10:46:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684345559; x=1686937559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r32waci+7msiLYjT0xk6Q0YNKNwf8HVaX33ysEpRnWc=;
 b=IkcCJO1JduU0QHbAB8bPuaNI0X4qQV+cVcPQR/OngxkWWjQMZQguyddTm4BLHcPBhF
 ySXKKcET2ZH60XmUnmT+yuRmTjh4CYqBzeaCkEBS9hA9QWXSfmaXyprxYY0YKNp/3f1i
 uoOg6IMZTNyYbMS+zG/PfyuCs0MNqHr7VVTGYMRCU9RC+KPJvF1RK+0ynJqekg8aIoT+
 V6MQB+JgUExcx3RGRFmogAwy1LUAUpApmPIva1oTW7SXzwnRzN7RvOfcHUXDk6VPki0k
 XTmy8fRFdG4xnLi5aloCj20oE595+hT0cYw47pygXaCN0mPpCe2ypAsvZiYxCpQbUQ5i
 SlHg==
X-Gm-Message-State: AC+VfDz+9OrX8wHLYJMes5Agr1AhoH0mVakv4bqh5rt6W2ntGGZ4KWPh
 7cRbftURdX40ys3vgAtSpoonSprKFxdMg6pRKiNUBS1l8y3D4T3pTg9+C9RXluxuQrK8FVep1v6
 X74H935kUw05VpdoDKoKbemLlYaIa4lJhsKTxoguKam0puLlRJTaUojAV2rPq2QHHtRO0UxmFX8
 Y=
X-Received: by 2002:a5d:464d:0:b0:2f2:783f:ae4a with SMTP id
 j13-20020a5d464d000000b002f2783fae4amr1358197wrs.32.1684345559678; 
 Wed, 17 May 2023 10:45:59 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ61aEV5iCfVRTSTYTk7OSdZ4OkF4S8/Dzt7rLO5teN5Vt9rWjEl3hAdsJFnB/kPXm45DJlZOQ==
X-Received: by 2002:a5d:464d:0:b0:2f2:783f:ae4a with SMTP id
 j13-20020a5d464d000000b002f2783fae4amr1358189wrs.32.1684345559337; 
 Wed, 17 May 2023 10:45:59 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 f3-20020a0560001b0300b003063772a55bsm3409470wrz.61.2023.05.17.10.45.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 10:45:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>
Subject: [PULL 22/68] mkvenv: add nested venv workaround
Date: Wed, 17 May 2023 19:44:34 +0200
Message-Id: <20230517174520.887405-23-pbonzini@redhat.com>
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

Python virtual environments do not typically nest; they may inherit from
the top-level system packages or not at all.

For our purposes, it would be convenient to emulate "nested" virtual
environments to allow callers of the configure script to install
specific versions of python utilities in order to test build system
features, utility version compatibility, etc.

While it is possible to install packages into the system environment
(say, by using the --user flag), it's nicer to install test packages
into a totally isolated environment instead.

As detailed in https://www.qemu.org/2023/03/24/python/, Emulate a nested
venv environment by using .pth files installed into the site-packages
folder that points to the parent environment when appropriate.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
Message-Id: <20230511035435.734312-6-jsnow@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 python/scripts/mkvenv.py | 91 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 86 insertions(+), 5 deletions(-)

diff --git a/python/scripts/mkvenv.py b/python/scripts/mkvenv.py
index 3c48f8b9baa6..1c1dd89a9afd 100644
--- a/python/scripts/mkvenv.py
+++ b/python/scripts/mkvenv.py
@@ -38,8 +38,10 @@
 import logging
 import os
 from pathlib import Path
+import site
 import subprocess
 import sys
+import sysconfig
 from types import SimpleNamespace
 from typing import Any, Optional, Union
 import venv
@@ -52,6 +54,11 @@
 logger = logging.getLogger("mkvenv")
 
 
+def inside_a_venv() -> bool:
+    """Returns True if it is executed inside of a virtual environment."""
+    return sys.prefix != sys.base_prefix
+
+
 class Ouch(RuntimeError):
     """An Exception class we can't confuse with a builtin."""
 
@@ -60,10 +67,9 @@ class QemuEnvBuilder(venv.EnvBuilder):
     """
     An extension of venv.EnvBuilder for building QEMU's configure-time venv.
 
-    As of this commit, it does not yet do anything particularly
-    different than the standard venv-creation utility. The next several
-    commits will gradually change that in small commits that highlight
-    each feature individually.
+    The primary difference is that it emulates a "nested" virtual
+    environment when invoked from inside of an existing virtual
+    environment by including packages from the parent.
 
     Parameters for base class init:
       - system_site_packages: bool = False
@@ -78,6 +84,18 @@ class QemuEnvBuilder(venv.EnvBuilder):
     def __init__(self, *args: Any, **kwargs: Any) -> None:
         logger.debug("QemuEnvBuilder.__init__(...)")
 
+        # For nested venv emulation:
+        self.use_parent_packages = False
+        if inside_a_venv():
+            # Include parent packages only if we're in a venv and
+            # system_site_packages was True.
+            self.use_parent_packages = kwargs.pop(
+                "system_site_packages", False
+            )
+            # Include system_site_packages only when the parent,
+            # The venv we are currently in, also does so.
+            kwargs["system_site_packages"] = sys.base_prefix in site.PREFIXES
+
         if kwargs.get("with_pip", False):
             check_ensurepip()
 
@@ -86,11 +104,71 @@ def __init__(self, *args: Any, **kwargs: Any) -> None:
         # Make the context available post-creation:
         self._context: Optional[SimpleNamespace] = None
 
+    def get_parent_libpath(self) -> Optional[str]:
+        """Return the libpath of the parent venv, if applicable."""
+        if self.use_parent_packages:
+            return sysconfig.get_path("purelib")
+        return None
+
+    @staticmethod
+    def compute_venv_libpath(context: SimpleNamespace) -> str:
+        """
+        Compatibility wrapper for context.lib_path for Python < 3.12
+        """
+        # Python 3.12+, not strictly necessary because it's documented
+        # to be the same as 3.10 code below:
+        if sys.version_info >= (3, 12):
+            return context.lib_path
+
+        # Python 3.10+
+        if "venv" in sysconfig.get_scheme_names():
+            lib_path = sysconfig.get_path(
+                "purelib", scheme="venv", vars={"base": context.env_dir}
+            )
+            assert lib_path is not None
+            return lib_path
+
+        # For Python <= 3.9 we need to hardcode this. Fortunately the
+        # code below was the same in Python 3.6-3.10, so there is only
+        # one case.
+        if sys.platform == "win32":
+            return os.path.join(context.env_dir, "Lib", "site-packages")
+        return os.path.join(
+            context.env_dir,
+            "lib",
+            "python%d.%d" % sys.version_info[:2],
+            "site-packages",
+        )
+
     def ensure_directories(self, env_dir: DirType) -> SimpleNamespace:
         logger.debug("ensure_directories(env_dir=%s)", env_dir)
         self._context = super().ensure_directories(env_dir)
         return self._context
 
+    def create(self, env_dir: DirType) -> None:
+        logger.debug("create(env_dir=%s)", env_dir)
+        super().create(env_dir)
+        assert self._context is not None
+        self.post_post_setup(self._context)
+
+    def post_post_setup(self, context: SimpleNamespace) -> None:
+        """
+        The final, final hook. Enter the venv and run commands inside of it.
+        """
+        if self.use_parent_packages:
+            # We're inside of a venv and we want to include the parent
+            # venv's packages.
+            parent_libpath = self.get_parent_libpath()
+            assert parent_libpath is not None
+            logger.debug("parent_libpath: %s", parent_libpath)
+
+            our_libpath = self.compute_venv_libpath(context)
+            logger.debug("our_libpath: %s", our_libpath)
+
+            pth_file = os.path.join(our_libpath, "nested.pth")
+            with open(pth_file, "w", encoding="UTF-8") as file:
+                file.write(parent_libpath + os.linesep)
+
     def get_value(self, field: str) -> str:
         """
         Get a string value from the context namespace after a call to build.
@@ -183,9 +261,12 @@ def make_venv(  # pylint: disable=too-many-arguments
     )
 
     style = "non-isolated" if builder.system_site_packages else "isolated"
+    nested = ""
+    if builder.use_parent_packages:
+        nested = f"(with packages from '{builder.get_parent_libpath()}') "
     print(
         f"mkvenv: Creating {style} virtual environment"
-        f" at '{str(env_dir)}'",
+        f" {nested}at '{str(env_dir)}'",
         file=sys.stderr,
     )
 
-- 
2.40.1


