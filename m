Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F369E8D6AB6
	for <lists+qemu-devel@lfdr.de>; Fri, 31 May 2024 22:31:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD8rP-0002pk-4h; Fri, 31 May 2024 16:28:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sD8rM-0002oy-BQ
 for qemu-devel@nongnu.org; Fri, 31 May 2024 16:28:20 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sD8rG-0000n8-7g
 for qemu-devel@nongnu.org; Fri, 31 May 2024 16:28:19 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-702555eb23bso74856b3a.1
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 13:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1717187292; x=1717792092; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EuGNiLoanyDO7mD97RqI1BTp6/0+i7R30n1y2I4bdsk=;
 b=Rqgg/NjFkQ2c3/GYZSoHQp1obITT3LvPlzqhl2176Bsz5OnaXIPBK/MiD7KIBRS3XY
 BLpjApV9JhlenIy1fWF9p6fczSQl2dpn0gZ+o3Nchkm4mzG3l5c2ulvKRSFeuZFrWpD3
 n0eYhDdT+FvFCg+A3u3NfZOHh2Rz3N3hHJ0C00ww2cIvBUcNNoVUVTtnmQu46ZjSnzi9
 ULDDdpeNMvnQSBcBVh318HHDJtFmaY/7hhuRh+x58a9qC+4qxB32Z8tT8qMK9ZCb92oG
 zIiiaDcHByh+fF0VJ8dKY6lTxQ30PulWNEbZATyNByGoLEGYKgqLROGre+A23FwHF5Pl
 EkJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717187292; x=1717792092;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EuGNiLoanyDO7mD97RqI1BTp6/0+i7R30n1y2I4bdsk=;
 b=lql5nAp6DqUi5idQIoOIeHfwua73Plax7zZd3MijWo8weU5v4BR0PYY53Pb1nMHryD
 1dyUZtAeh/IgfNJpdKgNzYRR9NPtKo7I4CPXc8efRmOTXGLek9bEMNc4WWS7GovbMRwd
 wndDwyCoTqXmqiaFPgeivpIg8CejmtmYrSeEWQo946pMXl1qaE0pRbq7FawOY3XqoOJm
 3AQH5dqqhwNZosvzezdtgPzhJvCzTeQmX5mCxKR7fGi7+Uragsj+p3Lq4Tjgchwsa9WC
 6XkrnU7touEZhKtVTgl/bgwDfbT8Mj0Eia1QxV1hFix6FfRH4Bm6jkj+h3n1N8QVSoyk
 gj8Q==
X-Gm-Message-State: AOJu0Yy4OF4PyPhIFpFOSsgxj2jZQRlTrJO3wMvvMD/sAPZhVMd7tbq7
 y78WX0mx1b2U/hqcS5ZrCtkguOEzdhIGn/m9Yj+bgaFTbNa5jqYFDmmc2Zdw6nV7NhwbYozLS8f
 g
X-Google-Smtp-Source: AGHT+IEmW2poHiw7iUCvfD/PL0YJbRQCHPcLTvCRoZAEWaBidsgbxL9BDLPkn8LQoMKfNAhzPRLZnw==
X-Received: by 2002:a05:6a00:130c:b0:6ed:6b11:4076 with SMTP id
 d2e1a72fcca58-702477e4893mr2232988b3a.12.1717187292266; 
 Fri, 31 May 2024 13:28:12 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com
 (189-69-160-78.dial-up.telesp.net.br. [189.69.160.78])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70242b09133sm1819691b3a.178.2024.05.31.13.28.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 13:28:11 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 apatel@ventanamicro.com, ajones@ventanamicro.com, conor@kernel.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 1/8] hw/riscv/virt.c: add address-cells in
 create_fdt_one_aplic()
Date: Fri, 31 May 2024 17:27:52 -0300
Message-ID: <20240531202759.911601-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240531202759.911601-1-dbarboza@ventanamicro.com>
References: <20240531202759.911601-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

We need #address-cells properties in all interrupt controllers that are
referred by an interrupt-map [1]. For the RISC-V machine, both PLIC and
APLIC controllers must have this property.

PLIC already sets it in create_fdt_socket_plic(). Set the property for
APLIC in create_fdt_one_aplic().

[1] https://lore.kernel.org/linux-arm-kernel/CAL_JsqJE15D-xXxmELsmuD+JQHZzxGzdXvikChn6KFWqk6NzPw@mail.gmail.com/

Suggested-by: Anup Patel <apatel@ventanamicro.com>
Fixes: e6faee65855b ("hw/riscv: virt: Add optional AIA APLIC support to virt machine")
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/riscv/virt.c         | 2 ++
 include/hw/riscv/virt.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 4fdb660525..1a7e1e73c5 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -609,6 +609,8 @@ static void create_fdt_one_aplic(RISCVVirtState *s, int socket,
     aplic_name = g_strdup_printf("/soc/aplic@%lx", aplic_addr);
     qemu_fdt_add_subnode(ms->fdt, aplic_name);
     qemu_fdt_setprop_string(ms->fdt, aplic_name, "compatible", "riscv,aplic");
+    qemu_fdt_setprop_cell(ms->fdt, aplic_name, "#address-cells",
+                          FDT_APLIC_ADDR_CELLS);
     qemu_fdt_setprop_cell(ms->fdt, aplic_name,
                           "#interrupt-cells", FDT_APLIC_INT_CELLS);
     qemu_fdt_setprop(ms->fdt, aplic_name, "interrupt-controller", NULL, 0);
diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index 3db839160f..c0dc41ff9a 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -118,6 +118,7 @@ enum {
 #define FDT_PLIC_ADDR_CELLS   0
 #define FDT_PLIC_INT_CELLS    1
 #define FDT_APLIC_INT_CELLS   2
+#define FDT_APLIC_ADDR_CELLS  0
 #define FDT_IMSIC_INT_CELLS   0
 #define FDT_MAX_INT_CELLS     2
 #define FDT_MAX_INT_MAP_WIDTH (FDT_PCI_ADDR_CELLS + FDT_PCI_INT_CELLS + \
-- 
2.45.1


