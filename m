Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 28415779718
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 20:26:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUWpD-0002MR-N5; Fri, 11 Aug 2023 14:25:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qUWpB-0002Kf-W8
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 14:25:26 -0400
Received: from mail-vk1-xa30.google.com ([2607:f8b0:4864:20::a30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qUWpA-0003oQ-1f
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 14:25:25 -0400
Received: by mail-vk1-xa30.google.com with SMTP id
 71dfb90a1353d-48746a002f8so828062e0c.1
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 11:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691778305; x=1692383105;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1F7SrSpIXNlKh5W9vshZuEadPvion/6uR1Y68b6CsiE=;
 b=nXoe5ERThCaQB6Z1anFuYR+pr+yxmf9BZSj1viPU0vvgalrxOaZgr3M4M4V5SUaCvc
 qtCeVZYB1xJvfODFp7ZEJqUu754N+1zyq7NqQEHSgvhQvJlxMkyeM9Ak8PyUiygWRGx9
 CTL3u9zSh4Rj58+DQdeAfsCntTCTYJLEgGoH+TBmLR+/u+NR/XmoimWIB82ewni9O+Ah
 zc3sbJWqIc8cEpqUNWb+ggWm+DTtqKzLBY6Gasxbp7JtBQjoLgQjtEw4mLcxv29RGIeJ
 DwfmZ0cLLEn+m2c4in/68p7nUFW44xgH5uL2ey+fIJFeFoGQHHJjl7+Vo6+AysMWsvBz
 4BZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691778305; x=1692383105;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1F7SrSpIXNlKh5W9vshZuEadPvion/6uR1Y68b6CsiE=;
 b=MTyesCS6LWZe4a8BEkkh3+JO7KK2gRTj44Fn4bToleoHemQ+Tv/Aby8wPro5tWsDQ1
 4HyzjfHcoiX4d/zzre8qMABhrOztKddBW9RENjP/Qq4jWdOJpDJGsELMRJgKSFxtxaqg
 thateUQzynAkEMc97yrciIVUQXr9esPX1PSbJnBKrxRz1HCkPCGeTaLmMTwVa6tjFwUM
 vYs16jT5BH7KeLj6dx1eI1wmYo+5LwcyPI8m/9FPZ6Q+4PR9tNYNvSySuQmXK7DrKH1R
 N0CGCqeFwXhpPxxQrW65gTVVu43Rd3mspH8qtYfatYB71bEBTdFnXdOEUD01syrdSpVa
 Foiw==
X-Gm-Message-State: AOJu0YxmuBxnIRGqigqCSByYY0K6tEjvQfy1vQ7FLsarI7UlkE1yvLm5
 9fgkB9gBOXjIImQR433/WOygWhkEfxoAEcgS
X-Google-Smtp-Source: AGHT+IF/JGj7BhmkTUdf5BbP+lx7xLzXRcF3qmZybFAK+wPBUDFm6VNJjLVE547SUlmYZhsP8OPt+g==
X-Received: by 2002:a05:6102:282f:b0:446:f573:3ec6 with SMTP id
 ba15-20020a056102282f00b00446f5733ec6mr2322801vsb.9.1691778305464; 
 Fri, 11 Aug 2023 11:25:05 -0700 (PDT)
Received: from localhost.localdomain ([146.70.187.10])
 by smtp.gmail.com with ESMTPSA id
 g30-20020ab016de000000b007876731f2dbsm638234uaf.22.2023.08.11.11.25.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Aug 2023 11:25:05 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Andrew Jones <ajones@ventanamicro.com>
Subject: [PULL 1/2] target/riscv/kvm.c: fix mvendorid size in
 vcpu_set_machine_ids()
Date: Fri, 11 Aug 2023 14:24:44 -0400
Message-ID: <20230811182445.1185140-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230811182445.1185140-1-alistair.francis@wdc.com>
References: <20230811182445.1185140-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a30;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa30.google.com
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

cpu->cfg.mvendorid is a 32 bit field and kvm_set_one_reg() always write
a target_ulong val, i.e. a 64 bit field in a 64 bit host.

Given that we're passing a pointer to the mvendorid field, the reg is
reading 64 bits starting from mvendorid and going 32 bits in the next
field, marchid. Here's an example:

$ ./qemu-system-riscv64 -machine virt,accel=kvm -m 2G -smp 1 \
   -cpu rv64,marchid=0xab,mvendorid=0xcd,mimpid=0xef(...)

(inside the guest)
 # cat /proc/cpuinfo
processor	: 0
hart		: 0
isa		: rv64imafdc_zicbom_zicboz_zihintpause_zbb_sstc
mmu		: sv57
mvendorid	: 0xab000000cd
marchid		: 0xab
mimpid		: 0xef

'mvendorid' was written as a combination of 0xab (the value from the
adjacent field, marchid) and its intended value 0xcd.

Fix it by assigning cpu->cfg.mvendorid to a target_ulong var 'reg' and
use it as input for kvm_set_one_reg(). Here's the result with this patch
applied and using the same QEMU command line:

 # cat /proc/cpuinfo
processor	: 0
hart		: 0
isa		: rv64imafdc_zicbom_zicboz_zihintpause_zbb_sstc
mmu		: sv57
mvendorid	: 0xcd
marchid		: 0xab
mimpid		: 0xef

This bug affects only the generic (rv64) CPUs when running with KVM in a
64 bit env since the 'host' CPU does not allow the machine IDs to be
changed via command line.

Fixes: 1fb5a622f7 ("target/riscv: handle mvendorid/marchid/mimpid for KVM CPUs")
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Message-ID: <20230802180058.281385-1-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/kvm.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/target/riscv/kvm.c b/target/riscv/kvm.c
index 9d8a8982f9..b1fd2233c0 100644
--- a/target/riscv/kvm.c
+++ b/target/riscv/kvm.c
@@ -852,12 +852,19 @@ void kvm_arch_init_irq_routing(KVMState *s)
 static int kvm_vcpu_set_machine_ids(RISCVCPU *cpu, CPUState *cs)
 {
     CPURISCVState *env = &cpu->env;
+    target_ulong reg;
     uint64_t id;
     int ret;
 
     id = kvm_riscv_reg_id(env, KVM_REG_RISCV_CONFIG,
                           KVM_REG_RISCV_CONFIG_REG(mvendorid));
-    ret = kvm_set_one_reg(cs, id, &cpu->cfg.mvendorid);
+    /*
+     * cfg.mvendorid is an uint32 but a target_ulong will
+     * be written. Assign it to a target_ulong var to avoid
+     * writing pieces of other cpu->cfg fields in the reg.
+     */
+    reg = cpu->cfg.mvendorid;
+    ret = kvm_set_one_reg(cs, id, &reg);
     if (ret != 0) {
         return ret;
     }
-- 
2.41.0


