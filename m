Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E0C84E42A
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Feb 2024 16:41:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rY6WP-0005gN-Nn; Thu, 08 Feb 2024 10:41:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rY6WL-0005dx-Tx; Thu, 08 Feb 2024 10:41:01 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rY6WJ-0004pA-KA; Thu, 08 Feb 2024 10:41:01 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id AD9A24B8F1;
 Thu,  8 Feb 2024 18:41:57 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 2EEE576FB6;
 Thu,  8 Feb 2024 18:40:43 +0300 (MSK)
Received: (nullmailer pid 553402 invoked by uid 1000);
 Thu, 08 Feb 2024 15:40:42 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH trivial v2] qemu-options.hx: document that tftp=dir is readonly
Date: Thu,  8 Feb 2024 18:40:38 +0300
Message-Id: <20240208154038.553385-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
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


Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1286
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
v2: include suggestion by Peter.
   Not keeping Reviewed-by tags.

 qemu-options.hx | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/qemu-options.hx b/qemu-options.hx
index 5adbed1101..e7f07d8ccf 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3100,6 +3100,8 @@ SRST
         server. The files in dir will be exposed as the root of a TFTP
         server. The TFTP client on the guest must be configured in
         binary mode (use the command ``bin`` of the Unix TFTP client).
+        The built-in TFTP server is read-only, it does not implement any
+        command for writing files. QEMU will not write to this directory.
 
     ``tftp-server-name=name``
         In BOOTP reply, broadcast name as the "TFTP server name"
-- 
2.39.2


