Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6847C7F1E
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 09:58:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrCwN-0004rj-N9; Fri, 13 Oct 2023 03:50:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrCwK-0004lt-Cg
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:50:32 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrCw3-0004PD-8Q
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:50:32 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-406618d0991so18696625e9.2
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183413; x=1697788213; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3ONrF169gffnN0Ooe5lkieW/R6eKM+PaGfalQnkEes4=;
 b=tSz06HzQQ6QR448WPVxneN7xc6R5E5UnD67EZNJN6FQCeS9fjnrVDsKSdVfBeThUK0
 zATIuiwqtoyuxxpR1TpaZHYhICi9p9PYHIJp6cT5MebkXI4ksIYnBGreyF2+x0WEGvUB
 YlN3kMP5tU8kRzxncBl8wHJMxf3D7yybUNueP0wmV5GkBSGrG8yJc8BVN97Okga6bfc/
 mVaxk8T7znfNDO1wr8VNAExG6v+sT5YnnBUDpduNqULfBX0YpxMDJMRYW86wgSnxFxUI
 rt2L7uvo16takADkz+/djIQG+MQtl/pNAoO1ShccWJaJz613+p/NyaYa2u90E0wfFPjv
 Nqnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183413; x=1697788213;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3ONrF169gffnN0Ooe5lkieW/R6eKM+PaGfalQnkEes4=;
 b=E9JYGhy/zvnQ9CwKVra6jI199Z9JAB7vYJ7LmX7L5sxtSFO6QyAfAyCfWiNIGUYemG
 iXttBzYse5ihkKIPnnEkr3R3UUo1PQv5ODDop6Xk4742vPvKmYvqYBaDb0hWijIM20cZ
 6Pacs3psaTh+6M++8NFwo1MI+65ofgvOYi5eDHFUA05GKAnKvEE/qeSdFWPMWtRgNkKU
 hzl3RZU5ookvnfAc9PMJjwlio6rPGxwnIE0GU6eJKk/E72L37CzykwC5juEV0bfKEO+4
 Y/gjxFJ3KOAcYXMr/NtimC9t4orI/8VpXmA/tqp8Cg+fggqPzZ0c17x+lW76yLyYkvWM
 he+w==
X-Gm-Message-State: AOJu0YyhQJHfDMwCC7OqrKJdzixEoyj0KUB4NA0YUtEdhCBwAYg+ryvE
 AARD/VVjEw0+yPOCQRSmPcM8CxrXaDYdE53OOZc=
X-Google-Smtp-Source: AGHT+IEhVT20xsZ1CB61O9W6zk/Hj2oxwKGDKRW63WieQwom6O8XNYqXtCfJdXKxbdTMbYfg8FwC6Q==
X-Received: by 2002:a5d:5b1b:0:b0:329:6e92:8d73 with SMTP id
 bx27-20020a5d5b1b000000b003296e928d73mr20173227wrb.67.1697183413740; 
 Fri, 13 Oct 2023 00:50:13 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 m8-20020adfa3c8000000b0032d7fde2d3csm7990663wrb.79.2023.10.13.00.50.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:50:13 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-block@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [RFC PATCH 14/78] util/error-report.c: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 10:47:18 +0300
Message-Id: <7dc547f2966ad838d6a417b29589e592c76e99b5.1697183082.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183081.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183081.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32e.google.com
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

In preparation of raising -Wimplicit-fallthrough to 5, replace all
fall-through comments with the fallthrough attribute pseudo-keyword.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 util/error-report.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/error-report.c b/util/error-report.c
index 6e44a55732..acb66420de 100644
--- a/util/error-report.c
+++ b/util/error-report.c
@@ -353,36 +353,36 @@ static char *qemu_glog_domains;
 static void qemu_log_func(const gchar *log_domain,
                           GLogLevelFlags log_level,
                           const gchar *message,
                           gpointer user_data)
 {
     switch (log_level & G_LOG_LEVEL_MASK) {
     case G_LOG_LEVEL_DEBUG:
     case G_LOG_LEVEL_INFO:
         /*
          * Use same G_MESSAGES_DEBUG logic as glib to enable/disable debug
          * messages
          */
         if (qemu_glog_domains == NULL) {
             break;
         }
         if (strcmp(qemu_glog_domains, "all") != 0 &&
           (log_domain == NULL || !strstr(qemu_glog_domains, log_domain))) {
             break;
         }
-        /* Fall through */
+        fallthrough;
     case G_LOG_LEVEL_MESSAGE:
         info_report("%s%s%s",
                     log_domain ?: "", log_domain ? ": " : "", message);
 
         break;
     case G_LOG_LEVEL_WARNING:
         warn_report("%s%s%s",
                     log_domain ?: "", log_domain ? ": " : "", message);
         break;
     case G_LOG_LEVEL_CRITICAL:
     case G_LOG_LEVEL_ERROR:
         error_report("%s%s%s",
                      log_domain ?: "", log_domain ? ": " : "", message);
         break;
     }
 }
-- 
2.39.2


