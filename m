Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3549FF6AB
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Jan 2025 08:55:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTG23-0005nI-RU; Thu, 02 Jan 2025 02:54:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tTG20-0005mf-H7
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 02:54:12 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tTG1w-0000YX-J6
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 02:54:12 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8BxPOIWRnZnxi5dAA--.51887S3;
 Thu, 02 Jan 2025 15:53:58 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMDx_8cVRnZn0i8RAA--.16082S2;
 Thu, 02 Jan 2025 15:53:57 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 0/3] hw/intc/loongarch_extioi: Add irq routing from physical
 cpu id
Date: Thu,  2 Jan 2025 15:53:54 +0800
Message-Id: <20250102075357.2541410-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMDx_8cVRnZn0i8RAA--.16082S2
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

The similiar with IPI, physical cpu id is used for irq routing. Also
get cpu number from possible_cpu_arch_ids() and remove num-cpu
property for TYPE_LOONGARCH_EXTIOI_COMMON object.

Bibo Mao (3):
  hw/intc/loongarch_extioi: Get cpu number from possible_cpu_arch_ids
  hw/intc/loongarch_extioi: Remove num-cpu property
  hw/intc/loongarch_extioi: Add irq routing support from physical id

 hw/intc/loongarch_extioi.c                | 45 +++++++++++++++++------
 hw/intc/loongarch_extioi_common.c         | 14 -------
 hw/loongarch/virt.c                       |  1 -
 include/hw/intc/loongarch_extioi_common.h |  2 +
 4 files changed, 35 insertions(+), 27 deletions(-)


base-commit: 2b7a80e07a29074530a0ebc8005a418ee07b1faf
-- 
2.39.3


