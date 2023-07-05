Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 620CD749005
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 23:41:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHAEl-0004tl-5U; Wed, 05 Jul 2023 17:40:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qHAEg-0004rt-RF
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 17:40:30 -0400
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qHAEd-0001hn-JA
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 17:40:30 -0400
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-56347da4a50so4713443eaf.2
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 14:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1688593225; x=1691185225;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zsw0pJ1ZMaa7pJqxBp9+XWOi9ryOdYncMUElEND8Y8o=;
 b=iZLX4ZpQlnEGo+ssQ/3/dXjA+Hj0z37yMR+YwGvS8P0u+hpkAFI9jVbErrerCLh8FL
 UnH+/+Hv4tDyFdv2OIEUkenaVrs5nes+JJ9KOPxOQ0V9QrY441w6RIoDWA977PYP97RC
 MWi8YICqPA1xTraT50JyebVOX3dSVLWWkVll03cSPK4OMgCiWHXHII6zchN41nKKstZV
 IdYzBdN9Uh1Qr9alrhZM0rYrIte32MDvv3NBeHZC272a5LJG5TPpeGXYCoTMJzaT/8L2
 GTe5q//rqzFgMZezjGk10Jxq4iYMAwmshwhRIwPWQbYhG7waAADhX71kO5HBx0Xw59DF
 iOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688593225; x=1691185225;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zsw0pJ1ZMaa7pJqxBp9+XWOi9ryOdYncMUElEND8Y8o=;
 b=QHYIBZp63fduP2SVDR5GGJLljFalC3EVY2YA8TNT/5AIfiUhCkQhgs8vScMD84MoCk
 ry2FP7wv72veMg1187hc0E3GU1zJIIt6Ajxr0uje2T2ANKb1lcG8Kd8ii4Hhf+4v0hX2
 zZ1awrPDrMSl6FH+SuNZnBK0NZasUbJlKUWco/oYYg8ENzfXN+L6U8OZLKVPB8mQs4Xn
 dFXZf/thpsXGXeqiTbVXr3ihCDBBk5EuxQkYnn7izo52R06WeAzpVgMGqnaDG78odFI/
 HKGyo/UbSb6fZVYpx+lkl+vjKo6I1nFqxVgV+fiY5nH95ges9DEVLjCLvdJNX1nEVrb0
 5tyQ==
X-Gm-Message-State: ABy/qLZKap3U21yID1ZpQrYeE7IZM0hh8tqk268nH+wh1YGgTQ8odhrI
 bxQ6VCjKZvoGyq7EEtRA5Rt2z8ZM5W66rSf/PUA=
X-Google-Smtp-Source: APBJJlHmwopqcMX5jK4hYn4zHJb5UJCGsCsXvbxYW+4YD03tMQCDNha037vckDVSTNvzfiX/qy4W8Q==
X-Received: by 2002:a4a:4fc9:0:b0:565:8648:9cf1 with SMTP id
 c192-20020a4a4fc9000000b0056586489cf1mr73586oob.0.1688593225241; 
 Wed, 05 Jul 2023 14:40:25 -0700 (PDT)
Received: from grind.. (201-69-66-110.dial-up.telesp.net.br. [201.69.66.110])
 by smtp.gmail.com with ESMTPSA id
 m1-20020a4add01000000b0056665a16536sm70764oou.30.2023.07.05.14.40.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jul 2023 14:40:24 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v8 07/20] target/riscv: read marchid/mimpid in
 kvm_riscv_init_machine_ids()
Date: Wed,  5 Jul 2023 18:39:42 -0300
Message-ID: <20230705213955.429895-8-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705213955.429895-1-dbarboza@ventanamicro.com>
References: <20230705213955.429895-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c32;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oo1-xc32.google.com
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


