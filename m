Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCB07370AA
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 17:39:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBdRY-0001St-Pi; Tue, 20 Jun 2023 11:38:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qBdRW-0001RR-M3
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 11:38:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qBdRV-0008A5-0k
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 11:38:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687275532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uhzlrktkW8XP3/ORNnL7RIgIMaMzfBjxRyrhxkI6XR0=;
 b=HpMwY0Doi47fle6vSTBHom2wTPfIvrqWME0QE5c/VLUr4SjS4X3ONvS7Z2eTNLd6TWo8jQ
 xoFH/5m7UV/aWBb8bwInJ9FvwD7neqni/a/RkF6G//ptAciIVsIKirK3iXoeo/+u8fJc9P
 aqHppF8c9t9nrQ6OyOS6/mG6Oyv496M=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-101-W9NujVaNPpeAW2BfDT222A-1; Tue, 20 Jun 2023 11:38:45 -0400
X-MC-Unique: W9NujVaNPpeAW2BfDT222A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BB02C3814966;
 Tue, 20 Jun 2023 15:37:23 +0000 (UTC)
Received: from localhost (unknown [10.39.208.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 55BCE9E9C;
 Tue, 20 Jun 2023 15:37:23 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PATCH v2 1/2] gitlab-ci: grab msys2 meson-logs as artifacts
Date: Tue, 20 Jun 2023 17:37:19 +0200
Message-Id: <20230620153720.514882-2-marcandre.lureau@redhat.com>
In-Reply-To: <20230620153720.514882-1-marcandre.lureau@redhat.com>
References: <20230620153720.514882-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Rename build directory to "build", like most other CI builds.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 .gitlab-ci.d/windows.yml | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/.gitlab-ci.d/windows.yml b/.gitlab-ci.d/windows.yml
index 472bacd2e2..d45794463a 100644
--- a/.gitlab-ci.d/windows.yml
+++ b/.gitlab-ci.d/windows.yml
@@ -11,6 +11,11 @@
   needs: []
   stage: build
   timeout: 80m
+  artifacts:
+    name: "$CI_JOB_NAME-$CI_COMMIT_REF_SLUG"
+    expire_in: 7 days
+    paths:
+      - build/meson-logs/testlog.txt
   before_script:
   - If ( !(Test-Path -Path msys64\var\cache ) ) {
       mkdir msys64\var\cache
@@ -65,8 +70,8 @@ msys2-64bit:
   - $env:CHERE_INVOKING = 'yes'  # Preserve the current working directory
   - $env:MSYSTEM = 'MINGW64'     # Start a 64-bit MinGW environment
   - $env:MSYS = 'winsymlinks:native' # Enable native Windows symlink
-  - mkdir output
-  - cd output
+  - mkdir build
+  - cd build
   # Note: do not remove "--without-default-devices"!
   # commit 9f8e6cad65a6 ("gitlab-ci: Speed up the msys2-64bit job by using --without-default-devices"
   # changed to compile QEMU with the --without-default-devices switch
@@ -115,8 +120,8 @@ msys2-32bit:
   - $env:CHERE_INVOKING = 'yes'  # Preserve the current working directory
   - $env:MSYSTEM = 'MINGW32'     # Start a 32-bit MinGW environment
   - $env:MSYS = 'winsymlinks:native' # Enable native Windows symlink
-  - mkdir output
-  - cd output
+  - mkdir build
+  - cd build
   - ..\msys64\usr\bin\bash -lc '../configure --target-list=ppc64-softmmu
                                 --enable-fdt=system'
   - ..\msys64\usr\bin\bash -lc 'make'
-- 
2.40.1


