Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E9C743904
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 12:10:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFB3Y-00058b-1O; Fri, 30 Jun 2023 06:08:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qFB3W-00057L-4T
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 06:08:46 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qFB3U-0000n3-DH
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 06:08:45 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6b71eef1bc0so1347084a34.2
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 03:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1688119722; x=1690711722;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zsw0pJ1ZMaa7pJqxBp9+XWOi9ryOdYncMUElEND8Y8o=;
 b=GH6xfbDlYFiN3u3U6CTbWQRGgvwOtVR4OIsQpsqFejd/RsTkUR76uSU+h8d+MSM1wy
 OsX2gjaL8sI/C88XK/lK7eWK5ILriGr/l9GDlBofEfZdJRnUciPe6eHn8IHQNEKjMqQO
 MLcivy2WQAjeLXjW0WT6277b/HXpQHt6nJpYkxQ2xTehXvpcsXxvLMeZlChCFKdE50ep
 BoezemNf2jY2dxjTiksLk+TzdP0SRyqTclLotZiFLd/fDEBhnB9AwoUqXMAU+A/W/9iB
 FNq3xz2/Mp8wZo3uGJL/PCqM/mPg8n0d4JUYeDl3LB7NwsTkq1LK8NOr1MyNPc96/q8w
 Zebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688119722; x=1690711722;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zsw0pJ1ZMaa7pJqxBp9+XWOi9ryOdYncMUElEND8Y8o=;
 b=iQQIYvvHolup8NL1EyYzd29XVQR1GOXhSKI5urYFJUZGyzlhhypXrK7E761y+8uveu
 /3cjMgz8NdQskTVI5v+g5H2jRlyw+togvippRzYE+dWnO4D1vMEh3BT8nvrvL1BnNaeF
 6tct4obt5OSnZnPB38L8D6HD+rNMx9CBWl9AzSk9iV8auYH6BXYr92D6DYIIOm+0gEGp
 /6LPE4JcGib+fEix0fx4YWYy1iIJ7SjaH+C7S9pB3Bgf+fqFdLBsz5iwctTElFpmw8nT
 oIIILmr11iXv+do+kYOem+IkOdIYK+yZXrRgItrpQob9tgMKvylaisMZmoBYaOtE/5KX
 zNSw==
X-Gm-Message-State: ABy/qLasiNY1z+hpl0VdfXR58xI9m3OvxEfeGgRT/tLyIS1DaWDAVnx7
 Hr44SJ8cxtaVqIOqHFkBYuIRPRIbL9suvn7Y/kA=
X-Google-Smtp-Source: ACHHUZ4MVNOn4MkSywhYbYB4lQ4jMM1wA7dBU+/gb0jxakka3OSkMJ5jPkGL7t4gLCOHoeIO9chUIw==
X-Received: by 2002:a05:6870:ac2a:b0:1b0:6f69:89ab with SMTP id
 kw42-20020a056870ac2a00b001b06f6989abmr3246812oab.46.1688119722765; 
 Fri, 30 Jun 2023 03:08:42 -0700 (PDT)
Received: from grind.. (201-69-66-110.dial-up.telesp.net.br. [201.69.66.110])
 by smtp.gmail.com with ESMTPSA id
 eh18-20020a056870f59200b001a663e49523sm8707467oab.36.2023.06.30.03.08.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 03:08:42 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com, philmd@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v7 07/20] target/riscv: read marchid/mimpid in
 kvm_riscv_init_machine_ids()
Date: Fri, 30 Jun 2023 07:07:58 -0300
Message-ID: <20230630100811.287315-8-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230630100811.287315-1-dbarboza@ventanamicro.com>
References: <20230630100811.287315-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x32f.google.com
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


