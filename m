Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C65697D1EB
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Sep 2024 09:44:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srYHR-0007uj-UA; Fri, 20 Sep 2024 03:42:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1srYHC-0007Tt-6B; Fri, 20 Sep 2024 03:42:02 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1srYH9-0000Fn-Jd; Fri, 20 Sep 2024 03:42:01 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4E6379085F;
 Fri, 20 Sep 2024 10:41:20 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id CAAE31409E2;
 Fri, 20 Sep 2024 10:41:39 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 09/22] hw/display: Fix mirrored output in dm163
Date: Fri, 20 Sep 2024 10:41:21 +0300
Message-Id: <20240920074134.664961-10-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240920074134.664961-1-mjt@tls.msk.ru>
References: <20240920074134.664961-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Inès Varhol <ines.varhol@telecom-paris.fr>

DM163 is an emulated 8x8 LED matrix. This commit flips the image
horizontally so it's rendered the same way as on the hardware.

Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/display/dm163.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/display/dm163.c b/hw/display/dm163.c
index f92aee371d..75a91f62bd 100644
--- a/hw/display/dm163.c
+++ b/hw/display/dm163.c
@@ -271,7 +271,7 @@ static uint32_t *update_display_of_row(DM163State *s, uint32_t *dest,
                                        unsigned row)
 {
     for (unsigned _ = 0; _ < LED_SQUARE_SIZE; _++) {
-        for (int x = 0; x < RGB_MATRIX_NUM_COLS * LED_SQUARE_SIZE; x++) {
+        for (int x = RGB_MATRIX_NUM_COLS * LED_SQUARE_SIZE - 1; x >= 0; x--) {
             /* UI layer guarantees that there's 32 bits per pixel (Mar 2024) */
             *dest++ = s->buffer[s->buffer_idx_of_row[row]][x / LED_SQUARE_SIZE];
         }
-- 
2.39.5


