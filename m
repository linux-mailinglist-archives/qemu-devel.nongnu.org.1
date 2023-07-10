Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4883374D5D7
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 14:39:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIq6H-0005EE-A7; Mon, 10 Jul 2023 08:34:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq60-0004TW-9f
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:34:28 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq5y-0004uS-HF
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:34:28 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-668711086f4so2802596b3a.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 05:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688992465; x=1691584465;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zR6f44GtuTgYpBLT99VRQR0q9TbbFdrsY8mvhV9/6T0=;
 b=CHuzErkpMQ8EnKnBRo9k6D7Z4xfQSrN5qZZm3+0gpMMknt/8IAFHao1mY2YDoZs2g6
 aZTez03T8WRkhs+JmdxTxlkngzCYG2gMvZJ/yqsp1S4xYaOXTM+/QzsZImqw6fawDzen
 117auetxgc0wun8jsRarmCEEamwmULosdQKxslXD8XxOZvfAXxgOy3tzvg/3PUQVPKuU
 2QX1ohnaQ/ad2E6OJGmLcqEtZKpmd+ysA1Anx8TlijinOddQGbAz3c5p+HFMEe2FPyLu
 v4+WtmurvFs5ASvzmOP8/i0uiGvD2LUq9Lq7SBtlCNtd3ZVTQWTjk8jN4nClfo2FK8xH
 foCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688992465; x=1691584465;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zR6f44GtuTgYpBLT99VRQR0q9TbbFdrsY8mvhV9/6T0=;
 b=VjWjTJ7+Ru77Ue5k7wet+DmRkN7CPYJFX0Sqq1Cu2TvVKHrcUmLJf8PFQbDmYQ97jS
 pp1+OvdQkS0HgUZYxx4gTlKQdadZQbpNgtRMOigTR3aDdIj+gTv8GrhR+2KhFp5LaKXS
 cWLcCwu3cMDltesnsMReUKo7VXvEnW6UMm9d0nI2f2rqCW9vuEhZ2BJdA+zBnYFAiG1d
 6lftZ11ZdMUQi8qH8/Q1h7a89rZoCeSyXGCacm05SlueNBWnKvRnS1HzJVq/0nsUbhbP
 6r15XfTCPb+DJXVodG+on73L/n/bGTK1393hQELm71hLMrFyQ7zR+C3eG10E3Gd5AI8s
 Yctg==
X-Gm-Message-State: ABy/qLaV+4MzGnVSCsnIlXVbLNCDX74NPsNYUn0abCg9k/MsZ/jmBfwe
 uCEA1RVepNsC0k2SF+40le4P3siPdi2bNA==
X-Google-Smtp-Source: APBJJlGfcGlIcwp3Xz/d2PbPerB9XBEjKMe8HwLXHD9ce2gwlunKutkNkhkLx3+QDQ0wcFVO8nz67g==
X-Received: by 2002:a05:6a20:6a0e:b0:12d:91a0:2408 with SMTP id
 p14-20020a056a206a0e00b0012d91a02408mr18103608pzk.19.1688992464949; 
 Mon, 10 Jul 2023 05:34:24 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 i126-20020a639d84000000b0055b44a901absm181559pgd.70.2023.07.10.05.34.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 05:34:24 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 36/54] hw/riscv/virt.c: skip 'mmu-type' FDT if satp mode not set
Date: Mon, 10 Jul 2023 22:31:47 +1000
Message-Id: <20230710123205.2441106-37-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230710123205.2441106-1-alistair.francis@wdc.com>
References: <20230710123205.2441106-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42d.google.com
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

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
Message-Id: <20230706101738.460804-3-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 2b380eff73..d90286dc46 100644
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
2.40.1


