Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E5571A494F5
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Feb 2025 10:29:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnwfi-0003Kh-4K; Fri, 28 Feb 2025 04:28:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1tnwfb-0003A4-5m
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 04:28:35 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1tnwfY-0001Uj-1e
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 04:28:34 -0500
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxTWu6gcFnydOFAA--.32442S3;
 Fri, 28 Feb 2025 17:28:26 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowMBxLse5gcFnnJYtAA--.40662S2;
 Fri, 28 Feb 2025 17:28:25 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org,
	maobibo@loongson.cn
Cc: richard.henderson@linaro.org, yangxiaojuan@loongson.cn,
 wangliupu@loongson.cn
Subject: [PATCH v5 0/2] target/loongarch: fix 'make check-functional' failed
Date: Fri, 28 Feb 2025 17:06:57 +0800
Message-Id: <20250228090659.2434568-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxLse5gcFnnJYtAA--.40662S2
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

 Some tlb instructions get the tlb_ps from tlb->misc but the
 value may has been initialized to 0,just check the tlb_e skip
 the function and check_tlb_ps write a log.

For LoongArch th min tlb_ps is 12(4KB), for TLB code,
the tlb_ps may be 0,this may case UndefinedBehavior
Add a check-tlb_ps fuction to check tlb_ps,
to make sure the tlb_ps is avalablie. we check tlb_ps
when get the tlb_ps from tlb->misc or CSR bits.
1. cpu reset.
   set CSR_PWCL.PTBASE and CSR_STLBPS.PS bits a default value
   from CSR_PRCFG2;
2. tlb instructions.
   some tlb instructions get  the tlb_ps from tlb->misc but the
   value may  has been initialized to 0. we need just check the tlb_e
   skip the function and check tlb_ps write a guest log.
3. csrwr instructions.
   to make sure CSR_PWCL.PTBASE and CSR_STLBPS.PS bits are avalable,
   cheke theses bits and set a default value from CSR_PRCFG2.

V5:
  1 Add add chek_ps() function to check tlb_ps with CSR_PRCFG2;
  2 Some tlb instuctions, just check tlb_ps, do't rewrite the tlb_ps
  bits  just write a guest log;
  3 remove csrwr crmd helper function and crmd check PWCL and check CSR_STLBPS.just
chcek PWCL and STLBPS when csrwr CSR_PWCL and CSR_STLBPS;
  4 set CSR_PWCL.PTBASE and CSR_STLBPS.PS bits a default value
   from CSR_PRCFG2 when cpu reset.
V4:
1.Get the default tlb_ps value from env->CSR_PRCFG2.
2.Some tlb  instrucions check the tlb_ps such as tlbfill/tlbwr/invtlb.
3.check_tlb_ps()just check CSR_PWCL.PTBASE bits and CSR_STLBPS.PS bits.
don't check all tlb->misc.

v3:
remove some tlb instruction chek MMU on PG model, because on DA model
also can use tlb instructions.

v2:
check-tlb_ps when write CSR_PWCL and CSR_STLBPS;
some tlb instructions check CRMD PG model when clear/read/write the tlb.
link to patch: https://patchew.org/QEMU/20250220012226.2182174-1-gaosong@loongson.cn/

Thanks.
Song Gao

Song Gao (2):
  target/loongarch: fix 'make check-functional' failed
  target/loongarch: check tlb_ps

 target/loongarch/cpu.c                        | 10 +++-
 target/loongarch/cpu_helper.c                 |  8 ++-
 target/loongarch/helper.h                     |  1 +
 target/loongarch/internals.h                  |  2 +
 target/loongarch/tcg/csr_helper.c             | 30 +++++++++-
 .../tcg/insn_trans/trans_privileged.c.inc     |  1 +
 target/loongarch/tcg/tlb_helper.c             | 55 ++++++++++++++++++-
 7 files changed, 99 insertions(+), 8 deletions(-)

-- 
2.34.1


