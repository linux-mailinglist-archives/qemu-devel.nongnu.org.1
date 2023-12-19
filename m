Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8061A818A34
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 15:39:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFbFA-0001Ub-23; Tue, 19 Dec 2023 09:38:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1rFbF6-0001UI-L9
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 09:38:45 -0500
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1rFbF3-0003GZ-HW
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 09:38:43 -0500
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id DF6F6413DC; 
 Tue, 19 Dec 2023 14:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1702996717;
 bh=p1IdFuEAUEZ1YIId+u6eiQDrO9JcR8wROnGqDi+YRdc=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=E9wS29QStZXefRQRjdc1peDyPNkAwmiTryOwY7Yywbr8LhZ1FWUUbVrrW2iTUEPDM
 Cs1r90UFhekyZ7YXgsVUJPTPtaMvLtCNBvzDPg7JbbnWeV/X+fWXT2gBzc0frXesqX
 k1yE1GpxXLDmmR9bGPen45nw0ejYcBG5FgVuVgGTkXIEGl7HTklvKvyBNm2EB/HNt7
 3r/HLLEo7Q8qF9wnqVZKfwTQIfapY2o2IlV63cHOeHP57GnrxGfe94irBUrEnx2g/E
 fmoM4hpYXDYEyyUCQjV7gjAUQqCL4o7h+nRd8sbGwPJ6N+9SIoojca5B5E5zlA7jXn
 7AGuEYTcNOdBg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Alistair Francis <alistair.francis@wdc.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Sunil V L <sunilvl@ventanamicro.com>, qemu-devel@nongnu.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] docs/system/riscv: document acpi parameter of virt machine
Date: Tue, 19 Dec 2023 15:38:29 +0100
Message-Id: <20231219143829.8961-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.125.188.120;
 envelope-from=heinrich.schuchardt@canonical.com;
 helo=smtp-relay-canonical-0.canonical.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.066,
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

Since QEMU v8.0.0 the RISC-V virt machine has a switch to disable ACPI
table generation. Add it to the documentation.

Fixes: 168b8c29cedb ("hw/riscv/virt: Add a switch to disable ACPI")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 docs/system/riscv/virt.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/docs/system/riscv/virt.rst b/docs/system/riscv/virt.rst
index f5fa7b8b29..4e134ff2ac 100644
--- a/docs/system/riscv/virt.rst
+++ b/docs/system/riscv/virt.rst
@@ -95,6 +95,11 @@ The following machine-specific options are supported:
   SiFive CLINT. When not specified, this option is assumed to be "off".
   This option is restricted to the TCG accelerator.
 
+- acpi=[on|off|auto]
+
+  When this option is "on", ACPI tables are generated and exposed as firmware
+  tables etc/acpi/rsdp and etc/acpi/tables.
+
 - aia=[none|aplic|aplic-imsic]
 
   This option allows selecting interrupt controller defined by the AIA
-- 
2.40.1


