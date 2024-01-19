Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FCD832909
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 12:41:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQnAH-0002GT-9D; Fri, 19 Jan 2024 06:36:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQnAE-0002Ay-I0
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 06:35:58 -0500
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQnAB-00013j-Ti
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 06:35:58 -0500
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-50e72e3d435so615703e87.2
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 03:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705664154; x=1706268954; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DBo2Z7Ku5vyeXLs2uqKJ4IlgAVFUCbWhBp53AWDvWSA=;
 b=RVkbTjHpw6HYCktUCLrc06V6zdfSUu+vDrCtMdt0c1ZgkbIsnQmv1PQrwMUZmKnG2H
 6TmYvnvXI5KK3E+SEkmPiJxvHy1z6yY8iv61qiU77xTKqbklQLqY7LfDPabn6R/bJ/FF
 CAEccApMIYmqp1UrVvWmF5PD8YsKJqdQ88rOa9rHagzEqgYeSv0F0/5lOhThe4SOR1km
 iVV+ujEwRZ19Nc3e7UKRLMbLRAfIZxmSGVodB8iQn1c2AYJgVnSj5rbe9POKKyga5P/7
 757l+01IaQfLkApH44ZgRODMzqKvSorVEj/K7PYDgF2oh830r9gONZs6lin3AbT7OI0f
 wj+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705664154; x=1706268954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DBo2Z7Ku5vyeXLs2uqKJ4IlgAVFUCbWhBp53AWDvWSA=;
 b=NPqsPaoFx/pjNWchByuN4WrlhVor3/AF0fEZpSltx/INS/XyNLLsLPX+ZsIvv/SBtz
 vXQ8GXbenWnfoXpbwfm15V6IzmPgw5kvahPw+uZWTrfuNe4Fd7zpz9q24wkhh7bdR9sC
 JKJBElE85B5khbVvQ4VDe/1wTWDhTP1gNO/34vttzbhiz/zRG07G2wgrrQXtH1MZQWvy
 9qpxpkqo14a+mlikfJ8SMGySTkrBTKGg5tBsntFF2xRJ7GX0Mz+h68r1VStK0kwdZr+Y
 EaTlwOWo4Ylrzpuuo0BTXlYSCHdYpDXOfcGbA7O8/ZSiel0wkKubRNwHK6aaEIPYeAA6
 DbEw==
X-Gm-Message-State: AOJu0YwxaYdrD//HR2/RUmc92WFojjEIwbKNvRyZbJSwXNA1lc3hxq9L
 xi0zDR+p0H7pMhXxJx9Otzdsns1U98JTru984N15wq6WCdVrzHzs4q1jHz1FKW6eTOrKaF4XH1r
 8nxhDBw==
X-Google-Smtp-Source: AGHT+IElNn9L8/6jJL90/vu5QXCwBLnWT2dEk/3zGBtfEOKQ1NZdjm7pScda0EC8IVQvZUfZ4vn5jg==
X-Received: by 2002:ac2:4e81:0:b0:50e:b945:fc98 with SMTP id
 o1-20020ac24e81000000b0050eb945fc98mr325094lfr.170.1705664153935; 
 Fri, 19 Jan 2024 03:35:53 -0800 (PST)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 o2-20020a5d4a82000000b00338ca0ada22sm1400094wrq.111.2024.01.19.03.35.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Jan 2024 03:35:53 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org, qemu-block@nongnu.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 10/36] target/alpha: Only build sys_helper.c on system emulation
Date: Fri, 19 Jan 2024 12:34:39 +0100
Message-ID: <20240119113507.31951-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240119113507.31951-1-philmd@linaro.org>
References: <20240119113507.31951-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x136.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20231207105426.49339-3-philmd@linaro.org>
---
 target/alpha/sys_helper.c | 3 ---
 target/alpha/meson.build  | 6 ++++--
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/target/alpha/sys_helper.c b/target/alpha/sys_helper.c
index 98d9a0fff7..768116ef32 100644
--- a/target/alpha/sys_helper.c
+++ b/target/alpha/sys_helper.c
@@ -28,7 +28,6 @@
 
 
 /* PALcode support special instructions */
-#ifndef CONFIG_USER_ONLY
 void helper_tbia(CPUAlphaState *env)
 {
     tlb_flush(env_cpu(env));
@@ -74,5 +73,3 @@ void helper_set_alarm(CPUAlphaState *env, uint64_t expire)
         timer_del(cpu->alarm_timer);
     }
 }
-
-#endif /* CONFIG_USER_ONLY */
diff --git a/target/alpha/meson.build b/target/alpha/meson.build
index ea252c99a5..7dbbd55717 100644
--- a/target/alpha/meson.build
+++ b/target/alpha/meson.build
@@ -7,13 +7,15 @@ alpha_ss.add(files(
   'clk_helper.c',
   'int_helper.c',
   'mem_helper.c',
-  'sys_helper.c',
   'translate.c',
   'vax_helper.c',
 ))
 
 alpha_system_ss = ss.source_set()
-alpha_system_ss.add(files('machine.c'))
+alpha_system_ss.add(files(
+  'machine.c',
+  'sys_helper.c',
+))
 
 target_arch += {'alpha': alpha_ss}
 target_system_arch += {'alpha': alpha_system_ss}
-- 
2.41.0


