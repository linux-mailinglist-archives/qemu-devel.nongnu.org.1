Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC5F81282F
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Dec 2023 07:33:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDfGl-0001ra-3U; Thu, 14 Dec 2023 01:32:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rDfGj-0001rN-5V
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 01:32:25 -0500
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rDfGh-00044y-5u
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 01:32:24 -0500
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-6da3a585c29so846428a34.1
 for <qemu-devel@nongnu.org>; Wed, 13 Dec 2023 22:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702535542; x=1703140342;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Hu2GriO1MrAnoyhy/5uDQI6ndh4gr9e/XQreypZyRXo=;
 b=QeKS2WHJdc1Dn9+J8Uy4Ga0ZGgvHG1GhIyYcbMjXBEyc4A2ICr/ZMMcQM049HL5fOF
 hOc4TVLDia/qlYLEjpuvst4BIO7jWfQfS997PL3xb8ww+Gj2VzauVJ8ovv2JMMSE7UrQ
 m31ZTmMQP/faLm9qni6wUxz2acPMxQnZswhB43Xi3skBlcGIvaKr7/mS8DbtYS+t3vkv
 IXDYcWyztM1MUCLcqCStteaHdiA0Ss9xOM8DuaNBy0dSF5pC5D75EIvSZPOshmJ6w7Bs
 TLb5q3/RNkVfDleyHtGmxzKYeu2pQh3CJjHZ/WwSmW62ukQauBm/KWKPISbwQmfG/29v
 aupg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702535542; x=1703140342;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Hu2GriO1MrAnoyhy/5uDQI6ndh4gr9e/XQreypZyRXo=;
 b=R9cBtm8Q3qB/LIkfP1Or4bDooww8Sxh9jeYxbrDGZEvNO50wwFNefREJIZkUB4n/xF
 H7S7gg45Hz3wETH9d1WcB3kZ4xMqy0KIo7F4B3WI+I/ooWgx6Vw/KwmUcWJby1/zxBWv
 g2ALUBLLauh28zIQuHeTFk+RUWVMLmjU31qjanqAGzQQQv5kL4qguz3PB48Q1FZxRhEy
 bPjmxfVC9dKZuJZOlDmJmcnij4tkTanf3tF1CZrNrBg3ww9Q00vW8RVXizVYvDp/sE2L
 PSDheaFXopN+N+zLOXg1kotcHcRGNdc+6rcNzjnXhbYXIS8+QrAe2uXpZw7R5Uj0Fw1c
 VAcQ==
X-Gm-Message-State: AOJu0YyIYi1wtvlg3BZnbZL3tO1gue+wzBuvBXatqqAY+JvQhLCIoIij
 Mswya4wArWKXy/wGIzB5TxpA7g==
X-Google-Smtp-Source: AGHT+IFdW8R8YlGKFD0ANRkqAhkgiASolwGwLfQkrGxSrd/1f1hfQsarh1YbIxHYPHwrCv7xsOT26g==
X-Received: by 2002:a05:6808:1250:b0:3b8:b063:9b6f with SMTP id
 o16-20020a056808125000b003b8b0639b6fmr10410584oiv.97.1702535541846; 
 Wed, 13 Dec 2023 22:32:21 -0800 (PST)
Received: from localhost ([157.82.200.183])
 by smtp.gmail.com with UTF8SMTPSA id
 d15-20020aa7814f000000b006cdd00f91fdsm4719422pfn.185.2023.12.13.22.32.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Dec 2023 22:32:21 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH 0/2] qemu-options: Improve -display cocoa documentation
Date: Thu, 14 Dec 2023 15:31:34 +0900
Message-Id: <20231214-options-v1-0-113f347b0e3f@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEahemUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDI0MT3fyCEqCSYl1jC7NUE4sks7REk2QloOqCotS0zAqwSdGxtbUAxt3
 IjFkAAAA=
To: Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Carwyn Ellis <carwynellis@gmail.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>, 
 BALATON Zoltan <balaton@eik.bme.hu>
X-Mailer: b4 0.12.4
Received-SPF: none client-ip=2607:f8b0:4864:20::332;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ot1-x332.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

For the context, see:
https://lore.kernel.org/all/e3839467-6d4c-e8e6-9247-a71fafe5505e@eik.bme.hu/

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Akihiko Odaki (2):
      qemu-options: Unify the help entries for cocoa
      qemu-options: Tell more for -display cocoa

 qemu-options.hx | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)
---
base-commit: 4705fc0c8511d073bee4751c3c974aab2b10a970
change-id: 20231214-options-386e48b6fa4c

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


