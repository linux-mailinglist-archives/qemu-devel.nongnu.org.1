Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 779A77E7DDE
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 17:44:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1UbT-00052S-Ri; Fri, 10 Nov 2023 11:43:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r1UbM-0004yS-6C
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 11:43:25 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r1UbK-0001wn-GT
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 11:43:23 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4083cd3917eso16999025e9.3
 for <qemu-devel@nongnu.org>; Fri, 10 Nov 2023 08:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699634600; x=1700239400; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6Z/d/PlRIYV975I1CTJVwYo3Y8uvT4BaRAHDGx9VFCo=;
 b=k9umReDId+IMOUq6lNUoaLr143xY29H7d/WYEp8rOh5fjdAyJCliRiZFQJl+cTvvHj
 Z37yup8kNeW6JYYKVP/bV2wLChJ59mNsfPwq216VRDkC56krSzuWD3Uz5xEZAHhe59sx
 YGt3r55j2P2sZp//M6PVAH9U0Dnp1WL71ehrRokSkS8sqCqMKWv2MGRbVg2varThsrPk
 e346Mma6GDGUdDeeuIkLSrvIWTmKGdMWtvIIuqKnVqqBT7ZaFMIu6yJfQSjE5LNo7j5e
 crmBbsz4/oJ3kVhfKaD/v0UJt3kUHNczmVI1TRPeaGMMuaM44uI6vtHUVwl1pgHdyRcb
 1iig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699634600; x=1700239400;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6Z/d/PlRIYV975I1CTJVwYo3Y8uvT4BaRAHDGx9VFCo=;
 b=LHabMDJVAWbDCNyQuMi00AGeYeGlqahXhn1WcNXDaggsFrFFd678y9rY577hPk5yuG
 mlUrARqR9x9hk+6lr1nhFYmR3hNT6Iij8u0S2tJqQ4v8v6qiBeZUfg+T1q7UzwTSaALG
 MmGZM6XuEMin91ndL5vnUMK36B/++wG794t4ogMyXP2M4OQiSBvEfoihr3t8rzPzMvwY
 fJgYpj3jMhTOcYICSwX0OW/JGfzk+fGOPyOGoJd5XeaxpOsLtASStmAaYhLfCb82+eZb
 0WcXktrLKETzTnNFPYGM3X38LWm/FCI+ECUuT99Wngb64gRwCt+0OaZYFk7Hj62xzcdl
 KbtA==
X-Gm-Message-State: AOJu0YxJr/0g+CrgbpS5kRj79k342ryx2LMIinZYknkAn/t4A9QvyMHq
 aHAj6GmzmQVHu8Lh5TFoe3qnqaH/rxzngAomcDE=
X-Google-Smtp-Source: AGHT+IGx5gc+JIu2aZBMQXpHFI/UqCkxNnckKmi5Lx2e4+ryDbsPkF/ivV3FxCrMYCvgyJB3V9qOxQ==
X-Received: by 2002:a5d:6c66:0:b0:32d:8819:4620 with SMTP id
 r6-20020a5d6c66000000b0032d88194620mr6701667wrz.14.1699634599977; 
 Fri, 10 Nov 2023 08:43:19 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 s8-20020adfea88000000b003196b1bb528sm2247958wrm.64.2023.11.10.08.43.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Nov 2023 08:43:19 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] hw/audio/es1370: Clean up comment
Date: Fri, 10 Nov 2023 16:43:18 +0000
Message-Id: <20231110164318.2197569-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

Replace a sweary comment with one that's a bit more helpful to
future readers of the code.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/audio/es1370.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/audio/es1370.c b/hw/audio/es1370.c
index 91c47330ad3..fad55412119 100644
--- a/hw/audio/es1370.c
+++ b/hw/audio/es1370.c
@@ -670,8 +670,13 @@ static void es1370_transfer_audio (ES1370State *s, struct chan *d, int loop_sel,
     cnt += (transferred + d->leftover) >> 2;
 
     if (s->sctl & loop_sel) {
-        /* Bah, how stupid is that having a 0 represent true value?
-           i just spent few hours on this shit */
+        /*
+         * loop_sel tells us which bit in the SCTL register to look at
+         * (either P1_LOOP_SEL, P2_LOOP_SEL or R1_LOOP_SEL). The sense
+         * of these bits is 0 for loop mode (set interrupt and keep recording
+         * when the sample count reaches zero) or 1 for stop mode (set
+         * interrupt and stop recording).
+         */
         AUD_log ("es1370: warning", "non looping mode\n");
     } else {
         d->frame_cnt = size;
-- 
2.34.1


