Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 845F6739E4B
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 12:19:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCHNb-0008W2-Qp; Thu, 22 Jun 2023 06:17:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qCHNY-0008Uk-Hn
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 06:17:29 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qCHNW-0003Jb-W6
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 06:17:28 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3f90b8acefeso51612875e9.0
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 03:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687429044; x=1690021044;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gfHj/18jEb5HZc5WOL4oeH6nRL+WbriNo612ICdOt40=;
 b=wxxoAt/QkgH4yLm5KGKrK5QqvUPH1o66mxBFggWJmp+4nvu5pwcYaWkOBeR4KZ+NYr
 Ngn37XQu1i04z6T8CkdKWdCViMcX9WoM7f4Xe2qUEkjMQ0ua9jbjzIxyrpE9TKWwStrH
 3KbvMpCmcFIBsIoBCvXMX0qAaiDvTLTwLlORylW/qGSAXSHAq9IX5+TDRWNwcltbuahx
 Fuv6SpLnnihRqOwNHMIDzOdU6cewDlR/jGqn0EkLnfFt5fLrpkGWbeTCqs6W3zucu9sB
 h9Sf5ttO8ulbU4peydI1cKxFP5ZwTO4njAa4UFJLTi7APLTI1q27wzFM1TeNAhYWdpfX
 9Wow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687429044; x=1690021044;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gfHj/18jEb5HZc5WOL4oeH6nRL+WbriNo612ICdOt40=;
 b=DJw1T1JeOhS2atc8N5Xjqu28bI7X6ZVWVkj/qoKmbzTBxs1IHj87m+u6OBAm7hxtVs
 sBgztjPsm8dvKjvnxPoEozlqfEffsQVoRaevJr3HE6EbsldN/3YkXH/ev7QT9lJNqy78
 IJKTiTz+H5WV9IfprDbI8EWhatl2SHi+KZWc758VWtil6ig04PYs1Z2QBd+rJFNPa9iD
 P38cSOT00EFmryC8VLFxHPT+SZ4PnCyGHayzEIWcolE80sUrFrOFBG0NZxhdUk6LI+ll
 cddWSxFmGPtAQCeBEJ2z7e6WaGaImb1QbkbMGH3+LP02KtuMKDZMVH8CteUXTtvlp/DL
 t3mw==
X-Gm-Message-State: AC+VfDxZfT3mlkj7sBV/r67JCNje06WNVW61sSbnlxR5n4482hG1EpKk
 hgQokIrxI2BfsTV3x4NP1hnzXkMsR2mBH6TWEg0ZKg==
X-Google-Smtp-Source: ACHHUZ7Tfrpkbsb2MfQ5eaRu75/LqZyhhbsOTZ44tcjFtxVizNHncI3gDn93tw/HKHNO28oe/jbLPw==
X-Received: by 2002:adf:cf12:0:b0:30f:d20f:f922 with SMTP id
 o18-20020adfcf12000000b0030fd20ff922mr12943675wrj.9.1687429044427; 
 Thu, 22 Jun 2023 03:17:24 -0700 (PDT)
Received: from localhost.localdomain (127.red-88-28-17.dynamicip.rima-tde.net.
 [88.28.17.127]) by smtp.gmail.com with ESMTPSA id
 f12-20020a5d58ec000000b00309382eb047sm6616897wrd.112.2023.06.22.03.17.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Jun 2023 03:17:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH] docs/devel/qom.rst: Correct code style
Date: Thu, 22 Jun 2023 12:17:17 +0200
Message-Id: <20230622101717.70468-1-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Per commit 067109a11c ("docs/devel: mention the spacing requirement
for QOM"):

  For a storage structure the first declaration should always be
  called “parent_obj” and for a class structure the first member
  should always be called “parent_class”

Adapt the QOM rST document accordingly.

Reported-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/devel/qom.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/devel/qom.rst b/docs/devel/qom.rst
index c9237950d0..2828843058 100644
--- a/docs/devel/qom.rst
+++ b/docs/devel/qom.rst
@@ -26,7 +26,7 @@ features:
    typedef DeviceClass MyDeviceClass;
    typedef struct MyDevice
    {
-       DeviceState parent;
+       DeviceState parent_obj;
 
        int reg0, reg1, reg2;
    } MyDevice;
@@ -147,7 +147,7 @@ will also have a wrapper function to call it easily:
 
    typedef struct MyDeviceClass
    {
-       DeviceClass parent;
+       DeviceClass parent_class;
 
        void (*frobnicate) (MyDevice *obj);
    } MyDeviceClass;
-- 
2.38.1


