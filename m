Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CBEEA7548E9
	for <lists+qemu-devel@lfdr.de>; Sat, 15 Jul 2023 15:55:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKfiz-0004Wf-3e; Sat, 15 Jul 2023 09:54:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKfiI-00042c-Am
 for qemu-devel@nongnu.org; Sat, 15 Jul 2023 09:53:34 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKfiG-0001Fk-Ju
 for qemu-devel@nongnu.org; Sat, 15 Jul 2023 09:53:34 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3fbab0d0b88so24926785e9.0
 for <qemu-devel@nongnu.org>; Sat, 15 Jul 2023 06:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689429211; x=1692021211;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TsEvG+VWvCxR8wzqDIyWaXPHqC8uQbp4ZRAeyYSrQhw=;
 b=tV8M2B+W4xFNbzX44m/SvtOMztiCdlRnMo2tzSASbOteqG4sfJXnKK+gQnJqNDRheE
 l0kQLlcytPnXM4zYl22Gp4yEjTmeox3O1/sKPGuq1Z8I60y84oIGfMRaNnesiIW3kNUW
 cmr8QeoCVMPEjYlo/tPgVr/j6wUy0la4onLdoLCkwhezdBovU57LuibA8JKbf7K8P1zS
 lchbZKhrMfbKAKgFiqMZwEvD5fiufaY/zItMaDsY6dn09nUnI9bPKLmyuqXzJ3sS3Y06
 f9pTHPdkwnV6npQdu05qilIjSVGWxuGBXGNNYF4xmn3HrIujGcF8g8D1tU+B0m858B3g
 eNbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689429211; x=1692021211;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TsEvG+VWvCxR8wzqDIyWaXPHqC8uQbp4ZRAeyYSrQhw=;
 b=M3Ej1zwTOw7Cth5FZqrICrvxF6pHqMuxEJWMqTLlLavnCBBr0uUiT8/2HIa1uQvZFG
 2f9TDS8cH2+1IUKI7B337U2D/cFgjPpLvxNIxDNGmefbH20YsNsKhmMZTi4NmCvC2acv
 UEo6gw9DFBggbjDDO7dkMBqeFtvPJix+kDkMjZzUU2llxDHkR0gYMBWKR/LvjePxvFc/
 zHz5EHS9FEJfeXhpoDog9we21uRDua9XkFVIyfG+pFYBJqBc/E11G/JjYICmnav/63Ug
 eZ8Foq0qZI2e7NTdt4pA0p6BVtAbhQ2GgcGkG/RluPp15c3TjXW5m+vShCeyf1orGESS
 5y3Q==
X-Gm-Message-State: ABy/qLaEF6hWvXeFfFcirYUgOIFQWZR3x0rbqiJ5OsoD42+PNKP99HO9
 33n710DtqmEF1EQoK8waeCX60hs9fUwfG3nVmDjsnw==
X-Google-Smtp-Source: APBJJlFY8Aq95pSsHrxC+pSoQRTVxMMDftD/I6abyXp10epvk1IICtxhsCzq8V5ARMV2hPPyrSTOWg==
X-Received: by 2002:a05:600c:20c:b0:3fb:416d:7324 with SMTP id
 12-20020a05600c020c00b003fb416d7324mr4789756wmi.6.1689429210984; 
 Sat, 15 Jul 2023 06:53:30 -0700 (PDT)
Received: from stoup.lan ([51.219.12.49]) by smtp.gmail.com with ESMTPSA id
 k10-20020a5d66ca000000b00313f9085119sm13838014wrw.113.2023.07.15.06.53.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Jul 2023 06:53:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/47] include/exec/user: Set ABI_LLONG_ALIGNMENT to 4 for
 microblaze
Date: Sat, 15 Jul 2023 14:52:44 +0100
Message-Id: <20230715135317.7219-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230715135317.7219-1-richard.henderson@linaro.org>
References: <20230715135317.7219-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x335.google.com
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

Based on gcc's microblaze.h setting BIGGEST_ALIGNMENT to 32 bits.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/user/abitypes.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/exec/user/abitypes.h b/include/exec/user/abitypes.h
index 743b8bb9ea..beba0a48c7 100644
--- a/include/exec/user/abitypes.h
+++ b/include/exec/user/abitypes.h
@@ -15,7 +15,9 @@
 #define ABI_LLONG_ALIGNMENT 2
 #endif
 
-#if (defined(TARGET_I386) && !defined(TARGET_X86_64)) || defined(TARGET_SH4)
+#if (defined(TARGET_I386) && !defined(TARGET_X86_64)) \
+    || defined(TARGET_SH4) \
+    || defined(TARGET_MICROBLAZE)
 #define ABI_LLONG_ALIGNMENT 4
 #endif
 
-- 
2.34.1


