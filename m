Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9995A7799B1
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 23:42:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUZsL-0003Ew-83; Fri, 11 Aug 2023 17:40:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUZsF-00038I-Dk
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 17:40:47 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUZsB-00027t-Bz
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 17:40:46 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2685bcd046eso1447568a91.3
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 14:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691790034; x=1692394834;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eTuKKiSegzQEbnvvYT6CJI40e4ypa3cKogfhwjbLuHI=;
 b=WodSzjzoN3Sc2TEfWLIQKuCtWiWlkTFWoqqX5mWvKZQNmFqrk7I5G9lvEmFZ7+bkLC
 FGFZKk5c8E323eLAfctPr0aaUWq+dmQbcMn8SPbqMSvU67i1kXt15GS6Q8ocyi/Xg8qV
 F/P7p/vsbqNvm1n4lPCdlZWmEjGhh1IlZa+S0GXszHcEtw+BBQrClPx2kr8ukHFrWehj
 6cMG/zi59o8lMQYeHun5lWLY4duuPueuoE6GM6MNM21cP4bIg3y1bKxh6yWRcUvoLOxc
 tXRsF+FRd/ryyovS1fpsN+9qhBYoHl8JoG0JKm4qzFUQqzFT39KIHuIUmOqFN+qRN3vo
 S9mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691790034; x=1692394834;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eTuKKiSegzQEbnvvYT6CJI40e4ypa3cKogfhwjbLuHI=;
 b=XKZ+nZvr9vAvto1+7wO5zcNQaIOa9eeS60aJTdqq3jPQxF8s90NYuyAnPMVSle6KlL
 UhxGBRR1G9TQ+g7P7yZmp6gVUXHkghEMwRLRcNUy09fWgZ2u5sWBdXcW+82zHUTxW2aC
 CmhCTjcphYZ301etVgFzyKxMPN4f5s48B4lmwNX33D6QbEgEgEXT7BkJDB6EVWz/JRwM
 ddtwxlnfrjYwV7RgeV7MhQcRNDCYTPsDZdCOvgeA9uX8FEQ0T3q6y/ZqIT5JAvk+NlBK
 kFLbnT072Yt+NtJ/Jc9/U6Yn1Ky5XvbpS3W2SR81VnZIZ3y95EMohpRlaPJViDnfEQpL
 Ohtw==
X-Gm-Message-State: AOJu0Ywh2mJKjhC03iQJMj523kQyIi4BS/xUnytOhDQe6EiRguxTpT3V
 gKhWhleziIZULL7fkfYV4lGEYdhI5d8I/39SarQ=
X-Google-Smtp-Source: AGHT+IHZ5O5WRsp+GKw44EZyIj3bh3Fq0TEGejZlf+i/Vhplx/N6+lZL2AO5uaAfbjABUJVhzVsvgg==
X-Received: by 2002:a17:90b:2390:b0:26b:e80:11de with SMTP id
 mr16-20020a17090b239000b0026b0e8011demr2237904pjb.25.1691790033796; 
 Fri, 11 Aug 2023 14:40:33 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:e773:351d:2db2:8a8a])
 by smtp.gmail.com with ESMTPSA id
 gk18-20020a17090b119200b00263ba6a248bsm5723840pjb.1.2023.08.11.14.40.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Aug 2023 14:40:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 01/11] target/arm: Reduce dcz_blocksize to uint8_t
Date: Fri, 11 Aug 2023 14:40:21 -0700
Message-Id: <20230811214031.171020-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230811214031.171020-1-richard.henderson@linaro.org>
References: <20230811214031.171020-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

This value is only 4 bits wide.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 88e5accda6..7fedbb34ba 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1074,7 +1074,8 @@ struct ArchCPU {
     bool prop_lpa2;
 
     /* DCZ blocksize, in log_2(words), ie low 4 bits of DCZID_EL0 */
-    uint32_t dcz_blocksize;
+    uint8_t dcz_blocksize;
+
     uint64_t rvbar_prop; /* Property/input signals.  */
 
     /* Configurable aspects of GIC cpu interface (which is part of the CPU) */
-- 
2.34.1


