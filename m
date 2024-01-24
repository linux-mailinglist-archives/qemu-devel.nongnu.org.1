Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7084F83AA4B
	for <lists+qemu-devel@lfdr.de>; Wed, 24 Jan 2024 13:50:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSchl-00013R-NQ; Wed, 24 Jan 2024 07:50:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bjorn@kernel.org>) id 1rSchh-00012k-92
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 07:50:06 -0500
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bjorn@kernel.org>) id 1rSchf-0008PI-1r
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 07:50:04 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 623D6CE2D9D;
 Wed, 24 Jan 2024 12:49:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4086CC43399;
 Wed, 24 Jan 2024 12:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1706100594;
 bh=CaC190ioRAJx6UTsAkbO9nsrMbRdFg40jhaO3cN77kM=;
 h=From:To:Cc:Subject:Date:From;
 b=ibWsyqB+erU4RSF24jjw1C6qoMueVhtfU2aXfmsMl2sPhT5TXjRYS49aui/QeAodC
 AGyUWXWV7bJvS8NET1YMENjcNHdK389PzYErByoMnAVhE2+Qi5U2sTaaAWhEJf6yxw
 YTxydscV12T4X5A8BNCAj6y4/BF8VLXEf03foJEKSMxII3KcAEOi++Fx1EK2TMdcAR
 QejhPuNTsWTfPNUbBgwcO8DMSxRbCzel7pM/mQg+OYQevsG4ng/epmnIRBjN+ooEvp
 OgyhwFV/GLvs6sQFk9mQVl4hZz4cBGlkJF4NiadedDBGio+vf6T1yg2fUSFqQpEsxs
 lCOeiKkDbEoFQ==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: qemu-devel@nongnu.org, "Daniel Henrique Barboza"
 <dbarboza@ventanamicro.com>, =?utf-8?Q?Christoph_M=C3=BCllner?=
 <christoph.muellner@vrull.eu>
Cc: linux-riscv@lists.infradead.org, "LIU Zhiwei"
 <zhiwei_liu@linux.alibaba.com>, "Andrew Jones" <ajones@ventanamicro.com>,
 "Alistair Francis" <alistair.francis@wdc.com>
Subject: qemu riscv, thead c906, Linux boot regression
Date: Wed, 24 Jan 2024 13:49:51 +0100
Message-ID: <874jf2rj4g.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2604:1380:40e1:4800::1;
 envelope-from=bjorn@kernel.org; helo=sin.source.kernel.org
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi!

I bumped the RISC-V Linux kernel CI to use qemu 8.2.0, and realized that
thead c906 didn't boot anymore. Bisection points to commit d6a427e2c0b2
("target/riscv/cpu.c: restrict 'marchid' value")

Reverting that commit, or the hack below solves the boot issue:

--8<--
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 8cbfc7e781ad..e18596c8a55a 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -505,6 +505,9 @@ static void rv64_thead_c906_cpu_init(Object *obj)
     cpu->cfg.ext_xtheadsync =3D true;
=20
     cpu->cfg.mvendorid =3D THEAD_VENDOR_ID;
+    cpu->cfg.marchid =3D ((QEMU_VERSION_MAJOR << 16) |
+                        (QEMU_VERSION_MINOR << 8)  |
+                        (QEMU_VERSION_MICRO));
 #ifndef CONFIG_USER_ONLY
     set_satp_mode_max_supported(cpu, VM_1_10_SV39);
 #endif
--8<--

I'm unsure what the correct qemu way of adding a default value is,
or if c906 should have a proper marchid.

Maybe Christoph or Zhiwei can answer?

qemu command-line:
qemu-system-riscv64 -nodefaults -nographic -machine virt,acpi=3Doff \
   -cpu thead-c906 ...


Thanks,
Bj=C3=B6rn

