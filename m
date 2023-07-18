Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E788757816
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 11:32:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLh2x-000452-32; Tue, 18 Jul 2023 05:31:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qLh2p-00043s-3N
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 05:30:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qLh2m-0004FQ-Gr
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 05:30:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689672655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=10Hf9TvKlJRB2JDOPZ02jBkzxfqVji3pOM00MBYZzzw=;
 b=PgUXitdI614OMh1JvFPCBEVudaDiUIKm4/VqwTmDvGR+ZJwOLd05suA1t6VqfUPT2eSeUR
 MHQI/6rB6fvq8rPYuN8qLvsCcVVoivuFkgDBNOmg6nmB3J8SJoqqUu02MTBa8P49CvY4Y+
 qmPWJwsjbnLx2VV1X4gCyn2dOESItRw=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-6-ueNHjiWHNzW0QdLTtlqOhQ-1; Tue, 18 Jul 2023 05:30:52 -0400
X-MC-Unique: ueNHjiWHNzW0QdLTtlqOhQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1C26A3C13920;
 Tue, 18 Jul 2023 09:30:52 +0000 (UTC)
Received: from thuth.com (unknown [10.39.193.89])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2147F2166B25;
 Tue, 18 Jul 2023 09:30:50 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 7/8] tests/vm/freebsd: Get up-to-date package list from lcitool
 vars file
Date: Tue, 18 Jul 2023 11:30:39 +0200
Message-Id: <20230718093040.172145-8-thuth@redhat.com>
In-Reply-To: <20230718093040.172145-1-thuth@redhat.com>
References: <20230718093040.172145-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Get an up-to-date package list from lcitool, that way we
don't need to manually keep this array in sync.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Inspired-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20230711144922.67491-5-philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/vm/freebsd | 42 ++----------------------------------------
 1 file changed, 2 insertions(+), 40 deletions(-)

diff --git a/tests/vm/freebsd b/tests/vm/freebsd
index 11de6473f4..ac51376c82 100755
--- a/tests/vm/freebsd
+++ b/tests/vm/freebsd
@@ -31,45 +31,6 @@ class FreeBSDVM(basevm.BaseVM):
     link = "https://download.freebsd.org/releases/CI-IMAGES/13.2-RELEASE/amd64/Latest/FreeBSD-13.2-RELEASE-amd64-BASIC-CI.raw.xz"
     csum = "a4fb3b6c7b75dd4d58fb0d75e4caf72844bffe0ca00e66459c028b198ffb3c0e"
     size = "20G"
-    pkgs = [
-        # build tools
-        "git",
-        "pkgconf",
-        "bzip2",
-        "python39",
-        "ninja",
-
-        # gnu tools
-        "bash",
-        "gmake",
-        "gsed",
-        "gettext",
-
-        # libs: crypto
-        "gnutls",
-
-        # libs: images
-        "jpeg-turbo",
-        "png",
-
-        # libs: ui
-        "sdl2",
-        "gtk3",
-        "libxkbcommon",
-
-        # libs: opengl
-        "libepoxy",
-        "mesa-libs",
-
-        # libs: migration
-        "zstd",
-
-        # libs: networking
-        "libslirp",
-
-        # libs: sndio
-        "sndio",
-    ]
 
     BUILD_SCRIPT = """
         set -e;
@@ -151,8 +112,9 @@ class FreeBSDVM(basevm.BaseVM):
         self.console_wait(prompt)
         self.console_send("echo 'chmod 666 /dev/vtbd1' >> /etc/rc.local\n")
 
+        pkgs = self.get_qemu_packages_from_lcitool_json()
         self.print_step("Installing packages")
-        self.ssh_root_check("pkg install -y %s\n" % " ".join(self.pkgs))
+        self.ssh_root_check("pkg install -y %s\n" % " ".join(pkgs))
 
         # shutdown
         self.ssh_root(self.poweroff)
-- 
2.39.3


