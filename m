Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B4D78BAE4
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 00:15:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qakUE-0005ri-Jd; Mon, 28 Aug 2023 18:13:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qakUD-0005rG-AF
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 18:13:29 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qakU9-000483-OX
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 18:13:29 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-31c6cd238e0so2981534f8f.0
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 15:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693260804; x=1693865604;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CDnk9YSeaoJdQRRB9TTsPC8B6FMZ/ZKTWzxCgLttq3Q=;
 b=P7BR8xaDjcJGshJySCVQVljJUEjiUazbpSm6e1BrSRK+dCfM7YZ4UL3KGATyHUIm1v
 0n6TjpdingX0FubBMXjURoyLyOfDVd2nooMZL2IRehWAnC46vCUeSBBlSRDJ8q0lv1iy
 vqYmYypvtpHR9mv8E0O9krIbh2FpkurwLZd9aUJJ8zeJbIpVvVwpHFDlnWptsZE2Sh2R
 dBN9pPlV+AW0EPgyUHiX12xfO1wwQam6kV0iXkZu1cRAl6xabGMr4M+KUfuBmj5LKWM7
 Auo23CNqfNZ74J7crYM8/Ey2XTjImyGGSVHQER1R8NY068/ItAuxIA8cBGehJEncdVg6
 Zx/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693260804; x=1693865604;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CDnk9YSeaoJdQRRB9TTsPC8B6FMZ/ZKTWzxCgLttq3Q=;
 b=gNT0VlH+dKi56PYNOVW4cCOQSJ7K/EjEylLG+p4FeKWZavUV3SKNkIUzNm/Dg904ZD
 2PHlinPVXEjK3vIAX8HBmFtK/g/nrKrf3IF4H0p13o50X4VOVrFnc/f5HrgXGYQSLd0d
 WRqlkoxhtLj0KSyi7hF/RLah5vwpjAhZnlw+zjwtZDTHAFFZGVGNA52IgnT44iBw665W
 aVvXNn+6PsWZiTMzuYxZEbd3EVa16H13PhRtiOG7yaoM1YdcdoRvGGWVznePhSIzgC8h
 VVXFfNUOT2vlvcjzc+XH1MtJMOFLiTAcFfi7jaaL9lDrUzHkhIfJI2COoQsqOOe1UNR+
 V9Bw==
X-Gm-Message-State: AOJu0YwrT2Q+7ifoaUU3xlqdiMSYG1tQPbqMX8GmC/3quMM07TQv/W60
 NNKwQBAHg9uZsnDPo9SLU/fJ/66lxj7be2/Tu+I=
X-Google-Smtp-Source: AGHT+IHPvQrHbNHJ1Cn+83ARyJjToN6jv5cfY3yRFi8hdT1JXKLwAncQEdY+0AZgTULZpOckfOJihQ==
X-Received: by 2002:a5d:530b:0:b0:317:ce01:fe99 with SMTP id
 e11-20020a5d530b000000b00317ce01fe99mr605633wrv.9.1693260803920; 
 Mon, 28 Aug 2023 15:13:23 -0700 (PDT)
Received: from m1x-phil.lan ([176.164.201.64])
 by smtp.gmail.com with ESMTPSA id
 u5-20020adfed45000000b0031984b370f2sm11756175wro.47.2023.08.28.15.13.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 28 Aug 2023 15:13:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 01/11] target/ppc/pmu: Include missing 'qemu/timer.h' header
Date: Tue, 29 Aug 2023 00:13:04 +0200
Message-ID: <20230828221314.18435-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828221314.18435-1-philmd@linaro.org>
References: <20230828221314.18435-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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


