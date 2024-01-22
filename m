Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C13848375FE
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 23:17:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rS2aW-0004vC-8v; Mon, 22 Jan 2024 17:16:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rS2aE-0004qS-Tt
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 17:15:59 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rS2aC-0005xF-54
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 17:15:58 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1d731314e67so7136745ad.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 14:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1705961753; x=1706566553; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O5iJeKaMhSSEIURROwKDqU58ZqHVR0g4H9L7rGUnf5Q=;
 b=k0uRMoN8RNswmdViYjzorjlyt3qLglxbB7ZxFzephDbRYFp1hPLJXlcVXLlxCzXxgD
 dRVb4hZc3IXYj6hh/rwQPCoX/6AKQFtiwGy43JCiOLtRHM0/e9y/NppT7HXCODJsJxNf
 H5W817r1nXsoCguDrDEhfb4NUUG8NtPAKevyE5cjoVlF3f6c6fyga75pdWXf316AOltv
 Rs2V37EXSSpSBf+9mhW+8ZUvsqpM8df0CNFVfzJGPxJRAYcs5W/yA/0wuB9PoEtm4f9U
 8INhfeK5jJwbObTAFfLy3DqtmJ5hIlK9bstAiCQYAekO8JcOGsI7efNjRz93Z9kGw2Bz
 LjJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705961753; x=1706566553;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O5iJeKaMhSSEIURROwKDqU58ZqHVR0g4H9L7rGUnf5Q=;
 b=MKLKkC+TjZPCnYdnQALaofzxL2WuumvK6EsOBfa2XQIIEK3uMX8hevIetXR9cXCPvV
 fGeW5uBTGH8Ib0qZjHLB3p/Us0FQIRECA+5FiGPo8aMxsecVDv/NmRsQXeqCpGm/je0m
 Qn9fvUWk60+3HzWHeTZRDZsUIU06KUwJc2NjiXXjt/VGDrFsc9uYHBxkmWnbzcGnS1vg
 LkssT+gHy6N7/TJ4Y28UOcDFTkhWIUtG9qB6HcpVbaG2cl6WuhsElQnV6tt6KqynDrfl
 4Q7auuzyc3MafK3XLb9v0T5TJnyGv6gNfgzIhBFD1jSvhMo3qWNMmJchmREXWKwYVbjA
 Hbnw==
X-Gm-Message-State: AOJu0YxbynXvzZchDm8SUJP9d2UzOJGrlOmXvLcxfHK8AT5wRkn92Yv0
 hQQ9gekNqt7s4SrD2VJii/Q1pMlIrR6JVZLJAPYG4N1bNGVuZVSfasJorvaqhrE5BoKsDkKpRhP
 0
X-Google-Smtp-Source: AGHT+IHgf6blRaPvZqSH7SYMlfoiOcbAG7XmobK3zlocwbsM3KDDWm48s0i73fH4i0VKNNhktSCMRA==
X-Received: by 2002:a17:903:3305:b0:1d5:e313:8380 with SMTP id
 jk5-20020a170903330500b001d5e3138380mr2025694plb.2.1705961753222; 
 Mon, 22 Jan 2024 14:15:53 -0800 (PST)
Received: from grind.. ([152.234.127.94]) by smtp.gmail.com with ESMTPSA id
 kr8-20020a170903080800b001d7338977e6sm4029104plb.223.2024.01.22.14.15.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 14:15:52 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 6/7] hw/riscv/virt.c: use g_autofree in virt_machine_init()
Date: Mon, 22 Jan 2024 19:15:28 -0300
Message-ID: <20240122221529.86562-7-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122221529.86562-1-dbarboza@ventanamicro.com>
References: <20240122221529.86562-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x630.google.com
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

Move 'soc_name' to the loop, and give it g_autofree, to avoid the manual
g_free().

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/riscv/virt.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index f8278df83f..710fbbda2c 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1356,7 +1356,6 @@ static void virt_machine_init(MachineState *machine)
     RISCVVirtState *s = RISCV_VIRT_MACHINE(machine);
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
-    char *soc_name;
     DeviceState *mmio_irqchip, *virtio_irqchip, *pcie_irqchip;
     int i, base_hartid, hart_count;
     int socket_count = riscv_socket_count(machine);
@@ -1376,6 +1375,8 @@ static void virt_machine_init(MachineState *machine)
     /* Initialize sockets */
     mmio_irqchip = virtio_irqchip = pcie_irqchip = NULL;
     for (i = 0; i < socket_count; i++) {
+        g_autofree char *soc_name = g_strdup_printf("soc%d", i);
+
         if (!riscv_socket_check_hartids(machine, i)) {
             error_report("discontinuous hartids in socket%d", i);
             exit(1);
@@ -1393,10 +1394,8 @@ static void virt_machine_init(MachineState *machine)
             exit(1);
         }
 
-        soc_name = g_strdup_printf("soc%d", i);
         object_initialize_child(OBJECT(machine), soc_name, &s->soc[i],
                                 TYPE_RISCV_HART_ARRAY);
-        g_free(soc_name);
         object_property_set_str(OBJECT(&s->soc[i]), "cpu-type",
                                 machine->cpu_type, &error_abort);
         object_property_set_int(OBJECT(&s->soc[i]), "hartid-base",
-- 
2.43.0


