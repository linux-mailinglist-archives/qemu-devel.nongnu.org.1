Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E3F7799B2
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 23:42:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUZsN-0003G6-4O; Fri, 11 Aug 2023 17:40:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUZsF-00039B-R4
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 17:40:47 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUZsB-00028L-DH
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 17:40:47 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-269304c135aso1678136a91.3
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 14:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691790036; x=1692394836;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3XmEXwWgr34F4lUBgO2f5fSa8ByD9tZ8lTL3vDvsP/s=;
 b=f10TfHzvb/6L1OCjgwbEDfFJo7Li5Bw+QYVUX1nMhsCUYFbsS6XnZ/aBe6jF3QlWUG
 w1UioYaRLdAF7Mhl+9mvI6ityFYrO1v6jnJnMqnCWBQtoEQ1JIcd37jvkSJ+BqJWWWOp
 nNA3CByRYEKSqZgAf4MD24uXQWzCUe4i3XPCOYjNTCnUD0WsA6dIXDw5SIaKhItf02yK
 JyRGmz4vc8uLY9kv1YLopjIE546aD9MUoiNVl8b5Z4Y25/AF3HH2XnUR7cnUnXkZxng9
 VT6dJSuO2lJtWzhub7h5fJbDn+hqtkcDm9AZ69oquLu6+ogx4jLiR4KfRVJxMhWcdSKL
 gO9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691790036; x=1692394836;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3XmEXwWgr34F4lUBgO2f5fSa8ByD9tZ8lTL3vDvsP/s=;
 b=dgZn7fvCto1LkvyOTE2rQIQqcD4smlqD5PXZ5r1oSasNw4AMx5CQMvkYVeYoeXF+cQ
 Nb6qTCYUv80ees12Q6q3eTPDEP4fWWxwSqiqSwMxXYP3dq/RmSfUkFBOhF+yfJCm5nHA
 Gt0gKgyETHuSV4yUdoHbsuT+/7VnsH5CuE4WOrkSH/eTpzvmGX99hZW7TpaahRGu6Ob/
 xtkdG11ansjE+luPWzSKxuka9ONQ1uVxN+aUJf6ocHrbXP0AWPtwVPSOdYmh3qLyaT9b
 sRFPnN56OE5PFA2xgTSxQSYj42lR6S8ET/zhiSsIy+M4paxcKxFkp3aDvTRZCWFYpQQ1
 wOTg==
X-Gm-Message-State: AOJu0YzRvsKVV0AC9vi6ole0CXmwGYWj162IqVAeVLDwC5l/yVTs9cnr
 0QliMjlYpw/01n650e/RXjQMGpLX4ojhmoUd+P8=
X-Google-Smtp-Source: AGHT+IEZNbFeahAut9MV0IzPH+vFij3U3PH3WYklWeFKTWdqnzFhEpaGojZUqfNCwSyU9BRuFITO3Q==
X-Received: by 2002:a17:90b:3e86:b0:269:1d16:25fa with SMTP id
 rj6-20020a17090b3e8600b002691d1625famr2662413pjb.12.1691790036619; 
 Fri, 11 Aug 2023 14:40:36 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:e773:351d:2db2:8a8a])
 by smtp.gmail.com with ESMTPSA id
 gk18-20020a17090b119200b00263ba6a248bsm5723840pjb.1.2023.08.11.14.40.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Aug 2023 14:40:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 04/11] target/arm: When tag memory is not present, set MTE=1
Date: Fri, 11 Aug 2023 14:40:24 -0700
Message-Id: <20230811214031.171020-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230811214031.171020-1-richard.henderson@linaro.org>
References: <20230811214031.171020-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

When the cpu support MTE, but the system does not, reduce cpu
support to user instructions at EL0 instead of completely
disabling MTE.  If we encounter a cpu implementation which does
something else, we can revisit this setting.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 37e8c35677..85c02308e4 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2067,12 +2067,13 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
 
 #ifndef CONFIG_USER_ONLY
         /*
-         * Disable the MTE feature bits if we do not have tag-memory
-         * provided by the machine.
+         * If we do not have tag-memory provided by the machine,
+         * reduce MTE support to instructions enabled at EL0.
+         * This matches Cortex-A710 BROADCASTMTE input being LOW.
          */
         if (cpu->tag_memory == NULL) {
             cpu->isar.id_aa64pfr1 =
-                FIELD_DP64(cpu->isar.id_aa64pfr1, ID_AA64PFR1, MTE, 0);
+                FIELD_DP64(cpu->isar.id_aa64pfr1, ID_AA64PFR1, MTE, 1);
         }
 #endif
     }
-- 
2.34.1


