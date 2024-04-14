Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBD489EC8F
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Apr 2024 09:44:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruSOr-00082Y-94; Wed, 10 Apr 2024 03:29:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSOT-0007Q3-Nl; Wed, 10 Apr 2024 03:29:18 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSOR-0004zx-Gn; Wed, 10 Apr 2024 03:29:16 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 29BD25D6B0;
 Wed, 10 Apr 2024 10:25:07 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id C0EB5B02F0;
 Wed, 10 Apr 2024 10:23:08 +0300 (MSK)
Received: (nullmailer pid 4191842 invoked by uid 1000);
 Wed, 10 Apr 2024 07:23:04 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.3 64/87] target/riscv/vector_helper.c: fix 'vmvr_v'
 memcpy endianess
Date: Wed, 10 Apr 2024 10:22:37 +0300
Message-Id: <20240410072303.4191455-64-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.3-20240410085155@cover.tls.msk.ru>
References: <qemu-stable-8.2.3-20240410085155@cover.tls.msk.ru>
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

vmvr_v isn't handling the case where the host might be big endian and
the bytes to be copied aren't sequential.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Fixes: f714361ed7 ("target/riscv: rvv-1.0: implement vstart CSR")
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240314175704.478276-4-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit 768e7b329c0be22035da077fe76221dd0a47103b)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 6215a0bc5e..d5a98acce0 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -5064,9 +5064,17 @@ void HELPER(vmvr_v)(void *vd, void *vs2, CPURISCVState *env, uint32_t desc)
     uint32_t startb = env->vstart * sewb;
     uint32_t i = startb;
 
+    if (HOST_BIG_ENDIAN && i % 8 != 0) {
+        uint32_t j = ROUND_UP(i, 8);
+        memcpy((uint8_t *)vd + H1(j - 1),
+               (uint8_t *)vs2 + H1(j - 1),
+               j - i);
+        i = j;
+    }
+
     memcpy((uint8_t *)vd + H1(i),
            (uint8_t *)vs2 + H1(i),
-           maxsz - startb);
+           maxsz - i);
 
     env->vstart = 0;
 }
-- 
2.39.2


