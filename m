Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2101D91CFF3
	for <lists+qemu-devel@lfdr.de>; Sun, 30 Jun 2024 05:12:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNkzX-00041z-HI; Sat, 29 Jun 2024 23:12:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sNkzV-0003xJ-5L; Sat, 29 Jun 2024 23:12:37 -0400
Received: from out30-124.freemail.mail.aliyun.com ([115.124.30.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sNkzT-0006Ti-2C; Sat, 29 Jun 2024 23:12:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1719717150; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=lb8nPC3guShQriWC6z1jk+f/5hN4YT+Hh7z+UKZLabI=;
 b=BelLaQ5vrALOgdxmp9AlJsCoK/RsXxoGLd1ENW8oMoHtgmCd7xfjHgMmU/J+c5zRmC5hCn8iuNC5tD2cMKS8uPdUr0hFCoGIOmKJd4H+gBI636FyI0DimjD3d6F44QMwFu8n1NWivKGiCHN9v+5BtgNN/ELj/CkK6idbpJAf8lM=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R111e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033045046011;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=8; SR=0;
 TI=SMTPD_---0W9UUi57_1719717148; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0W9UUi57_1719717148) by smtp.aliyun-inc.com;
 Sun, 30 Jun 2024 11:12:29 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH v2 09/11] target/riscv: Add amocas.[b|h] for Zabha
Date: Sun, 30 Jun 2024 11:05:57 +0800
Message-Id: <20240630030559.877-10-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20240630030559.877-1-zhiwei_liu@linux.alibaba.com>
References: <20240630030559.877-1-zhiwei_liu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.124;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-124.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn32.decode                  |  2 ++
 target/riscv/insn_trans/trans_rvzabha.c.inc | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 8a4801d442..eee48f92d3 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -1041,3 +1041,5 @@ amomin_h   10000 . . ..... ..... 001 ..... 0101111 @atom_st
 amomax_h   10100 . . ..... ..... 001 ..... 0101111 @atom_st
 amominu_h  11000 . . ..... ..... 001 ..... 0101111 @atom_st
 amomaxu_h  11100 . . ..... ..... 001 ..... 0101111 @atom_st
+amocas_b    00101 . . ..... ..... 000 ..... 0101111 @atom_st
+amocas_h    00101 . . ..... ..... 001 ..... 0101111 @atom_st
diff --git a/target/riscv/insn_trans/trans_rvzabha.c.inc b/target/riscv/insn_trans/trans_rvzabha.c.inc
index 9093a1cfc1..ce8edcba62 100644
--- a/target/riscv/insn_trans/trans_rvzabha.c.inc
+++ b/target/riscv/insn_trans/trans_rvzabha.c.inc
@@ -129,3 +129,17 @@ static bool trans_amomaxu_h(DisasContext *ctx, arg_amomaxu_h *a)
     REQUIRE_ZABHA(ctx);
     return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umax_tl, MO_TESW);
 }
+
+static bool trans_amocas_b(DisasContext *ctx, arg_amocas_b *a)
+{
+    REQUIRE_ZACAS(ctx);
+    REQUIRE_ZABHA(ctx);
+    return gen_cmpxchg(ctx, a, MO_SB);
+}
+
+static bool trans_amocas_h(DisasContext *ctx, arg_amocas_h *a)
+{
+    REQUIRE_ZACAS(ctx);
+    REQUIRE_ZABHA(ctx);
+    return gen_cmpxchg(ctx, a, MO_ALIGN | MO_TESW);
+}
-- 
2.25.1


