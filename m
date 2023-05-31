Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7677174F4
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 06:13:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4D3s-00072O-7x; Wed, 31 May 2023 00:03:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4D3l-0006qf-N2
 for qemu-devel@nongnu.org; Wed, 31 May 2023 00:03:43 -0400
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4D3j-0006AE-9B
 for qemu-devel@nongnu.org; Wed, 31 May 2023 00:03:40 -0400
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-19f454bd2c8so3188989fac.3
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 21:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685505817; x=1688097817;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pETdULDQ5wVmC1hpPClhoopHjiyEI8tGTGOipI84kxM=;
 b=LbP560zKuDlRw0qodstBmUBOZsiyZQffkqwgzUNqDH42Z9UYDn2JSmxOpnxiPKJj2J
 swCDMRCDHVemeT4rWyRELm0znxaBmgREwBPuo/HyYUADKdQWCmV+BKXtHTJzaKuTY3oz
 BO9g1HCwgGBqyJ2t5KpS2zhR/2EwYUw3zzPNFHAMZmaVXA3fDeekjVAdvbUPzIQtncxa
 V9jSEwafWdJKUD3ZCqHIcaWCK96SVRoSMEzT5V8e8yJucxp3tI6C3QWm0aKfVGhZdvA4
 Y6jxjsXmeiBZuTXyKQkYZDtkMx4IgISR0r9Y8nxU31VRr0eDxy2Bmze2x3qTcRVxorqU
 Eoig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685505817; x=1688097817;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pETdULDQ5wVmC1hpPClhoopHjiyEI8tGTGOipI84kxM=;
 b=k7d6OtWZW3nWhHUWX5lVNbDVSG709PCVSp/GnMEnWo18QACL1yaVHQAPmO5z5mP9wt
 FCL6OyMQ42MlrusOX5Pk7iWF1pPMATSp4wi7coKB32hSHLtm9A1Ym2K6kqINbtT78B5Z
 6nTCYw8jQA6Ky0wANCEX8fsNC6Wrdzm0kjAoiTrSUYWMJeAIyt3+0fqdZFZHyGtYPybV
 wFZ6F2+gaaruh9QIW4vQa4wDuUsXiLY8+djFfKs4fk5lCGHVD6JYgo4cimTSTHMwf6do
 VlW75ab7BdRkfJhee00hJ2YIss34CdcNf2JDatMQVuOoX4PIefeUbdAHs52tXcnOwPXY
 cyTw==
X-Gm-Message-State: AC+VfDy6qjnEv1PqmxpkUnb8hQpiolg6tG17+bRNHQTRBIYK8KQb36ay
 gZ6avv/E504JnBYkQlC7nzKHV0ukkXUwse2mZjg=
X-Google-Smtp-Source: ACHHUZ7kIQq7qBSVmiPdcRLQpsqm2h39UzBEQD2dgBKPPeBqAFRQK/L/upLQhCDKJ9VQhoEG+jfH4Q==
X-Received: by 2002:a05:6358:919c:b0:123:5851:f09f with SMTP id
 j28-20020a056358919c00b001235851f09fmr671317rwa.23.1685505817607; 
 Tue, 30 May 2023 21:03:37 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:1cd:ec7a:a720:ce9a])
 by smtp.gmail.com with ESMTPSA id
 j12-20020a63fc0c000000b005348af1b84csm194814pgi.74.2023.05.30.21.03.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 21:03:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 08/48] *: Add missing includes of qemu/error-report.h
Date: Tue, 30 May 2023 21:02:50 -0700
Message-Id: <20230531040330.8950-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230531040330.8950-1-richard.henderson@linaro.org>
References: <20230531040330.8950-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2b.google.com
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

This had been pulled in from tcg/tcg.h, via exec/cpu_ldst.h,
via exec/exec-all.h, but the include of tcg.h will be removed.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/avr/helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/avr/helper.c b/target/avr/helper.c
index 156dde4e92..2bad242a66 100644
--- a/target/avr/helper.c
+++ b/target/avr/helper.c
@@ -20,6 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qemu/error-report.h"
 #include "cpu.h"
 #include "hw/core/tcg-cpu-ops.h"
 #include "exec/exec-all.h"
-- 
2.34.1


