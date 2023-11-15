Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6963C7ED81D
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 00:24:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3PDW-0007dC-EY; Wed, 15 Nov 2023 18:22:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3PDT-0007d1-LW
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 18:22:39 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3PDR-0003U4-4Q
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 18:22:38 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-9f27af23443so33276566b.0
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 15:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700090555; x=1700695355; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XdaILDX0UTZX18ZacnU/N5Y1jh+ZT87BDkgwEDab2Z8=;
 b=ZBGSnvPTjQN5h8fVPyZcQQicvqm24OPrOaxk6gSQ8aXzXknpZ1vHpwONBCgRr5k8qo
 8b/tdOctbpFsiRs+N8tePfK4EuoiYLt/oyDCjm7VVY5hsBpI3tmzsWJEbPCrwF1NKc6Y
 smYZUk4KaVq63TP3V7WswqSAYz9EjfGui+ueTl8YSPNrdwHf8rpB505D0rxkEnQ1ZzYB
 X3gsVTB2EnegCr8TfTtE27FmNz2djtJ/oUq+mrhl3et3eu4/cD6qo8Iq6wpza2jafjCM
 Cfu4+hRbr2/UJSXUSaj7tRp10AQV8Ob1HUrI0Pqo0h3LSJ6F/9SGDAlsVCUU7YMlZGr+
 hJtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700090555; x=1700695355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XdaILDX0UTZX18ZacnU/N5Y1jh+ZT87BDkgwEDab2Z8=;
 b=cT0x0WYmwYQtPJNuuLJypE8iC71esLQhdQL+EW8tA2365flbFi2dEbvO5HOs0uM1BO
 fiaQGEfwU4OBCdufJQCbN9kK4uwcP1DPO6Eo3lYzuh7a/a8abSkPok1zi5u4pifqerSl
 7KtOScEPJ2UVjGFTkza0b9kuwCSR/1YY8DlnUr3WWwZuNMzgh9ruB7bfX8g460B9iici
 SRdl+PuBRJ6rD8ahBbTbIyRWZoXTS1st8YxEzDUZ8O9HdHEb9o3opH6YSYTS4Eh/NT1R
 1cdl6oSejKGPc+n2AgKysT/uqfA+n++bEMSxhJstMXZbCbQqFeSeNScSmPVXsP/eTCjo
 OqbQ==
X-Gm-Message-State: AOJu0Yxn69u2AXqxzWmRsolwdj8j+pXM4hpw+udD8Acw00JPSEVG2pTr
 aqioGv6Z5Y9so+aagrYyyFYQsSa/uEnl6+uTwvY=
X-Google-Smtp-Source: AGHT+IHVjGNPOwda86AXQFkb3vmYWTJzEzUmoQI1HYhGi+2FnU2uwdEcEOTkDQ/Z2WCxW81Xv0vtHw==
X-Received: by 2002:a17:906:6c4:b0:9e4:121c:c292 with SMTP id
 v4-20020a17090606c400b009e4121cc292mr7264894ejb.77.1700090555672; 
 Wed, 15 Nov 2023 15:22:35 -0800 (PST)
Received: from m1x-phil.lan ([176.176.130.62])
 by smtp.gmail.com with ESMTPSA id
 bh2-20020a170906a0c200b009e6b055fa88sm7750745ejb.148.2023.11.15.15.22.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Nov 2023 15:22:35 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 Tyrone Ting <kfting@nuvoton.com>, Subbaraya Sundeep <sbhatta@marvell.com>,
 Hao Wu <wuhaotsh@google.com>, Felipe Balbi <balbi@kernel.org>,
 Gavin Shan <gshan@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0 6/6] hw/arm/musca: Simplify setting
 MachineClass::valid_cpu_types[]
Date: Thu, 16 Nov 2023 00:21:53 +0100
Message-ID: <20231115232154.4515-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231115232154.4515-1-philmd@linaro.org>
References: <20231115232154.4515-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
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

Musca boards use the embedded subsystems (SSE) tied to a specific
Cortex core. Our models only use the Cortex-M33.

Use the common code introduced in commit c9cf636d48 ("machine: Add
a valid_cpu_types property") to check for valid CPU type at the
board level.

Remove the now unused MachineClass::default_cpu_type field.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/musca.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/hw/arm/musca.c b/hw/arm/musca.c
index 6eeee57c9d..d3658354ba 100644
--- a/hw/arm/musca.c
+++ b/hw/arm/musca.c
@@ -355,7 +355,6 @@ static void musca_init(MachineState *machine)
 {
     MuscaMachineState *mms = MUSCA_MACHINE(machine);
     MuscaMachineClass *mmc = MUSCA_MACHINE_GET_CLASS(mms);
-    MachineClass *mc = MACHINE_GET_CLASS(machine);
     MemoryRegion *system_memory = get_system_memory();
     DeviceState *ssedev;
     DeviceState *dev_splitter;
@@ -366,12 +365,6 @@ static void musca_init(MachineState *machine)
     assert(mmc->num_irqs <= MUSCA_NUMIRQ_MAX);
     assert(mmc->num_mpcs <= MUSCA_MPC_MAX);
 
-    if (strcmp(machine->cpu_type, mc->default_cpu_type) != 0) {
-        error_report("This board can only be used with CPU %s",
-                     mc->default_cpu_type);
-        exit(1);
-    }
-
     mms->sysclk = clock_new(OBJECT(machine), "SYSCLK");
     clock_set_hz(mms->sysclk, SYSCLK_FRQ);
     mms->s32kclk = clock_new(OBJECT(machine), "S32KCLK");
@@ -603,12 +596,16 @@ static void musca_init(MachineState *machine)
 
 static void musca_class_init(ObjectClass *oc, void *data)
 {
+    static const char *machine_valid_cpu_types[] = {
+        ARM_CPU_TYPE_NAME("cortex-m33"),
+        NULL
+    };
     MachineClass *mc = MACHINE_CLASS(oc);
 
     mc->default_cpus = 2;
     mc->min_cpus = mc->default_cpus;
     mc->max_cpus = mc->default_cpus;
-    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-m33");
+    mc->valid_cpu_types = machine_valid_cpu_types;
     mc->init = musca_init;
 }
 
-- 
2.41.0


