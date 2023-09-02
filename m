Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C97A790522
	for <lists+qemu-devel@lfdr.de>; Sat,  2 Sep 2023 07:07:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qcIoT-0007sC-5B; Sat, 02 Sep 2023 01:04:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qcIoN-0007hv-Jt
 for qemu-devel@nongnu.org; Sat, 02 Sep 2023 01:04:43 -0400
Received: from hognose1.porkbun.com ([35.82.102.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qcIoH-0001AF-KW
 for qemu-devel@nongnu.org; Sat, 02 Sep 2023 01:04:43 -0400
Received: from ls3a6000.. (unknown [223.72.40.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: c@jia.je)
 by hognose1.porkbun.com (Postfix) with ESMTPSA id A0A7244378;
 Sat,  2 Sep 2023 05:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jia.je; s=default;
 t=1693631074; bh=imShC+zTFtvhXOODpmF+btMlH7aeverR52OZGJkHKLY=;
 h=From:To:Cc:Subject:Date;
 b=XyvQd9lLRBrXMIbpoZNCDvdEFUTdnCLqNDkvIvH7yBvI+6s3TSzLD1D/tMUe54pTc
 OiZ1z9xpKfS+ctlQL3tXIqtwcKux4I9FV1YS6LLMzgOges5Wqfl2TcaTs2Bw/jqzEE
 1OwvzoYUrmbS9LK8cWnsZcU2ZhJnlTL+/B3ZdswY=
From: Jiajie Chen <c@jia.je>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, gaosong@loongson.cn, git@xen0n.name,
 Jiajie Chen <c@jia.je>
Subject: [PATCH v3 00/16] Lower TCG vector ops to LSX
Date: Sat,  2 Sep 2023 13:02:00 +0800
Message-ID: <20230902050415.1832700-1-c@jia.je>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=35.82.102.206; envelope-from=c@jia.je;
 helo=hognose1.porkbun.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

This patch series allows qemu to utilize LSX instructions on LoongArch
machines to execute TCG vector ops.

Passed tcg tests with x86_64 and aarch64 cross compilers.

Changes since v2:

- Add vece argument to tcg_target_const_match() for const args of vector ops
- Use custom constraint for cmp_vec/add_vec/sub_vec for better const arg handling
- Implement 128-bit load & store using vldx/vstx

Changes since v1:

- Optimize dupi_vec/st_vec/ld_vec/cmp_vec/add_vec/sub_vec generation
- Lower not_vec/shi_vec/roti_vec/rotv_vec

Jiajie Chen (16):
  tcg/loongarch64: Import LSX instructions
  tcg/loongarch64: Lower basic tcg vec ops to LSX
  tcg: pass vece to tcg_target_const_match()
  tcg/loongarch64: Lower cmp_vec to vseq/vsle/vslt
  tcg/loongarch64: Lower add/sub_vec to vadd/vsub
  tcg/loongarch64: Lower vector bitwise operations
  tcg/loongarch64: Lower neg_vec to vneg
  tcg/loongarch64: Lower mul_vec to vmul
  tcg/loongarch64: Lower vector min max ops
  tcg/loongarch64: Lower vector saturated ops
  tcg/loongarch64: Lower vector shift vector ops
  tcg/loongarch64: Lower bitsel_vec to vbitsel
  tcg/loongarch64: Lower vector shift integer ops
  tcg/loongarch64: Lower rotv_vec ops to LSX
  tcg/loongarch64: Lower rotli_vec to vrotri
  tcg/loongarch64: Implement 128-bit load & store

 tcg/aarch64/tcg-target.c.inc         |    2 +-
 tcg/arm/tcg-target.c.inc             |    2 +-
 tcg/i386/tcg-target.c.inc            |    2 +-
 tcg/loongarch64/tcg-insn-defs.c.inc  | 6251 +++++++++++++++++++++++++-
 tcg/loongarch64/tcg-target-con-set.h |    9 +
 tcg/loongarch64/tcg-target-con-str.h |    3 +
 tcg/loongarch64/tcg-target.c.inc     |  601 ++-
 tcg/loongarch64/tcg-target.h         |   40 +-
 tcg/loongarch64/tcg-target.opc.h     |   12 +
 tcg/mips/tcg-target.c.inc            |    2 +-
 tcg/ppc/tcg-target.c.inc             |    2 +-
 tcg/riscv/tcg-target.c.inc           |    2 +-
 tcg/s390x/tcg-target.c.inc           |    2 +-
 tcg/sparc64/tcg-target.c.inc         |    2 +-
 tcg/tcg.c                            |    4 +-
 tcg/tci/tcg-target.c.inc             |    2 +-
 16 files changed, 6806 insertions(+), 132 deletions(-)
 create mode 100644 tcg/loongarch64/tcg-target.opc.h

-- 
2.42.0


