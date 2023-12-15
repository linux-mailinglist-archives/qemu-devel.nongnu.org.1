Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B6BC18146C3
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Dec 2023 12:23:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rE6GV-0005Yc-1x; Fri, 15 Dec 2023 06:21:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rE6GS-0005YA-1A
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 06:21:56 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rE6GQ-0001AL-Dy
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 06:21:55 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6cebbf51742so357302b3a.1
 for <qemu-devel@nongnu.org>; Fri, 15 Dec 2023 03:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702639313; x=1703244113;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DBFE3Wk5njtNrf59/LHKiXjllHWHHI9RsajCVwRkkOs=;
 b=wmxoSPnPIvE8vPw2m+3Qa59KeCBTH1gujBI0J/Z+q29ymtY9f9ApzbSUgTLtfN04KZ
 U65pD3v1/QUUD0GJDbyREwurjY1MKKrdGUKrMmssQnkKTJM7fbLFTc5rX1esJfH6oVAv
 rIT+k/jEiC8TQeWbQ1Nz7Z0dXIxM+o/jvQVjGkcJZc/cbtO6M5XUD7akNSdq297+zk8R
 CvOD4G7ZWynF//N5RuPiCXDaWTvOn5kGLOQWkQu6L12AlCrCQy8IAsBnkHnhlzGB4r/x
 J1/Mm0r8ul0FjsWfiURcZGEgM1NJ8DLsJgKNfrT02Ck+6MKUNwgcH6z7zPzAxy7de1r6
 ZmsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702639313; x=1703244113;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DBFE3Wk5njtNrf59/LHKiXjllHWHHI9RsajCVwRkkOs=;
 b=R+mE/H17DpPeypsB6dkvxerkI9+2ToJ1bxrcrs2zsdaD77UcmI38a4RazdvzS2mT9H
 brMznb6UJqpTWLpEr4w0h6GzwSWFIcNHPNxOQKpS8AD0D7rMZ2AczY09HhaTgsaWQViI
 spegatV90vfrqHMGjULoN+nu+szSjz+KRkz22c4LuGOjC7C0kpWSDCHwfUPFfy8ScX8A
 URRUI1SFTWuvBtJKE3sCRm0H/t5fWHRdYGxceulV5cLtwi0L4sSRLkQrHIGBQo0xvsH6
 FUqj5N7Q30cNCT7DOAnpGW+w568YyzrVXEk6xPsNo6/dlbBg8GTdZOTCBxC7ykd4PYCY
 iP4w==
X-Gm-Message-State: AOJu0YwZyEXlEQBfXub7LPmOBz1op3VJXPnU+60qp9qlEzVx7y+sAH7n
 pV8n/3OJoLGVIaHsuksk5C/fvA==
X-Google-Smtp-Source: AGHT+IHsTmLWEpLsbmDTe/fMvTRiNIYO5sGpl9adgfT56icVCDbRiQ3Kgca67YSeEh9kW+Hod2JIeA==
X-Received: by 2002:a05:6a20:65b0:b0:190:6d:1c5a with SMTP id
 p48-20020a056a2065b000b00190006d1c5amr11013688pzh.56.1702639312828; 
 Fri, 15 Dec 2023 03:21:52 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 o14-20020a63e34e000000b005c67bb1585csm13140889pgj.68.2023.12.15.03.21.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Dec 2023 03:21:52 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH 0/4] meson: Fixes for dbus modules
Date: Fri, 15 Dec 2023 20:21:35 +0900
Message-Id: <20231215-dbus-v1-0-349e059ac5b2@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL82fGUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDI0NT3ZSk0mJdCzMLc7PU5CTzJANLJaDSgqLUtMwKsDHRsbW1APYB/PV
 WAAAA
To: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.4
Received-SPF: none client-ip=2607:f8b0:4864:20::42c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42c.google.com
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
Akihiko Odaki (4):
      Move dbus-display1 out of ui
      audio: Depend on dbus_display1_dep
      meson: Explicitly specify dbus-display1.h dependency
      tests/qtest: Depend on dbus_display1_dep

 meson.build                               | 21 +++++++++++++++++++++
 ui/dbus.h                                 |  2 +-
 audio/dbusaudio.c                         |  2 +-
 tests/qtest/dbus-display-test.c           |  2 +-
 audio/meson.build                         |  3 ++-
 ui/dbus-display1.xml => dbus-display1.xml |  0
 tests/qtest/meson.build                   |  2 +-
 ui/meson.build                            | 18 ------------------
 8 files changed, 27 insertions(+), 23 deletions(-)
---
base-commit: 4705fc0c8511d073bee4751c3c974aab2b10a970
change-id: 20231215-dbus-86876ecb7b09

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


