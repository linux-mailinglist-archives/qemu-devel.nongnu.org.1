Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9484181B02F
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 09:20:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGEHD-0005Tp-MT; Thu, 21 Dec 2023 03:19:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1rGEGx-0005Sh-Ce
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 03:19:15 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1rGEGu-0007Vw-EN
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 03:19:15 -0500
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8CxO+n59INlG1wDAA--.17088S3;
 Thu, 21 Dec 2023 16:19:06 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxG+T49INltGsDAA--.18043S2; 
 Thu, 21 Dec 2023 16:19:04 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, peter.maydell@linaro.org, richard.henderson@linaro.org
Subject: [PULL 0/2] loongarch-to-apply queue
Date: Thu, 21 Dec 2023 16:06:09 +0800
Message-Id: <20231221080611.2960977-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxG+T49INltGsDAA--.18043S2
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
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

The following changes since commit 191710c221f65b1542f6ea7fa4d30dde6e134fd7:

  Merge tag 'pull-request-2023-12-20' of https://gitlab.com/thuth/qemu into staging (2023-12-20 09:40:16 -0500)

are available in the Git repository at:

  https://gitlab.com/gaosong/qemu.git tags/pull-loongarch-20231221

for you to fetch changes up to be45144bee708d3b84c3c474a4d4aeb7e5c4733a:

  target/loongarch: Add timer information dump support (2023-12-21 16:07:47 +0800)

----------------------------------------------------------------
pull-loongarch-20231221

----------------------------------------------------------------
Bibo Mao (2):
      hw/loongarch/virt: Align high memory base address with super page size
      target/loongarch: Add timer information dump support

 include/hw/loongarch/virt.h | 2 +-
 target/loongarch/cpu.c      | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)


