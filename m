Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C661D815DBB
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Dec 2023 07:13:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rEkOe-0001e4-8r; Sun, 17 Dec 2023 01:13:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rEkOb-0001dr-Th
 for qemu-devel@nongnu.org; Sun, 17 Dec 2023 01:13:02 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rEkOa-0005QU-3A
 for qemu-devel@nongnu.org; Sun, 17 Dec 2023 01:13:01 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6ceba6c4b8dso1777796b3a.1
 for <qemu-devel@nongnu.org>; Sat, 16 Dec 2023 22:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702793577; x=1703398377;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=h19Wz51S6VFToCO4MpnG/+6wb0DpFvTS19hzP3IEmnY=;
 b=DjWEyYGWXcg+uhh5uK2J86Nv48oSkgXFzUxQ4acCqAlyQWxSSt7SXG0qswLcb+WAz5
 qIlTq7V+LSc3PyQVwb4KGcuX4HtwORErIXNl5UhGQVK3+TFBGbWDA/KK80Kh1Z4yHUKA
 Nx+sdedIfy8QMkIeVT8bP4DOdT9a/z/qTTGI98SAY2GkuYjOGRpiSODyqeoMpqHsT46t
 vK+cj5vlz+8RcJKWVTBJtZIuk2LUmPN3MMic5OWD2AOnzvp/TWNB9fhskUlIQxKEpy4h
 r8mQAgCuwRRc6jSBD5P5EOVGcYOGq9Wt2EqEdHkVSoOukw/adc9u3TgMnIpGNqbCILFH
 XBtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702793577; x=1703398377;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h19Wz51S6VFToCO4MpnG/+6wb0DpFvTS19hzP3IEmnY=;
 b=s54YIn5Wkk7GqQ4fNUVAXgCtGCmgNwUs+YBCQC0weD4478t94QZBt9/bHd6iRJhyjn
 hXQKFa2cUdvPHfQWe9FBjIimiVIMz95G1dRbnXHIc5PGd9aAMMRXlbEyBZOPduXnvnRp
 jae6ERMAdqzaKHIRsEFx1z5RflbsbRbw2ghYsZB6p8/MpD52uHRdLP99mn8iWdca/jRa
 08rvNbaZgYR0HlIjELeINlyj2JPIwKCfbjTkMca9mJxDLH4Igm+5LbjaB8T7KWkCgnPn
 y6FbfCUxgZp8l745jJyJUPSjOmmLq+oAUlxAfNip0etAJdIVfPozC4eOxZZfZssK3Tu1
 zdyQ==
X-Gm-Message-State: AOJu0YxDUdTXmPkwbcHFPaE7wpnrBfwauMdaV9SvmacGaNtfTcIbOPjy
 bC2jcLZor5ncdD7wqWg5Xos8Cw==
X-Google-Smtp-Source: AGHT+IG9fri6Qb8vfV/wQa1W88+33Ak5EpByQI62k4P8S403vbFFglZTdwvS6NX7akF6RiU5YtQ6wA==
X-Received: by 2002:a05:6a00:1789:b0:6ce:6cae:c262 with SMTP id
 s9-20020a056a00178900b006ce6caec262mr18394710pfg.11.1702793577449; 
 Sat, 16 Dec 2023 22:12:57 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 r1-20020a62e401000000b006ce91d27c72sm16484055pfh.175.2023.12.16.22.12.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 16 Dec 2023 22:12:57 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v5 0/2] meson: Fixes for dbus modules
Date: Sun, 17 Dec 2023 15:12:51 +0900
Message-Id: <20231217-dbus-v5-0-8122e822a392@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGORfmUC/23MSw6CMBSF4a2Yjq3pu+DIfRgHfdxKB4KhSiCEv
 VsIAxSH5+Z+/4gStBESOh9G1EIXU2zqPOTxgFxl6jvg6PNGjDBOGZXY23fChSq0Ame1JSXKr88
 WQuyXzPWWdxXTq2mHpdrR+foT6CgmmIsSiCyNk5ZdvBnq2J9c80BzoWP/FMuKAgNlDGGUyp3iW
 6VWxbOywjoLXnMtzE6JrdKrElmJ4KWgxAYiwpeapukDZ+nNXDsBAAA=
To: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.4
Received-SPF: none client-ip=2607:f8b0:4864:20::429;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x429.google.com
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
Changes in v5:
- Fixed docs/interop/dbus-display.rst.
- Link to v4: https://lore.kernel.org/r/20231217-dbus-v4-0-4fd5410bf04f@daynix.com

Changes in v4:
- Moved dbus_display1 to util.
- Link to v3: https://lore.kernel.org/r/20231216-dbus-v3-0-b4bcbed7374a@daynix.com

Changes in v3:
- Merged dbus_display1_lib into libqemuutil.
- Added patch "audio: Do not include ui/dbus.h".
- Link to v2: https://lore.kernel.org/r/20231215-dbus-v2-0-1e2e6aa02115@daynix.com

Changes in v2:
- Updated MAINTAINERS.
- Link to v1: https://lore.kernel.org/r/20231215-dbus-v1-0-349e059ac5b2@daynix.com

---
Akihiko Odaki (2):
      util: Move dbus_display1 to util
      audio: Do not include ui/dbus.h

 MAINTAINERS                     |  2 +-
 docs/interop/dbus-display.rst   |  6 +++---
 ui/dbus.h                       |  2 +-
 audio/dbusaudio.c               |  3 +--
 tests/qtest/dbus-display-test.c |  2 +-
 audio/meson.build               |  2 +-
 tests/qtest/meson.build         |  2 +-
 ui/meson.build                  | 20 +-------------------
 {ui => util}/dbus-display1.xml  |  0
 util/meson.build                | 21 +++++++++++++++++++++
 10 files changed, 31 insertions(+), 29 deletions(-)
---
base-commit: 4705fc0c8511d073bee4751c3c974aab2b10a970
change-id: 20231215-dbus-86876ecb7b09

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


