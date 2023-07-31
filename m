Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9C276973A
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 15:11:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQSfH-0004e1-FZ; Mon, 31 Jul 2023 09:10:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <negge@xiph.org>) id 1qQRjF-0000sH-2a
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 08:10:26 -0400
Received: from mailfish.xiph.org ([2001:470:eb26:42:5054:ff:fe09:a40c])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <negge@xiph.org>) id 1qQRjC-0004ry-K6
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 08:10:24 -0400
Received: from [192.168.0.104] (c-24-126-94-29.hsd1.wv.comcast.net
 [24.126.94.29])
 by mailfish.xiph.org (Postfix) with ESMTPSA id 9C0799F7B6
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 12:10:16 +0000 (UTC)
To: qemu-devel@nongnu.org
From: Nathan Egge <negge@xiph.org>
Subject: [PATCH] linux-user/elfload: Set V in ELF_HWCAP for RISC-V
Message-ID: <c8b63aa1-8929-e46f-3a26-a5d9944c473c@xiph.org>
Date: Mon, 31 Jul 2023 08:10:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------576B3B0CDCDDF95A45A6CCCC"
Content-Language: en-US
Received-SPF: pass client-ip=2001:470:eb26:42:5054:ff:fe09:a40c;
 envelope-from=negge@xiph.org; helo=mailfish.xiph.org
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 31 Jul 2023 09:10:16 -0400
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

This is a multi-part message in MIME format.
--------------576B3B0CDCDDF95A45A6CCCC
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

One line patch that fixes the issue reported in:

https://gitlab.com/qemu-project/qemu/-/issues/1793

--------------576B3B0CDCDDF95A45A6CCCC
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-linux-user-elfload-Set-V-in-ELF_HWCAP-for-RISC-V.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-linux-user-elfload-Set-V-in-ELF_HWCAP-for-RISC-V.patch"

From 7122a450d745325ce250785e58c543481054bec6 Mon Sep 17 00:00:00 2001
From: "Nathan E. Egge" <negge@xiph.org>
Date: Mon, 31 Jul 2023 03:45:13 -0400
Subject: [PATCH] linux-user/elfload: Set V in ELF_HWCAP for RISC-V

Set V bit for hwcap if misa is set.

Signed-off-by: Nathan E. Egge <negge@xiph.org>
---
 linux-user/elfload.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 861ec07abc..a299ba7300 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1710,7 +1710,8 @@ static uint32_t get_elf_hwcap(void)
 #define MISA_BIT(EXT) (1 << (EXT - 'A'))
     RISCVCPU *cpu = RISCV_CPU(thread_cpu);
     uint32_t mask = MISA_BIT('I') | MISA_BIT('M') | MISA_BIT('A')
-                    | MISA_BIT('F') | MISA_BIT('D') | MISA_BIT('C');
+                    | MISA_BIT('F') | MISA_BIT('D') | MISA_BIT('C')
+                    | MISA_BIT('V');
 
     return cpu->env.misa_ext & mask;
 #undef MISA_BIT
-- 
2.35.1


--------------576B3B0CDCDDF95A45A6CCCC--

