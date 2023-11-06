Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D3BB87E2CB7
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 20:17:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r054H-0007pp-Od; Mon, 06 Nov 2023 14:15:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r054F-0007pY-Q7
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 14:15:23 -0500
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r054A-0005hF-Nd
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 14:15:23 -0500
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2c50d1b9f22so64711121fa.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 11:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699298117; x=1699902917; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Qmj8n16WRX5qkSaR82mhwTNhyAAZT1HBdA/s8U4MLR0=;
 b=Pw4/iqxXVIWHHJFOOekeItQYbAq61f4PkYr5RAbRLQ+ZKBzDE3l53PvCMEkEslFl8e
 MsUu8L8PQCJXX+219EXwXgzZ00dhqXsXPiEPBCXYX6Av+vdgxqBz7A2jPm05i73aFjtg
 8kOrTd/PTELDdFtSBmYNTISKzqxq9gDFMo9XNIvd5YsphBllZPbldDs3EJ2Sq/YrsCR0
 npRRY1q1Lrt2qkPSQMPzCQy3Quaq2Sb3x9pyxNKl7LBPequLy9kKMj0K+jZQInuRbHji
 WLPoxQDW53c6/wwewCGtws3pwH9bC9tA2ekhzoJmAPX/bszwdJMfdzbItMqOva+wg0f/
 aslw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699298117; x=1699902917;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Qmj8n16WRX5qkSaR82mhwTNhyAAZT1HBdA/s8U4MLR0=;
 b=md1XZvYtbK+cPpPm7NovBs1MVzQEPTt9V/pW/R2vjzaI81Q8dmWdZ27K6OpPMVui2g
 2f+GunMP3wmuw7F10nHpwao8EICnPlvw8Ikeab6Aq9ZG+8mDy9UnIx1Zh9vbMdU7Zrbs
 OCVFt+CzIlTb64hV7dLfRoOjZu+iX7r/zh6hfzt2Or0s/FSYEnQ6m1bAiwZ7wYvLxYkz
 MNUL5YferN2wt+omt9Lt9+4j6qPt3jj3gDmlUDZy0P4A89RXDpGenxiEI0mzVIOwVMhb
 QSX7qgbNYtOPSj/SF96N5rLd9zo/lF5cMymB7lEXkPNtxuCsf1EnszYzkrL7GjdosZnH
 GJhw==
X-Gm-Message-State: AOJu0Ywga9nSsWC2uofPADxFNCbbvN2W5ZcR/gcLL/vn7vHc34dSWbSD
 LfePc5r5KByNh9mmiYM7j3tSIA==
X-Google-Smtp-Source: AGHT+IEsyCtcnAJ2ZtB2LhBi0FQuoL2770BX1Ynq5KjVEDvfMVETda1z0cH6D1vPKIFpVtcFaNDggQ==
X-Received: by 2002:a2e:9d55:0:b0:2c5:1674:8d79 with SMTP id
 y21-20020a2e9d55000000b002c516748d79mr23848326ljj.21.1699298116756; 
 Mon, 06 Nov 2023 11:15:16 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 d8-20020a05600c34c800b0040770ec2c19sm13569630wmq.10.2023.11.06.11.15.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 11:15:16 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C393D65565;
 Mon,  6 Nov 2023 19:15:15 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, virtio-fs@redhat.com,
 Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Kevin Wolf <kwolf@redhat.com>, Erik Schilling <erik.schilling@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v6 0/6] virtio: cleanup vhost-user-generic and reduce c&p
Date: Mon,  6 Nov 2023 19:15:09 +0000
Message-Id: <20231106191515.2801863-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x22c.google.com
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

A lot of our vhost-user stubs are large chunks of boilerplate that do
(mostly) the same thing. This series continues the cleanups by
splitting the vhost-user-base and vhost-user-generic implementations.
After adding a new vq_size property the rng, gpio and i2c vhost-user
devices become simple specialisations of the common base defining the
ID, number of queues and potentially the config handling.

I've also added Manos' vhost-user-sound while I was at it.

Changes
-------

v6
  - re-base to current master
  - make vhost-user-device abstract
  - mention abstractness in docs

v5
  - addressing comments and tags
  - improved the docs

v4
  - dropped the F_TRANSPORT work for another series
  - added vhost-user-sound

Alex Bennée (5):
  virtio: split into vhost-user-base and vhost-user-device
  hw/virtio: derive vhost-user-rng from vhost-user-base
  hw/virtio: derive vhost-user-gpio from vhost-user-base
  hw/virtio: derive vhost-user-i2c from vhost-user-base
  docs/system: add a basic enumeration of vhost-user devices

Manos Pitsidianakis (1):
  hw/virtio: add vhost-user-snd and virtio-snd-pci devices

 docs/system/devices/vhost-user-rng.rst        |   2 +
 docs/system/devices/vhost-user.rst            |  65 ++-
 ...{vhost-user-device.h => vhost-user-base.h} |  21 +-
 include/hw/virtio/vhost-user-gpio.h           |  23 +-
 include/hw/virtio/vhost-user-i2c.h            |  14 +-
 include/hw/virtio/vhost-user-rng.h            |  11 +-
 include/hw/virtio/vhost-user-snd.h            |  26 ++
 hw/virtio/vhost-user-base.c                   | 345 +++++++++++++++
 hw/virtio/vhost-user-device-pci.c             |  10 +-
 hw/virtio/vhost-user-device.c                 | 337 +--------------
 hw/virtio/vhost-user-gpio.c                   | 406 +-----------------
 hw/virtio/vhost-user-i2c.c                    | 272 +-----------
 hw/virtio/vhost-user-rng.c                    | 278 +-----------
 hw/virtio/vhost-user-snd-pci.c                |  75 ++++
 hw/virtio/vhost-user-snd.c                    |  67 +++
 hw/virtio/Kconfig                             |   5 +
 hw/virtio/meson.build                         |  23 +-
 17 files changed, 690 insertions(+), 1290 deletions(-)
 rename include/hw/virtio/{vhost-user-device.h => vhost-user-base.h} (71%)
 create mode 100644 include/hw/virtio/vhost-user-snd.h
 create mode 100644 hw/virtio/vhost-user-base.c
 create mode 100644 hw/virtio/vhost-user-snd-pci.c
 create mode 100644 hw/virtio/vhost-user-snd.c

-- 
2.39.2


