Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C891C8295B0
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 10:05:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNURj-0005Xz-Un; Wed, 10 Jan 2024 04:00:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUQm-0004IF-IV
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 03:59:25 -0500
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUQj-00043v-Tu
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 03:59:23 -0500
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3bbbf5a59b7so3534098b6e.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 00:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704877160; x=1705481960; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nbco6y2Ui7OCD7BuZyHiT9zINXryXXOKQ/3cC8VY7N0=;
 b=Bop916q+QVkFmrbbZBn3gwRY85tMJxvOw0x9BBGomefzh+DepdfVk71CXNr+54axkP
 ybcY66nSMk6foBq6x7Z1GWCeyonczhe2pcb01lk2xjTRh8AbEksFzxdhHKXFAo3C5hNO
 3JSxaOzCvagXal8xrfVF3MAL+k7X9XMG8qdwiweE9WiEPMJfhBAeK1WfI8P7ytkIuQgx
 KJwLAKBY4IoERsuod0e5n+ISFVfcKnQ1YtUmxTCEEjDRi99xkArxeadm2t+JdUDJ3GIb
 RRcWrHbtg0ou8D0B05dbIp2sNpsLXZDI90WDvqBTM5GbngPom69IduPv4gfoYs3dI4Aj
 yj0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704877160; x=1705481960;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nbco6y2Ui7OCD7BuZyHiT9zINXryXXOKQ/3cC8VY7N0=;
 b=BqfimF144ZXiNZSJXyBi21rcDqbPX/3V9HKryOqzQBi1z952iI3HsuVitzpAD+5QzJ
 vKpE7vWUxalTFpcbBwz91mkcU9/phnppOKCD9HaFX4AD0DdVafKCAnOlXL2nZrlVaG6/
 KV6/Li1NisM3SN4Hflext2L4qirJwcImBeuVPcBkcFiSBrOjj4K14SXaXj3tUEIcJT2I
 H85AAwUUE52VS5Ex2Rhdgt3jAiGqeDlw+qFN8Bw4m2vyzGB9lxnaCRp1fRMh3DkXc0nI
 J+snMf3goZlZA9v/CAOsO/Tt0enWoQJlb7WD6m+TMmJKWlFZS7MqHyfWUqT1uE8ES8CZ
 e0rw==
X-Gm-Message-State: AOJu0YwsY41Z6xaj2c+cLQ1J3ut8HgA0tO3s++SiOiyXSnj8A2hxQPsv
 DvADom+47c0uJ0isLX+KA0+yfcfYqk8MRq9G
X-Google-Smtp-Source: AGHT+IHAimiSAAjovsGOQJ4qqUw27W2OgpGYumdOFZ2xt20HvmHKFnj0pwE/e60iaqJShYuG59nRvQ==
X-Received: by 2002:a05:6808:14c8:b0:3bd:413a:e334 with SMTP id
 f8-20020a05680814c800b003bd413ae334mr847576oiw.58.1704877160449; 
 Wed, 10 Jan 2024 00:59:20 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 t65-20020a628144000000b006d9879ba6besm3223814pfd.170.2024.01.10.00.59.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 00:59:19 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Yong-Xuan Wang <yongxuan.wang@sifive.com>,
 Jim Shu <jim.shu@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 25/65] hw/riscv/virt.c: fix the interrupts-extended property
 format of PLIC
Date: Wed, 10 Jan 2024 18:56:53 +1000
Message-ID: <20240110085733.1607526-26-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110085733.1607526-1-alistair.francis@wdc.com>
References: <20240110085733.1607526-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=alistair23@gmail.com; helo=mail-oi1-x235.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Yong-Xuan Wang <yongxuan.wang@sifive.com>

The interrupts-extended property of PLIC only has 2 * hart number
fields when KVM enabled, copy 4 * hart number fields to fdt will
expose some uninitialized value.

