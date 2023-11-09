Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 272D27E6B7F
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 14:49:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r15PJ-0005zf-Nu; Thu, 09 Nov 2023 08:49:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15Od-0004es-EO; Thu, 09 Nov 2023 08:48:35 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15Ob-0002Vf-Ay; Thu, 09 Nov 2023 08:48:35 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 93CFD31B2B;
 Thu,  9 Nov 2023 16:43:15 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 9F6AC344D2;
 Thu,  9 Nov 2023 16:43:07 +0300 (MSK)
Received: (nullmailer pid 1461916 invoked by uid 1000);
 Thu, 09 Nov 2023 13:43:03 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.1.3 51/55] target/s390x: Fix CLC corrupting cc_src
Date: Thu,  9 Nov 2023 16:42:55 +0300
Message-Id: <20231109134300.1461632-51-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.1.3-20231109164030@cover.tls.msk.ru>
References: <qemu-stable-8.1.3-20231109164030@cover.tls.msk.ru>
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

CLC updates cc_src before accessing the second operand; if the latter
is inaccessible, the former ends up containing a bogus value.

Fix by reading cc_src into a temporary first.

Fixes: 4f7403d52b1c ("target-s390: Convert CLC")
Closes: https://gitlab.com/qemu-project/qemu/-/issues/1865
Cc: qemu-stable@nongnu.org
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Message-ID: <20231106093605.1349201-2-iii@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit aba2ec341c6d20c8dc3e6ecf87fa7c1a71e30c1e)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index dc7041e1d8..97ab1b3daa 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -2007,6 +2007,7 @@ static DisasJumpType op_cksm(DisasContext *s, DisasOps *o)
 static DisasJumpType op_clc(DisasContext *s, DisasOps *o)
 {
     int l = get_field(s, l1);
+    TCGv_i64 src;
     TCGv_i32 vl;
     MemOp mop;
 
@@ -2016,9 +2017,11 @@ static DisasJumpType op_clc(DisasContext *s, DisasOps *o)
     case 4:
     case 8:
         mop = ctz32(l + 1) | MO_TE;
-        tcg_gen_qemu_ld_tl(cc_src, o->addr1, get_mem_index(s), mop);
+        /* Do not update cc_src yet: loading cc_dst may cause an exception. */
+        src = tcg_temp_new_i64();
+        tcg_gen_qemu_ld_tl(src, o->addr1, get_mem_index(s), mop);
         tcg_gen_qemu_ld_tl(cc_dst, o->in2, get_mem_index(s), mop);
-        gen_op_update2_cc_i64(s, CC_OP_LTUGTU_64, cc_src, cc_dst);
+        gen_op_update2_cc_i64(s, CC_OP_LTUGTU_64, src, cc_dst);
         return DISAS_NEXT;
     default:
         vl = tcg_constant_i32(l);
-- 
2.39.2


