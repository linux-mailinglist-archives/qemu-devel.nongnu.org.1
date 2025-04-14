Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B62A87542
	for <lists+qemu-devel@lfdr.de>; Mon, 14 Apr 2025 03:27:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u48ae-0004Iu-5Y; Sun, 13 Apr 2025 21:26:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1u48aE-00045B-PP
 for qemu-devel@nongnu.org; Sun, 13 Apr 2025 21:26:01 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1u48aA-000365-V8
 for qemu-devel@nongnu.org; Sun, 13 Apr 2025 21:25:57 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8AxCGoLZPxnmnO8AA--.50336S3;
 Mon, 14 Apr 2025 09:25:31 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMAxzxsJZPxnTz6AAA--.562S2;
 Mon, 14 Apr 2025 09:25:29 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Subject: [PATCH 0/5] target/loongarch: Code cleanup with function
 loongarch_map_address
Date: Mon, 14 Apr 2025 09:25:23 +0800
Message-Id: <20250414012528.4075447-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAxzxsJZPxnTz6AAA--.562S2
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

Get physical address from virtual address is important for qmp command to
dump memory content. In TCG mode, it searches TLB tables firstly and
then do page table walker. In KVM mode, there is no TLB tables and page
table walker is used directly.

Here TLB tables searching is moved to directory tcg, and code about page
table walker is put in common part so that it can be used in KVM mode
also.

Bibo Mao (5):
  target/loongarch: Move header file helper.h to directory tcg
  target/loongarch: Add function loongarch_get_addr_from_tlb
  target/loongarch: Move function get_dir_base_width to common directory
  target/loongarch: Set function loongarch_map_address() with common
    code
  target/loongarch: Move function loongarch_tlb_search to directory tcg

 target/loongarch/cpu_helper.c     | 173 ++-----
 target/loongarch/helper.h         | 720 +----------------------------
 target/loongarch/internals.h      |  14 +-
 target/loongarch/tcg/helper.h     | 722 ++++++++++++++++++++++++++++++
 target/loongarch/tcg/tlb_helper.c | 172 +++++--
 5 files changed, 913 insertions(+), 888 deletions(-)
 create mode 100644 target/loongarch/tcg/helper.h


base-commit: 56c6e249b6988c1b6edc2dd34ebb0f1e570a1365
-- 
2.39.3


