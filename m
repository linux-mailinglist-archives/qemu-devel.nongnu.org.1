Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1407E3304
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 03:34:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0BsI-0004D0-Ag; Mon, 06 Nov 2023 21:31:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0BsG-0004Ci-TB
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:31:28 -0500
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0BsF-0002si-FT
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:31:28 -0500
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-5bd33a450fdso3587225a12.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 18:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699324285; x=1699929085; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uv61dBTbQVMzoaHakAGYk5ptMn6PVA8IgMNK1icvAD8=;
 b=BbaTkuZZyPzDc2PEPP2UU+xcx889dPYnbBrjS6APQORbtvjO9iueg8sknRc7a9cwYR
 Zm2lR9Hj/msRMABDF5slHvU/yIoXlhf9Rbt8jpjRpg3DaW/sWX6pQjb9isKaTBSG8+JA
 d7+oGzdtjucWrS1dRG2a5rohvVh3sk5Fj/WkV3za+B6VwQ+e0NwbsaQsntzN/qstwibZ
 IkYkk4DYLDsc9zRHgkwA0cCysMOe1u/hnZQbJWn4wltzDsL5xfbTlgEoyhhKEbbzslly
 vopQcaK517jKna3JpuFfeNyLIs1OqKwwewh3J+0YZi3YTPRmrgGG942v3ySLuT7/UKA4
 lUlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699324285; x=1699929085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uv61dBTbQVMzoaHakAGYk5ptMn6PVA8IgMNK1icvAD8=;
 b=qYSDbrEKU+wdPrnD4glTQ7C05FTedND1GRPlG3B+5n3I+9ICMLPS9Xwj2LN/wr8XKV
 zPEMNJOsfTR54cj4RJdgJcwST97bnFAVgEIHKuKYl9PdnKnYftNnaeLxVCvZfJ6Y/pBi
 xHqLar9AhJPuMNztFh6RegQNxw8ZsuQCFEd1bW9W5k8QX0Zt02ftAzmhUmbG2VLFn6hA
 Ll5ANPw4xnBScDUGwYm+1qeyjsrCl1sqeLVqtrfyaN8oO9rMZgFlTcfLdnDQxes5RYAU
 4IJJTpWHUdoJxq6ACL3Jhxt5OykCE5et0NAzl+RN/6mD6dyMbVOAlKN3U3utRxbnfuDT
 lv5g==
X-Gm-Message-State: AOJu0YyRbEoyrwx8wQ5u352UZbljqXByePY9us63pdxO1FUoQB35FJGO
 6QK/sd+0s/Wl6DijiYXD2oSoIIsEzzgqvg==
X-Google-Smtp-Source: AGHT+IEAc3auX6UMlyLbMVnzX9TJYstzaLkyOHGBndU7Tq3SoViGc+2UFaNqB9AWGjc8SmFL6wbocQ==
X-Received: by 2002:a05:6a21:66c4:b0:180:23d2:b5e5 with SMTP id
 ze4-20020a056a2166c400b0018023d2b5e5mr35563533pzb.60.1699324285214; 
 Mon, 06 Nov 2023 18:31:25 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u18-20020a170902e5d200b001cc32f46757sm6487649plf.107.2023.11.06.18.31.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 18:31:24 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 26/49] target/riscv/kvm: add zicsr, zifencei, zba, zbs, svnapot
Date: Tue,  7 Nov 2023 12:29:22 +1000
Message-ID: <20231107022946.1055027-27-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231107022946.1055027-1-alistair.francis@wdc.com>
References: <20231107022946.1055027-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x529.google.com
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

These regs were added in Linux 6.6.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20231031205150.208405-1-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/kvm/kvm-cpu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index a11c0e4a99..78fa1fa162 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -229,12 +229,17 @@ static KVMCPUConfig kvm_multi_ext_cfgs[] = {
     KVM_EXT_CFG("zicbom", ext_zicbom, KVM_RISCV_ISA_EXT_ZICBOM),
     KVM_EXT_CFG("zicboz", ext_zicboz, KVM_RISCV_ISA_EXT_ZICBOZ),
     KVM_EXT_CFG("zicntr", ext_zicntr, KVM_RISCV_ISA_EXT_ZICNTR),
+    KVM_EXT_CFG("zicsr", ext_zicsr, KVM_RISCV_ISA_EXT_ZICSR),
+    KVM_EXT_CFG("zifencei", ext_zifencei, KVM_RISCV_ISA_EXT_ZIFENCEI),
     KVM_EXT_CFG("zihintpause", ext_zihintpause, KVM_RISCV_ISA_EXT_ZIHINTPAUSE),
     KVM_EXT_CFG("zihpm", ext_zihpm, KVM_RISCV_ISA_EXT_ZIHPM),
+    KVM_EXT_CFG("zba", ext_zba, KVM_RISCV_ISA_EXT_ZBA),
     KVM_EXT_CFG("zbb", ext_zbb, KVM_RISCV_ISA_EXT_ZBB),
+    KVM_EXT_CFG("zbs", ext_zbs, KVM_RISCV_ISA_EXT_ZBS),
     KVM_EXT_CFG("ssaia", ext_ssaia, KVM_RISCV_ISA_EXT_SSAIA),
     KVM_EXT_CFG("sstc", ext_sstc, KVM_RISCV_ISA_EXT_SSTC),
     KVM_EXT_CFG("svinval", ext_svinval, KVM_RISCV_ISA_EXT_SVINVAL),
+    KVM_EXT_CFG("svnapot", ext_svnapot, KVM_RISCV_ISA_EXT_SVNAPOT),
     KVM_EXT_CFG("svpbmt", ext_svpbmt, KVM_RISCV_ISA_EXT_SVPBMT),
 };
 
-- 
2.41.0


