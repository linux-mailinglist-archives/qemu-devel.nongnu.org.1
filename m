Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A0378EE4A
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 15:14:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbhHs-0006HD-4x; Thu, 31 Aug 2023 09:00:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbhF2-0002u3-Bo
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 08:57:45 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbhEx-0005JL-TV
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 08:57:42 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-401b5516104so7025145e9.2
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 05:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693486655; x=1694091455; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jp50x3wJK7x4LxNpAtuBZu9CKHmOOVq7QE4QCfb0dao=;
 b=MfASd75hoLx+RzR8wmJ9sHCbhC5b4SGy6WtsEc4sKTJ9spUnZe/1p2yvjpJfy6JVnw
 YmTYuKuyR7q7zsYg2VsI+rqZsjBvgsaDwRH9tUQSBeuhBavh0czv56U4vDDdaX4SGbVA
 RFdWA872krGtu+YGSUgCoELqMcXWd1nJdmVm1aUC+WF9sXWAzMDVeAFZPieJrwELvPBC
 Qe66FEGS9NG5lqhcHKFzGr2HrC3xemaqLN7syy+o5yFu7QRLfLq5/RUmtOX5y2qm7CXn
 Fkg+UyrVIgA8sbSp1jRZaN6Fbr4vpl04k13F0DxasSAkj2ygOkqhNNVIJdD0XCRlQEu4
 oACA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693486655; x=1694091455;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jp50x3wJK7x4LxNpAtuBZu9CKHmOOVq7QE4QCfb0dao=;
 b=BqXW+Fxo8iJtGAOM8/A3MbZdc+0IeAsrdDYgXsixkBZiosBnlpBslNBhVpZB6OXfrw
 DFIOeGqWz6dqnP7IFTmCPERrki7Oxq8yxnHkO0HfSSRMHblg3JrvoV5skVTAtNUB/3hk
 JKjQawgWuZQeYAZyA7WpJOIHZyCaN4S2cb8dMt1jxgS14dkMQoUalUYnfgvkoyfIwYHX
 rpuoZNhwFiAr3BBkg+odklZ45kHupDOhoOjPZCNQDSTuYxXaxT9DL0lzkvdPe3MJx3ui
 S3OIk3UKq1TXNikKQfT0lMFnSz5pgiAyEdu/MKOWWNC7Jch07pTxdv3viFAsyJFbtbRE
 Z6bQ==
X-Gm-Message-State: AOJu0YyRj1kA0qm0r7Jy+Ic812Eu6NhyxsGqdJr2uKujJHmW2rIsmbea
 UG07CHY9H4+1VQ9bjlXMgeHAR/Ydco/vz4OZ5lo=
X-Google-Smtp-Source: AGHT+IGOJ/QhRL4HVSliSQ3yLN7Mk4OUv9ZBAYrf/fzbubk39jJXgh0jyPHVY6P2AA4b9SI7qmoz0w==
X-Received: by 2002:a05:600c:231a:b0:401:bf87:9895 with SMTP id
 26-20020a05600c231a00b00401bf879895mr4465464wmo.22.1693486655352; 
 Thu, 31 Aug 2023 05:57:35 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.199.245])
 by smtp.gmail.com with ESMTPSA id
 f22-20020a7bc8d6000000b00401c9228bf7sm1914641wml.18.2023.08.31.05.57.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 31 Aug 2023 05:57:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: [PULL 08/41] target/ppc/pmu: Include missing 'qemu/timer.h' header
Date: Thu, 31 Aug 2023 14:56:10 +0200
Message-ID: <20230831125646.67855-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230831125646.67855-1-philmd@linaro.org>
References: <20230831125646.67855-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Since commit c2eff582a3 ("target/ppc: PMU basic cycle count for
pseries TCG") pmu_update_cycles() uses QEMU_CLOCK_VIRTUAL and
calls qemu_clock_get_ns(), both defined in "qemu/timer.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230828221314.18435-2-philmd@linaro.org>
---
 target/ppc/power8-pmu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/ppc/power8-pmu.c b/target/ppc/power8-pmu.c
index 7bb4bf81f7..2537cded83 100644
--- a/target/ppc/power8-pmu.c
+++ b/target/ppc/power8-pmu.c
@@ -16,6 +16,7 @@
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 #include "qemu/error-report.h"
+#include "qemu/timer.h"
 #include "qemu/main-loop.h"
 #include "hw/ppc/ppc.h"
 #include "power8-pmu.h"
-- 
2.41.0


