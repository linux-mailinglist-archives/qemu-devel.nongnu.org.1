Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 665537AD866
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 14:58:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkl8n-0008ID-6l; Mon, 25 Sep 2023 08:56:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nbowler@draconx.ca>)
 id 1qkdjw-0001fH-QA
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 01:02:36 -0400
Received: from mta01.start.ca ([162.250.196.97])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nbowler@draconx.ca>)
 id 1qkdjt-0004ot-V0
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 01:02:36 -0400
Received: from mta01.start.ca (localhost [127.0.0.1])
 by mta01.start.ca (Postfix) with ESMTP id 27956207A2;
 Mon, 25 Sep 2023 01:02:33 -0400 (EDT)
Received: from localhost (dhcp-24-53-241-2.cable.user.start.ca [24.53.241.2])
 by mta01.start.ca (Postfix) with ESMTPS id F0D6D20784;
 Mon, 25 Sep 2023 01:02:32 -0400 (EDT)
From: Nick Bowler <nbowler@draconx.ca>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PATCH 8/8] target/sparc: Fix VIS subtraction instructions.
Date: Mon, 25 Sep 2023 01:03:57 -0400
Message-ID: <20230925050545.30912-9-nbowler@draconx.ca>
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

All of the VIS subtraction instructions are documented to subtract the
second input operand from the first.  This is also consistent with how
the instructions actually work on a real UltraSparc II.

But the emulator is implementing the subtraction in the wrong order,
subtracting the first input from the second, so the results are wrong
in all nontrivial cases.

Signed-off-by: Nick Bowler <nbowler@draconx.ca>
---
 target/sparc/vis_helper.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/sparc/vis_helper.c b/target/sparc/vis_helper.c
index 3903beaf5d..fa97e09ffa 100644
--- a/target/sparc/vis_helper.c
+++ b/target/sparc/vis_helper.c
@@ -282,10 +282,10 @@ uint64_t helper_fexpand(uint32_t src2)
         s.ll = src1;                                    \
         d.ll = src2;                                    \
                                                         \
-        d.VIS_W64(0) = F(d.VIS_W64(0), s.VIS_W64(0));   \
-        d.VIS_W64(1) = F(d.VIS_W64(1), s.VIS_W64(1));   \
-        d.VIS_W64(2) = F(d.VIS_W64(2), s.VIS_W64(2));   \
-        d.VIS_W64(3) = F(d.VIS_W64(3), s.VIS_W64(3));   \
+        d.VIS_W64(0) = F(s.VIS_W64(0), d.VIS_W64(0));   \
+        d.VIS_W64(1) = F(s.VIS_W64(1), d.VIS_W64(1));   \
+        d.VIS_W64(2) = F(s.VIS_W64(2), d.VIS_W64(2));   \
+        d.VIS_W64(3) = F(s.VIS_W64(3), d.VIS_W64(3));   \
                                                         \
         return d.ll;                                    \
     }                                                   \
@@ -297,8 +297,8 @@ uint64_t helper_fexpand(uint32_t src2)
         s.l = src1;                                     \
         d.l = src2;                                     \
                                                         \
-        d.VIS_W32(0) = F(d.VIS_W32(0), s.VIS_W32(0));   \
-        d.VIS_W32(1) = F(d.VIS_W32(1), s.VIS_W32(1));   \
+        d.VIS_W32(0) = F(s.VIS_W32(0), d.VIS_W32(0));   \
+        d.VIS_W32(1) = F(s.VIS_W32(1), d.VIS_W32(1));   \
                                                         \
         return d.l;                                     \
     }                                                   \
@@ -310,8 +310,8 @@ uint64_t helper_fexpand(uint32_t src2)
         s.ll = src1;                                    \
         d.ll = src2;                                    \
                                                         \
-        d.VIS_L64(0) = F(d.VIS_L64(0), s.VIS_L64(0));   \
-        d.VIS_L64(1) = F(d.VIS_L64(1), s.VIS_L64(1));   \
+        d.VIS_L64(0) = F(s.VIS_L64(0), d.VIS_L64(0));   \
+        d.VIS_L64(1) = F(s.VIS_L64(1), d.VIS_L64(1));   \
                                                         \
         return d.ll;                                    \
     }                                                   \
@@ -323,7 +323,7 @@ uint64_t helper_fexpand(uint32_t src2)
         s.l = src1;                                     \
         d.l = src2;                                     \
                                                         \
-        d.l = F(d.l, s.l);                              \
+        d.l = F(s.l, d.l);                              \
                                                         \
         return d.l;                                     \
     }
-- 
2.41.0


