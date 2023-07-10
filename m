Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B75774D5B3
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 14:36:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIq6U-00061i-W6; Mon, 10 Jul 2023 08:34:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq6N-0005oz-UW
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:34:52 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq6F-0004zr-3e
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:34:51 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-6b87d505e28so3490753a34.2
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 05:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688992481; x=1691584481;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cLLp+q7BwdrJGckFD+1rZ6cBN6mCIMrvY7uM2PePZnE=;
 b=czIrMn/LPyA3r+trWcHC6iT9DFLHGkqkGcHc+JVOLl9UBMdphgUVoodFGbObicM9Q8
 iGGE/lkO5LaYuEtpHoAu/ZuDnSNTuw/Kll61vRHXBzF3CsFGzI7t8JZjEQ2aeU9oYZpw
 hS0UHI0OmV+fH1Wh8oZxCfubAHj8VfO1BZQImIN+rv9s1eHrQ79L4AZpP/1wpWEjRwAB
 FbEkM/rQfWNJaZ1UwnmsjuNI8y9ZkZMYqZwzcgU/PKYWLlcY38Y4C5VzZy5Zhkpq3o8A
 b/FEQjOjpor1UU6znZzI/Z5ce8mZIkiIuOvWF4018Nl8T4n1OYmayidKtvIq53Oav07/
 I24g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688992481; x=1691584481;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cLLp+q7BwdrJGckFD+1rZ6cBN6mCIMrvY7uM2PePZnE=;
 b=QiNiAo3h0pgWXIK8UM2PJui0hX32bdzUf+htyYKqbBw3KWDJAUrnOI04HrHP2UoO6m
 jbNYEXyTtO2p6aVrVi9GdoeWvSrQHdBrE2WnacvtNFtA+6vsULoHmyFn9Vq4SCYpCimj
 0f7eUlK5Bok7FwL5TMd8l5wDjzkbW59+eTAY9Ss4ZKTeYZl21wkM2DXnBXMNGALnDQFX
 zPNRFR3Pi1fEhYxoVJ4hRLQjhkAe9XMyC2NAah0D72c6WDAUgGEaUp7S8dD5KGGM8BTx
 6mwkDDGZkHnsN4QCb6OMUhOGbahUA9nD8pCvnNBQPb6cRVzlqnEuJD6f4gnAp3MddMRt
 GGlA==
X-Gm-Message-State: ABy/qLYjsgaS/6G/idBQJM16ujHkRgeSz8hW5+/2x5MUSdn1OX+5LOPp
 hW36PCk4t5J2lorXzQpWUV7qwV+MmuPnNQ==
X-Google-Smtp-Source: APBJJlFcOlKfLQa6McREjWjuCfLRuE3SePx7apDdtcCWt+Lh4da3AnHyxH+VnePkk+OrOV6WKp8Y8Q==
X-Received: by 2002:a9d:65d0:0:b0:6b8:873b:af6b with SMTP id
 z16-20020a9d65d0000000b006b8873baf6bmr9903831oth.6.1688992481539; 
 Mon, 10 Jul 2023 05:34:41 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 i126-20020a639d84000000b0055b44a901absm181559pgd.70.2023.07.10.05.34.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 05:34:41 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 41/54] target/riscv: read marchid/mimpid in
 kvm_riscv_init_machine_ids()
Date: Mon, 10 Jul 2023 22:31:52 +1000
Message-Id: <20230710123205.2441106-42-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230710123205.2441106-1-alistair.francis@wdc.com>
References: <20230710123205.2441106-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=alistair23@gmail.com; helo=mail-ot1-x32e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Allow 'marchid' and 'mimpid' to also be initialized in
kvm_riscv_init_machine_ids().

After this change, the handling of mvendorid/marchid/mimpid for the
'host' CPU type will be equal to what we already have for TCG named
CPUs, i.e. the user is not able to set these values to a different val
than the one that is already preset.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20230706101738.460804-8-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/kvm.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/target/riscv/kvm.c b/target/riscv/kvm.c
index 7402bfbfc5..d8c1423b54 100644
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


