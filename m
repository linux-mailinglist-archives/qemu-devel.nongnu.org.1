Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C82E67E6B70
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 14:47:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r15Mu-00075E-2A; Thu, 09 Nov 2023 08:46:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15M8-0006N6-8Q; Thu, 09 Nov 2023 08:46:00 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15M6-0001qO-Ep; Thu, 09 Nov 2023 08:45:59 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A3F8931B15;
 Thu,  9 Nov 2023 16:43:13 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 99390344BB;
 Thu,  9 Nov 2023 16:43:05 +0300 (MSK)
Received: (nullmailer pid 1461848 invoked by uid 1000);
 Thu, 09 Nov 2023 13:43:02 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Denis V. Lunev" <den@openvz.org>, Juan Quintela <quintela@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.1.3 29/55] util/uuid: Remove UUID_FMT_LEN
Date: Thu,  9 Nov 2023 16:42:33 +0300
Message-Id: <20231109134300.1461632-29-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.1.3-20231109164030@cover.tls.msk.ru>
References: <qemu-stable-8.1.3-20231109164030@cover.tls.msk.ru>
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

From: Cédric Le Goater <clg@redhat.com>

Dangerous and now unused.

Cc: Fam Zheng <fam@euphon.net>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: "Denis V. Lunev" <den@openvz.org>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
(cherry picked from commit 4ef9d97b1a37b8cfd152cc3ac5f9576e406868b1)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/include/qemu/uuid.h b/include/qemu/uuid.h
index 9e160d65aa..008926ab32 100644
--- a/include/qemu/uuid.h
+++ b/include/qemu/uuid.h
@@ -78,8 +78,7 @@ typedef struct {
                  "%02hhx%02hhx-" \
                  "%02hhx%02hhx%02hhx%02hhx%02hhx%02hhx"
 
-#define UUID_FMT_LEN 36
-#define UUID_STR_LEN (UUID_FMT_LEN + 1)
+#define UUID_STR_LEN (36 + 1)
 
 #define UUID_NONE "00000000-0000-0000-0000-000000000000"
 
-- 
2.39.2


