Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 990C07971C1
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 13:28:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeDAP-0004bC-Kx; Thu, 07 Sep 2023 07:27:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1qeDA8-0004IR-RS
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 07:27:05 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1qeDA0-00064V-Pj
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 07:27:04 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-307d20548adso847786f8f.0
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 04:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1694086015; x=1694690815; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Onk5iX5pAqOQQ8Z64rzCsuwWRpswOiPiPW0vWDB6iYs=;
 b=aEdnT2mucqGZPkpxkqcNH/diU7wS3Ykg3yvMzrPWYb839Ws3jxlxQDtlP7htzFaBh9
 RzaNZAj9SyJozG1SZia5fu7XhpGFow41Twz0jPLK/mkUT9y6tZOMC+5m0C6Gt04UBaq5
 mMDwkzeWASEoT2dalgP05AcC8RhzI0wUJhb/lQyds95yB8ysSOyOno9+5i5h4rHjPck3
 7+7ibOnAokpn4QgKfCPSDEfGlyPJvkJZJ/KTlzxL2j0927me+UdkexaeDC3X+HtU2HOR
 K/4o3vr79GyIIhsM9g4kMS5He7Apq6PiMK98oh1gcWk0aeWorU3CsHeNfwTy8p5fc3Rk
 S6Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694086015; x=1694690815;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Onk5iX5pAqOQQ8Z64rzCsuwWRpswOiPiPW0vWDB6iYs=;
 b=H5uyzNvlmdxFRnTpr5iOZFelw3GBDppi1AAaAedhz3xW6bafL3BlgpoG4VD+ucU1+u
 pnzdl6ZysNlKc/MjxSyueiBgEjX4UGW4CGnK+vov9EG+TgnTbiof7xvJ9HH/C0dZNSNR
 ZhYvZxb1b5h751dmyAitKd10Jvh9yCnjs+dRh7DFC2z4ahDT0Iaj3+wNPFNV3Jgjon/h
 4WC8pPIHBg82645OEK5KLYjw5ZnIQndSI/K5rt1JYnJxjUwDN8mpnH33P3Gmlu8u+4br
 FzOkwfZ3G+Nwiz/CC/wQOt3jFF9TvkhSMaZca6Y9Kn4xKpKUpHRld2T22Jkf/3sZmxxP
 dVeg==
X-Gm-Message-State: AOJu0YxYaliU6Daf4MUA30A2QhyMVRgPzRbPVJRq+WgHpMRwd6wcsu2u
 rafAKLTADxvZlQa9baGRxlEJTd9kUSoEXpzjR5Q=
X-Google-Smtp-Source: AGHT+IHxHbDj6g0qxNfIf6qtXstbjqXuscneLTUuoI6CckEdLjo1l/WzKqygOYx2T+mFTDvjgaMYgQ==
X-Received: by 2002:a5d:4442:0:b0:319:7b6f:4a5d with SMTP id
 x2-20020a5d4442000000b003197b6f4a5dmr4857309wrr.52.1694086015012; 
 Thu, 07 Sep 2023 04:26:55 -0700 (PDT)
Received: from chigot-Dell.home ([2a01:cb15:8123:8100:c2c3:52c5:8306:a161])
 by smtp.gmail.com with ESMTPSA id
 y3-20020adfe6c3000000b00317909f9985sm22998755wrm.113.2023.09.07.04.26.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 04:26:54 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, peter.maydell@linaro.org, alistair23@gmail.com,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
Subject: [PATCH v3 4/5] hw/char: riscv_htif: replace exit calls with proper
 shutdown
Date: Thu,  7 Sep 2023 13:26:39 +0200
Message-Id: <20230907112640.292104-5-chigot@adacore.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230907112640.292104-1-chigot@adacore.com>
References: <20230907112640.292104-1-chigot@adacore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=chigot@adacore.com; helo=mail-wr1-x42a.google.com
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

This replaces the exit calls by shutdown requests, ensuring a proper
cleanup of Qemu. Otherwise, some connections like gdb could be broken
before its final packet ("Wxx") is being sent. This part, being done
inside qemu_cleanup function, can be reached only when the main loop
exits after a shutdown request.

Signed-off-by: Clément Chigot <chigot@adacore.com>
---
 hw/char/riscv_htif.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/char/riscv_htif.c b/hw/char/riscv_htif.c
index 37d3ccc76b..7e9b6fcc98 100644
--- a/hw/char/riscv_htif.c
+++ b/hw/char/riscv_htif.c
@@ -31,6 +31,7 @@
 #include "qemu/error-report.h"
 #include "exec/address-spaces.h"
 #include "sysemu/dma.h"
+#include "sysemu/runstate.h"
 
 #define RISCV_DEBUG_HTIF 0
 #define HTIF_DEBUG(fmt, ...)                                                   \
@@ -205,7 +206,9 @@ static void htif_handle_tohost_write(HTIFState *s, uint64_t val_written)
                     g_free(sig_data);
                 }
 
-                exit(exit_code);
+                qemu_system_shutdown_request_with_code(
+                    SHUTDOWN_CAUSE_GUEST_SHUTDOWN, exit_code);
+                return;
             } else {
                 uint64_t syscall[8];
                 cpu_physical_memory_read(payload, syscall, sizeof(syscall));
-- 
2.25.1


