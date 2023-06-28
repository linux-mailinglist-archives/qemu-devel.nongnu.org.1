Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CA5741B00
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 23:33:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEclA-000294-4a; Wed, 28 Jun 2023 17:31:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qEcl5-00027P-Bq
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 17:31:28 -0400
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qEcl3-00084p-Os
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 17:31:26 -0400
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-56597d949b1so292236eaf.1
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 14:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1687987884; x=1690579884;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zsw0pJ1ZMaa7pJqxBp9+XWOi9ryOdYncMUElEND8Y8o=;
 b=kyQK/YTsrh/WmEj6I/YnsbjccVlqtiEVUy6xajB3VPA0zb4XBIn5sgM706svEH5Go4
 8dyvcgXAgDC+SKJfVbE9/6+uaNfXSC8fyloDVnsobk0cBAeNinM5TaUXW+tTWoQ+qqlJ
 C7ounHRLHR1bZBdRLMo7OQdZ6vpUjsW8gOuXnfqHnOjGEtyu4m976EN9/biupg7tXNCz
 uzV4m6yBsxmBFh2pGXBJ9W5XsGAIznstlKu+VYZ6AGVdo/qt/UDvLsOP0Ikbr5C8Pck/
 x6pohjCh0DguxLRmWP8PF4OOhnImMGzRqtxV2BO34ul6PBdT7JDPf0PTYwkZUWEh5tSv
 wiag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687987884; x=1690579884;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zsw0pJ1ZMaa7pJqxBp9+XWOi9ryOdYncMUElEND8Y8o=;
 b=S3fqj9qNCXxpgfsPW8hkPYZFqQyCSPSilmo3n4Nr6YxbCdPdgJSQR9bkh78M81RpZF
 jp2MHvuD42vIAHzvOrcSJlmI1YgnOKayNNxdf6KiROLExl9/Vre7lG6fE4tHf+ts6N+C
 vJbODGncBQ0QfwnRWyOr7Hr53QostWaX4M6+gefyzXwK5nEzS1Y43wSmfhwWZRqjCvML
 vn0STowIG/Fngo+LfAF3mb9zTKXXEEjpLF7IonaRBZGbE/IOBCmyp7ogHwDI+WbM5Akl
 J13R6kcgd5HenTtddkXOfxXZa7tHcL216GKl3xL8PIAV2BPIdhXOjSgfp0KTKakBV3pY
 xS/Q==
X-Gm-Message-State: AC+VfDyivwrEedwKvq5Rhwh7Qna0lYqwPl6KsouMS1G+8ztsmw/ol3qq
 W7q9FG7YHJJ32tbabgjB+u9spnJ/ZYKI4zv/yNY=
X-Google-Smtp-Source: ACHHUZ7ma3u63LdWigthFSdh7vsxC461vF7PEhkNL7Ibbiq1xIuELJ9aie+OWUNT3s2XnEyqgSIH5g==
X-Received: by 2002:a4a:e1a5:0:b0:562:f872:3b8c with SMTP id
 5-20020a4ae1a5000000b00562f8723b8cmr15604351ooy.3.1687987884291; 
 Wed, 28 Jun 2023 14:31:24 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com
 (201-69-66-110.dial-up.telesp.net.br. [201.69.66.110])
 by smtp.gmail.com with ESMTPSA id
 y17-20020a4a4511000000b0056084a91c74sm832892ooa.24.2023.06.28.14.31.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jun 2023 14:31:23 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com, philmd@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v6 07/20] target/riscv: read marchid/mimpid in
 kvm_riscv_init_machine_ids()
Date: Wed, 28 Jun 2023 18:30:20 -0300
Message-ID: <20230628213033.170315-8-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230628213033.170315-1-dbarboza@ventanamicro.com>
References: <20230628213033.170315-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oo1-xc2b.google.com
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


