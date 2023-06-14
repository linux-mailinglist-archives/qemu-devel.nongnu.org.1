Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 159CE72F1B0
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 03:23:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9FDb-0000yj-Go; Tue, 13 Jun 2023 21:22:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FDY-0000hf-J4
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:22:36 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FDW-0004nH-RP
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:22:36 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-652426346bbso4824275b3a.3
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 18:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686705753; x=1689297753;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XgMtz3Q2G9A+pnSEdvZ3mrFvxASf1BgbkfbwhuUXAMM=;
 b=qa+DrqjBT8g9Gu/HFIzkT2FAgzwgoLzLP96uFR1j2aU50ko7rlWLY5LQGv7KMY6Rex
 cIPMoHUTzb9/exq9bK2JpTSR2nSiO9SPHebMXsDXp619W+grp9FUvvBClPbNg0Jit4sD
 mfs1pvKKs92K9nhm+4Ve1sRFf2wISJ0PwpeH9vgH8gtwlOQXI7DEQQVMjo87LvHijpcm
 AZ+C3G9TWCZ4io1MuYEXbLXeEYsgCzTX8ZaLq9IUGkH5vS24nZcwlCPSyyf3ghvfqgvf
 tBxiP0GotC/KEZ1HzCQpuVSPZAz3uNOG0Xuf3IZcfS/PJuZKy33N5MN85PaBNHgbQFlV
 ixJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686705753; x=1689297753;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XgMtz3Q2G9A+pnSEdvZ3mrFvxASf1BgbkfbwhuUXAMM=;
 b=WcrLxwI93cXw6HiCDjZpUFupZeYuVEiIGWRks3xSta5ut8jB6lHrB7irefurlgLRIB
 m3ticfHtzvlW+kMeejzwcazmkFIavvTZQkfimaRgWJ3AcI40jKuMa7cp+W0FcwNUsRxg
 v7IQNx+t+Uz4k2rp5DRfXtoUCnntvqcIQthiq4CwkdsUt8tr1w8/Cxflrl4WW+sKVhFI
 kZpDHUVNtKfq2SqjRJbm1uVoCenRkjQhOtPu0yIihJOfTicRePb1xSGs+QW9TXyA9sql
 bH3wCf24bbN73iRfwJ4ilE/a2dfOmWN4WByvzxJ7do7hVHYMjDwoqXJREn+lZFVRsPbi
 wSKQ==
X-Gm-Message-State: AC+VfDwl88bwPH3ZBOAlr8ovAxRWqGDBqhOeqQIlIE9OuuLBYulUFzt2
 3cCF6J59yFlmbPS0deP33IxIRy9YRFEltA==
X-Google-Smtp-Source: ACHHUZ5wznx+a+qFv+BbRuE5t4ttRx1EByBUTpYbmw8yaXdYtRgNmZpSD+pbxQYAAXiYAwsF+eGkNA==
X-Received: by 2002:a05:6a00:1744:b0:65d:4a3:a9d1 with SMTP id
 j4-20020a056a00174400b0065d04a3a9d1mr442969pfc.33.1686705753167; 
 Tue, 13 Jun 2023 18:22:33 -0700 (PDT)
Received: from toolbox.wdc.com
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u1-20020aa78381000000b0064f7c56d8b7sm9112238pfm.219.2023.06.13.18.22.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jun 2023 18:22:32 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 30/60] hw/riscv/opentitan: Correct OpenTitanState parent
 type/size
Date: Wed, 14 Jun 2023 11:19:47 +1000
Message-Id: <20230614012017.3100663-31-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614012017.3100663-1-alistair.francis@wdc.com>
References: <20230614012017.3100663-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

OpenTitanState is the 'machine' (or 'board') state: it isn't
a SysBus device, but inherits from the MachineState type.
Correct the instance size.
Doing so we  avoid leaking an OpenTitanState pointer in
opentitan_machine_init().

Fixes: fe0fe4735e ("riscv: Initial commit of OpenTitan machine")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-Id: <20230520054510.68822-6-philmd@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
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
2.40.1


