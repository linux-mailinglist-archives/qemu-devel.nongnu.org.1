Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7638295BF
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 10:07:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNURu-0007C9-Do; Wed, 10 Jan 2024 04:00:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNURW-0005dj-JW
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 04:00:12 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNURU-0004iv-ND
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 04:00:10 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6d9b37f4804so3141661b3a.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 01:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704877207; x=1705482007; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uRYwGnRvNaF66+ZgD+qJDnGYw78KjfSr86sf9gWXd4E=;
 b=HQMrjDKv/lpfC4c3pqBitbTcKH8mIDMlMvKu8lsw6sbKMbqikI8uiBeDylkwArPrc7
 lC1rCX9mat3S0gCS1oupit4TO+X5hev7Cr5W+LhtrLsWGKYZzT4uX1K70t5bySr92WSN
 tz4yNR4Px+XeHLcJJw9lzgaYt01wekurKgtQa4Agmy78pa0v+uhPC7Va7yGSgKXfjJJz
 iBWazG6nxEJo4EwHQ6mBXYlI13hbY6wyl8bHA5Eqx+pONCQP3obYPfFJ7vf1ryKecs7G
 4X1FaYEXE6wDo/szdILDLv+1TKHeL68RsG6n1Esf7I4AdtwSCAreAR3XEURoT5FWCgwv
 haeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704877207; x=1705482007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uRYwGnRvNaF66+ZgD+qJDnGYw78KjfSr86sf9gWXd4E=;
 b=vMPF8UJWdTYR8omrKJ4Mk7GLo2bWuZNF5uDxHqwnrWIUq0UT0ZkfOxAUO+C/eC+xMM
 eBuGAIKCzMrdL9T5N0XA78gWXyYKkDMPB7RYsQw8/21QByfJFJNKFKdoCAkB0Vvcac83
 FyrFedgUxWvOjimB7sc/GE6DUV1TChApToAyrYe+1AgoFnor1LWXnE0yT4P5A5jd163N
 g8kcSOYmfYJt1NZDzofGVqS+xqMoQKugf+Tc2N3E8LOoRH+4ZItO0N98LxBwDxU3EO2S
 bBgpeVJ6sh9GmiiGQee3z6L7RhHP6yKRtykRDYHCLHXR12kQagaXYVChycfKpAJK5QRC
 TwVw==
X-Gm-Message-State: AOJu0YxNW0Usay/12aQ8MdZGsm2AxoNXyd70vjlzUqidSfSZ9kvLySRA
 pioy9Q1H9vcBtWrPve88y/VrDjWtsXvfiM1u
X-Google-Smtp-Source: AGHT+IGxkRNv1yguM1cKjp6wc6tTB6PrkQv11J3vV57ReChQ0PQbDlPzmQOinCGcfgL0I0J5GL2FwA==
X-Received: by 2002:a05:6a20:244a:b0:19a:288a:60a9 with SMTP id
 t10-20020a056a20244a00b0019a288a60a9mr592924pzc.18.1704877206023; 
 Wed, 10 Jan 2024 01:00:06 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 t65-20020a628144000000b006d9879ba6besm3223814pfd.170.2024.01.10.01.00.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 01:00:05 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Andrew Jones <ajones@ventanamicro.com>
Subject: [PULL 37/65] target/riscv/kvm: add 'rva22u64' flag as unavailable
Date: Wed, 10 Jan 2024 18:57:05 +1000
Message-ID: <20240110085733.1607526-38-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110085733.1607526-1-alistair.francis@wdc.com>
References: <20240110085733.1607526-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42e.google.com
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
Message-ID: <20231218125334.37184-10-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/kvm/kvm-cpu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index a31df6e273..2c5217102c 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -414,7 +414,7 @@ static void cpu_set_cfg_unavailable(Object *obj, Visitor *v,
     }
 
     if (value) {
-        error_setg(errp, "extension %s is not available with KVM",
+        error_setg(errp, "'%s' is not available with KVM",
                    propname);
     }
 }
@@ -495,6 +495,11 @@ static void kvm_riscv_add_cpu_user_properties(Object *cpu_obj)
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
2.43.0


