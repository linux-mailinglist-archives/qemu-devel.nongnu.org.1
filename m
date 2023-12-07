Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E7D808C33
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 16:48:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBGa3-0000mX-Fw; Thu, 07 Dec 2023 10:46:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rBGa0-0000ks-C7
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 10:46:24 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rBGZw-0002BB-57
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 10:46:23 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-54cff638658so1475013a12.1
 for <qemu-devel@nongnu.org>; Thu, 07 Dec 2023 07:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701963977; x=1702568777; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VDQz48eWGvAAxBK49fKsnjDhuFSF5WlUTAlWJ/FVbAE=;
 b=tOYSHLqwUulb8UCrB6OrnIZ61xIhkKvGwhxu1o9W1DWp5wyQQxrsdiTfvYx1pMDNZL
 ocMttqxVTCH3ffa8fXwrpmYDt6q1mBuY/cWYGsXmQOtWwV4ETHR8VJO3HmRiRm/P6cuk
 me51+M2J6IIMLEcXl8FBu4bUy7yyreu9VFetJuHArFr24UTeeQkoISi7CMnARlTwUU6f
 e3wUZ4bF+nhDOjaY+UveTuFPjQmZCu3vdRyinF97eH3LClFT8T/ptW5e4ukBPhvj/xdo
 UF6lnKASosgkgoWfDM3vZa2bwbO+o4pMBjZY3JLp4zMVpVWv3XE9iS86ZqalfIWTNFBA
 /eKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701963977; x=1702568777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VDQz48eWGvAAxBK49fKsnjDhuFSF5WlUTAlWJ/FVbAE=;
 b=Y4y26/ONTB8RXACRu9bReetvyTeszeyyhEG0jw3veYkezHkE+fpSoMsaJvf/AhKyDR
 VBRfJTQNEEXkNB4loqeYIHCzRwE+gaQX+9cnACTk9qf/aGES19eb6XNK8MnzPs+kd7xc
 Ucs4gxHtRddaPHpe7iTA0woAtkx6ZD6HWVWUo8unMNpK+TX9JFYZ3pEKXZdrN5HMGAxP
 nLz8E+TGQb8mdcLwtsLMrGOPDTfjxmXtjn+Kv3RL8qmrT0GPhpU/Tvk2NsaS8SBIjsLz
 ITsvMTi29BRsj48gV0t+bi4DoE8jDfHVXThWLX8iivAwga/TfjuwdtMJLO/D40sN8X57
 fY0w==
X-Gm-Message-State: AOJu0YzxqsrBQhbg0AUsyLonKj3Kmm6uNCokVTHQxwB3GYPzevI50IaS
 IW0Mpqh2rRTPc4rszD+ekj/ej6MrnfxX9hcCOyI=
X-Google-Smtp-Source: AGHT+IEVYK5W6YS/D7h2AS1PAtM8dqCm9q5VwfX/xJ3P/ohAPselsL9UwzKndnL00miz0CsMfZ8RkQ==
X-Received: by 2002:a17:906:ae9b:b0:a16:9cc4:87c0 with SMTP id
 md27-20020a170906ae9b00b00a169cc487c0mr1567762ejb.51.1701963977054; 
 Thu, 07 Dec 2023 07:46:17 -0800 (PST)
Received: from m1x-phil.lan ([176.187.202.111])
 by smtp.gmail.com with ESMTPSA id
 l17-20020a170906a41100b00a1d885359d6sm966918ejz.46.2023.12.07.07.46.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 07 Dec 2023 07:46:16 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Fam Zheng <fam@euphon.net>, Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 4/5] system/vl: Restrict icount to TCG emulation
Date: Thu,  7 Dec 2023 16:45:49 +0100
Message-ID: <20231207154550.65087-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231207154550.65087-1-philmd@linaro.org>
References: <20231207154550.65087-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x529.google.com
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
---
 stubs/icount.c | 6 ------
 system/vl.c    | 6 +++++-
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/stubs/icount.c b/stubs/icount.c
index a5202e2dd9..b060b03a73 100644
--- a/stubs/icount.c
+++ b/stubs/icount.c
@@ -1,5 +1,4 @@
 #include "qemu/osdep.h"
-#include "qapi/error.h"
 #include "sysemu/cpu-timers.h"
 
 /* icount - Instruction Counter API */
@@ -10,11 +9,6 @@ void icount_update(CPUState *cpu)
 {
     abort();
 }
-void icount_configure(QemuOpts *opts, Error **errp)
-{
-    /* signal error */
-    error_setg(errp, "cannot configure icount, TCG support not available");
-}
 int64_t icount_get_raw(void)
 {
     abort();
diff --git a/system/vl.c b/system/vl.c
index 2bcd9efb9a..8c99c5f681 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2270,7 +2270,11 @@ static void user_register_global_props(void)
 
 static int do_configure_icount(void *opaque, QemuOpts *opts, Error **errp)
 {
-    icount_configure(opts, errp);
+    if (tcg_enabled()) {
+        icount_configure(opts, errp);
+    } else {
+        error_setg(errp, "cannot configure icount, TCG support not available");
+    }
     return 0;
 }
 
-- 
2.41.0


