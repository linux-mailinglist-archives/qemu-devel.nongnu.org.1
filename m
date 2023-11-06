Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 31BA27E1FE1
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 12:24:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzxPm-0007oj-R0; Mon, 06 Nov 2023 06:05:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzxPi-0007l5-0m
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:05:02 -0500
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzxPe-0003vA-Px
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:05:01 -0500
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-507a55302e0so5787103e87.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 03:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699268696; x=1699873496; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vePePWiaVFUAUv821iwYutEeShxemZReiuwQp7UFnAo=;
 b=dRSL/hYuo9Mvs3/Uu2aM/U3y5KtxOU6FUOjtDHSTO811vk8PjAwvonEAdKv+4MSTO5
 KhgrQ7U/SOHght8JGfhJ71WUg5+dPtRFSZD84ef7uYO7TjlyadJB0vgEIs6c0haD1GcW
 KdyU4/a97FgR2lNBNLBdLVUMJiz6iN5tOVv4WyiB+qH/nG7dcptikOt0H4IjNj/UkDsy
 VlYKtdV/audwFpCPYRbK/VCbHjze+OSLuJqkaYzockZyPnebr14RcjHV9AXTNVsPQqVF
 N91JWnzi3m/BBao49ojcZaB0eoi7OJXL8+KtpsqZbAYnmBODVOVRRJBGy3vGxKA/JUiP
 RkGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699268696; x=1699873496;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vePePWiaVFUAUv821iwYutEeShxemZReiuwQp7UFnAo=;
 b=oHfoSPauCpIw5UtZq6gu2NgAisbq6DHxYK2lyhX8Hd+2c6YbuuKratFaM8/3Aaqm/+
 +c8Ofm3ze5l8wMFFvrWx2ljRIxQpaprPR/JBg81AZXh/TnzIXxt0kzKLe1isGH5SY7tN
 Altbd9pqfN7TydLJCemQ0dNvI0qqCDAHVI4l1fFiXcwlTIwmMVan9v4T0sbCC6wqrti6
 nhcH8dEgydRLXnzBGIAIeQ7/AzTKp5T0I/fhUxs8kax1+VGO5UiGHSArNeU7TMgCiXKZ
 OtDlVEietMyxb34q5ijagKBMpwOvVfE5nIYPjfQRlkSTGF7uMXWS59x/zbVfR/y6CsIp
 qv7Q==
X-Gm-Message-State: AOJu0YwxjUzKkk5CXgTjQsbPwZVOgnTprtVy+z0oGrfeXJevelmLXRNQ
 4QP0KFYp83GC/LUBHFndkp+u/Du1SPe2uxh/uzg=
X-Google-Smtp-Source: AGHT+IGU7JDB32d3EmZv97kO2MEntQmcvvGtu7x3AN/j6r3vWH3xlZC+Z5FtDVtjxNdca8AyJOth4A==
X-Received: by 2002:ac2:4d93:0:b0:507:b074:ecd4 with SMTP id
 g19-20020ac24d93000000b00507b074ecd4mr20448646lfe.7.1699268695795; 
 Mon, 06 Nov 2023 03:04:55 -0800 (PST)
Received: from m1x-phil.lan (176-131-220-199.abo.bbox.fr. [176.131.220.199])
 by smtp.gmail.com with ESMTPSA id
 p12-20020adfce0c000000b0032dc1fc84f2sm9191301wrn.46.2023.11.06.03.04.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 Nov 2023 03:04:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-s390x@nongnu.org, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 11/60] target/ppc: Remove CPU_RESOLVING_TYPE from 'cpu-qom.h'
Date: Mon,  6 Nov 2023 12:02:43 +0100
Message-ID: <20231106110336.358-12-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231106110336.358-1-philmd@linaro.org>
References: <20231106110336.358-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x133.google.com
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

"target/ppc/cpu-qom.h" is supposed to be target agnostic
(include-able by any target). Add such mention in the
header.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20231013140116.255-5-philmd@linaro.org>
---
 target/ppc/cpu-qom.h | 3 +--
 target/ppc/cpu.h     | 2 ++
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
index be33786bd8..41df51269b 100644
--- a/target/ppc/cpu-qom.h
+++ b/target/ppc/cpu-qom.h
@@ -1,5 +1,5 @@
 /*
- * QEMU PowerPC CPU
+ * QEMU PowerPC CPU QOM header (target agnostic)
  *
  * Copyright (c) 2012 SUSE LINUX Products GmbH
  *
@@ -33,7 +33,6 @@ OBJECT_DECLARE_CPU_TYPE(PowerPCCPU, PowerPCCPUClass, POWERPC_CPU)
 
 #define POWERPC_CPU_TYPE_SUFFIX "-" TYPE_POWERPC_CPU
 #define POWERPC_CPU_TYPE_NAME(model) model POWERPC_CPU_TYPE_SUFFIX
-#define CPU_RESOLVING_TYPE TYPE_POWERPC_CPU
 
 #define TYPE_HOST_POWERPC_CPU POWERPC_CPU_TYPE_NAME("host")
 
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 24dd6b1b0a..02619e5d54 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -27,6 +27,8 @@
 #include "qom/object.h"
 #include "hw/registerfields.h"
 
+#define CPU_RESOLVING_TYPE TYPE_POWERPC_CPU
+
 #define TCG_GUEST_DEFAULT_MO 0
 
 #define TARGET_PAGE_BITS_64K 16
-- 
2.41.0


