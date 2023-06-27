Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F246740163
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 18:36:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEBcN-0003b3-Kr; Tue, 27 Jun 2023 12:32:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qEBcM-0003an-Go
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:32:38 -0400
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qEBcI-0004qN-Qi
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:32:38 -0400
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-1b0156a1c4bso2241150fac.1
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 09:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1687883553; x=1690475553;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zsw0pJ1ZMaa7pJqxBp9+XWOi9ryOdYncMUElEND8Y8o=;
 b=AmTCYHGUynesLcDwR/L/9ogbJ/dRk/ZGDbUIhbkT67Ibj6j/eYhnPoGrxtmG8T+VOM
 kTPj5qcL4SaNIbKJjTtyPGfqT57QvhESBNpfaMEfFjhj+Hz+kamsBitqRstUOisgJa24
 O2bea6c6zkahzHZWrYqRA0EBi8+kyfGW3KByi+kTa5KIm0nFLKbGBWvZ8yXt6spI0vqD
 g8j9Vd/8pOBpuddLipJl4r+Z2q742hhLVIpFHMna32hRGOu/UtXJMFfFaEdPiwIfwmWS
 AeJAcA0sGKs/VFfYrVbkX2YbTtqBda7+YHqwxBZTNq02aZoaNjYQMLsdC7w+WTaqtQag
 /nRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687883553; x=1690475553;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zsw0pJ1ZMaa7pJqxBp9+XWOi9ryOdYncMUElEND8Y8o=;
 b=aDJzuER247XRzw/WUsOroPgPFLW56J7OfXQgW6CFQ59+HgvV7poyWQDXOn0rjDSZOf
 Wbp/le5TNLTFDNoPrsHzgugoAFsQIBet92NRjFIVNWqtbFmaHMHjajaaalWcJi5flrRN
 SFtW2pKlXXZB+PHEV5wtZdBttSlLlKxu0YvdoGQeVbjWP7VphRroZDCL/GOlgjvGduq2
 uesCRXvc/An/HGjH8RO+l7AVgi6nIGMw+joUIxJ0VeCPO6CpjzoK+xLNg9MX31Dz3s8E
 k9Sc7tFVxjGSutKKKGM/P9HESSKz3rprnn8qp6swab0tf9J4gigC4jgskxpbtiXtMOih
 TmgQ==
X-Gm-Message-State: AC+VfDzHS963K7ObDgclgmMtlfVJ9nZMedQrezLeWRlYaqKUsSZw3uRa
 cerHN9DiRroUk5MJcSplCCr44+xNOXsYETrQ7PA=
X-Google-Smtp-Source: ACHHUZ5JLC0eFrwbkx+8CFvGH6lukTMGwNY8puOoTXUFac2e5MW6P+Vw6UqyvW+v/oP+2yA88ly31g==
X-Received: by 2002:a05:6870:e896:b0:18d:4738:33fc with SMTP id
 q22-20020a056870e89600b0018d473833fcmr20310044oan.37.1687883553474; 
 Tue, 27 Jun 2023 09:32:33 -0700 (PDT)
Received: from grind.. (201-69-66-110.dial-up.telesp.net.br. [201.69.66.110])
 by smtp.gmail.com with ESMTPSA id
 gu17-20020a056870ab1100b001a3093ec23fsm5254134oab.32.2023.06.27.09.32.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 09:32:33 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v5 07/19] target/riscv: read marchid/mimpid in
 kvm_riscv_init_machine_ids()
Date: Tue, 27 Jun 2023 13:31:51 -0300
Message-ID: <20230627163203.49422-8-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230627163203.49422-1-dbarboza@ventanamicro.com>
References: <20230627163203.49422-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oa1-x2b.google.com
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


