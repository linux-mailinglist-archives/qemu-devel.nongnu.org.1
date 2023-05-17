Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BE2706FDC
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 19:47:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzLEY-0008JR-6M; Wed, 17 May 2023 13:46:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLE4-0007ay-DK
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:46:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLE2-0004Gc-Nq
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:46:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684345569;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WaYDq55qknnU8QMRXQL79aAwtuV8ftUSiPH6BPevf0s=;
 b=Vm9vkZpuuJF7WYKYvr6wyyZH06UAuxdoKF5qqzTcIG9X04IydA9afNgBucJ6+1SrhC4r0w
 uGODZEIq7I6gaSFvSpQHUHIftcTYKgS4O7a+D4y8nLpTEH2g3I3URkeCbsivjJvESwcVQu
 5mxYDMxBdewAoAeIutiUFO9Sy52KfXs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-NGa0J2yCP8ioLEW79B3ahw-1; Wed, 17 May 2023 13:46:08 -0400
X-MC-Unique: NGa0J2yCP8ioLEW79B3ahw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f433a2308bso48200955e9.0
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 10:46:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684345566; x=1686937566;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WaYDq55qknnU8QMRXQL79aAwtuV8ftUSiPH6BPevf0s=;
 b=IgxjKoQfctJ7uexwfkocoVMn5MmHQ7gofXPLwJP++K5UWFT05Bj5F6ivm/8Vvt16xq
 QPmvKU2aKTMpXK87XXyw7eama3L8wso+RZ1LRxdvLve4sOApJk7IHDYIQLoBBthmxnnY
 CU2GH/GdGOACKUqz6pwS3Th/FkJcVTQQevMtDra/M2pOpbu1cq6ZcxhtbeuFBCRbmAap
 0vgwd9fgGgkBz2qCFVm5cki37bMROLYm2TeBek0oubFQHnZtpTsDnJ/u0FfsNnA11SGI
 JRY6Np7A585KRSlVRf45bcp8N8ynHfqSyj6S7+2znMbAf6pRkciAHHv9bb9UGkBdwn5q
 WYAw==
X-Gm-Message-State: AC+VfDwloKVt89UdYRG4It8m3q4J2UNADe2xzm/iJKHGS2nvHsB63jYL
 F45MSXZd6R7KzxCyg4EE8w9HAPkwN//+654jp54q0F67E3vNqgqnVRZZJxTwIpuFl9Jx3qA+N+C
 /dKxVZ42gXxjXZL+G+EKHK9QJNIfwx2y93BDjcqkzXaGHEoobcngZk3v5D3HenM08fjdS15LvDq
 Q=
X-Received: by 2002:a5d:5390:0:b0:309:43fe:1b9d with SMTP id
 d16-20020a5d5390000000b0030943fe1b9dmr1214808wrv.29.1684345566556; 
 Wed, 17 May 2023 10:46:06 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ53fv4UeWQam2w4euBseJK2xSLdTTcdMOZvg6DMmaF2K286raysJbe0OZrCAYWk+4QvKQ6rsg==
X-Received: by 2002:a5d:5390:0:b0:309:43fe:1b9d with SMTP id
 d16-20020a5d5390000000b0030943fe1b9dmr1214798wrv.29.1684345566255; 
 Wed, 17 May 2023 10:46:06 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 m39-20020a05600c3b2700b003f07ef4e3e0sm5341583wms.0.2023.05.17.10.46.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 10:46:05 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>
Subject: [PULL 26/68] mkvenv: use pip's vendored distlib as a fallback
Date: Wed, 17 May 2023 19:44:38 +0200
Message-Id: <20230517174520.887405-27-pbonzini@redhat.com>
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
index f17c3d3606ba..fb91f922d2b9 100644
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


