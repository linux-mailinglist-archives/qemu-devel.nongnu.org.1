Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 98656825716
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 16:50:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLmNR-000881-SI; Fri, 05 Jan 2024 10:44:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLmNN-0007sy-P8
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 10:44:49 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLmNH-0003M3-30
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 10:44:49 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3367601a301so1314157f8f.2
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 07:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704469481; x=1705074281; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u+LOg4cE3e/L+FkF/kdo/NDds7gIy3v+MrTgt4iIEa4=;
 b=n5kSfdb/lfP7oDDbyCG5oqr7XHssSJaEsPSnUqsTFei00qGvkLC5F377mhnpJvZE/v
 pe1zbxhC7rYsHfDr+65vayV6/AelRC1ynexpKTGiDSUJddWM6m/EpBQ/fCL/rFzq429v
 Ies5iUwKXbTH0oWxDVWR8sIqeA8DYXe/lkEy4V63Uw4u6nQcsA+Ux6uvLRFawF55WJKF
 XOOVx3bzHJaD8hdAwnT7WpEtelvVEmbKO0kap2TItCVTL5G24Prh+j14VtxOnPm8/QNR
 PKbWArQzkF2Aj28LuacMuelFJJFoV5OHawvWr39qMV+4vM0libGicCScHhvOfzhpSTP7
 4Rzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704469481; x=1705074281;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u+LOg4cE3e/L+FkF/kdo/NDds7gIy3v+MrTgt4iIEa4=;
 b=MlNPBC+zDVW46Hdqjz9Xwek47oLciFX+C6MibV17yQ7xTYlE4X1YAOZ7Q97OqBjAVz
 ObC5Tg6yiYA7A4zxs3cPpldujOnsNi2XPfbXz4ZnB8FDyq8bWJZ41baqiIN76xf2hnj4
 3BFFS8Pqi6qAJ2vZsiIBMfBy8W3EJHNNdQ6t3WmhnFoUd58nanGB/WC5+3V9bG6dBPxG
 hNVrct319pX+aGQGWxwhhQB6tRr1bwgYwZD/0FJPTI1zsj6aPlUMCI7ZTHHqX96tM6XZ
 EPEKIU+d4+KarC5uRh5sJmxF4W+hwZ9S17Ixpv5U4JOFTVHywzqZQ1SVs6dce9Pg3EoP
 TrIw==
X-Gm-Message-State: AOJu0YwfMgkU7XXSsgoXXWiO0qZJuZRMEuuGBIM5FQswviurfrLHBuVZ
 GHcEAQ6nssAHHx6FmdL4xWO/yu4FjXlMDjeGYLwYPbRdjH0=
X-Google-Smtp-Source: AGHT+IEarfJTD405bI94EVCg55vrH/dVFfv8hgbjU6uLDA50z0vQRFzAKUVK9+a0lSmqXfes6+iuWw==
X-Received: by 2002:a5d:6445:0:b0:337:4e86:ebe1 with SMTP id
 d5-20020a5d6445000000b003374e86ebe1mr837995wrw.42.1704469481467; 
 Fri, 05 Jan 2024 07:44:41 -0800 (PST)
Received: from m1x-phil.lan (juv34-h02-176-184-26-1.dsl.sta.abo.bbox.fr.
 [176.184.26.1]) by smtp.gmail.com with ESMTPSA id
 f11-20020a5d50cb000000b00336ebf27d59sm1604796wrt.78.2024.01.05.07.44.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 05 Jan 2024 07:44:41 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Gavin Shan <gshan@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Subject: [PULL 15/71] target/mips: Use generic cpu_list()
Date: Fri,  5 Jan 2024 16:42:08 +0100
Message-ID: <20240105154307.21385-16-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240105154307.21385-1-philmd@linaro.org>
References: <20240105154307.21385-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Gavin Shan <gshan@redhat.com>

Before it's applied:

[gshan@gshan q]$ ./build/qemu-system-mips64 -cpu ?
MIPS '4Kc'
MIPS '4Km'
MIPS '4KEcR1'
MIPS 'XBurstR1'
MIPS '4KEmR1'
MIPS '4KEc'
MIPS '4KEm'
MIPS '24Kc'
MIPS '24KEc'
MIPS '24Kf'
MIPS '34Kf'
MIPS '74Kf'
MIPS 'XBurstR2'
MIPS 'M14K'
MIPS 'M14Kc'
MIPS 'P5600'
MIPS 'mips32r6-generic'
MIPS 'I7200'
MIPS 'R4000'
MIPS 'VR5432'
MIPS '5Kc'
MIPS '5Kf'
MIPS '20Kc'
MIPS 'MIPS64R2-generic'
MIPS '5KEc'
MIPS '5KEf'
MIPS 'I6400'
MIPS 'I6500'
MIPS 'Loongson-2E'
MIPS 'Loongson-2F'
MIPS 'Loongson-3A1000'
MIPS 'Loongson-3A4000'
MIPS 'mips64dspr2'
MIPS 'Octeon68XX'

After it's applied:

[gshan@gshan q]$ ./build/qemu-system-mips64 -cpu ?
Available CPUs:
  20Kc
  24Kc
  24KEc
  24Kf
  34Kf
  4Kc
  4KEc
  4KEcR1
  4KEm
  4KEmR1
  4Km
  5Kc
  5KEc
  5KEf
  5Kf
  74Kf
  I6400
  I6500
  I7200
  Loongson-2E
  Loongson-2F
  Loongson-3A1000
  Loongson-3A4000
  M14K
  M14Kc
  mips32r6-generic
  mips64dspr2
  MIPS64R2-generic
  Octeon68XX
  P5600
  R4000
  VR5432
  XBurstR1
  XBurstR2

Signed-off-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20231114235628.534334-16-gshan@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/cpu.h          | 4 ----
 target/mips/cpu-defs.c.inc | 9 ---------
 2 files changed, 13 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 52f13f0363..1163a71f3c 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1235,10 +1235,6 @@ struct MIPSCPUClass {
     bool no_data_aborts;
 };
 
-void mips_cpu_list(void);
-
-#define cpu_list mips_cpu_list
-
 void cpu_wrdsp(uint32_t rs, uint32_t mask_num, CPUMIPSState *env);
 uint32_t cpu_rddsp(uint32_t mask_num, CPUMIPSState *env);
 
diff --git a/target/mips/cpu-defs.c.inc b/target/mips/cpu-defs.c.inc
index c0c389c59a..fbf787d8ce 100644
--- a/target/mips/cpu-defs.c.inc
+++ b/target/mips/cpu-defs.c.inc
@@ -1018,15 +1018,6 @@ const mips_def_t mips_defs[] =
 };
 const int mips_defs_number = ARRAY_SIZE(mips_defs);
 
-void mips_cpu_list(void)
-{
-    int i;
-
-    for (i = 0; i < ARRAY_SIZE(mips_defs); i++) {
-        qemu_printf("MIPS '%s'\n", mips_defs[i].name);
-    }
-}
-
 static void fpu_init (CPUMIPSState *env, const mips_def_t *def)
 {
     int i;
-- 
2.41.0


