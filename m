Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C037D03F5
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 23:25:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtaQs-0006sG-Nb; Thu, 19 Oct 2023 17:19:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtaQm-0006iB-6d
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:19:49 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtaQj-00056o-ST
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:19:47 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40806e4106dso938345e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 14:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697750384; x=1698355184; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MEQ8PJ+7/tWDp1e1acSYNFj06Phs17Z7XzBWfANn630=;
 b=yDViE9tQp/gicWUGWWdsRr1qTN+E5FmiOiHU/JDklz1PZSTagLoPj2z+4vxHlrpTtb
 1YmOacRZGynauV5AFHqK8ZnWXRZTEQoWOiqMvWpOr/jsk9yWed86kPLhVopuPM4WKcT7
 pjp/fneWJM25xnadFndmf7W5aCCQpUTafpjByR5WubaPVWI6dAC/NiPP2P9VbHa1Z93U
 d3rfRWE3HSKkqDrdhCf5ELTVylBgJELfzBGPPWvz8XrpffVDjKwF1Fbgx8YCXVusyzO6
 VwrXb2xUth1IdHfCKTB3a8yS+v4AFqrEJJgi8nG7jNIs8tcFaGwN8Mf8GkTys8NVrjvn
 AG8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697750384; x=1698355184;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MEQ8PJ+7/tWDp1e1acSYNFj06Phs17Z7XzBWfANn630=;
 b=jmDyyeZYQ0rL0kWaftF9QmtIbaaxf8XB1LFdJZfjbcVw09EkwY5g7MogCOGF1ER+R8
 vl121o/27eMH+JCGSKaXa72gWiMT3CJiOwQMtcB4g/ZTH6Hey+HHqk4+0XBxUY5aQ/uB
 gWc34VuMMa9JtJJ5w8ZLVcWSSIWIOMYbMNwiiqRcihAQ7/GGEEaHi6L2Z4fO5BAEPl+a
 dsJJ1UHu90C5+8+RDch4soW0/512ipfLMUUm4ZS45OD2AUIYniPwKPVm57RU1v0Anz++
 SU7fdF9l5cMbC5s898Cj9K69LwCP30RUerhUu++CMgwbx5edC3ULR63duHstHKID/H0l
 Do1w==
X-Gm-Message-State: AOJu0Yx+C9Kr1P/faPkKXtzK1hZG62vmiLdgYjet4PkgiQAklQ0Fot+V
 gf/r022l4ZGDfSML0Vq6kUeSS00s9xG/OW5Ilf1v8Q==
X-Google-Smtp-Source: AGHT+IHGW8tdsnslQuA5SeoNb3+2SxI2qTdy2Moze5rnGaD/CEaIzdQttIMSg1XOvdEc91qE5zXw9A==
X-Received: by 2002:a05:600c:3b20:b0:402:f91e:df80 with SMTP id
 m32-20020a05600c3b2000b00402f91edf80mr2978322wms.3.1697750384014; 
 Thu, 19 Oct 2023 14:19:44 -0700 (PDT)
Received: from m1x-phil.lan (176-131-216-177.abo.bbox.fr. [176.131.216.177])
 by smtp.gmail.com with ESMTPSA id
 e16-20020adfe390000000b0032dab20e773sm214722wrm.69.2023.10.19.14.19.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Oct 2023 14:19:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-block@nongnu.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Subject: [PULL 13/46] hw/misc/mips_itu: Declare itc_reconfigure() in
 'hw/misc/mips_itu.h'
Date: Thu, 19 Oct 2023 23:17:38 +0200
Message-ID: <20231019211814.30576-14-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019211814.30576-1-philmd@linaro.org>
References: <20231019211814.30576-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

We already provide "hw/misc/mips_itu.h" to declare prototype
related to MIPSITUState. Move itc_reconfigure() declaration
there.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20231009171443.12145-3-philmd@linaro.org>
---
 include/hw/misc/mips_itu.h          | 2 ++
 target/mips/cpu.h                   | 3 ---
 target/mips/tcg/sysemu/cp0_helper.c | 1 +
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/hw/misc/mips_itu.h b/include/hw/misc/mips_itu.h
index 35218b2d14..a413789151 100644
--- a/include/hw/misc/mips_itu.h
+++ b/include/hw/misc/mips_itu.h
@@ -79,4 +79,6 @@ struct MIPSITUState {
 /* Get ITC Configuration Tag memory region. */
 MemoryRegion *mips_itu_get_tag_region(MIPSITUState *itu);
 
+void itc_reconfigure(struct MIPSITUState *tag);
+
 #endif /* MIPS_ITU_H */
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index fb44defc93..5fddceff3a 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1350,9 +1350,6 @@ void cpu_mips_soft_irq(CPUMIPSState *env, int irq, int level);
 void cpu_mips_irq_init_cpu(MIPSCPU *cpu);
 void cpu_mips_clock_init(MIPSCPU *cpu);
 
-/* mips_itu.c */
-void itc_reconfigure(struct MIPSITUState *tag);
-
 #endif /* !CONFIG_USER_ONLY */
 
 /* helper.c */
diff --git a/target/mips/tcg/sysemu/cp0_helper.c b/target/mips/tcg/sysemu/cp0_helper.c
index 5da1124589..d349548743 100644
--- a/target/mips/tcg/sysemu/cp0_helper.c
+++ b/target/mips/tcg/sysemu/cp0_helper.c
@@ -28,6 +28,7 @@
 #include "qemu/host-utils.h"
 #include "exec/helper-proto.h"
 #include "exec/exec-all.h"
+#include "hw/misc/mips_itu.h"
 
 
 /* SMP helpers.  */
-- 
2.41.0


