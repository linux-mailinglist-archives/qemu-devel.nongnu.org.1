Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D3B72ED84
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 23:02:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9B6t-0001z5-Gh; Tue, 13 Jun 2023 16:59:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1q9B6r-0001yN-9d
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 16:59:25 -0400
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1q9B6o-0006dr-Ol
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 16:59:25 -0400
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-55b2fb308bbso10710eaf.1
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 13:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1686689961; x=1689281961;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OnHsil+rlJITNmRjajhe4WP+4n0ur2gd/ZeLsL06USo=;
 b=bobXsVpW7/Wv9slPkM/HRZExSBTz1VDd2DkVE5IPYA0XZV2O/eMkA/FbLTnGUgvXGF
 vkzgxHeuGbYhrMQQXnn2cbQvmgxHLpIhrjnYeCwlWpCc0zP21ogO/bRlFTLglZjbfH4a
 gQSMJjufFISUI5szaQzK73BG6SAmdCLfyU75l2IWnUzuhQI2C8AcN7XNM+jOQKBbILVy
 la3QMrgAwvnHvRAkxhTRTRgJfPlIqz/7JYB0HFGlUCfPsDu6GGaTqTUaqQAIg7fbM4kx
 shN4d/ov6L8ZijzPWKsRIWSmDYndP4u7WqUlPkxQthAS6HI0fphaVdcxJ83H5y+6F77T
 bzyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686689961; x=1689281961;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OnHsil+rlJITNmRjajhe4WP+4n0ur2gd/ZeLsL06USo=;
 b=Bnj5ZJbHUVJYZFdyNjWHHhsgvpApnOczQL3eKBWMrNSH7MQzpgVM1dLn39StDXw7kG
 7zxy2XfgvofWApjss5p47tXpguu3jHxhExommR7TF/5iNM0bfkE/hQblwxGHRPMSgf0X
 oOBLLjbvt1CKgivwgy0eyaMRCjhs9vX/rMrEU0wbsX40PbVwD5m60AM87he4n7ErcWgZ
 mCk76+QGfyT+JHrNKEhJbHMGZ2tGzOiHUw+8A8ce/K51xmrRgrdoW6Y+/nRQawQ8/Jxl
 vMoaqBIsxvNB4PzuEQhGg1WVyXzu8LfYLAv4Ia2VnwlC5HcWXXUHWbG753o6YuuIPcXv
 McJQ==
X-Gm-Message-State: AC+VfDzPpPmyD//WNHqjZr4O2zyJL3aRFflhKTspsACPL5UayQI5IjnR
 QhnQ890eo5ClrCLsSJoFBNatGsIBU4gNl20NVpU=
X-Google-Smtp-Source: ACHHUZ4TxXeYPrVPQWW4qTka2gL5zqJ53LEdCOSTKvt0SJFDbpqtgbmZajOdaWzxEH0p+yrgTnEnnA==
X-Received: by 2002:a05:6808:1291:b0:39b:dab1:4b32 with SMTP id
 a17-20020a056808129100b0039bdab14b32mr10761818oiw.0.1686689961244; 
 Tue, 13 Jun 2023 13:59:21 -0700 (PDT)
Received: from grind.. ([177.170.117.210]) by smtp.gmail.com with ESMTPSA id
 q82-20020acaf255000000b003982a8a1e3fsm5619514oih.51.2023.06.13.13.59.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jun 2023 13:59:21 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 02/18] hw/riscv/virt.c: skip 'mmu-type' FDT if satp mode
 not set
Date: Tue, 13 Jun 2023 17:58:41 -0300
Message-Id: <20230613205857.495165-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230613205857.495165-1-dbarboza@ventanamicro.com>
References: <20230613205857.495165-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c35;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oo1-xc35.google.com
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
index 76c7a3ba3b..e80127d28a 100644
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


