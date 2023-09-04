Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C77D79154E
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 11:57:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd6Kz-0005uP-Hp; Mon, 04 Sep 2023 05:57:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qd6Kx-0005u4-RB
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 05:57:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qd6Ks-0006n0-1E
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 05:57:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693821452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uCpyOpb2XemYy0/+vgrwsX+DzVxiyGspyte7b/RQvBM=;
 b=h2LIKTE7JQWU2iuHHrzIJs/HDilj1tPYwy0l+Hxy1g1A8Q84pQbrOXHIXPxOPCplOYRHHl
 VXZQsQTMaDvmS1ldgQ9AZmn3Y1wybjCdj3Ox/bcgo6VmtmJ2FMj7az2L8Xgtr9FaTeEF77
 NM4pm2O/jABRc+fe7lm7LONLy5bQtZI=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-Zcqqw3nAPP-AOxQqdXUNvA-1; Mon, 04 Sep 2023 05:57:31 -0400
X-MC-Unique: Zcqqw3nAPP-AOxQqdXUNvA-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2bcc2fd542bso11924761fa.3
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 02:57:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693821449; x=1694426249;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uCpyOpb2XemYy0/+vgrwsX+DzVxiyGspyte7b/RQvBM=;
 b=hKmAXV9un3DAXY8oVL1YqaLFvaqu/9P62n+W5Jh9rc0nmtmAa1TdGGGaDtpszCr4Qw
 rV/1t0EoEKhcqOruwGCdE8ttfBCXm6s3kp/lxl50MfiYir+btPbT1QH6WCAUNcNx16x2
 DBjmMlV0F7VP5IjmpuOBsVwusNHCQAyR4zjykKLGsuEtwCUQBpas0hMHhlQt2ErFeKN9
 XXu4Tw3WKsrsdXnxuDXlIVCEh2/5iydhL8qEvEh+iKO2vh9P+jErADMur7rycbDotM2P
 t6jt1SNck0yD4Do18aywgppVjh+P/ygA0rp5RT9ddNdWcPqLeUyuvrptGYWuePuqRQbu
 bIuA==
X-Gm-Message-State: AOJu0YxnBcWTM2sgfNIMRHZok+OcjTcR5Wp5btwcLqEN14zkdk8bdzh5
 qgSnZzFmfPIOvddfaFhCh3j+MXN2QA4nRqgfB768PegV/BnYJPGpGBTS1efUeM83FNvxdTLr1Ki
 65304NgGt76R9gLiW4VItObnu3/gMWiLB7m4eQORZmpTGVuu48ltorGvYnAXQK5GZDjlKUdm/au
 4=
X-Received: by 2002:a2e:9691:0:b0:2bc:d33e:ccc5 with SMTP id
 q17-20020a2e9691000000b002bcd33eccc5mr7327559lji.41.1693821448798; 
 Mon, 04 Sep 2023 02:57:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJzJ0m4nSLBFvN5e7G4JDG+qbyZ89KmRf/jMcmGWBL1rCjf1GYESqs6nJ2kV+LJTGH5bEu4A==
X-Received: by 2002:a2e:9691:0:b0:2bc:d33e:ccc5 with SMTP id
 q17-20020a2e9691000000b002bcd33eccc5mr7327535lji.41.1693821448501; 
 Mon, 04 Sep 2023 02:57:28 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 m9-20020a05600c280900b00401df304a7esm16559169wmb.28.2023.09.04.02.57.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Sep 2023 02:57:27 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, armbru@redhat.com, peter.maydell@linaro.org,
 berrange@redhat.com
Subject: [RFC PATCH 3/3] Revert "mkvenv: work around broken pip installations
 on Debian 10"
Date: Mon,  4 Sep 2023 11:57:20 +0200
Message-ID: <20230904095720.154738-4-pbonzini@redhat.com>
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
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


