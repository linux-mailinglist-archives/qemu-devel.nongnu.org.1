Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 10038816ECB
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 13:55:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFD8U-0002j4-NF; Mon, 18 Dec 2023 07:54:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rFD8S-0002iR-Le
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 07:54:16 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rFD8R-0004tA-77
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 07:54:16 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1d39afa1eecso16065555ad.2
 for <qemu-devel@nongnu.org>; Mon, 18 Dec 2023 04:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1702904053; x=1703508853; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fhQC9jgEnFsY5QipozztkZp58yiYBOZNUoWpxhfbrbo=;
 b=dUhjzZZ5r5tvMQ/tYyFXq2iOCjvXQVgSUVIBEDI9szwAQpZxwHU6ma8dJOkLkrf6UM
 GQOt4ZRJ/WyMhxh/EHdTnVc2S1eFS/ADxHfB27LKjBwxg5Nax41c/C4Je9ZONBjiXcY/
 DIyAFyteDV9YNtVIgdi2Y89jUZX+rbU/LONf7u+RIvLM0h39C6PuF/C4wFelSjOxwNoT
 jnIb+1z7fivRZV/v8+M0+oWeBDcHc0LLQIGbso7chXLLZxvkBPDkgfTvyFQnLALzaJMh
 klKR7K/tpeouXuCyt2iTlG19BIlu3GoRFyjthfWKUC+20K3tC2gkFyr4LpcXupp3pc9l
 KCmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702904053; x=1703508853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fhQC9jgEnFsY5QipozztkZp58yiYBOZNUoWpxhfbrbo=;
 b=pLMixEwyo/5RhheTgrjPCQz/BV8kunY+Ge7G59SPAaneW7VdV+nvJsMzB+FVj1Bofd
 n5B1T04CljcCI5/TTsU1N8A0li9LP/sE/3wdUCDT34UeGW1HxC2GwCY+gglmIXCWmhNa
 OabmRT7lFAaV1ZYDGUdZUELV+eve8OodlNTN0nwmxFinro5mMePugV1HRpJvncFc75zX
 xWdvHRhamhnjUJR5mkNlTx6nk5NrvK2bOyZ5wfkCypn41dQAv044SreEIXBWDGzHAKMw
 KZA7nwL5wgfXEQ/6eUo2b/RdQkkVn3Ky9DciomSJwRFBnlWQ/9xk3g4gM9jvBspqV5dG
 H2yw==
X-Gm-Message-State: AOJu0Yx8syWIhUhOK8MnzkL11vrlxb9OHnOawqM6aPNjKB8gHL0n2Yw5
 XHal3LW27UNjqriZ2GQLYUFmKqCI2XWtekd0V7I=
X-Google-Smtp-Source: AGHT+IFeGIYV00Jj4Hpj0GTR+/yxBCnRMgzLSG73STEydE7D81/W1bTQWMK9oM5dZBE6TsRmh5UunA==
X-Received: by 2002:a17:903:246:b0:1d3:bc96:6c13 with SMTP id
 j6-20020a170903024600b001d3bc966c13mr1821269plh.35.1702904053669; 
 Mon, 18 Dec 2023 04:54:13 -0800 (PST)
Received: from grind.. ([179.93.21.205]) by smtp.gmail.com with ESMTPSA id
 c2-20020a170902848200b001d09c539c96sm7494897plo.229.2023.12.18.04.54.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 04:54:13 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v13 09/26] target/riscv/kvm: add 'rva22u64' flag as unavailable
Date: Mon, 18 Dec 2023 09:53:17 -0300
Message-ID: <20231218125334.37184-10-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218125334.37184-1-dbarboza@ventanamicro.com>
References: <20231218125334.37184-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62c.google.com
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
index 62a1e51f0a..ea8b1b1259 100644
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


