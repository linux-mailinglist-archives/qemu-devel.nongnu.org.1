Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC769A6B124
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Mar 2025 23:43:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvOQj-0003ba-P7; Thu, 20 Mar 2025 18:32:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvOPT-0002Sa-Lo
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 18:30:49 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvOPE-00079E-9j
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 18:30:42 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-224100e9a5cso26124905ad.2
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 15:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742509824; x=1743114624; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eCoHq1TF4OuerztqGd91anfr0TMnNc3lHBgW4hpQzhU=;
 b=MLlomhZUOWJcCepxgMs139yijKCM1yBh2dJw4o90rWp34cp7m+BIhb/20lU7kf2YXR
 7u/itJaQP5BBHfNE/kslZS6HHjxgFMxeVtKjJLlQwsGd+imdn+feqn1PoHQybRGzxvFM
 UI1V4X1ZZzMyKZkYuvZbvTeJK6D5cgK6TMmfzeaw7YSpCUS5v/ZnwQwghUGPjr2OzRLf
 I/VNTx3kVzzDXU6rdz/vx5Q3YRnxwmogdD2QVKWAGZQBp+8q+QXYJqqBgtLPI1cMQUHq
 EhD8ZwknMes0UPCVcnL3sb5DR0Id+xTWTsQT5NPNzXpcR8wbkQj8OZvpYE5qVTDaLstY
 XfBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742509824; x=1743114624;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eCoHq1TF4OuerztqGd91anfr0TMnNc3lHBgW4hpQzhU=;
 b=rOq9hVnEvxORGJfGSCCTKUE7Fr8++1BAHMZbGVqPy6CSKt7eAyL27iufmWS9jajsQ3
 +YIHjZi/4RtxuEhp2Wa6PwWbR5LWQlw2tWTfwhLe2Rezt4UFZu8FxtnLSzuF+qa9gkLU
 wUWMtTrWVl84bYkF68fx/wuoXdZ0SYEDWnU/R9R6tibhBLyTsTzbYTSFULS36l5ntYKN
 yIkbYAWfjhTQJu9R12NblaN+vhftX34SYrBwYqghpLt7daadPPo2g6UjcYVFFa3EUE7o
 femZYrwnFPYCq0x1o6sODu+HKyU0kpWdDp7MxKvYjmLpEKejloYBBE5YXUnU3vqIaRXy
 E+vA==
X-Gm-Message-State: AOJu0YwsecxMZ+zhqfciR2Ln/QEl8gYDr/btCYa+83IKy4RLVSbkGNFq
 w/LlULhEsRzspke+7r8C1MClreGEL0MEm2X7Pya0K+AkH49pVvDEQSguxok9i91i+mGr0gt6/Oy
 +
X-Gm-Gg: ASbGnctPfxjvfyDO0z3GqN1IHdb5z0H/aceD3i6d00INqdkMVuZR8gbGMLfHEGDGs3f
 fuvlkmYpy/8DP6oj/H8AnEa6ebn59QjyQRO5AZ25GQShYJzjjdpvT7LlRxS+fGwSeK6D6MLtXCD
 bH5OZUmT60iYBK43KTEha8HgkbLzi8N2Bf+MFZSuXv9XjMfuKdowEWrfAvCXPk8fk5SFFPVsqWb
 5y3icB2gdhWQVC6uXLqXvPrw1/0/dLMogiAIxmH0VElPEKus8tvhTk/xMzz9RWalYd0AZ7lhaEU
 1DpA3jRzXOjSNcpBHu30hJRms5AhJiXgXVEGZhipad8X
X-Google-Smtp-Source: AGHT+IGI4h055zkEpag1yC+Lf9SXKqGgcc//U54r/YtVGXHhgxJCu9SYna1AurwwJwuLFCO6BJkVVw==
X-Received: by 2002:a17:902:ecd0:b0:220:bcc5:2845 with SMTP id
 d9443c01a7336-22780c5350fmr15267505ad.7.1742509824135; 
 Thu, 20 Mar 2025 15:30:24 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22780f4581csm3370145ad.59.2025.03.20.15.30.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 15:30:23 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 11/30] exec/cpu-all: remove hw/core/cpu.h include
Date: Thu, 20 Mar 2025 15:29:43 -0700
Message-Id: <20250320223002.2915728-12-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
References: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/exec/cpu-all.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index d4705210370..d4d05d82315 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -20,7 +20,6 @@
 #define CPU_ALL_H
 
 #include "exec/cpu-common.h"
-#include "hw/core/cpu.h"
 
 #include "cpu.h"
 
-- 
2.39.5


