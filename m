Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C71587BD929
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 13:03:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpo2z-0006ep-Tz; Mon, 09 Oct 2023 07:03:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpo2i-0006Pn-BV
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 07:03:22 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpo2e-0003QZ-Tl
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 07:03:19 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-9b29186e20aso752256966b.2
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 04:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696849395; x=1697454195; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1+J1wI69+igLibXDQf0PHgHIzLfY8D41JYZfyX16+G8=;
 b=ecKA4V1F9DPFs2cwjQ8AZKNzG4WOYVOH9X1FZpaV4IShxeIXvgSeDINqWXqYU8N/bq
 Lx5Qd0nQfPmG7MmfQmYO96C45YrDzxFuFxUYRc4VFXrg8otxwpYjRP9hymX7vntH3BfI
 /ibdVEnZDFTMpVDi25+7p+hsOZAHp2TYOXfmKepyt8bHJAFrTmHr0CO6D8pCwzFtJXnm
 XaLPjI3Cvnpo8QLaPGrS6/drLMWgSMrtfFGRQdzA2ZOrp7VL4Ba8JN20H1T4zWL1qOFH
 RLXYQEKdVvQKnqaHewoUAJK93xXY4USRW5a0kF2krnJdxT2kgw+VHICVQs7qSo1zkwRZ
 N8jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696849395; x=1697454195;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1+J1wI69+igLibXDQf0PHgHIzLfY8D41JYZfyX16+G8=;
 b=MwLwpSsAEZ4R5qbuUV9ekHR65asazgb4a1eOnb9cv0ZBXmID2nFL0vV/9BZpOIOOUM
 W+5xKofbJYeKKK2irgFkPlc9Q0QwEI0CWCqi94xKGunJhnCyTHT0G75E2jNsuhWUQXKO
 hy5iiJHtDSNXOIdgp0IZCeI3WxhkDGAVf9TaqrSUBZg7VhOkP3tnoQdiyslzzu8eCtjx
 R8HdBNjs+l5tj+vZvtk0GYBWAy4R+odEq2mNQ5zqfV8dAsXuP4Cv+Ek/2miJ/PNRyaMQ
 GyJlAKuBc4OFSO/khTG4FoCnyc+opHhzaVDb1ktthDdLI19t9B7D6stYquXpi6DY6UD2
 GWcg==
X-Gm-Message-State: AOJu0YzRJ+QC3W4RZyAEVCRmBkf/KVm8rypG+hLFH4DBjvW5rlf+uifZ
 2ykclSDaf6vlowj3nR0y+vxF9haZ9naYonjlaOw=
X-Google-Smtp-Source: AGHT+IEnwQIfXK0PSpcUquHgDcrZc+NXC/pJVOCtuYwXpIu5y20njwFFRWuyfel+p9KZo0y0JdqV8Q==
X-Received: by 2002:a17:906:3081:b0:9ae:73ca:bbad with SMTP id
 1-20020a170906308100b009ae73cabbadmr13579817ejv.43.1696849395170; 
 Mon, 09 Oct 2023 04:03:15 -0700 (PDT)
Received: from m1x-phil.lan (thr44-h01-176-170-217-185.dsl.sta.abo.bbox.fr.
 [176.170.217.185]) by smtp.gmail.com with ESMTPSA id
 n17-20020a170906379100b009b957d5237asm6543236ejc.80.2023.10.09.04.03.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Oct 2023 04:03:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 qemu-s390x@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Bin Meng <bin.meng@windriver.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Cameron Esfahani <dirty@apple.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-riscv@nongnu.org,
 Max Filippov <jcmvbkbc@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 5/6] target/i386/hvf: Use x86_cpu in simulate_[rdmsr|wrmsr]()
Date: Mon,  9 Oct 2023 13:02:38 +0200
Message-ID: <20231009110239.66778-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231009110239.66778-1-philmd@linaro.org>
References: <20231009110239.66778-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

We already have 'x86_cpu = X86_CPU(cpu)'. Use the variable
instead of doing another QOM cast with X86_CPU().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/hvf/x86_emu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/hvf/x86_emu.c b/target/i386/hvf/x86_emu.c
index ccda568478..af1f205ecf 100644
--- a/target/i386/hvf/x86_emu.c
+++ b/target/i386/hvf/x86_emu.c
@@ -676,7 +676,7 @@ void simulate_rdmsr(struct CPUState *cpu)
         val = rdtscp() + rvmcs(cpu->accel->fd, VMCS_TSC_OFFSET);
         break;
     case MSR_IA32_APICBASE:
-        val = cpu_get_apic_base(X86_CPU(cpu)->apic_state);
+        val = cpu_get_apic_base(x86_cpu->apic_state);
         break;
     case MSR_IA32_UCODE_REV:
         val = x86_cpu->ucode_rev;
@@ -776,7 +776,7 @@ void simulate_wrmsr(struct CPUState *cpu)
     case MSR_IA32_TSC:
         break;
     case MSR_IA32_APICBASE:
-        cpu_set_apic_base(X86_CPU(cpu)->apic_state, data);
+        cpu_set_apic_base(x86_cpu->apic_state, data);
         break;
     case MSR_FSBASE:
         wvmcs(cpu->accel->fd, VMCS_GUEST_FS_BASE, data);
-- 
2.41.0


