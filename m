Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC189C2CE4
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Nov 2024 13:24:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9kMq-0001vq-DY; Sat, 09 Nov 2024 07:15:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9kMf-0001gD-Oq; Sat, 09 Nov 2024 07:14:53 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9kMd-0004lR-JD; Sat, 09 Nov 2024 07:14:53 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A5147A1629;
 Sat,  9 Nov 2024 15:08:06 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 6C93F167FB1;
 Sat,  9 Nov 2024 15:09:01 +0300 (MSK)
Received: (nullmailer pid 3296129 invoked by uid 1000);
 Sat, 09 Nov 2024 12:09:01 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.1.2 01/58] tcg/s390x: fix constraint for 32-bit TSTEQ/TSTNE
Date: Sat,  9 Nov 2024 15:08:02 +0300
Message-Id: <20241109120901.3295995-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.1.2-20241109150812@cover.tls.msk.ru>
References: <qemu-stable-9.1.2-20241109150812@cover.tls.msk.ru>
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

From: Paolo Bonzini <pbonzini@redhat.com>

32-bit TSTEQ and TSTNE is subject to the same constraints as
for 64-bit, but setcond_i32 and negsetcond_i32 were incorrectly
using TCG_CT_CONST ("i") instead of TCG_CT_CONST_CMP ("C").

Adjust the constraint and make tcg_target_const_match use the
same sequence as tgen_cmp2: first check if the constant is a
valid operand for TSTEQ/TSTNE, then accept everything for 32-bit
non-test comparisons, finally check if the constant is a valid
operand for 64-bit non-test comparisons.

Reported-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Cc: qemu-stable@nongnu.org

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 615586cb356811e46c2e5f85c36db4b93f8381cd)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index ad587325fc..a27e346602 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -563,6 +563,20 @@ static bool tcg_target_const_match(int64_t val, int ct,
     }
 
     if (ct & TCG_CT_CONST_CMP) {
+        if (is_tst_cond(cond)) {
+            if (is_const_p16(uval) >= 0) {
+                return true;  /* TMxx */
+            }
+            if (risbg_mask(uval)) {
+                return true;  /* RISBG */
+            }
+            return false;
+        }
+
+        if (type == TCG_TYPE_I32) {
+            return true;
+        }
+
         switch (cond) {
         case TCG_COND_EQ:
         case TCG_COND_NE:
@@ -582,13 +596,7 @@ static bool tcg_target_const_match(int64_t val, int ct,
             break;
         case TCG_COND_TSTNE:
         case TCG_COND_TSTEQ:
-            if (is_const_p16(uval) >= 0) {
-                return true;  /* TMxx */
-            }
-            if (risbg_mask(uval)) {
-                return true;  /* RISBG */
-            }
-            break;
+            /* checked above, fallthru */
         default:
             g_assert_not_reached();
         }
@@ -3221,9 +3229,9 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_rotl_i64:
     case INDEX_op_rotr_i32:
     case INDEX_op_rotr_i64:
+        return C_O1_I2(r, r, ri);
     case INDEX_op_setcond_i32:
     case INDEX_op_negsetcond_i32:
-        return C_O1_I2(r, r, ri);
     case INDEX_op_setcond_i64:
     case INDEX_op_negsetcond_i64:
         return C_O1_I2(r, r, rC);
-- 
2.39.5


