Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 993D0A41406
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Feb 2025 04:29:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmP8p-00015x-ST; Sun, 23 Feb 2025 22:28:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tmP8d-00012I-PW
 for qemu-devel@nongnu.org; Sun, 23 Feb 2025 22:28:16 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tmP8Z-0004V7-OB
 for qemu-devel@nongnu.org; Sun, 23 Feb 2025 22:28:11 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Bx364957tnKl2AAA--.5969S3;
 Mon, 24 Feb 2025 11:27:57 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMDx_MQ857tnVqMlAA--.6451S2;
 Mon, 24 Feb 2025 11:27:56 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org,
	lixianglai <lixianglai@loongson.cn>
Subject: [PATCH v2 0/8] target/loongarch: Add paravirt feature support
Date: Mon, 24 Feb 2025 11:27:48 +0800
Message-Id: <20250224032756.809994-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMDx_MQ857tnVqMlAA--.6451S2
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

Paravirt features is enabled by default if it is supported by KVM host,
such as KVM_FEATURE_IPI and KVM_FEATURE_STEAL_TIME, however paravirt
feature KVM_FEATURE_VIRT_EXTIOI is controlled from qemu VMM rather KVM
host.

From qemu VMM side, all paravirt features should be controlled. Here
property of paravirt features are added, also feature detection and
enabling is added here.

---
  v1 ... v2:
    1. Add stub implementation with kvm_loongarch_cpu_post_init() so that
       it passes to compile with --without-system option.
    2. In order to detect supported paravirt features from qmp command,
       paravirt feature is added in array cpu_model_advertised_features
       such as  kvm-pv-ipi and kvm-steal-time.
---
Bibo Mao (8):
  target/loongarch: Add post init function for kvm mode
  target/loongarch: Mov kvm specified vcpu property to kvm directory
  target/loongarch: Add CPU property for paravirt ipi feature
  target/loongarch: Add paravirt ipi feature detection
  target/loongarch: Add paravirt ipi feature enabling
  target/loongarch: Add CPU property for kvm steal time feature
  target/loongarch: Add kvm steal time feature detection
  target/loongarch: Add virtual extioi feature enabling

 hw/loongarch/virt.c                   |   8 --
 include/hw/loongarch/virt.h           |   9 ++
 target/loongarch/cpu.c                |  42 +-----
 target/loongarch/cpu.h                |  13 ++
 target/loongarch/kvm/kvm.c            | 177 +++++++++++++++++++++++++-
 target/loongarch/loongarch-qmp-cmds.c |   2 +-
 6 files changed, 202 insertions(+), 49 deletions(-)


base-commit: db7aa99ef894e88fc5eedf02ca2579b8c344b2ec
-- 
2.39.3


