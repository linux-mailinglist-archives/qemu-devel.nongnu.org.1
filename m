Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 762397BE780
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 19:16:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qptql-0004IX-AS; Mon, 09 Oct 2023 13:15:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qptqa-0004Ft-IA
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 13:15:19 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qptqP-0001F7-Va
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 13:15:08 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-9936b3d0286so864265466b.0
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 10:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696871698; x=1697476498; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fbvzk8w4yOrUuIdaZAWtNHnxqM3Ns8E/x7P8LC66JEg=;
 b=VVgUntWViajyAgunUMxqgJDuQQnFe8UpRuVTEI38VvXmyhKYrtJLbnwHz9gUEMM/At
 LdiXmW+/EVbX/nyKdsG6ELoYETLQdtQswRvg7I1KTrtX2zU6/p4veezIahvW8q6IuIdh
 hskT3TvBia08yqIfot6CYEOjcbIupUDeBaFyViUKZQzBlIWe6HNVhqniBCHQFXq8ZYwK
 Ad+1SSH053NBizVmiyDehEdcUmaDVhECBSUz1E17ICTZD1XtNLrSRK4sLsLrytngBMmu
 6huCGo4FlBgO85WR7kzXZxuWLr+ifQsAwjsEnETRhCe+h+AEnFK/7ylLsY+Qhu//bBZz
 e7vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696871698; x=1697476498;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fbvzk8w4yOrUuIdaZAWtNHnxqM3Ns8E/x7P8LC66JEg=;
 b=wtbBF5oaLoFH5/SGWZxaL/vfmKLUzotm8CI7neSFUgGABLhfJb/7Ik/aU2cbFYbaON
 xjkX6KPfiGZj2knR8Lef6VKXb3tJktw/StZ9Xqhb/KJuilTf9GDTpnguLP4xd/LEtywX
 FksGkIxHWS8IPV1HzrQes+C4ppd5WcJSj5Xl2Qk6gsshLESbVRFPr7+F/7+5uloYuvTA
 EVQMrqq2tynZCVyH0Epu95p8rv/1RvwWlJJU5lpRZKKeAxjXqDxbk5stMV1oBCqxDOaz
 YcQQWjjM7l7yx4pi46FbCur6jUAS2gHZoAQ1NmW+Sj+OFxG1AASKaDIL8/s5VEncX8fK
 a0Mg==
X-Gm-Message-State: AOJu0YxfYL8HU76dM3Ck9PuwUb5QvgTWIJN4zdhEYRPpshqTamPXPVQA
 j669SrQ448e9FB+cIj+HgOX8SErcua/QOFQK2Qc=
X-Google-Smtp-Source: AGHT+IHNdmx/1Onvq6fbpuHAxJ1/nuku/fNs8c/6zENyED/yxAu7gtvKT/PUI/dn/O9AvR893T+q+w==
X-Received: by 2002:a17:906:9c1:b0:9ae:5aa4:9fa with SMTP id
 r1-20020a17090609c100b009ae5aa409famr14158989eje.42.1696871698001; 
 Mon, 09 Oct 2023 10:14:58 -0700 (PDT)
Received: from m1x-phil.lan (thr44-h01-176-170-217-185.dsl.sta.abo.bbox.fr.
 [176.170.217.185]) by smtp.gmail.com with ESMTPSA id
 e25-20020a1709062c1900b009adc77fe164sm7045575ejh.66.2023.10.09.10.14.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Oct 2023 10:14:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>
Subject: [PATCH 2/3] hw/misc/mips_itu: Declare itc_reconfigure() in
 'hw/misc/mips_itu.h'
Date: Mon,  9 Oct 2023 19:14:42 +0200
Message-ID: <20231009171443.12145-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231009171443.12145-1-philmd@linaro.org>
References: <20231009171443.12145-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
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

We already provide "hw/misc/mips_itu.h" to declare prototype
related to MIPSITUState. Move itc_reconfigure() declaration
there.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


