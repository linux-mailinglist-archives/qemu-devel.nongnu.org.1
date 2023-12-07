Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5249D8085D9
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 11:55:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBC1m-0006XR-Rx; Thu, 07 Dec 2023 05:54:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rBC1j-0006Wz-Pv
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 05:54:44 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rBC1i-000784-6g
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 05:54:43 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3332e351670so718068f8f.0
 for <qemu-devel@nongnu.org>; Thu, 07 Dec 2023 02:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701946480; x=1702551280; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pzHfNd+5ye/JZZWncMwC1J3XXil2LznVmX5p2wjtceY=;
 b=PLDMXR5J3ceAev10UkWnOYlAei/YBi1z7iOPkTO0FnSPl/ZLaEWVXw2GrqgyHGRf8/
 zQEeTQOr/nmzxrR+aAhwzawRRmrvxevh4FnB9W61wsDz1ms5SD01kSKAdXFMpKFjeaaa
 6K93ial56Sp1GHx43lzASnoHQSG1SJp/mhGrbzWaZ3cpK+RFyGieDB43jywiutkPaxwv
 oZA40Merptp+0151U/lDr+KGnKFXTh4Bc49N01dfouoTB7wu1nz6+ydbng0OfMsXm4yx
 ZwUIxNOxtPp9Pj65GMHynkoADIrYJUyB6gOO/vegE+/YPbY96NbKgK7jnkvt7PJM1Nir
 ixmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701946480; x=1702551280;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pzHfNd+5ye/JZZWncMwC1J3XXil2LznVmX5p2wjtceY=;
 b=hWMd5JkOUOp+KaAn34d5aUEM0jbRi/UFAqC9UXxtbWixm3uqsSSAaDX04UXcGkb8BU
 e6kshADMIJOOC6BKYlTjZlh6Ehz2og9LJpbBMPT8nZB82G+sQ3A4W61gdP7DBawnxL86
 IBHZNSr4oup167dHQjmWLC54BwxH6hzoN98dvEif4iH0X9N+j6Es2NZW1Ss4jVrEK+dm
 ZNlmNLnvl5t9HgmObBmJBZofcwIxF/4k2vw74mnpiBuLU2HZUPYs1ti5y7a/a8v8e2j9
 dtqrB8JYz6PQrsV3KP3BzRKDPoY9jCjG0x1y4jdZ99UaJYmUaaXI04u/KWpZcMZaxZK2
 6ZXg==
X-Gm-Message-State: AOJu0YzSxwXyhJXI5CeBb5q0X/SQwqowrH40HzR/slgg+7Bzu9saj1w7
 C8MEo5hoMkbYMyLuj6D1htM8cYqA+TqjmcAYIP4=
X-Google-Smtp-Source: AGHT+IHma8uKa7BIFYjivlRLJLdj6+Ldk6Mjada5KP63e1mOO1zT+EPnRd8Bz+vbZV1jnRzL6RKCJw==
X-Received: by 2002:a5d:6306:0:b0:333:130d:4311 with SMTP id
 i6-20020a5d6306000000b00333130d4311mr777394wru.52.1701946480450; 
 Thu, 07 Dec 2023 02:54:40 -0800 (PST)
Received: from m1x-phil.lan ([176.187.202.111])
 by smtp.gmail.com with ESMTPSA id
 m12-20020a5d4a0c000000b003333a0da243sm1121730wrq.81.2023.12.07.02.54.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 07 Dec 2023 02:54:40 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/2] target/alpha: Only build sys_helper.c on system emulation
Date: Thu,  7 Dec 2023 11:54:26 +0100
Message-ID: <20231207105426.49339-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231207105426.49339-1-philmd@linaro.org>
References: <20231207105426.49339-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


