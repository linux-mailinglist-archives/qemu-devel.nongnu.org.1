Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D1C729F4C
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 17:55:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7eS8-0001kE-1f; Fri, 09 Jun 2023 11:55:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q7eS6-0001k4-BV
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 11:55:02 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q7eS4-0004wF-LJ
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 11:55:02 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-30b023b0068so1505661f8f.0
 for <qemu-devel@nongnu.org>; Fri, 09 Jun 2023 08:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686326099; x=1688918099;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gzyK1+R1Q0PBbWpAgX7HkHDOH+bFjjAYfW6YaQlCD2E=;
 b=L9OOa69oHb1k9ANzMZQXMiQZwzh8/3t2DSlz9zLXYsph7ulDJXuRW2o7lsKWY5kUV3
 9Ki4K2wA8AGoB9rUkmaR3LFbT9wH9WZCwLX/4XowVKNO8PT4HbjpNMMmcwWIF0dKl6vK
 5ObQKvphiQFF43RctanL04A93MdNPRSn7x2uD+FsdYVFxc8D+1Hwzl6Njc/+kv7FQRbQ
 qPG2ojgYc/6tpQH4cTfAKQatfLkoAUleVyCEEo0DVpgAh4V5FkeyHZFZsfFSgg7fLzx3
 p9gMpKc5VDVL1XTY4yWH4nFo6JavqkMh7vnsLISmgpMtz4SHyuYkFWkdCVDr6kT0E1l6
 teMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686326099; x=1688918099;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gzyK1+R1Q0PBbWpAgX7HkHDOH+bFjjAYfW6YaQlCD2E=;
 b=bpHg9EU1lVsN0CA4YV6krx+zm4gLqey1nnTN7l4XlCfp4Dvy6hBJyYcraIV/IJOv9D
 gj2Ei6K8lsTDRQsbLNdw9MaQI9TDRT/H5J1Kw/ZZQKM89hDfrpdSOou9U/KhJmydrm8P
 lzXehPY+CJ6xE75VFFJiLaNvcjIAF0iqzEA95HPFaYLeVVaOv+7fjn/4Za1kMaV8R6oZ
 yfcWwp1hf1r6xcTNCp0G9VH+Oi2wy4xRKkLHBIsPaLTnL2I478jzMMsmHF7YgiN+lJ+2
 tEeC/ZXqDaPS9N/RHys2EMyvtrivanxRtajF//DfxzEoD+DB88C/aC3BSftjd5NMr8uv
 zulQ==
X-Gm-Message-State: AC+VfDxEV87J/+ns+BcjC4tDTgJA4a5/UOw/02XGTGO5hzvymHdCXYaf
 vcrqUOIFxqaiAE73yIuSKOMi9Q==
X-Google-Smtp-Source: ACHHUZ6bNoC3bcjz9Ihm0nNsbTDy+hJ9LSYsCDCvK+9Jg0L4gCx/GBGkm+Bub6pvcNUOEcJDAXbevg==
X-Received: by 2002:adf:dd8d:0:b0:303:daff:f1a3 with SMTP id
 x13-20020adfdd8d000000b00303dafff1a3mr4556477wrl.1.1686326099189; 
 Fri, 09 Jun 2023 08:54:59 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 u26-20020a05600c211a00b003f42314832fsm3097686wml.18.2023.06.09.08.54.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Jun 2023 08:54:58 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
	qemu-stable@nongnu.org
Subject: [PATCH] target/arm: Return correct result for LDG when ATA=0
Date: Fri,  9 Jun 2023 16:54:57 +0100
Message-Id: <20230609155457.87848-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

The LDG instruction loads the tag from a memory address (identified
by [Xn + offset]), and then merges that tag into the destination
register Xt. We implemented this correctly for the case when
allocation tags are enabled, but didn't get it right when ATA=0:
instead of merging the tag bits into Xt, we merged them into the
memory address [Xn + offset] and then set Xt to that.

Merge the tag bits into the old Xt value, as they should be.

Cc: qemu-stable@nongnu.org
Fixes: c15294c1e36a7dd9b25 ("target/arm: Implement LDG, STG, ST2G instructions")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Spotted this while I was doing decodetree conversion stuff.
I guess nobody runs with MTE available but not turned on :-)
---
 target/arm/tcg/translate-a64.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index aa93f37e216..9ead91a450b 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -4187,9 +4187,13 @@ static void disas_ldst_tag(DisasContext *s, uint32_t insn)
         if (s->ata) {
             gen_helper_ldg(tcg_rt, cpu_env, addr, tcg_rt);
         } else {
+            /*
+             * Tag access disabled: we must check for aborts on the load
+             * load from [rn+offset], and then insert a 0 tag into rt.
+             */
             clean_addr = clean_data_tbi(s, addr);
             gen_probe_access(s, clean_addr, MMU_DATA_LOAD, MO_8);
-            gen_address_with_allocation_tag0(tcg_rt, addr);
+            gen_address_with_allocation_tag0(tcg_rt, tcg_rt);
         }
     } else {
         tcg_rt = cpu_reg_sp(s, rt);
-- 
2.34.1


