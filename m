Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BCB831981
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 13:52:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQRrg-0003up-2q; Thu, 18 Jan 2024 07:51:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rQRrc-0003tZ-NX; Thu, 18 Jan 2024 07:51:20 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rQRrb-0000eh-4O; Thu, 18 Jan 2024 07:51:20 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A40BF452CF;
 Thu, 18 Jan 2024 15:51:27 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 6403A668C3;
 Thu, 18 Jan 2024 15:50:57 +0300 (MSK)
Received: (nullmailer pid 2502755 invoked by uid 1000);
 Thu, 18 Jan 2024 12:50:56 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Ido Plat <Ido.Plat@ibm.com>, David Hildenbrand <david@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.1.5 10/11] target/s390x: Fix LAE setting a wrong access
 register
Date: Thu, 18 Jan 2024 15:50:48 +0300
Message-Id: <20240118125056.2502687-10-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.1.5-20240118154659@cover.tls.msk.ru>
References: <qemu-stable-8.1.5-20240118154659@cover.tls.msk.ru>
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

LAE should set the access register corresponding to the first operand,
instead, it always modifies access register 1.

Co-developed-by: Ido Plat <Ido.Plat@ibm.com>
Cc: qemu-stable@nongnu.org
Fixes: a1c7610a6879 ("target-s390x: implement LAY and LAEY instructions")
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-ID: <20240111092328.929421-2-iii@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit e358a25a97c71c39e3513d9b869cdb82052e50b8)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(Mjt: target/s390x/tcg/translate.c: fixup for
 v8.1.0-1189-gad75a51e84 "tcg: Rename cpu_env to tcg_env")

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index d927e01c0c..b009789281 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -3221,6 +3221,7 @@ static DisasJumpType op_mov2e(DisasContext *s, DisasOps *o)
 {
     int b2 = get_field(s, b2);
     TCGv ar1 = tcg_temp_new_i64();
+    int r1 = get_field(s, r1);
 
     o->out = o->in2;
     o->in2 = NULL;
@@ -3244,7 +3245,7 @@ static DisasJumpType op_mov2e(DisasContext *s, DisasOps *o)
         break;
     }
 
-    tcg_gen_st32_i64(ar1, cpu_env, offsetof(CPUS390XState, aregs[1]));
+    tcg_gen_st32_i64(ar1, cpu_env, offsetof(CPUS390XState, aregs[r1]));
     return DISAS_NEXT;
 }
 
-- 
2.39.2


