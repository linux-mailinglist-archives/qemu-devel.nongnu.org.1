Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 230B080AC3F
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 19:40:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBfkR-00068Y-KS; Fri, 08 Dec 2023 13:38:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rBfkM-00067w-KU
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 13:38:46 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rBfkK-0008SO-Vj
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 13:38:46 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-286d8dae2dbso2741382a91.1
 for <qemu-devel@nongnu.org>; Fri, 08 Dec 2023 10:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1702060722; x=1702665522; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oKQSIfEeOv87vk/nwq3R4JWRjgFx7fupjLrhNfyLjg4=;
 b=mCc8PBWJLdanLuaKtDsuju8WHFqmCGyXXw96J2gocPv+ku4xSLjUOnGv9A9Zoxb6CR
 nY8QbZ4+Uh1lKqhfI0/Fai9I7tGHm2+l/qxj3wJ70Xp4n9wJmtQMrYpFZImKJBTwP+W/
 Akl1ky8/d8u+xFxzklH50WjqZ8nT+E5cpKGYjzumrSoL39W16l9feV4JgvWfPJe/5mUe
 xN60nvbXhZBbl6v6HrhBvogUILFKWcxn4+m/Q/Ou3Qvg9oqXzPZmKuPM/kh+TsnVJkxl
 9HMS5he95/0jFBfOVJePeNF/HmmIfmiCATniKW9kbkPUFNA5zD9k9LzLKWLnNEotP+st
 GFlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702060722; x=1702665522;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oKQSIfEeOv87vk/nwq3R4JWRjgFx7fupjLrhNfyLjg4=;
 b=SozLb05p4b/gdMWgn+jFIjkz99X3gCgkfaV7iYdvPZU3HwD3usNmQwtYYtaS1salaR
 XHY9oHtUNuW6LmJWoi0dh1IcKpTBk6wY1V3Ucsb8fyzcowIdhQFcdgD1dS7tBU/scfYP
 iYFKBxdCJUohJaGzX48YC2oU/43KD5l1BaZcfytJNyVAloorLBG8L2ZXw18hUtdEpOIR
 BEXan02f6lGsvEYLTo+Ont74++vZtE8M33sqVRTcmjoowkNJEwa8yIlxiywhx8pdaauy
 l9htrlh+UYBK+w6vdE82xcTRcybkCVe99gjbr3geaVhsx5x9ITJBcNXk3U7IorXHcVMo
 9wJg==
X-Gm-Message-State: AOJu0YyRGB/CJLzSrlGfb5VUGc+RrHUSGUetY1uzp8NuHylu0vGSqfbQ
 QPy8RDjY3Ak6JSF1NIrCwmfR24I6BXcisZbld+w=
X-Google-Smtp-Source: AGHT+IGNEOiYDTi291+6Om8EWUsNpOfA4bL800fCEWUwGGw+Y9whLKksDA3jr24SE8HCAGTemES7og==
X-Received: by 2002:a17:90a:fd13:b0:286:ec21:f579 with SMTP id
 cv19-20020a17090afd1300b00286ec21f579mr760387pjb.28.1702060721736; 
 Fri, 08 Dec 2023 10:38:41 -0800 (PST)
Received: from grind.. ([152.234.124.8]) by smtp.gmail.com with ESMTPSA id
 sk13-20020a17090b2dcd00b002864c14063fsm2190709pjb.20.2023.12.08.10.38.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Dec 2023 10:38:41 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-9.0 0/5] target/riscv/kvm: fix KVM reg id sizes
Date: Fri,  8 Dec 2023 15:38:30 -0300
Message-ID: <20231208183835.2411523-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x1036.google.com
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

Hi,

While working in a follow-up for the Vector KVM regs, where we would
read 'vlenb' and then all other vregs [1], Drew noticed that we're using
kvm_riscv_reg_id() in registers that are u32 and u64.

The helper is returning ulong regs for all cases, meaning that we return
the wrong size for u32 regs when running 6 in 64 bits (case of FP_F
regs) and u64 regs when running in 32 bits (case of FP_D and timer
regs).

It's best to do a quick bug fix round in the KVM reg IDs before adding
more IDs, so here we are.

This is marked as 9.0 because the fixes aren't critical enough to
postpone 8.2. Michael, patches 1, 2 and 3 are good candidates for
8.2-stable.

Alistair, in case these are accepted I'll re-send "[PATCH for-9.0 0/4]
target/riscv: add RVV CSRs" based on these fixes to avoid conflicts in
the tree.


[1] this is dependent on kernel side changes that are being discussed
here: https://lore.kernel.org/kvm/20231205174509.2238870-1-dbarboza@ventanamicro.com/
("[PATCH v3 0/3] RISC-V, KVM: add 'vlenb' and vector CSRs to get-reg-list")


Daniel Henrique Barboza (5):
  target/riscv/kvm: change KVM_REG_RISCV_FP_F to u32
  target/riscv/kvm: change KVM_REG_RISCV_FP_D to u64
  target/riscv/kvm: change timer regs size to u64
  target/riscv/kvm: add RISCV_CONFIG_REG()
  target/riscv/kvm: rename riscv_reg_id() to riscv_reg_id_ulong()

 target/riscv/kvm/kvm-cpu.c | 109 ++++++++++++++++++++-----------------
 1 file changed, 59 insertions(+), 50 deletions(-)

-- 
2.41.0


