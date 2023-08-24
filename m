Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E151786BE4
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 11:30:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ6eF-0004RF-1O; Thu, 24 Aug 2023 05:29:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZ6e0-00044F-ED
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:28:51 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZ6du-0004xZ-1U
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:28:45 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-31c6cd238e0so425374f8f.0
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 02:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692869319; x=1693474119;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FNoz2jRyGGMfcclJtMl6sQI4wYYwL4cvUDJy9nWF4mc=;
 b=m9Hl/g/tSIh/kUWCVajQWohdt8ek2hfPEXkXMNFAfO+HhMtKdqW1WFUrSvS1+3bFjx
 qN8g6zSmk9rwiyscr6xx37DscJmWQUcW+Vzrd9fRF7opeO5J0UcNlKUAW4YUGCr3GQpH
 fFKu3sbt4asCxNI/yCmudfPeOZ9qmSrhl8nUeT/E8wNjF40QI3KdzV2sj9kavuB0wiRy
 EGK1jiam091+qY6MBoMyTeEvd6jlxt92zBlQ9B5Caqq3oaAQnaOSROWZosMIHALRZ8jj
 jqZoYfJcR0JR9psSU7KmiWUwJD2GSpLSlO/P8FiECBa2ksgNT9E1rXr8834vLkkLcaap
 GXUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692869319; x=1693474119;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FNoz2jRyGGMfcclJtMl6sQI4wYYwL4cvUDJy9nWF4mc=;
 b=Y1fsKJ7aVk7QKq/2NcRdnLbN3AMctP/XMOXf2oP2/9ebDF2P38CUaTwVBpCIpWDnHQ
 TnwxAfrSuFt6wrhaFAYpa6LG5uQqpbFGuzk+G9Y1Ahf4alipy+dX3K2KoqjTL7LxagUy
 CdA2sLrXG8am4skPr3C0AnLN1/LPEnYt63kJ4IekYFXbqRfrn/CWbeW/0o2n1HUlSYiI
 X2jkQasQiTloRQQlAB1alhYY/YQE4bGsSFVfTj7FzzV8G+F9qfV9AAsIMBAtiUlD7i1b
 N69eQnXoFzANxazCUIXZBzabSS+gU3hPlEtaYoMtIwD8sPTuvF6BcEjRy5KNA0AsjDrv
 mrfA==
X-Gm-Message-State: AOJu0YzshBPt/sowSPzC0l6Rk9qiZ2Bi42/l611meoeRHQsL6g2FEFCz
 VSJaWZUDHiALaQlikYhEZriuyp8gMHiRI5Bm6EE=
X-Google-Smtp-Source: AGHT+IE9VUEJNqOswMGiOhGyGeZre6ySwx0E18BtdAWnk2wnekD8pEogVY6/Xfup9WM0k7LL8g7QxA==
X-Received: by 2002:adf:f54a:0:b0:317:597f:3aa6 with SMTP id
 j10-20020adff54a000000b00317597f3aa6mr12596368wrp.18.1692869319595; 
 Thu, 24 Aug 2023 02:28:39 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 s12-20020adfeccc000000b00317b5c8a4f1sm21844004wro.60.2023.08.24.02.28.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 02:28:39 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/35] qtest: bail from irq_intercept_in if name is specified
Date: Thu, 24 Aug 2023 10:28:05 +0100
Message-Id: <20230824092836.2239644-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824092836.2239644-1-peter.maydell@linaro.org>
References: <20230824092836.2239644-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

From: Chris Laplante <chris@laplante.io>

Named interception of in-GPIOs is not supported yet.

Signed-off-by: Chris Laplante <chris@laplante.io>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20230728160324.1159090-5-chris@laplante.io
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 softmmu/qtest.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/softmmu/qtest.c b/softmmu/qtest.c
index 0f1d478bda5..66757ba2618 100644
--- a/softmmu/qtest.c
+++ b/softmmu/qtest.c
@@ -397,9 +397,11 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
         || strcmp(words[0], "irq_intercept_in") == 0) {
         DeviceState *dev;
         NamedGPIOList *ngl;
+        bool is_named;
         bool is_outbound;
 
         g_assert(words[1]);
+        is_named = words[2] != NULL;
         is_outbound = words[0][14] == 'o';
         dev = DEVICE(object_resolve_path(words[1], NULL));
         if (!dev) {
@@ -408,6 +410,12 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
             return;
         }
 
+        if (is_named && !is_outbound) {
+            qtest_send_prefix(chr);
+            qtest_send(chr, "FAIL Interception of named in-GPIOs not yet supported\n");
+            return;
+        }
+
         if (irq_intercept_dev) {
             qtest_send_prefix(chr);
             if (irq_intercept_dev != dev) {
-- 
2.34.1


