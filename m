Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE817DE6EE
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 21:46:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyI34-0002lB-L8; Wed, 01 Nov 2023 16:42:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qyI32-0002ka-Mv
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 16:42:44 -0400
Received: from mail-yb1-xb31.google.com ([2607:f8b0:4864:20::b31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qyI2z-0000kc-J2
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 16:42:43 -0400
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-d9b9adaf291so195569276.1
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 13:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698871360; x=1699476160; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NzlbiQ+OWiuQaLiREzwSbJ6YhgK4c0yS/a9TyPGRRgU=;
 b=K/JofTD3x13u2FOHCjjlWyS9Lzgkj12ZuIctznqkQAv2bO1px4iAFk4SSYwY1YeD10
 o8fNXn8qEHhWBOGjxW1v/YhPRlUy88etr/FiNWAue+NVOBzX69Sv1B2nJQmllto4CqU3
 fWAtFnMZXNtC8SMTZ+ESTewBojiDtm9fRDL5aPt11h14ZNWdhuq8nJtO4PaRZ2zkrxYs
 OM4D+7jWEzQT/xA1SiNdCm5ljQEKtGhDGLZJKlUj52tpiXxUm9s3LZ7z9fRGbs5Snw47
 rcheNdoZ7MWb1PXBtwVeKM+ovW3m2rEC5hanYhQGssPQqbhwF9rewXMlL+PsxH75riQr
 7saw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698871360; x=1699476160;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NzlbiQ+OWiuQaLiREzwSbJ6YhgK4c0yS/a9TyPGRRgU=;
 b=ILUNUg5peohasyoleydP9bPPxQmpC+sgOEZeDpxoAnIAcSVJQdbFbx5KziSelF4pU/
 V+aSCI7sql5mEHQE6BcvwC55Eey9Icuk+d4kHhc3Mm/Tdv5KLBuEBSXHW35BzT3Fprhv
 Xg6RTbMb+ZCsGvrKfqOlfssJtHQf6i70ByT8D0+q8MkZ7XedzVmWjMzcAerYpuBiJDxM
 0oPjSGj8Qdj2u3ipDyap3APw50ir14VV+Ahf8qfBWohi6eDnmJmqHF69lOUmhQXRz3O4
 SatXGwMSLkuKFCowB8aSZOxhi1Fmmf3SF+UGdmBUN+GVZSsW+chiLd+7jhMOnDKmUQJz
 s9MQ==
X-Gm-Message-State: AOJu0YxjEpcKu4cylSfewj4NjYrui/e2hATXvv2IIB7fSFEiFgxdEvY5
 AoWUjsUoXnd1X1zNxF5Npgyq8A8PLKuNeBTZbJQ=
X-Google-Smtp-Source: AGHT+IHVcgcZSR3doe7k8NWo7ga9mtZrLooAmtr8tqO3LDReahoE7SYemV/cDeWvDFlACrnNtwOt9Q==
X-Received: by 2002:a25:cfd1:0:b0:d9a:b70c:d32b with SMTP id
 f200-20020a25cfd1000000b00d9ab70cd32bmr14273649ybg.41.1698871360326; 
 Wed, 01 Nov 2023 13:42:40 -0700 (PDT)
Received: from grind.. ([179.193.10.161]) by smtp.gmail.com with ESMTPSA id
 z187-20020a2533c4000000b00d9cc49edae9sm329724ybz.63.2023.11.01.13.42.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 13:42:40 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v8 11/19] target/riscv/kvm: add 'rva22u64' flag as unavailable
Date: Wed,  1 Nov 2023 17:41:56 -0300
Message-ID: <20231101204204.345470-12-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231101204204.345470-1-dbarboza@ventanamicro.com>
References: <20231101204204.345470-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b31;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-yb1-xb31.google.com
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

KVM does not have the means to support enabling the rva22u64 profile.
The main reasons are:

- we're missing support for some mandatory rva22u64 extensions in the
  KVM module;

- we can't make promises about enabling a profile since it all depends
  on host support in the end.

We'll revisit this decision in the future if needed. For now mark the
'rva22u64' profile as unavailable when running a KVM CPU:

$ qemu-system-riscv64 -machine virt,accel=kvm -cpu rv64,rva22u64=true
qemu-system-riscv64: can't apply global rv64-riscv-cpu.rva22u64=true:
    'rva22u64' is not available with KVM

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 target/riscv/kvm/kvm-cpu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index a11c0e4a99..c5167d474a 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -393,7 +393,7 @@ static void cpu_set_cfg_unavailable(Object *obj, Visitor *v,
     }
 
     if (value) {
-        error_setg(errp, "extension %s is not available with KVM",
+        error_setg(errp, "'%s' is not available with KVM",
                    propname);
     }
 }
@@ -474,6 +474,11 @@ static void kvm_riscv_add_cpu_user_properties(Object *cpu_obj)
     riscv_cpu_add_kvm_unavail_prop_array(cpu_obj, riscv_cpu_extensions);
     riscv_cpu_add_kvm_unavail_prop_array(cpu_obj, riscv_cpu_vendor_exts);
     riscv_cpu_add_kvm_unavail_prop_array(cpu_obj, riscv_cpu_experimental_exts);
+
+   /* We don't have the needed KVM support for profiles */
+    for (i = 0; riscv_profiles[i] != NULL; i++) {
+        riscv_cpu_add_kvm_unavail_prop(cpu_obj, riscv_profiles[i]->name);
+    }
 }
 
 static int kvm_riscv_get_regs_core(CPUState *cs)
-- 
2.41.0


