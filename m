Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ACE5837600
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 23:17:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rS2aV-0004uC-Oq; Mon, 22 Jan 2024 17:16:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rS2a9-0004p6-7M
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 17:15:53 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rS2a7-0005w6-NV
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 17:15:52 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1d427518d52so26158425ad.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 14:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1705961750; x=1706566550; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tl3iidZgjm5uEUrZPE7oR27Prvw+PS6Pb1oSe3v2DTM=;
 b=fny2502EBEYBNIotWtX55pXsRk2Kj091R2tt8JW8jT5M4EI/tYVX80P8BLPzfw98YY
 YyKJdSE61Q0YW7WK0WfD/ja4TW6Ar8VoufNB5KcUKqT0b0/s7ZjWCbHrdipsSrOyG+CO
 T0IeDHRiv+Zbh3LyvIPoqMxMOUs++4R1HeRuyJgUyKtN8h4OQtbZ/Vhk0F4oQAxbyo0q
 OlCVTZWOJjySHOvjkE59BNMvvwvqpUm5JvnmYi5mPFZtvgsgiFhzAeYmnFrS1hCbaStL
 bSA2smNZ1rSsLtBAPFzE2Kr6A9r/wGt4CORXT51Es3g6mOm1qzG0EjzeCmurHfASvqj9
 t3JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705961750; x=1706566550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tl3iidZgjm5uEUrZPE7oR27Prvw+PS6Pb1oSe3v2DTM=;
 b=JIHwHdS4U0deC8KUN1CIJxHf7lwoHywdHzib03Fwy9+TLJe0J83gaDsSOTBJvyFy3G
 XB6kEZ3bH6ubC4QNSAXGfEOK5ltDVviYRxIIzdBfZxi7SkxIiF+wnTm/0IRk3ZNSMdRm
 Pqnlb+rbq8IfabpsGd03WB8PwOcAgx8o6x9Mva0RSE59WAQ6btHVFG6BwgQaCaH7rqTz
 M42MxZ4OiTEv1Omf4GtGVC+Xj31K7dzQslawpo6RFQSAt4gIqGsWdUQxDzcTXIpUrZFy
 X6KH6trLyqovRyWg3uJqk5imdKBwngmGgomHU5QG1dWHW4mtFqmcPXh9NcuWAIZuwEoW
 L5dg==
X-Gm-Message-State: AOJu0YyEzT7Fajfgpy4TGPupROXTpZzY6/UqEUGXYfq+Y3i0LIJZy649
 218Ui5hWFUvRmGc++WKyeTqq6eep3CMMOKWeBDLUBTyWGnKxgp0OUg3tEYZR6LeSnVZJubUDUI3
 c
X-Google-Smtp-Source: AGHT+IFTubjT+ymld5oYADRNI6PHZvq3wRXwLJIkc9RKEpt/d8MF1EnLxtH8niY6OI2be6JsE8Q3oQ==
X-Received: by 2002:a17:902:fe0c:b0:1d3:8bf1:9add with SMTP id
 g12-20020a170902fe0c00b001d38bf19addmr6561079plj.36.1705961749971; 
 Mon, 22 Jan 2024 14:15:49 -0800 (PST)
Received: from grind.. ([152.234.127.94]) by smtp.gmail.com with ESMTPSA id
 kr8-20020a170903080800b001d7338977e6sm4029104plb.223.2024.01.22.14.15.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 14:15:49 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 5/7] hw/riscv/virt.c: use g_autofree in create_fdt_virtio()
Date: Mon, 22 Jan 2024 19:15:27 -0300
Message-ID: <20240122221529.86562-6-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122221529.86562-1-dbarboza@ventanamicro.com>
References: <20240122221529.86562-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62d.google.com
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

Put 'name' declaration inside the loop, with g_autofree, to avoid
manually doing g_free() in each iteration.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/riscv/virt.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index d0f402e0d5..f8278df83f 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -820,12 +820,12 @@ static void create_fdt_virtio(RISCVVirtState *s, const MemMapEntry *memmap,
                               uint32_t irq_virtio_phandle)
 {
     int i;
-    char *name;
     MachineState *ms = MACHINE(s);
 
     for (i = 0; i < VIRTIO_COUNT; i++) {
-        name = g_strdup_printf("/soc/virtio_mmio@%lx",
+        g_autofree char *name =  g_strdup_printf("/soc/virtio_mmio@%lx",
             (long)(memmap[VIRT_VIRTIO].base + i * memmap[VIRT_VIRTIO].size));
+
         qemu_fdt_add_subnode(ms->fdt, name);
         qemu_fdt_setprop_string(ms->fdt, name, "compatible", "virtio,mmio");
         qemu_fdt_setprop_cells(ms->fdt, name, "reg",
@@ -840,7 +840,6 @@ static void create_fdt_virtio(RISCVVirtState *s, const MemMapEntry *memmap,
             qemu_fdt_setprop_cells(ms->fdt, name, "interrupts",
                                    VIRTIO_IRQ + i, 0x4);
         }
-        g_free(name);
     }
 }
 
-- 
2.43.0


