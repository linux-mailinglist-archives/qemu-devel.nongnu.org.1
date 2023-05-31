Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CA2717B32
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 11:06:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4HlF-0003As-4v; Wed, 31 May 2023 05:04:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q4Hkm-000360-TV
 for qemu-devel@nongnu.org; Wed, 31 May 2023 05:04:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q4Hkk-0001Rd-MU
 for qemu-devel@nongnu.org; Wed, 31 May 2023 05:04:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685523860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Ua5483nqV/kfxJNCI7crpWVceG+bcM8BZx57LQ+ivA0=;
 b=CxNMuks4T8jAk44ianTeCwUAYvUWjvcT/DFtXx7M0StRSCIc1NebPwrVTo2NDfxbcksoUH
 u4nGGNF/4dsjqh5j6rA/ISCbOgzZi4T0EABsOMOxweobVhXzVauzoeUyHhZrcaCuemv++z
 ifyXZ5vl9TPk37ST3eS5TLyOcJpYtFk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-142-wkz8pVrzNZCxNCQfDg5AhQ-1; Wed, 31 May 2023 05:04:19 -0400
X-MC-Unique: wkz8pVrzNZCxNCQfDg5AhQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8C3C5811E8E;
 Wed, 31 May 2023 09:04:18 +0000 (UTC)
Received: from thuth.com (unknown [10.39.193.207])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 26964112132C;
 Wed, 31 May 2023 09:04:17 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ed Maste <emaste@freebsd.org>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] tests/vm/freebsd: Install more feature libraries in the
 FreeBSD VM
Date: Wed, 31 May 2023 11:04:15 +0200
Message-Id: <20230531090415.40421-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
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

The standalone freebsd VM image misses a lot of libraries compared
to the image that we use in the Gitlab-CI (see the file
.gitlab-ci.d/cirrus/freebsd-13.vars). Let's extend the list here
and while we're at it, re-arrange the list in alphabetical order
without the cumbersome grouping into categories.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/vm/freebsd | 76 +++++++++++++++++++++++++++++-------------------
 1 file changed, 46 insertions(+), 30 deletions(-)

diff --git a/tests/vm/freebsd b/tests/vm/freebsd
index 11de6473f4..8143637905 100755
--- a/tests/vm/freebsd
+++ b/tests/vm/freebsd
@@ -32,43 +32,59 @@ class FreeBSDVM(basevm.BaseVM):
     csum = "a4fb3b6c7b75dd4d58fb0d75e4caf72844bffe0ca00e66459c028b198ffb3c0e"
     size = "20G"
     pkgs = [
-        # build tools
-        "git",
-        "pkgconf",
-        "bzip2",
-        "python39",
-        "ninja",
-
-        # gnu tools
+        "alsa-lib",
         "bash",
-        "gmake",
-        "gsed",
+        "bison",
+        "bzip2",
+        "capstone4",
+        "curl",
+        "cyrus-sasl",
+        "dbus",
+        "diffutils",
+        "dtc",
+        "flex",
+        "fusefs-libs3",
         "gettext",
-
-        # libs: crypto
+        "git",
+        "glib",
+        "gmake",
         "gnutls",
-
-        # libs: images
-        "jpeg-turbo",
-        "png",
-
-        # libs: ui
-        "sdl2",
+        "gsed",
         "gtk3",
-        "libxkbcommon",
-
-        # libs: opengl
         "libepoxy",
-        "mesa-libs",
-
-        # libs: migration
-        "zstd",
-
-        # libs: networking
+        "libffi",
+        "libgcrypt",
+        "libjpeg-turbo",
+        "libnfs",
         "libslirp",
-
-        # libs: sndio
+        "libspice-server",
+        "libssh",
+        "libtasn1",
+        "libxkbcommon",
+        "lzo2",
+        "mesa-libs",
+        "meson",
+        "ncurses",
+        "nettle",
+        "ninja",
+        "pixman",
+        "pkgconf",
+        "png",
+        "py39-pip",
+        "py39-sphinx",
+        "py39-sphinx_rtd_theme",
+        "py39-yaml",
+        "python3",
+        "sdl2",
+        "sdl2_image",
+        "snappy",
         "sndio",
+        "spice-protocol",
+        "usbredir",
+        "virglrenderer",
+        "vte3",
+        "xorriso",
+        "zstd",
     ]
 
     BUILD_SCRIPT = """
-- 
2.31.1


