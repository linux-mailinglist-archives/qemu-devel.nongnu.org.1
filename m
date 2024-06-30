Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E1E91CFEB
	for <lists+qemu-devel@lfdr.de>; Sun, 30 Jun 2024 05:09:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNkvA-0006QV-Dx; Sat, 29 Jun 2024 23:08:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sNkv8-0006QH-9A; Sat, 29 Jun 2024 23:08:06 -0400
Received: from out30-101.freemail.mail.aliyun.com ([115.124.30.101])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sNkv5-0000rg-Ha; Sat, 29 Jun 2024 23:08:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1719716869; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
 bh=2W18I21YVGI00DBbJ+TTeefdJFKUPsF/bVJQ3CxV0cA=;
 b=SErGqvvpGJ8PZsFGf3xesReG5s1AiZzUNmYg5KrOfyMZP/58M624RIpUn9RSisYTM2eaOQ6cI9JSr7QCldf/5augUMm89Ixima+HcKmVJI+YgnyqVyt6d+tUBsQtq0q3YtvPl2ob/fI3gfgAq1CduIQM0HTw1AwxvxO/QGFUj3s=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R451e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037067110;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=8; SR=0;
 TI=SMTPD_---0W9UZ3Lr_1719716866; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0W9UZ3Lr_1719716866) by smtp.aliyun-inc.com;
 Sun, 30 Jun 2024 11:07:47 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH v2 00/11] target/riscv: Support zimop/zcmop/zama16b/zabha 
Date: Sun, 30 Jun 2024 11:05:48 +0800
Message-Id: <20240630030559.877-1-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.101;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-101.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

We have sent their implementations separately, and we have received few objective
comments except for some ISA extensions order. So, I have put them together
as one patch set to make it easier for merging.

v1->v2:
    1. Fix the isa orders.
    2. Make zimop/zcmop/zama16b/zabha depend on priviledged 1.13
    2. Add review tags.

The v1 patch set is here
    1. zimop/zcmop
        https://mail.gnu.org/archive/html/qemu-riscv/2024-05/msg00207.html
    2. zama16b
        https://mail.gnu.org/archive/html/qemu-riscv/2024-05/msg00212.html
    3. zabha
        https://mail.gnu.org/archive/html/qemu-riscv/2024-05/msg00214.html

LIU Zhiwei (11):
  target/riscv: Add zimop extension
  disas/riscv: Support zimop disassemble
  target/riscv: Add zcmop extension
  disas/riscv: Support zcmop disassemble
  target/riscv: Support Zama16b extension
  target/riscv: Move gen_amo before implement Zabha
  target/riscv: Add AMO instructions for Zabha
  target/riscv: Move gen_cmpxchg before adding amocas.[b|h]
  target/riscv: Add amocas.[b|h] for Zabha
  target/riscv: Enable zabha for max cpu
  disas/riscv: Support zabha disassemble

 disas/riscv.c                               | 183 ++++++++++++++++++++
 target/riscv/cpu.c                          |   8 +
 target/riscv/cpu_cfg.h                      |   4 +
 target/riscv/insn16.decode                  |   1 +
 target/riscv/insn32.decode                  |  33 ++++
 target/riscv/insn_trans/trans_rva.c.inc     |  51 ++----
 target/riscv/insn_trans/trans_rvd.c.inc     |  14 +-
 target/riscv/insn_trans/trans_rvf.c.inc     |  14 +-
 target/riscv/insn_trans/trans_rvi.c.inc     |   6 +
 target/riscv/insn_trans/trans_rvzabha.c.inc | 145 ++++++++++++++++
 target/riscv/insn_trans/trans_rvzacas.c.inc |  13 --
 target/riscv/insn_trans/trans_rvzcmop.c.inc |  29 ++++
 target/riscv/insn_trans/trans_rvzimop.c.inc |  37 ++++
 target/riscv/tcg/tcg-cpu.c                  |   5 +
 target/riscv/translate.c                    |  38 ++++
 15 files changed, 531 insertions(+), 50 deletions(-)
 create mode 100644 target/riscv/insn_trans/trans_rvzabha.c.inc
 create mode 100644 target/riscv/insn_trans/trans_rvzcmop.c.inc
 create mode 100644 target/riscv/insn_trans/trans_rvzimop.c.inc

-- 
2.25.1


