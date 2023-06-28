Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 302D57415BA
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 17:54:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEXUR-00064Q-Us; Wed, 28 Jun 2023 11:53:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEXUP-00063W-KP
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 11:53:53 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEXUO-00084R-1G
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 11:53:53 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3fa8ce2307dso517195e9.2
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 08:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687967630; x=1690559630;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ngq1vqqDWR57+w6BNtF6G/pe8jppamc/e1NYlOezZ3M=;
 b=zb8kyrF25BKeOg2uKJoRy36vTHu+J1ICpHrMkeWg7DWikCtBtoneE0onDGH+9jc+Uc
 U/p/uIKuGcFgWlCuNLOHEKynwNXFQNfQRjCCAd1lQGlSaxW8jvLmCvLw0fJq1X6z80Bo
 tF8HEryye25tQughpSWxFbgSOg1dk0Fto1ul3Dj1I8rxOeaRn8xmxfE+Y3qaLwNXYNfN
 6CbtNyR/1kEX6Gptrd0GTY8y7eNlEz+F15VKy3nXbEFZ6xyQpRPNSucW7X6Hoha38pxM
 YhubFmjmaE4yJuYKjg8sj8lYoJ4MlCnONXyRV8lck2OnyQ5B/DZPf7246HCIkSuXNk0Z
 2OBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687967630; x=1690559630;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ngq1vqqDWR57+w6BNtF6G/pe8jppamc/e1NYlOezZ3M=;
 b=dIFwP4ggI1zRHn9zKijVyYBx/yJnD1jVbURTYLim44uLIwf/sH3a2d+bV8ikfiTlrg
 sd1ds9ZO3zuuHfPvgOlmzHChbNZFEdkbyE/D4TlKNlQEvAwHT4OHKm487shAPRUJBElB
 qDwdAhjA/uOBUrP/612se4Zi/wQjTQ1zZ8VqaQR/x6O3oGGeBUrPUIuE8svCD1B5zsqK
 8JNld16XgsVKq3nCZJHwnaAsy2ik8ayobcZJ6VTtwVNxwDuJAOZ5Wwc31kpbxay+GQJJ
 dHdf8av0yU8rxGSdoYCUNaNIv7NRqt5e3T1XE9XdlwCumt8NtMkI8ADeThQ+O8r2kfJD
 U9bg==
X-Gm-Message-State: AC+VfDwgvLJGrrwRWVpAHv7NpUCEZqKAZ+46VQfNpC8dNEYUj1EP8zvm
 bJYn1tIq9TmlovL1BZxBEAkiBpbJgJz1LIEOxGc=
X-Google-Smtp-Source: ACHHUZ7atqNuEs/u1cyCHhxoiREJCfXnDaHPZOfXf36I5iU5RP1qXsUplQNX6BdUnfGxYxA29EWHhw==
X-Received: by 2002:a5d:690a:0:b0:314:dea:41b with SMTP id
 t10-20020a5d690a000000b003140dea041bmr2465805wru.52.1687967630215; 
 Wed, 28 Jun 2023 08:53:50 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.207.229])
 by smtp.gmail.com with ESMTPSA id
 r15-20020adfe68f000000b003111025ec67sm13564763wrm.25.2023.06.28.08.53.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 28 Jun 2023 08:53:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 06/30] accel: Fix a leak on Windows HAX
Date: Wed, 28 Jun 2023 17:52:49 +0200
Message-Id: <20230628155313.71594-7-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230628155313.71594-1-philmd@linaro.org>
References: <20230628155313.71594-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

hThread is only used on the error path in hax_kick_vcpu_thread().

Fixes: b0cb0a66d6 ("Plumb the HAXM-based hardware acceleration support")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230624174121.11508-5-philmd@linaro.org>
---
 target/i386/hax/hax-all.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/i386/hax/hax-all.c b/target/i386/hax/hax-all.c
index 3e5992a63b..a2321a1eff 100644
--- a/target/i386/hax/hax-all.c
+++ b/target/i386/hax/hax-all.c
@@ -205,6 +205,9 @@ int hax_vcpu_destroy(CPUState *cpu)
      */
     hax_close_fd(vcpu->fd);
     hax_global.vm->vcpus[vcpu->vcpu_id] = NULL;
+#ifdef _WIN32
+    CloseHandle(cpu->hThread);
+#endif
     g_free(vcpu);
     return 0;
 }
-- 
2.38.1


