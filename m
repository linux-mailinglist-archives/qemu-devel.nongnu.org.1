Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 64AA873EE4A
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 00:05:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDuIt-0003cw-N3; Mon, 26 Jun 2023 18:03:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qDuHw-0001YQ-W3
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 18:02:25 -0400
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qDuHu-0005sr-D2
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 18:02:24 -0400
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-1b0156a1c49so2185267fac.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 15:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1687816940; x=1690408940;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DReao0hDMiDF72kgz7UAQRQxD03tnNvVGU/fYBfp15s=;
 b=XG1mVVmxyS+u3Fz7ftoFv/o6rssv0JGYyPCPqa4BJ9vakHMudhKJQfQNfi+zawNm0U
 gygfQNC86R+OJHJ95NYOyRtZM2khfB0vaxJGE3Y80PoAPkXL7bFA4YH0uymEHSy09J52
 5v9mcto9Z1ta+DADjX/q2YpUWQeY7tRNb+qKiKEgGtLdpNV54ONAlMDpTzZLZw1qcuQH
 CP0Ij/bQeiP7FV55lRl5efIixUv5LJ6k4C681Oi3ey/S7sMVZ38iFZgIpj5jIpb0Q9Cv
 cISpdwiYzZVq/VGHDqyyyQCqpAuab0P4Ry2vIdsmYLuQB+HqGFuc/UdMJg3L/mHFILDq
 TgmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687816940; x=1690408940;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DReao0hDMiDF72kgz7UAQRQxD03tnNvVGU/fYBfp15s=;
 b=LQysv6kIZJgSG+rI4zdFHFoyw0Cfc8wlMBYVuXhVcIzqGB479ApIJBS5UMKS6lyYZ2
 uJBH9VFoYKZwc03TbKTaKgbq0+y3YyIIxRjFivPkfuC3J1cgvFsMtfjwx8eV2YdZ52Oj
 ePibvgizu8DJhJwKsnsFUosz+rTkHrV4O8xWHiLSIAqPGNIj2OipI4HTJwQJrG4NjDIL
 8B2IoEwhUgsD9gQJQzbwLICskZnMbkJVw99/xM0udoioICuKrNOgMouqZDbsgnor08d2
 sPa3t8gs/F2noJreQXlfcLEbBkdqrpHNGt8P3NdKSyzvJqz98nIB+aCIQxDB6Sbib296
 rNIA==
X-Gm-Message-State: AC+VfDzE78GP7eQSj5ey1+xXCvfhajC5sz5Tiy/prlfrlPk5kDvKDcxD
 Ipq4Fp9dHzFnz5BwhJ2Bba1dVs7OWghhEZ2H4sM=
X-Google-Smtp-Source: ACHHUZ4JY3ylW1BYs9nkasuTzxTJbZ6ZTdYxVxh4RdTg0m47CtDldZ1N8nhROlV5n2waRJ7KORHdTg==
X-Received: by 2002:a05:6870:5253:b0:1a3:365:a8d5 with SMTP id
 o19-20020a056870525300b001a30365a8d5mr28684552oai.48.1687816940674; 
 Mon, 26 Jun 2023 15:02:20 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com
 (201-69-66-110.dial-up.telesp.net.br. [201.69.66.110])
 by smtp.gmail.com with ESMTPSA id
 m12-20020a056870a10c00b001b03fbfa0c5sm1831419oae.39.2023.06.26.15.02.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 15:02:20 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v4 02/19] hw/riscv/virt.c: skip 'mmu-type' FDT if satp mode
 not set
Date: Mon, 26 Jun 2023 19:01:52 -0300
Message-ID: <20230626220209.22142-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626220209.22142-1-dbarboza@ventanamicro.com>
References: <20230626220209.22142-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oa1-x2f.google.com
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


