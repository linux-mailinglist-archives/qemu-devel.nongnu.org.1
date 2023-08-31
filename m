Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3E578EAFB
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 12:48:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbfBK-0003pk-BR; Thu, 31 Aug 2023 06:45:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qbfB5-0003YU-Le
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 06:45:32 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qbfAz-00042z-77
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 06:45:29 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-31aec0a1a8bso385342f8f.0
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 03:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693478724; x=1694083524; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pajFn5q5HPV3atNa2Qh8ORUExlGjK7L5LypBPDHo1HM=;
 b=BaRtFNEJJ5W1UM2Hh+CrOYeNds0sBEx+slhr3fAqbZJMpKmXLDRzmT/cLklrVAgius
 pB5iflugSnWjf6O7iDON8xyvGOUMKzbhtFPGQjk/Xq8vye5fz6Lwvn4oyQmCQdeERcTN
 YMwoINH1uVnvCxwbuFkg00s/fO3NyWtg72rKZtHaLWIcoKrIiAqG92O14FXkqkpa15IX
 sbSLn876+zirLwHMIGMDpVs2Ra0HMDdO9l6qLW5O/74TqTghQss7YAdileGYZlY1m9fo
 amqd4u+YL9e0u5JuXQ/4aQ0BFwKnDcljklrwfiygnuhTW10hXYtTVhhPPN4Ax+HJVEt0
 7bHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693478724; x=1694083524;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pajFn5q5HPV3atNa2Qh8ORUExlGjK7L5LypBPDHo1HM=;
 b=cQWV+YT/64OSqd08CvVjowJ/3Kyto+en8mWXojIFgmGdGCQAC17/ej5rprzLkuQaM8
 aoxaIc7dWuNanndz6AfsZpHan56MbId7Qc7o8kj0eeiR+vXVMfXQJ8IxxUW0nEKnYmTo
 okuXELUfWfjAgFWF3jZHUZRATRcJDoxNgiPfQMMaMDBdP2yxBJMX7VckefY5TllzpHHT
 bz1SrDNVfZMdJ8N0vbPkqtCtagz2/M+7HEcAXOtixl2KQdJOjzE5h4U2mSCjIvNg8CJR
 4YEdk0Wk+0ADjevhVAdYwRqxvIz4Oh84JKgqIhpa8eXzMRGt0jy6E7bzCmsWZDshM9Cd
 lLRA==
X-Gm-Message-State: AOJu0YxOL6X8C5Ru0QYfLg9evjaGnoKQltrtn3Qo66a4VDkXf66AZDNF
 G5FWKbIOM3ulnAN9b5JK4W9GTMYLDh/iQ6vLmwI=
X-Google-Smtp-Source: AGHT+IEu+lnPZCXerFo5AlGRHwRUnX2yDh869Pq09WbXcD8dxXfFYSx1hbV4rQqq/dUiMhF8zILi1w==
X-Received: by 2002:a5d:4c45:0:b0:317:dcdd:3fa1 with SMTP id
 n5-20020a5d4c45000000b00317dcdd3fa1mr1953110wrt.34.1693478723945; 
 Thu, 31 Aug 2023 03:45:23 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 l5-20020adfe585000000b0031c71693449sm1785524wrm.1.2023.08.31.03.45.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 03:45:23 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/24] target/arm: Suppress FEAT_TRBE (Trace Buffer Extension)
Date: Thu, 31 Aug 2023 11:45:03 +0100
Message-Id: <20230831104519.3520658-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230831104519.3520658-1-peter.maydell@linaro.org>
References: <20230831104519.3520658-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Like FEAT_TRF (Self-hosted Trace Extension), suppress tracing
external to the cpu, which is out of scope for QEMU.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20230811214031.171020-10-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 23901121ac6..17540300feb 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2088,6 +2088,9 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         /* FEAT_SPE (Statistical Profiling Extension) */
         cpu->isar.id_aa64dfr0 =
             FIELD_DP64(cpu->isar.id_aa64dfr0, ID_AA64DFR0, PMSVER, 0);
+        /* FEAT_TRBE (Trace Buffer Extension) */
+        cpu->isar.id_aa64dfr0 =
+            FIELD_DP64(cpu->isar.id_aa64dfr0, ID_AA64DFR0, TRACEBUFFER, 0);
         /* FEAT_TRF (Self-hosted Trace Extension) */
         cpu->isar.id_aa64dfr0 =
             FIELD_DP64(cpu->isar.id_aa64dfr0, ID_AA64DFR0, TRACEFILT, 0);
-- 
2.34.1


