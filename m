Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93094798228
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 08:14:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeUeR-0006r8-MB; Fri, 08 Sep 2023 02:07:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qeUeN-0006X7-BT
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:07:27 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qeUeJ-0007Ox-Nq
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:07:26 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1c1e3a4a06fso13421655ad.3
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 23:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694153241; x=1694758041; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NjXuICcOeuQWR8Rareoyy0vJVSEo7Ycr9iahUIb1+bw=;
 b=OKaUSPZVxOVjChffvAp2R7K5mb3y1Fe1ehAHLjZZGkATVVy2KFHmiX0JtpFkfrqFK3
 2dSBdbLrO0Zd+xwz3MV70twvqKYP3kmPFWkWqTGRUW9xE9+vfmzXaACFiw53mueburMT
 C7aEpatmMX3ysszpwwS3VHHpVYKk3UA9+zLlOhokQPbx1YQCLlv4N8xWmw2czarj3F5N
 OMHOprzDJkgtqjS04voV8l4j2mKfjxiOtRS93tPyREyjXJ4cZxOrDlZHGPgIEKkob4AI
 OL8lv35Zs41NjIdqgu2/NtNHzOo3CjQ4SS5HWiPaXV4zEy6C40F4HIR5Ly157SloOPsk
 Vmbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694153241; x=1694758041;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NjXuICcOeuQWR8Rareoyy0vJVSEo7Ycr9iahUIb1+bw=;
 b=VUqA4cvudk/kJL6Dz4ZLir4nLLyBeBoIi2eAzjMNOWJ1udoTWWc/ytOnoBly4PTUp/
 9Yq8WXnM+/uU+HiVM9ZtCPbwFV6EzLVKrXo82Tay7aVhIHs1fGXfrhrAgohXIDJDHZdR
 TV/sMbaIugHRI91WiwJXx87LysMI8FL57lXQClA9vCppjsWrF0jBFKKNuBLCwtEORvR+
 4T1TgxWuhyoF7MjQInrf/MQDYttkSK2nO9QSo907DzZjLjOfPwuRotwCjkIgWNKWRext
 QhsZtVSk2D+YTs+TqcqDmqVz9oKE9LaagHaU6qZqPxv8Cg3LeORviEUgyCydNJrZv2Kq
 b9ZQ==
X-Gm-Message-State: AOJu0YyBD+6VsyqRHnlB9fdkQ9bPH8GNRZsB+hbA3TwH6xTIMJ+Shg7V
 DDk7m0YJvMSvdDyXXj38omwoiOKTL2tuHukR
X-Google-Smtp-Source: AGHT+IEWeqLfbC/iFt8+sn3sKJ609TC3/jJYop1v8tnraZ8coLpOqozUbcp9tW66H183m7c3srtCKQ==
X-Received: by 2002:a17:903:495:b0:1c3:308b:ecb9 with SMTP id
 jj21-20020a170903049500b001c3308becb9mr1563699plb.11.1694153240833; 
 Thu, 07 Sep 2023 23:07:20 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 q1-20020a170902dac100b001c3267ae31bsm715231plx.301.2023.09.07.23.07.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 23:07:19 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Andrew Jones <ajones@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 38/65] hw/riscv/virt.c: fix non-KVM --enable-debug build
Date: Fri,  8 Sep 2023 16:04:04 +1000
Message-ID: <20230908060431.1903919-39-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230908060431.1903919-1-alistair.francis@wdc.com>
References: <20230908060431.1903919-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62e.google.com
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

A build with --enable-debug and without KVM will fail as follows:

/usr/bin/ld: libqemu-riscv64-softmmu.fa.p/hw_riscv_virt.c.o: in function `virt_machine_init':
./qemu/build/../hw/riscv/virt.c:1465: undefined reference to `kvm_riscv_aia_create'

This happens because the code block with "if virt_use_kvm_aia(s)" isn't
being ignored by the debug build, resulting in an undefined reference to
a KVM only function.

Add a 'kvm_enabled()' conditional together with virt_use_kvm_aia() will
make the compiler crop the kvm_riscv_aia_create() call entirely from a
non-KVM build. Note that adding the 'kvm_enabled()' conditional inside
virt_use_kvm_aia() won't fix the build because this function would need
to be inlined multiple times to make the compiler zero out the entire
block.

While we're at it, use kvm_enabled() in all instances where
virt_use_kvm_aia() is checked to allow the compiler to elide these other
kvm-only instances as well.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Fixes: dbdb99948e ("target/riscv: select KVM AIA in riscv virt machine")
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20230830133503.711138-2-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 388e52a294..3b259b9305 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -782,7 +782,7 @@ static void create_fdt_sockets(RISCVVirtState *s, const MemMapEntry *memmap,
     }
 
     /* KVM AIA only has one APLIC instance */
-    if (virt_use_kvm_aia(s)) {
+    if (kvm_enabled() && virt_use_kvm_aia(s)) {
         create_fdt_socket_aplic(s, memmap, 0,
                                 msi_m_phandle, msi_s_phandle, phandle,
                                 &intc_phandles[0], xplic_phandles,
@@ -808,7 +808,7 @@ static void create_fdt_sockets(RISCVVirtState *s, const MemMapEntry *memmap,
 
     g_free(intc_phandles);
 
-    if (virt_use_kvm_aia(s)) {
+    if (kvm_enabled() && virt_use_kvm_aia(s)) {
         *irq_mmio_phandle = xplic_phandles[0];
         *irq_virtio_phandle = xplic_phandles[0];
         *irq_pcie_phandle = xplic_phandles[0];
@@ -1461,7 +1461,7 @@ static void virt_machine_init(MachineState *machine)
         }
     }
 
-    if (virt_use_kvm_aia(s)) {
+    if (kvm_enabled() && virt_use_kvm_aia(s)) {
         kvm_riscv_aia_create(machine, IMSIC_MMIO_GROUP_MIN_SHIFT,
                              VIRT_IRQCHIP_NUM_SOURCES, VIRT_IRQCHIP_NUM_MSIS,
                              memmap[VIRT_APLIC_S].base,
-- 
2.41.0


