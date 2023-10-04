Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8BD7B7E9F
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 14:03:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo0al-00017l-Hx; Wed, 04 Oct 2023 08:03:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qo0Yj-00006h-HD
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:01:04 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qo0Yg-00010z-Ly
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:00:56 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4060b623e64so5255015e9.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 05:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696420852; x=1697025652; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uFvZwDADzu+jGNLm/Nr1aEk3hDp0zJEDlovZc+F59xM=;
 b=CfIHqfe+XO5A2GWTasaHgTBZyPjmjz8EgE8LP0hzssONqBmBthiob8V7ji9e39nq87
 7mWt7uT+jnyuxCoi4JAq6DNiZhMQMGWoJDG++EkBDPLNoFVmmhq1yw+qNokILVFsIFXe
 OrUDlNrk98YbHAfenEahhZJKaz/L0b/YIlD78zWQI3XF/cew7GxMYJP7hjl7mzOKQt0x
 de/v+4wf8j1D/lpT6LNz3Oyo0Jn+1bye1zoJecZvO6pgtlv4426akFd0vzlCBqQ8bUz9
 882BEit66qtEYZZ/jrDIuOKYlIfFNvoyRKlJcv0IweKacFb+MJMhwLh2ws1mAopEY/GL
 Gk1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696420852; x=1697025652;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uFvZwDADzu+jGNLm/Nr1aEk3hDp0zJEDlovZc+F59xM=;
 b=l0U/s1O4ZbX1m4MAyEi9+vrTdMqCS1kS2aF4XkEhdbgoFbu8n//nbgl86N1S+tgdNK
 AaPfQTgTHxVBw788bEi1G36ySouolAq2Ouk8Jh+od+sFdYQpe/5/vWHlgU6z79eHsKKK
 fpgRtMxzJpdzhvSz6N+PyHFMUUoZR+sKkosbfqJbafnCT0ydwumK1fo7KUxtO2qZpH0P
 Gb/AYAciNPcKrQsPH/yjlDAb6NdB0ZQ9CfGtsAKEvcACYwEe2XlEThIJl/65ZwMsI+xI
 dRpOdQlR42v8DCknpkuLpBwMeTyNRy3V68D9Cbs4y1KmvQbLob0KUGDi9ea+JRgVWoMc
 Ny5g==
X-Gm-Message-State: AOJu0YxK8IsvBhzkqCQYgOlJvuNC06rEL2ZHOakPEiQn0Fogsq4jvI7q
 9w1PU1xYHrZNXTu4PMaEIqA2AVyd6b3xVQklMCA=
X-Google-Smtp-Source: AGHT+IEXIZTrg1qnQx3RubWF1mReyHjUCnbWwh/8W+VVNuAwgCBCuyd7CivVVgalmM/M6alD0O8fdA==
X-Received: by 2002:a05:600c:3b11:b0:406:45c1:4dd with SMTP id
 m17-20020a05600c3b1100b0040645c104ddmr4664556wms.14.1696420852705; 
 Wed, 04 Oct 2023 05:00:52 -0700 (PDT)
Received: from m1x-phil.lan (5ep85-h01-176-173-163-52.dslam.bbox.fr.
 [176.173.163.52]) by smtp.gmail.com with ESMTPSA id
 g18-20020a5d5552000000b0032327b70ef6sm3865780wrw.70.2023.10.04.05.00.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Oct 2023 05:00:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH v3 05/16] plugins/loader: Clean up global variable shadowing
Date: Wed,  4 Oct 2023 14:00:08 +0200
Message-ID: <20231004120019.93101-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004120019.93101-1-philmd@linaro.org>
References: <20231004120019.93101-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Fix:

  include/qemu/plugin.h:245:54: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
  static inline void qemu_plugin_opt_parse(const char *optarg,
                                                       ^
  /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/getopt.h:77:14: note: previous declaration is here
  extern char *optarg;                    /* getopt(3) external variables */
               ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/plugin.h | 4 ++--
 plugins/loader.c      | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index bc0781cab8..7fdc3a4849 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -50,7 +50,7 @@ static inline void qemu_plugin_add_opts(void)
     qemu_add_opts(&qemu_plugin_opts);
 }
 
-void qemu_plugin_opt_parse(const char *optarg, QemuPluginList *head);
+void qemu_plugin_opt_parse(const char *optstr, QemuPluginList *head);
 int qemu_plugin_load_list(QemuPluginList *head, Error **errp);
 
 union qemu_plugin_cb_sig {
@@ -242,7 +242,7 @@ void qemu_plugin_user_postfork(bool is_child);
 static inline void qemu_plugin_add_opts(void)
 { }
 
-static inline void qemu_plugin_opt_parse(const char *optarg,
+static inline void qemu_plugin_opt_parse(const char *optstr,
                                          QemuPluginList *head)
 {
     error_report("plugin interface not enabled in this build");
diff --git a/plugins/loader.c b/plugins/loader.c
index 809f3f9b13..734c11cae0 100644
--- a/plugins/loader.c
+++ b/plugins/loader.c
@@ -140,12 +140,12 @@ static int plugin_add(void *opaque, const char *name, const char *value,
     return 0;
 }
 
-void qemu_plugin_opt_parse(const char *optarg, QemuPluginList *head)
+void qemu_plugin_opt_parse(const char *optstr, QemuPluginList *head)
 {
     struct qemu_plugin_parse_arg arg;
     QemuOpts *opts;
 
-    opts = qemu_opts_parse_noisily(qemu_find_opts("plugin"), optarg, true);
+    opts = qemu_opts_parse_noisily(qemu_find_opts("plugin"), optstr, true);
     if (opts == NULL) {
         exit(1);
     }
-- 
2.41.0


