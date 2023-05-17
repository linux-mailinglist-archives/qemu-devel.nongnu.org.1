Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDB9707031
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 19:57:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzLEC-00081J-2N; Wed, 17 May 2023 13:46:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLE7-0007hL-NO
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:46:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLE5-0004HP-V8
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:46:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684345573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tlEc08hsHfooO7rQikJ5l6wNa9dPNHYDs4dAyWzQnhQ=;
 b=LPuOuvAW7kXitgpLkQ7kin+dTCx0a2W13HxoJszDbtLEotNo1ahD9Huvzb8sVdU5a2nVe+
 AimXIjDMklReGqsVNY9qNiYs54WnSZqqPKDk6W7H8ep8JcLpXeAX9J51tpoR6+fY3WIqZT
 /w8yAtFa9mRKBGisNi63stIJmJEMT8c=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-zZOHHL5lM86OqkTXTXsohw-1; Wed, 17 May 2023 13:46:12 -0400
X-MC-Unique: zZOHHL5lM86OqkTXTXsohw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f42867b47dso6595495e9.2
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 10:46:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684345570; x=1686937570;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tlEc08hsHfooO7rQikJ5l6wNa9dPNHYDs4dAyWzQnhQ=;
 b=FeP6VVvcYEvYf37OR5PP75U/srzZx9JANU0RyNNwvmB5hIf1CDvasNVR0f+ikP8x1y
 QVPMLtGhoBUWsBNIpchgD5vhbOe4D0/Bymw6fHDgJFasGmMmOUn12lrApwMIvTBZK6UL
 kX8DtEDrXCfCwsJcWW4Kqowj0MnQusDfPhjvi4A8Ewq+SnXl6qvxmshPYpwHwtNbqFPP
 +AqIZbko1A9HOlfOHMrwq3pOf+m5DUMbsiFbf6vBp4dCiyKCYZOG2uu2Zk0gH3sappj6
 QQxm5Uv25cs5O+je+q3wTunYJUdzEZDI8cKKSs5U3LNdGBthvVIg8FJyetnPn5NYWC5x
 JYvg==
X-Gm-Message-State: AC+VfDy5Fb/4aM0GYl1JCRnR5DCZAXdW1HPfFqHTtXqojiOLCXYj3o7s
 L8T5tihSwy6LdtF73GozO0Qje9WUXutfLGns7F9XHpomBcV5BPgn4Pdi0EPxy8oXMInOztAfukD
 RxpSj9kGr4/Ns7T/7rRymKpeHVhrcZV70N6ilNFNyFriFo5+TPNJvBnC20phq/S0pJaKdB9Sh7H
 U=
X-Received: by 2002:a7b:c5d6:0:b0:3f1:969f:c9d0 with SMTP id
 n22-20020a7bc5d6000000b003f1969fc9d0mr30995808wmk.4.1684345570281; 
 Wed, 17 May 2023 10:46:10 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7C9McPTBZwF21I//SvuoO91O5rjbWK50HlGFvBj2d7RK4TrP4siB1PcrSlQVwNkKyl1Z+rbA==
X-Received: by 2002:a7b:c5d6:0:b0:3f1:969f:c9d0 with SMTP id
 n22-20020a7bc5d6000000b003f1969fc9d0mr30995785wmk.4.1684345569717; 
 Wed, 17 May 2023 10:46:09 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 z4-20020a05600c220400b003f4069417absm2849765wml.24.2023.05.17.10.46.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 10:46:09 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>
Subject: [PULL 28/68] mkvenv: work around broken pip installations on Debian 10
Date: Wed, 17 May 2023 19:44:40 +0200
Message-Id: <20230517174520.887405-29-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230517174520.887405-1-pbonzini@redhat.com>
References: <20230517174520.887405-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This is a workaround intended for Debian 10, where the debian-patched
pip does not function correctly if accessed from within a virtual
environment.

We don't support Debian 10 as a build platform any longer, though we do
still utilize it for our build-tricore-softmmu CI test. It's also
possible that this bug might appear on other derivative platforms and
this workaround may prove useful.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
Message-Id: <20230511035435.734312-11-jsnow@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 python/scripts/mkvenv.py | 72 +++++++++++++++++++++++++++++++---------
 1 file changed, 56 insertions(+), 16 deletions(-)

diff --git a/python/scripts/mkvenv.py b/python/scripts/mkvenv.py
index a9c566029e6f..558619910efd 100644
--- a/python/scripts/mkvenv.py
+++ b/python/scripts/mkvenv.py
@@ -161,7 +161,7 @@ def __init__(self, *args: Any, **kwargs: Any) -> None:
             ):
                 kwargs["with_pip"] = False
             else:
