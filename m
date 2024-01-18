Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A6A8318AD
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 12:49:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQQsG-0005Ll-TD; Thu, 18 Jan 2024 06:47:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1rQQro-0005C6-D7
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 06:47:28 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1rQQrk-0004kd-Ft
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 06:47:28 -0500
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxefDKD6lljZ4BAA--.8245S3;
 Thu, 18 Jan 2024 19:47:22 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxXs3HD6llrW8IAA--.40089S11; 
 Thu, 18 Jan 2024 19:47:22 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org, philmd@linaro.org,
 maobibo@loongson.cn, zhaotianrui@loongson.cn, lixianglai@loongson.cn
Subject: [RESEND PATCH v4 09/17] hw/loongarch: Fix fdt memory node wrong 'reg'
Date: Thu, 18 Jan 2024 19:31:15 +0800
Message-Id: <20240118113123.1672939-10-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240118113123.1672939-1-gaosong@loongson.cn>
References: <20240118113123.1672939-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxXs3HD6llrW8IAA--.40089S11
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

The right fdt memory node like [1], not [2]

  [1]
        memory@0 {
                device_type = "memory";
                reg = <0x00 0x00 0x00 0x10000000>;
        };
  [2]
        memory@0 {
                device_type = "memory";
                reg = <0x02 0x00 0x02 0x10000000>;
        };

Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
Message-Id: <20231227080821.3216113-10-gaosong@loongson.cn>
---
 hw/loongarch/virt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 5f5153e681..129cad92e5 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -290,7 +290,7 @@ static void fdt_add_memory_node(MachineState *ms,
     char *nodename = g_strdup_printf("/memory@%" PRIx64, base);
 
     qemu_fdt_add_subnode(ms->fdt, nodename);
-    qemu_fdt_setprop_cells(ms->fdt, nodename, "reg", 2, base, 2, size);
+    qemu_fdt_setprop_cells(ms->fdt, nodename, "reg", 0, base, 0, size);
     qemu_fdt_setprop_string(ms->fdt, nodename, "device_type", "memory");
 
     if (ms->numa_state && ms->numa_state->num_nodes) {
-- 
2.25.1


