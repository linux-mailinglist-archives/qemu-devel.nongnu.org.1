Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C08C974DDC
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Sep 2024 11:03:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soJEn-0006Tm-0T; Wed, 11 Sep 2024 05:02:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1soJEk-0006Sg-Ep
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 05:02:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1soJEi-0002e9-HA
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 05:02:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726045322;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=mhuEvwyaAjZlgTnymRKgOpJT82CF8hhrdhl2avmzOmk=;
 b=EFlYFhj0sKqDNcWsWsVag1JLd3G99rEgk6/o/9BsD0SMKG8EdfBftzpTtgknBCMgUtnvXS
 kzCKaX4nI8OvQEm0zBJ5He1tbXm9c/y/+ePFYAr20j6Fxj06rkRgL+T77S3nO4DCsm7tbH
 uIZOKKg+G9q9XHkoKawQxrpiiW+DdUQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-454-1EwAuvG4OoicuaJjUsQgrQ-1; Wed,
 11 Sep 2024 05:01:57 -0400
X-MC-Unique: 1EwAuvG4OoicuaJjUsQgrQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8CE561955EA8; Wed, 11 Sep 2024 09:01:55 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.18])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E87D419560AB; Wed, 11 Sep 2024 09:01:51 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Ed Maste <emaste@freebsd.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] Update FreeBSD CI jobs FreeBSD 14.1
Date: Wed, 11 Sep 2024 11:01:49 +0200
Message-ID: <20240911090149.286257-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The current FreeBSD CI jobs are failing installation since the
"opencv" package is now missing there. Updating to 14.1 fixes
the issue.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 Here's the output of a successful run:
 https://gitlab.com/thuth/qemu/-/jobs/7795460644

 .gitlab-ci.d/cirrus.yml                                  | 6 +++---
 .gitlab-ci.d/cirrus/{freebsd-13.vars => freebsd-14.vars} | 2 +-
 tests/lcitool/refresh                                    | 4 ++--
 tests/vm/freebsd                                         | 6 +++---
 4 files changed, 9 insertions(+), 9 deletions(-)
 rename .gitlab-ci.d/cirrus/{freebsd-13.vars => freebsd-14.vars} (95%)

diff --git a/.gitlab-ci.d/cirrus.yml b/.gitlab-ci.d/cirrus.yml
index 75df1273bc..92c97eefc1 100644
--- a/.gitlab-ci.d/cirrus.yml
+++ b/.gitlab-ci.d/cirrus.yml
@@ -46,13 +46,13 @@
   variables:
     QEMU_JOB_CIRRUS: 1
 
-x64-freebsd-13-build:
+x64-freebsd-14-build:
   extends: .cirrus_build_job
   variables:
-    NAME: freebsd-13
+    NAME: freebsd-14
     CIRRUS_VM_INSTANCE_TYPE: freebsd_instance
     CIRRUS_VM_IMAGE_SELECTOR: image_family
-    CIRRUS_VM_IMAGE_NAME: freebsd-13-3
+    CIRRUS_VM_IMAGE_NAME: freebsd-14-1
     CIRRUS_VM_CPUS: 8
     CIRRUS_VM_RAM: 8G
     UPDATE_COMMAND: pkg update; pkg upgrade -y
diff --git a/.gitlab-ci.d/cirrus/freebsd-13.vars b/.gitlab-ci.d/cirrus/freebsd-14.vars
similarity index 95%
rename from .gitlab-ci.d/cirrus/freebsd-13.vars
rename to .gitlab-ci.d/cirrus/freebsd-14.vars
index 69c948b503..aba0eff4b9 100644
--- a/.gitlab-ci.d/cirrus/freebsd-13.vars
+++ b/.gitlab-ci.d/cirrus/freebsd-14.vars
@@ -1,6 +1,6 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool variables freebsd-13 qemu
+#  $ lcitool variables freebsd-14 qemu
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index ac803e34f1..290804f6be 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -207,14 +207,14 @@ try:
     #
     # Cirrus packages lists for GitLab
     #
-    generate_cirrus("freebsd-13")
+    generate_cirrus("freebsd-14")
     generate_cirrus("macos-13")
     generate_cirrus("macos-14")
 
     #
     # VM packages lists
     #
-    generate_pkglist("freebsd", "freebsd-13")
+    generate_pkglist("freebsd", "freebsd-14")
 
     #
     # Ansible package lists
diff --git a/tests/vm/freebsd b/tests/vm/freebsd
index 1247f40a38..74b3b1e520 100755
--- a/tests/vm/freebsd
+++ b/tests/vm/freebsd
@@ -28,8 +28,8 @@ class FreeBSDVM(basevm.BaseVM):
     name = "freebsd"
     arch = "x86_64"
 
-    link = "https://download.freebsd.org/releases/CI-IMAGES/13.2-RELEASE/amd64/Latest/FreeBSD-13.2-RELEASE-amd64-BASIC-CI.raw.xz"
-    csum = "a4fb3b6c7b75dd4d58fb0d75e4caf72844bffe0ca00e66459c028b198ffb3c0e"
+    link = "https://download.freebsd.org/releases/CI-IMAGES/14.1-RELEASE/amd64/Latest/FreeBSD-14.1-RELEASE-amd64-BASIC-CI.raw.xz"
+    csum = "202fe27a05427f0a86d3ebb97712745186f2776ccc4f70d95466dd99a0238ba5"
     size = "20G"
 
     BUILD_SCRIPT = """
@@ -39,7 +39,7 @@ class FreeBSDVM(basevm.BaseVM):
         mkdir src build; cd src;
         tar -xf /dev/vtbd1;
         cd ../build;
-        ../src/configure --python=python3.9  --extra-ldflags=-L/usr/local/lib \
+        ../src/configure --extra-ldflags=-L/usr/local/lib \
                          --extra-cflags=-I/usr/local/include {configure_opts};
         gmake --output-sync -j{jobs} {target} {verbose};
     """
-- 
2.46.0


