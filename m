Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 78DDCBC8DE0
	for <lists+qemu-devel@lfdr.de>; Thu, 09 Oct 2025 13:43:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6p1J-0007v4-2V; Thu, 09 Oct 2025 07:41:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liu.xuemei1@zte.com.cn>)
 id 1v6p1D-0007uc-Pj; Thu, 09 Oct 2025 07:41:11 -0400
Received: from mxhk.zte.com.cn ([160.30.148.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liu.xuemei1@zte.com.cn>)
 id 1v6p17-0005AW-8g; Thu, 09 Oct 2025 07:41:11 -0400
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4cj7Gz0nHNz5PM3G;
 Thu, 09 Oct 2025 19:40:43 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
 by mse-fl1.zte.com.cn with SMTP id 599BeZXo089017;
 Thu, 9 Oct 2025 19:40:35 +0800 (+08)
 (envelope-from liu.xuemei1@zte.com.cn)
Received: from mapi (xaxapp01[null]) by mapi (Zmail) with MAPI id mid32;
 Thu, 9 Oct 2025 19:40:38 +0800 (CST)
Date: Thu, 9 Oct 2025 19:40:38 +0800 (CST)
X-Zmail-TransId: 2af968e79f3643e-4420b
X-Mailer: Zmail v1.0
Message-ID: <202510091940382809HwqVAalRODBWrvsUvqF8@zte.com.cn>
Mime-Version: 1.0
From: <liu.xuemei1@zte.com.cn>
To: <pbonzini@redhat.com>, <palmer@dabbelt.com>, <alistair.francis@wdc.com>,
 <liwei1518@gmail.com>, <dbarboza@ventanamicro.com>,
 <zhiwei_liu@linux.alibaba.com>, <sunilvl@ventanamicro.com>,
 <bjorn@rivosinc.com>, <anisinha@redhat.com>
Cc: <qemu-riscv@nongnu.org>, <qemu-devel@nongnu.org>
Subject: =?UTF-8?B?W1BBVENIIHY0XSBody9yaXNjdi92aXJ0OiBBZGQgYWNwaSBnZWQgYW5kIHBvd2VyZG93biBzdXBwb3J0?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 599BeZXo089017
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: liu.xuemei1@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Thu, 09 Oct 2025 19:40:43 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68E79F3B.000/4cj7Gz0nHNz5PM3G
Received-SPF: pass client-ip=160.30.148.34;
 envelope-from=liu.xuemei1@zte.com.cn; helo=mxhk.zte.com.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

From: Xuemei Liu <liu.xuemei1@zte.com.cn>

Add acpi ged and powerdown support

Changes in v4:
- Added modifies of DSDT blob in another patch
- Link to v3: https://lore.kernel.org/qemu-riscv/20250723113739751COZ5PkRzx6aXEuKzsHhm_@zte.com.cn/

Changes in v3:
- Added missing param to virt_is_acpi_enabled
- Fixed failure of bios-tables-test
- Link to v2: https://lore.kernel.org/qemu-riscv/202506201130099861lTkD839Hh6oko8Jo2W2H@zte.com.cn/

Changes in v2:
- Unwrappered acpi_dsdt_add_ged function
- Modified base address of VIRT_ACPI_GED
- Added conditions for function calls
- Adjusted code formatting
- Link to v1: https://lore.kernel.org/qemu-riscv/202506191556260735QxWC8sxRwFURYEvlD24y@zte.com.cn/

Xuemei Liu (2):
  hw/riscv/virt: Add acpi ged and powerdown support
  tests/acpi: Add acpi ged and power button in DSDT for RISC-V

 hw/riscv/Kconfig                  |   1 +
 hw/riscv/virt-acpi-build.c        |  10 +++++++++
 hw/riscv/virt.c                   |  35 ++++++++++++++++++++++++++++++
 include/hw/riscv/virt.h           |   4 ++++
 tests/data/acpi/riscv64/virt/DSDT | Bin 3538 -> 3681 bytes
 5 files changed, 50 insertions(+)

-- 
2.27.0

