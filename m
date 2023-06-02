Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 407BC7207AF
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 18:36:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q57jz-0003s4-DX; Fri, 02 Jun 2023 12:35:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q57jx-0003rh-Ag
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 12:35:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q57jv-0005Cl-DR
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 12:35:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685723698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=WGxFi1my92DPgiQnFv9wo12AG6gKB+d64Q9tnwnE/3g=;
 b=MVgFSkCzyYoqi7cCO6AoeJaU4FdoWugHPO8fnk+KPPhAud82tW3kfMUCdx8kLoPDkhGJtx
 hafAZiTGVyGTi/D8XsGK9hL2MxPEAqa14aGrgOgF3OO7UCoN1o/CNfTvG31ws6ocagVlrO
 yE2D62R+wVb4JRQO57j8wE2MpsS5WjE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-658-CUIYD2L2NX250QRTZ4oe4g-1; Fri, 02 Jun 2023 12:34:56 -0400
X-MC-Unique: CUIYD2L2NX250QRTZ4oe4g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6360B811E86;
 Fri,  2 Jun 2023 16:34:56 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A179E1121314;
 Fri,  2 Jun 2023 16:34:54 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-trivial@nongnu.org
Subject: [PATCH v2] meson.build: Use -Wno-undef only for SDL2 versions that
 need it
Date: Fri,  2 Jun 2023 18:34:52 +0200
Message-Id: <20230602163452.521305-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.171,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
 v2: Compile test code instead of hard-coding the version number

 meson.build | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/meson.build b/meson.build
index a61d3e9b06..a4c69616c3 100644
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
+                     ''', dependencies: sdl, args: '-Wundef')
+    sdl = declare_dependency(compile_args: '-Wno-undef',
+                             dependencies: sdl,
+                             version: sdl.version())
+  endif
   sdl_image = dependency('SDL2_image', required: get_option('sdl_image'),
                          method: 'pkg-config')
 else
-- 
2.31.1


