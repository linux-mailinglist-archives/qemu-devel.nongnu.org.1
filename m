Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B4E97B67F3
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 13:33:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qndeS-0006Aj-4R; Tue, 03 Oct 2023 07:33:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qndeP-00069a-CE
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 07:33:17 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qndeM-0003c0-SS
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 07:33:17 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1c60f1a2652so5990455ad.0
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 04:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1696332791; x=1696937591; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gV+m8svtmPot68FeOXZ+bfhc1uQobNg9HVkxHtgK/qA=;
 b=RDDT+uZPqDJ0Ksj1PhDCeMlLXh5g+IJPrgULXZkr9zmqiWqN0n99dJ9UlD62kRDyZa
 8Trdhcd7IQ1ntp4X/D4qqBn3pJpoK0vDab2xg5COXaIhc44TC7lC0LFbqO3FyQf30yXx
 axXbdH9sjA/N4R635X9C/hHFdG69eWPR5yRpXS9zoJfNzTCcECcpxBl6BKioDeuJfaMZ
 yQ3OTkEl8qgeEjfEt2GslXgwlPPhI+iCA/M4E5gcJLqqW/ofIyYu0l1DSBw0Owhcesur
 voxQXn/6RpzCZagXZIRzki/R9XtUxA7om0IklkbnF92GyM/Y8sd5PVcH2JXU/FViRhTV
 /fRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696332791; x=1696937591;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gV+m8svtmPot68FeOXZ+bfhc1uQobNg9HVkxHtgK/qA=;
 b=c9Ashb8FMW8sWGQ2XGYlgr7tdj3X5IkzjXDIhQ42Bz3dMkISJYTUqG/Js41+Y66L6h
 pgjaHD990lUqf1AYIo9qA9e+6wfdfkt7oV3Ef8H0cp6lq9YEnLMi5f2d4d/xV5JMfLGj
 PT8w3IOv1rKUvlzvUUvIxjUCWZkHuSvIlNSGHdY27E5M6jSirIWrXM0BxLuOXOQ/RnZd
 l181rV92su1PRYHoo5LkBkAvqst/zw31kqKfrKOV5vwYYmrgOVcmRTAQhhRTjC1ska0b
 +1p6AcJ3g6HeJehAMQbwHVUo97lJOQOwZybCAGuGHicLcVUKNvJgc7g4MsnBmKyvB0PG
 +Jqg==
X-Gm-Message-State: AOJu0YywbP9y/CzLgQzmvHjT1R1FceVDh9+6CeAjrqMbXCnCIAalLhmd
 O3yhlmMQbuhaj4BZvNXJKPgJ/JJer6khst638l0=
X-Google-Smtp-Source: AGHT+IE7p18GUpBZ7Hg3IKtl253FzI/aeltXQm1SxqBZh5iTiIgXNl3Z8VC6BOjFujnre9Hnw/0deg==
X-Received: by 2002:a17:902:e5d1:b0:1c3:e5bf:a9fe with SMTP id
 u17-20020a170902e5d100b001c3e5bfa9femr3622911plf.30.1696332791305; 
 Tue, 03 Oct 2023 04:33:11 -0700 (PDT)
Received: from grind.. ([177.94.15.124]) by smtp.gmail.com with ESMTPSA id
 b12-20020a170902b60c00b001b850c9d7b3sm1285506pls.249.2023.10.03.04.33.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 04:33:10 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 1/2] target/riscv/kvm: improve 'init_multiext_cfg' error msg
Date: Tue,  3 Oct 2023 08:32:58 -0300
Message-ID: <20231003113259.771539-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003113259.771539-1-dbarboza@ventanamicro.com>
References: <20231003113259.771539-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62d.google.com
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

Our error message is returning the value of 'ret', which will be always
-1 in case of error, and will not be that useful:

qemu-system-riscv64: Unable to read ISA_EXT KVM register ssaia, error -1

Improve the error message by outputting 'errno' instead of 'ret'. Use
strerrorname_np() to output the error name instead of the error code.
This will give us what we need to know right away:

qemu-system-riscv64: Unable to read ISA_EXT KVM register ssaia, error code: ENOENT

Use "error_setg(&error_fatal, ..." since it'll both print the error and
do an exit(EXIT_FAILURE) in one single call, allowing us to remove
error_report() and exit().

Finally, given that we're going to exit(1) in this condition instead of
attempting to recover, remove the 'kvm_riscv_destroy_scratch_vcpu()'
call.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/kvm/kvm-cpu.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index c6615cb807..847cb2876a 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -791,10 +791,9 @@ static void kvm_riscv_init_multiext_cfg(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
                 multi_ext_cfg->supported = false;
                 val = false;
             } else {
-                error_report("Unable to read ISA_EXT KVM register %s, "
-                             "error %d", multi_ext_cfg->name, ret);
-                kvm_riscv_destroy_scratch_vcpu(kvmcpu);
-                exit(EXIT_FAILURE);
+                error_setg(&error_fatal, "Unable to read ISA_EXT "
+                           "KVM register %s, error code: %s",
+                           multi_ext_cfg->name, strerrorname_np(errno));
             }
         } else {
             multi_ext_cfg->supported = true;
-- 
2.41.0


