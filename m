Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE11CAB5BD4
	for <lists+qemu-devel@lfdr.de>; Tue, 13 May 2025 19:53:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEtnd-0000Ve-Cm; Tue, 13 May 2025 13:52:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEtc7-0000KL-S4
 for qemu-devel@nongnu.org; Tue, 13 May 2025 13:40:27 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEtc5-0003OG-Rl
 for qemu-devel@nongnu.org; Tue, 13 May 2025 13:40:23 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43cec5cd73bso40319495e9.3
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 10:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747158020; x=1747762820; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q8SAO3KJ++XWvDWuMU/h8ZGGLKmYxZ6lrHNEHZshFbA=;
 b=jk5opCxDYvg+OpOi7DsKan8Y9t/h/AH1xmNn9y0VMuXot0TOdBvmUnMxUrNar9Lki9
 YLFC6+9KYVXZSKpIPcqcplUUCimNBBZ4tjWiK/XibW7UjOU/Lw57I1dZUhqk1sdR5Qwt
 XOPv53ueQJUPUPum6nwIuz1QfC27f7U6Og666Qje7uXcSQq1R5Zmcmv9psPvm+nyr8mb
 61LM/HcRzP1capKNZtKjy2PMCPR6kBB2C2JSs8d+rJQ2Gbme3kaSw3djZ7xBcSnR98eX
 h9bOiGNhXEEygVVe/9LN7qE97zOyCWR7htM4s7aGg86oAcRrIPelNaeeTEh2o1nhmqjj
 aj8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747158020; x=1747762820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q8SAO3KJ++XWvDWuMU/h8ZGGLKmYxZ6lrHNEHZshFbA=;
 b=qVF2GdeFoHaz+1mGncFQ4cJKo8gzZiebG99MP5zshvCY3RXEz9so2ipOtljnYaKB4E
 g8OEYGkXwWXgEq9MYH0w/u9LZBi8BB4kbI0tihgitgnfk+GRSg+/PyNOOHXud2xSptwb
 pX4fshroHLRX05kICcH977jX2ayfGnDTZqBr6kZLCkklUGoKmQlemqVry/WuA0/eQFhj
 XRSSmCq22rAJC4oRX4xlagk4H/QSDGrB+qRA3KO2nJjwU6ZIQmOt5rV4uySL59m7iecO
 LPptWZQUcgPScciWsfO1wiik2tPkyCdNiFs9OVGWTzWTcUTdPTh8XnXeDdaHh6hY36Kx
 FCEg==
X-Gm-Message-State: AOJu0YygwHoA8JLFVc4Shf9RwycSv757omV7IHBJt4cLwSniyFyqIGSK
 gW2RhOkc9BzkeHmtqBSHoARgSHCeZ0OpZWvwtIYhj1aEN3G5t6ywvmL5eAClCySDeoXz4nnrCjg
 PjtY=
X-Gm-Gg: ASbGncux+LRaBzM4y//vu3MbyrnvJ4tkeRVx6xULPDeUgAPT3yw9ho7qd5WW05LZ1Rv
 jsLjvjzcs84n3BE9fiehZZf4VM7ZDl6k5MXljPsEycx0K1MIRztngx9sUHmMdyLb8kwdr1gLBsv
 fyY9P/ZygeU59sExbTA6BLLu9nDDLOhbXpuMadhIEgXCxIBaTQFsymWOKj9TZvt9P+fiOaQLuP4
 MbdVnLiclb+/Shl2spcxhSpwAbiPmKe33TAvuUR7H76r+lyAWbpgWoJ4eJ38fGdrSxHDPZnlr6B
 VWB+CYtoHvFlGR1SjYXKfksQl+qAl20GsqJgUuIpEIbkd6yI+Tc3cFVRuI4dTc2bKPCTbHsZJKV
 EpLAYoM/j4HxU2ZPxF5hkCmrswEKy
X-Google-Smtp-Source: AGHT+IHf6GTd3RZvjMBcv+Yhn08GoRM2N7nM/a3ZlvK36HyHaGGsR3rJGytbA/WJOlLm4MjHcQxKnQ==
X-Received: by 2002:a05:600c:5128:b0:43c:ec4c:25b1 with SMTP id
 5b1f17b1804b1-442f2169795mr1791695e9.23.1747158019825; 
 Tue, 13 May 2025 10:40:19 -0700 (PDT)
Received: from localhost.localdomain (110.8.30.213.rev.vodafone.pt.
 [213.30.8.110]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442d67ed1bcsm173216355e9.18.2025.05.13.10.40.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 May 2025 10:40:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 10/19] hw/arm: Remove unnecessary 'cpu.h' header
Date: Tue, 13 May 2025 18:39:19 +0100
Message-ID: <20250513173928.77376-11-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250513173928.77376-1-philmd@linaro.org>
References: <20250513173928.77376-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/arm/exynos4210.c | 1 -
 hw/arm/highbank.c   | 1 -
 hw/arm/mps3r.c      | 1 -
 hw/arm/smmuv3.c     | 1 -
 4 files changed, 4 deletions(-)

diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
index 76001ff0dfc..56267ec2bd2 100644
--- a/hw/arm/exynos4210.c
+++ b/hw/arm/exynos4210.c
@@ -24,7 +24,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "exec/tswap.h"
-#include "cpu.h"
 #include "hw/cpu/a9mpcore.h"
 #include "hw/irq.h"
 #include "system/blockdev.h"
diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
index 3ae26ebebdc..5b2719555af 100644
--- a/hw/arm/highbank.c
+++ b/hw/arm/highbank.c
@@ -35,7 +35,6 @@
 #include "hw/cpu/a15mpcore.h"
 #include "qemu/log.h"
 #include "qom/object.h"
-#include "cpu.h"
 #include "target/arm/cpu-qom.h"
 
 #define SMP_BOOT_ADDR           0x100
diff --git a/hw/arm/mps3r.c b/hw/arm/mps3r.c
index 48c73acc62e..889d291401e 100644
--- a/hw/arm/mps3r.c
+++ b/hw/arm/mps3r.c
@@ -29,7 +29,6 @@
 #include "qapi/error.h"
 #include "qobject/qlist.h"
 #include "system/address-spaces.h"
-#include "cpu.h"
 #include "system/system.h"
 #include "hw/boards.h"
 #include "hw/or-irq.h"
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index ab679723533..37b39c9f84f 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -24,7 +24,6 @@
 #include "hw/qdev-properties.h"
 #include "hw/qdev-core.h"
 #include "hw/pci/pci.h"
-#include "cpu.h"
 #include "exec/target_page.h"
 #include "trace.h"
 #include "qemu/log.h"
-- 
2.47.1


