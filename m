Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B132D7972AA
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 15:11:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeEeR-0004OF-VO; Thu, 07 Sep 2023 09:02:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEde-0003c9-NT
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:01:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEdb-0007RC-Fi
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:01:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694091694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uCpyOpb2XemYy0/+vgrwsX+DzVxiyGspyte7b/RQvBM=;
 b=HCigZUn6sHWtnihdg/+RH/lZsmT7ieZZpWH5vTi3FBUVQ1ZhohSAM4v63ahUFKfASf13Un
 SbWVmkxxLUzS51QZs7kyxHaxT4mDiQABCJ/iodE/UzRR7GaDqoXn2lrIN936FzxIZv6jOy
 9wOIMJtwQ2mmbH6iqW0oIftkVtJUPdo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-fbtP4pfbNHCeQil0xGHO0w-1; Thu, 07 Sep 2023 09:01:33 -0400
X-MC-Unique: fbtP4pfbNHCeQil0xGHO0w-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-31aea5cf0f5so647523f8f.1
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 06:01:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694091691; x=1694696491;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uCpyOpb2XemYy0/+vgrwsX+DzVxiyGspyte7b/RQvBM=;
 b=drZwgUtNwEhOmc+Gc7gSo1uyVhFiZ3eDOUAypG3jyISt/ftK802LxWxgvnZCoCCGvb
 VWQLUyKLn/37437QiT52mqXhTQTtNjx2+2pSAZaDWanywxJV6KqxsOCZbp6ca/DIHA3K
 FMV4EJZ+QgCpYTlhxwjinLUfSWvbwLu7iUSKyLSmWSqN1f3miqczsQhSIEqVYje+Qwfa
 uqrUpNdz035b8w1n3QB8hORTxNzw4g2tZPOLOITXUPPIbJeoR8LDT0ZiBOMO2T2W1PNH
 AoAensO2dVSsxtCI5VKIsVVbPSPkZZXQ4i9S/xWf+xVwrB5b+aLIJHatLcAN9FU7RCa4
 plAQ==
X-Gm-Message-State: AOJu0YxnA8Q17FnRJYnXmrIK6kSeSTw5iDIL6btDZ9Kl4Vnbnp+eeZUU
 SGobU0X1GYdD1CVwqwJVjUnvVcsWtuB3OZVVH7ZRMiM94TsdMxH5oaK8XqaPcfK2wjkMNHqd3SK
 ihHGa2SyCZPdBTtJc1XI1jmLR4Cbr4XkTinrNYjB2MLPLKwOZ6Wgqy9dxTtnfhS/VcoHaaK0jVY
 E=
X-Received: by 2002:adf:e74c:0:b0:317:7062:32d2 with SMTP id
 c12-20020adfe74c000000b00317706232d2mr4612761wrn.54.1694091691633; 
 Thu, 07 Sep 2023 06:01:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHaVdNvI5ybCBWpDVzC/QPX9wzT+Tl+BHS5gOIUe6PpaPu/NkZ6S0MU6WFhApZ4a4//YqmFA==
X-Received: by 2002:adf:e74c:0:b0:317:7062:32d2 with SMTP id
 c12-20020adfe74c000000b00317706232d2mr4612740wrn.54.1694091691046; 
 Thu, 07 Sep 2023 06:01:31 -0700 (PDT)
Received: from [192.168.1.174] ([151.48.237.81])
 by smtp.gmail.com with ESMTPSA id
 x12-20020a5d54cc000000b00315af025098sm23320841wrv.46.2023.09.07.06.01.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 06:01:29 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 36/51] Revert "mkvenv: work around broken pip installations on
 Debian 10"
Date: Thu,  7 Sep 2023 14:59:45 +0200
Message-ID: <20230907130004.500601-37-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230907130004.500601-1-pbonzini@redhat.com>
References: <20230907130004.500601-1-pbonzini@redhat.com>
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

Debian 10 has Python 3.7, so it is not possible to use it anymore
now that Python 3.8 is required.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 python/scripts/mkvenv.py | 74 +++++++++-------------------------------
 1 file changed, 16 insertions(+), 58 deletions(-)

