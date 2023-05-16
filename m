Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC61704BC7
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 13:06:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pysPt-00022P-7b; Tue, 16 May 2023 07:00:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pysPF-0001YU-Mi
 for qemu-devel@nongnu.org; Tue, 16 May 2023 06:59:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pysP7-00086p-4I
 for qemu-devel@nongnu.org; Tue, 16 May 2023 06:59:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684234763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dmnl6xynvT7+OjOSoquC35u/p1oOHqZjwpmQ3o8Jo8w=;
 b=G9C+1vDEvELDjaoAVgiFFiIx8Frvibqd/1c0XvG9i71hZ8CaESKNSNxtbJpiPUFsUbb0gG
 wJpErZNddF8hfWhT0Cf+AbQRqwDWmDe7kxGoQUI52WYFdN6q0gQzZh8uTpJ8Er0oP22pZk
 Hvii7pf3Cv4s92cACzaBWDAveQ5xq/E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-70-Y0F_4QE3M8mmao50vLdf5w-1; Tue, 16 May 2023 06:59:20 -0400
X-MC-Unique: Y0F_4QE3M8mmao50vLdf5w-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8466C87DC03;
 Tue, 16 May 2023 10:59:20 +0000 (UTC)
Received: from avogadro.lan (unknown [10.39.192.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A3A76492B00;
 Tue, 16 May 2023 10:59:19 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com,
	philmd@linaro.org,
	berrange@redhat.com
Subject: [PATCH v2 09/27] mkvenv: use pip's vendored distlib as a fallback
Date: Tue, 16 May 2023 12:58:50 +0200
Message-Id: <20230516105908.527838-9-pbonzini@redhat.com>
In-Reply-To: <20230516105908.527838-1-pbonzini@redhat.com>
References: <20230516105908.527838-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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

distlib is usually not installed on Linux distribution, but it is vendored
into pip.  Because the virtual environment has pip via ensurepip, we
can piggy-back on pip's vendored version.  This could break if they move
our cheese in the future, but the fix would be simply to require distlib.

If it is debundled, as it is on msys, it is simply available directly.

Signed-off-by: John Snow <jsnow@redhat.com>
[Move to toplevel. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 python/scripts/mkvenv.py | 25 ++++++++++++++++++++++---
 python/setup.cfg         | 18 ++++++++++++++++++
 2 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/python/scripts/mkvenv.py b/python/scripts/mkvenv.py
index c4c542524144..9e50bfb1778b 100644
--- a/python/scripts/mkvenv.py
+++ b/python/scripts/mkvenv.py
@@ -69,10 +69,25 @@
 import venv
 import warnings
 
-import distlib.database
-import distlib.scripts
-import distlib.version
 
+# Try to load distlib, with a fallback to pip's vendored version.
+# HAVE_DISTLIB is checked below, just-in-time, so that mkvenv does not fail
+# outside the venv or before a potential call to ensurepip in checkpip().
+HAVE_DISTLIB = True
+try:
+    import distlib.database
+    import distlib.scripts
+    import distlib.version
+except ImportError:
+    try:
+        # Reach into pip's cookie jar.  pylint and flake8 don't understand
+        # that these imports will be used via distlib.xxx.
+        from pip._vendor import distlib
+        import pip._vendor.distlib.database  # noqa, pylint: disable=unused-import
+        import pip._vendor.distlib.scripts  # noqa, pylint: disable=unused-import
+        import pip._vendor.distlib.version  # noqa, pylint: disable=unused-import
+    except ImportError:
+        HAVE_DISTLIB = False
 
 # Do not add any mandatory dependencies from outside the stdlib:
 # This script *must* be usable standalone!
@@ -664,6 +679,10 @@ def ensure(
         bellwether for the presence of 'sphinx'.
     """
     print(f"mkvenv: checking for {', '.join(dep_specs)}", file=sys.stderr)
+
+    if not HAVE_DISTLIB:
+        raise Ouch("a usable distlib could not be found, please install it")
+
     try:
         _do_ensure(dep_specs, online, wheels_dir)
     except subprocess.CalledProcessError as exc:
diff --git a/python/setup.cfg b/python/setup.cfg
index 826a2771ba5d..fc3fae5b1076 100644
--- a/python/setup.cfg
+++ b/python/setup.cfg
@@ -125,6 +125,24 @@ ignore_missing_imports = True
 [mypy-distlib.version]
 ignore_missing_imports = True
 
+[mypy-pip]
+ignore_missing_imports = True
+
+[mypy-pip._vendor]
+ignore_missing_imports = True
+
+[mypy-pip._vendor.distlib]
+ignore_missing_imports = True
+
+[mypy-pip._vendor.distlib.database]
+ignore_missing_imports = True
+
+[mypy-pip._vendor.distlib.scripts]
+ignore_missing_imports = True
+
+[mypy-pip._vendor.distlib.version]
+ignore_missing_imports = True
+
 [pylint.messages control]
 # Disable the message, report, category or checker with the given id(s). You
 # can either give multiple identifiers separated by comma (,) or put this
-- 
2.40.1



