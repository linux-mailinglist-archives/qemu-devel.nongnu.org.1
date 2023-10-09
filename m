Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D4A7BD92E
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 13:04:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpo2o-0006XG-Bx; Mon, 09 Oct 2023 07:03:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpo2c-0006MK-1D
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 07:03:15 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpo2S-0003OO-8x
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 07:03:11 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5362bcc7026so7758666a12.1
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 04:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696849382; x=1697454182; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/xL54zgpI4nEx7Yl6kW+m7mCJYstREJ1f9hvJxDP1UE=;
 b=avMliAXbQLZgauO4GnN8+8MXtBsJX1/xEE576ipv6ITdbcaMiobQbD+skZ/Hkoon+v
 VooEb4c8AlGiEIf/p1YmsdYUqvOeKGEU8Db11tw+wrrBQn/vKrrKR5i9ROLW4ZBlDXx+
 cD8zW2k6nN4cowAqj1p+PEt7PwfS+Yw6r9bW9wIKwXpYkeT+Bdsj27kwzk72p/85OrQt
 s2Rctyw2LujFEheeCwNQ+oN3/G7N62tp05f5Q0v/y6NQT74mdO8OXqUB4SBLhlWiS7Wv
 SEQuax3T/aoR7zGS+VGbTuBWdHmFCw5fALN5EPzye3G1iqgjMkX+vLn5ZNgWIqcHA7JR
 o16A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696849382; x=1697454182;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/xL54zgpI4nEx7Yl6kW+m7mCJYstREJ1f9hvJxDP1UE=;
 b=hSv+2bUt3GssOREquXDWm1Xc3KbiY0+cu6ZlXYFAkjee8gkfrygPQUXYPV47hRVa2w
 ZhsuEJVm2Q4YIFnuRsHehAJNXdPmUFukOuM86kUlWNjMknM8TRNBT+EU5jZv2FQPWDp3
 YX3Lvo9EnSYWYuW21UjgIDbxWG31V2DbxAgSPMHYAWH0mH+6kqCCqqTVI+Cfqs5YCAGD
 Bwsu+1bQXT42zKcOx93bLkVyL6C72cxC3nOfqPqt08GcRK0Z8sYf55HbXS2ioeWz3d6T
 y7e62/wN6GD9PBf/e4EYJ2/Lkct4r5pCluw5oLkXqtDXORB7HJsdhvFQJ7lV1DbKgWLl
 tuUA==
X-Gm-Message-State: AOJu0Yw794Q8t4p6dlk8v/xq7EBqVF4hz3ic4hoytqs37E4zZ78+RfoI
 A9dCGi/LRGAf+5oCp/hdT1DIlPU16aVh0+wO4Go=
X-Google-Smtp-Source: AGHT+IEefebTk5Qmy9jCOLkszVMi9NaRJRvfEmB0R/xOj91bCWL6pVDZYQ6gcYX6EXYLDpHaKqT/EQ==
X-Received: by 2002:a05:6402:28a:b0:538:8d4:2077 with SMTP id
 l10-20020a056402028a00b0053808d42077mr12461170edv.13.1696849382603; 
 Mon, 09 Oct 2023 04:03:02 -0700 (PDT)
Received: from m1x-phil.lan (thr44-h01-176-170-217-185.dsl.sta.abo.bbox.fr.
 [176.170.217.185]) by smtp.gmail.com with ESMTPSA id
 j17-20020aa7c411000000b0053635409213sm6014873edq.34.2023.10.09.04.03.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Oct 2023 04:03:02 -0700 (PDT)
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
Subject: [PATCH 3/6] target/s390x: Use env_archcpu() in handle_diag_308()
Date: Mon,  9 Oct 2023 13:02:36 +0200
Message-ID: <20231009110239.66778-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231009110239.66778-1-philmd@linaro.org>
References: <20231009110239.66778-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x535.google.com
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

When CPUArchState* is available (here CPUS390XState*), we
can use the fast env_archcpu() macro to get ArchCPU* (here
S390CPU*). The QOM cast S390_CPU() macro will be slower when
building with --enable-qom-cast-debug.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/diag.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index 8ce18e08f3..27ffd48576 100644
--- a/target/s390x/diag.c
+++ b/target/s390x/diag.c
@@ -77,7 +77,7 @@ void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
 {
     bool valid;
     CPUState *cs = env_cpu(env);
-    S390CPU *cpu = S390_CPU(cs);
+    S390CPU *cpu = env_archcpu(env);
     uint64_t addr =  env->regs[r1];
     uint64_t subcode = env->regs[r3];
     IplParameterBlock *iplb;
-- 
2.41.0


