Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4A670A5BE
	for <lists+qemu-devel@lfdr.de>; Sat, 20 May 2023 07:46:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0FPP-0007Lj-6A; Sat, 20 May 2023 01:45:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q0FP8-0007DZ-Kl
 for qemu-devel@nongnu.org; Sat, 20 May 2023 01:45:24 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q0FP6-0007c1-Nn
 for qemu-devel@nongnu.org; Sat, 20 May 2023 01:45:22 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3f423521b10so26269125e9.0
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 22:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684561518; x=1687153518;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QoiLKMEOX41tFLy0qcfFWPV2O7S+2JSUpMk1QMM25jk=;
 b=V76Eq+YECNX7VaDfDoQ/AsLC3xPuSpCb7UZocxiXVHsnBJkZ5N5WqVSdD1YGA0TMiU
 J7MPqWxTwZx2HkF0Uoy4+IoYKcmL2LSnSG895WdDUj9bx/QGTXyyfkv7QHVyRpcL5aI3
 Gfzf+CFn4Njd8KjaT8nl4H+pFX644qN8ZnBjogR39sf+IXWMudIf+ur0W/4ayLw6NpCN
 Px2dmXOKp1b3KJUgBdAslLx0ID8GW+Mx0nxvk5Dc4WgKNbC4p8iQtj3x0DH4KkpmwM8n
 2UC1009K7PTAyb0njdpUFh1TFC6qK6YnenNuTkukHL5mR/FJwUcbk6tNg2nnPVNKvqDs
 UE6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684561518; x=1687153518;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QoiLKMEOX41tFLy0qcfFWPV2O7S+2JSUpMk1QMM25jk=;
 b=HL0HWAEpViRWAubiEOghOuNtdSn7ngtqB8OIjs1LHQReQCsAX6PwX6AYDsAg4uMUR/
 SJhkDjgznmqBaLUAMpzUgShsXCKTYhYjYyvpClRh3U8R0zy6XsdrbrowNfEYSw21q6ja
 sXJApZAX7Mb4iI1pJKu3QnZ0LMIhg4W2lh7UfypqhaZxg2e6cBkWjtUOIz6fxuEiyN2E
 fsz+ACOC3snWkc9wo4zulsqitzXmmQwfffNaf1OtVfJ+PbcnBC3Ne42GjE2Bw1ENKNF8
 NMPyAuRGPqKnW+foxchOlGROPJ83RLM3LG4vl77PNlJZxsemI4aq2OMZ/UT2bGPJ6nbp
 JnVA==
X-Gm-Message-State: AC+VfDxvGLryA6fS6OxC8leN8Lx9YK4xda0kA5DQ5o0cyT3EW0vl39p0
 2CZf3Uyo6AyHxUXCBGXEAIkO/DX2lxd2D7klaLo=
X-Google-Smtp-Source: ACHHUZ4csgNyyT/psF7HgptwDPAqaL5PythaxSAos8jHh6FNFfYt6y9UmPWol2OiVVQ6gEzfs4yH4A==
X-Received: by 2002:a05:600c:ac6:b0:3f1:8c5f:dfc5 with SMTP id
 c6-20020a05600c0ac600b003f18c5fdfc5mr2749103wmr.39.1684561518473; 
 Fri, 19 May 2023 22:45:18 -0700 (PDT)
Received: from localhost.localdomain
 (mau49-h01-176-184-41-228.dsl.sta.abo.bbox.fr. [176.184.41.228])
 by smtp.gmail.com with ESMTPSA id
 4-20020a05600c020400b003f19b3d89e9sm4304862wmi.33.2023.05.19.22.45.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 May 2023 22:45:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Bin Meng <bin.meng@windriver.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/5] hw/riscv/opentitan: Rename machine_[class]_init()
 functions
Date: Sat, 20 May 2023 07:45:06 +0200
Message-Id: <20230520054510.68822-2-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230520054510.68822-1-philmd@linaro.org>
References: <20230520054510.68822-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Follow QOM style which declares FOO_init() as instance
initializer and FOO_class_init() as class initializer:
rename the OpenTitan machine class/instance init()
accordingly.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/riscv/opentitan.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
index bc678766e7..2d21ee39c5 100644
--- a/hw/riscv/opentitan.c
+++ b/hw/riscv/opentitan.c
@@ -75,7 +75,7 @@ static const MemMapEntry ibex_memmap[] = {
     [IBEX_DEV_FLASH_VIRTUAL] =  {  0x80000000,  0x80000     },
 };
 
-static void opentitan_board_init(MachineState *machine)
+static void opentitan_machine_init(MachineState *machine)
 {
     MachineClass *mc = MACHINE_GET_CLASS(machine);
     const MemMapEntry *memmap = ibex_memmap;
@@ -108,17 +108,17 @@ static void opentitan_board_init(MachineState *machine)
     }
 }
 
-static void opentitan_machine_init(MachineClass *mc)
+static void opentitan_machine_class_init(MachineClass *mc)
 {
     mc->desc = "RISC-V Board compatible with OpenTitan";
-    mc->init = opentitan_board_init;
+    mc->init = opentitan_machine_init;
     mc->max_cpus = 1;
     mc->default_cpu_type = TYPE_RISCV_CPU_IBEX;
     mc->default_ram_id = "riscv.lowrisc.ibex.ram";
     mc->default_ram_size = ibex_memmap[IBEX_DEV_RAM].size;
 }
 
-DEFINE_MACHINE("opentitan", opentitan_machine_init)
+DEFINE_MACHINE("opentitan", opentitan_machine_class_init)
 
 static void lowrisc_ibex_soc_init(Object *obj)
 {
-- 
2.38.1


