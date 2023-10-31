Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D457DD765
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 21:53:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxviX-0001cW-Og; Tue, 31 Oct 2023 16:52:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qxviW-0001b6-0E
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 16:52:04 -0400
Received: from mail-vk1-xa31.google.com ([2607:f8b0:4864:20::a31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qxviU-0001FG-D0
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 16:52:03 -0400
Received: by mail-vk1-xa31.google.com with SMTP id
 71dfb90a1353d-49dc95be8c3so2531463e0c.0
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 13:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698785519; x=1699390319; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FR3ujDYIpjULyW/1KYJG1hqQjepS6FGdNIe2vE+WeLg=;
 b=meUJP7DMclhMIw7D+BZ9y43jiDv2mDljPoAOTiuljZV0TRhzy71zm15Z+rgP+CUO+X
 f20TrQcV8qsBXlUFphmFZ0eykZJzNN2i4uE5ygUeWU16VWk4mU0bBX0PUG9t0XUHX1dZ
 bcywNwtlLP9oMwpXrOnmVZIU5DjklOQxoW9wK0x+SyCKg0a5fnRpOES83Dzxb5vwU4Tf
 iatxYLj5DbHwha3K2LL6yExXcDq7a3ITS8kxDLLMwAFXUQhh+22H4MTQfOLsV8HRW6Pp
 g1rMYENBvU2xshWi4hQlS5FrKdZmTyZyq1twMD9arFgYw6dxY0wEhXOFuah2arl2ZzLP
 EzWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698785519; x=1699390319;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FR3ujDYIpjULyW/1KYJG1hqQjepS6FGdNIe2vE+WeLg=;
 b=jPgYhmRg6IMWWVZYowF3b8Bkeac3S5QNXy3u+uhjRyHyUnmSn0vkQCxVoFAAEmXPMr
 FgMepNy9I9Efb9buj78hPw9PvH/k9m8RUkXpfLm58JrTlTiENVYmaYUB+xe6ycv0K22J
 n2s0I9MVruHInGRdVhtyz8PDhfAtsu//cmoO9P1D/8CIk9oJtFPvcDQ+1hYBIzXRLCn+
 hriMq52EPanXuery8YbqrTxI1s8t9eAf0TuUuSyGI+sAtMtUKqj+pkmKdKvh731vbox9
 q5geIk8QaLXevPt5yk/HPoU7N+LwiQ/xmKUCsbjSv2mc0NBdnLDdASsQv+gVDbKWAXhe
 Ujeg==
X-Gm-Message-State: AOJu0Yz4T3CvzqRC//1/hCnYdLxLTm66D9K6Pt1dg4QTjRRx+9pxLzBM
 XkU1ZT5gpVOrftYuKKnF9uyKYL0Jb1GKgUKSTBo=
X-Google-Smtp-Source: AGHT+IH8XUwnA0miDHEaQBSrPQ9PjnzdPtl4bMXmHrlSlRZHBLV/y/Gy1L9+XQV2MTHfYyBk9Tdjlg==
X-Received: by 2002:a1f:b201:0:b0:493:3491:ce89 with SMTP id
 b1-20020a1fb201000000b004933491ce89mr9419667vkf.14.1698785519468; 
 Tue, 31 Oct 2023 13:51:59 -0700 (PDT)
Received: from grind.. ([179.193.10.161]) by smtp.gmail.com with ESMTPSA id
 t8-20020a0cef48000000b00671ab3da5d0sm826408qvs.105.2023.10.31.13.51.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 13:51:59 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH] target/riscv/kvm: add zicsr, zifencei, zba, zbs, svnapot
Date: Tue, 31 Oct 2023 17:51:50 -0300
Message-ID: <20231031205150.208405-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a31;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-vk1-xa31.google.com
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

These regs were added in Linux 6.6.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
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


