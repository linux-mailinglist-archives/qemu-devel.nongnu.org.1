Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3726372E1D9
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 13:42:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q90UR-0005V9-6G; Tue, 13 Jun 2023 05:39:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q90UO-0005Tm-RV
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 05:39:00 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q90UH-0005Z8-LA
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 05:39:00 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-977d02931d1so782493066b.0
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 02:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686649131; x=1689241131;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7g0Yqy2wB54am4pKsVZHqGyVbbprfwoeuCpS8UNAr/Q=;
 b=VhQ6tJsMl7jtmM9J/i0BhJWFESqjyFFPRIDg00QiFGA/kB7sR0c8ml+n31REt1EuB5
 taYdKTcZmPEc1q9/OC4fvocy1dvnJNBDmCSMfgYHMRfqxixfe9BGIS+AXnPZtQbZsmmH
 ADFzxJ6NM/jcqeF17RTpZBxFn2zQD/VjfxmxctYAw9edtGNGDky+Rqa/KyK3NOMh5xsk
 LMnB+8jUmC62uhf75GS2/61UD5C7Osn6kkBOHgS1HQRGR7DMVZhTxGga3vMK6ovc+w0H
 YkEodPlXW5nOillgGgNPZ7qPZRZMm6lp5LevBW9e8Vxcs0SbdyEeUWCXGKSbu/P3q8sQ
 fE3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686649131; x=1689241131;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7g0Yqy2wB54am4pKsVZHqGyVbbprfwoeuCpS8UNAr/Q=;
 b=UDNyC+Qmoz0XdXc2W0ELjjbwq7IcNNMxpd5a+vPMCzorWHOe3XKnTjhtGGXM9zA4n4
 E2HxTaW/n5HjB3nLqiTFTrkp4omq+laLYIoGvLFdwsvLmfU/LkdUzF8apwOrSUWHrvUi
 ut42e5D131JQPYXHu76HshGIbqXnl/ODE+GnhXRGAgMkNYeBWzEKEdRwAdHMiMOt9w00
 ydo+esB/6romQYkdnh8oO2SYS+Yr2rPgo2WIxCHzHZ6ziERmAdqUEcN9tW5DkL9ENOHo
 8idKNKtuvK9NEcSa2O8zrWEBVPm9zT1dDlpET8ClRYNEqtm+y1uL8xmlEqIqZcA0fYM8
 QbKw==
X-Gm-Message-State: AC+VfDzCWehowscLe9yZrAdgZ0BI7S4mXm1w8hRawu246RF0IEVEZd4W
 2fUalYqtxBLrAnx4WpuLizR7UKrdU4+/LPU5yQCRuw==
X-Google-Smtp-Source: ACHHUZ7JhRAiDkneppoHfApMqYVKtBWCST7DJhhsO9DGABO0Lt08jFzLRSEWHTYnIORWmTUkd4RiWg==
X-Received: by 2002:a17:906:ee82:b0:96a:ca96:3e49 with SMTP id
 wt2-20020a170906ee8200b0096aca963e49mr13379120ejb.13.1686649131840; 
 Tue, 13 Jun 2023 02:38:51 -0700 (PDT)
Received: from localhost.localdomain ([185.140.244.249])
 by smtp.gmail.com with ESMTPSA id
 k7-20020a17090627c700b00977da9d4ef9sm6527305ejc.18.2023.06.13.02.38.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 Jun 2023 02:38:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 06/17] target/hppa/meson: Only build int_helper.o with system
 emulation
Date: Tue, 13 Jun 2023 11:38:11 +0200
Message-Id: <20230613093822.63750-7-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230613093822.63750-1-philmd@linaro.org>
References: <20230613093822.63750-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
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

int_helper.c only contains system emulation code:
remove the #ifdef'ry and move the file to the meson
softmmu source set.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230602223016.58647-1-philmd@linaro.org>
---
 target/hppa/int_helper.c | 3 ---
 target/hppa/meson.build  | 2 +-
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/target/hppa/int_helper.c b/target/hppa/int_helper.c
index f599dccfff..d2480b163b 100644
--- a/target/hppa/int_helper.c
+++ b/target/hppa/int_helper.c
@@ -25,7 +25,6 @@
 #include "hw/core/cpu.h"
 #include "hw/hppa/hppa_hardware.h"
 
-#ifndef CONFIG_USER_ONLY
 static void eval_interrupt(HPPACPU *cpu)
 {
     CPUState *cs = CPU(cpu);
@@ -273,5 +272,3 @@ bool hppa_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
     }
     return false;
 }
-
-#endif /* !CONFIG_USER_ONLY */
diff --git a/target/hppa/meson.build b/target/hppa/meson.build
index 81b4b4e617..83b1e0ee7d 100644
--- a/target/hppa/meson.build
+++ b/target/hppa/meson.build
@@ -7,13 +7,13 @@ hppa_ss.add(files(
   'fpu_helper.c',
   'gdbstub.c',
   'helper.c',
-  'int_helper.c',
   'op_helper.c',
   'translate.c',
 ))
 
 hppa_softmmu_ss = ss.source_set()
 hppa_softmmu_ss.add(files(
+  'int_helper.c',
   'machine.c',
   'mem_helper.c',
   'sys_helper.c',
-- 
2.38.1


