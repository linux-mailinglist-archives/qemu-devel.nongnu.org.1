Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FE7749933
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 12:18:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHM3h-0004lm-QW; Thu, 06 Jul 2023 06:17:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qHM3f-0004l4-Re
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 06:17:55 -0400
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qHM3e-00061z-57
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 06:17:55 -0400
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-19a427d7b57so413304fac.2
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 03:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1688638672; x=1691230672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RhAiEWLkm7RohdkYppZgYQ1OAzANqzZCHwqQEo06IWU=;
 b=MeWyER0Mysfiw6Hq8ouroHvmafU8/q0X6GzMB+CTuifQfVcNKGDwh7LFHmURlN9RKi
 uXkbJ7f/GkTXUxc2sD24+CxAuqblDaSy99qrDubEbBgrjVByUr6nvv9jDUmqm50+mEz4
 zDO+G7nKdeuacbrCk7h9wIesCzIKxwufBJZiAoOOvelmLhGqI8weUUTK+ZWIESZ7iucE
 DHOgylmTov6RmwKZtk8W73oLl7Bw7mLZ7DHeT2d9u1UQh2rkncDAsEgs8QES3BvNJMYr
 HlEpTCcrZzXYj6Dq0W/9KqLiAzKLDxRePYsYvS9PV54sZpuJcHtl6upyqYgphfkgOoqa
 nSMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688638672; x=1691230672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RhAiEWLkm7RohdkYppZgYQ1OAzANqzZCHwqQEo06IWU=;
 b=czpYZI1O7pD9oXSygPiEVy4Ar7rax3rXIGT5z4iWdvkStL5McvfBuiPNUOUfHEM1MR
 ZOrorvHcuqNsJ1BMH0bpM11r1SUVLY81KxiyrjSvd/kRB0mbCSAoIMRLk5Nn4pjlMIVR
 g0ySk74R2zQDdWaKMZ8NJJoMq9ff2J8ws+gZY747pFw5GdXvp/gmD7ebxx+DntEl3iFf
 IM3TqXXOoBq4YAn1vIL43BatX5AcqXYC54ZteB6o1ivBohIoxeuC/PBqUoO/VhNGysbR
 kH7igrXUrE1hPesm+tyje/Lj9LwQjO0fHidEkybZwjaEBWMqgnMxtlmNlKrlvp2zjSB0
 SCWA==
X-Gm-Message-State: ABy/qLaC1dYtqC5/vKTVDnWrMMUOBUCLzbRPZJBd+ENlYOt+fu4hY7sn
 YULEeCSTZr5Nk9egVSVvhQ/2Nl7bfVghKvRdX2w=
X-Google-Smtp-Source: APBJJlEUVG28CLJ2B3HKt+yWj91KvjqWcpThj1shrzt8yhMuv8b6GjBTaiV2DiitHYfG6P2LFwMQQA==
X-Received: by 2002:a05:6870:5610:b0:19a:695:15a5 with SMTP id
 m16-20020a056870561000b0019a069515a5mr1777751oao.25.1688638672432; 
 Thu, 06 Jul 2023 03:17:52 -0700 (PDT)
Received: from grind.. (201-69-66-110.dial-up.telesp.net.br. [201.69.66.110])
 by smtp.gmail.com with ESMTPSA id
 h25-20020a9d6a59000000b006b8850ad193sm511382otn.56.2023.07.06.03.17.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jul 2023 03:17:52 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v9 02/20] hw/riscv/virt.c: skip 'mmu-type' FDT if satp mode
 not set
Date: Thu,  6 Jul 2023 07:17:20 -0300
Message-ID: <20230706101738.460804-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230706101738.460804-1-dbarboza@ventanamicro.com>
References: <20230706101738.460804-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::33;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oa1-x33.google.com
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

$ ./qemu/build/qemu-system-riscv64  -machine virt,accel=kvm \
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

[1] https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bindings/riscv/cpus.yaml

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/riscv/virt.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 8ff4b5fd71..ee77b005ef 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -244,13 +244,13 @@ static void create_fdt_socket_cpus(RISCVVirtState *s, int socket,
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


