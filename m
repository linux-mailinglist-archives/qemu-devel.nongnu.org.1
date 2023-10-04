Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B737B79B5
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:09:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnwuA-0006Cr-OD; Wed, 04 Oct 2023 04:06:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qnwrL-0007AF-8h; Wed, 04 Oct 2023 04:03:56 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qnwrI-00008K-Ra; Wed, 04 Oct 2023 04:03:54 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8D7A02759F;
 Wed,  4 Oct 2023 11:02:26 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id E33722CBDB;
 Wed,  4 Oct 2023 11:02:25 +0300 (MSK)
Received: (nullmailer pid 2702813 invoked by uid 1000);
 Wed, 04 Oct 2023 08:02:21 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.1.2 21/45] meson.build: Make keyutils independent from
 keyring
Date: Wed,  4 Oct 2023 11:01:42 +0300
Message-Id: <20231004080221.2702636-21-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.1.2-20231003193203@cover.tls.msk.ru>
References: <qemu-stable-8.1.2-20231003193203@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Thomas Huth <thuth@redhat.com>

Commit 0db0fbb5cf ("Add conditional dependency for libkeyutils")
tried to provide a possibility for the user to disable keyutils
if not required by makeing it depend on the keyring feature. This
looked reasonable at a first glance (the unit test in tests/unit/
needs both), but the condition in meson.build fails if the feature
is meant to be detected automatically, and there is also another
spot in backends/meson.build where keyutils is used independently
from keyring. So let's remove the dependency on keyring again and
introduce a proper meson build option instead.

Cc: qemu-stable@nongnu.org
Fixes: 0db0fbb5cf ("Add conditional dependency for libkeyutils")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1842
Message-ID: <20230824094208.255279-1-thuth@redhat.com>
Reviewed-by: "Daniel P. Berrangé" <berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit c64023b0ba677cfa6b878e82ea8e18507a597396)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/meson.build b/meson.build
index 912c7e7847..a9c4f28247 100644
--- a/meson.build
+++ b/meson.build
@@ -1771,8 +1771,9 @@ if gnutls.found()
                      method: 'pkg-config')
 endif
 keyutils = not_found
-if get_option('keyring').enabled()
-  keyutils = dependency('libkeyutils', required: false, method: 'pkg-config')
+if not get_option('libkeyutils').auto() or have_block
+  keyutils = dependency('libkeyutils', required: get_option('libkeyutils'),
+                        method: 'pkg-config')
 endif
 
 has_gettid = cc.has_function('gettid')
@@ -4211,6 +4212,7 @@ endif
 summary_info += {'AF_ALG support':    have_afalg}
 summary_info += {'rng-none':          get_option('rng_none')}
 summary_info += {'Linux keyring':     have_keyring}
+summary_info += {'Linux keyutils':    keyutils}
 summary(summary_info, bool_yn: true, section: 'Crypto')
 
 # UI
diff --git a/meson_options.txt b/meson_options.txt
index aaea5ddd77..ae6d8f469d 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -119,6 +119,8 @@ option('avx512bw', type: 'feature', value: 'auto',
        description: 'AVX512BW optimizations')
 option('keyring', type: 'feature', value: 'auto',
        description: 'Linux keyring support')
+option('libkeyutils', type: 'feature', value: 'auto',
+       description: 'Linux keyutils support')
 
 option('attr', type : 'feature', value : 'auto',
        description: 'attr/xattr support')
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 9da3fe299b..d7020af175 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -120,6 +120,7 @@ meson_options_help() {
   printf "%s\n" '  libdaxctl       libdaxctl support'
   printf "%s\n" '  libdw           debuginfo support'
   printf "%s\n" '  libiscsi        libiscsi userspace initiator'
+  printf "%s\n" '  libkeyutils     Linux keyutils support'
   printf "%s\n" '  libnfs          libnfs block device driver'
   printf "%s\n" '  libpmem         libpmem support'
   printf "%s\n" '  libssh          ssh block device support'
@@ -341,6 +342,8 @@ _meson_option_parse() {
     --libexecdir=*) quote_sh "-Dlibexecdir=$2" ;;
     --enable-libiscsi) printf "%s" -Dlibiscsi=enabled ;;
     --disable-libiscsi) printf "%s" -Dlibiscsi=disabled ;;
+    --enable-libkeyutils) printf "%s" -Dlibkeyutils=enabled ;;
+    --disable-libkeyutils) printf "%s" -Dlibkeyutils=disabled ;;
     --enable-libnfs) printf "%s" -Dlibnfs=enabled ;;
     --disable-libnfs) printf "%s" -Dlibnfs=disabled ;;
     --enable-libpmem) printf "%s" -Dlibpmem=enabled ;;
-- 
2.39.2


