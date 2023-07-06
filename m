Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96190749D93
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 15:27:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHOze-0005OU-4Z; Thu, 06 Jul 2023 09:25:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qHOzK-0004qw-5n
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 09:25:38 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qHOzE-0000sW-Vi
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 09:25:36 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3fbac8b01b3so16591105e9.1
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 06:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688649919; x=1691241919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=REQxdvHqMD5dtevjQjK3Wnx/HFYuQ118HppndU5qJ5M=;
 b=ooaS1xdbtay9lt4wBuU22N3LBehSNEH0DtKOj55QKGRf+kTMXWdvcJFbUVTlHmjNpW
 8eMgjJRy3xyfnUm+hsXmBnF+a9FJo90Y64YFEH+8/laKS4Um5+ipT3hDZmC86dh982FE
 X6cL84gD6nLCQfam/tEPVSxcCJsV2FFzPwTlyBx/B9BfTIkRfSHgECT3D4Blgxj7gHLj
 e9wBlEGEj/bNrwc2LSM63fMCylUezoi/OkUS/AC7xaU7hFptrC2Ya7Z2csrJhy41ofBz
 zDUlJkvkqHizB88jhMFmPMHfyo+l66CatKlk7wrAg/QeHnVXJlXMI2FE5ruV34yVE480
 oH8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688649919; x=1691241919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=REQxdvHqMD5dtevjQjK3Wnx/HFYuQ118HppndU5qJ5M=;
 b=bi3Ei8SJ0/dObqVo6miBDUM7U73cOBTlsbWhUOIIhSb5ynMX5QMu52ek/3Y9IGDIxS
 Ne3nMqWinmPctG9cn5qYGAaTR+BHl1y96B7Qh+/VCV1taFn+LT4O4pGKrrA/sioNqdZw
 TRy0PeL3FiNQJqVmIrEB40PxRtVZxvQxQSpm2MDj4MchquWVttzdM6sTtLuj8ORXYSG9
 V9yi2cJSk+Wwj8iq1dIHphX1vVNs7J80n06AQunO/iZYNVkSYYuX/Xeoy17D0yiF2ugE
 nshqYO+hR2/GX+I4eFzohITncAbn3Ygem/6OiFa3ZRsVn22elR+3tjQ5kd4G0Sjy4p2x
 Ob9w==
X-Gm-Message-State: ABy/qLbEYq0FerROdjVh0grqLqiO3kvNxyvOrDlbk9O3w/Z5s8KNoV5Q
 PE7gUO72fGJ24T6SZbVhJMAvh8MQSd2BC25oyP4=
X-Google-Smtp-Source: APBJJlGdHBLeLajFod82IG52SLmMAVTdXv6sJe8iXft4Cl72IZsqA5eIiLFPgij0pZXQ6xUi/Yj+7Q==
X-Received: by 2002:a05:600c:3582:b0:3fa:7bf0:7a81 with SMTP id
 p2-20020a05600c358200b003fa7bf07a81mr5359604wmq.0.1688649919112; 
 Thu, 06 Jul 2023 06:25:19 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 s15-20020a5d510f000000b00304adbeeabbsm1856170wrt.99.2023.07.06.06.25.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jul 2023 06:25:18 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/14] target/xtensa: Assert that interrupt level is within
 bounds
Date: Thu,  6 Jul 2023 14:25:09 +0100
Message-Id: <20230706132512.3534397-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230706132512.3534397-1-peter.maydell@linaro.org>
References: <20230706132512.3534397-1-peter.maydell@linaro.org>
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

In handle_interrupt() we use level as an index into the interrupt_vector[]
array. This is safe because we have checked it against env->config->nlevel,
but Coverity can't see that (and it is only true because each CPU config
sets its XCHAL_NUM_INTLEVELS to something less than MAX_NLEVELS), so it
complains about a possible array overrun (CID 1507131)

Add an assert() which will make Coverity happy and catch the unlikely
case of a mis-set XCHAL_NUM_INTLEVELS in future.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Acked-by: Max Filippov <jcmvbkbc@gmail.com>
Message-id: 20230623154135.1930261-1-peter.maydell@linaro.org
---
 target/xtensa/exc_helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/xtensa/exc_helper.c b/target/xtensa/exc_helper.c
index d4823a65cda..43f6a862de2 100644
--- a/target/xtensa/exc_helper.c
+++ b/target/xtensa/exc_helper.c
@@ -169,6 +169,9 @@ static void handle_interrupt(CPUXtensaState *env)
         CPUState *cs = env_cpu(env);
 
         if (level > 1) {
+            /* env->config->nlevel check should have ensured this */
+            assert(level < sizeof(env->config->interrupt_vector));
+
             env->sregs[EPC1 + level - 1] = env->pc;
             env->sregs[EPS2 + level - 2] = env->sregs[PS];
             env->sregs[PS] =
-- 
2.34.1


