Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA0873EF28
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 01:22:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDvVb-0004cT-DS; Mon, 26 Jun 2023 19:20:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qDvVZ-0004br-2l
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 19:20:33 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qDvVX-0008QC-G8
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 19:20:32 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-991e69499d1so122028066b.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 16:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687821629; x=1690413629;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W8NcuMKsIMVo8BKREArVzU5buwOf6lSqGWRgcZxHDMo=;
 b=fZ2pvKsGyFxNgeT02+WdLzkxKUwAjAzExJxd4w2IJztwMnPpGCFB10lidiEf/gbras
 AVKOILkyfsYXfQMGtjMABw0KZ9U71yOc3kinySzqFE/3nSgldUfCFM7zcz/qHWQbspjI
 pFr2ibiqKiz1lPMPmTCloL+mGy971cFwf3J1qcaMaUrnalInUVYV8we3A/W3v7aYl1Bj
 U4dOJOU7lW2+5MggUR5bAMwfXtrK1yy6nTHwPhicLb2nFSSd31s8vP/qd7LsHp3U1ecz
 KU7JF7PvcKEECU9u5aOABsISkf9psY22ZvGaHVP0EcGtEoPQ5vA2hfXb8mmh7uwnn+aA
 yvGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687821629; x=1690413629;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W8NcuMKsIMVo8BKREArVzU5buwOf6lSqGWRgcZxHDMo=;
 b=A8hW2ise/HZdoyqA8RqXVOjQqHdMbKPxM+DJHIR/vIGxZAVGyJrpntQnfgBCCuQlHz
 wlUAPH15tACMWwRULggCALlSA7u3frghN8qc53yoPmeGQUEQJlEiZt0526RY0bYpo9AW
 hOKFQ6p/xYbEG8qVN5GINKsmPJAFCzJBjBSU9kdLF/chpMsfOoYViCqIqV6rUSN7eJ2D
 7zwJ+3G5v8pZrLC0DX5imJFyibYsp0IfB/ieafXhPbPyVHvuXwkAXFYG1N1SIbGnGI6U
 hJcoKpD2YReZHFKYU8ZtKUxQnO8zliP8+dJ1P5PapbpzvTXX1gn7wB1u9HnY469zh/QV
 ICxw==
X-Gm-Message-State: AC+VfDxdESG585NsNFkmrEluXVLkjFgfUcV/Umus2cmFvJgknJIiwrxp
 JLdBlgx/I0owZg4ZtI5p9uzGHGQHYuWLdEfrg6g=
X-Google-Smtp-Source: ACHHUZ7N86Wzf4GnCcmKQeQgvU0I7+zXopmC3nN4Uq3/HwfDAarttg6GBxWLWSRWWvADJT3R5qot4A==
X-Received: by 2002:a17:907:2ce2:b0:98a:ed3d:8917 with SMTP id
 hz2-20020a1709072ce200b0098aed3d8917mr16161605ejc.9.1687821629556; 
 Mon, 26 Jun 2023 16:20:29 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.199.226])
 by smtp.gmail.com with ESMTPSA id
 t23-20020a170906179700b00987f64b84afsm3757789eje.39.2023.06.26.16.20.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 Jun 2023 16:20:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bin Meng <bin.meng@windriver.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Weiwei Li <liweiwei@iscas.ac.cn>, qemu-riscv@nongnu.org
Subject: [PATCH 03/16] target/riscv: Restrict sysemu specific header to user
 emulation
Date: Tue, 27 Jun 2023 01:19:54 +0200
Message-Id: <20230626232007.8933-4-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230626232007.8933-1-philmd@linaro.org>
References: <20230626232007.8933-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/cpu.c        | 8 +++++---
 target/riscv/cpu_helper.c | 2 ++
 target/riscv/csr.c        | 2 ++
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 4035fe0e62..175dbc9826 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -23,9 +23,13 @@
 #include "qemu/log.h"
 #include "cpu.h"
 #include "cpu_vendorid.h"
+#ifndef CONFIG_USER_ONLY
 #include "pmu.h"
-#include "internals.h"
 #include "time_helper.h"
+#include "sysemu/kvm.h"
+#include "kvm_riscv.h"
+#endif
+#include "internals.h"
 #include "exec/exec-all.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
@@ -33,8 +37,6 @@
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "fpu/softfloat-helpers.h"
-#include "sysemu/kvm.h"
-#include "kvm_riscv.h"
 #include "tcg/tcg.h"
 
 /* RISC-V CPU definitions */
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 90cef9856d..d871718e5d 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -28,7 +28,9 @@
 #include "tcg/tcg-op.h"
 #include "trace.h"
 #include "semihosting/common-semi.h"
+#ifndef CONFIG_USER_ONLY
 #include "sysemu/cpu-timers.h"
+#endif
 #include "cpu_bits.h"
 #include "debug.h"
 #include "tcg/oversized-guest.h"
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 58499b5afc..936ba2be24 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -21,8 +21,10 @@
 #include "qemu/log.h"
 #include "qemu/timer.h"
 #include "cpu.h"
+#ifndef CONFIG_USER_ONLY
 #include "pmu.h"
 #include "time_helper.h"
+#endif
 #include "qemu/main-loop.h"
 #include "exec/exec-all.h"
 #include "exec/tb-flush.h"
-- 
2.38.1