In this patch, I also refactor the code about the setting of
interrupts-extended property of PLIC for improved readability.

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Reviewed-by: Jim Shu <jim.shu@sifive.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20231218090543.22353-1-yongxuan.wang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt.c | 47 +++++++++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 20 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index a7c4c3508e..4194ddcef1 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -437,24 +437,6 @@ static void create_fdt_socket_plic(RISCVVirtState *s,
         "sifive,plic-1.0.0", "riscv,plic0"
     };
 
-    if (kvm_enabled()) {
-        plic_cells = g_new0(uint32_t, s->soc[socket].num_harts * 2);
-    } else {
-        plic_cells = g_new0(uint32_t, s->soc[socket].num_harts * 4);
-    }
-
-    for (cpu = 0; cpu < s->soc[socket].num_harts; cpu++) {
-        if (kvm_enabled()) {
-            plic_cells[cpu * 2 + 0] = cpu_to_be32(intc_phandles[cpu]);
-            plic_cells[cpu * 2 + 1] = cpu_to_be32(IRQ_S_EXT);
-        } else {
-            plic_cells[cpu * 4 + 0] = cpu_to_be32(intc_phandles[cpu]);
-            plic_cells[cpu * 4 + 1] = cpu_to_be32(IRQ_M_EXT);
-            plic_cells[cpu * 4 + 2] = cpu_to_be32(intc_phandles[cpu]);
-            plic_cells[cpu * 4 + 3] = cpu_to_be32(IRQ_S_EXT);
-        }
-    }
-
     plic_phandles[socket] = (*phandle)++;
     plic_addr = memmap[VIRT_PLIC].base + (memmap[VIRT_PLIC].size * socket);
     plic_name = g_strdup_printf("/soc/plic@%lx", plic_addr);
@@ -467,8 +449,33 @@ static void create_fdt_socket_plic(RISCVVirtState *s,
                                   (char **)&plic_compat,
                                   ARRAY_SIZE(plic_compat));
     qemu_fdt_setprop(ms->fdt, plic_name, "interrupt-controller", NULL, 0);
-    qemu_fdt_setprop(ms->fdt, plic_name, "interrupts-extended",
-        plic_cells, s->soc[socket].num_harts * sizeof(uint32_t) * 4);
+
+    if (kvm_enabled()) {
+        plic_cells = g_new0(uint32_t, s->soc[socket].num_harts * 2);
+
+        for (cpu = 0; cpu < s->soc[socket].num_harts; cpu++) {
+            plic_cells[cpu * 2 + 0] = cpu_to_be32(intc_phandles[cpu]);
+            plic_cells[cpu * 2 + 1] = cpu_to_be32(IRQ_S_EXT);
+        }
+
+        qemu_fdt_setprop(ms->fdt, plic_name, "interrupts-extended",
+                         plic_cells,
+                         s->soc[socket].num_harts * sizeof(uint32_t) * 2);
+   } else {
+        plic_cells = g_new0(uint32_t, s->soc[socket].num_harts * 4);
+
+        for (cpu = 0; cpu < s->soc[socket].num_harts; cpu++) {
+            plic_cells[cpu * 4 + 0] = cpu_to_be32(intc_phandles[cpu]);
+            plic_cells[cpu * 4 + 1] = cpu_to_be32(IRQ_M_EXT);
+            plic_cells[cpu * 4 + 2] = cpu_to_be32(intc_phandles[cpu]);
+            plic_cells[cpu * 4 + 3] = cpu_to_be32(IRQ_S_EXT);
+        }
+
+        qemu_fdt_setprop(ms->fdt, plic_name, "interrupts-extended",
+                         plic_cells,
+                         s->soc[socket].num_harts * sizeof(uint32_t) * 4);
+    }
+
     qemu_fdt_setprop_cells(ms->fdt, plic_name, "reg",
         0x0, plic_addr, 0x0, memmap[VIRT_PLIC].size);
     qemu_fdt_setprop_cell(ms->fdt, plic_name, "riscv,ndev",
-- 
2.43.0


