Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E27FF824A0B
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 22:11:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLUyP-0006u5-9s; Thu, 04 Jan 2024 16:09:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rLUyM-0006tU-3G
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 16:09:50 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rLUyK-0007R7-1g
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 16:09:49 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40e36bd5643so2515435e9.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jan 2024 13:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704402586; x=1705007386; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mmocIxVHM9Ec8y34XjBRHTx+9ZyDi8yaIR+1yW6fQco=;
 b=C0udZ34vvtUAJl26VaUFV3z2ZfcTzzOECBc6tCiQOs9ecNFntH2m+FYW+LgKHk0O+4
 m/iDUBUMtE+Rd/E3i7iIP7FkfzqNaKx8jHchz8cTbWjz49fPDjGlQIM3yPivVBP9G8C7
 +jC0d0Vwwi6WH1JnEP/GvjvLCrTV3XkstLXVmThSYH+FkTr6ga8/dCHiMN21EuPAHIsS
 bC3xyVfM1rZyWQzigTA9RoBFhqC9i8mgtrWjSHHtfXYEkclldKT2jGRhrFB3YeXuQ8FT
 MiByxvvtwEnckPDdGNLP+UrCG87jWlmb+ePR8TzVF1DdeYEbUSuEQ6QOY/ZcuLZyBeof
 Ur4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704402586; x=1705007386;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mmocIxVHM9Ec8y34XjBRHTx+9ZyDi8yaIR+1yW6fQco=;
 b=S53B/cUBKCICiYvHVSae0qqgHY0gk117JoTSOSoxMhIMx0LHZcFYjAzIDUMEfFXi4h
 UI1l3svDeKLXpFmC98NNUFs9Q1Hegan/pN3zPXNl+SPUVRQbwniUKAuuVikGOhgck+bX
 dKdF1/fuBQ1iZfGkjjwPL29B85gYTe8l2LJQP5d1fwhI3itIuBdTdP62FZtZVWtiZL+M
 PLIpdUuwfaOcLMKOxNu+SayasxsWMAJBPSdO4s0ZuGunx38K6JMfE72Eq8sg30Foss+c
 V0l53dqg0p+RTnF7eYx8heyjyG6IUaM2AY3PeGQaDMjmP+SkZ2n8ubIGtQjXL3czFEIH
 HD+A==
X-Gm-Message-State: AOJu0Yw01+xw4VrG81FUf4meJOxdVlKdGeVHaHLg/0mKbJ884ijKMC36
 fUV2s+mQ4q9/rNbkU7El75N8SZAsPZh6AQ==
X-Google-Smtp-Source: AGHT+IFTzlvFTWxg4+YmcQ3tYr2j5MD5fSsqpBrezMPMdFD8FjJdXohTVXcnqHHBI/ckiiRnB0WwTg==
X-Received: by 2002:a05:600c:1e01:b0:40d:86ab:2b00 with SMTP id
 ay1-20020a05600c1e0100b0040d86ab2b00mr667812wmb.123.1704402586061; 
 Thu, 04 Jan 2024 13:09:46 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 h8-20020adfa4c8000000b003375083ff8esm109398wrb.32.2024.01.04.13.09.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jan 2024 13:09:45 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1244A5F92F;
 Thu,  4 Jan 2024 21:09:45 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Jason Wang <jasowang@redhat.com>,
 Erik Schilling <erik.schilling@linaro.org>, Eric Blake <eblake@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, virtio-fs@redhat.com,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v9 00/11] virtio: cleanup vhost-user-generic and reduce c&p +
 vhost-user-input
Date: Thu,  4 Jan 2024 21:09:34 +0000
Message-Id: <20240104210945.1223134-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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

I've also added Manos' vhost-user-sound and Leo's vhost-user-input
stubs which are based on the same base.

Changes
-------

v9
  - re-base and fix conflicts
  - add Leo's vhost-user-input series

v8
  - scrubbed errant Message-Id

v7
  - various review comments
  - move to async teardown (fixes CI failure)

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

Alex Bennée (6):
  virtio: split into vhost-user-base and vhost-user-device
  hw/virtio: convert vhost-user-base to async shutdown
  hw/virtio: derive vhost-user-rng from vhost-user-base
  hw/virtio: derive vhost-user-gpio from vhost-user-base
  hw/virtio: derive vhost-user-i2c from vhost-user-base
  docs/system: add a basic enumeration of vhost-user devices

Leo Yan (4):
  hw/virtio: Support set_config() callback in vhost-user-base
  docs/system: Add vhost-user-input documentation
  hw/virtio: Move vhost-user-input into virtio folder
  hw/virtio: derive vhost-user-input from vhost-user-base

Manos Pitsidianakis (1):
  hw/virtio: add vhost-user-snd and virtio-snd-pci devices

 MAINTAINERS                                   |  16 +-
 docs/system/device-emulation.rst              |   1 +
 docs/system/devices/vhost-user-input.rst      |  45 ++
 docs/system/devices/vhost-user-rng.rst        |   2 +
 docs/system/devices/vhost-user.rst            |  72 +++-
 ...{vhost-user-device.h => vhost-user-base.h} |  21 +-
 include/hw/virtio/vhost-user-gpio.h           |  25 +-
 include/hw/virtio/vhost-user-i2c.h            |  14 +-
 include/hw/virtio/vhost-user-rng.h            |  13 +-
 include/hw/virtio/vhost-user-snd.h            |  24 ++
 include/hw/virtio/virtio-input.h              |   6 +-
 hw/input/vhost-user-input.c                   | 136 ------
 hw/virtio/vhost-user-base.c                   | 371 ++++++++++++++++
 hw/virtio/vhost-user-device-pci.c             |  13 +-
 hw/virtio/vhost-user-device.c                 | 338 +--------------
 hw/virtio/vhost-user-gpio.c                   | 407 +-----------------
 hw/virtio/vhost-user-i2c.c                    | 272 +-----------
 hw/virtio/vhost-user-input-pci.c              |   3 -
 hw/virtio/vhost-user-input.c                  |  58 +++
 hw/virtio/vhost-user-rng.c                    | 294 +------------
 hw/virtio/vhost-user-snd-pci.c                |  75 ++++
 hw/virtio/vhost-user-snd.c                    |  67 +++
 hw/input/meson.build                          |   1 -
 hw/virtio/Kconfig                             |   5 +
 hw/virtio/meson.build                         |  27 +-
 25 files changed, 850 insertions(+), 1456 deletions(-)
 create mode 100644 docs/system/devices/vhost-user-input.rst
 rename include/hw/virtio/{vhost-user-device.h => vhost-user-base.h} (71%)
 create mode 100644 include/hw/virtio/vhost-user-snd.h
 delete mode 100644 hw/input/vhost-user-input.c
 create mode 100644 hw/virtio/vhost-user-base.c
 create mode 100644 hw/virtio/vhost-user-input.c
 create mode 100644 hw/virtio/vhost-user-snd-pci.c
 create mode 100644 hw/virtio/vhost-user-snd.c

-- 
2.39.2


