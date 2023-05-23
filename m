Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E2770DE36
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 15:56:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1ST7-0006ZW-Uw; Tue, 23 May 2023 09:54:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SSP-0004zk-3y
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:53:46 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SSD-00031U-6Q
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:53:44 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-64d4e45971bso2348302b3a.2
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684850011; x=1687442011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pETdULDQ5wVmC1hpPClhoopHjiyEI8tGTGOipI84kxM=;
 b=q+mgntLrg1UWZclDE3LYT9aWqZk6AzgQZtPJNk9IaJ+8zKc9bK7knAyOjq1f4NWf83
 biuhX5NLiw5r/u4MXiLWb1vNUw4clGTMMWkainDLsTkSxVN4dNwPlOTU96C735qn0oD1
 de0Gs5vOpF3z1YsQWr/vpfHM/AnotXLK7TFG6l6NQEnuKGIXpgZ5huXC8WngIv22h+Cv
 LLCUGl6VHJYR/BUxD99AC+kG1ZQfdDQxgD5nSQO+3q1FDxXy83vjSnaW0RgYEpXM7pf3
 yzBZWhqu7L465Re9nIVwKJoFkVBPhUMlcQPjC3QJFy0ttu0qey+8f2Ar5CGzA5+TRMiS
 bABg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684850011; x=1687442011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pETdULDQ5wVmC1hpPClhoopHjiyEI8tGTGOipI84kxM=;
 b=XKuY0WOqjQvBHaKqYNNKcE2dvIsrUwMfHEYSnDq3LsTIcRi6yVKcA9+tjNpAGCGcmn
 KAGlJIxwzxDEvn0EAR1nuK1EIYn+GP+q84AysFnCv6Ek+VE2HNiToQWvbYPrCGAT99zA
 H5bjINLgBHANZAjQlRM2NNT4IG4AF4xIrHIGgKmsJL3HJsCMnOvSLEHdui75Ym0m291B
 SNCGLLSKhIjCtKBUjXFh0nGDtj3kOAEa4yGLENNkHMgfQc8vAreQwv2mapQeHyb6sCtE
 LTFSzymL5Z375SipgYzYI/+f8rVHo0XBOTppVwF2DksNlmF1eLFeAOptL9MeQOIF/im3
 tc9g==
X-Gm-Message-State: AC+VfDyLMJSaCjrzxmPh3XO6YmqESxTN2FiLmYifzFvYOJTHrSKKmnnR
 Z04heRSHteZkZh3FwnLAlFi/D8UscGkJ19VbwOA=
X-Google-Smtp-Source: ACHHUZ4dycvza3RtcsagkBaNNC7vF+aAgbvTynIPiPn7oYBSOiQdxgRg96LRltbRBaFEY7CdVJIVwA==
X-Received: by 2002:a05:6a00:2e21:b0:627:e49a:871a with SMTP id
 fc33-20020a056a002e2100b00627e49a871amr18608389pfb.23.1684850011539; 
 Tue, 23 May 2023 06:53:31 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 b8-20020aa78708000000b0064d27a28451sm5796111pfo.100.2023.05.23.06.53.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 06:53:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 09/52] *: Add missing includes of qemu/error-report.h
Date: Tue, 23 May 2023 06:52:39 -0700
Message-Id: <20230523135322.678948-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523135322.678948-1-richard.henderson@linaro.org>
References: <20230523135322.678948-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


