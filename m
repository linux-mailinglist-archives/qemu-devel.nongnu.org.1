Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CAC8A149C8
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Jan 2025 07:48:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYg8Y-0002tG-BW; Fri, 17 Jan 2025 01:47:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tYg8V-0002sz-LZ
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 01:47:19 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tYg8R-00055I-V3
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 01:47:18 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2165448243fso39792435ad.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 22:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737096434; x=1737701234;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RPGtldq2AToABPoGlvtRrOakExknZokmZy+QMhvNIp4=;
 b=JW4QIS7PwaD4B3szwYBpAH1aSq1Gbj2Hyo3Wq+Dr0fDqoFSC4BZRuqG6T6BVAXCZ33
 JH6dn/uNpESYT5tzptDG82nbO26omtHE7N2U2wNQGI2Byh0JQtZkJTXAiIvY7t9U59xC
 kBs+9LSZidooIj8Ku5EQpROkGbCXqGo9OnYBCZSCdItgetwiHQ07bbmsQRckmp+eBHWo
 YN6meM+hvBYqRT2cHi/NCgXe5YsE3YCv1W4pTXQTZT7fZh8mA7Pu9JbNatexYXjQnTUR
 jwIk3vwR/SyLTq79Ihz/cXPZRFfmrYI/lLshppvJkBcLtM6Ie3KzQhQDtwbHUdp/1klU
 3XRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737096434; x=1737701234;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RPGtldq2AToABPoGlvtRrOakExknZokmZy+QMhvNIp4=;
 b=jumLgRmQmLhk95vvWnk9r/xJyMeE1z0tBKsGiDhzFKeNAUuyyyK3vGPHRe9QzXRnf6
 s2ZAzFxtujHVDHyU/cm8si7i/iArwQRvfQHml/LneBCH/HsOs0yCnV87C1Kh+eOl0YhA
 Gnas+MXa6LQ2KiE8Bdb4/GBlfrexm0Adt2IYbqgDu96U2BJ4e/VmxB9P/jbj9MUK5XED
 jFtugrxHOK0STgfHAfpT7sBIkRGnssclRrfSbNC6BGv+SKl0PWvo2LbkxuJh2Q+4+1LB
 KHOzj3stGysT8LTZo1aVG0v4zeFHG4TVPs4di5FQLcabMSY0U63dLj6PU0CGcD/+ooF9
 kTNQ==
X-Gm-Message-State: AOJu0Yw/b3JglZf+8QOfRe7aLp9ZARpMQ2V5m7CwaABpRiVO7VwJwP3N
 jfM9WpWp5Zf7HJ6Z8cEFj6BFM7f9KAp6fN5F15onXU6aD1EE3gLnP6Jze0K6JPk=
X-Gm-Gg: ASbGnctoZk9fkUjhVWqnnz1OvuuScbBleL7c46UtZ7Os9XHS0U5Qz5leR4t/EOqouM5
 6T8mIB1PCEG2dJrjIwX/dsJeKosZpzTkOkzWIc03Nzx8cDU1suFwQlNrziXotrYq48R2ZguiXTn
 DpqaAuRi+xJ4dI2LnGXXNorxfJ9N+rwD7n+dVJV5V37dKyBsm7vCMyjxyQGxp1NvPlYo9Eehi3X
 +1xbv4Uaj6uTsADmBTUUSkMzybHociiQgRL47GU6bRLubP2QIlZr7FApKU=
X-Google-Smtp-Source: AGHT+IF4ziTWiN1zYOMCG6aNy9FKknQChL4hpMwe+6+4QHJRTSNGNjQPWoTGn5SsPQIsKeB2i1MtYw==
X-Received: by 2002:a05:6a00:4fd3:b0:728:e1e3:3d88 with SMTP id
 d2e1a72fcca58-72daf9bec6amr2792941b3a.7.1737096433975; 
 Thu, 16 Jan 2025 22:47:13 -0800 (PST)
Received: from localhost ([157.82.203.37]) by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-72dab7f1776sm1068924b3a.7.2025.01.16.22.47.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2025 22:47:13 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v4 0/3] coreaudio fixes
Date: Fri, 17 Jan 2025 15:46:59 +0900
Message-Id: <20250117-coreaudio-v4-0-f8d4fa4cb5f4@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOP8iWcC/03MQQ6DIBCF4auYWZcGVKx21Xs0LgSGOouCgZZoD
 HcvNV10+b+8fDtEDIQRrtUOARNF8q5Ee6pAz5N7ICNTGmpeSy74wLQPOL0NeaaHvu34BYXpNZT
 /EtDSelj3sfRM8eXDdtCp+a4/Rcg/JTWMM2VUp7SSyg72ZqbN0XrW/gljzvkDZlDXLaMAAAA=
To: Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: qemu-devel@nongnu.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

This series contains two fixes for coreaudio. See each one for details.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Changes in v4:
- Splitted patch "audio: Add functions to initialize buffers" from
  patch "coreaudio: Initialize the buffer for device change".
- Changed the message of patch "coreaudio: Commit the result of init in
  the end" to tell that early returns happen when there is a fatal error
  or the device gets unplugged.
- Link to v3: https://lore.kernel.org/r/20250115-coreaudio-v3-0-bdb6bcb5bf9f@daynix.com

---
Akihiko Odaki (3):
      coreaudio: Commit the result of init in the end
      audio: Add functions to initialize buffers
      coreaudio: Initialize the buffer for device change

 audio/audio_int.h |  2 ++
 audio/audio.c     | 24 ++++++++++++++++++------
 audio/coreaudio.m | 50 ++++++++++++++++++++++++++++----------------------
 3 files changed, 48 insertions(+), 28 deletions(-)
---
base-commit: 38d0939b86e2eef6f6a622c6f1f7befda0146595
change-id: 20250109-coreaudio-c984607e1d8c

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


