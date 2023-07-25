Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB8F761A69
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 15:47:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOINV-0006rc-HB; Tue, 25 Jul 2023 09:47:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qOIMG-0005HK-JV; Tue, 25 Jul 2023 09:45:54 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qOIMF-0001Hj-1q; Tue, 25 Jul 2023 09:45:48 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id AC994160EE;
 Tue, 25 Jul 2023 16:45:33 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 44583194B1;
 Tue, 25 Jul 2023 16:45:31 +0300 (MSK)
Received: (nullmailer pid 3370801 invoked by uid 1000);
 Tue, 25 Jul 2023 13:45:29 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.4 06/31] target/s390x: Fix EPSW CC reporting
Date: Tue, 25 Jul 2023 16:44:51 +0300
Message-Id: <20230725134517.3370706-6-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.4-20230725164041@cover.tls.msk.ru>
References: <qemu-stable-8.0.4-20230725164041@cover.tls.msk.ru>
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

EPSW should explicitly calculate and insert CC, like IPM does.

Fixes: e30a9d3fea58 ("target-s390: Implement EPSW")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Cc: qemu-stable@nongnu.org
Message-Id: <20230704081506.276055-3-iii@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit 110b1bac2ecd94a78a1d38003e24e37367bf074e)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 82900f53f4..0c22d2f17f 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -2393,10 +2393,14 @@ static DisasJumpType op_epsw(DisasContext *s, DisasOps *o)
     int r1 = get_field(s, r1);
     int r2 = get_field(s, r2);
     TCGv_i64 t = tcg_temp_new_i64();
+    TCGv_i64 t_cc = tcg_temp_new_i64();
 
     /* Note the "subsequently" in the PoO, which implies a defined result
        if r1 == r2.  Thus we cannot defer these writes to an output hook.  */
+    gen_op_calc_cc(s);
+    tcg_gen_extu_i32_i64(t_cc, cc_op);
     tcg_gen_shri_i64(t, psw_mask, 32);
+    tcg_gen_deposit_i64(t, t, t_cc, 12, 2);
     store_reg32_i64(r1, t);
     if (r2 != 0) {
         store_reg32_i64(r2, psw_mask);
-- 
2.39.2


