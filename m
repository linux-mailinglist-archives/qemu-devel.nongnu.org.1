Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D2E7EA356
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 20:11:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2cKl-000848-ME; Mon, 13 Nov 2023 14:10:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlmgr@proulx.com>) id 1r2cJp-0007xi-02
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 14:09:57 -0500
Received: from havoc.proulx.com ([198.99.81.74])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlmgr@proulx.com>) id 1r2cJn-0001BV-KT
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 14:09:56 -0500
Received: by havoc.proulx.com (Postfix, from userid 1027)
 id 9BA918B5; Mon, 13 Nov 2023 12:09:54 -0700 (MST)
Resent-From: Mailing List Manager <mlmgr@proulx.com>
Resent-Date: Mon, 13 Nov 2023 12:09:54 -0700
Resent-Message-ID: <ZVJ0gnYf0HCw5jyT@havoc.proulx.com>
Resent-To: qemu-devel@nongnu.org
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rcardenas@hatelia.local>)
 id 1r2YIS-0005Zh-C8
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 09:52:18 -0500
Received: from [213.94.54.170] (helo=hatelia.local)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rcardenas@hatelia.local>) id 1r2YIP-0005Jt-Ve
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 09:52:16 -0500
Received: by hatelia.local (Postfix, from userid 501)
 id 4E3CB39588A; Fri, 10 Nov 2023 17:15:29 +0100 (CET)
From: rcardenas.rod@gmail.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Rom=C3=A1n=20C=C3=A1rdenas=20Rodr=C3=ADguez?=
 <rcardenas.rod@gmail.com>
Subject: [PATCH] Fix CLINT clock frequency for SiFive E
Date: Fri, 10 Nov 2023 17:14:57 +0100
Message-Id: <20231110161457.60528-1-rcardenas.rod@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 213.94.54.170 (failed)
Received-SPF: none client-ip=213.94.54.170;
 envelope-from=rcardenas@hatelia.local; helo=hatelia.local
Received-SPF: pass client-ip=198.99.81.74; envelope-from=mlmgr@proulx.com;
 helo=havoc.proulx.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_ADSP_CUSTOM_MED=0.001,
 FORGED_GMAIL_RCVD=1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 HK_RANDOM_ENVFROM=0.999, NML_ADSP_CUSTOM_MED=0.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 13 Nov 2023 14:10:53 -0500
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

From: Román Cárdenas Rodríguez <rcardenas.rod@gmail.com>

---
 hw/riscv/sifive_e.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 0d37adc542..87d9602383 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -225,7 +225,7 @@ static void sifive_e_soc_realize(DeviceState *dev, Error **errp)
             RISCV_ACLINT_SWI_SIZE,
         RISCV_ACLINT_DEFAULT_MTIMER_SIZE, 0, ms->smp.cpus,
         RISCV_ACLINT_DEFAULT_MTIMECMP, RISCV_ACLINT_DEFAULT_MTIME,
-        RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ, false);
+        SIFIVE_E_LFCLK_DEFAULT_FREQ, false);
     sifive_e_prci_create(memmap[SIFIVE_E_DEV_PRCI].base);
 
     /* AON */
-- 
2.39.3 (Apple Git-145)



