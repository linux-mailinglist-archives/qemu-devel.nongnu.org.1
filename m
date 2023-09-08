Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 373F17981D0
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 08:07:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeUe9-0005Fz-0e; Fri, 08 Sep 2023 02:07:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qeUe6-00056v-BI
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:07:10 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qeUe3-0006qs-OE
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:07:10 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1bf57366ccdso20254885ad.1
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 23:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694153226; x=1694758026; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hxlq5Geudrn5K7zUDOYOIODn69Bkkfse0taaW1zZPXI=;
 b=GLfIo22COcLfY82Z4iUF7oDiA0gYqaXy37BQJJuas3atdGfriR5KhRt3PIsIdAILJY
 QpzbgAcq5WV4yStt/f8E/p8KYjVXsfcQbHlecnFwORGfwHC7LbM1YHYsTXeWuFog9ErW
 Aqbg0TOEwlhy8IQN+aILYFFPdAMrZ1ql8Cr1qZNnM9DAPhShsgZMOoaDw64cPHVJVzc9
 8ehQtl9Rp7aE9n99Sp9fa6bQeq6edqizgKIr9+BevCiDe3fvKMHJFpZJipI3D+3EAebq
 5iyIPNTQh+Ck5cMLRP72twR4r0ouX2PuDJMs5oJCDMU0FjRvh2mi88xXqG0VfxTchsb8
 LFsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694153226; x=1694758026;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hxlq5Geudrn5K7zUDOYOIODn69Bkkfse0taaW1zZPXI=;
 b=NHdOnQz7bVCVrkhhKZBXnrnyiD+sVoRf2D02XOY6K8njljC8/h9bnQcgesGnraE3kw
 Fi2htsXB4rocZncbGAeeVwz27lnnZQpqB/1CbdfW5eiPi9V1eyzro+jAvIPfVEXu52GU
 X93c+qViIWzbrtUDdZIILREOjXTthG4CM8Uivis6qxaqS1o119XEj/KJEEXT0t7Q9Q/B
 pfnSrJE3lJL0S70KZ2MCPSPfnsO1dUzJR/cg8l/nZFB1buQCdF3Tc6alQXvaPv1ozzu8
 R5FMyTTbZV7t+9W6b2QH1lF7m65VmOMzWfXNU1AuavKuMCwP69Gaj4DTNuLg+EkeIRSr
 TV3g==
X-Gm-Message-State: AOJu0Yxu8AZrsZG4JL4xlzE1QQVAxmlZCITD2Ur2uSnYMHh7VrJJuXXD
 sPhCUGLxQqvfdpcOWh4Zm5eIrGfOC4CDPVlR
X-Google-Smtp-Source: AGHT+IHIGNGAZmCUL78LfchooGWliY4YMpOsQ6e4Ebzsw585LZcNcJIWQG9EmgMTtobQj9zVE7YXHQ==
X-Received: by 2002:a17:902:da91:b0:1bd:f69e:a407 with SMTP id
 j17-20020a170902da9100b001bdf69ea407mr7039092plx.8.1694153226150; 
 Thu, 07 Sep 2023 23:07:06 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 q1-20020a170902dac100b001c3267ae31bsm715231plx.301.2023.09.07.23.07.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 23:07:05 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Conor Dooley <conor.dooley@microchip.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 34/65] hw/riscv: virt: Fix riscv,pmu DT node path
Date: Fri,  8 Sep 2023 16:04:00 +1000
Message-ID: <20230908060431.1903919-35-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230908060431.1903919-1-alistair.francis@wdc.com>
References: <20230908060431.1903919-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x635.google.com
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
index a0f7b5abf9..388e52a294 100644
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


