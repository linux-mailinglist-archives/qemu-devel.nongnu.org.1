Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 162C3808C2E
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 16:48:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBGa3-0000m5-Ai; Thu, 07 Dec 2023 10:46:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rBGZl-0000fo-UW
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 10:46:13 -0500
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rBGZk-00029g-9w
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 10:46:09 -0500
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2c9bd3ec4f6so11245181fa.2
 for <qemu-devel@nongnu.org>; Thu, 07 Dec 2023 07:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701963965; x=1702568765; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kHtbNbE33I2d0hjrmbCtkemMmPZQwimW4EDhg2VKvrs=;
 b=Oi9JjzOsES0KBiBWv3TCkSa9CbLU48Vr+amo1RFXZEO9ALxrx+OO2w1e3Y4f9eVfvP
 r40OvDTDi/8jyJ615cKRYXpjgpaXtB0QLn+gMwdgZ50rb+ZYEfXRTkpWYG69BbG11hlj
 Z5YzUlaevHvj+EyLKVkF4fEc8pBIdeoxZ5BwvC2yq9Pr1lhOR9WkbR1M6BPrsPmoYX0/
 xh2KEPxnhcz9V3fk2ex/gFs/R74AUERDqjaLPoEjQd7/VS8W0UCk4LS8FdeHHz9MYqdo
 Do2ni5hDFlIaS1pWyHPoIE38ryryyM8KQyO7pDuGBF7xr6eHMXxdyZUdc9lXE/I1f7uJ
 pFfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701963965; x=1702568765;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kHtbNbE33I2d0hjrmbCtkemMmPZQwimW4EDhg2VKvrs=;
 b=GlAw4naClmCLChDTdV0PgAgL8Rh6vuMOhDjzVIIClS1AmKDk+I5Znh/RY6JLMnggvY
 zV6eML/UBTqjdchjWZVvwkvnwo66Bod3cgRCCy5YOUGFkq3AN3vBS+IJwsHe4KhaAN0b
 lK0+oGnXlqsCp9ts2LpQ8F5wr70ZzVDOkA/ccavBxXDqwFiIDgDkZB3tK1igwMgNfatw
 mMOPq3PjSt1IMObrNQbPsbTflXol/Z15A1PP69rOuCJP5DrAZzLpBHNnMkzLuCPsE1aY
 vsOfmnmHXmN2viFsKctYtuLrKi2+bcER1BB050e8OvWa6zdoRHDRZ3Cpe6S4fekWCzBJ
 qg0A==
X-Gm-Message-State: AOJu0Yz0+VGl1Lcs+qvzs8BE+DKQHJnesDY23v0mXDXB2jxR6NMencxu
 nk382vRIIsp3FEzWk1rYhmXoZ0J5hpVfELpHi1Q=
X-Google-Smtp-Source: AGHT+IHd2lg3ODNOvTYneXj74GHG0gL1tQHmJY+cgLagg76vLzcWXViVOOU+Cz0cmSTJcGZp90LdHA==
X-Received: by 2002:a19:ad44:0:b0:50b:f84a:5398 with SMTP id
 s4-20020a19ad44000000b0050bf84a5398mr916528lfd.89.1701963965573; 
 Thu, 07 Dec 2023 07:46:05 -0800 (PST)
Received: from m1x-phil.lan ([176.187.202.111])
 by smtp.gmail.com with ESMTPSA id
 e6-20020a1709067e0600b00a19afc16d23sm971415ejr.104.2023.12.07.07.46.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 07 Dec 2023 07:46:05 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Fam Zheng <fam@euphon.net>, Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 2/5] target/arm: Ensure icount is enabled when emulating
 INST_RETIRED
Date: Thu,  7 Dec 2023 16:45:47 +0100
Message-ID: <20231207154550.65087-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231207154550.65087-1-philmd@linaro.org>
References: <20231207154550.65087-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22d.google.com
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

pmu_init() register its event checking the pm_event::supported()
handler. For INST_RETIRED, the event is only registered and the
bit enabled in the PMU Common Event Identification register when
icount is enabled as ICOUNT_PRECISE.

Assert the pm_event::get_count() and pm_event::ns_per_count()
handler will only be called under this icount mode.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index adb0960bba..333fd5f4bf 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -940,11 +940,13 @@ static bool instructions_supported(CPUARMState *env)
 
 static uint64_t instructions_get_count(CPUARMState *env)
 {
+    assert(icount_enabled() == ICOUNT_PRECISE);
     return (uint64_t)icount_get_raw();
 }
 
 static int64_t instructions_ns_per(uint64_t icount)
 {
+    assert(icount_enabled() == ICOUNT_PRECISE);
     return icount_to_ns((int64_t)icount);
 }
 #endif
-- 
2.41.0


