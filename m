Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA54182ACD8
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 12:07:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNssB-0001MA-Kl; Thu, 11 Jan 2024 06:05:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNss5-0001KC-CN
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:05:13 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNss2-0004NP-Qs
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:05:13 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40e60e13762so3186585e9.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 03:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704971109; x=1705575909; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CaJ0lo5TmAF8BFZ0QGqs81rse4aATjl1O9jO7ww+ztg=;
 b=cRCaNUQntyq4UDLQnlhaDdISitRxAwTafcAcikJzadIrgofqFIt+YcuTo6tOUJf/la
 JqCCuUbuLMeKisjZzxi0dwo/1EMCwImV50yqvh1bnXrqfjCsjECb8ziECiwxMqlLXdfr
 aiLQvNWIv7ucyLAK1hRg8/B2COMcWJoVUvt4d3UPL0vO/304tKnWkd47rT1TbK59pAdS
 488Y+06F+aag8Juz0bQ/QEKig/OEbyZr1AmTiOcL6lcnSTgPiRPLXBfs1O10jgZY7qRr
 VFtMSyiMd2PUnCyPHlz/M/iX5sL9tdn5IPg/3UuWn6Hd/FyNBokYNqP0+wv1Col7/78Q
 slow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704971109; x=1705575909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CaJ0lo5TmAF8BFZ0QGqs81rse4aATjl1O9jO7ww+ztg=;
 b=Y5bUMBjo9STw9GEnWsclR1uVimjv7qsmSDJenOX3ldXRzaKf5qp3hbERidhzft7fW6
 nJlHlvODG1+z37irsbUFgHkconHyU6xf52KbuV978dN5dX6CjZ9nxT4bcbYL7Y3cTdRX
 eOPaziVb9Qu+0c+UL0Qx1Eiv7lnYxiSkhpeetdyz5lmyoB43iyWhkQ3j/VJZZbFsBc1S
 zZqRZ3pAxOvi02Lr8fZz8ZTCkl7TDq43UbDIUsFkKSFhaUzYDb/+AVCBiBYp6N8URI4Z
 lRxwdUDM3ElGB3iuAEi93BBuieiFceKd5LH14pcBJ+jJN0tQZq1vlsGb1RB2BEVU8M3r
 8YjA==
X-Gm-Message-State: AOJu0YxrUK7aOmvvVgr7EulpTXfhnBUCF5agFAQEahTnIYqZT97KW2sz
 UAJMPiWqYRoHg6mAf58Mpcy39uzx3J70/dmGDHLc4tF6p2g=
X-Google-Smtp-Source: AGHT+IEWBrVmbE+GqWUDdgIY8khKd3OdTWIQd9GvBvjowGWGokz6WBY0Ig8BzCrXvCl/HIKn+RlSew==
X-Received: by 2002:a05:600c:2158:b0:40e:526f:a110 with SMTP id
 v24-20020a05600c215800b0040e526fa110mr142562wml.107.1704971108972; 
 Thu, 11 Jan 2024 03:05:08 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v30-20020adf8b5e000000b0033690139ea5sm951323wra.44.2024.01.11.03.05.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 03:05:08 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/41] hw/intc/armv7m_nvic: add "num-prio-bits" property
Date: Thu, 11 Jan 2024 11:04:28 +0000
Message-Id: <20240111110505.1563291-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240111110505.1563291-1-peter.maydell@linaro.org>
References: <20240111110505.1563291-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

From: Samuel Tardieu <sam@rfc1149.net>

Cortex-M NVIC can have a different number of priority bits.
Cortex-M0/M0+/M1 devices must use 2 or more bits, while devices based
on ARMv7m and up must use 3 or more bits.

This adds a "num-prio-bits" property which will get sensible default
values if unset (2 or 8 depending on the device). Unless a SOC
specifies the number of bits to use, the previous behavior is
maintained for backward compatibility.

Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20240106181503.1746200-2-sam@rfc1149.net
Suggested-by: Anton Kochkov <anton.kochkov@proton.me>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1122
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/armv7m_nvic.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 50f9a973a2e..404a445138a 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -2572,6 +2572,11 @@ static const VMStateDescription vmstate_nvic = {
 static Property props_nvic[] = {
     /* Number of external IRQ lines (so excluding the 16 internal exceptions) */
     DEFINE_PROP_UINT32("num-irq", NVICState, num_irq, 64),
+    /*
+     * Number of the maximum priority bits that can be used. 0 means
+     * to use a reasonable default.
+     */
+    DEFINE_PROP_UINT8("num-prio-bits", NVICState, num_prio_bits, 0),
     DEFINE_PROP_END_OF_LIST()
 };
 
@@ -2685,7 +2690,23 @@ static void armv7m_nvic_realize(DeviceState *dev, Error **errp)
     /* include space for internal exception vectors */
     s->num_irq += NVIC_FIRST_IRQ;
 
-    s->num_prio_bits = arm_feature(&s->cpu->env, ARM_FEATURE_V7) ? 8 : 2;
+    if (s->num_prio_bits == 0) {
+        /*
+         * If left unspecified, use 2 bits by default on Cortex-M0/M0+/M1
+         * and 8 bits otherwise.
+         */
+        s->num_prio_bits = arm_feature(&s->cpu->env, ARM_FEATURE_V7) ? 8 : 2;
+    } else {
+        uint8_t min_prio_bits =
+            arm_feature(&s->cpu->env, ARM_FEATURE_V7) ? 3 : 2;
+        if (s->num_prio_bits < min_prio_bits || s->num_prio_bits > 8) {
+            error_setg(errp,
+                       "num-prio-bits %d is outside "
+                       "NVIC acceptable range [%d-8]",
+                       s->num_prio_bits, min_prio_bits);
+            return;
+        }
+    }
 
     /*
      * This device provides a single memory region which covers the
-- 
2.34.1


