Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6827D716DF3
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 21:48:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q45J6-0006aw-5C; Tue, 30 May 2023 15:47:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1q45J4-0006Zy-4w
 for qemu-devel@nongnu.org; Tue, 30 May 2023 15:46:58 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1q45J1-0004Ix-L6
 for qemu-devel@nongnu.org; Tue, 30 May 2023 15:46:57 -0400
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-397f3aec11aso132646b6e.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 12:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1685476014; x=1688068014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RRT+44VDoy+4v36rTa7zi9SGRXRzolaKQZeKAAn0Q/E=;
 b=nYqB3w91d2ThcUoM0FCQ87uqY908IMWIZUFVa0cAGbuyW5foor589rSy85QspsxDWQ
 w09mN+V3mCRCV7G+MqkPWRA0Wp3Sqy7ps4aYbvrd66YL97oqSs2Ej8gH5Rf1TVgxyO+W
 H8lKw96LpCgqudtivAyfzERjPd/qllP83Dn5CSXfJG2+QLj4RKbOhV31ncKr4WnHYjRE
 GQYi3hV+K6O0XH3jSk3CEmTZB0UnsZE3Ke84nnI6YaWsXQCDptgWzHdzsYf5KaDar7qs
 Mo4hpBvPhnDXOKEXp4XUxtqOYAc6Xw2Z5wBqCG+cxeyIhPopk6ZlbfwetsUGwv4NBPSi
 6Unw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685476014; x=1688068014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RRT+44VDoy+4v36rTa7zi9SGRXRzolaKQZeKAAn0Q/E=;
 b=l3uJTjJP6/cegSzBFjcR4iMrBKy5yW4JBRbDhmOAF4UHkSAQlbdf7Ylo5A2wSkinBU
 U/h106ryDNDkrZgLWLc9ZkuqQMQNv8YR2gqpo8fqv+bqE3a2L57v5F3wYhWOg7awuHpC
 YyT/utART8Hdp0ZMjo+95cdJewI8jbkCG8aAGjkiu45MIkusdQUtn6ple+zgfMlXUhUM
 IGRQMHkhRgLFj/X8LYqwVrHyLaREJUnKwLfgqKUvhRU9X1HEeMvXiTPCgkM6tzBUuigs
 8zNpdkNwPtk0FHVYdOcGsPFKLSYpGmlmeRHETBiFttiGAdu/LSVw86P8XqTwuU72wM/5
 o1Nw==
X-Gm-Message-State: AC+VfDzBWKZsvKouQzT5AKmOXgu3ehszJIdkzzvwdRHGmvtcgEWjJ5qh
 681c8Q9thEjLd9SqpGiVypC/Th/y8XTGlQXk+X4=
X-Google-Smtp-Source: ACHHUZ6bSCx0/MSV2LTrw4X9l2NzaC817de0O+RVwDKAZaHBfjCDYL4hFmz+GqXyxUgkuu+IlC0jNA==
X-Received: by 2002:a05:6808:3022:b0:393:fe54:9a01 with SMTP id
 ay34-20020a056808302200b00393fe549a01mr1789194oib.11.1685476014272; 
 Tue, 30 May 2023 12:46:54 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com
 (200-162-225-121.static-corp.ajato.com.br. [200.162.225.121])
 by smtp.gmail.com with ESMTPSA id
 j3-20020a056870a48300b0019fa8728b05sm342214oal.39.2023.05.30.12.46.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 12:46:54 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 07/16] target/riscv: read marchid/mimpid in
 kvm_riscv_init_machine_ids()
Date: Tue, 30 May 2023 16:46:14 -0300
Message-Id: <20230530194623.272652-8-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230530194623.272652-1-dbarboza@ventanamicro.com>
References: <20230530194623.272652-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oi1-x22b.google.com
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
2.40.1


