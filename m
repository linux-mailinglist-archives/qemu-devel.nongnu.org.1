Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7EB579A3DB
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 08:49:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfagf-0004pt-Io; Mon, 11 Sep 2023 02:46:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qfagV-0003dJ-Qi
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 02:46:11 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qfagQ-0005FQ-4D
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 02:46:11 -0400
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3a81154c5f5so2814799b6e.1
 for <qemu-devel@nongnu.org>; Sun, 10 Sep 2023 23:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694414764; x=1695019564; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/hFN2dlBubMVtn023qgNLHsDI3Hg9nR/nsnfeLKyUdo=;
 b=o5UH3k+n0hceMx66DmoWSNxY9NW2fFEXyiR/WImwk1ruV0pZCaZ5hL154PNq+aaZg3
 wlW5yU8m7sVN7McU8eiSXdIcTTmQNAEoHl23hGgarUk0blJrbz4sz8hThfFrmUz5iWaE
 z8SG3aC3oe87wzOpCuh1V65GdctnCrz1h1kHR4qp10jQ2LWu9LJHW87K/uALqbuscyGC
 ZNHDyFsOi/xOgcosZPitwY9I0utdEgOQmRxih+xqon7z/ROb565vs0I6D7u/uZtW9DQk
 UFC+m6kjI56ibJBquI7FgS6jzt+U+7hrZy6HxdAfp3qsKQ6EyEOYiaVuuiOyvo0+X5GA
 zCsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694414764; x=1695019564;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/hFN2dlBubMVtn023qgNLHsDI3Hg9nR/nsnfeLKyUdo=;
 b=UkHSnBh5vitvPkOPLcazbSndkix18uPFdUoKn3J966V6na6s2d/qbRceXC4ngiALca
 Ax0Lik8tl0zfdU803fLI6jdcZFVKgAP9ERK9yifKUVUeITlKMk+aF3tnkWw04+XVQlFQ
 KsE+EaUYQHFbfyuXoe6YfEkgFY72CyFY7ci33tPwq+H6rr6pgOAWi5t9B/P5xi/zyl1H
 wz5aE0ZmWMWgW3d5gpYbHiwaJJ52Xc1BPIAxTtMG5QNQVWAvoiwbvTa24MpSSaAODkib
 oxwRhplExwq7C2aesd7KKiZ8t4j2h2N1GYyq2pk4u5T2Q7Ql3Hp2+YQdrRIprMhqJ3Tq
 ydRA==
X-Gm-Message-State: AOJu0YwWRVmuG+9LDUSzWIfg2j6/WPnN37wp5bTSpZA6eiHBwVM5JgQ+
 plrV3MEG8N7oplzj/oEpRDuD2Nsr4kXGOA==
X-Google-Smtp-Source: AGHT+IG0fqLI1us5uOmZNfG6WCoTpp+T1J0tFukk9Ww8vXS4weRh8woFiOH7eFPQH7oq19cigChUBQ==
X-Received: by 2002:a05:6808:171c:b0:3a7:4cf6:f0cb with SMTP id
 bc28-20020a056808171c00b003a74cf6f0cbmr10211108oib.21.1694414764508; 
 Sun, 10 Sep 2023 23:46:04 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 q12-20020a656a8c000000b00553dcfc2179sm4264606pgu.52.2023.09.10.23.46.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Sep 2023 23:46:03 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Andrew Jones <ajones@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 38/45] hw/riscv/virt.c: fix non-KVM --enable-debug build
Date: Mon, 11 Sep 2023 16:43:13 +1000
Message-ID: <20230911064320.939791-39-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911064320.939791-1-alistair.francis@wdc.com>
References: <20230911064320.939791-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=alistair23@gmail.com; helo=mail-oi1-x236.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
index 496c17c644..5edc1d98d2 100644
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


