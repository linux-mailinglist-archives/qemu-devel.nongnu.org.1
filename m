Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DF5738829
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 16:56:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBzF4-00026k-Iw; Wed, 21 Jun 2023 10:55:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1qBzF2-00026A-H3
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 10:55:28 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1qBzF0-0006VM-B1
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 10:55:28 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6686ef86110so2349771b3a.2
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 07:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1687359325; x=1689951325;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nqH3aMkSK9qxiVaw0GmCtUqp8Wyz1u6/ws84JkvNEL0=;
 b=H5ViZUPQw9osR2VXps93zxn8IrqItIFx7TDj6ITC14iT112mUitwZVJMhKkxQ+EKGy
 L+BYQLQnjExqMU7PtP3NAQkInMPsZ3Bkq7Rgb+9JUUyP7x27tpG45eeA3p3DF5GvociK
 B5wmVSz6t1EuoU+W8hmoenwTWRzZJGl9y+OgEVBIetmbBtsDJpe73RO93YV0Lupoo1oA
 PWjeF+DpMAbMTFi15HIiUmq4Xf8eeMfrjFXr2QVcfaZcWgkrDBJG0jrE8u3NubdUOCU2
 bGhpA9noPs1EKDvESlEOpMAAvsIvq8NWlGGK1thwrfmT5eLZrQlvA6bOptW7+9C5+wxR
 F4Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687359325; x=1689951325;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nqH3aMkSK9qxiVaw0GmCtUqp8Wyz1u6/ws84JkvNEL0=;
 b=Aa0hEz8KF1IkVqdwjcz2Jls0A23A9SWVkZcip5+obLhRRbh46UCti85abhFle0wfFY
 omzyPbIzRlPbjTz2LEMBSH+8PPJHp9rSqIc0yS6qI/M2ZHLtPE7uDMEwuvT1pDNYbGaA
 JCJZqDdpdGIQ+rmACplkqSPwhCbEgTpfrX0kVGlIylOFd7PTEWQbAXdIyplTk4wO+NPf
 rReo2UEEJZltHNj5s6mn65CAKxOKNoBj1fFFCUYNBvpk6FQxDQ6veqJWbnR0nQlWj9vo
 mA54CWG18nnqzGV/boGzyTMAOKzl6T66AbxNVlaTquIruUQG9Ry8AbNH5pN9XyYIHLhH
 55Og==
X-Gm-Message-State: AC+VfDxqvN3ek/8vE2TNYgTioTuimrP9DMSJGe7FSf4BcccFxVAOtgO5
 FXu9uT1obj0IOrVFugivd4u/Fi3UyGa2VxnWHFkT0esTN6JQvf9xP8FuHpujIfQUWRFzaDstm6o
 dvh4PoblISxMaMulk+OjmgpYOXU9h0Qhk8Ai8446eZh8lyD7CHWuPJxp73ueKamnpeAZCg0O1jA
 jy27QE
X-Google-Smtp-Source: ACHHUZ5AJbgoi1rYVfa6wEmMT+MdfVPa920a7WoPuofemVbiLB65tBYhIsRWNQD4axPlHfl+4W2h2Q==
X-Received: by 2002:a05:6a20:9144:b0:10c:513d:2bd9 with SMTP id
 x4-20020a056a20914400b0010c513d2bd9mr11519434pzc.50.1687359324631; 
 Wed, 21 Jun 2023 07:55:24 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 v8-20020a62a508000000b0066a4e561beesm356762pfm.173.2023.06.21.07.55.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jun 2023 07:55:24 -0700 (PDT)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: rkanwal@rivosinc.com, anup@brainfault.org, dbarboza@ventanamicro.com,
 atishp@atishpatra.org, vincent.chen@sifive.com, greentime.hu@sifive.com,
 frank.chang@sifive.com, jim.shu@sifive.com,
 Yong-Xuan Wang <yongxuan.wang@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Subject: [PATCH v4 3/6] target/riscv: check the in-kernel irqchip support
Date: Wed, 21 Jun 2023 14:54:53 +0000
Message-Id: <20230621145500.25624-4-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230621145500.25624-1-yongxuan.wang@sifive.com>
References: <20230621145500.25624-1-yongxuan.wang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=yongxuan.wang@sifive.com; helo=mail-pf1-x435.google.com
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
---
 target/riscv/kvm.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/target/riscv/kvm.c b/target/riscv/kvm.c
index 0f932a5b96..eb469e8ca5 100644
--- a/target/riscv/kvm.c
+++ b/target/riscv/kvm.c
@@ -433,7 +433,18 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
 
 int kvm_arch_irqchip_create(KVMState *s)
 {
-    return 0;
+    if (kvm_kernel_irqchip_split()) {
+        error_report("-machine kernel_irqchip=split is not supported "
+                     "on RISC-V.");
+        exit(1);
+    }
+
+    /*
+     * If we can create the VAIA using the newer device control API, we
+     * let the device do this when it initializes itself, otherwise we
+     * fall back to the old API
+     */
+    return kvm_check_extension(s, KVM_CAP_DEVICE_CTRL);
 }
 
 int kvm_arch_process_async_events(CPUState *cs)
-- 
2.17.1


