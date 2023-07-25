Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CDF761A75
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 15:48:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOINX-00072Q-CN; Tue, 25 Jul 2023 09:47:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qOIMy-0005my-J9; Tue, 25 Jul 2023 09:46:34 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qOIMq-0001X9-9v; Tue, 25 Jul 2023 09:46:25 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5F387160F8;
 Tue, 25 Jul 2023 16:45:35 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 20398194BB;
 Tue, 25 Jul 2023 16:45:33 +0300 (MSK)
Received: (nullmailer pid 3370831 invoked by uid 1000);
 Tue, 25 Jul 2023 13:45:29 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Mauro Matteo Cascella <mcascell@redhat.com>,
 Kevin Denis <kevin.denis@synacktiv.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.4 16/31] ui/vnc-clipboard: fix infinite loop in
 inflate_buffer (CVE-2023-3255)
Date: Tue, 25 Jul 2023 16:45:01 +0300
Message-Id: <20230725134517.3370706-16-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.4-20230725164041@cover.tls.msk.ru>
References: <qemu-stable-8.0.4-20230725164041@cover.tls.msk.ru>
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

From: Mauro Matteo Cascella <mcascell@redhat.com>

A wrong exit condition may lead to an infinite loop when inflating a
valid zlib buffer containing some extra bytes in the `inflate_buffer`
function. The bug only occurs post-authentication. Return the buffer
immediately if the end of the compressed data has been reached
(Z_STREAM_END).

Fixes: CVE-2023-3255
Fixes: 0bf41cab ("ui/vnc: clipboard support")
Reported-by: Kevin Denis <kevin.denis@synacktiv.com>
Signed-off-by: Mauro Matteo Cascella <mcascell@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Tested-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20230704084210.101822-1-mcascell@redhat.com>
(cherry picked from commit d921fea338c1059a27ce7b75309d7a2e485f710b)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/ui/vnc-clipboard.c b/ui/vnc-clipboard.c
index 8aeadfaa21..c759be3438 100644
--- a/ui/vnc-clipboard.c
+++ b/ui/vnc-clipboard.c
@@ -50,8 +50,11 @@ static uint8_t *inflate_buffer(uint8_t *in, uint32_t in_len, uint32_t *size)
         ret = inflate(&stream, Z_FINISH);
         switch (ret) {
         case Z_OK:
-        case Z_STREAM_END:
             break;
+        case Z_STREAM_END:
+            *size = stream.total_out;
+            inflateEnd(&stream);
+            return out;
         case Z_BUF_ERROR:
             out_len <<= 1;
             if (out_len > (1 << 20)) {
@@ -66,11 +69,6 @@ static uint8_t *inflate_buffer(uint8_t *in, uint32_t in_len, uint32_t *size)
         }
     }
 
-    *size = stream.total_out;
-    inflateEnd(&stream);
-
-    return out;
-
 err_end:
     inflateEnd(&stream);
 err:
-- 
2.39.2


