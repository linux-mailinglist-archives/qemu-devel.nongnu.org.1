Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A18816943
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 10:07:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rF9ZT-000604-A9; Mon, 18 Dec 2023 04:05:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1rF9ZR-0005zL-5q
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 04:05:53 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1rF9ZP-0005jZ-K9
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 04:05:52 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1d3ae590903so6183055ad.1
 for <qemu-devel@nongnu.org>; Mon, 18 Dec 2023 01:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1702890349; x=1703495149; darn=nongnu.org;
 h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5Prm2RQOFL5Rml8G8Y8xBqh8xRDyejK3NR4FTYNxBcI=;
 b=jYETh40uALor9Wm81Jb3g39p+2t/996/XvcW2nYPGjGaMzbVvjZuer/Fqpbd5w6EIy
 afy+WUdHZ5WjgGX81dRj6aS7DZy4x6Me6aCnSNnZ4vIUX+uZplMla+bBMNykSgu/4m1/
 UQ+nkrC9HCaqOai54eJQ5KHhb0vM3aUjb2NtcVka+WTVBH43rebv2AWXNtIFU8jSVkbx
 pECGb+e+41ctit6qJ3w7vy63TUtXr308EZ3PsPk89KfQm6XzSYzW5W1Uf1HvblGJ/GbT
 qP/7yZf0Qa0CO6BHV1Td8Z5AbmdYLqlt/ZrtjOLlATWs6eHLuOOht+m4GbhX2UjAMz/y
 sxVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702890349; x=1703495149;
 h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5Prm2RQOFL5Rml8G8Y8xBqh8xRDyejK3NR4FTYNxBcI=;
 b=vvkAaRBGrmVC6VH7DNr/wqSKnHMMqm7RRBUP1NX+8Nql8A4RqJ5IjGjPWMjs2IY4a/
 siGLjhXK3HHLiSB41d2YtPp+BHBYzDwrIHnHp04z9lSsfT1Aoei0Qvxp3+r0AkJcQos/
 aeC+0DEbXxt2d7k7je4wEKDVk0mazhiKgYZ702KhGYDQonYdqUZSvHt+7X+vG+tJcXt6
 yv6OFv+fvmfthltKgqlRByotoApIZ8x9PijsRhh7jPcOo36qWkAmuou1B/dnlV5hUlXK
 l6GFTwXxrcb74wx5q3a4iLjjCtUbbejlsOBRC0WROcIPJ5rj4ZoTSNS+QoaVxGutYxsa
 kBtg==
X-Gm-Message-State: AOJu0Yzb2huTRXRFXrx3zpRlcCDtyQH24nKXfE51okE4tIlRUPkxZPvL
 cV1I+51b/lHcL3su6KVlB1FVzpvU+XXJlAx462dD+eUb0Xxz9QMai0TMyOMls66+M/NEe1mJRbN
 kC4P5LGuDzNaxrNQOCT/KRESgy1kkhT+3A/JT78AmJgxq/8Hh6vaO+Xd+PHUmjQcznHlkUA10Qn
 JvfXgU7Cc=
X-Google-Smtp-Source: AGHT+IG/sDa2FB0ab0g+ui6NkiPpL/pIozc9sfm74nywpWzPpD7WG3B4/mboJFMb2O+Fpp7OXcScAg==
X-Received: by 2002:a17:902:680a:b0:1d0:6ffd:6115 with SMTP id
 h10-20020a170902680a00b001d06ffd6115mr15749114plk.55.1702890348793; 
 Mon, 18 Dec 2023 01:05:48 -0800 (PST)
Received: from hsinchu26.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 j4-20020a170902da8400b001cc3c521affsm18527946plx.300.2023.12.18.01.05.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 01:05:48 -0800 (PST)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: greentime.hu@sifive.com, vincent.chen@sifive.com, frank.chang@sifive.com,
 jim.shu@sifive.com, Yong-Xuan Wang <yongxuan.wang@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH 1/1] hw/riscv/virt.c: fix the interrupts-extended property
 format of PLIC
Date: Mon, 18 Dec 2023 09:05:40 +0000
Message-Id: <20231218090543.22353-1-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=yongxuan.wang@sifive.com; helo=mail-pl1-x629.google.com
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

The interrupts-extended property of PLIC only has 2 * hart number
fields when KVM enabled, copy 4 * hart number fields to fdt will
expose some uninitialized value.

In this patch, I also refactor the code about the setting of
interrupts-extended property of PLIC for improved readability.

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Reviewed-by: Jim Shu <jim.shu@sifive.com>
---
 hw/riscv/virt.c | 47 +++++++++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 20 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index d2eac2415619..e42baf82cab6 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -460,24 +460,6 @@ static void create_fdt_socket_plic(RISCVVirtState *s,
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
@@ -490,8 +472,33 @@ static void create_fdt_socket_plic(RISCVVirtState *s,
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
2.17.1


