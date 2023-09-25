Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 091847AD862
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 14:58:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkl8p-0008Km-7f; Mon, 25 Sep 2023 08:56:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nbowler@draconx.ca>)
 id 1qkdjv-0001eU-Sb
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 01:02:35 -0400
Received: from mta01.start.ca ([162.250.196.97])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nbowler@draconx.ca>)
 id 1qkdjt-0004oh-I1
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 01:02:35 -0400
Received: from mta01.start.ca (localhost [127.0.0.1])
 by mta01.start.ca (Postfix) with ESMTP id 5849620786;
 Mon, 25 Sep 2023 01:02:32 -0400 (EDT)
Received: from localhost (dhcp-24-53-241-2.cable.user.start.ca [24.53.241.2])
 by mta01.start.ca (Postfix) with ESMTPS id 31AE220784;
 Mon, 25 Sep 2023 01:02:32 -0400 (EDT)
From: Nick Bowler <nbowler@draconx.ca>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PATCH 6/8] target/sparc: Fix VIS fpmerge input registers.
Date: Mon, 25 Sep 2023 01:03:55 -0400
Message-ID: <20230925050545.30912-7-nbowler@draconx.ca>
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

On a real UltraSparc II CPU, the fpmerge instruction reads two
single-precision input registers, but the emulator is reading
from double-precision input registers instead.

These are unlikely to contain the correct data so in most instances
the results of the emulation are just garbage in most instances.

Signed-off-by: Nick Bowler <nbowler@draconx.ca>
---
 target/sparc/helper.h     |  2 +-
 target/sparc/translate.c  |  6 +++++-
 target/sparc/vis_helper.c | 26 +++++++++++++-------------
 3 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index 7a588f3068..b71688079f 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -125,7 +125,7 @@ DEF_HELPER_FLAGS_2(fstox, TCG_CALL_NO_RWG, s64, env, f32)
 DEF_HELPER_FLAGS_2(fdtox, TCG_CALL_NO_RWG, s64, env, f64)
 DEF_HELPER_FLAGS_1(fqtox, TCG_CALL_NO_RWG, s64, env)
 
-DEF_HELPER_FLAGS_2(fpmerge, TCG_CALL_NO_RWG_SE, i64, i64, i64)
+DEF_HELPER_FLAGS_2(fpmerge, TCG_CALL_NO_RWG_SE, i64, i32, i32)
 DEF_HELPER_FLAGS_2(fmul8x16, TCG_CALL_NO_RWG_SE, i64, i32, i64)
 DEF_HELPER_FLAGS_2(fmul8x16al, TCG_CALL_NO_RWG_SE, i64, i32, i32)
 DEF_HELPER_FLAGS_2(fmul8x16au, TCG_CALL_NO_RWG_SE, i64, i32, i32)
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index cfccd95c3a..241ac429ca 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4825,7 +4825,11 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                     break;
                 case 0x04b: /* VIS I fpmerge */
                     CHECK_FPU_FEATURE(dc, VIS1);
-                    gen_ne_fop_DDD(dc, rd, rs1, rs2, gen_helper_fpmerge);
+                    cpu_src1_32 = gen_load_fpr_F(dc, rs1);
+                    cpu_src2_32 = gen_load_fpr_F(dc, rs2);
+                    cpu_dst_64 = gen_dest_fpr_D(dc, rd);
+                    gen_helper_fpmerge(cpu_dst_64, cpu_src1_32, cpu_src2_32);
+                    gen_store_fpr_D(dc, rd, cpu_dst_64);
                     break;
                 case 0x04c: /* VIS II bshuffle */
                     CHECK_FPU_FEATURE(dc, VIS2);
diff --git a/target/sparc/vis_helper.c b/target/sparc/vis_helper.c
index 306383ba60..029aad3923 100644
--- a/target/sparc/vis_helper.c
+++ b/target/sparc/vis_helper.c
@@ -77,22 +77,22 @@ typedef union {
     float32 f;
 } VIS32;
 
-uint64_t helper_fpmerge(uint64_t src1, uint64_t src2)
+uint64_t helper_fpmerge(uint32_t src1, uint32_t src2)
 {
-    VIS64 s, d;
+    VIS32 s1, s2;
+    VIS64 d;
 
-    s.ll = src1;
-    d.ll = src2;
+    s1.l = src1;
+    s2.l = src2;
 
-    /* Reverse calculation order to handle overlap */
-    d.VIS_B64(7) = s.VIS_B64(3);
-    d.VIS_B64(6) = d.VIS_B64(3);
-    d.VIS_B64(5) = s.VIS_B64(2);
-    d.VIS_B64(4) = d.VIS_B64(2);
-    d.VIS_B64(3) = s.VIS_B64(1);
-    d.VIS_B64(2) = d.VIS_B64(1);
-    d.VIS_B64(1) = s.VIS_B64(0);
-    /* d.VIS_B64(0) = d.VIS_B64(0); */
+    d.VIS_B64(0) = s2.VIS_B32(0);
+    d.VIS_B64(1) = s1.VIS_B32(0);
+    d.VIS_B64(2) = s2.VIS_B32(1);
+    d.VIS_B64(3) = s1.VIS_B32(1);
+    d.VIS_B64(4) = s2.VIS_B32(2);
+    d.VIS_B64(5) = s1.VIS_B32(2);
+    d.VIS_B64(6) = s2.VIS_B32(3);
+    d.VIS_B64(7) = s1.VIS_B32(3);
 
     return d.ll;
 }
-- 
2.41.0


