Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C7D786C33
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 11:43:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ6rD-0000EF-OX; Thu, 24 Aug 2023 05:42:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qZ6r7-0000Cy-Iw
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:42:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qZ6r2-0007nM-I0
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:42:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692870135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=fPqq38AXgkQboPcVp25qUUjyBIQhzkIroRGzqY6tK8o=;
 b=BjHWVUBITFUsFJgxnmOT42RHwc/ntR9JwJZCYMJAZCo82nbWl7GOdvacX8IY//xkOSRjTL
 03mgNNLqBUg4WVAAc4ZfZyiVjkAe+Px1FUcDCe6fxOTdLrjsuQGkby9OUYr5j25/gzfNEc
 0L7lwjul1IvTBe12253RK6GWNckOU8s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-687-7vFW__TnPWOtvwOIZrbz2w-1; Thu, 24 Aug 2023 05:42:12 -0400
X-MC-Unique: 7vFW__TnPWOtvwOIZrbz2w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 545A0853064;
 Thu, 24 Aug 2023 09:42:12 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.175])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CD7454A9004;
 Thu, 24 Aug 2023 09:42:10 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 antischmock@googlemail.com
Subject: [PATCH] meson.build: Make keyutils independent from keyring
Date: Thu, 24 Aug 2023 11:42:08 +0200
Message-Id: <20230824094208.255279-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 meson.build                   | 6 ++++--
 meson_options.txt             | 2 ++
 scripts/meson-buildoptions.sh | 3 +++
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/meson.build b/meson.build
index 98e68ef0b1..5756148576 100644
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
2.39.3


