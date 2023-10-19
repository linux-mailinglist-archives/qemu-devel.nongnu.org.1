Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DCCF7CF480
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 11:57:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtPlK-0004zh-8p; Thu, 19 Oct 2023 05:56:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qtPlH-0004yx-Kq
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 05:56:15 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qtPlF-0006Qi-P7
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 05:56:15 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-507bd19eac8so4193310e87.0
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 02:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697709371; x=1698314171; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=98S7NRPtEG2gZGbwqDI/I8OEUT2IsSiJuqGaCj8Lgnk=;
 b=HDGSeuu1PsO041wBI2mO4GLFRZc4+yJ1L2b1MiUShdEaB8pKv3ii4H2U/RODGgj9xd
 vpa4qeoOCF7H/tbnPO8acumzv/IZKQlIlfEuOKpjjdyMqzD7no+/PX/D9NDfAzIalMi9
 gY5/wyaJQ4kjia/nftd0FsNUg1tnvmwtjUZwL76zoQ4FL/yQe28ENKOhf1qyZJlKNKtG
 Hh12dC1oZOruRWDG9eoobAXaHqBqXcwsmCGNu1mV1uI3khcBf0N86m4iyZMe6/kvsH/7
 c6D8s7nworAaqxMNeOe8zIKKbzXKjPHGJjb2oVZvjWVmoyX5nAdFT5ee7zLHGo7wx4Bb
 1h9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697709371; x=1698314171;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=98S7NRPtEG2gZGbwqDI/I8OEUT2IsSiJuqGaCj8Lgnk=;
 b=dOrgYUQ+56uQHEnTmcnZNA9QjMRnPLEiTsJX2TNyiXKHyRqsZAyFFk8v8bIhksJZ+a
 6KqHN5/Z69jYx+eVFZpWrA/sgvq3IErnePOX/kTfoX4CcwN/ZCANU3axNW0kMHoz82F6
 o1sek1h20aYHO191B+GHQ6pZgJil0KhiTkGXkD5CstuflH/uHsptpKK2NitQ1vdHF7N4
 NldqsXCoI+AS+atnVgzyxxR437oDRWi2Nkfi7bVBPGb2Cocx6N9OH0/P1JALwchbcjJG
 c2zHgveq2b28e1VgAz7y3vbaFZqL2ONvb0/N9eZwhp731obwOrE8cnSRPNoH3OnnFUPa
 nNhw==
X-Gm-Message-State: AOJu0Yyr1RTaWSypgyh1BGKoje47h0b8126il13t6eJe64hCos1jnevd
 OXhQyDuZkv0uemGA0iF+uwb1mg==
X-Google-Smtp-Source: AGHT+IGg3E6ZTGElBBalk8s2iVW2+ujun3V5BjY9nU7542sy+1DhbllFIw1v9MFJR5SWlwnm12Bl2w==
X-Received: by 2002:ac2:530c:0:b0:503:2555:d1e7 with SMTP id
 c12-20020ac2530c000000b005032555d1e7mr1159361lfh.45.1697709371041; 
 Thu, 19 Oct 2023 02:56:11 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 bg14-20020a05600c3c8e00b00401e32b25adsm4122886wmb.4.2023.10.19.02.56.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 02:56:10 -0700 (PDT)
Received: from zen.linaroharston (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 45B331FFBB;
 Thu, 19 Oct 2023 10:56:10 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 virtio-fs@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Fam Zheng <fam@euphon.net>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Erik Schilling <erik.schilling@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>
Subject: [PATCH v5 0/6] virtio: cleanup vhost-user-generic and reduce c&p
Date: Thu, 19 Oct 2023 10:56:04 +0100
Message-Id: <20231019095610.2818087-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x131.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

A lot of our vhost-user stubs are large chunks of boilerplate that do
(mostly) the same thing. This series continues the cleanups by
splitting the vhost-user-base and vhost-user-generic implementations.
After adding a new vq_size property the rng, gpio and i2c vhost-user
devices become simple specialisations of the common base defining the
ID, number of queues and potentially the config handling.

I've also added Manos' vhost-user-sound while I was at it.

Changes
-------

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
 docs/system/devices/vhost-user.rst            |  60 ++-
 ...{vhost-user-device.h => vhost-user-base.h} |  21 +-
 include/hw/virtio/vhost-user-gpio.h           |  23 +-
 include/hw/virtio/vhost-user-i2c.h            |  14 +-
 include/hw/virtio/vhost-user-rng.h            |  11 +-
 include/hw/virtio/vhost-user-snd.h            |  26 ++
 hw/virtio/vhost-user-base.c                   | 345 +++++++++++++++
 hw/virtio/vhost-user-device-pci.c             |  10 +-
 hw/virtio/vhost-user-device.c                 | 335 +-------------
 hw/virtio/vhost-user-gpio.c                   | 407 +-----------------
 hw/virtio/vhost-user-i2c.c                    | 272 +-----------
 hw/virtio/vhost-user-rng.c                    | 278 +-----------
 hw/virtio/vhost-user-snd-pci.c                |  75 ++++
 hw/virtio/vhost-user-snd.c                    |  67 +++
 hw/virtio/Kconfig                             |   5 +
 hw/virtio/meson.build                         |  23 +-
 17 files changed, 683 insertions(+), 1291 deletions(-)
 rename include/hw/virtio/{vhost-user-device.h => vhost-user-base.h} (71%)
 create mode 100644 include/hw/virtio/vhost-user-snd.h
 create mode 100644 hw/virtio/vhost-user-base.c
 create mode 100644 hw/virtio/vhost-user-snd-pci.c
 create mode 100644 hw/virtio/vhost-user-snd.c

-- 
2.39.2


