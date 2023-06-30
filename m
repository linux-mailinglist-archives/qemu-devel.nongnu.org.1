Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F51E743F77
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 18:08:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFGf5-00064h-Le; Fri, 30 Jun 2023 12:07:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng@tinylab.org>) id 1qFGf2-00063e-N7
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 12:07:52 -0400
Received: from bg4.exmail.qq.com ([43.154.221.58])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng@tinylab.org>) id 1qFGez-0002AV-RJ
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 12:07:52 -0400
X-QQ-mid: bizesmtp68t1688141242tfa77ev9
Received: from ubuntu.. ( [111.196.130.174]) by bizesmtp.qq.com (ESMTP) with 
 id ; Sat, 01 Jul 2023 00:07:21 +0800 (CST)
X-QQ-SSF: 01200000000000F0G000000A0000000
X-QQ-FEAT: 5q30pvLz2ieWoWMfxqb7H2KICkwc1VtJYJ+QUK18JhUAeNqxX6FW1ThPFt7Ni
 8YGCQgtkoEH3eo7fhAvDcPljEcuEf6sxo1F5XAHtqc7bGBe0Nhu51/MUu/FbinN7iKxWWxW
 kKmpDFATX7r6/asQV6x31SUZeo9tuiUePtuZlykzx+++16k9ixrGjivaH3xG7uvGBJC8/I5
 yePQCABnplfwucoJum4PhXPwcWzMmWnV4j1bdvKiGlbCitFvmMLcqzekWYREctvx3mf9jW6
 ZIs2fG5IotTOaYATFNiSIQvi2bbIYTwcKEwBVtuZlaCkkY/hC2w3bwexaVGUnhXVgpL9qey
 kPDpA6i1nD0q85K5LOclLI1K5uY6ZmOr1PXQFOX
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14815911306921742767
From: Bin Meng <bmeng@tinylab.org>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Subject: [PATCH 2/2] tests/avocado: riscv: Enable 32-bit Spike OpenSBI boot
 testing
Date: Sat,  1 Jul 2023 00:07:17 +0800
Message-Id: <20230630160717.843044-2-bmeng@tinylab.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230630160717.843044-1-bmeng@tinylab.org>
References: <20230630160717.843044-1-bmeng@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz7a-0
Received-SPF: pass client-ip=43.154.221.58; envelope-from=bmeng@tinylab.org;
 helo=bg4.exmail.qq.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SBL=0.141,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

The 32-bit Spike boot issue has been fixed in the OpenSBI v1.3.
Let's enable the 32-bit Spike OpenSBI boot testing.

Signed-off-by: Bin Meng <bmeng@tinylab.org>
---

 tests/avocado/riscv_opensbi.py | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tests/avocado/riscv_opensbi.py b/tests/avocado/riscv_opensbi.py
index e02f0d404a..bfff9cc3c3 100644
--- a/tests/avocado/riscv_opensbi.py
+++ b/tests/avocado/riscv_opensbi.py
@@ -6,7 +6,6 @@
 # later.  See the COPYING file in the top-level directory.
 
 from avocado_qemu import QemuSystemTest
-from avocado import skip
 from avocado_qemu import wait_for_console_pattern
 
 class RiscvOpenSBI(QemuSystemTest):
@@ -21,7 +20,6 @@ def boot_opensbi(self):
         wait_for_console_pattern(self, 'Platform Name')
         wait_for_console_pattern(self, 'Boot HART MEDELEG')
 
-    @skip("requires OpenSBI fix to work")
     def test_riscv32_spike(self):
         """
         :avocado: tags=arch:riscv32
-- 
2.34.1


