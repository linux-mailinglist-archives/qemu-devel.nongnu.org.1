Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4A8C0D15E
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Oct 2025 12:13:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDL9T-0005wN-ML; Mon, 27 Oct 2025 07:12:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vDL9J-0005fw-BU
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 07:12:29 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vDL98-0007bS-Iu
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 07:12:29 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-63c0eb94ac3so8012794a12.2
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 04:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761563532; x=1762168332; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WOQRbM60FQe2Gg4TBOEVmKU1rzcMDNuOtCzGhYSu6Hg=;
 b=D9yrHUZozII8lBJ54xpM6x0256JhtSKHpgrhOfN/mlXPCutadiB27RBOUtWWKt6FXF
 SkJztFa+qGuw9iSwxXNU4Vv/IaXjGZ6uSgkggRi5zgs233QdICBsYKSCXTNt6R0aqfro
 RQGEzLcCFOa75pg01vslor0aR6MVeIvWZnucUVrljrFr30WVnZgYELVdoHKh57gcI9WH
 qkJRk/XzTn5IZ0DfCxkwlQLh7kzBrqVeiOK1wWEvqjTx4qkOqDoEri+GSGb5Ul9RT00H
 FuryH/3Y17XyRqj3P3hnNzfIrSJGbnHg0f+cuWgTvsjnFkXTCl+zNdJDNM0KuEtr1A0a
 NCRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761563532; x=1762168332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WOQRbM60FQe2Gg4TBOEVmKU1rzcMDNuOtCzGhYSu6Hg=;
 b=oDBf0WHCG5MRgNDd5Z0AZqITB2gDWk8Je+nosep2Roe5i5yqXO2iTAQ0mfplsVPv2h
 CkTDTaV4Y6t5J5WXRBMqucNd6FDpEKqNGmNoCQMlQyWL/4YwO9E1xDKHcASH3qSyYmsb
 syBzqT3OJtWFIyP/KmjS0lVf66lBlTFn9kNPe8DfuzJfU8YNEMes+wecclfnQBWFzPoR
 mbQX48US6yd7PhJAv7s4ZlTO5H2Sof9k0ym68v0uW301TnGObMEnyCcW7omBlr+hfLLl
 LWDboAUbXhM+BvTLoOCYSXRMeAEJZ/3VB1JjgRKjDjgHUmcFYBnd7YFpXaxNDGGhS+mi
 Ooxw==
X-Gm-Message-State: AOJu0YxctUatYLl+Bd6WHHP4ID6ASZoPYMA96e62U0RtQg6XoqCESAgq
 x5XliTj6EwK8WNdOK+pzuiHJFAuu04TgnMsxKHJ3YmOaS5h9N7CDIxHDgEgJbRqn8qY=
X-Gm-Gg: ASbGnctB5RmHgLSrDvvANSm+ZsvTzHr4oxRT6LpZ/2x0YnFksTetLojZimiNwDhYcCO
 zA0lF5zGGDuNMF0iYhMjPgILt8Af3aUb/4/2e6zE7djzc6h28a1jC+dr6iDQl//LlA7IyJlDmm5
 QUqB6cPTrcxvoNF38u12eeeUwGp0IPVQJvYd61vE4z+JTpQBzlKrBf6/SZESmgI3s4c7Ys5pGgo
 D8uZUN/FdT0ETsKer/n00y4GYcNziDPnf7GWejIu8Vdhgo3eekbjCVRvxkIEzsj2dEUUsjnqrod
 LzjuYrAuG0iwHo1PLOPd1mkyHZE4nhxgyA68Q4p5VZahBfDcG38bX82DcXGSWpgD67YdScBodRu
 9xpnxfbw3qk29rx/YD2xnkfUcdW0WsSEXfWWNTjl7UNbKfDBQ/VrBur3cW4okJozOwtK8WTThAY
 kbb2T6ty292ys=
X-Google-Smtp-Source: AGHT+IH4PDPfoknGAMNh6qUlBg4iUvE8gsQC5JitQIK3kaMz6NHG7UP3emaCgcbIBB99Qsiw0VvCFg==
X-Received: by 2002:a05:6402:34c5:b0:63b:f5cb:e1fa with SMTP id
 4fb4d7f45d1cf-63c1f64fd4emr33960935a12.11.1761563532196; 
 Mon, 27 Oct 2025 04:12:12 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63e7efd0fabsm5738233a12.34.2025.10.27.04.12.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Oct 2025 04:12:09 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 28AE360DA5;
 Mon, 27 Oct 2025 11:03:46 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Chinmay Rath <rathc@linux.ibm.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stafford Horne <shorne@gmail.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Laurent Vivier <laurent@vivier.eu>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Michael Rolnik <mrolnik@gmail.com>,
 Song Gao <gaosong@loongson.cn>, qemu-riscv@nongnu.org,
 Aleksandar Rikalo <arikalo@gmail.com>, Julian Ganz <neither@nut.email>
Subject: [PATCH 22/35] target/riscv: call plugin trap callbacks
Date: Mon, 27 Oct 2025 11:03:29 +0000
Message-ID: <20251027110344.2289945-23-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251027110344.2289945-1-alex.bennee@linaro.org>
References: <20251027110344.2289945-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Julian Ganz <neither@nut.email>

We recently introduced API for registering callbacks for trap related
events as well as the corresponding hook functions. Due to differences
between architectures, the latter need to be called from target specific
code.

This change places hooks for RISC-V targets.

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Julian Ganz <neither@nut.email>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/riscv/cpu_helper.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 360db133e21..c4fb68b5de8 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -36,6 +36,7 @@
 #include "cpu_bits.h"
 #include "debug.h"
 #include "pmp.h"
+#include "qemu/plugin.h"
 
 int riscv_env_mmu_index(CPURISCVState *env, bool ifetch)
 {
@@ -2175,6 +2176,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
     uint64_t hdeleg = async ? env->hideleg : env->hedeleg;
     const bool prev_virt = env->virt_enabled;
     const target_ulong prev_priv = env->priv;
+    uint64_t last_pc = env->pc;
     target_ulong tval = 0;
     target_ulong tinst = 0;
     target_ulong htval = 0;
@@ -2197,6 +2199,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         case RISCV_EXCP_SEMIHOST:
             do_common_semihosting(cs);
             env->pc += 4;
+            qemu_plugin_vcpu_hostcall_cb(cs, last_pc);
             return;
 #endif
         case RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT:
@@ -2466,6 +2469,12 @@ void riscv_cpu_do_interrupt(CPUState *cs)
                         prev_priv, prev_virt);
     }
 
+    if (async) {
+        qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
+    } else {
+        qemu_plugin_vcpu_exception_cb(cs, last_pc);
+    }
+
     /*
      * Interrupt/exception/trap delivery is asynchronous event and as per
      * zicfilp spec CPU should clear up the ELP state. No harm in clearing
-- 
2.47.3


