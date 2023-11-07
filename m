Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF327E47C4
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 19:04:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0QPh-00085o-CS; Tue, 07 Nov 2023 13:02:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0QPc-000859-F0
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:02:52 -0500
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0QPZ-0000dU-JN
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:02:52 -0500
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2c501bd6ff1so84439361fa.3
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 10:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699380167; x=1699984967; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7/NS4jzylqsR4woBmmhWZ8uZVX9wA7qTXVASTS+L4CQ=;
 b=uo5sBcrEd0KVUGtPhp94ugnS70n1VvYn+0RBiDsBX2PCIpIk2061Y9cuuD1LY1zE28
 JuglZCV9l50T7eeltJW0GNaArurw33ftWyFsqWFy1f58mNMbBbJBuStJunZNM5lx4bf/
 2NZlBWhmdax7wtWOcxEbjwKITdy7H12OB/htcpC6TGrcHzrK5F4epSJDacSirzZ3Z/g+
 5/AroVjEgrU0VL9lBrA6RjxRUUMHPPykxhhff69A0kAaxPpevMQQnP/DInzdk8c0tNZt
 OgrK1piNL9rmC0KKkGxWswxxGBd+4CXjHvZxhsdaIxDoWC5lNA0FR2vuhYHw4ETK0J1I
 2jJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699380167; x=1699984967;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7/NS4jzylqsR4woBmmhWZ8uZVX9wA7qTXVASTS+L4CQ=;
 b=CKBpGHKEIZ9DAXElRoGZJCVLYjw7NLd+b6xDNOHiQ7XlvB3r36AUE+/vjl0Y0x57n7
 mUViXyreNXZcb/I83XRQ39a6qFW0ZLdSrqyXSqxvJFSX2i8ARSgCnb96trNrg2Yx3dGD
 wx6Rlo3GSkyZqDzApuNR9IWE9c27ZeNgGuuHiRPWVLVJrso+wT0bUJbYpf6aF1dLrzSv
 5bANoE9J+jzkESWNoCPeQbhqnz8UBFxIbPKXMm8KcYTASvV5su4uHyTW0q/6R2qICF3b
 8vbHjoQE+4pj+SK4sk5lE4XWkSuZwo1mccT2eekfiBeRA1MbwLCXBVYW6Cs3ph1BU69r
 Fm5A==
X-Gm-Message-State: AOJu0YwO4CNuWr0J8mscOf/OaX3d7tpmYAYm/Jy4G3MREnWXrMfTzMs+
 jFsPlmUYOoXU7TM3LUcNTFpNxw==
X-Google-Smtp-Source: AGHT+IFlAneX7RuepV/F10AZo9wlJFfaVdahnJCMQ1veoSeYwD0Oask8HPJBQVhxjp1FcMwl+lHtVQ==
X-Received: by 2002:a2e:a793:0:b0:2c5:8b1:7561 with SMTP id
 c19-20020a2ea793000000b002c508b17561mr33035440ljf.10.1699380167523; 
 Tue, 07 Nov 2023 10:02:47 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 17-20020a05600c021100b004053e9276easm16057705wmi.32.2023.11.07.10.02.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 10:02:47 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A31645F790;
 Tue,  7 Nov 2023 18:02:46 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fam Zheng <fam@euphon.net>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Hanna Reitz <hreitz@redhat.com>,
 Erik Schilling <erik.schilling@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, virtio-fs@redhat.com,
 Kevin Wolf <kwolf@redhat.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>
Subject: [PATCH v7 0/7] virtio: cleanup vhost-user-generic and reduce c&p
Date: Tue,  7 Nov 2023 18:02:39 +0000
Message-Id: <20231107180246.3456598-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x231.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Manos Pitsidianakis (1):
  hw/virtio: add vhost-user-snd and virtio-snd-pci devices

 MAINTAINERS                                   |  13 +
 docs/system/devices/vhost-user-rng.rst        |   2 +
 docs/system/devices/vhost-user.rst            |  70 ++-
 ...{vhost-user-device.h => vhost-user-base.h} |  21 +-
 include/hw/virtio/vhost-user-gpio.h           |  25 +-
 include/hw/virtio/vhost-user-i2c.h            |  14 +-
 include/hw/virtio/vhost-user-rng.h            |  13 +-
 include/hw/virtio/vhost-user-snd.h            |  24 ++
 hw/virtio/vhost-user-base.c                   | 354 +++++++++++++++
 hw/virtio/vhost-user-device-pci.c             |  13 +-
 hw/virtio/vhost-user-device.c                 | 338 +--------------
 hw/virtio/vhost-user-gpio.c                   | 406 +-----------------
 hw/virtio/vhost-user-i2c.c                    | 272 +-----------
 hw/virtio/vhost-user-rng.c                    | 278 +-----------
 hw/virtio/vhost-user-snd-pci.c                |  75 ++++
 hw/virtio/vhost-user-snd.c                    |  67 +++
 hw/virtio/Kconfig                             |   5 +
 hw/virtio/meson.build                         |  23 +-
 18 files changed, 719 insertions(+), 1294 deletions(-)
 rename include/hw/virtio/{vhost-user-device.h => vhost-user-base.h} (71%)
 create mode 100644 include/hw/virtio/vhost-user-snd.h
 create mode 100644 hw/virtio/vhost-user-base.c
 create mode 100644 hw/virtio/vhost-user-snd-pci.c
 create mode 100644 hw/virtio/vhost-user-snd.c

-- 
2.39.2


