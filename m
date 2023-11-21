Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 20AD37F2A55
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 11:26:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5Nw2-0004Ik-L8; Tue, 21 Nov 2023 05:24:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r5Nw0-0004G5-J7
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 05:24:48 -0500
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r5Nvx-0007EP-L2
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 05:24:48 -0500
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-507a29c7eefso7630748e87.1
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 02:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700562284; x=1701167084; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=48i16lN/X0IufQ0d/3ATpQbGOSnta9cBh6bFvGherhw=;
 b=bsq+uaoAQ/OtEMEEvn+G2zO+g+3ZPjiMvYEakYfju3TYHWcupjVwJPyDuVWPI1PRMd
 k7QWCDQdtB2gpoMxxV9LLj3TecDBg5tNorCfr0AnZX9ABLaGoPRxEUQtYPRocWEXmLCu
 Jmn2WtyLzUlrQmL0SoHPVv27mQ900aTGN3ujWVQgJxtK7vbJWHhsBNAGZdUWwRBP80NJ
 gyC/jSagZHsSJ62EqFRFiYiGM2IxCjzkd2ixnJWmDNcEiUPlVqKStfAKEvhjUaJGSK9k
 Ztw2h0ge/EVmVbO/VID6Z7I1pHhKUVxkAPxD3E4Zzc7DRloJN5BGz4jwTvoLcrmXSMGl
 MEOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700562284; x=1701167084;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=48i16lN/X0IufQ0d/3ATpQbGOSnta9cBh6bFvGherhw=;
 b=BGIfFj6F2jFsopBToTCgaEFiKmPfe7jYTF1lDoxOakF8XQvGCPhNCrxlthAdHaAqol
 g6wANyUxN90lfpNvREbwneTHhYwyJxU9+hLXlccq3VJhihXP5HvrOB25SgrgPKYty0ic
 p7dohVj0BUrhfG33FZ70IJdEdV+0f9bTfUuUIx9+Af+a+EoAXU8DOG8c1ETyyg5y8893
 Rt081Nj0kR8NhJYYXSJz2TCnuC1tEnJQPd4XccwUBf3UjZ2g1ds3S1iI7KdDGlPHUHgE
 jQ4h8hpgp7UibjBThEb/Hhsr88NORluIckQvefo6Uv+TP79QlnVPRfIHh/gWlpBnoNXU
 BUvQ==
X-Gm-Message-State: AOJu0YzVR3BhnbknwWDNjKDuQljftH569cnD8KrfYUy/7kzZ+IjfWZsn
 V6eND4x9D7IVBcLzXKxqJfYqG2GpoGYK1Ql717A=
X-Google-Smtp-Source: AGHT+IEokHooP/rHzOaIt2poO4Ams1GHQdUMwviHlyc5yxy4yZ6Xs25emQOzbhB2Cj7TtoM1/8KNtg==
X-Received: by 2002:ac2:5df3:0:b0:502:fdca:2eaa with SMTP id
 z19-20020ac25df3000000b00502fdca2eaamr6882544lfq.52.1700562283905; 
 Tue, 21 Nov 2023 02:24:43 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 n25-20020a05600c181900b00405442edc69sm20450835wmp.14.2023.11.21.02.24.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 02:24:43 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 1/8] target/arm: enable FEAT_RNG on Neoverse-N2
Date: Tue, 21 Nov 2023 10:24:34 +0000
Message-Id: <20231121102441.3872902-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231121102441.3872902-1-peter.maydell@linaro.org>
References: <20231121102441.3872902-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x134.google.com
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

From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>

I noticed that Neoverse-V1 has FEAT_RNG enabled so let enable it also on
Neoverse-N2.

Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20231114103443.1652308-1-marcin.juszkiewicz@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/cpu64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 08db1dbcc74..fcda99e1583 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1018,7 +1018,7 @@ static void aarch64_neoverse_n2_initfn(Object *obj)
     cpu->isar.id_aa64dfr1  = 0;
     cpu->id_aa64afr0       = 0;
     cpu->id_aa64afr1       = 0;
-    cpu->isar.id_aa64isar0 = 0x0221111110212120ull; /* with Crypto */
+    cpu->isar.id_aa64isar0 = 0x1221111110212120ull; /* with Crypto and FEAT_RNG */
     cpu->isar.id_aa64isar1 = 0x0011111101211052ull;
     cpu->isar.id_aa64mmfr0 = 0x0000022200101125ull;
     cpu->isar.id_aa64mmfr1 = 0x0000000010212122ull;
-- 
2.34.1


