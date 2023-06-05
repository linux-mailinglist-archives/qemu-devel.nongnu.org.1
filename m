Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C777224DC
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 13:46:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q68eX-00063X-Hs; Mon, 05 Jun 2023 07:45:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q68eU-000634-7D
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 07:45:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q68eP-0002mB-Qp
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 07:45:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685965528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=5aKpoTPURF7rJUwo6fAYiL6PaEeqwqDalfN1WGpeTHE=;
 b=T0fooWnJ0dBenNewDookBYyI7pNpFVqOaJ8qm2aL+bbmniZYxX3AAd3ZmmaEgMNNr4affy
 G48IyITHcsDG6HJJQMNVJj3eiU3X9gH8RpPX4VrF0YPuWIp/nqPO2uIu+p6Fu/7CxjOx5i
 Ma/THJ63o15SGb4cg6XgLqz9pUIvP6c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-494-iw5ZaIg1MheH2FCzaOy0-w-1; Mon, 05 Jun 2023 07:45:27 -0400
X-MC-Unique: iw5ZaIg1MheH2FCzaOy0-w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3FA9C185A78E;
 Mon,  5 Jun 2023 11:45:27 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.97])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 181252026D49;
 Mon,  5 Jun 2023 11:45:25 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Subject: [PATCH v3] meson.build: Use -Wno-undef only for SDL2 versions that
 need it
Date: Mon,  5 Jun 2023 13:45:23 +0200
Message-Id: <20230605114523.282987-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

There is no need to disable this useful compiler warning for
all versions of the SDL. Unfortunately, various versions are
buggy (beside SDL 2.0.8, the version 2.26.0 and 2.26.1 are
broken, too, see https://github.com/libsdl-org/SDL/issues/6619 ),
but we can use a simple compiler check to see whether we need
the -Wno-undef or not.

This also enables the printing of the version number with
good versions of the SDL in the summary of the meson output
again.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v3: Use -Werror to make sure that compiler fails when there is an issue

 meson.build | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/meson.build b/meson.build
index a61d3e9b06..59b65c3bf5 100644
--- a/meson.build
+++ b/meson.build
@@ -1273,10 +1273,16 @@ if not get_option('sdl').auto() or have_system
   sdl_image = not_found
 endif
 if sdl.found()
-  # work around 2.0.8 bug
-  sdl = declare_dependency(compile_args: '-Wno-undef',
-                           dependencies: sdl,
-                           version: sdl.version())
+  # Some versions of SDL have problems with -Wundef
+  if not cc.compiles('''
+                     #include <SDL.h>
+                     #include <SDL_syswm.h>
+                     int main(int argc, char *argv[]) { return 0; }
+                     ''', dependencies: sdl, args: '-Werror=undef')
+    sdl = declare_dependency(compile_args: '-Wno-undef',
+                             dependencies: sdl,
+                             version: sdl.version())
+  endif
   sdl_image = dependency('SDL2_image', required: get_option('sdl_image'),
                          method: 'pkg-config')
 else
-- 
2.31.1


