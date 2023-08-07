Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D39D771D58
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 11:47:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSwoB-0006x7-QY; Mon, 07 Aug 2023 05:45:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qSwo2-0006r7-5M
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 05:45:48 -0400
Received: from hognose1.porkbun.com ([35.82.102.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qSwo0-0002u2-GK
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 05:45:41 -0400
Received: from develop.s.cslab.moe (unknown [166.111.226.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: c@jia.je)
 by hognose1.porkbun.com (Postfix) with ESMTPSA id D30DF43B70;
 Mon,  7 Aug 2023 09:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jia.je; s=default;
 t=1691401537; bh=QPIfZdK+VITWIvg71jeCebUsOkpaEf7hb7i6NUmM97M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=u6282+ksaFk/MTvVt/plHNm7MS5+YP90g15RkgFHQo7bCWWVlb1Uzrpty5dMHZzGh
 YxIAMiCinxvovHmtBtuiGa/rXNO8X0NrAYYebKTm5vWgB2xW5rGfw1jiNElqlzVe4P
 3XP7uZ5WEg5T+UvwILPNQ07+6QCMQiPgFkoR2uiM=
From: Jiajie Chen <c@jia.je>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, yijun@loongson.cn, shenjinyang@loongson.cn,
 Jiajie Chen <c@jia.je>, Song Gao <gaosong@loongson.cn>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>
Subject: [PATCH v3 1/6] target/loongarch: Add loongarch32 mode for
 loongarch64-softmmu
Date: Mon,  7 Aug 2023 17:45:00 +0800
Message-Id: <20230807094505.2030603-2-c@jia.je>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230807094505.2030603-1-c@jia.je>
References: <20230807094505.2030603-1-c@jia.je>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=35.82.102.206; envelope-from=c@jia.je;
 helo=hognose1.porkbun.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This commit adds loongarch32 mode to loongarch64-softmmu.

Signed-off-by: Jiajie Chen <c@jia.je>
---
 target/loongarch/cpu.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index fa371ca8ba..43c73e6363 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -272,9 +272,16 @@ struct LoongArchTLB {
 };
 typedef struct LoongArchTLB LoongArchTLB;
 
+/* Current LoongArch mode */
+typedef enum LoongArchMode {
+    LA32 = 0,
+    LA64 = 1,
+} LoongArchMode;
+
 typedef struct CPUArchState {
     uint64_t gpr[32];
     uint64_t pc;
+    LoongArchMode mode;
 
     fpr_t fpr[32];
     float_status fp_status;
-- 
2.39.2


