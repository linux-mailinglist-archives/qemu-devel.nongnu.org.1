Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD50B436E8
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Sep 2025 11:20:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uu66u-0006ZT-U3; Thu, 04 Sep 2025 05:18:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@zevorn.cn>)
 id 1uu66q-0006Y4-HB; Thu, 04 Sep 2025 05:18:24 -0400
Received: from [115.124.28.68] (helo=out28-68.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@zevorn.cn>)
 id 1uu66i-0002sz-7R; Thu, 04 Sep 2025 05:18:24 -0400
Received: from ZEVORN-PC(mailfrom:chao.liu@zevorn.cn
 fp:SMTPD_---.eXOUI2e_1756977228 cluster:ay29) by smtp.aliyun-inc.com;
 Thu, 04 Sep 2025 17:13:49 +0800
From: Chao Liu <chao.liu@zevorn.cn>
To: richard.henderson@linaro.org, paolo.savini@embecosm.com, npiggin@gmail.com,
 ebiggers@kernel.org, dbarboza@ventanamicro.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, Chao Liu <chao.liu@zevorn.cn>
Subject: [PATCH v7 0/2] Generate strided vector loads/stores with tcg nodes
Date: Thu,  4 Sep 2025 17:13:44 +0800
Message-ID: <cover.1756975571.git.chao.liu@zevorn.cn>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.28.68 (deferred)
Received-SPF: pass client-ip=115.124.28.68; envelope-from=chao.liu@zevorn.cn;
 helo=out28-68.mail.aliyun.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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

Hi all,

Thanks Nick for the review. In patch v7:

1. Standardize the subject line of patch 1 and remove the trailing period.

2. Split into sub-functions to improve the patch's code readability and
   facilitate review.

3. Use more faster TCG ops, use tcg_gen_andi_tl() instead of tcg_gen_rem_tl().

4. Add a tested-by signature for patch 2, as Eric has already tested it.


History of changes:

patch v6:
- If a strided vector memory access instruction has non-zero vstart, 
  check it through vlse/vsse helpers function.
- Adjust the tcg test Makefile.
  https://lore.kernel.org/qemu-devel/cover.1756906528.git.chao.liu@zevorn.cn/

Patch v5:
- Removed the redundant call to mark_vs_dirty(s) within the
  gen_ldst_stride_main_loop() function.
  https://lore.kernel.org/qemu-riscv/cover.1755609029.git.chao.liu@zevorn.cn/

Patch v4:
- Use ctz32() replace to for-loop
  https://lore.kernel.org/qemu-devel/cover.1755333616.git.chao.liu@yeah.net/

Patch v3:
- Fix the get_log2() function:
  https://lore.kernel.org/qemu-riscv/cover.1755287531.git.chao.liu@yeah.net/T/#t
- Add test for vlsseg8e32 instruction.
- Rebase on top of the latest master.

Patch v2:
- Split the TCG node emulation of the complex strided load/store operation into
  two separate functions to simplify the implementation:
  https://lore.kernel.org/qemu-riscv/20250312155547.289642-1-paolo.savini@embecosm.com/

Patch v1:
- Paolo submitted the initial version of the patch.
  https://lore.kernel.org/qemu-devel/20250211182056.412867-1-paolo.savini@embecosm.com/


Tanks,
Chao

Chao Liu (2):
  target/riscv: Use tcg nodes for strided vector ld/st generation
  tests/tcg/riscv64: Add test for vlsseg8e32 instruction

 target/riscv/insn_trans/trans_rvv.c.inc   | 348 ++++++++++++++++++++--
 tests/tcg/riscv64/Makefile.softmmu-target |   7 +-
 tests/tcg/riscv64/test-vlsseg8e32.S       | 107 +++++++
 3 files changed, 444 insertions(+), 18 deletions(-)
 create mode 100644 tests/tcg/riscv64/test-vlsseg8e32.S

-- 
2.50.1


