Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5820575354D
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 10:46:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKEPy-0006QD-33; Fri, 14 Jul 2023 04:44:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1qKEPv-0006Po-WB
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 04:44:48 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1qKEPu-0004KC-Ic
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 04:44:47 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-6b91ad1f9c1so1339590a34.3
 for <qemu-devel@nongnu.org>; Fri, 14 Jul 2023 01:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1689324284; x=1691916284;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GfEVzfDMM3KV/MRFcXCu/fGQgJk4J1J61XVMjT70iMs=;
 b=e1yvwM1JnNOK5nmqmWByk3B6LXVJm4gsB0kJJZ93hMZynFWSjhMxwqLzsiDycAqsTS
 Ho45m6z2X0Qdy4obZJOdTzMMbJlyFvdYAQ/vR+xO+wNFVGjMEcqa7Gg64XnQXbV2VJc/
 hBDMNfOHTWFMphIHhbHberq8PAmG4bsnXX0yqUcKAsiiTYEj+dUm3LklVxRp4xVwBGTk
 nNohUxYuTc9bJGAZa3gmBuLvkrxlJZFO2hN50SMmpNS+2Xe51PuBbs9e62Gg8OOiJLuk
 ll9OSDidlJP9k6yMF4SoZfT+5GsUcQBa3boApro6qXRm/p0sC2S9FlrP5qv7DHNUSxcB
 RWhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689324284; x=1691916284;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GfEVzfDMM3KV/MRFcXCu/fGQgJk4J1J61XVMjT70iMs=;
 b=ad8YycQvTqkvLFVqFt66uhh7yjljtSofWLnqeOTC62XhB3xjOYR24hDF08h6hxBJT3
 MXlIBVBVSEYzKM2kM5aN0WydvErSjakfNB3KK2azZjLVdXaOVRevPOwvaohI0ox4iz94
 9okA7KJbTJId3irR7BUO2/D3koolvyJZLAfuJMVYjKbQZOmGxPS7t47EsLX97Ra/cjFV
 MfEuxZC5b/nVRbeAk0r10guk1P6c9I9rNFyB0BjQk8LfIsESXHj7RfWWxZVwB6fLOnEE
 e6lsnGyt/rChvaUV6sPcjsto5b59xqUVf+kL1hKaxSA3bzLUL0OG/S8FjBO9+/Mk+21a
 70qg==
X-Gm-Message-State: ABy/qLaii1o/DgGWlKcCCueXiml5IyCbgfNx6aIukK15tnI2YTGbCWJe
 Cd4C4lKUC0A2P9jwUEEaFzxPg1tkLhdtv4TXYzNR4P+GNoqkIfdpGW11GQ3ZcIW0Q8zTW7tX5SD
 4MI47Y8iIVaLmwXr9OPzXmwMAsTZFSzYfF3ac8ngJ1H+sSduAVU4neXir2ajfF1DW3uKoKcr1EI
 LkC4/2
X-Google-Smtp-Source: APBJJlGarhaXYAwO0vEVi4wHfBWRjjM8l1WYOGhZJum/Z7QpEgy5OtqK8hLRoFYfq0TSANWd/P5IZQ==
X-Received: by 2002:a05:6358:714:b0:132:d0d2:7cdf with SMTP id
 e20-20020a056358071400b00132d0d27cdfmr4341137rwj.6.1689324283922; 
 Fri, 14 Jul 2023 01:44:43 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 c19-20020aa781d3000000b006829b28b393sm6616305pfn.199.2023.07.14.01.44.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Jul 2023 01:44:43 -0700 (PDT)
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
Subject: [PATCH v6 2/5] target/riscv: check the in-kernel irqchip support
Date: Fri, 14 Jul 2023 08:44:24 +0000
Message-Id: <20230714084429.22349-3-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230714084429.22349-1-yongxuan.wang@sifive.com>
References: <20230714084429.22349-1-yongxuan.wang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=yongxuan.wang@sifive.com; helo=mail-ot1-x334.google.com
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

We check the in-kernel irqchip support when using KVM acceleration.

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Reviewed-by: Jim Shu <jim.shu@sifive.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
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


