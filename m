Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B40C7B7EA0
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 14:03:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo0aw-0001zY-Gx; Wed, 04 Oct 2023 08:03:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qo0ZB-0000Jm-6M
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:01:33 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qo0Z6-00014p-0z
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:01:22 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-405524e6768so19833055e9.2
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 05:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696420878; x=1697025678; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lY+2ZyI4HgMHia8dRE1/FWk+2Dlndzg7wEwrT1ttBuw=;
 b=F2pYlKQC3xDPyDiLtmHNVWaEZwc5AWU+LZ/eMDfFDYEW//WQ2hUjKjfwfJBVfQn4wv
 1jN/RYdJm4XQl102pFlZyhyWFSrR8I7naZn5HHhIXZZc3t3cODSvHRXD47Kdd1/OKofx
 42bqVOBIMzruclo4sZcnA6vHITQldTbYQkKGLvap7E55wO9JAle6F38nQ/Mye+qxWEOb
 RdUyxRia1wf0JMAmSkFwZ/159ZFYbmQfeegVm84dR8X3a1ps1sjedW+WW8I3XoKi17e3
 lVQ98P19Xw8RGbcJqUuQifAqToA5cf8JT8qvWcfmSdx8fsT3sLN8CVx4QVe+ol444MUN
 2Atg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696420878; x=1697025678;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lY+2ZyI4HgMHia8dRE1/FWk+2Dlndzg7wEwrT1ttBuw=;
 b=JxJ7XF8Tcw6k1HSEGYGkgTBx1cfUoROKzdj5/XTO5t61a45H6VrwpUnQ/CH3s6gSW5
 Z+YEW8P9vURjW5TELCP5NxJF9eyLB7g2oy1QlpxchlgvVYq6LWmTFPzVLBCu8+U95bzO
 JSX7n5fBjBVqSJIeILyP3zknrhXDQR5shVNQt87e5prMO6WNcckuFaLKct+K4tXNV3hY
 6du8rvClpoX2E96AmUeVNLTywdaMAFm5xqcOXq2yPl1+g+OrUOPBKCtXOHB7NuHZlN8P
 CGo0dWFO1gt+7k9QPmTldTnNZTlIzSixCcnAlkVOzUg16wq1VfCmvCemXFrI1dIbvTU/
 M8iw==
X-Gm-Message-State: AOJu0Yw/WeUwkyFnipJGZNC5zJyT+qKpwQSRHfQiT8MN8mNCMQ69Bt5c
 RkHokpMthk+QM3gACLEUrcYVTvU3L/CFZ0HkBYY=
X-Google-Smtp-Source: AGHT+IHpz3K5Hghl3u2dyVG1oPT1csZBgDcX7TcKpIiSBonBl/oFwdDqCGuTb7525lFrO98JTQeClg==
X-Received: by 2002:a05:600c:6027:b0:406:8465:d299 with SMTP id
 az39-20020a05600c602700b004068465d299mr1518248wmb.7.1696420876973; 
 Wed, 04 Oct 2023 05:01:16 -0700 (PDT)
Received: from m1x-phil.lan (5ep85-h01-176-173-163-52.dslam.bbox.fr.
 [176.173.163.52]) by smtp.gmail.com with ESMTPSA id
 p7-20020adff207000000b003253523d767sm3837501wro.109.2023.10.04.05.01.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Oct 2023 05:01:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 09/16] semihosting: Clean up global variable shadowing
Date: Wed,  4 Oct 2023 14:00:12 +0200
Message-ID: <20231004120019.93101-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004120019.93101-1-philmd@linaro.org>
References: <20231004120019.93101-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

  semihosting/config.c:134:49: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
  int qemu_semihosting_config_options(const char *optarg)
                                                  ^
  /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/getopt.h:77:14: note: previous declaration is here
  extern char *optarg;                    /* getopt(3) external variables */
               ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/semihosting/semihost.h | 2 +-
 semihosting/config.c           | 8 ++++----
 stubs/semihost.c               | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/semihosting/semihost.h b/include/semihosting/semihost.h
index efd2efa25a..97d2a2ba99 100644
--- a/include/semihosting/semihost.h
+++ b/include/semihosting/semihost.h
@@ -66,7 +66,7 @@ const char *semihosting_get_cmdline(void);
 void semihosting_arg_fallback(const char *file, const char *cmd);
 /* for vl.c hooks */
 void qemu_semihosting_enable(void);
-int qemu_semihosting_config_options(const char *opt);
+int qemu_semihosting_config_options(const char *optstr);
 void qemu_semihosting_chardev_init(void);
 void qemu_semihosting_console_init(Chardev *);
 #endif /* CONFIG_USER_ONLY */
diff --git a/semihosting/config.c b/semihosting/config.c
index 8ca569735d..e826457733 100644
--- a/semihosting/config.c
+++ b/semihosting/config.c
@@ -131,10 +131,10 @@ void qemu_semihosting_enable(void)
     semihosting.target = SEMIHOSTING_TARGET_AUTO;
 }
 
-int qemu_semihosting_config_options(const char *optarg)
+int qemu_semihosting_config_options(const char *optstr)
 {
     QemuOptsList *opt_list = qemu_find_opts("semihosting-config");
-    QemuOpts *opts = qemu_opts_parse_noisily(opt_list, optarg, false);
+    QemuOpts *opts = qemu_opts_parse_noisily(opt_list, optstr, false);
 
     semihosting.enabled = true;
 
@@ -155,7 +155,7 @@ int qemu_semihosting_config_options(const char *optarg)
                 semihosting.target = SEMIHOSTING_TARGET_AUTO;
             } else {
                 error_report("unsupported semihosting-config %s",
-                             optarg);
+                             optstr);
                 return 1;
             }
         } else {
@@ -165,7 +165,7 @@ int qemu_semihosting_config_options(const char *optarg)
         qemu_opt_foreach(opts, add_semihosting_arg,
                          &semihosting, NULL);
     } else {
-        error_report("unsupported semihosting-config %s", optarg);
+        error_report("unsupported semihosting-config %s", optstr);
         return 1;
     }
 
diff --git a/stubs/semihost.c b/stubs/semihost.c
index aad7a70353..b3c61935b3 100644
--- a/stubs/semihost.c
+++ b/stubs/semihost.c
@@ -36,7 +36,7 @@ void qemu_semihosting_enable(void)
 {
 }
 
-int qemu_semihosting_config_options(const char *optarg)
+int qemu_semihosting_config_options(const char *optstr)
 {
     return 1;
 }
-- 
2.41.0