-                check_ensurepip()
+                check_ensurepip(suggest_remedy=True)
 
         super().__init__(*args, **kwargs)
 
@@ -266,7 +266,7 @@ def need_ensurepip() -> bool:
     return True
 
 
-def check_ensurepip() -> None:
+def check_ensurepip(prefix: str = "", suggest_remedy: bool = False) -> None:
     """
     Check that we have ensurepip.
 
@@ -277,12 +277,15 @@ def check_ensurepip() -> None:
             "Python's ensurepip module is not found.\n"
             "It's normally part of the Python standard library, "
             "maybe your distribution packages it separately?\n"
-            "Either install ensurepip, or alleviate the need for it in the "
-            "first place by installing pip and setuptools for "
-            f"'{sys.executable}'.\n"
-            "(Hint: Debian puts ensurepip in its python3-venv package.)"
+            "(Debian puts ensurepip in its python3-venv package.)\n"
         )
-        raise Ouch(msg)
+        if suggest_remedy:
+            msg += (
+                "Either install ensurepip, or alleviate the need for it in the"
+                " first place by installing pip and setuptools for "
+                f"'{sys.executable}'.\n"
+            )
+        raise Ouch(prefix + msg)
 
     # ensurepip uses pyexpat, which can also go missing on us:
     if not find_spec("pyexpat"):
@@ -290,12 +293,15 @@ def check_ensurepip() -> None:
             "Python's pyexpat module is not found.\n"
             "It's normally part of the Python standard library, "
             "maybe your distribution packages it separately?\n"
-            "Either install pyexpat, or alleviate the need for it in the "
-            "first place by installing pip and setuptools for "
-            f"'{sys.executable}'.\n\n"
-            "(Hint: NetBSD's pkgsrc debundles this to e.g. 'py310-expat'.)"
+            "(NetBSD's pkgsrc debundles this to e.g. 'py310-expat'.)\n"
         )
-        raise Ouch(msg)
+        if suggest_remedy:
+            msg += (
+                "Either install pyexpat, or alleviate the need for it in the "
+                "first place by installing pip and setuptools for "
+                f"'{sys.executable}'.\n"
+            )
+        raise Ouch(prefix + msg)
 
 
 def make_venv(  # pylint: disable=too-many-arguments
@@ -501,6 +507,38 @@ def _get_entry_points() -> Iterator[str]:
             logger.debug("wrote console_script '%s'", filename)
 
 
+def checkpip() -> bool:
+    """
+    Debian10 has a pip that's broken when used inside of a virtual environment.
+
+    We try to detect and correct that case here.
+    """
+    try:
+        # pylint: disable=import-outside-toplevel,unused-import,import-error
+        # pylint: disable=redefined-outer-name
+        import pip._internal  # type: ignore  # noqa: F401
+
+        logger.debug("pip appears to be working correctly.")
+        return False
+    except ModuleNotFoundError as exc:
+        if exc.name == "pip._internal":
+            # Uh, fair enough. They did say "internal".
+            # Let's just assume it's fine.
+            return False
+        logger.warning("pip appears to be malfunctioning: %s", str(exc))
+
+    check_ensurepip("pip appears to be non-functional, and ")
+
+    logger.debug("Attempting to repair pip ...")
+    subprocess.run(
+        (sys.executable, "-m", "ensurepip"),
+        stdout=subprocess.DEVNULL,
+        check=True,
+    )
+    logger.debug("Pip is now (hopefully) repaired!")
+    return True
+
+
 def pkgname_from_depspec(dep_spec: str) -> str:
     """
     Parse package name out of a PEP-508 depspec.
@@ -741,10 +779,12 @@ def post_venv_setup() -> None:
     This is intended to be run *inside the venv* after it is created.
     """
     logger.debug("post_venv_setup()")
-    # Generate a 'pip' script so the venv is usable in a normal
-    # way from the CLI. This only happens when we inherited pip from a
-    # parent/system-site and haven't run ensurepip in some way.
-    generate_console_scripts(["pip"])
+    # Test for a broken pip (Debian 10 or derivative?) and fix it if needed
+    if not checkpip():
+        # Finally, generate a 'pip' script so the venv is usable in a normal
+        # way from the CLI. This only happens when we inherited pip from a
+        # parent/system-site and haven't run ensurepip in some way.
+        generate_console_scripts(["pip"])
 
 
 def _add_create_subcommand(subparsers: Any) -> None:
-- 
2.40.1


