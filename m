Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADAE7C7F55
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:04:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrD41-00009G-R2; Fri, 13 Oct 2023 03:58:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD3y-0008QO-V3
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:58:27 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD3w-0006oz-FF
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:58:26 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-406618d0992so18984875e9.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183903; x=1697788703; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3ONrF169gffnN0Ooe5lkieW/R6eKM+PaGfalQnkEes4=;
 b=G/mPZEcLplgqaoCJb35YC4IvVLOhISy7OdsrwlFycZ5NgFdXCzfzm8lvj/qt3Bs6X4
 AE8/cfxreLuRu301xWpqyqEKjh41RL3Uf/A79zLZXN7AgEEaB0JmtyjmDwlPWEVx/mAL
 ielaKk9kBSQFBXw9kT05nUfYoCItYzS8Iu/Dmp5h6wZvYc296O6Yw17zK23T38s6A4/c
 O29+ERJQQzVltnELjtkqBTig3Hh2/7+6gIODRghtIqhwU4/9fLZIeSuiQitbwuw4Tozp
 smp+nVAvS8daiSsmJZ7CkeTB2W/tCPNsuXnaKioXj3peoxVzWhNwtY0Q/vTWj9MhF+VO
 FSXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183903; x=1697788703;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3ONrF169gffnN0Ooe5lkieW/R6eKM+PaGfalQnkEes4=;
 b=SgA68J8+5+IqophRq18T+rdooyhMZtdmNWDcr8N8V5SaTJB7ggvomZm8pl0FS94nvj
 8QG08uvqsdCaQwM8iJNJpDouc9q2vxuFJyCViBjuqg2ar9e5OAmQYP6HkeFUDfKAT5kZ
 7an0kREvEDy0nodQgKj5iA1PJX2w7Kq6J3m5wgivSNm2i1EM/ZUcfV3PhOBo5oLgakaO
 214QWczhQL57xRxFCSVpkqIOT1GFLScPOQ7P6NTRdtzMj7XynOqbwxR/v5HvgADFK57o
 5adnpl1jE+nDYUJoVNPK4u4OHA45BDZF+dfbpRt4rLJWWZg9LKG346Jt2nuPB1Jl+Jb9
 dPeg==
X-Gm-Message-State: AOJu0YxFOwiH/jJkw63/dq+a1B5t6RBMfMrVeKr2PJ33zLcfyvE3FZjX
 xgfBF/nf26i7qLo56OKGuNDH/zEUQh7WrACbPXs=
X-Google-Smtp-Source: AGHT+IGTc3vm3xo8ElfvblbERevogLBizU6z3Pmjl2Js+cOmxC/cQ0BWke7Lm/Rt+YjPkxaC4y4lFQ==
X-Received: by 2002:a1c:6a07:0:b0:405:4f78:e128 with SMTP id
 f7-20020a1c6a07000000b004054f78e128mr24096397wmc.4.1697183902880; 
 Fri, 13 Oct 2023 00:58:22 -0700 (PDT)
Received: from localhost.localdomain (adsl-26.37.6.0.tellas.gr. [37.6.0.26])
 by smtp.gmail.com with ESMTPSA id
 a10-20020a05600c224a00b003fe23b10fdfsm1798183wmm.36.2023.10.13.00.58.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:58:22 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [RFC PATCH v2 14/78] util/error-report.c: add fallthrough
 pseudo-keyword
Date: Fri, 13 Oct 2023 10:56:41 +0300
Message-Id: <7dc547f2966ad838d6a417b29589e592c76e99b5.1697183699.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32d.google.com
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


