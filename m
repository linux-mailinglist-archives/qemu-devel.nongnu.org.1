Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CDFB270A5BF
	for <lists+qemu-devel@lfdr.de>; Sat, 20 May 2023 07:46:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0FPY-0007P2-6D; Sat, 20 May 2023 01:45:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q0FPU-0007O0-2t
 for qemu-devel@nongnu.org; Sat, 20 May 2023 01:45:44 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q0FPS-0007dr-AZ
 for qemu-devel@nongnu.org; Sat, 20 May 2023 01:45:43 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3f42c865535so40477675e9.1
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 22:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684561540; x=1687153540;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kXcukaWbFF62HN09sQV7LoFKa7B0fHLkBZtjDa1RbSE=;
 b=m9jcuZXBdHByEjfauE4oKJQyaTyU49whZMe6zRjeCmP6kYfk25son0cLoeaUkRgAIY
 85BVBBBbzyyXc0iZwJMp3ktSIxr6L7VhnaIUStq+24FOxKR8sq6ncfhXGqV32imvGDAN
 pFSZk0AeoAdepbG9VRNSxlx6S9ai/ELGpe7AvFLXchxpPKWndCnjnNo/5Sb7Pt8h46iI
 pZoU+VRR+0cTC+nyqNUBWUHw5lOZMM5vnuiblhABeQIf7LB+N2Ac1+S6ZGvHhRugS7oK
 aQhFWvDPfLV0IjB6jkRDoQk+5CfttA8uaCFY2enPHARU0t1R/YTDSNIml3IJlCj2LQzs
 jNdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684561540; x=1687153540;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kXcukaWbFF62HN09sQV7LoFKa7B0fHLkBZtjDa1RbSE=;
 b=lszRFrBoYnhT41fk4s5YUL+zMWAmcAmI16nIj67yuT9uR0b7T06FWQ1yLurv3gmjSL
 XOwfAE31zZfl8NXKCtR9vLfT2AHUG70NGDr0OcNmlQQVIWydeL0/DY4f7wqzqjYXHvcb
 5Z23q2camuu9WldILygCelo1cxeT0yJIGBlRyixqDR1IraFuzIdJewpq1Fs+WBwSVIPK
 MRhbiE01wN4Chgolfk7fe3taHUuiUA574N6TPWWRRiHBCiVu8coXh5vAYdX8S3y9UWnX
 DbtIvWnpip+UrX5Me+mGTfVvItSCvp6aMQrWJZJuoe9oyd161cXFPvjhTDQf/CX5fov3
 KNKQ==
X-Gm-Message-State: AC+VfDzkqleINqun28n2DluegXBE2zM14Rpzj7E51ii/GTw1uogfrGNX
 PM6zDCYx96zwsq3LwcVawcSNJTBH+tq/IdDuLh4=
X-Google-Smtp-Source: ACHHUZ6bgex7spNwvcTdQoTXcKLQYC5SZZosop6yrNb7653pVrNKU1MeyJaENsWTX6+Gj8OSb9ALjw==
X-Received: by 2002:a7b:cc88:0:b0:3f1:8223:6683 with SMTP id
 p8-20020a7bcc88000000b003f182236683mr2396819wma.40.1684561540264; 
 Fri, 19 May 2023 22:45:40 -0700 (PDT)
Received: from localhost.localdomain
 (mau49-h01-176-184-41-228.dsl.sta.abo.bbox.fr. [176.184.41.228])
 by smtp.gmail.com with ESMTPSA id
 s2-20020a7bc382000000b003f4fbd9cdb3sm1128093wmj.34.2023.05.19.22.45.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 May 2023 22:45:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Bin Meng <bin.meng@windriver.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 5/5] hw/riscv/opentitan: Correct OpenTitanState parent
 type/size
Date: Sat, 20 May 2023 07:45:10 +0200
Message-Id: <20230520054510.68822-6-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230520054510.68822-1-philmd@linaro.org>
References: <20230520054510.68822-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

OpenTitanState is the 'machine' (or 'board') state: it isn't
a SysBus device, but inherits from the MachineState type.
Correct the instance size.
Doing so we  avoid leaking an OpenTitanState pointer in
opentitan_machine_init().

Fixes: fe0fe4735e ("riscv: Initial commit of OpenTitan machine")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/riscv/opentitan.h | 3 ++-
 hw/riscv/opentitan.c         | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/hw/riscv/opentitan.h b/include/hw/riscv/opentitan.h
index 806ff73528..609473d07b 100644
--- a/include/hw/riscv/opentitan.h
+++ b/include/hw/riscv/opentitan.h
@@ -55,10 +55,11 @@ struct LowRISCIbexSoCState {
 };
 
 #define TYPE_OPENTITAN_MACHINE MACHINE_TYPE_NAME("opentitan")
+OBJECT_DECLARE_SIMPLE_TYPE(OpenTitanState, OPENTITAN_MACHINE)
 
 typedef struct OpenTitanState {
     /*< private >*/
-    SysBusDevice parent_obj;
+    MachineState parent_obj;
 
     /*< public >*/
     LowRISCIbexSoCState soc;
diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
index 9535308197..6a2fcc4ade 100644
--- a/hw/riscv/opentitan.c
+++ b/hw/riscv/opentitan.c
@@ -78,8 +78,8 @@ static const MemMapEntry ibex_memmap[] = {
 static void opentitan_machine_init(MachineState *machine)
 {
     MachineClass *mc = MACHINE_GET_CLASS(machine);
+    OpenTitanState *s = OPENTITAN_MACHINE(machine);
     const MemMapEntry *memmap = ibex_memmap;
-    OpenTitanState *s = g_new0(OpenTitanState, 1);
     MemoryRegion *sys_mem = get_system_memory();
 
     if (machine->ram_size != mc->default_ram_size) {
@@ -330,6 +330,7 @@ static const TypeInfo open_titan_types[] = {
     }, {
         .name           = TYPE_OPENTITAN_MACHINE,
         .parent         = TYPE_MACHINE,
+        .instance_size  = sizeof(OpenTitanState),
         .class_init     = opentitan_machine_class_init,
     }
 };
-- 
2.38.1


