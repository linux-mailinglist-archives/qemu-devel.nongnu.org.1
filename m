Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D34751C04
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 10:45:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJrw9-0006No-OK; Thu, 13 Jul 2023 04:44:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1qJrw4-0006MO-9h
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 04:44:30 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1qJrw1-0006yl-0o
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 04:44:26 -0400
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-38c35975545so497165b6e.1
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 01:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1689237863; x=1691829863;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bRqQKtep7JWLgclLdUkli6/fChTnwWs+kTdTq5m30jU=;
 b=CTlKktPs+hY0cgE7CS2PUANVjOXYIGn9DpU2fh7mMW2HZEQy1ymS0r+QkdZU1bdjGB
 P2H/jtF17Wexhc+P++LOh0FtkHw9ToVJYYkmJ2R+46Pq+yCVcBYwEa6sNddZeYTAQG93
 F9Re91F5WlS3VTETLFEyPWpb8ZNnRWYnopTN/k1Y1tVgM4Q3WhYSiZEb5INzk1ZCWmZy
 Ht6uHxlWh/bDhXre4KQ3q292Ebz8ayR2ctMZrSgTwIWEJnL9HCOIKtH7CssMxSprI1gQ
 basdybVGjqRuPOKpJ+sCLh4s5/DYF6oxFOrVQwIq/hKuKNAcy/cCYqRf8VrmJrBEBlX/
 xwhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689237863; x=1691829863;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bRqQKtep7JWLgclLdUkli6/fChTnwWs+kTdTq5m30jU=;
 b=JONJNMCwiO/Ues9F/bZGJKEcLQEbIrM1aMcEcpRRHoSuE59iOr11Ma9OxBl4aSE36a
 syBTh2A4kF+9+s3WRRnBbpvy1AgI7zpN2XgdMVvIIf+At2CthlcFNQn71sVTfk1yEQND
 xHer2KdCnJqQTODAz5hnzxYJ5pOwzXVQ4eE5YJ5o0SyIteardJol09jQp2HD8Vhse1s9
 aPnhSTiRNhyVfmg/0XbgHniu9phf+dg8FrXAhwc9klilxu94vhjcuOaco8FKS6VHO8se
 ScJsLWKdD1AUG9lVwb+ZvALsePYzxMNfOmOvRAkYAZxinbx1WfwmyKQOPgBCq2SmCfdb
 316Q==
X-Gm-Message-State: ABy/qLYz0IcHhw7caD7gRyIp0n0t3pdTtF6+TvJCWFoUJA6wZFDL6KUW
 avZO3pu3OuubMq98QsdzpUWUhlzeny5YrQ8JrdewcSynqC5mliwCq0IcCEO66nZXGPM68B2exYb
 sRX9vV9/2R8GuR/reFnKJ6LqELeuxsW6h/Q2HnhhP860LeHAMcYEJv/Jcnr3N/AdJwDDQrcXZ6w
 aUo+LB
X-Google-Smtp-Source: APBJJlEwvjQxj7TZ0LJFULoNQDbfGWViUSUPEKbUpl3Uk7rotzEbi31NqIdsDVgZwphMV9Wf+7w6Vw==
X-Received: by 2002:a05:6358:70d:b0:133:26e4:afb2 with SMTP id
 e13-20020a056358070d00b0013326e4afb2mr2045730rwj.3.1689237863041; 
 Thu, 13 Jul 2023 01:44:23 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 c10-20020a63724a000000b0055386b1415dsm4989198pgn.51.2023.07.13.01.44.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jul 2023 01:44:22 -0700 (PDT)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: rkanwal@rivosinc.com, anup@brainfault.org, dbarboza@ventanamicro.com,
 ajones@ventanamicro.com, atishp@atishpatra.org, vincent.chen@sifive.com,
 greentime.hu@sifive.com, frank.chang@sifive.com, jim.shu@sifive.com,
 Yong-Xuan Wang <yongxuan.wang@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Subject: [PATCH v5 2/5] target/riscv: check the in-kernel irqchip support
Date: Thu, 13 Jul 2023 08:43:54 +0000
Message-Id: <20230713084405.24545-3-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230713084405.24545-1-yongxuan.wang@sifive.com>
References: <20230713084405.24545-1-yongxuan.wang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=yongxuan.wang@sifive.com; helo=mail-oi1-x234.google.com
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

We check the in-kernel irqchip support when using KVM acceleration.

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Reviewed-by: Jim Shu <jim.shu@sifive.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/kvm.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/target/riscv/kvm.c b/target/riscv/kvm.c
index 9d8a8982f9..005e054604 100644
--- a/target/riscv/kvm.c
+++ b/target/riscv/kvm.c
@@ -914,7 +914,15 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
 
 int kvm_arch_irqchip_create(KVMState *s)
 {
-    return 0;
+    if (kvm_kernel_irqchip_split()) {
+        error_report("-machine kernel_irqchip=split is not supported on RISC-V.");
+        exit(1);
+    }
+
+    /*
+     * We can create the VAIA using the newer device control API.
+     */
+    return kvm_check_extension(s, KVM_CAP_DEVICE_CTRL);
 }
 
 int kvm_arch_process_async_events(CPUState *cs)
-- 
2.17.1


