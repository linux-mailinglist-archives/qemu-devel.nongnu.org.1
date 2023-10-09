Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 685D47BE77F
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 19:16:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qptqk-0004IG-7U; Mon, 09 Oct 2023 13:15:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qptqf-0004H2-7M
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 13:15:19 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qptqa-0001Qd-BF
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 13:15:16 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-536b39daec1so8146484a12.2
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 10:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696871703; x=1697476503; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PeZLMWVBcIq2AL5jS2WYOBrnjRfadpnh5KEt1PKPozs=;
 b=wkROtT7EuYRh2NoUjFNlTIsB1I2wklm+gYjvOQCSqT1NRWkUZnZgvg+CFgWxVouIwP
 RUhdVNVhbwobcBQrmEAL5mQiDq89A8HxcxDsypEf8+GJzJzxwaYbhT1ovR6hQC1CzLyn
 BY9sed9w4RrWSgBKh7Xyp1Wcoub9FdhRdqBAad2mvW/r801vZtiJDRvGW+9d0T/w+R8I
 UP4iYkOFHZTXxxrpMXzjxJMAJm9soSrtFMrlkJEo7UpU7c3s2mgFL72DzpPmEIEfuwGd
 SjAQbtncvEQBHYLCLfQLAFM3QXoxDPpLO/TrMvB6nH6dKmM0Ff9VuSwfDl5yjJyQXtgy
 /Mxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696871703; x=1697476503;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PeZLMWVBcIq2AL5jS2WYOBrnjRfadpnh5KEt1PKPozs=;
 b=bmarJEZrWG8607Sv4WR2UbUXs4deogrBA76Mdg126IejOSBKuos4LXuMfLLVTwn0pl
 GMFsQcX97tXXuC2kWpAn0KIHg+wvh44cAA3JXviTt940Ys3wsuY6u/iD4xNPmp9oMzuw
 6nzSIfmkgbViesexgQ0vlxgKzzcpbzoVPl97JaT5AU4Zso2ZNDH6TuexVf2GAy3jkmR1
 UdXeeXEvDrpY8pTu9YEE3Q48Lc4Fn780doKigJBveL1Sg5z28kY/fpFxN5ln6IHmCcgV
 Oy0RGxAL4PtZV0jKiNihGnvXHhkGeSTo4Ln4oOlB2oEcjuKsC/b3YaSjypsr6YVHAsFb
 aXXg==
X-Gm-Message-State: AOJu0Yw+X2kE5nBwXcreI8gJkdlEEWEddr9A5IMxnu6j46P8hAetXyNG
 ekwLU3YGqi1dJCWmWOKQUyyDQvmVdJVNbDmxM6Q=
X-Google-Smtp-Source: AGHT+IERpTp4GJSMyxMDnOGVGwLGUhGLXeSpgxwVaNHDny0rDLELHcvdNPAE6nXCnxaqU6PbtKIcKQ==
X-Received: by 2002:a05:6402:389:b0:530:8897:f0e9 with SMTP id
 o9-20020a056402038900b005308897f0e9mr13757593edv.21.1696871703530; 
 Mon, 09 Oct 2023 10:15:03 -0700 (PDT)
Received: from m1x-phil.lan (thr44-h01-176-170-217-185.dsl.sta.abo.bbox.fr.
 [176.170.217.185]) by smtp.gmail.com with ESMTPSA id
 u5-20020aa7d545000000b00534e791296bsm6339002edr.37.2023.10.09.10.15.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Oct 2023 10:15:03 -0700 (PDT)
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
Subject: [PATCH 3/3] hw/misc/mips_itu: Make MIPSITUState target agnostic
Date: Mon,  9 Oct 2023 19:14:43 +0200
Message-ID: <20231009171443.12145-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231009171443.12145-1-philmd@linaro.org>
References: <20231009171443.12145-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x532.google.com
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

When prototyping a heterogenous machine including the ITU,
we get:

  include/hw/misc/mips_itu.h:76:5: error: unknown type name 'MIPSCPU'
      MIPSCPU *cpu0;
      ^

MIPSCPU is declared in the target specific "cpu.h" header,
but we don't want to include it, because "cpu.h" is target
specific and its inclusion taints all files including
"mips_itu.h", which become target specific too. We can
however use the 'ArchCPU *' type in the public header.
By keeping the TYPE_MIPS_CPU QOM type check in the link
property declaration, QOM core code will still check the
property is a correct MIPS CPU.

TYPE_MIPS_ITU is still built per-(MIPS)target, but its header
can now be included by other targets.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/misc/mips_itu.h | 2 +-
 hw/misc/mips_itu.c         | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/hw/misc/mips_itu.h b/include/hw/misc/mips_itu.h
index a413789151..5caed6cc36 100644
--- a/include/hw/misc/mips_itu.h
+++ b/include/hw/misc/mips_itu.h
@@ -73,7 +73,7 @@ struct MIPSITUState {
 
     /* SAAR */
     uint64_t *saar;
-    MIPSCPU *cpu0;
+    ArchCPU *cpu0;
 };
 
 /* Get ITC Configuration Tag memory region. */
diff --git a/hw/misc/mips_itu.c b/hw/misc/mips_itu.c
index 0eda302db4..5a83ccc4e8 100644
--- a/hw/misc/mips_itu.c
+++ b/hw/misc/mips_itu.c
@@ -532,7 +532,7 @@ static void mips_itu_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    env = &s->cpu0->env;
+    env = &MIPS_CPU(s->cpu0)->env;
     if (env->saarp) {
         s->saar = env->CP0_SAAR;
     }
@@ -563,7 +563,7 @@ static Property mips_itu_properties[] = {
                       ITC_FIFO_NUM_MAX),
     DEFINE_PROP_UINT32("num-semaphores", MIPSITUState, num_semaphores,
                       ITC_SEMAPH_NUM_MAX),
-    DEFINE_PROP_LINK("cpu[0]", MIPSITUState, cpu0, TYPE_MIPS_CPU, MIPSCPU *),
+    DEFINE_PROP_LINK("cpu[0]", MIPSITUState, cpu0, TYPE_MIPS_CPU, ArchCPU *),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.41.0


