Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9A979A3C1
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 08:47:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfagS-0003GN-Lp; Mon, 11 Sep 2023 02:46:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qfagE-0002y7-G0
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 02:45:55 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qfagB-0005EE-BY
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 02:45:53 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-6c0822f46a1so2907201a34.0
 for <qemu-devel@nongnu.org>; Sun, 10 Sep 2023 23:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694414750; x=1695019550; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wXlsoQHwf3oyepQRy21sdbcrctFTEGdm2UM7pLp/J8Y=;
 b=VRAM5mDlOihJbWyET0W6P8EqPbHIM2ChocqQEcLXAUg0SBzBhnr3e2m5h12ojByEHk
 GKp53asxV/1z4i0Z99frX2eHII01hpyFyL6JO7oM9TbeE9sl0nbU8ONKoViajiRnWiaL
 tN6MAMndoXDw2fJr6is5pyfn6FufTTgzBbFAS5rnSmS/XB5mzz4VmpjDGEGRgcts4bNW
 5jv1hphTm19KhxZND2ha0yK2UKtnT2mGFSYlkb4aaOqgUJmhqTFRT2pSbX3iKOQ2uqxo
 4M97tAgc3dEjDAtrtuiLUP86gE2wvCvR8qnX5KCWaSgmjHNcbbriSIg1r3HNH+K3ncYA
 ss9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694414750; x=1695019550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wXlsoQHwf3oyepQRy21sdbcrctFTEGdm2UM7pLp/J8Y=;
 b=fAAB1oPiM3d5ti8XK7dkwwn17J2T835hYL/Q+ObbW81NbKYiSmwMkQWjLl+evXRbck
 qR6/Quiez0dfhPXSuq4qP3NBhs2MiaXisEYKDgGieU5sHOUaBcn1b1uV79vRX3eV9fej
 +V+I4kDCHIIyNlDtnErdIQiULZc2A0pg+uciEMxhKmzKIyORdDREAdwv5QU4DkhlpL4m
 HF0yqx8Old5ClaHSlBvIuQvW25oe49HkMArgMQv5L2PAWwVqrNzC+/qte7Is/zO+fE9i
 u/jZjs9D9MiB3556KfOIqBlwvkE5uDlgfh4I8EzhDP3zHUtDnhbJxK8vqXLJMDGQ4mka
 nUQQ==
X-Gm-Message-State: AOJu0YzwgqplatWkdgHEAcEaCN0LkCZa9O6l2RXT4ZMu+VOGmeQ8ePsy
 JAsH0iUp8wlxBCrsv3tm2IYF28RfOIuP9Q==
X-Google-Smtp-Source: AGHT+IHV7EFViD6xaH5FmIqCRoqL1F/d7corJBm9ZviH+PZIY2g5hUh77CLOn4cbeYiV5A6wNzcVeA==
X-Received: by 2002:a05:6358:c17:b0:139:4783:5140 with SMTP id
 f23-20020a0563580c1700b0013947835140mr9879026rwj.16.1694414749764; 
 Sun, 10 Sep 2023 23:45:49 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 q12-20020a656a8c000000b00553dcfc2179sm4264606pgu.52.2023.09.10.23.45.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Sep 2023 23:45:48 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Conor Dooley <conor.dooley@microchip.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL v2 34/45] hw/riscv: virt: Fix riscv,pmu DT node path
Date: Mon, 11 Sep 2023 16:43:09 +1000
Message-ID: <20230911064320.939791-35-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911064320.939791-1-alistair.francis@wdc.com>
References: <20230911064320.939791-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=alistair23@gmail.com; helo=mail-ot1-x332.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Conor Dooley <conor.dooley@microchip.com>

On a dtb dumped from the virt machine, dt-validate complains:
soc: pmu: {'riscv,event-to-mhpmcounters': [[1, 1, 524281], [2, 2, 524284], [65561, 65561, 524280], [65563, 65563, 524280], [65569, 65569, 524280]], 'compatible': ['riscv,pmu']} should not be valid under {'type': 'object'}
        from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
That's pretty cryptic, but running the dtb back through dtc produces
something a lot more reasonable:
Warning (simple_bus_reg): /soc/pmu: missing or empty reg/ranges property

Moving the riscv,pmu node out of the soc bus solves the problem.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20230727-groom-decline-2c57ce42841c@spud>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 0353a6de56..496c17c644 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -719,7 +719,7 @@ static void create_fdt_pmu(RISCVVirtState *s)
     MachineState *ms = MACHINE(s);
     RISCVCPU hart = s->soc[0].harts[0];
 
-    pmu_name = g_strdup_printf("/soc/pmu");
+    pmu_name = g_strdup_printf("/pmu");
     qemu_fdt_add_subnode(ms->fdt, pmu_name);
     qemu_fdt_setprop_string(ms->fdt, pmu_name, "compatible", "riscv,pmu");
     riscv_pmu_generate_fdt_node(ms->fdt, hart.cfg.pmu_num, pmu_name);
-- 
2.41.0


