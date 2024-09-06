Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD4C96F2D2
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Sep 2024 13:21:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smWza-0004pz-4y; Fri, 06 Sep 2024 07:19:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smWzW-0004av-2f; Fri, 06 Sep 2024 07:19:02 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smWzU-0008Hs-66; Fri, 06 Sep 2024 07:19:01 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5967A8C4AC;
 Fri,  6 Sep 2024 14:12:10 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 65FD0133715;
 Fri,  6 Sep 2024 14:13:28 +0300 (MSK)
Received: (nullmailer pid 353739 invoked by uid 1000);
 Fri, 06 Sep 2024 11:13:25 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Alyssa Ross <hi@alyssa.is>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.0.3 59/69] target/hexagon: don't look for static glib
Date: Fri,  6 Sep 2024 14:13:08 +0300
Message-Id: <20240906111324.353230-59-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-9.0.3-20240906141259@cover.tls.msk.ru>
References: <qemu-stable-9.0.3-20240906141259@cover.tls.msk.ru>
MIME-Version: 1.0
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

From: Alyssa Ross <hi@alyssa.is>

When cross compiling QEMU configured with --static, I've been getting
configure errors like the following:

    Build-time dependency glib-2.0 found: NO

    ../target/hexagon/meson.build:303:15: ERROR: Dependency lookup for glib-2.0 with method 'pkgconfig' failed: Could not generate libs for glib-2.0:
    Package libpcre2-8 was not found in the pkg-config search path.
    Perhaps you should add the directory containing `libpcre2-8.pc'
    to the PKG_CONFIG_PATH environment variable
    Package 'libpcre2-8', required by 'glib-2.0', not found

This happens because --static sets the prefer_static Meson option, but
my build machine doesn't have a static libpcre2.  I don't think it
makes sense to insist that native dependencies are static, just
because I want the non-native QEMU binaries to be static.

Signed-off-by: Alyssa Ross <hi@alyssa.is>
Link: https://lore.kernel.org/r/20240805104921.4035256-1-hi@alyssa.is
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit fe68cc0923ebfa0c12e4176f61ec9b363a07a73a)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/hexagon/meson.build b/target/hexagon/meson.build
index fb480afc03..940110c055 100644
--- a/target/hexagon/meson.build
+++ b/target/hexagon/meson.build
@@ -321,7 +321,7 @@ if idef_parser_enabled and 'hexagon-linux-user' in target_dirs
         arguments: ['@INPUT@', '--defines=@OUTPUT1@', '--output=@OUTPUT0@']
     )
 
-    glib_dep = dependency('glib-2.0', native: true)
+    glib_dep = dependency('glib-2.0', native: true, static: false)
 
     idef_parser = executable(
         'idef-parser',
-- 
2.39.2


