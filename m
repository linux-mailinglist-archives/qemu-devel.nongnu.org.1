Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE08749015
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 23:44:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHAEU-0004m7-1x; Wed, 05 Jul 2023 17:40:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qHAER-0004lA-Ah
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 17:40:15 -0400
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qHAEO-0001b9-5d
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 17:40:15 -0400
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-5634808e16eso5046966eaf.2
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 14:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1688593210; x=1691185210;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E6THGGM2zfgm2qpjIfbEunlOUZT4plwrbrKJ83+1QH8=;
 b=Fp7xsqzqo5pz2hwbdRiQ4IoK4p5LG720chc8kMSSP6x9X1Z1SwnHqKoBLqexo0WV4K
 IcIXE1oboJwD05o6pqqoNfdJ0L1l0NAe8B5z0HLaRCBN2reJ458pNKxJS1ksGS6mBY3T
 oB4ozL2Wtjro18vmsrDzasHqz1KbRi7ts/G7vCLEjARJekLAe/9zbY+a3k/G+ssgCMah
 N0q09OgB5BgO6jv9e40yw6YtrILO9Y88UkRJbWfa0wnOpoovX1kSDJTSvCCfR+bvuNn6
 YzS4qqVFuoGa572pudGt1bvBJxMp+vANkYfxyPz3XAoDFXHSMRqf7Vj0yWebzXK2g7IT
 z/Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688593210; x=1691185210;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E6THGGM2zfgm2qpjIfbEunlOUZT4plwrbrKJ83+1QH8=;
 b=Bz38j0JRsqnqpaS48yDXzHPlf3iS301W/qGJN8hrMKomC24IioZbR1BxyBX7iqZ1OP
 fcoNdiOy26MlWs84AfgNR5eSH/5DpfRxHuzdIg8Fa5ae5RDo0/phny4I+cttRpEm4yil
 i+n/s6GEBPkO8LLy/GoZT/csaj2rAHYpoaJsYdAJH9dFbxLETQuFKjhKOrAF8IMMgKQW
 WQY6Z7qIxYcjmlP4+w552SvN7fMH80vMqIPqGwj4oXyjP2JU00ZJ0QOEDCF7lwbQSr1E
 MngRo4KySArSqKNFIpvqAeIay2QGOVq06Di1QE4w2OxxARrjvGRBSXzSU0caMmU9LMzX
 U01Q==
X-Gm-Message-State: ABy/qLbNYagSEuJ1Ad8sWxCFjuppF+TBUIXwquvqbNkyVm1qJSADnEdJ
 goCckPpu1d0rtEXcbygxgku8ODoMQE26Jq2Ke4Y=
X-Google-Smtp-Source: APBJJlGuWfjZjgSXvlCujtNnKpOzZ605VaZmmax9MRH+3idqRM3fNzzRf3SDwK//BNFYfUcf3iQejA==
X-Received: by 2002:a4a:374c:0:b0:562:eb64:73f6 with SMTP id
 r73-20020a4a374c000000b00562eb6473f6mr26595oor.4.1688593210326; 
 Wed, 05 Jul 2023 14:40:10 -0700 (PDT)
Received: from grind.. (201-69-66-110.dial-up.telesp.net.br. [201.69.66.110])
 by smtp.gmail.com with ESMTPSA id
 m1-20020a4add01000000b0056665a16536sm70764oou.30.2023.07.05.14.40.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jul 2023 14:40:10 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v8 02/20] hw/riscv/virt.c: skip 'mmu-type' FDT if satp mode
 not set
Date: Wed,  5 Jul 2023 18:39:37 -0300
Message-ID: <20230705213955.429895-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705213955.429895-1-dbarboza@ventanamicro.com>
References: <20230705213955.429895-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oo1-xc2c.google.com
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

[1] https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/cpu.yaml

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


