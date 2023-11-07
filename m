Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 893A57E47D4
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 19:08:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0QUY-0006kq-RU; Tue, 07 Nov 2023 13:07:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0QUW-0006kC-Fa
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:07:56 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0QUU-000246-MI
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:07:56 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4094301d505so44574275e9.2
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 10:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699380473; x=1699985273; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+9XW3EHOKM/MWCXapoGb3UX+brT9mes7VJQxcqljpE0=;
 b=E7ZJ/AZy/Q+G7hsYxlXWmfXlCswQqFomxmBur5DUywCstsrZTrDDHRKBKaWR0LSLIi
 nUUPhhv4KL3kfrTMImwzPmFw6iOY/XOLKmxEmvlI6JHS8wPzmRIHC0Y+L85hKnWaFs8k
 F1U5n+dJd0AOPF/G/hXRvs6ttow/omvhqabsHuzWet4CnSf22B/hCGSzQrj+qtyKNhWm
 zf8G4YR+cZbvQWMsed3l9gRRTtyyUz+gkBFQV73QtJYLlVQvUaw3xdciiibXM78TECYD
 4d/pYqO2sHht3q3HJDFBCqmwoekdX2/JpTYE5Xk0mCaaDbaWrXEWauZp8hbhhjqlo8d/
 r0Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699380473; x=1699985273;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+9XW3EHOKM/MWCXapoGb3UX+brT9mes7VJQxcqljpE0=;
 b=H94lIfh6FWDpFOw7VLkpxcOCpxueQZkjgXCQo4UwgnaHg8QPIxkeJAL+Rs6lszA3x8
 rlfOt11PHPBVHcTQx6mNjB9HF+lP7xHT+yBzwDgV9iW8og9fQpR2d3DYUQw/nhKLowX2
 u77Xlj5PGsjiJg0AkBVR3G7fzFS3eyb9OPKuj/f6bz0zW0dcDFhrC7LOKNAljq3cBOuZ
 7s1XfSNLDoKeGOqWDBkBYEuHc2xx6IdR5YLWPLC3/eRdKwn01TEkW9qmQWG1n88m8gBJ
 ZoSGiOKUcQT8MJLr/JbnnNPMzbXpQFl3eA9r1V2dqf9yYEaMRlOvtHFuAkUK7Fu4i+3p
 xyVw==
X-Gm-Message-State: AOJu0YxD6NA7m9FoTNXlKkhQscvFkZ+cgOD3daDR4crBoyTtbQQNfXFu
 osoZmJtyu6bPOL3NqfNk+Gc0hA==
X-Google-Smtp-Source: AGHT+IE6LV5p2t3nTLLG9Pk/DRJHrT1R4N/2pu54ln19OgQzQBdfYeW89eHgmpzCa48Ajoc5/9Jo1w==
X-Received: by 2002:a05:600c:1384:b0:405:3ae6:2413 with SMTP id
 u4-20020a05600c138400b004053ae62413mr2925122wmf.25.1699380473122; 
 Tue, 07 Nov 2023 10:07:53 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 g20-20020a05600c4ed400b003fee8793911sm16851906wmq.44.2023.11.07.10.07.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 10:07:52 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 665CC5F790;
 Tue,  7 Nov 2023 18:07:52 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Erik Schilling <erik.schilling@linaro.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, virtio-fs@redhat.com,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH v8 0/7] virtio: cleanup vhost-user-generic and reduce c&p
Date: Tue,  7 Nov 2023 18:07:45 +0000
Message-Id: <20231107180752.3458672-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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


