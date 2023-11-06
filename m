Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B9F7E1F6F
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 12:07:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzxPw-00085d-GE; Mon, 06 Nov 2023 06:05:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzxPo-0007tU-6v
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:05:08 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzxPl-00040C-6A
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:05:07 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40907b82ab9so31025645e9.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 03:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699268702; x=1699873502; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RkZROkW3VJc36/l321YGkxp/mj9LkNXWejNsMfklYm4=;
 b=M0jyDKDuA29/C5IXYxKTLsJAiQuNekWnXhzb70fveFPwlNltGzICV1WS5yJTA1F0YD
 911Hbxzw9s9vdh6MYv6JjslYwQpqZLIyaeSwv7BrxLinpsWvtglAr8ctVz/Qtk/nCyr1
 uZdXSYjox5cCzfnCkYv5JjPcB1X1M3lNKrpPV6d4LMUbkyA1Wzgg+m2IZk8m3OF08fSW
 oZvNXOw9qG+wHH65zbdKEVs0ZlcAnmo59BOjjkX7Ya6+g3/GlHeOSwNko1L4mFIl29rS
 bUG4+oNr78LJW/rXCKxKSeV4MoLxnyLYLlqO3mNzlkjgxdkUWTYLGFYoJOTU9aFJnp5b
 eQHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699268702; x=1699873502;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RkZROkW3VJc36/l321YGkxp/mj9LkNXWejNsMfklYm4=;
 b=MoV00E0zhVGZtrKLbUMc5ouCgmoomuyJJQ875mrd1M9W45U3Vx0dE7Ikf2o+sP4Gxn
 dph4Dv/hZuDBtw9/17MKuXFiSNyVKHBxHRsPVEsrupdKhrAleGTyus1Ge4kfiKCarg4X
 HIGdukDzWT2K50jQNNJTvJd0jh/OuJtCc9J0cIu0phhbm4puQU2wjwpEcKt3zhwjR9f7
 ph/amDbXNSY4qLEbuQV/0FmdZgPmSUJ0xSLtt1nTvohFPQeVrIPl8CpO4ULVJ3oySakw
 I3IOXAAqH6YBuls0yLltzXnFFUHjstyrdh9pP76Jt+CEntYAXJ+fBR1625w+S6UHV/ew
 WwaA==
X-Gm-Message-State: AOJu0YzSwG9pqUst757KSFAQMnNxQ+vXkTu+VstVVwZMJGdOYyZrQh2U
 lrR/hGtmt8OpI3CSlpyuqW5U8vUhwneYS6hum04=
X-Google-Smtp-Source: AGHT+IGPi0CoBElw4e4e166oDDPnxqGeqjewSbN0jbUXOO8Wcvzxylrv4M0+O34JS3v7Ej+kyRAkyA==
X-Received: by 2002:a05:6000:1845:b0:32d:a431:9045 with SMTP id
 c5-20020a056000184500b0032da4319045mr10462910wri.30.1699268702575; 
 Mon, 06 Nov 2023 03:05:02 -0800 (PST)
Received: from m1x-phil.lan (176-131-220-199.abo.bbox.fr. [176.131.220.199])
 by smtp.gmail.com with ESMTPSA id
 k9-20020a056000004900b0032dbf26e7aesm8956250wrx.65.2023.11.06.03.05.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 Nov 2023 03:05:02 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-s390x@nongnu.org, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 12/60] target/riscv: Remove CPU_RESOLVING_TYPE from 'cpu-qom.h'
Date: Mon,  6 Nov 2023 12:02:44 +0100
Message-ID: <20231106110336.358-13-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231106110336.358-1-philmd@linaro.org>
References: <20231106110336.358-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

CPU_RESOLVING_TYPE is a per-target definition, and is
irrelevant for other targets. Move it to "cpu.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20231013140116.255-6-philmd@linaro.org>
---
 target/riscv/cpu-qom.h | 1 -
 target/riscv/cpu.h     | 2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
index b9164a8e5b..b78169093f 100644
--- a/target/riscv/cpu-qom.h
+++ b/target/riscv/cpu-qom.h
@@ -27,7 +27,6 @@
 
 #define RISCV_CPU_TYPE_SUFFIX "-" TYPE_RISCV_CPU
 #define RISCV_CPU_TYPE_NAME(name) (name RISCV_CPU_TYPE_SUFFIX)
-#define CPU_RESOLVING_TYPE TYPE_RISCV_CPU
 
 #define TYPE_RISCV_CPU_ANY              RISCV_CPU_TYPE_NAME("any")
 #define TYPE_RISCV_CPU_MAX              RISCV_CPU_TYPE_NAME("max")
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index f0dc257a75..144cc94cce 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -32,6 +32,8 @@
 #include "qapi/qapi-types-common.h"
 #include "cpu-qom.h"
 
+#define CPU_RESOLVING_TYPE TYPE_RISCV_CPU
+
 #define TCG_GUEST_DEFAULT_MO 0
 
 /*
-- 
2.41.0


