Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2799C2BB5
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Nov 2024 11:24:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9ibg-0005gI-Vc; Sat, 09 Nov 2024 05:22:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9iWb-0006Tl-0K; Sat, 09 Nov 2024 05:17:01 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9iWY-000879-6w; Sat, 09 Nov 2024 05:17:00 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id CEEBBA1402;
 Sat,  9 Nov 2024 13:13:50 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 79DC0167EED;
 Sat,  9 Nov 2024 13:14:45 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.8 29/49] dockerfiles: fix default targets for
 debian-loongarch-cross
Date: Sat,  9 Nov 2024 13:14:20 +0300
Message-Id: <20241109101443.312701-29-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-8.2.8-20241109131339@cover.tls.msk.ru>
References: <qemu-stable-8.2.8-20241109131339@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

fix system target name, and remove --disable-system (which deactivates
system target).

Found using: make docker-test-build@debian-loongarch-cross V=1

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20241020213759.2168248-1-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20241023113406.1284676-10-alex.bennee@linaro.org>
(cherry picked from commit 24be5341fbeea341cca38b59d4c0928a8cf5fac1)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/docker/dockerfiles/debian-loongarch-cross.docker b/tests/docker/dockerfiles/debian-loongarch-cross.docker
index 6a9197528b..576e35972f 100644
--- a/tests/docker/dockerfiles/debian-loongarch-cross.docker
+++ b/tests/docker/dockerfiles/debian-loongarch-cross.docker
@@ -42,8 +42,8 @@ RUN curl -#SL https://github.com/loongson/build-tools/releases/download/2023.08.
 ENV PATH $PATH:/opt/cross-tools/bin
 ENV LD_LIBRARY_PATH /opt/cross-tools/lib:/opt/cross-tools/loongarch64-unknown-linux-gnu/lib:$LD_LIBRARY_PATH
 
-ENV QEMU_CONFIGURE_OPTS --disable-system --disable-docs --disable-tools
-ENV DEF_TARGET_LIST loongarch64-linux-user,loongarch-softmmu
+ENV QEMU_CONFIGURE_OPTS --disable-docs --disable-tools
+ENV DEF_TARGET_LIST loongarch64-linux-user,loongarch64-softmmu
 ENV MAKE /usr/bin/make
 
 # As a final step configure the user (if env is defined)
-- 
2.39.5


