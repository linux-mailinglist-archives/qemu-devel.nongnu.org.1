Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 868FE86B921
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Feb 2024 21:37:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfQfK-0005ow-5J; Wed, 28 Feb 2024 15:36:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rfQfH-0005gh-Fm; Wed, 28 Feb 2024 15:36:31 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rfQfE-0001Oo-OF; Wed, 28 Feb 2024 15:36:30 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0170351779;
 Wed, 28 Feb 2024 23:35:59 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 95EED8BA81;
 Wed, 28 Feb 2024 23:35:22 +0300 (MSK)
Received: (nullmailer pid 267650 invoked by uid 1000);
 Wed, 28 Feb 2024 20:35:21 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.10 47/47] tests/vm: avoid re-building the VM images all
 the time
Date: Wed, 28 Feb 2024 23:35:15 +0300
Message-Id: <20240228203521.267565-14-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.10-20240228233111@cover.tls.msk.ru>
References: <qemu-stable-7.2.10-20240228233111@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Alex Bennée <alex.bennee@linaro.org>

The main problem is that "check-venv" is a .PHONY target will always
evaluate and trigger a full re-build of the VM images. While its
tempting to drop it from the dependencies that does introduce a
breakage on freshly configured builds.

Fortunately we do have the otherwise redundant --force flag for the
script which up until now was always on. If we make the usage of
--force conditional on dependencies other than check-venv triggering
the update we can avoid the costly rebuild and still run cleanly on a
fresh checkout.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2118
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240227144335.1196131-4-alex.bennee@linaro.org>
(cherry picked from commit 151b7dba391fab64cc008a1fdba6ddcf6f8c39c8)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index 2cc2203d09..e332fd13c3 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -103,7 +103,7 @@ $(IMAGES_DIR)/%.img:	$(SRC_PATH)/tests/vm/% \
 		$(if $(LOG_CONSOLE),--log-console) \
 		--source-path $(SRC_PATH) \
 		--image "$@" \
-		--force \
+		$(if $(filter-out check-venv, $?), --force) \
 		--build-image $@, \
 		"  VM-IMAGE $*")
 
diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 2276364c42..6a54d9d4e0 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -634,9 +634,9 @@ def main(vmcls, config=None):
         vm = vmcls(args, config=config)
         if args.build_image:
             if os.path.exists(args.image) and not args.force:
-                sys.stderr.writelines(["Image file exists: %s\n" % args.image,
+                sys.stderr.writelines(["Image file exists, skipping build: %s\n" % args.image,
                                       "Use --force option to overwrite\n"])
-                return 1
+                return 0
             return vm.build_image(args.image)
         if args.build_qemu:
             vm.add_source_dir(args.build_qemu)
-- 
2.39.2


