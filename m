Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D109F2852
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Dec 2024 02:59:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tN0LT-0006Gf-9q; Sun, 15 Dec 2024 20:56:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tN0LK-0006Fo-7G
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 20:56:18 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tN0LH-0007lU-EB
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 20:56:17 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8AxaeG3iF9nd0BXAA--.38440S3;
 Mon, 16 Dec 2024 09:56:07 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMAxnsK3iF9nKNCEAA--.50112S2;
 Mon, 16 Dec 2024 09:56:07 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org,
	Song Gao <gaosong@loongson.cn>
Subject: [PULL 00/18] loongarch-to-apply queue
Date: Mon, 16 Dec 2024 09:55:49 +0800
Message-Id: <20241216015607.1795880-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAxnsK3iF9nKNCEAA--.50112S2
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

The following changes since commit ca80a5d026a280762e0772615f1988db542b3ade:

  Merge tag 'hw-misc-20241214' of https://github.com/philmd/qemu into staging (2024-12-14 08:42:53 -0500)

are available in the Git repository at:

  https://gitlab.com/bibo-mao/qemu.git tags/pull-loongarch-20241216

for you to fetch changes up to efada537c6c49e414ae87ce66803d6d8543ad140:

  hw/intc/loongarch_extioi: Code cleanup about loongarch_extioi (2024-12-16 09:05:14 +0800)

----------------------------------------------------------------
pull-loongarch-20241216
  v1 .. v2: Push patch again since forgot to push to upstream

----------------------------------------------------------------
Bibo Mao (18):
      include: Add loongarch_pic_common header file
      include: Move struct LoongArchPCHPIC to loongarch_pic_common header file
      hw/intc/loongarch_pch: Merge instance_init() into realize()
      hw/intc/loongarch_pch: Rename LoongArchPCHPIC with LoongArchPICCommonState
      hw/intc/loongarch_pch: Move some functions to file loongarch_pic_common
      hw/intc/loongarch_pch: Inherit from loongarch_pic_common
      hw/intc/loongarch_pch: Add pre_save and post_load interfaces
      hw/intc/loongarch_pch: Code cleanup about loongarch_pch_pic
      include: Add loongarch_extioi_common header file
      include: Move struct LoongArchExtIOI to header file loongarch_extioi_common
      include: Rename LoongArchExtIOI with LoongArchExtIOICommonState
      hw/intc/loongarch_extioi: Rename LoongArchExtIOI with LoongArchExtIOICommonState
      hw/intc/loongarch_extioi: Add common realize interface
      hw/intc/loongarch_extioi: Add unrealize interface
      hw/intc/loongarch_extioi: Add common file loongarch_extioi_common
      hw/intc/loongarch_extioi: Inherit from loongarch_extioi_common
      hw/intc/loongarch_extioi: Add pre_save interface
      hw/intc/loongarch_extioi: Code cleanup about loongarch_extioi

 hw/intc/loongarch_extioi.c                | 110 +++++++++--------------------
 hw/intc/loongarch_extioi_common.c         | 113 ++++++++++++++++++++++++++++++
 hw/intc/loongarch_pch_pic.c               | 106 +++++++++-------------------
 hw/intc/loongarch_pic_common.c            |  97 +++++++++++++++++++++++++
 hw/intc/meson.build                       |   4 +-
 hw/loongarch/virt.c                       |   2 +-
 include/hw/intc/loongarch_extioi.h        |  84 +++-------------------
 include/hw/intc/loongarch_extioi_common.h |  98 ++++++++++++++++++++++++++
 include/hw/intc/loongarch_pch_pic.h       |  70 ++++--------------
 include/hw/intc/loongarch_pic_common.h    |  82 ++++++++++++++++++++++
 10 files changed, 488 insertions(+), 278 deletions(-)
 create mode 100644 hw/intc/loongarch_extioi_common.c
 create mode 100644 hw/intc/loongarch_pic_common.c
 create mode 100644 include/hw/intc/loongarch_extioi_common.h
 create mode 100644 include/hw/intc/loongarch_pic_common.h


