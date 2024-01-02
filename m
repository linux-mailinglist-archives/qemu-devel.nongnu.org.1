Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E2952821664
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 03:15:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKUJ9-0007NZ-VV; Mon, 01 Jan 2024 21:15:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1rKUJ7-0007ND-3l
 for qemu-devel@nongnu.org; Mon, 01 Jan 2024 21:15:05 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1rKUJ4-0000xn-FR
 for qemu-devel@nongnu.org; Mon, 01 Jan 2024 21:15:04 -0500
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8DxvuuecZNl+gUBAA--.4307S3;
 Tue, 02 Jan 2024 10:14:54 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Dxjb6dcZNlziQVAA--.57902S2; 
 Tue, 02 Jan 2024 10:14:53 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, peter.maydell@linaro.org, philmd@linaro.org,
 alex.bennee@linaro.org, pbonzini@redhat.com, maobibo@loongson.cn
Subject: [PATCH v2 1/2] target/loongarch/meson: move gdbstub.c to loongarch.ss
Date: Tue,  2 Jan 2024 10:01:59 +0800
Message-Id: <20240102020200.3462097-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dxjb6dcZNlziQVAA--.57902S2
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

gdbstub.c is not specific to TCG and can be used by
other accelerators, such as KVM accelerator

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/loongarch/meson.build b/target/loongarch/meson.build
index 18e8191e2b..b3a0fb12fb 100644
--- a/target/loongarch/meson.build
+++ b/target/loongarch/meson.build
@@ -3,6 +3,7 @@ gen = decodetree.process('insns.decode')
 loongarch_ss = ss.source_set()
 loongarch_ss.add(files(
   'cpu.c',
+  'gdbstub.c',
 ))
 loongarch_tcg_ss = ss.source_set()
 loongarch_tcg_ss.add(gen)
@@ -10,7 +11,6 @@ loongarch_tcg_ss.add(files(
   'fpu_helper.c',
   'op_helper.c',
   'translate.c',
-  'gdbstub.c',
   'vec_helper.c',
 ))
 loongarch_tcg_ss.add(zlib)
-- 
2.25.1


