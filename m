Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9E28375FB
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 23:17:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rS2a8-0004nt-3h; Mon, 22 Jan 2024 17:15:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rS2Zx-0004mU-Ty
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 17:15:42 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rS2Zw-0005ty-Ee
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 17:15:41 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1d76671e5a4so5286025ad.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 14:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1705961738; x=1706566538; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0kWZUcyOcgTFo8e119jS9KvVJWH/ZmICoOps9eP3tTI=;
 b=i+mk8dhIdz7aYXJuqVD6FYzC0Tdcq8lATL5Th9IOYTuVaxU8/ZyCS3uxFEuECa+7Z2
 ZKG4eMwdHRs6OgZ9KboagzWX5iYPcv/HKXkYWKTPh9pw+h1MM1uJIOUvIzOpxPsetESF
 wh6ngIMLORMHE366BZGPPHy+nJwpjmGnUFADhKw2xzctrFoppuX3iu//j5LZhkeK9GWx
 98WkTlUn0YLsnq92r+aXbDEGguDXAyuGnMCGiSV2Mj4WYZrLzD+rCX2a6XyuPio3rxs7
 3mGwcGkB7N2/3uqMo1GxTARJle0Un2N0z5AjjsKl/xq8RteJiw7BRYb7ItMBBQp9WjVx
 8AMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705961738; x=1706566538;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0kWZUcyOcgTFo8e119jS9KvVJWH/ZmICoOps9eP3tTI=;
 b=GLvnPd5d37sugtRKE6i2+a0VVaMawz10AW5PuSZnrB0KQQrYKF0NnN+XEeoWvHqcN4
 2JrpR9bTsBHl1PQgMLFiFcrQ+SBtMKbb+0EdygFVFqKPiqoSUlQPZfx8y9XkbgwLqmLA
 DqT+CIDKt+9YuWn1+SiAKaF0i1oz24tWjUb4JC3ricTp1BMfxyo1qJ2osT8MVGN7J8W7
 rkqWCbpYSA7bAzsrUq5vs5GwkE28M9xy+W6olEqmcuQ/BdQQNSazxUJQOCfZQNWUKkpI
 l5X0ucMi6pi08Yi29FcLhMEdwHplb0GHpNMqrBSt92+Td52o59SPzetyJCNJQfgyH+Cg
 +DyA==
X-Gm-Message-State: AOJu0Yyx2/CLngWuvalq4FSi6Orz43b3mUDyhs9cPA9dnZQ78Ri5IvQn
 +OQ24vrIkFd2mGiderLFkd5ed6afwLLz3OYBGMWNlAiChVOCBzpsBtAWFmNFDMw9acrCFaJoLqv
 9
X-Google-Smtp-Source: AGHT+IHYwwPdqLb0Z1C56XNnK3IvlAVjKnaIMHXXYZ9zehfY4ji7+ycXJUrgIqVTp5ZtbNpWOx/9Zw==
X-Received: by 2002:a17:902:ec84:b0:1d7:5adc:3a03 with SMTP id
 x4-20020a170902ec8400b001d75adc3a03mr2054076plg.119.1705961738306; 
 Mon, 22 Jan 2024 14:15:38 -0800 (PST)
Received: from grind.. ([152.234.127.94]) by smtp.gmail.com with ESMTPSA id
 kr8-20020a170903080800b001d7338977e6sm4029104plb.223.2024.01.22.14.15.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 14:15:37 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 1/7] hw/riscv/virt-acpi-build.c: fix leak in build_rhct()
Date: Mon, 22 Jan 2024 19:15:23 -0300
Message-ID: <20240122221529.86562-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122221529.86562-1-dbarboza@ventanamicro.com>
References: <20240122221529.86562-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The 'isa' char pointer isn't being freed after use.

Issue detected by Valgrind:

==38752== 128 bytes in 1 blocks are definitely lost in loss record 3,190 of 3,884
==38752==    at 0x484280F: malloc (vg_replace_malloc.c:442)
==38752==    by 0x5189619: g_malloc (gmem.c:130)
==38752==    by 0x51A5BF2: g_strconcat (gstrfuncs.c:628)
==38752==    by 0x6C1E3E: riscv_isa_string_ext (cpu.c:2321)
==38752==    by 0x6C1E3E: riscv_isa_string (cpu.c:2343)
==38752==    by 0x6BD2EA: build_rhct (virt-acpi-build.c:232)
==38752==    by 0x6BD2EA: virt_acpi_build (virt-acpi-build.c:556)
==38752==    by 0x6BDC86: virt_acpi_setup (virt-acpi-build.c:662)
==38752==    by 0x9C8DC6: notifier_list_notify (notify.c:39)
==38752==    by 0x4A595A: qdev_machine_creation_done (machine.c:1589)
==38752==    by 0x61E052: qemu_machine_creation_done (vl.c:2680)
==38752==    by 0x61E052: qmp_x_exit_preconfig.part.0 (vl.c:2709)
==38752==    by 0x6220C6: qmp_x_exit_preconfig (vl.c:2702)
==38752==    by 0x6220C6: qemu_init (vl.c:3758)
==38752==    by 0x425858: main (main.c:47)

Fixes: ebfd392893 ("hw/riscv/virt: virt-acpi-build.c: Add RHCT Table")
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/riscv/virt-acpi-build.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index 26c7e4482d..fb8baf64f6 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -196,7 +196,7 @@ static void build_rhct(GArray *table_data,
     RISCVCPU *cpu = &s->soc[0].harts[0];
     uint32_t mmu_offset = 0;
     uint8_t satp_mode_max;
-    char *isa;
+    g_autofree char *isa = NULL;
 
     AcpiTable table = { .sig = "RHCT", .rev = 1, .oem_id = s->oem_id,
                         .oem_table_id = s->oem_table_id };
-- 
2.43.0


