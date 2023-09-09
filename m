Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF58799899
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 15:20:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qexbV-0000yd-CA; Sat, 09 Sep 2023 09:02:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qexb0-00084V-1P; Sat, 09 Sep 2023 09:01:56 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qexav-0002Qo-T4; Sat, 09 Sep 2023 09:01:52 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id BBF43205A0;
 Sat,  9 Sep 2023 16:01:16 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 92A6F26E06;
 Sat,  9 Sep 2023 16:00:25 +0300 (MSK)
Received: (nullmailer pid 353108 invoked by uid 1000);
 Sat, 09 Sep 2023 13:00:22 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.5 18/43] target/s390x: Use a 16-bit immediate in VREP
Date: Sat,  9 Sep 2023 15:59:44 +0300
Message-Id: <20230909130020.352951-18-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.5-20230909155813@cover.tls.msk.ru>
References: <qemu-stable-8.0.5-20230909155813@cover.tls.msk.ru>
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

Unlike most other instructions that contain an immediate element index,
VREP's one is 16-bit, and not 4-bit. The code uses only 8 bits, so
using, e.g., 0x101 does not lead to a specification exception.

Fix by checking all 16 bits.

Cc: qemu-stable@nongnu.org
Fixes: 28d08731b1d8 ("s390x/tcg: Implement VECTOR REPLICATE")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20230807163459.849766-1-iii@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit 23e87d419f347b6b5f4da3bf70d222acc24cdb64)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/s390x/tcg/translate_vx.c.inc b/target/s390x/tcg/translate_vx.c.inc
index f8df121d3d..a6d840d406 100644
--- a/target/s390x/tcg/translate_vx.c.inc
+++ b/target/s390x/tcg/translate_vx.c.inc
@@ -57,7 +57,7 @@
 #define FPF_LONG        3
 #define FPF_EXT         4
 
-static inline bool valid_vec_element(uint8_t enr, MemOp es)
+static inline bool valid_vec_element(uint16_t enr, MemOp es)
 {
     return !(enr & ~(NUM_VEC_ELEMENTS(es) - 1));
 }
@@ -964,7 +964,7 @@ static DisasJumpType op_vpdi(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_vrep(DisasContext *s, DisasOps *o)
 {
-    const uint8_t enr = get_field(s, i2);
+    const uint16_t enr = get_field(s, i2);
     const uint8_t es = get_field(s, m4);
 
     if (es > ES_64 || !valid_vec_element(enr, es)) {
-- 
2.39.2


