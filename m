Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 599FC7AF473
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 21:51:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlE4p-0003wS-GC; Tue, 26 Sep 2023 15:50:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qlE4d-0003ta-NY
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 15:50:26 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qlE4W-0001YN-TO
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 15:50:19 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1c5c91bec75so68517025ad.3
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 12:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1695757815; x=1696362615; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mrIhG7cIMde6t60jVzVbSGs2vVGh5gLL5jJ9lmN+bHs=;
 b=M792Ecq2XVc/r4YDENyG7pIdiABz92f+THV24k16MUDN0AlPU2UH0PTcrPdo9gYi7t
 /QXDdgaSU3rQoKRmzetDLM1NWx5+LfhDo32NKvbx0s6o0UcxJGK5nBWPYqoT//1GfWgn
 uzIlsIFbtfvLx5+/BmKgg+6HUKVoXYuoSgpjWIcpolWRG2kfwCfRRg6J8AbOK/1G5S9n
 NUqJDOA7YGTMM7oGIBI1HMrIumFOYptUrj/RYkndcXT/sFa1J54DfwNwKUecZc9sIHIh
 Liav+Hjq8pZaqqerOUiquU4A1NSuQeGGRa1JXpPdFS08XhH+b1pwGB9iKW9ib7RcmbCh
 s4Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695757815; x=1696362615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mrIhG7cIMde6t60jVzVbSGs2vVGh5gLL5jJ9lmN+bHs=;
 b=aTYv0ZC6/UDHaeWUhaoNo07x7UXFdOhupgj1vq73C2C5oc4ak6s9+gV4d5n6+fBDmb
 AU05tDuJ/fitZeIFacIXwZHJ4/hbpfCxB39TSR4wL2YRuf/YdiLC57glQkRDERLQukDo
 ZXTcpy5jhCpsWvFq07z4h3TEzQeVDfMmTKseiFvJjPi7q6lyM7eXr4Bmui42LLkv0mJn
 YEYXH1m1PKxwJng8iX03KKZg9mFNYWuPNG0Wrlv+HnDNR0LQnGD1ZdNlKWhvphiAk4N0
 kZF2Z/iUhRTgy9gVQY3VZ7SNxBZEEW5TKNzYK1o73iO/C/J3Ad/GHw/4H4MdraRdpXJh
 78Ag==
X-Gm-Message-State: AOJu0YzkHS96YaGiSKI+He++/7U8yvkyczGpYSPIfx4OAriA9x4fDeG2
 kWsn/TT+HWiW8JLjSXOyKBsuAhFUfU13H14Be7Y=
X-Google-Smtp-Source: AGHT+IG33Ia6xAH5hjcFh5WkevXKREynQycTG6Ly8PZUIl4+fzpe8rfTqyT3JdTEXnSeiOQcxly4mw==
X-Received: by 2002:a17:902:8341:b0:1c5:9d28:b2bb with SMTP id
 z1-20020a170902834100b001c59d28b2bbmr7112219pln.33.1695757814977; 
 Tue, 26 Sep 2023 12:50:14 -0700 (PDT)
Received: from grind.. ([177.94.42.59]) by smtp.gmail.com with ESMTPSA id
 l6-20020a170902f68600b001c41e1e9ca7sm11386010plg.215.2023.09.26.12.50.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 12:50:14 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 6/6] target/riscv/kvm: add 'rva22u64' flag as unavailable
Date: Tue, 26 Sep 2023 16:49:50 -0300
Message-ID: <20230926194951.183767-7-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230926194951.183767-1-dbarboza@ventanamicro.com>
References: <20230926194951.183767-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x632.google.com
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

KVM does not have the means to support enabling the rva22u64 profile.
The main reasons are:

- we're missing support for some mandatory rva22u64 extensions in the
  KVM module;

- we can't make promises about enabling a profile since it all depends
  on host support in the end.

We'll revisit this decision in the future if needed. For now mark the
'rva22u64' profile as unavailable when running a KVM CPU:

$ qemu-system-riscv64 -machine virt,accel=kvm -cpu rv64,rva22u64=true
qemu-system-riscv64: can't apply global rv64-riscv-cpu.rva22u64=true:
    'rva22u64' is not available with KVM

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/kvm/kvm-cpu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index c6615cb807..258e360422 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -358,7 +358,7 @@ static void cpu_set_cfg_unavailable(Object *obj, Visitor *v,
     }
 
     if (value) {
-        error_setg(errp, "extension %s is not available with KVM",
+        error_setg(errp, "'%s' is not available with KVM",
                    propname);
     }
 }
@@ -438,6 +438,9 @@ static void kvm_riscv_add_cpu_user_properties(Object *cpu_obj)
     riscv_cpu_add_kvm_unavail_prop_array(cpu_obj, riscv_cpu_extensions);
     riscv_cpu_add_kvm_unavail_prop_array(cpu_obj, riscv_cpu_vendor_exts);
     riscv_cpu_add_kvm_unavail_prop_array(cpu_obj, riscv_cpu_experimental_exts);
+
+   /* We don't have the needed KVM support for this profile */
+   riscv_cpu_add_kvm_unavail_prop(cpu_obj, RVA22U64.name);
 }
 
 static int kvm_riscv_get_regs_core(CPUState *cs)
-- 
2.41.0


