Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D8F704B5E
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 13:01:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pysPl-0001ul-Rf; Tue, 16 May 2023 07:00:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pysPE-0001WS-BZ
 for qemu-devel@nongnu.org; Tue, 16 May 2023 06:59:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pysP6-00086v-Ae
 for qemu-devel@nongnu.org; Tue, 16 May 2023 06:59:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684234764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BFFMSSXMRNQD2M10UitwVYaEW4ieOpD15ZxEuDPfVVI=;
 b=LDKwuTNcm04w3LmdnmH/Ke7zoTwfxdExQCPD6okVg9YatL0tduCZ49J8MlcMsxUSoek42M
 a5TMH2dynky6mQMZ9n4B9khsWo4YoEqgs0IAwkXZOLNgcwgHMJFqhdpKIKKLcB/iPWFqyO
 i2b2FDYQTUH8qN/NjnR28OzOedbAqLk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-147-8zkD5lcsPcmSUQEWsxLtjA-1; Tue, 16 May 2023 06:59:23 -0400
X-MC-Unique: 8zkD5lcsPcmSUQEWsxLtjA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4C87C87DC00;
 Tue, 16 May 2023 10:59:23 +0000 (UTC)
Received: from avogadro.lan (unknown [10.39.192.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ED4A2492B00;
 Tue, 16 May 2023 10:59:21 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com,
	philmd@linaro.org,
	berrange@redhat.com
Subject: [PATCH v2 11/27] mkvenv: work around broken pip installations on
 Debian 10
Date: Tue, 16 May 2023 12:58:52 +0200
Message-Id: <20230516105908.527838-11-pbonzini@redhat.com>
In-Reply-To: <20230516105908.527838-1-pbonzini@redhat.com>
References: <20230516105908.527838-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
index 7fc30dc1b3e8..b310f6c0531e 100644
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



