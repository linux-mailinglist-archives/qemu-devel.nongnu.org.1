Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E758497B69A
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Sep 2024 03:43:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqji2-0006Ns-EJ; Tue, 17 Sep 2024 21:42:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1sqjhz-0006Mt-Lt
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 21:42:19 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1sqjhx-0007kc-3s
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 21:42:19 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Bx9+jxL+pmrWMKAA--.22638S3;
 Wed, 18 Sep 2024 09:42:09 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMBxn+TuL+pmkT8JAA--.52894S2;
 Wed, 18 Sep 2024 09:42:06 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Song Gao <gaosong@loongson.cn>
Cc: Ani Sinha <anisinha@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 "Jason A . Donenfeld" <Jason@zx2c4.com>,
 =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
 qemu-devel@nongnu.org
Subject: [PATCH v3 0/2] Add FDT table support with acpi ged pm register
Date: Wed, 18 Sep 2024 09:42:04 +0800
Message-Id: <20240918014206.2165821-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxn+TuL+pmkT8JAA--.52894S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
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

ACPI ged is used for power management on LoongArch virt platform, in
general it is parsed from acpi table. However if system boot directly from
elf kernel, no UEFI bios is provided and acpi table cannot be used also.

Here acpi ged pm register is exposed with FDT table, it is compatbile
with syscon method in FDT table, only that acpi ged pm register is accessed
with 8-bit mode, rather with 32-bit mode.

---
v2 ... v3:
  1. Keep orginal macro name ACPI_GED_SLP_TYP_S5 unchanged, renaming 
     ACPI_GED_SLP_TYPx_y with  ACPI_GED_SLP_TYP_y
  2. Add acpi chapter reference with notation

v1 ... v2:
  1. Modify name of macro for acpi ged register from ACPI spec, and also add
     comments for macro definition.
---
Bibo Mao (2):
  acpi: ged: Add macro for acpi sleep control register
  hw/loongarch/virt: Add FDT table support with acpi ged pm register

 hw/acpi/generic_event_device.c         |  6 ++--
 hw/loongarch/virt.c                    | 39 ++++++++++++++++++++++++++
 include/hw/acpi/generic_event_device.h |  7 +++--
 3 files changed, 47 insertions(+), 5 deletions(-)


base-commit: 2b81c046252fbfb375ad30632362fc16e6e22bd5
-- 
2.39.3


