Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F3900716DF7
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 21:48:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q45Iq-0006Uj-5k; Tue, 30 May 2023 15:46:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1q45In-0006Ty-Vt
 for qemu-devel@nongnu.org; Tue, 30 May 2023 15:46:41 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1q45Im-0004Fj-E9
 for qemu-devel@nongnu.org; Tue, 30 May 2023 15:46:41 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-19f7f41d9dcso1643953fac.2
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 12:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1685475999; x=1688067999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TtJS64pZP8Myq3aHHVtCKuG+G8XVLuM7yaFoUAKFiIg=;
 b=F6iey4xNUKNa0z8T1UGiqJkETmPugmnjuo8iKQjCarmc8dM983WsKqHGwQWoqzvRoj
 OutY7qiBk8EmhsoiQLWWxnxQIQd0NXb2MACooBTPfIiAx4/yy8DIhGka5rPZWiKDyeiL
 pM+hejkujXhtsulekyrgCntfx5xyXdLeKNKHGsZaP1ErngCEACJMMB+IX1uRB6bREDxp
 Stem3vT6reh6CFZ5Bb+dtFhUKzMeN0lkuKwu4fjnfKgyK6cznfd8yhoICH0fs2ISGnXT
 LZdRwTe/esGz5zXKGy1cNGGrxWJKsLdqCm3DXohiwt9KZs4uT2bwarKN1JJ9vVv4zhWJ
 QUfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685475999; x=1688067999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TtJS64pZP8Myq3aHHVtCKuG+G8XVLuM7yaFoUAKFiIg=;
 b=OFAWjrRxkzID5AqfM87H72Yb6pRfq8wTiEAFwL6Er/ncKsxGwHDIFPgVuxVOboXs/I
 O/RH3VZPALwMARwAdV3EOPnX0omv0WHE8sdrBGvTN5fTYEkr9NK15tzRarMIFtV8S593
 AFguyqTZxo2G0w/FYbwPHId1cSfKJkH8ufPyGcsnDUWVe1PNxrm68YZWuy+Aiuxo/4qI
 N/WF6hpugy64slXJ9tOcuCFG4STdAQqzqV07lFIdomHXz4o7p9P7m3ws2OFrAv2LFe2g
 0hlG/g+BqVF/0YG5oOZmcQIkpHVi+hOuk9kwPDWdWi0XE6lVPiBMrxa80u+eum+/ddI2
 uf9Q==
X-Gm-Message-State: AC+VfDxFLweLpfJFUjM1+xeyQ3Reg1KEDq9qGLwY9rYTgPJ9FFCBKGhR
 FcEFZRjerswh6lkyP/2fXL98ST6DDw8suK7x8Ak=
X-Google-Smtp-Source: ACHHUZ7Na67M5A9vtLlovDqnH8GofqEl+Jo8BQqS2kiFd3QlJIEAOOOzGEDvnqOmL7Ne5sNoWY3hHg==
X-Received: by 2002:a05:6870:32c2:b0:19f:5d99:fc75 with SMTP id
 r2-20020a05687032c200b0019f5d99fc75mr1530927oac.2.1685475999144; 
 Tue, 30 May 2023 12:46:39 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com
 (200-162-225-121.static-corp.ajato.com.br. [200.162.225.121])
 by smtp.gmail.com with ESMTPSA id
 j3-20020a056870a48300b0019fa8728b05sm342214oal.39.2023.05.30.12.46.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 12:46:38 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 02/16] hw/riscv/virt.c: skip 'mmu-type' FDT if satp mode not
 set
Date: Tue, 30 May 2023 16:46:09 -0300
Message-Id: <20230530194623.272652-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230530194623.272652-1-dbarboza@ventanamicro.com>
References: <20230530194623.272652-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oa1-x2a.google.com
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

For this KVM 'cpu' we would need to inherit the satp supported modes
from the RISC-V host. At this moment this is not possible because the
KVM driver does not support it. And even when it does we can't just let
this broken for every other older kernel.

Skip the 'mmu-type' FDT node if there's no satp_mode set.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/riscv/virt.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 4e3efbee16..8aa907e81f 100644
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
2.40.1


