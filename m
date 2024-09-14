Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D4A978E7F
	for <lists+qemu-devel@lfdr.de>; Sat, 14 Sep 2024 08:48:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spMYm-0006pT-06; Sat, 14 Sep 2024 02:47:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1spMYi-0006ow-CR
 for qemu-devel@nongnu.org; Sat, 14 Sep 2024 02:47:04 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1spMYe-0003oc-Q1
 for qemu-devel@nongnu.org; Sat, 14 Sep 2024 02:47:03 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8AxpuhdMeVmQccHAA--.16795S3;
 Sat, 14 Sep 2024 14:46:53 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMDxL9ZdMeVmZpwGAA--.30568S2;
 Sat, 14 Sep 2024 14:46:53 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH v2] target/loongarch: Avoid bits shift exceeding width of bool
 type
Date: Sat, 14 Sep 2024 14:46:45 +0800
Message-Id: <20240914064645.2099169-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMDxL9ZdMeVmZpwGAA--.30568S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
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

Variable env->cf[i] is defined as bool type, it is treated as int type
with shift operation. However the max possible width is 56 for the shift
operation, exceeding the width of int type. And there is existing api
read_fcc() which is converted to u64 type with bitwise shift, it can be
used to dump fp registers into coredump note segment.

Resolves: Coverity CID 1561133
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/loongarch/arch_dump.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/target/loongarch/arch_dump.c b/target/loongarch/arch_dump.c
index 4986db970e..d9e1120333 100644
--- a/target/loongarch/arch_dump.c
+++ b/target/loongarch/arch_dump.c
@@ -97,11 +97,7 @@ static int loongarch_write_elf64_fprpreg(WriteCoreDumpFunction f,
 
     loongarch_note_init(&note, s, "CORE", 5, NT_PRFPREG, sizeof(note.fpu));
     note.fpu.fcsr = cpu_to_dump64(s, env->fcsr0);
-
-    for (i = 0; i < 8; i++) {
-        note.fpu.fcc |= env->cf[i] << (8 * i);
-    }
-    note.fpu.fcc = cpu_to_dump64(s, note.fpu.fcc);
+    note.fpu.fcc = cpu_to_dump64(s, read_fcc(env));
 
     for (i = 0; i < 32; ++i) {
         note.fpu.fpr[i] = cpu_to_dump64(s, env->fpr[i].vreg.UD[0]);

base-commit: 28ae3179fc52d2e4d870b635c4a412aab99759e7
-- 
2.39.3


