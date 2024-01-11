Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB93F82ACE1
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 12:08:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNssl-0001j4-Tx; Thu, 11 Jan 2024 06:05:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNssB-0001Mr-51
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:05:19 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNss8-0004RV-Nh
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:05:18 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-33678156e27so4461010f8f.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 03:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704971115; x=1705575915; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7DGlJd8zO7MQUcG5o1SU1odAfTI4o+ayPUZ+8rGfmO8=;
 b=q6f5r0sXYkCzmf3EvFlix7bfhI7CA5YpuM+73fI6MmhRBm2wmNm3gUHvFiU7TGdLaD
 pvxv5dxZYdGe++I8GuZ4Egx/k1Cx+cfbnc3VFJLU/FEB9Q14so8kIRK/ThXlCmy1bCLF
 zunMQtd8/lsU+LGYlh22AnkEBx/SR5uB3PIJdsfeY1q+fDUrHe3A7sRkKOOpQilwRkdl
 GhyITkDYhoBaovnCz124Gh8Dy+MFDqIXaA5w/c76n5LCbu/vwkiubRQ9lsi2wT+bo1+M
 P1XhdFOBj/ueliNQwG3KH+ZNEqmeOr84YXXfYP0IR3k5JGvWynlrokOaU6SPWxgOBo9B
 ruZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704971115; x=1705575915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7DGlJd8zO7MQUcG5o1SU1odAfTI4o+ayPUZ+8rGfmO8=;
 b=pjH6s8WylfcqedzFu0WrTI6wHl8tgX47kWcntzys5lgzU1VbdfKSnn+pzqAvJb0XiT
 N7eEOFnkOmRAjZnh7SsWvvi2FrI9gPr5sE7mkWEW8AwPFKYPNns/dtMIKB13YCzEM+i3
 wWgmAHKvglOzIrXItZNVoar+l2s79XMGGw/7QLSlMzK0MmN90NeHf+M4Ng7G5KIZbLhR
 lCsETCaAgLo9UWDw6mecAy7ohii1Sz8O+IwQOorMcvbwSAaCDozkJ/Y8MQhycdaxkQR1
 Lz/2JzhRZTQaR0OmFQ9eKjBUmSwh6Opqvt83gQwD2MydMHDzpBVYqxhJqMVe9CPvARtm
 D0sQ==
X-Gm-Message-State: AOJu0Yw4OdR98r4Db9sV8c0498rDBQZGPCDhEQG8BeFN0q+Qu6L7uEKe
 ViAo13a+IhfeCExtzrj059G3A0y7351sDHUZ+W9Hk5XGSq8=
X-Google-Smtp-Source: AGHT+IFIPjQTHTYdINqO6e7MjuR2/6ZLOGs12aUtLM2Re26Rpzlutp+uIO3nUcZQYG6eD8EavH79UA==
X-Received: by 2002:a5d:6091:0:b0:336:70ed:4cc with SMTP id
 w17-20020a5d6091000000b0033670ed04ccmr567863wrt.95.1704971115391; 
 Thu, 11 Jan 2024 03:05:15 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v30-20020adf8b5e000000b0033690139ea5sm951323wra.44.2024.01.11.03.05.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 03:05:15 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/41] target/arm: Make NV reads of CurrentEL return EL2
Date: Thu, 11 Jan 2024 11:04:44 +0000
Message-Id: <20240111110505.1563291-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240111110505.1563291-1-peter.maydell@linaro.org>
References: <20240111110505.1563291-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

FEAT_NV requires that when HCR_EL2.NV is set reads of the CurrentEL
register from EL1 always report EL2 rather than the real EL.
Implement this.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Miguel Luis <miguel.luis@oracle.com>
---
 target/arm/tcg/translate-a64.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index f5377dbaf2d..ed1cc019a4c 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2241,12 +2241,17 @@ static void handle_sys(DisasContext *s, bool isread,
         }
         return;
     case ARM_CP_CURRENTEL:
-        /* Reads as current EL value from pstate, which is
+    {
+        /*
+         * Reads as current EL value from pstate, which is
          * guaranteed to be constant by the tb flags.
+         * For nested virt we should report EL2.
          */
+        int el = s->nv ? 2 : s->current_el;
         tcg_rt = cpu_reg(s, rt);
-        tcg_gen_movi_i64(tcg_rt, s->current_el << 2);
+        tcg_gen_movi_i64(tcg_rt, el << 2);
         return;
+    }
     case ARM_CP_DC_ZVA:
         /* Writes clear the aligned block of memory which rt points into. */
         if (s->mte_active[0]) {
-- 
2.34.1


