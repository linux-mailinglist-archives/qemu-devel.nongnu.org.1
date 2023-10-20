Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FEA7D0E34
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 13:13:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtnQ0-0006xn-NG; Fri, 20 Oct 2023 07:11:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtnPx-0006ow-VS
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 07:11:49 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtnPv-0002KO-Rz
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 07:11:49 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2c515527310so9756131fa.2
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 04:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697800306; x=1698405106; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xnbl+CEJMh29ntVjs7lWsGl3ZirIDduEVYwzRCUzZKs=;
 b=zeBHYyQqW83D1/r0IgXXCQe//L/ss/X9ETesziI3kfvGTfMd3Lks2/l860Rtnia/fS
 SuVEPdMBYPYJMcJz2ONyw9BP/nMbbY4eMl7FUaLCe5sPK8xiqVVTJu7709YjBfIhV2sH
 1FweOn5Kc+ruqi1M5PNhZ1EPi29sHrQFeuV22uFezlW8CggMm05MusOhyj3RCgteawoN
 PKUbXmjPlQ7AqmYtikI0q7GmwZY/nGhfpdAJfm7wP3lJEmxoxz1+RcMtPTCzoaSAi7Jg
 ZzeEQnBj8rHl6+0vjgXxXWPTIHBuQpnEfuVIXxOXc245usA63YVJVM5XvScSm99I3EoG
 yEGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697800306; x=1698405106;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xnbl+CEJMh29ntVjs7lWsGl3ZirIDduEVYwzRCUzZKs=;
 b=f/0ViH5p3IqERvgrcBNbpDDqIWun04vb+v9zgegcLVrPY4P2MAtP/D0k3X08XbsgbS
 GJyZGnO5mwTx7sVL3/kkTZAi8gTzmq4LR62iQQEHCTeXux08hWm9qME5CIqQbdnKSRAn
 lB6K0QDHB6t3MbWKE5Wdzot4czqFVR/eAcfU1PVPRvTs7jdB421sJ1hw0kP7ZjdsRFD7
 AaH5d239u8EJRBz90TEFL4n8IfBvVZ1zDRm75Jk89lXvq8+YtvD7DbS1J1HiDyumEg7a
 gAoCZD3avKuoSeOsQSc2GsYzbLs6i0j7NX2sUmFaxKSd0RiSGkXaV6OV8DV1VRJ4AXSp
 XYTA==
X-Gm-Message-State: AOJu0Yz3HAHAUXyNlPwl8QQAjtTQmSmt+cf8lTC2v+al2iJ3owZ6tL3s
 9OlijhxLzIZYHSBkYNAnUvtTcQCijeUtIDBO3aU=
X-Google-Smtp-Source: AGHT+IEO9v3ymU/FZ8MTBuqknq1/kuItOF2skrgG4ti8XjtQgZlr0wFYXz/xOs0kgLSTC+Nn712dmQ==
X-Received: by 2002:a05:651c:2111:b0:2c5:1042:b6e8 with SMTP id
 a17-20020a05651c211100b002c51042b6e8mr1404101ljq.12.1697800305973; 
 Fri, 20 Oct 2023 04:11:45 -0700 (PDT)
Received: from m1x-phil.lan (tbo33-h01-176-171-212-97.dsl.sta.abo.bbox.fr.
 [176.171.212.97]) by smtp.gmail.com with ESMTPSA id
 az15-20020a05600c600f00b00406447b798bsm6780865wmb.37.2023.10.20.04.11.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Oct 2023 04:11:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>, Zhao Liu <zhao1.liu@intel.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/3] target/i386/hvf: Use CPUState typedef
Date: Fri, 20 Oct 2023 13:11:34 +0200
Message-ID: <20231020111136.44401-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231020111136.44401-1-philmd@linaro.org>
References: <20231020111136.44401-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x231.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Follow C style guidelines and use CPUState forward
declaration from "qemu/typedefs.h".

No functional changes.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/hvf/x86_emu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/i386/hvf/x86_emu.c b/target/i386/hvf/x86_emu.c
index b1f8a685d1..cd7ef30126 100644
--- a/target/i386/hvf/x86_emu.c
+++ b/target/i386/hvf/x86_emu.c
@@ -45,7 +45,7 @@
 #include "vmcs.h"
 #include "vmx.h"
 
-void hvf_handle_io(struct CPUState *cpu, uint16_t port, void *data,
+void hvf_handle_io(CPUState *cpu, uint16_t port, void *data,
                    int direction, int size, uint32_t count);
 
 #define EXEC_2OP_FLAGS_CMD(env, decode, cmd, FLAGS_FUNC, save_res) \
@@ -1417,7 +1417,7 @@ static void init_cmd_handler()
     }
 }
 
-void load_regs(struct CPUState *cpu)
+void load_regs(CPUState *cpu)
 {
     X86CPU *x86_cpu = X86_CPU(cpu);
     CPUX86State *env = &x86_cpu->env;
@@ -1440,7 +1440,7 @@ void load_regs(struct CPUState *cpu)
     env->eip = rreg(cpu->accel->fd, HV_X86_RIP);
 }
 
-void store_regs(struct CPUState *cpu)
+void store_regs(CPUState *cpu)
 {
     X86CPU *x86_cpu = X86_CPU(cpu);
     CPUX86State *env = &x86_cpu->env;
-- 
2.41.0


