Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A340C79F7F9
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 04:28:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgc4R-00037w-KS; Wed, 13 Sep 2023 22:27:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qgc4O-00036n-4j
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 22:27:04 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qgc4J-0004ps-N6
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 22:27:03 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxIvBsbwJlTvgmAA--.9199S3;
 Thu, 14 Sep 2023 10:26:52 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxvdxmbwJlJ+UDAA--.7298S3; 
 Thu, 14 Sep 2023 10:26:50 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	maobibo@loongson.cn
Subject: [PATCH v6 01/57] target/loongarch: Renamed lsx*.c to vec* .c
Date: Thu, 14 Sep 2023 10:25:49 +0800
Message-Id: <20230914022645.1151356-2-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230914022645.1151356-1-gaosong@loongson.cn>
References: <20230914022645.1151356-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxvdxmbwJlJ+UDAA--.7298S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

Renamed lsx_helper.c to vec_helper.c and trans_lsx.c.inc to trans_vec.c.inc
So LASX can used them.

Signed-off-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/loongarch/translate.c                                    | 2 +-
 target/loongarch/{lsx_helper.c => vec_helper.c}                 | 2 +-
 .../loongarch/insn_trans/{trans_lsx.c.inc => trans_vec.c.inc}   | 2 +-
 target/loongarch/meson.build                                    | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)
 rename target/loongarch/{lsx_helper.c => vec_helper.c} (99%)
 rename target/loongarch/insn_trans/{trans_lsx.c.inc => trans_vec.c.inc} (99%)

diff --git a/target/loongarch/translate.c b/target/loongarch/translate.c
index fd393ed76d..288727181b 100644
--- a/target/loongarch/translate.c
+++ b/target/loongarch/translate.c
@@ -261,7 +261,7 @@ static uint64_t make_address_pc(DisasContext *ctx, uint64_t addr)
 #include "insn_trans/trans_fmemory.c.inc"
 #include "insn_trans/trans_branch.c.inc"
 #include "insn_trans/trans_privileged.c.inc"
-#include "insn_trans/trans_lsx.c.inc"
+#include "insn_trans/trans_vec.c.inc"
 
 static void loongarch_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
 {
diff --git a/target/loongarch/lsx_helper.c b/target/loongarch/vec_helper.c
similarity index 99%
rename from target/loongarch/lsx_helper.c
rename to target/loongarch/vec_helper.c
index 9571f0aef0..73f0974744 100644
--- a/target/loongarch/lsx_helper.c
+++ b/target/loongarch/vec_helper.c
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
- * QEMU LoongArch LSX helper functions.
+ * QEMU LoongArch vector helper functions.
  *
  * Copyright (c) 2022-2023 Loongson Technology Corporation Limited
  */
diff --git a/target/loongarch/insn_trans/trans_lsx.c.inc b/target/loongarch/insn_trans/trans_vec.c.inc
similarity index 99%
rename from target/loongarch/insn_trans/trans_lsx.c.inc
rename to target/loongarch/insn_trans/trans_vec.c.inc
index 5fbf2718f7..aed5bac5bc 100644
--- a/target/loongarch/insn_trans/trans_lsx.c.inc
+++ b/target/loongarch/insn_trans/trans_vec.c.inc
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
- * LSX translate functions
+ * LoongArch vector translate functions
  * Copyright (c) 2022-2023 Loongson Technology Corporation Limited
  */
 
diff --git a/target/loongarch/meson.build b/target/loongarch/meson.build
index b7a27df5a9..7fbf045a5d 100644
--- a/target/loongarch/meson.build
+++ b/target/loongarch/meson.build
@@ -11,7 +11,7 @@ loongarch_tcg_ss.add(files(
   'op_helper.c',
   'translate.c',
   'gdbstub.c',
-  'lsx_helper.c',
+  'vec_helper.c',
 ))
 loongarch_tcg_ss.add(zlib)
 
-- 
2.39.1


