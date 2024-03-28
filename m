Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 246188748DD
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Mar 2024 08:37:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ri8Jo-0007Ir-85; Thu, 07 Mar 2024 02:37:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1ri8Jh-0007Ba-Ri
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 02:37:26 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1ri8Jf-00051p-Jw
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 02:37:25 -0500
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8DxK+mrbullxrAVAA--.35453S3;
 Thu, 07 Mar 2024 15:37:15 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Dxfs2qbulld+9PAA--.14088S2; 
 Thu, 07 Mar 2024 15:37:14 +0800 (CST)
From: Xianglai Li <lixianglai@loongson.cn>
To: qemu-devel@nongnu.org
Cc: maobibo@loongson.cn, Song Gao <gaosong@loongson.cn>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, zhaotianrui@loongson.cn
Subject: [PATCH V3 0/1] target/loongarch: Fixed tlb huge page loading issue
Date: Thu,  7 Mar 2024 15:37:02 +0800
Message-Id: <cover.1709796364.git.lixianglai@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dxfs2qbulld+9PAA--.14088S2
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

When we use qemu tcg simulation, the page size of bios is 4KB.
When using the level 2 super large page (page size is 1G) to create the page table,
it is found that the content of the corresponding address space is abnormal,
resulting in the bios can not start the operating system and graphical interface normally.

The lddir and ldpte instruction emulation has
a problem with the use of super large page processing above level 2.
The page size is not correctly calculated,
resulting in the wrong page size of the table entry found by tlb.

Changes log:
V2->V3:
Delete the intermediate variable LDDIR_PS, and implement lddir and ldpte
huge pages by referring to the latest architecture reference manual.

V1->V2:
Modified the patch title format and Enrich the commit mesg description

Cc: maobibo@loongson.cn
Cc: Song Gao <gaosong@loongson.cn>
Cc: Xiaojuan Yang <yangxiaojuan@loongson.cn>
Cc: zhaotianrui@loongson.cn

Xianglai Li (1):
  target/loongarch: Fixed tlb huge page loading issue

 target/loongarch/internals.h      |  8 +++
 target/loongarch/tcg/tlb_helper.c | 92 +++++++++++++++++++++++--------
 2 files changed, 76 insertions(+), 24 deletions(-)

-- 
2.39.1


