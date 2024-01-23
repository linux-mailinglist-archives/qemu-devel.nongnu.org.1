Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 261AE838C09
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 11:31:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSE1a-0006l9-LP; Tue, 23 Jan 2024 05:28:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rSE1X-0006kW-UF; Tue, 23 Jan 2024 05:28:55 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rSE1V-0005EN-VI; Tue, 23 Jan 2024 05:28:55 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0923E4674B;
 Tue, 23 Jan 2024 13:29:24 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 9DF8369AE7;
 Tue, 23 Jan 2024 13:28:43 +0300 (MSK)
Received: (nullmailer pid 3831704 invoked by uid 1000);
 Tue, 23 Jan 2024 10:28:43 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Anastasia Belova <abelova@astralinux.ru>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.1.5 12/24] load_elf: fix iterator's type for elf file
 processing
Date: Tue, 23 Jan 2024 13:28:26 +0300
Message-Id: <20240123102843.3831660-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.1.5-20240123123057@cover.tls.msk.ru>
References: <qemu-stable-8.1.5-20240123123057@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Anastasia Belova <abelova@astralinux.ru>

j is used while loading an ELF file to byteswap segments'
data. If data is larger than 2GB an overflow may happen.
So j should be elf_word.

This commit fixes a minor bug: it's unlikely anybody is trying to
load ELF files with 2GB+ segments for wrong-endianness targets,
but if they did, it wouldn't work correctly.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Cc: qemu-stable@nongnu.org
Fixes: 7ef295ea5b ("loader: Add data swap option to load-elf")
Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 410c2a4d75f52f6a2fe978eda5a9b6f854afe5ea)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/include/hw/elf_ops.h b/include/hw/elf_ops.h
index dffb0e73d2..52776e8010 100644
--- a/include/hw/elf_ops.h
+++ b/include/hw/elf_ops.h
@@ -499,7 +499,7 @@ static ssize_t glue(load_elf, SZ)(const char *name, int fd,
             }
 
             if (data_swab) {
-                int j;
+                elf_word j;
                 for (j = 0; j < file_size; j += (1 << data_swab)) {
                     uint8_t *dp = data + j;
                     switch (data_swab) {
-- 
2.39.2


