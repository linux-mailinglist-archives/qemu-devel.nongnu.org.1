Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC75815DB7
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Dec 2023 07:07:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rEkIJ-0007a7-P9; Sun, 17 Dec 2023 01:06:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rEkIG-0007Zw-Cm
 for qemu-devel@nongnu.org; Sun, 17 Dec 2023 01:06:28 -0500
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rEkIA-0004U2-JY
 for qemu-devel@nongnu.org; Sun, 17 Dec 2023 01:06:28 -0500
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-5906e03a7a4so1469192eaf.1
 for <qemu-devel@nongnu.org>; Sat, 16 Dec 2023 22:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702793180; x=1703397980;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BGT/1EuaWF4IlDkd+WJ9O9HZfmew1ytH9C8ic4i8YpM=;
 b=WCEwfXvLEqODJb4Rwz4W6tffF0PTg1EaAqsmTvCwmQGHTm+a2frUYplAlJMnh/HG7C
 XlG6PRrZzshSkdJ95G6xFqKMY+9BsrGj8Kzh8UTI4d1ydKQuOCxrioT9CkHgea/9+Ydj
 Cpx7BvbK5/jxKqE0FPKB/MMOUwpuv8rHaZAjMyLqvQawYh5imjZtIJiBJbmIW+wR+mLh
 exZuhGt9NG1Ifsf7AzANKaSu/bra9mhQmFwdiVrpLh9L1YWjyFgL5g3vNiy9nr5M6SKV
 B7uYentkagd3AGHusjde5XtPx047GXO8ERFl1GWucWHHWz32nxOVxapkJM6cGq1S4t7L
 HOeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702793180; x=1703397980;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BGT/1EuaWF4IlDkd+WJ9O9HZfmew1ytH9C8ic4i8YpM=;
 b=XKdcwL1OmvPw0KevD/cWHsglkGirYQwHzU175RZN5A2KddlpZkgb/se8hUeu9B0Ehe
 80OoES/nyY2ZTEULkWn9Oyucdsg33rNyofsWIOXEV0D0qtF4g4zrcPcz3TUk0edYjre6
 pGdOLv766+5xsjxWy+JxwPCn2qrIWcH0/RBuV2bkHaWBtS3C5wRRT4M7ovv0cWXfh9l2
 5HGdS8vraHkrxoI1XUU2UEjq8eHnXVOdjf0OHIeVnI4qwtXKkum/2jLlgTMM4YCr61/d
 ssldbAX2pLWlFtyK1wqfUMJPpSnmUVCjs5UDncK5iwAdIA4dtW1DY5Rw5ZSLsqdvnlbC
 ulZw==
X-Gm-Message-State: AOJu0YzBnxYW3GrIrCo1w9mD+ztUgw+dbfyYlrdWsdCrvPbLszlYaouR
 PKNy6ALzRZsspyNRN+SqpDP8Ew==
X-Google-Smtp-Source: AGHT+IGa6CU6eTmxrXZH3oKXogr2JbhGKhtLUX7XdeD207COITtBqpzmQqoT50V06s/bm1iXB/NhIg==
X-Received: by 2002:a05:6808:6490:b0:3b9:f8eb:21ee with SMTP id
 fh16-20020a056808649000b003b9f8eb21eemr18616924oib.104.1702793180209; 
 Sat, 16 Dec 2023 22:06:20 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 x12-20020a17090a970c00b0028649b84907sm18736654pjo.16.2023.12.16.22.06.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 16 Dec 2023 22:06:19 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v4 0/2] meson: Fixes for dbus modules
Date: Sun, 17 Dec 2023 15:06:14 +0900
Message-Id: <20231217-dbus-v4-0-4fd5410bf04f@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANePfmUC/23Myw7CIBCF4VcxrMXAAKV15XsYF1xGy8LWgJI2T
 d9d2rjwtjyT+f6JJIwBE9lvJhIxhxT6rgy53RDXmu6CNPiyCTAQHLii3j4SrataV+istqwh5fU
 W8RyGNXM8ld2GdO/juFYzX65fgcwpo0I2yFRjnLJw8GbswrBz/ZUshQz/FBTFEbAyhgHn6keJd
 1W9lCjKSussei20NB9qnucnLQxBSgUBAAA=
To: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.4
Received-SPF: none client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oo1-xc2a.google.com
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
 ui/dbus.h                       |  2 +-
 audio/dbusaudio.c               |  3 +--
 tests/qtest/dbus-display-test.c |  2 +-
 audio/meson.build               |  2 +-
 tests/qtest/meson.build         |  2 +-
 ui/meson.build                  | 20 +-------------------
 {ui => util}/dbus-display1.xml  |  0
 util/meson.build                | 21 +++++++++++++++++++++
 9 files changed, 28 insertions(+), 26 deletions(-)
---
base-commit: 4705fc0c8511d073bee4751c3c974aab2b10a970
change-id: 20231215-dbus-86876ecb7b09

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


