Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F68749941
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 12:19:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHM3y-0004sa-6A; Thu, 06 Jul 2023 06:18:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qHM3v-0004ry-UV
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 06:18:11 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qHM3t-0006bi-QN
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 06:18:11 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-6b7206f106cso439482a34.1
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 03:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1688638688; x=1691230688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zsw0pJ1ZMaa7pJqxBp9+XWOi9ryOdYncMUElEND8Y8o=;
 b=TOa+6qxfUaQJHAOPtKiPjmy8fUSyadQNweLwmiFbcaikuK9RirZAuKDhYOpc8EzRfp
 /6VOzxp6JTHcWERm4Ifg6sXanM/PKsRgeQGkOawvUUjrNKS9zG80JHH8mA4xXPolKQeB
 9nrOensZBvgtMYfHEp1PxJPeoaDciaSPIfHGw6ZuuRpx6uM93qZgmAUG5kIlr9NZxxOl
 lOJ9myHuHWZdA/JVLRRdmdMVHwSUj+B++wBUe+DKxEXX9XchgETMFWBbhLg/z10pBFVD
 StP4xfWXvQmzQoBfYpinl8wtyrq/rH5I8Eglt8Wu12DbWLDkmTpmfkiTDZ3CCI2lHkg2
 5HRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688638688; x=1691230688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zsw0pJ1ZMaa7pJqxBp9+XWOi9ryOdYncMUElEND8Y8o=;
 b=XRPPW7CzXe+smc9eIxuJUSI934bKCfxQ6pFZuZi7IeIfoIHvKRQjGVUYC4pGt1UTpn
 irH8H5z1BaptbPEhV76+3wxWQ+I28HY9TkVhn/Zsur4YWdjvY5+dvD8rxRO9zW9hi2Wq
 x0cJH1SyV3Yt31IQ/sMbmmtepp5BRRS6XfDWFN1HXnI0ygw0LC1h5eTDm8Y7sjJCpcVV
 nOvhk2nu4tqkazDfoLHNn//MmUTzJQw4CmSulD9tWK3VPNTO/iBjZB3xxLqARMn/JLnC
 b0FdfGkWyBcL0wpdi1W2Fx1xZm17pJWvZegFgK5SR9o8vIdtW54rR7xNmioGdIRgnbk6
 ihFA==
X-Gm-Message-State: ABy/qLZXPBmV/p/ZiJi1ZymK3mp7uPKI5sG8j7YnzRupf7HY+8FQiXzH
 t2lbfHH7wFGmXzdMNWVhEubkW4UTY3yj8OLUrHk=
X-Google-Smtp-Source: APBJJlF1QO7vQs4xtWourJStdtmg6cxWkQ9QQ8gVgPVbkKcwNv0dRrNQSis/sLgPzbii05pPy813aw==
X-Received: by 2002:a05:6830:1d5b:b0:6b8:9a14:91f5 with SMTP id
 p27-20020a0568301d5b00b006b89a1491f5mr1646074oth.21.1688638688402; 
 Thu, 06 Jul 2023 03:18:08 -0700 (PDT)
Received: from grind.. (201-69-66-110.dial-up.telesp.net.br. [201.69.66.110])
 by smtp.gmail.com with ESMTPSA id
 h25-20020a9d6a59000000b006b8850ad193sm511382otn.56.2023.07.06.03.18.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jul 2023 03:18:08 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v9 07/20] target/riscv: read marchid/mimpid in
 kvm_riscv_init_machine_ids()
Date: Thu,  6 Jul 2023 07:17:25 -0300
Message-ID: <20230706101738.460804-8-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230706101738.460804-1-dbarboza@ventanamicro.com>
References: <20230706101738.460804-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x32e.google.com
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

Allow 'marchid' and 'mimpid' to also be initialized in
kvm_riscv_init_machine_ids().

After this change, the handling of mvendorid/marchid/mimpid for the
'host' CPU type will be equal to what we already have for TCG named
CPUs, i.e. the user is not able to set these values to a different val
than the one that is already preset.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/kvm.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/target/riscv/kvm.c b/target/riscv/kvm.c
index 37f0f70794..cd2974c663 100644
--- a/target/riscv/kvm.c
+++ b/target/riscv/kvm.c
@@ -378,6 +378,22 @@ static void kvm_riscv_init_machine_ids(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
     if (ret != 0) {
         error_report("Unable to retrieve mvendorid from host, error %d", ret);
     }
+
+    reg.id = kvm_riscv_reg_id(env, KVM_REG_RISCV_CONFIG,
+                              KVM_REG_RISCV_CONFIG_REG(marchid));
+    reg.addr = (uint64_t)&cpu->cfg.marchid;
+    ret = ioctl(kvmcpu->cpufd, KVM_GET_ONE_REG, &reg);
+    if (ret != 0) {
+        error_report("Unable to retrieve marchid from host, error %d", ret);
+    }
+
+    reg.id = kvm_riscv_reg_id(env, KVM_REG_RISCV_CONFIG,
+                              KVM_REG_RISCV_CONFIG_REG(mimpid));
+    reg.addr = (uint64_t)&cpu->cfg.mimpid;
+    ret = ioctl(kvmcpu->cpufd, KVM_GET_ONE_REG, &reg);
+    if (ret != 0) {
+        error_report("Unable to retrieve mimpid from host, error %d", ret);
+    }
 }
 
 void kvm_riscv_init_user_properties(Object *cpu_obj)
-- 
2.41.0


