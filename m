Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F8E7B4020
	for <lists+qemu-devel@lfdr.de>; Sat, 30 Sep 2023 13:30:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmY9l-0004AY-Tt; Sat, 30 Sep 2023 07:29:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qmY9j-0004AL-Vz
 for qemu-devel@nongnu.org; Sat, 30 Sep 2023 07:29:08 -0400
Received: from hognose1.porkbun.com ([35.82.102.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qmY9h-0005GQ-AL
 for qemu-devel@nongnu.org; Sat, 30 Sep 2023 07:29:07 -0400
Received: from cslab-raptor.. (unknown [166.111.226.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: c@jia.je)
 by hognose1.porkbun.com (Postfix) with ESMTPSA id 223BB4381E;
 Sat, 30 Sep 2023 11:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jia.je; s=default;
 t=1696073334; bh=Du2OlKFl4QWKtys1PdreXB5tJwd6hyZnEaYVpxdmlWE=;
 h=From:To:Cc:Subject:Date;
 b=cILCtlrBFuGRQc0QWwS3+EsbQnMRZCR1FODfenA5hzIfYdiGskx3TF0I/qjnODbzZ
 qSZ/OLbPjzSvFAan2ybAVZZV7qfnEsfTuXm+dd19aHEyM8p4pTscJJjeLaRAOeSdoS
 9NSI5qoE0KbIXcU2bj0H6jC/6V6GUos2BztoNH7w=
From: Jiajie Chen <c@jia.je>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, gaosong@loongson.cn, git@xen0n.name,
 Jiajie Chen <c@jia.je>, Xiaojuan Yang <yangxiaojuan@loongson.cn>
Subject: [PATCH] target/loongarch: fix ASXE flag conflict
Date: Sat, 30 Sep 2023 19:28:23 +0800
Message-ID: <20230930112837.1871691-1-c@jia.je>
X-Mailer: git-send-email 2.41.0
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

HW_FLAGS_EUEN_ASXE acccidentally conflicts with HW_FLAGS_CRMD_PG,
enabling LASX instructions even when CSR_EUEN.ASXE=0.

Closes: https://gitlab.com/qemu-project/qemu/-/issues/1907
Signed-off-by: Jiajie Chen <c@jia.je>
---
 target/loongarch/cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index f125a8e49b..79ad79a289 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -462,7 +462,7 @@ static inline void set_pc(CPULoongArchState *env, uint64_t value)
 #define HW_FLAGS_CRMD_PG    R_CSR_CRMD_PG_MASK   /* 0x10 */
 #define HW_FLAGS_EUEN_FPE   0x04
 #define HW_FLAGS_EUEN_SXE   0x08
-#define HW_FLAGS_EUEN_ASXE  0x10
+#define HW_FLAGS_EUEN_ASXE  0x40
 #define HW_FLAGS_VA32       0x20
 
 static inline void cpu_get_tb_cpu_state(CPULoongArchState *env, vaddr *pc,
-- 
2.41.0


