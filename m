Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4D18146E5
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Dec 2023 12:29:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rE6N7-0002l0-Eh; Fri, 15 Dec 2023 06:28:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rE6My-0002kR-Vu
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 06:28:41 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rE6Mx-0007pS-5l
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 06:28:40 -0500
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-28694702c18so351807a91.3
 for <qemu-devel@nongnu.org>; Fri, 15 Dec 2023 03:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702639717; x=1703244517;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YCELKmQNNfPATvVzKW81YWq5C6cO6b4OovDr9mVveH4=;
 b=W3c5AW6qgFGVv4Kal4YBG61j0Kq4Khe9S/iPXgAEWOjNkuimbuKRCEba3FVKmb74c4
 8XoS4qdwHZCpmHioCmjQrjZOUQuhzV5Fkfb1JIBbCDJLFy0R0y53grKquBwJUt7Zd1+e
 b5ih9QRiTvFgdzeb4ROPV7I7TzQuZiPOWMTDnYshVv4+qZ9/47x1ODHPY3i4QUtLfWE6
 p0AFydNarh8ODlP5u4ijK05nt/xlJR0GHSbyh10MDmZ8kynGTcHWGm5lARr1v8u9gmZk
 omaKC0HO8AvypGD7qzP9COBsEAlPpGJFF1MBlD71syIFS8Hfgl2kMLPDol7xPjJYhsOE
 LJ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702639717; x=1703244517;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YCELKmQNNfPATvVzKW81YWq5C6cO6b4OovDr9mVveH4=;
 b=tmq6rP86HIrBHDEjQFZlIm1QiG+8xnoUe6kEFRr98N2pt9w4WtT/JbxJJoVC3rLlaT
 doN+7PGL4msZbtxHNLsvIVKVT30xzK6hXjxnBgWbUiLnWEDH38uNAfG68AcxdtQXOyAI
 ++/rYna5TFxwLf0xmHB6oWuu8H14epn7IKSFujqFj2h6fWeec/CplMZYWonqJRq+TCBm
 oSe1LL1VnYhbMLBpj7CA1WTn0RDLqIo94QTnLA4Hjs3OAs2lo3GUlpBE+u626zjrrZXq
 K0UhQNzJJEd2aFvtYSu+PrR3m+NfqeYk/13E8MqtkmgK//pZNr32PZMjMN2ihUHB8q35
 IyFg==
X-Gm-Message-State: AOJu0YwNhxR/OGOAADcz6hWguhIkM8SZkz2A5Tz05ka08uVFpCUazhOJ
 XrQLYe1S+78W4CX8cNra6K8jPw==
X-Google-Smtp-Source: AGHT+IHKlLKEpGQylsD02HtUk06a3sTCFzTm+ILjIHZu3ZmWWCVQPPP+VBZjl8Ca1WRuuxJ0JAcvzg==
X-Received: by 2002:a17:90a:5787:b0:286:742e:47b8 with SMTP id
 g7-20020a17090a578700b00286742e47b8mr8476426pji.3.1702639717344; 
 Fri, 15 Dec 2023 03:28:37 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 pq18-20020a17090b3d9200b00286dfa09e7asm14820113pjb.24.2023.12.15.03.28.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Dec 2023 03:28:36 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v2 0/4] meson: Fixes for dbus modules
Date: Fri, 15 Dec 2023 20:28:32 +0900
Message-Id: <20231215-dbus-v2-0-1e2e6aa02115@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGA4fGUC/13MSw6CMBSF4a2QO7amLRaoI/dhGPRxlTuQklYbC
 OnerQwd/icn3w4JI2GCa7NDxEyJwlxDnhpwk5mfyMjXBsllK6RQzNtPYkM39B0621uuoV6XiA9
 aD+Y+1p4ovUPcDjWL3/oHZME4ay8audLGKStv3mwzrWcXXjCWUr7Toa3PmQAAAA==
To: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.4
Received-SPF: none client-ip=2607:f8b0:4864:20::102f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102f.google.com
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
Changes in v2:
- Updated MAINTAINERS.
- Link to v1: https://lore.kernel.org/r/20231215-dbus-v1-0-349e059ac5b2@daynix.com

---
Akihiko Odaki (4):
      Move dbus-display1 out of ui
      audio: Depend on dbus_display1_dep
      meson: Explicitly specify dbus-display1.h dependency
      tests/qtest: Depend on dbus_display1_dep

 MAINTAINERS                               |  1 +
 meson.build                               | 21 +++++++++++++++++++++
 ui/dbus.h                                 |  2 +-
 audio/dbusaudio.c                         |  2 +-
 tests/qtest/dbus-display-test.c           |  2 +-
 audio/meson.build                         |  3 ++-
 ui/dbus-display1.xml => dbus-display1.xml |  0
 tests/qtest/meson.build                   |  2 +-
 ui/meson.build                            | 18 ------------------
 9 files changed, 28 insertions(+), 23 deletions(-)
---
base-commit: 4705fc0c8511d073bee4751c3c974aab2b10a970
change-id: 20231215-dbus-86876ecb7b09

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


