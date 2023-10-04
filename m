Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BEEB7B7E9E
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 14:03:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo0YO-0008SW-Tz; Wed, 04 Oct 2023 08:00:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qo0YL-0008Qu-Sy
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:00:34 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qo0YJ-0000m3-LE
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:00:33 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3214cdb4b27so2007772f8f.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 05:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696420829; x=1697025629; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0ChBQXwNW4QJm3R3JDhJpohyouOc36v+LlRUPzDRwbg=;
 b=jeLv0vw2jRuxzHzu8rt+iCzjFZZX1Bpc71sS+QNZyV3vf8XchguyI8V/m8Sowsm8no
 +FmN9BH85yuZrxHbOl9hiY6y4yMmidNO1SquN1cVYcHuSqxYJV/4q9n4KRaUeELHI+O4
 e2PfEgklGK3pOEflOrcztGuSicny4y2/Aal94dsZaM2Sub+yAB9DcQPqsZ7Q2yyUiVh4
 RNZP4qpIe2j0IbviwLhrLj1kZYLwTkCy2gG5Uik21fOpXU607OF1PjC6fj2WuNH1ZUSp
 MmEH6g3hjW0cL+Z2o17cAeyJmfVSVTtRMjqwU6dQC/Q0/axmRGnpLhwDKo/a9OOVZHWA
 N/Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696420829; x=1697025629;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0ChBQXwNW4QJm3R3JDhJpohyouOc36v+LlRUPzDRwbg=;
 b=NFQLZkYYKxEP9Z9eUeDNOpZZDd8+/v6joUL4Rho35VKETLSTicCwN8cgzJ9O/eEEWR
 XTB6L/9Va+pziPasK8Q+wBOM4NYeQqMLERLwnEDH6addXoo9GWP0a0E5TfbTjuJ8UztC
 BWVQtnlouhQGWqavObt3Y0iqoYeFmLbiHbcqLVyHe5Pd5pq3atfWy263ZsLqhAN4hvv8
 K/58Izy5XGfdZwRfDxyxFNFGjFQc+bw+58zIrQcG/kROAAkMJE6U2yItvQOmJNgkt2SE
 gdB69si/q+yIF+Cg7spJCTPxWlmxEC+B+jfBdfXxsePJH+dyM65FYDCIgN8W1zP2dXZX
 ZwiQ==
X-Gm-Message-State: AOJu0Yyh5FDwNoQ8nwSS3mSeNl+80GVJFyiJhg3Uk1b0+eI6M2sftjD8
 uwubtUQNV6FH4FImmrWygoSWVIFx5vfHTIhvTRw=
X-Google-Smtp-Source: AGHT+IHnfkBvFfZVaWaol4sWKXVpE+VpCKpIvTMpTQJnk5YjXIxRK1bQ1VodJdkfn6yrWhV0NEtkgg==
X-Received: by 2002:adf:fdd0:0:b0:31f:d7bb:481e with SMTP id
 i16-20020adffdd0000000b0031fd7bb481emr2161075wrs.63.1696420829014; 
 Wed, 04 Oct 2023 05:00:29 -0700 (PDT)
Received: from m1x-phil.lan (5ep85-h01-176-173-163-52.dslam.bbox.fr.
 [176.173.163.52]) by smtp.gmail.com with ESMTPSA id
 k5-20020a5d6e85000000b00327c79ca7c6sm3860165wrz.80.2023.10.04.05.00.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Oct 2023 05:00:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v3 01/16] hw/audio/soundhw: Clean up global variable shadowing
Date: Wed,  4 Oct 2023 14:00:04 +0200
Message-ID: <20231004120019.93101-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004120019.93101-1-philmd@linaro.org>
References: <20231004120019.93101-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

Fix:

  hw/audio/soundhw.c:86:33: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
  void select_soundhw(const char *optarg, const char *audiodev)
                                  ^
  /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/getopt.h:77:14: note: previous declaration is here
  extern char *optarg;                    /* getopt(3) external variables */
               ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/audio/soundhw.h | 2 +-
 hw/audio/soundhw.c         | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/hw/audio/soundhw.h b/include/hw/audio/soundhw.h
index 270717a06a..474c5ff94e 100644
--- a/include/hw/audio/soundhw.h
+++ b/include/hw/audio/soundhw.h
@@ -8,6 +8,6 @@ void deprecated_register_soundhw(const char *name, const char *descr,
 
 void soundhw_init(void);
 void show_valid_soundhw(void);
-void select_soundhw(const char *optarg, const char *audiodev);
+void select_soundhw(const char *name, const char *audiodev);
 
 #endif
diff --git a/hw/audio/soundhw.c b/hw/audio/soundhw.c
index 94d9463e42..b387b0ef7d 100644
--- a/hw/audio/soundhw.c
+++ b/hw/audio/soundhw.c
@@ -83,7 +83,7 @@ void show_valid_soundhw(void)
 static struct soundhw *selected = NULL;
 static const char *audiodev_id;
 
-void select_soundhw(const char *optarg, const char *audiodev)
+void select_soundhw(const char *name, const char *audiodev)
 {
     struct soundhw *c;
 
@@ -92,7 +92,7 @@ void select_soundhw(const char *optarg, const char *audiodev)
     }
 
     for (c = soundhw; c->name; ++c) {
-        if (g_str_equal(c->name, optarg)) {
+        if (g_str_equal(c->name, name)) {
             selected = c;
             audiodev_id = audiodev;
             break;
@@ -100,7 +100,7 @@ void select_soundhw(const char *optarg, const char *audiodev)
     }
 
     if (!c->name) {
-        error_report("Unknown sound card name `%s'", optarg);
+        error_report("Unknown sound card name `%s'", name);
         show_valid_soundhw();
         exit(1);
     }
-- 
2.41.0


