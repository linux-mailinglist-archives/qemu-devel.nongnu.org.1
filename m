Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 94099815850
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Dec 2023 08:54:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rEPUW-0003B7-S4; Sat, 16 Dec 2023 02:53:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rEPUU-0003Az-NN
 for qemu-devel@nongnu.org; Sat, 16 Dec 2023 02:53:42 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rEPUS-0000k0-M6
 for qemu-devel@nongnu.org; Sat, 16 Dec 2023 02:53:42 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6cebbf51742so1048951b3a.1
 for <qemu-devel@nongnu.org>; Fri, 15 Dec 2023 23:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702713219; x=1703318019;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XbVaSTATzeyZVvGbiL4jAkHDWHXD4qCFCn9/MAfiGiY=;
 b=FN0L9D+AKG64BD2akA1dOY0K9Nsn1vTSw+ORGPbq0K5ncJbfi21dNhMlG4b92jG9dK
 NRr65mrLXZ7iekA1md4nHBDeI3/NjOijOT8dLja5t2hhudQgm0ykchOuh4HlqkNdO6kS
 tFyv3ZY3hk83iTceSYrCW12kbTb6DdQRPfCbhXvulkNGIRW4952ZddYKUn8D95qlnLTb
 p6fKDOSxBKWEg+VuuVIFBY5HW51+NfGPZ+CqLSK/XRsiTcVtcClDOig7PUrc9l4ngiar
 +2G/ttDFVZ4xfxRUbzxZ4cFCL8RR/tzIRIoGfsZWEO0JEyOBexfIKbk/LQzdEAnDjwzY
 59yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702713219; x=1703318019;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XbVaSTATzeyZVvGbiL4jAkHDWHXD4qCFCn9/MAfiGiY=;
 b=mMmUBUic73808eb88jYikPmRTMFR7CA7I3K55F2jRYeGHKDcZPYSQyJES6rvNYB/PT
 PAVK6BRSzndR96keXQCsdPHhnhUL6lRweOPoSWnirZNB1/fOB27tnHnr/a7dWIR0mQrJ
 SwQY6qERgoe+AJPDyGo0mbHMubPlgsn4BuEqnfu+nAa/lPk6EEObabzSneo8YsEjbdeG
 co81CUDXDzqpTLtDFzqFZVzJZOAu38FCdbvdCuO5cwyIOnJ8ES3O1WLFHvOI2+Nay2Sv
 b9j4EhRhQ5j9q3wfIMdbc7PTCqB6gc5BtfK06jkbPzvpU5eUcqg+SSPag9W27oCmQXTZ
 +CQg==
X-Gm-Message-State: AOJu0Yyb2ljmdwPcutv9oCfEi6VrXKuJZPPxReOw2B1ft2RWhk9j3dPA
 uCtSG0Bnp+ZixtLgFFILJWHquw==
X-Google-Smtp-Source: AGHT+IHJ19Vrg+gE6OihB/j1swlie9996mjI56mkqU71+CoZs8NAMZCDN2E8BY1JJU0ErVxSW74wDQ==
X-Received: by 2002:a05:6a00:2d18:b0:6ce:2731:47b3 with SMTP id
 fa24-20020a056a002d1800b006ce273147b3mr15759759pfb.19.1702713218542; 
 Fri, 15 Dec 2023 23:53:38 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 u17-20020aa78491000000b006cb98a269f1sm14604675pfn.125.2023.12.15.23.53.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Dec 2023 23:53:38 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v3 0/3] meson: Fixes for dbus modules
Date: Sat, 16 Dec 2023 16:53:29 +0900
Message-Id: <20231216-dbus-v3-0-b4bcbed7374a@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHlXfWUC/22MOw7CMBAFr4K2xsi7wflQcQ9EYTsL2YIE2WAli
 nJ3nHQgynl6MzNEDsIRTrsZAieJMvQZiv0OfGf7OytpMwNpKpDQqNa9o6rLuirZu8rpBvL1Gfg
 m45a5XDN3El9DmLZqwnX9CSRUWhXHhrVprDeOzq2dehkPfnjAWkj0z6JsIROX1mpCNF/Wsiwfh
 ROb3M8AAAA=
To: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.4
Received-SPF: none client-ip=2607:f8b0:4864:20::42e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42e.google.com
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

I found it was failing to build dbus modules when --enable-dbus so here
are fixes.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Changes in v3:
- Merged dbus_display1_lib into libqemuutil.
- Added patch "audio: Do not include ui/dbus.h".
- Link to v2: https://lore.kernel.org/r/20231215-dbus-v2-0-1e2e6aa02115@daynix.com

Changes in v2:
- Updated MAINTAINERS.
- Link to v1: https://lore.kernel.org/r/20231215-dbus-v1-0-349e059ac5b2@daynix.com

---
Akihiko Odaki (3):
      Move dbus-display1 out of ui
      meson: Add dbus_display1 to util_ss and genh
      audio: Do not include ui/dbus.h

 MAINTAINERS                               |  1 +
 meson.build                               | 23 +++++++++++++++++++++++
 ui/dbus.h                                 |  2 +-
 audio/dbusaudio.c                         |  3 +--
 tests/qtest/dbus-display-test.c           |  2 +-
 audio/meson.build                         |  2 +-
 ui/dbus-display1.xml => dbus-display1.xml |  0
 tests/qtest/meson.build                   |  2 +-
 ui/meson.build                            | 20 +-------------------
 9 files changed, 30 insertions(+), 25 deletions(-)
---
base-commit: 4705fc0c8511d073bee4751c3c974aab2b10a970
change-id: 20231215-dbus-86876ecb7b09

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


