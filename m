Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F3087741AE8
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 23:32:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEcke-0001tg-5M; Wed, 28 Jun 2023 17:31:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qEckc-0001tH-8z
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 17:30:58 -0400
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qEcka-0007x9-De
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 17:30:58 -0400
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-1b0156a1c49so15703fac.0
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 14:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1687987855; x=1690579855;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qq5qA7YTGBupPjchdNTXF4wsUj+6lPmEnmsrbTcIfCo=;
 b=aAjDdTEQONRM6KjecBT/p8kpm5n3u2FyJN1rSBvpkYZxkKtSpl06sVuAgXRSTEEQor
 11+JifkkyqbKgT02aodyZL0w8Wugta5VCJTfr14dM+q2fCUF4QJcij6y9pUtnnkjIi7Y
 WTfQw2m6RubXny7RK9wp4UoWlCt/UklfrXTHndFJD9TjJj5afId8TQwEC+fiZEOIeaG5
 B9v7BvgVHUHdWgabUIesoas8FQm7r0Z82wSLCcRXWCEjq/z6YdR5IrtN5huKyDYPtdtq
 7/zoI5WWvKgn0hvRkg6iD/oQ+RV4xYLRU05A960o5mrFacLRZ5/+E5LtfUR3KPBguSoN
 qTpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687987855; x=1690579855;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qq5qA7YTGBupPjchdNTXF4wsUj+6lPmEnmsrbTcIfCo=;
 b=UVUXJ+SDD7WBR3AKFE3YQNDFYN1QXW7RfBJMYMDUcwIL9loMrB1V8ehpKT254KwVfV
 ohc2wYQdmb9cm/eVXTNrbCq7YhmkWbds5QQnxQc6wU0HhlcFuX9LTf5NS+gYmjOipbXW
 RIAavJCPL5JvVJQZe5nKF8kZnch5iFphGo2arMIz/5GTVzBa+12Xpm3J2Ga5pFhYz6a1
 nHy8SCd2hxpHLI0gzIiFMxqRMihh9jNmcFC0BrZLWclUvcG+Kdr+hBZpXVJ78ZIKPMt/
 i5osJPveQ64uWQCWDhLffx+97bfZIovzDuQo62v9bBRJGNKUFvJwVpyO/7TMA293g+tB
 qgzg==
X-Gm-Message-State: AC+VfDyE/hVzr09/dHKFicyWGZVYA214vhzMvPCnbm+Y8mwo4vK3FEbu
 4pjDEQ9zbYZwowJh59hz2TIkb8qJC+KwQIKVYUM=
X-Google-Smtp-Source: ACHHUZ4JAIKnldIho2x/q2MkqfeBO/tvaOzXsyWgUmSHpeP0EC8Li2vGHgg60qedX/aqoBHLPdMpng==
X-Received: by 2002:a05:6870:a442:b0:1b0:579:195f with SMTP id
 n2-20020a056870a44200b001b00579195fmr10860486oal.47.1687987854809; 
 Wed, 28 Jun 2023 14:30:54 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com
 (201-69-66-110.dial-up.telesp.net.br. [201.69.66.110])
 by smtp.gmail.com with ESMTPSA id
 y17-20020a4a4511000000b0056084a91c74sm832892ooa.24.2023.06.28.14.30.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jun 2023 14:30:54 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com, philmd@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v6 02/20] hw/riscv/virt.c: skip 'mmu-type' FDT if satp mode
 not set
Date: Wed, 28 Jun 2023 18:30:15 -0300
Message-ID: <20230628213033.170315-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230628213033.170315-1-dbarboza@ventanamicro.com>
References: <20230628213033.170315-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::32;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oa1-x32.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


