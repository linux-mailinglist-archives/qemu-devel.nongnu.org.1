Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2018BA1D824
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Jan 2025 15:23:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcPxC-0008Un-Jq; Mon, 27 Jan 2025 09:19:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcPwS-0008Kl-LQ; Mon, 27 Jan 2025 09:18:29 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcPwP-0002Kd-BI; Mon, 27 Jan 2025 09:18:19 -0500
Received: from localhost.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by isrv.corpit.ru (Postfix) with ESMTP id 2F7E9E0E29;
 Mon, 27 Jan 2025 17:17:39 +0300 (MSK)
Received: by localhost.tls.msk.ru (Postfix, from userid 1000)
 id 655CC51D67; Mon, 27 Jan 2025 17:18:03 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Liu Jaloo <liu.jaloo@gmail.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.2.1 05/41] roms: re-add edk2-basetools target
Date: Mon, 27 Jan 2025 17:17:19 +0300
Message-Id: <20250127141803.3514882-5-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.2.1-20250127154029@cover.tls.msk.ru>
References: <qemu-stable-9.2.1-20250127154029@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Gerd Hoffmann <kraxel@redhat.com>

Needed to build ipxe nic roms.

Reported-by: Liu Jaloo <liu.jaloo@gmail.com>
Fixes: 22e11539e167 ("edk2: replace build scripts")
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20241212084408.1390728-1-kraxel@redhat.com>
(cherry picked from commit 0f5715e4b5706b31b3550d8e6b88871e029c7823)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/roms/Makefile b/roms/Makefile
index dfed2b216a..31e4b97c98 100644
--- a/roms/Makefile
+++ b/roms/Makefile
@@ -157,6 +157,11 @@ edk2-version: edk2
 		touch $@; \
 	fi
 
+edk2-basetools: edk2-version
+	$(PYTHON) edk2-build.py --config edk2-build.config \
+		--silent --no-logs \
+		--match none # build only basetools
+
 efi: edk2-version
 	$(PYTHON) edk2-build.py --config edk2-build.config \
 		--version-override "$(EDK2_STABLE)$(FIRMWARE_EXTRAVERSION)" \
-- 
2.39.5


