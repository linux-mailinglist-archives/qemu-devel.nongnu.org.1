Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 836DC786BBB
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 11:28:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ6al-0004zB-9R; Thu, 24 Aug 2023 05:25:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qZ6aB-000430-VS
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:24:57 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qZ6a9-0003gt-5y
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:24:51 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxqOjFIedkh3kbAA--.20138S3;
 Thu, 24 Aug 2023 17:24:21 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxJ826IedkJjhiAA--.40637S24; 
 Thu, 24 Aug 2023 17:24:21 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, richard.henderson@linaro.org, Jiajie Chen <c@jia.je>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 22/31] hw/loongarch: Remove restriction of la464 cores in the
 virt machine
Date: Thu, 24 Aug 2023 17:24:00 +0800
Message-Id: <20230824092409.1492470-23-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230824092409.1492470-1-gaosong@loongson.cn>
References: <20230824092409.1492470-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxJ826IedkJjhiAA--.40637S24
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
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Allow virt machine to be used with la132 instead of la464.

Co-authored-by: Jiajie Chen <c@jia.je>
Signed-off-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20230822032724.1353391-11-gaosong@loongson.cn>
Message-Id: <20230822071959.35620-5-philmd@linaro.org>
---
 hw/loongarch/virt.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index e19b042ce8..af15bf5aaa 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -798,11 +798,6 @@ static void loongarch_init(MachineState *machine)
         cpu_model = LOONGARCH_CPU_TYPE_NAME("la464");
     }
 
-    if (!strstr(cpu_model, "la464")) {
-        error_report("LoongArch/TCG needs cpu type la464");
-        exit(1);
-    }
-
     if (ram_size < 1 * GiB) {
         error_report("ram_size must be greater than 1G.");
         exit(1);
-- 
2.39.1


