Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6F1A6B370
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Mar 2025 04:46:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvTKE-0006Au-FR; Thu, 20 Mar 2025 23:45:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tvTKB-0006AT-My
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 23:45:35 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tvTK8-0002H8-Bn
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 23:45:35 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8AxGHHT4NxnOp2fAA--.8355S3;
 Fri, 21 Mar 2025 11:45:23 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMBxLsfR4Nxn+j9XAA--.61233S2;
 Fri, 21 Mar 2025 11:45:22 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org,
	Song Gao <gaosong@loongson.cn>
Subject: [PULL 0/3] loongarch-to-apply queue
Date: Fri, 21 Mar 2025 11:45:18 +0800
Message-Id: <20250321034521.2425622-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxLsfR4Nxn+j9XAA--.61233S2
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

The following changes since commit 1dae461a913f9da88df05de6e2020d3134356f2e:

  Update version for v10.0.0-rc0 release (2025-03-18 10:18:14 -0400)

are available in the Git repository at:

  https://gitlab.com/bibo-mao/qemu.git tags/pull-loongarch-20250321

for you to fetch changes up to b8d5503a3ecf8bcf75e4960d04215f71dbfd5dd2:

  target/loongarch: fix bad shift in check_ps() (2025-03-21 11:31:56 +0800)

----------------------------------------------------------------
pull-loongarch-20250321 queue

----------------------------------------------------------------
Bibo Mao (1):
      docs/system: Add entry for LoongArch system

Song Gao (1):
      target/loongarch: fix bad shift in check_ps()

Yao Zi (1):
      host/include/loongarch64: Fix inline assembly compatibility with Clang

 docs/system/loongarch/virt.rst                     | 31 +++++++---------------
 docs/system/target-loongarch.rst                   | 19 +++++++++++++
 docs/system/targets.rst                            |  1 +
 host/include/loongarch64/host/atomic128-ldst.h.inc |  4 +--
 host/include/loongarch64/host/bufferiszero.c.inc   |  6 +++--
 .../loongarch64/host/load-extract-al16-al8.h.inc   |  2 +-
 target/loongarch/internals.h                       |  2 +-
 target/loongarch/tcg/csr_helper.c                  |  2 +-
 target/loongarch/tcg/tlb_helper.c                  | 10 +++----
 9 files changed, 44 insertions(+), 33 deletions(-)
 create mode 100644 docs/system/target-loongarch.rst


