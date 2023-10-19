Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F477CFB4F
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:38:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtTCW-0002XG-I7; Thu, 19 Oct 2023 09:36:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qtTBw-0001zM-8z
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:36:02 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qtTBq-0001EF-T5
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:35:59 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-507cee17b00so1303952e87.2
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 06:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697722546; x=1698327346; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=j1tM+l52FnQrUD9wyepjhR0Rex/I2IZngyzPJkref1s=;
 b=Dp+OcxpNWjSL2Pk8wGLQab1wINoxX25lPkIec2Fo4NALdq3lKsMgW1lMp4PcJvC4GX
 mvoPl1VjDKF/ZyH2/mSdY4Jvmp58eHObCcqVfESt2TdgJD35ZYsfrTQf+6N8zv8Iodeu
 qfw0tCWxB/trmsjc3Ctv6zyFrNLcJM9FE1fAk3Ikq/sPeOF8hHJNF8m2q7WqUo3tPTcx
 /GYC+APwMf5afsQtj3jlKWBch2C/eSY9qjSCZ9uRdDVsY2WJfolGox9m+FmEwpqqheB8
 VVZAHHpZhbZ81tesEdOfdRphavztkRMRTZhzbsGbq00SQEIgH8P7VNGaNyTGTltFJejR
 GUbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697722546; x=1698327346;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j1tM+l52FnQrUD9wyepjhR0Rex/I2IZngyzPJkref1s=;
 b=OFk0Ga2s0Oqx8XTOJ90GcR6esMrNDlB0wA9qmBSdyyY3Yg6plRMFWd5cOFo8W5IN9E
 xfKc9tQhTOUYYj9jkIZa3S06iOU2SinabOul9l7wxTKfTPfzaFbsH7asot0DHzoJb+1e
 p2Yy8smDAIkzDL0gshjGUKMz6CuL2wQ/ldtoo1mavTcn4mBlyVr4C3Ypbye46on0GJDd
 OSMy6iYQ71q67J75cpSbY+6umK9W5hIP4Ivrj35cFTdPHFQIoBHU4clci3vy9HagvzLZ
 bKK2UIMnovJ1WayU//WoOJBFk4YxxfKqXBBJotD6ij5e57JL/MOQMajebVyz+vqWeKWQ
 cZfg==
X-Gm-Message-State: AOJu0Yz4caHjpT2MoudQ7wznYzmiIClZhQHhWHZkUdpxX3Ef7eU7l8l8
 OVsxlKc3kVKp7YxjdQB3S/ijdUv/wwS+8A+cKG4=
X-Google-Smtp-Source: AGHT+IEPPmy3XO7CkvaJPgIX8/kNbLc1SdyCNMRHeKA9KGJXQPmbcQeBXsWAgM/cR15ImEJNmoGBUg==
X-Received: by 2002:a19:5509:0:b0:500:9a45:63b with SMTP id
 n9-20020a195509000000b005009a45063bmr1430942lfe.13.1697722546661; 
 Thu, 19 Oct 2023 06:35:46 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 d28-20020adf9b9c000000b0031f3ad17b2csm4512690wrc.52.2023.10.19.06.35.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 06:35:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/24] hw/arm/smmuv3: Sort ID register setting into field order
Date: Thu, 19 Oct 2023 14:35:30 +0100
Message-Id: <20231019133537.2114929-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019133537.2114929-1-peter.maydell@linaro.org>
References: <20231019133537.2114929-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x131.google.com
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

In smmuv3_init_regs() when we set the various bits in the ID
registers, we do this almost in order of the fields in the
registers, but not quite. Move the initialization of
SMMU_IDR3.RIL and SMMU_IDR5.OAS into their correct places.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Mostafa Saleh <smostafa@google.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Message-id: 20230914145705.1648377-3-peter.maydell@linaro.org
---
 hw/arm/smmuv3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 6f2b2bd45f9..f03d58300fa 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -278,15 +278,15 @@ static void smmuv3_init_regs(SMMUv3State *s)
     s->idr[1] = FIELD_DP32(s->idr[1], IDR1, EVENTQS, SMMU_EVENTQS);
     s->idr[1] = FIELD_DP32(s->idr[1], IDR1, CMDQS,   SMMU_CMDQS);
 
-    s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, 1);
     s->idr[3] = FIELD_DP32(s->idr[3], IDR3, HAD, 1);
+    s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, 1);
     s->idr[3] = FIELD_DP32(s->idr[3], IDR3, BBML, 2);
 
+    s->idr[5] = FIELD_DP32(s->idr[5], IDR5, OAS, SMMU_IDR5_OAS); /* 44 bits */
     /* 4K, 16K and 64K granule support */
     s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN4K, 1);
     s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN16K, 1);
     s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN64K, 1);
-    s->idr[5] = FIELD_DP32(s->idr[5], IDR5, OAS, SMMU_IDR5_OAS); /* 44 bits */
 
     s->cmdq.base = deposit64(s->cmdq.base, 0, 5, SMMU_CMDQS);
     s->cmdq.prod = 0;
-- 
2.34.1


