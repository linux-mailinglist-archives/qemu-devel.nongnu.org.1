Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E989A78D62C
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 15:36:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbLLy-0002A5-Nt; Wed, 30 Aug 2023 09:35:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qbLLw-00029g-OH
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 09:35:24 -0400
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qbLLu-0006Au-EO
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 09:35:24 -0400
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-5731fe1d2bfso2918119eaf.3
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 06:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1693402520; x=1694007320; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J6jO5NbvKLRHgcaZZEBjuoMQq9FCY74iMsuIIi+TDS0=;
 b=F8CIzPdFrc7jAy2N/XcWBvn4qP25kRqEejetoqeGbc/zg0uXfr3gMhHa58zZbc/Bab
 /LkiY/Nwdsk25h/A7OIlrI+eifhaCQOuDQgi95rbj452YOBQmd4/8dOBUXu+XomwIlnF
 BvGbGE9oCPvfDltZaoBUOaNdTrRkcoI7RGnaIfH3zZhKJNXIKX3VMG7ZvauXC/YH99tO
 OU9zmDXyZQBCIs/1mnuMfqcaGEi8G4WfwMkJXUOHVT7LpdsUIM5pAyiIjCqffnDas4gC
 WmD1THZ7JZw33Ty6hT+Pz60ILFWsNcktDbf/8WLbK+PZZe3mErFFcm36qCi2XWmsRZrI
 isYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693402520; x=1694007320;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J6jO5NbvKLRHgcaZZEBjuoMQq9FCY74iMsuIIi+TDS0=;
 b=TACOLhM5ZzLkldaiAlaELOEa8P8olmzdzRal9JLE8W6bwOEL9VtNErAdc2Obu9rlm5
 P36pOyTYGSQ67MtRM0WGP+frsVPEE5qDz/NBCdmEfegaIqCCThlhrhBsYTr+IOTGwBH+
 R+Axf4T3chL3EPdTV6mWM2wghXpSulpgd2xjE6tjl0HFkk/d3sgU2Mj+R9zwRjmXnj7m
 T3T8OCrqbsJQ/BcRjRTBblfAgGRP/A1tgf/Ap7mHnbx+up+pOQnTblsZN8p7q2m1PUdc
 aspHB3fMTlNcJuC4UxT/u6qB6YBaLUTlIlFJ0NOKipi0FfiwphFz+neLK8VHTyFX8pf1
 KTOQ==
X-Gm-Message-State: AOJu0YxUwIIrMW8Ta8wcBIne+s59vz78OgyxJ46ZbvEzgkBfxlcuzuN4
 oduikYIJqVra/L0JFuIq1/YriZi6V1KtOEYRmoY=
X-Google-Smtp-Source: AGHT+IE9jQQdN+cTXGgeNnLKOoFFBStlvjkeBu7HVp2Qo/2SWLRyRU2Qx0fMX1iUsQ8Ps2pK7CmCkQ==
X-Received: by 2002:a4a:6547:0:b0:573:2863:2926 with SMTP id
 z7-20020a4a6547000000b0057328632926mr2133445oog.8.1693402519928; 
 Wed, 30 Aug 2023 06:35:19 -0700 (PDT)
Received: from grind.. ([177.94.15.194]) by smtp.gmail.com with ESMTPSA id
 125-20020a4a0383000000b0057346742d82sm5938997ooi.6.2023.08.30.06.35.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 06:35:19 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 1/2] hw/riscv/virt.c: fix non-KVM --enable-debug build
Date: Wed, 30 Aug 2023 10:35:02 -0300
Message-ID: <20230830133503.711138-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230830133503.711138-1-dbarboza@ventanamicro.com>
References: <20230830133503.711138-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oo1-xc31.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