diff --git a/python/scripts/mkvenv.py b/python/scripts/mkvenv.py
index 6797e12e349..d0b9c215ca2 100644
--- a/python/scripts/mkvenv.py
+++ b/python/scripts/mkvenv.py
@@ -61,8 +61,6 @@
 
 """
 
-# pylint: disable=too-many-lines
-
 # Copyright (C) 2022-2023 Red Hat, Inc.
 #
 # Authors:
@@ -195,7 +193,7 @@ def __init__(self, *args: Any, **kwargs: Any) -> None:
             ):
                 kwargs["with_pip"] = False
             else:
-                check_ensurepip(suggest_remedy=True)
+                check_ensurepip()
 
         super().__init__(*args, **kwargs)
 
@@ -300,7 +298,7 @@ def need_ensurepip() -> bool:
     return True
 
 
-def check_ensurepip(prefix: str = "", suggest_remedy: bool = False) -> None:
+def check_ensurepip() -> None:
     """
     Check that we have ensurepip.
 
@@ -311,15 +309,12 @@ def check_ensurepip(prefix: str = "", suggest_remedy: bool = False) -> None:
             "Python's ensurepip module is not found.\n"
             "It's normally part of the Python standard library, "
             "maybe your distribution packages it separately?\n"
-            "(Debian puts ensurepip in its python3-venv package.)\n"
+            "Either install ensurepip, or alleviate the need for it in the "
+            "first place by installing pip and setuptools for "
+            f"'{sys.executable}'.\n"
+            "(Hint: Debian puts ensurepip in its python3-venv package.)"
         )
-        if suggest_remedy:
-            msg += (
-                "Either install ensurepip, or alleviate the need for it in the"
-                " first place by installing pip and setuptools for "
-                f"'{sys.executable}'.\n"
-            )
-        raise Ouch(prefix + msg)
+        raise Ouch(msg)
 
     # ensurepip uses pyexpat, which can also go missing on us:
     if not find_spec("pyexpat"):
@@ -327,15 +322,12 @@ def check_ensurepip(prefix: str = "", suggest_remedy: bool = False) -> None:
             "Python's pyexpat module is not found.\n"
             "It's normally part of the Python standard library, "
             "maybe your distribution packages it separately?\n"
-            "(NetBSD's pkgsrc debundles this to e.g. 'py310-expat'.)\n"
+            "Either install pyexpat, or alleviate the need for it in the "
+            "first place by installing pip and setuptools for "
+            f"'{sys.executable}'.\n\n"
+            "(Hint: NetBSD's pkgsrc debundles this to e.g. 'py310-expat'.)"
         )
-        if suggest_remedy:
-            msg += (
-                "Either install pyexpat, or alleviate the need for it in the "
-                "first place by installing pip and setuptools for "
-                f"'{sys.executable}'.\n"
-            )
-        raise Ouch(prefix + msg)
+        raise Ouch(msg)
 
 
 def make_venv(  # pylint: disable=too-many-arguments
@@ -489,38 +481,6 @@ def generate_console_scripts(
             logger.debug("wrote console_script '%s'", filename)
 
 
-def checkpip() -> bool:
-    """
-    Debian10 has a pip that's broken when used inside of a virtual environment.
-
-    We try to detect and correct that case here.
-    """
-    try:
-        # pylint: disable=import-outside-toplevel,unused-import,import-error
-        # pylint: disable=redefined-outer-name
-        import pip._internal  # type: ignore  # noqa: F401
-
-        logger.debug("pip appears to be working correctly.")
-        return False
-    except ModuleNotFoundError as exc:
-        if exc.name == "pip._internal":
-            # Uh, fair enough. They did say "internal".
-            # Let's just assume it's fine.
-            return False
-        logger.warning("pip appears to be malfunctioning: %s", str(exc))
-
-    check_ensurepip("pip appears to be non-functional, and ")
-
-    logger.debug("Attempting to repair pip ...")
-    subprocess.run(
-        (sys.executable, "-m", "ensurepip"),
-        stdout=subprocess.DEVNULL,
-        check=True,
-    )
-    logger.debug("Pip is now (hopefully) repaired!")
-    return True
-
-
 def pkgname_from_depspec(dep_spec: str) -> str:
     """
     Parse package name out of a PEP-508 depspec.
@@ -877,12 +837,10 @@ def post_venv_setup() -> None:
     This is intended to be run *inside the venv* after it is created.
     """
     logger.debug("post_venv_setup()")
-    # Test for a broken pip (Debian 10 or derivative?) and fix it if needed
-    if not checkpip():
-        # Finally, generate a 'pip' script so the venv is usable in a normal
-        # way from the CLI. This only happens when we inherited pip from a
-        # parent/system-site and haven't run ensurepip in some way.
-        generate_console_scripts(["pip"])
+    # Generate a 'pip' script so the venv is usable in a normal
+    # way from the CLI. This only happens when we inherited pip from a
+    # parent/system-site and haven't run ensurepip in some way.
+    generate_console_scripts(["pip"])
 
 
 def _add_create_subcommand(subparsers: Any) -> None:
-- 
2.41.0


