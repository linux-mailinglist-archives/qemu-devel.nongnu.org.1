Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD069A04AA
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Oct 2024 10:50:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0zjg-0008Mv-Cb; Wed, 16 Oct 2024 04:50:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1t0zjd-0008Cs-B4
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 04:50:25 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1t0zjb-0006gx-F0
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 04:50:25 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Bx22oCfg9nMdUfAA--.46009S3;
 Wed, 16 Oct 2024 16:49:06 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowMAx_9X4fQ9n6ncsAA--.29226S7;
 Wed, 16 Oct 2024 16:49:06 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 5/5] hw/loongarch/fw_cfg: Build in common_ss[]
Date: Wed, 16 Oct 2024 16:31:03 +0800
Message-Id: <20241016083103.2541727-6-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20241016083103.2541727-1-gaosong@loongson.cn>
References: <20241016083103.2541727-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAx_9X4fQ9n6ncsAA--.29226S7
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Nothing in LoongArch fw_cfg.c requires target specific definitions.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240927213254.17552-3-philmd@linaro.org>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 hw/loongarch/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/loongarch/meson.build b/hw/loongarch/meson.build
index bce7ebac97..005f017e21 100644
--- a/hw/loongarch/meson.build
+++ b/hw/loongarch/meson.build
@@ -1,8 +1,8 @@
 loongarch_ss = ss.source_set()
 loongarch_ss.add(files(
-    'fw_cfg.c',
     'boot.c',
 ))
+common_ss.add(when: 'CONFIG_LOONGARCH_VIRT', if_true: files('fw_cfg.c'))
 loongarch_ss.add(when: 'CONFIG_LOONGARCH_VIRT', if_true: files('virt.c'))
 loongarch_ss.add(when: 'CONFIG_ACPI', if_true: files('acpi-build.c'))
 
-- 
2.34.1


