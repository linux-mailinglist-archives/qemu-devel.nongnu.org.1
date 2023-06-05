Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DA972312D
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 22:22:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6GcW-0001of-KG; Mon, 05 Jun 2023 16:16:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6GcT-0001nh-O2
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:16:01 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6GcQ-0003mw-SI
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:16:01 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-651f2f38634so4813644b3a.0
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 13:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685996157; x=1688588157;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YqDV+jm8g9evb7GNVfVDtXxCAOldVWaEESSAIjdOu2o=;
 b=aQpwa3qufmzPaeZT+NA9CUG1yplHoISB0eqzU3StOQssT0/Uxb4Nb4PZ/DumDCcDDk
 uxkVgt4wWfza0Qy33Q7fP8+kMOmst0rUOUzGHZyeOTuSLdbsYZuZHWDYkE1oArf/NZIV
 UYvSNa15uxckDPmgnlp+cRN+M0QNboBVUI1bxMyP5aA5OyW1WZ0LWcu2uvX37DmLfdCg
 YNTBilnqLzPwQc+A0kjtiFSFLedL6JB7rK+ahlPoOdk9Pdv/PEYszHKvZKgTt7eYa2Xj
 3TbVDL1Dyb0HILXCrwNF8zec3tROTnEbom+14Y9j9o3RfxjrFz5ythGsYKlAQ+xMZLZe
 GkYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685996157; x=1688588157;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YqDV+jm8g9evb7GNVfVDtXxCAOldVWaEESSAIjdOu2o=;
 b=G9yint8l7tinExfHkoyX/iNBXKZOtPInzDIm3rFNowRQH7z0Kle1nGvuu1E3+nMe7w
 qe7xjP1wQ1jewyePguZ4xo2HgstOVev7s5Bc2qsJxRa5kYG409MWPzc0D6FNBFALkWlo
 J7EHdVhJyad8V41+t50NvD5PYCujhBc8Ns8L4zAhUKAGc2+BVyhrpw1cwh3MiOOQ9QaC
 FsaI06pr+SB3KZV8VMsK4OLUt7Vx6SmC5YYvDJoXpdnLAFILYPZLMhGo1mEWj5nv2CPa
 anogLnjCLlpVYHyeQPOoWeLQZ18f9xjoLQd6osX6fW0lp4haRCdtwak3I/7be5LIVSpy
 fMKg==
X-Gm-Message-State: AC+VfDxh2xYd1pg31j5sDHgoCTDS2eiNlsmoqCt2/64M72NIxQQTpuoZ
 OW5xIzrmfkBYEnttJDAnm8Y2tOjqdF7yPGJ7Sl4=
X-Google-Smtp-Source: ACHHUZ5c2UZbEwB//On1KsinuuOLH4kvPu+50jx/H14To3vj0WgSN5ThijwNSDG+95HfQY4ol6WSig==
X-Received: by 2002:a05:6a00:2292:b0:652:542c:ad8d with SMTP id
 f18-20020a056a00229200b00652542cad8dmr996404pfe.9.1685996157655; 
 Mon, 05 Jun 2023 13:15:57 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:3f85:a600:6a3e:e465])
 by smtp.gmail.com with ESMTPSA id
 f18-20020aa78b12000000b0064d32771fa8sm5552924pfd.134.2023.06.05.13.15.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 13:15:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 08/52] target/avr: Add missing includes of qemu/error-report.h
Date: Mon,  5 Jun 2023 13:15:04 -0700
Message-Id: <20230605201548.1596865-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230605201548.1596865-1-richard.henderson@linaro.org>
References: <20230605201548.1596865-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


