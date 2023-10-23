Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C21697D3AD8
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 17:32:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quwti-00010q-Jh; Mon, 23 Oct 2023 11:31:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1quwtd-00010F-Ri
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 11:31:14 -0400
Received: from hognose1.porkbun.com ([35.82.102.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1quwta-0002Kl-Tq
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 11:31:13 -0400
Received: from cslab-raptor.. (unknown [166.111.226.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: c@jia.je)
 by hognose1.porkbun.com (Postfix) with ESMTPSA id E7AE2444D4;
 Mon, 23 Oct 2023 15:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jia.je; s=default;
 t=1698075061; bh=FzU5h3sjpoz7D/ob8I4koQtFvd7S8p6KBWBRKnc1oEQ=;
 h=From:To:Cc:Subject:Date;
 b=suXHY7N4iMuu22HaU6oOnJZkNqi/mSuid42Iy7eiceRZZv6OtRNmEThYcKvpiAE7s
 7ErDWiAderlSCzkHj7BTkjj5MkYuZ599l7YfWE3EiVm6WFQ0maXOEtJK4jG+D6F+hy
 9tXwlMCt96qT2BCHa9qvlPfSrDgwFb4k1rsDLzPc=
From: Jiajie Chen <c@jia.je>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, gaosong@loongson.cn, git@xen0n.name,
 Jiajie Chen <c@jia.je>
Subject: [PATCH 0/5] Add LoongArch v1.1 instructions
Date: Mon, 23 Oct 2023 23:29:17 +0800
Message-ID: <20231023153029.269211-2-c@jia.je>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Latest revision of LoongArch ISA is out at
https://www.loongson.cn/uploads/images/2023102309132647981.%E9%BE%99%E8%8A%AF%E6%9E%B6%E6%9E%84%E5%8F%82%E8%80%83%E6%89%8B%E5%86%8C%E5%8D%B7%E4%B8%80_r1p10.pdf
(Chinese only). The revision includes the following updates:

- estimated fp reciporcal instructions: frecip -> frecipe, frsqrt ->
  frsqrte
- 128-bit width store-conditional instruction: sc.q
- ll.w/d with acquire semantic: llacq.w/d, sc.w/d with release semantic:
  screl.w/d
- compare and swap instructions: amcas[_db].b/w/h/d
- byte and word-wide amswap/add instructions: am{swap/add}[_db].{b/h}
- new definition for dbar hints
- clarify 32-bit division instruction hebavior
- clarify load ordering when accessing the same address
- introduce message signaled interrupt
- introduce hardware page table walker

The new revision is implemented in the to be released Loongson 3A6000
processor.

This patch series implements the new instructions except sc.q, because I
do not know how to match a pair of ll.d to sc.q.


Jiajie Chen (5):
  include/exec/memop.h: Add MO_TESB
  target/loongarch: Add am{swap/add}[_db].{b/h}
  target/loongarch: Add amcas[_db].{b/h/w/d}
  target/loongarch: Add estimated reciprocal instructions
  target/loongarch: Add llacq/screl instructions

 include/exec/memop.h                          |  1 +
 target/loongarch/cpu.h                        |  4 ++
 target/loongarch/disas.c                      | 32 ++++++++++++
 .../loongarch/insn_trans/trans_atomic.c.inc   | 52 +++++++++++++++++++
 .../loongarch/insn_trans/trans_farith.c.inc   |  4 ++
 target/loongarch/insn_trans/trans_vec.c.inc   |  8 +++
 target/loongarch/insns.decode                 | 32 ++++++++++++
 target/loongarch/translate.h                  | 27 +++++++---
 8 files changed, 152 insertions(+), 8 deletions(-)

-- 
2.42.0


