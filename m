Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 16562786C06
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 11:34:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ6eD-0004C1-30; Thu, 24 Aug 2023 05:29:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZ6e1-00044X-K7
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:28:51 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZ6du-0004xe-IB
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:28:47 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3fe5c0e587eso59911615e9.0
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 02:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692869320; x=1693474120;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yoGfh1IvGmJKIOpV0F76Srck7ySJzUuEK4yJEk7+R08=;
 b=aodfqDNntNqAQ7nwKwCvz0eHmJdEGmdjTOAqesWk2vKLQD+pWPPyLqdgjpOWrUj8/d
 4cUmnyK2GcflFkqde0WO8+PSfeJMMKldai0tqB1WQBComAOhfw55Hw7PzldGz0PJ6cfQ
 XBmrgCaDqGlaK5jWxW5NnJAiUfPLuW67Q3dSyqGyabHAOm15EjB8VPYmn3pwHtKIH5WD
 6hNBFiH0TwW5r9IxGc2Y+zFt3ZrmjYBKa9ET5qweNcqSOIY8IEskNqs8+lPGL4sNbPNg
 9fUj7vf522ADv6d3KEbOTLKnzav5/J3UE1Bs/aGYIZ8Vp0ZBjYA+SKvagXv/pLdN+DJZ
 flgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692869320; x=1693474120;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yoGfh1IvGmJKIOpV0F76Srck7ySJzUuEK4yJEk7+R08=;
 b=C6RaOwjtNC3zvErJAUpTa/oLKGuuFQbTeOaanXpd20KZ0DvVl5fQ7HH1bop+O+2nNv
 ecDBcXd+GBauenxGUTfZlYFwIoM06bwfBVolzukiteJAGNzE8NUvwVkTwcWBkz7kHpCA
 yTycVQ/8H0eP8aCsEqzrpML2EFsIwQ8Iel9XYLJNvgRyM/3Vq3HmxvD7l4dJSyp0YgiE
 3gx3+4dY2pV6Z/lgBGTPGs4pRys4U3ky0Uelh4THUI6ujRxFpHNN+yakInzC21KfkRIq
 6/Mtw9W+Nf4fUAf2WfIZIQfiUUv1BNd/e6CxOF450Y9GMIyrmz8H8y9srYbGSQ8xuUhv
 wnfw==
X-Gm-Message-State: AOJu0YwYLtAOiu7nxPwaNvf7aH/vy8Zmp6aS9C/RdDI/lz74uBFhHFrd
 Thj4qsLFJYijBpgFDmDeiY5DIJyCOYaNzCWgHsc=
X-Google-Smtp-Source: AGHT+IGz1zXttqpw9MTqxQ/VgVN0295fFE4MdoDkm26I2qmOUfXk54i3eIuZACq8u0ey1+w8RzKqvQ==
X-Received: by 2002:a1c:7903:0:b0:401:1b58:730e with SMTP id
 l3-20020a1c7903000000b004011b58730emr1274594wme.28.1692869319969; 
 Thu, 24 Aug 2023 02:28:39 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 s12-20020adfeccc000000b00317b5c8a4f1sm21844004wro.60.2023.08.24.02.28.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 02:28:39 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/35] qtest: irq_intercept_[out/in]: return FAIL if no
 intercepts are installed
Date: Thu, 24 Aug 2023 10:28:06 +0100
Message-Id: <20230824092836.2239644-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824092836.2239644-1-peter.maydell@linaro.org>
References: <20230824092836.2239644-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

This is much better than just silently failing with OK.

Signed-off-by: Chris Laplante <chris@laplante.io>
Message-id: 20230728160324.1159090-6-chris@laplante.io
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 softmmu/qtest.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/softmmu/qtest.c b/softmmu/qtest.c
index 66757ba2618..35b643a274c 100644
--- a/softmmu/qtest.c
+++ b/softmmu/qtest.c
@@ -399,6 +399,7 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
         NamedGPIOList *ngl;
         bool is_named;
         bool is_outbound;
+        bool interception_succeeded = false;
 
         g_assert(words[1]);
         is_named = words[2] != NULL;
@@ -435,15 +436,22 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
                     for (i = 0; i < ngl->num_out; ++i) {
                         qtest_install_gpio_out_intercept(dev, ngl->name, i);
                     }
+                    interception_succeeded = true;
                 }
             } else {
                 qemu_irq_intercept_in(ngl->in, qtest_irq_handler,
                                       ngl->num_in);
+                interception_succeeded = true;
             }
         }
-        irq_intercept_dev = dev;
+
         qtest_send_prefix(chr);
-        qtest_send(chr, "OK\n");
+        if (interception_succeeded) {
+            irq_intercept_dev = dev;
+            qtest_send(chr, "OK\n");
+        } else {
+            qtest_send(chr, "FAIL No intercepts installed\n");
+        }
     } else if (strcmp(words[0], "set_irq_in") == 0) {
         DeviceState *dev;
         qemu_irq irq;
-- 
2.34.1


