Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE7474014E
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 18:34:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEBc6-0003W0-Uu; Tue, 27 Jun 2023 12:32:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qEBc5-0003VV-8v
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:32:21 -0400
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qEBc2-0004mR-Cq
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:32:20 -0400
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-1b06ea7e7beso313714fac.0
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 09:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1687883537; x=1690475537;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DReao0hDMiDF72kgz7UAQRQxD03tnNvVGU/fYBfp15s=;
 b=YC0RV2tVAVT1ovBdvfyd2g4hI/mm96QsrLE3OlAa5/6qR2UNDWC/3FBLw2wsyDUNZt
 9VmgeurOJWJfdEl8FvtQN2fRznjLfJ/6qzPWszGcoaVmBUQNSahFlCb4FBU3F1yDPEBu
 VR0r5UTNJzmRjoYyklZnLWskaZ9ObAjOvNmL1FGNediHaXGJ4D0XXN7xrGbjhXMBEF0N
 RLZQ/PpOEdMI9GxhD744J7JpPTsWo1a6EXln3qDseGGBSAH5+ZRoRJIFHAI3wYjDYg4p
 ROCjn5o6NX8mxhcqkIqlDkFUbK+n3YDqdd5rkkQA8hdH+6s4cYSzOPJtnklQ/OBDImim
 mwIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687883537; x=1690475537;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DReao0hDMiDF72kgz7UAQRQxD03tnNvVGU/fYBfp15s=;
 b=eXsYqwRpLvQwbgCJxCAEKmZB/zK4F94J8qa9tnbn5f2N2zd5pZItJE418T5Leqk1Ro
 178lm+Vio3i8GWP1VtO96JC8HmiK9sHOvgwT88O/05qzHQa5jMiMlb0wbCl/xHmzvndG
 BFMvWS55w6xuzDl7SJ5KNMIAe9sy/icvCx8jpFixw18l2ajheyV4hFvpXn0XJYJ/jYsy
 vkiiilu7DJR6pawDr6t7EP+VXFtHaoJvGhWlxCUzDkN+vySpy14ctMImIr/CcNICB5SL
 DNabAt5z/z8XNbE1TQbisli05sXU/QAZtZ1eoW17eg/NRVrdLKJG/aee3IfhCR1CA4h1
 OPmw==
X-Gm-Message-State: AC+VfDwaYQljGoUakelciUX2VthVWTcnFWc5Lp/sRUoGiDmRJYetWkNU
 taEV0KxpLOCsRha/vYABeUq6lm9VuiUksKcZEKw=
X-Google-Smtp-Source: ACHHUZ4QWll7hRxSDIBlcdMvKwxRwcYqnqnvdShEY7fnuy0ieO4rJhmup6W8Q0iFex1aIzL6K/UvuQ==
X-Received: by 2002:a05:6870:5a96:b0:1b0:19a4:63f5 with SMTP id
 dt22-20020a0568705a9600b001b019a463f5mr10601290oab.52.1687883536891; 
 Tue, 27 Jun 2023 09:32:16 -0700 (PDT)
Received: from grind.. (201-69-66-110.dial-up.telesp.net.br. [201.69.66.110])
 by smtp.gmail.com with ESMTPSA id
 gu17-20020a056870ab1100b001a3093ec23fsm5254134oab.32.2023.06.27.09.32.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 09:32:16 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v5 02/19] hw/riscv/virt.c: skip 'mmu-type' FDT if satp mode
 not set
Date: Tue, 27 Jun 2023 13:31:46 -0300
Message-ID: <20230627163203.49422-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230627163203.49422-1-dbarboza@ventanamicro.com>
References: <20230627163203.49422-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oa1-x31.google.com
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

The absence of a satp mode in riscv_host_cpu_init() is causing the
following error:

$ sudo ./qemu/build/qemu-system-riscv64  -machine virt,accel=kvm \
    -m 2G -smp 1  -nographic -snapshot \
    -kernel ./guest_imgs/Image \
    -initrd ./guest_imgs/rootfs_kvm_riscv64.img \
    -append "earlycon=sbi root=/dev/ram rw" \
    -cpu host
**
ERROR:../target/riscv/cpu.c:320:satp_mode_str: code should not be
reached
Bail out! ERROR:../target/riscv/cpu.c:320:satp_mode_str: code should
not be reached
Aborted

The error is triggered from create_fdt_socket_cpus() in hw/riscv/virt.c.
It's trying to get satp_mode_str for a NULL cpu->cfg.satp_mode.map.

For this KVM cpu we would need to inherit the satp supported modes
from the RISC-V host. At this moment this is not possible because the
KVM driver does not support it. And even when it does we can't just let
this broken for every other older kernel.

Since mmu-type is not a required node, according to [1], skip the
'mmu-type' FDT node if there's no satp_mode set. We'll revisit this
logic when we can get satp information from KVM.

[1] https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/cpu.yaml

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 95708d890e..f025a0fcaf 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -243,13 +243,13 @@ static void create_fdt_socket_cpus(RISCVVirtState *s, int socket,
             s->soc[socket].hartid_base + cpu);
         qemu_fdt_add_subnode(ms->fdt, cpu_name);
 
-        satp_mode_max = satp_mode_max_from_map(
-            s->soc[socket].harts[cpu].cfg.satp_mode.map);
-        sv_name = g_strdup_printf("riscv,%s",
-                                  satp_mode_str(satp_mode_max, is_32_bit));
-        qemu_fdt_setprop_string(ms->fdt, cpu_name, "mmu-type", sv_name);
-        g_free(sv_name);
-
+        if (cpu_ptr->cfg.satp_mode.supported != 0) {
+            satp_mode_max = satp_mode_max_from_map(cpu_ptr->cfg.satp_mode.map);
+            sv_name = g_strdup_printf("riscv,%s",
+                                      satp_mode_str(satp_mode_max, is_32_bit));
+            qemu_fdt_setprop_string(ms->fdt, cpu_name, "mmu-type", sv_name);
+            g_free(sv_name);
+        }
 
         name = riscv_isa_string(cpu_ptr);
         qemu_fdt_setprop_string(ms->fdt, cpu_name, "riscv,isa", name);
-- 
2.41.0


