Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD90BFEF52
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Oct 2025 04:48:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBlMe-0007jr-9B; Wed, 22 Oct 2025 22:47:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1vBlMX-0007j7-Nd
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 22:47:37 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1vBlMV-0006XW-2S
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 22:47:37 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8BxndI_l_loS5cZAA--.54593S3;
 Thu, 23 Oct 2025 10:47:27 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJCxmcA+l_lo4ysCAQ--.19467S2;
 Thu, 23 Oct 2025 10:47:26 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Subject: [PATCH 0/3] target/loongarch: PMU enhancement in KVM mode
Date: Thu, 23 Oct 2025 10:47:23 +0800
Message-Id: <20251023024726.2995960-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxmcA+l_lo4ysCAQ--.19467S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This patchset add PMU migration support and CSR register dump support
with debug purpose, also it removes TLB migration support in TCG mode.

Bibo Mao (3):
  target/loongarch: Add PMU migration support in KVM mode
  target/loongarch: Add PMU register dump support in KVM mode
  target/loongarch: Remove LoongArch TLB migration support in TCG mode

 target/loongarch/cpu-csr.h | 10 ++++++
 target/loongarch/cpu.c     | 14 ++++++++-
 target/loongarch/cpu.h     |  8 +++++
 target/loongarch/csr.c     |  8 +++++
 target/loongarch/kvm/kvm.c | 64 ++++++++++++++++++++++++++++++++++++++
 target/loongarch/machine.c | 43 ++++++++++---------------
 6 files changed, 120 insertions(+), 27 deletions(-)


base-commit: c0e80879c876cbe4cbde43a92403329bcedf2ba0
-- 
2.39.3


