Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D81A97C981C
	for <lists+qemu-devel@lfdr.de>; Sun, 15 Oct 2023 08:09:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qruI6-0001xK-Ao; Sun, 15 Oct 2023 02:07:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qruI2-0001wL-0G; Sun, 15 Oct 2023 02:07:50 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qruHy-0002QJ-CO; Sun, 15 Oct 2023 02:07:49 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 74F0E2A695;
 Sun, 15 Oct 2023 09:07:52 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 8A9102F2FE;
 Sun, 15 Oct 2023 09:07:39 +0300 (MSK)
Received: (nullmailer pid 129206 invoked by uid 1000);
 Sun, 15 Oct 2023 06:07:39 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Olaf Hering <olaf@aepfle.de>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.1.2 62/64] roms: use PYTHON to invoke python
Date: Sun, 15 Oct 2023 09:07:17 +0300
Message-Id: <20231015060739.129177-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.1.2-20231015090447@cover.tls.msk.ru>
References: <qemu-stable-8.1.2-20231015090447@cover.tls.msk.ru>
MIME-Version: 1.0
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

From: Olaf Hering <olaf@aepfle.de>

python3 may not be the expected python version.
Use PYTHON to invoke python.

Fixes: 22e11539e1 ("edk2: replace build scripts")

Signed-off-by: Olaf Hering <olaf@aepfle.de>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(cherry picked from commit 17b8d8ac3309e2cfed0d8cb3861afdcc23f66ce0)

diff --git a/roms/Makefile b/roms/Makefile
index 6859685290..67f709ba2d 100644
--- a/roms/Makefile
+++ b/roms/Makefile
@@ -147,7 +147,7 @@ skiboot:
 	cp skiboot/skiboot.lid ../pc-bios/skiboot.lid
 
 efi:
-	python3 edk2-build.py --config edk2-build.config \
+	$(PYTHON) edk2-build.py --config edk2-build.config \
 		--version-override "edk2-stable202302-for-qemu" \
 		--release-date "03/01/2023"
 	rm -f ../pc-bios/edk2-*.fd.bz2
-- 
2.39.2


