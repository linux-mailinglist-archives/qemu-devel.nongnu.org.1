Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7617AD85C
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 14:58:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkl8s-0008M2-T4; Mon, 25 Sep 2023 08:56:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nbowler@draconx.ca>)
 id 1qkdjv-0001eT-Q4
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 01:02:35 -0400
Received: from mta01.start.ca ([162.250.196.97])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nbowler@draconx.ca>)
 id 1qkdjt-0004om-Ii
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 01:02:35 -0400
Received: from mta01.start.ca (localhost [127.0.0.1])
 by mta01.start.ca (Postfix) with ESMTP id B123F2078F;
 Mon, 25 Sep 2023 01:02:32 -0400 (EDT)
Received: from localhost (dhcp-24-53-241-2.cable.user.start.ca [24.53.241.2])
 by mta01.start.ca (Postfix) with ESMTPS id 8B3C620784;
 Mon, 25 Sep 2023 01:02:32 -0400 (EDT)
From: Nick Bowler <nbowler@draconx.ca>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PATCH 7/8] target/sparc: Fix VIS fexpand input register.
Date: Mon, 25 Sep 2023 01:03:56 -0400
Message-ID: <20230925050545.30912-8-nbowler@draconx.ca>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230925050545.30912-1-nbowler@draconx.ca>
References: <20230925050545.30912-1-nbowler@draconx.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Received-SPF: none client-ip=162.250.196.97; envelope-from=nbowler@draconx.ca;
 helo=mta01.start.ca
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 25 Sep 2023 08:56:43 -0400
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

This instruction is documented to get its input from the second
single-precision input operand; the first operand is ignored.
This is exactly what a real UltraSparc II does.  Meanwhile, the
the emulator uses only the irrelevant first operand, treating
it as a double-precision register, and ignores the second.

This will not normally contain the correct data so the emulated
instruction usually just produces garbage.

Signed-off-by: Nick Bowler <nbowler@draconx.ca>
---
 target/sparc/helper.h     | 2 +-
 target/sparc/translate.c  | 5 ++++-
 target/sparc/vis_helper.c | 5 ++---
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index b71688079f..81d44e7618 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -133,7 +133,7 @@ DEF_HELPER_FLAGS_2(fmul8sux16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(fmul8ulx16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(fmuld8sux16, TCG_CALL_NO_RWG_SE, i64, i32, i32)
 DEF_HELPER_FLAGS_2(fmuld8ulx16, TCG_CALL_NO_RWG_SE, i64, i32, i32)
-DEF_HELPER_FLAGS_2(fexpand, TCG_CALL_NO_RWG_SE, i64, i64, i64)
+DEF_HELPER_FLAGS_1(fexpand, TCG_CALL_NO_RWG_SE, i64, i32)
 DEF_HELPER_FLAGS_3(pdist, TCG_CALL_NO_RWG_SE, i64, i64, i64, i64)
 DEF_HELPER_FLAGS_2(fpack16, TCG_CALL_NO_RWG_SE, i32, i64, i64)
 DEF_HELPER_FLAGS_3(fpack32, TCG_CALL_NO_RWG_SE, i64, i64, i64, i64)
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 241ac429ca..4e92c27768 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4837,7 +4837,10 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                     break;
                 case 0x04d: /* VIS I fexpand */
                     CHECK_FPU_FEATURE(dc, VIS1);
-                    gen_ne_fop_DDD(dc, rd, rs1, rs2, gen_helper_fexpand);
+                    cpu_src2_32 = gen_load_fpr_F(dc, rs2);
+                    cpu_dst_64 = gen_dest_fpr_D(dc, rd);
+                    gen_helper_fexpand(cpu_dst_64, cpu_src2_32);
+                    gen_store_fpr_D(dc, rd, cpu_dst_64);
                     break;
                 case 0x050: /* VIS I fpadd16 */
                     CHECK_FPU_FEATURE(dc, VIS1);
diff --git a/target/sparc/vis_helper.c b/target/sparc/vis_helper.c
index 029aad3923..3903beaf5d 100644
--- a/target/sparc/vis_helper.c
+++ b/target/sparc/vis_helper.c
@@ -260,13 +260,12 @@ uint64_t helper_fmuld8ulx16(uint32_t src1, uint32_t src2)
     return d.ll;
 }
 
-uint64_t helper_fexpand(uint64_t src1, uint64_t src2)
+uint64_t helper_fexpand(uint32_t src2)
 {
     VIS32 s;
     VIS64 d;
 
-    s.l = (uint32_t)src1;
-    d.ll = src2;
+    s.l = src2;
     d.VIS_W64(0) = s.VIS_B32(0) << 4;
     d.VIS_W64(1) = s.VIS_B32(1) << 4;
     d.VIS_W64(2) = s.VIS_B32(2) << 4;
-- 
2.41.0


