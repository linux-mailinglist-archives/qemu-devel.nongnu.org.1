Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 303A274AFFC
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 13:39:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHjhM-0002Um-6D; Fri, 07 Jul 2023 07:32:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjhE-0002MN-Lz; Fri, 07 Jul 2023 07:32:21 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjhC-0006fV-9n; Fri, 07 Jul 2023 07:32:19 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-6b91e21365aso189072a34.1; 
 Fri, 07 Jul 2023 04:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688729537; x=1691321537;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RrNQLCeKTw4b+kLnO/5U6GHcujAhJpWFlo01Wc2vvfY=;
 b=Z08fTk6qgyKoVvuyeTVmGjMDdpLGNxPYcUJYLyYm7CjT63kpSrn4nhnewqpP/HV8dE
 a5LY0waySE8xSdCPOl3pc0S+4FGv8EZQdeqvadiuVVQ7gokZTdhCQckax1Fjf8iA7uT8
 TBYpXRIyoFEdZtJCC62wo+bL+8cLq7wM/qIYW+EMlK37vK4s2fK/G1mK+us55tcndqWJ
 PGIzybZCDslz+j6dMGPUIVSzmKhgYuamTo0S+aXlCk6JlClwphx9JKeIXlOhG7JfWz2B
 0j7cBxxoZxuBZGsZ9b3afg0TLSBuoh/r+Dv0zpmZpI+59YCWSQNhedzbNYtmfIpb/c0C
 CzeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688729537; x=1691321537;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RrNQLCeKTw4b+kLnO/5U6GHcujAhJpWFlo01Wc2vvfY=;
 b=VsU2irh6PZ2sLmTuo5vSNiawvV9TG6bsTYmqqA86rmf34bDsRl4YbL8m2hgtdMt0EM
 2sYjLDJbQrp/bqdNNgTKG/Teu4UlKdVMWM1fLbnpoAT4SqotHqfe8KjRpZ/j4L2UrHIW
 JwtsghtsFjiQ779kLZxwkdkr2z8qgITyRJuSK7W8NawzA4qlJVkc6/J9hr9RvG7rOqr4
 v43xJQnZBm3/SWSfE75zleicppM7ViY/jn448I9pe/Wshiynk91784fldwPCnf9YcOPi
 AWLqlqTWLJhkaeiDz6bpBMjKKmIXZqlZ0jnppIu4mnx7IqpK7o4fJx0B4s5/+u1Elvut
 Xm8g==
X-Gm-Message-State: ABy/qLY1YH2iJCWu09xwx3DByeh9BlDEZH6xexeSW2vjkt2d72H7r55j
 u6UBFNbrfM+e9WxG19D82zG2O43SZJw=
X-Google-Smtp-Source: APBJJlGhJUej/Jku38uyb5v5l9M/kjeS6rXET/0Zg98s4AR74GJWvNYV3o1L+vKTaBS+JgUvrZSaRA==
X-Received: by 2002:a05:6830:1019:b0:6b7:296d:3d4e with SMTP id
 a25-20020a056830101900b006b7296d3d4emr4514331otp.30.1688729536791; 
 Fri, 07 Jul 2023 04:32:16 -0700 (PDT)
Received: from grind.. ([2804:14c:f435:9162::1002])
 by smtp.gmail.com with ESMTPSA id
 g17-20020a9d6c51000000b006b74b37f5e5sm1574859otq.20.2023.07.07.04.32.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 04:32:16 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, Frederic Barrat <fbarrat@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 21/60] pnv/psi: Initialize the PSIHB interrupts to match
 hardware
Date: Fri,  7 Jul 2023 08:30:29 -0300
Message-ID: <20230707113108.7145-22-danielhb413@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707113108.7145-1-danielhb413@gmail.com>
References: <20230707113108.7145-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=danielhb413@gmail.com; helo=mail-ot1-x32e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Frederic Barrat <fbarrat@linux.ibm.com>

On the powernv9 and powernv10 machines, the PSIHB interrupts are
currently initialized with a PQ state of 0b01, i.e. interrupts are
disabled. However real hardware initializes them to 0b00 for the
PSIHB. This patch updates it, in case an hypervisor is in the mood of
checking it.

Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20230703081215.55252-3-fbarrat@linux.ibm.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/ppc/pnv_psi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index 46da58dff8..daaa2f0575 100644
--- a/hw/ppc/pnv_psi.c
+++ b/hw/ppc/pnv_psi.c
@@ -863,6 +863,8 @@ static void pnv_psi_power9_realize(DeviceState *dev, Error **errp)
     object_property_set_int(OBJECT(xsrc), "nr-irqs", PSIHB9_NUM_IRQS,
                             &error_fatal);
     object_property_set_link(OBJECT(xsrc), "xive", OBJECT(psi), &error_abort);
+    object_property_set_int(OBJECT(xsrc), "reset-pq", XIVE_ESB_RESET,
+                            &error_abort);
     if (!qdev_realize(DEVICE(xsrc), NULL, errp)) {
         return;
     }
-- 
2.41.0


