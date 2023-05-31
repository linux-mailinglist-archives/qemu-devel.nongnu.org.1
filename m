Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C93F0717C2E
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 11:40:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4IIa-0002kH-VD; Wed, 31 May 2023 05:39:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q4IIY-0002jx-JF
 for qemu-devel@nongnu.org; Wed, 31 May 2023 05:39:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q4IIW-0000xA-MO
 for qemu-devel@nongnu.org; Wed, 31 May 2023 05:39:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685525954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=9QK+UhQAgVdnI3YmdJT9YZjXN3XflW0VipyXGTbuJTc=;
 b=WeVjc3LpBtlRpaUIbVXe7pNcLObJ7oKhUmemnMoaE7DEFQecbUBFzH5bOFEXokIzt9UtNy
 MSGabbH26JsbDMr/FFqPBTEdRSeJ0jIVbXM/p34MPCkj1Fo/xLYofmzln29AGM4jQLuAeN
 cqiBad59NNz4SaNYHU8CCN4WF94BolQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-435-Ssc-fQZ4OHulATOYGvtLHg-1; Wed, 31 May 2023 05:39:10 -0400
X-MC-Unique: Ssc-fQZ4OHulATOYGvtLHg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 84B5438009F3;
 Wed, 31 May 2023 09:39:10 +0000 (UTC)
Received: from thuth.com (unknown [10.39.193.207])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5E2D6492B00;
 Wed, 31 May 2023 09:39:09 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-trivial@nongnu.org
Subject: [PATCH] meson.build: Use -Wno-undef only for SDL 2.0.8 and older
Date: Wed, 31 May 2023 11:39:02 +0200
Message-Id: <20230531093902.70695-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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

There is no need to disable this useful compiler warning for
newer versions of the SDL anymore.

This also enables the printing of the version number with
newer versions of the SDL in the summary of the meson output
again.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 meson.build | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/meson.build b/meson.build
index bc76ea96bf..8ccd928dca 100644
--- a/meson.build
+++ b/meson.build
@@ -1273,10 +1273,12 @@ if not get_option('sdl').auto() or have_system
   sdl_image = not_found
 endif
 if sdl.found()
-  # work around 2.0.8 bug
-  sdl = declare_dependency(compile_args: '-Wno-undef',
-                           dependencies: sdl,
-                           version: sdl.version())
+  if sdl.version().version_compare('<=2.0.8')
+    # work around 2.0.8 bug
+    sdl = declare_dependency(compile_args: '-Wno-undef',
+                             dependencies: sdl,
+                             version: sdl.version())
+  endif
   sdl_image = dependency('SDL2_image', required: get_option('sdl_image'),
                          method: 'pkg-config')
 else
-- 
2.31.1


