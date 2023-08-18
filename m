Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE65D781541
	for <lists+qemu-devel@lfdr.de>; Sat, 19 Aug 2023 00:15:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX7iv-0004y3-TI; Fri, 18 Aug 2023 18:13:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX7ir-0004uu-Ot
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 18:13:37 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX7ip-0004Mp-J6
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 18:13:37 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1bdb7b0c8afso10566725ad.3
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 15:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692396814; x=1693001614;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I6X02LVpI5P8WuQzUwKS5BnSI2M4T9BPUj1SOf8BYZU=;
 b=goD9wkZDRtNDOM9+WspYHkRraN4HM4SMBd57Nh4DbLn7cuDB08p1o6wlTc7xrlB5Jf
 SLwEOL7xhFh3/REQqHixxKp7rRP3y3eS1zRXmMV7sG21abM/rmFXlidqLCRY0Q8Legb7
 2mqrjF+4a6CrlV6HwhIldDV9MEQUqxU7nIWhEGe22YzNr5uB4C+yYFP9M6pk+aj7coba
 8mqWzP4KQFqc3TABUIlhHR5hphWL8UpSprWclqWhjzOYGe9Mg+4ED/PwJX+LsDvP3w5a
 ZJ3FiIeujKI9jDC7NeXgoE6k+OhkT/urY0aiPF65PRLAVogyFS7rGxZaGAIIVBcch81R
 K/hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692396814; x=1693001614;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I6X02LVpI5P8WuQzUwKS5BnSI2M4T9BPUj1SOf8BYZU=;
 b=DU/jYySKEhnCZCGB+ykf/0g9Rv1WfE3qhDQ8zLdXO7RBCP05G8YEKGjrl1Ok1E9sSi
 qZUtTTS//Qs9A4Gp6fy0tD8tAi3ESwvREwmMscSKUgQAn3gH9L0hwPcSugdlX14Zv/ww
 zdG9eRN0WSJ7tyZMKI2TapsAPJ4DuCGfY/cdqWaC8G4ZLgZf9cRZQ29LTmMO9C0NAatj
 y6PDWc2WlaHu1daqm5ZWgY9frZTvdyMBMqYQgMZRZWojbXB9yhj/BuIc7ZPsLzLQgjtk
 koCeiOM4I6bKz+3GTooiyWmG7b5mQOFq0Sx9PfB8+mAbh1GK/FcbuH0KSLBp8dDc4X3a
 e5og==
X-Gm-Message-State: AOJu0YyQ/JoyyIudpPa1HfjqLuO3s7UW3l6/yDVsay9+bEIvREPwDZTe
 19ThHCWCVwJg975Um9NnJCI3NoD+0ptn9hQ0YLk=
X-Google-Smtp-Source: AGHT+IHqMcOW8jNYBApUJL5il3jQ/KuU/rGd14a69UezSsBQtjeafUUsgzu6gzinaAV7TKauRve7BA==
X-Received: by 2002:a17:902:dad1:b0:1bc:afa:95a6 with SMTP id
 q17-20020a170902dad100b001bc0afa95a6mr554168plx.40.1692396814214; 
 Fri, 18 Aug 2023 15:13:34 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 y7-20020a17090322c700b001bdb85291casm2231417plg.208.2023.08.18.15.13.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 15:13:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 06/23] target/openrisc: Use tcg_gen_negsetcond_*
Date: Fri, 18 Aug 2023 15:13:10 -0700
Message-Id: <20230818221327.150194-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818221327.150194-1-richard.henderson@linaro.org>
References: <20230818221327.150194-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/openrisc/translate.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index a86360d4f5..7c6f80daf1 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -253,9 +253,8 @@ static void gen_mul(DisasContext *dc, TCGv dest, TCGv srca, TCGv srcb)
 
     tcg_gen_muls2_tl(dest, cpu_sr_ov, srca, srcb);
     tcg_gen_sari_tl(t0, dest, TARGET_LONG_BITS - 1);
-    tcg_gen_setcond_tl(TCG_COND_NE, cpu_sr_ov, cpu_sr_ov, t0);
+    tcg_gen_negsetcond_tl(TCG_COND_NE, cpu_sr_ov, cpu_sr_ov, t0);
 
-    tcg_gen_neg_tl(cpu_sr_ov, cpu_sr_ov);
     gen_ove_ov(dc);
 }
 
@@ -309,9 +308,8 @@ static void gen_muld(DisasContext *dc, TCGv srca, TCGv srcb)
 
         tcg_gen_muls2_i64(cpu_mac, high, t1, t2);
         tcg_gen_sari_i64(t1, cpu_mac, 63);
-        tcg_gen_setcond_i64(TCG_COND_NE, t1, t1, high);
+        tcg_gen_negsetcond_i64(TCG_COND_NE, t1, t1, high);
         tcg_gen_trunc_i64_tl(cpu_sr_ov, t1);
-        tcg_gen_neg_tl(cpu_sr_ov, cpu_sr_ov);
 
         gen_ove_ov(dc);
     }
-- 
2.34.1


