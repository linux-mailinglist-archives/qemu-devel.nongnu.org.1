Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7025374DA06
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 17:38:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIsvI-0005Zs-3I; Mon, 10 Jul 2023 11:35:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qIsv9-0005Y4-Vm
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 11:35:28 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qIsv7-0004hV-OK
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 11:35:27 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3fbc63c2e84so51838725e9.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 08:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689003324; x=1691595324;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XSMILEeS8Isq93UXfxuGWCtLXuOlbMWTCm5hqyU44q8=;
 b=p3QnVk6XCI1jjoYWAlbDymHSAu4DWDLkyu/t41kl9JmEO64qA0hcSoY3pm/oX0EcvK
 R5U6rsqyKhXHms1yeU3S9QDPaaka0tsLyZFYjuNpmYRdx0qxu+LuudT9bP7QmjST1Rtk
 WnPbfBRne/JGnMiL3RVx7vvsTBh01aSi+pGCLTdjBtGdrAzjh0uBzB6zbcxXTQK8PZZF
 BKuW05FAmVCYtnSvpmncK+luBn4mYo6FloNze/XrvirPzLYzNlCRoEhS3XYaUY5T6o5A
 VUE2GBMbixCDdzMqUcdlAh+sz7cKbWTzEXVuWm5d1MX9oVMeRVE135r0k24gBzdjsJck
 U4Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689003324; x=1691595324;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XSMILEeS8Isq93UXfxuGWCtLXuOlbMWTCm5hqyU44q8=;
 b=U5IIo1kdYQEnMTXN9A1Hf283ixPHERLRzGHOe7hoCKIRIreRJvN7hvpWknUrqL3uPW
 karjkYsRds8SVe2Avs1jZv5LuXa3AA4sT6JvKQzJlmaaEv9dfjiAv8qEcO5ZwLihGj+m
 LSmSVbrrqoj5yfaSASEZXYIqTp9a/18j9JFAor8IZTmeeTtv85IlbZHomUNyjVRxZkH6
 8xLsx+fWdZItg+LgLAR/nnJHzZI7QQzqsHjJy3uA4TGFhmFrFisLmU/YYMLkSEEB8WXU
 am6LKVuSuO9MEgp8TfocVvMGgzMGAD85is8OKzuOwRWqj5Kr4a8mEK8yzTTyGCdetxqu
 KD2Q==
X-Gm-Message-State: ABy/qLb0F+IYC2gs/hf9kFpdUrNA+bFJMwFHXjbvtsZTRk2qPbMm36qB
 SXFNoWdzv9vzRNVDhdStGfP4FA==
X-Google-Smtp-Source: APBJJlGRHnDsdQqGN0VZzOWJ7uSJ4dIlrxGDNY99mxLMW8wH4TW9LMDPKJPpczP13abJvryzlKc/JA==
X-Received: by 2002:a1c:7712:0:b0:3fa:71db:56ff with SMTP id
 t18-20020a1c7712000000b003fa71db56ffmr12555990wmi.40.1689003323799; 
 Mon, 10 Jul 2023 08:35:23 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 l15-20020a1c790f000000b003fc01f7b415sm8443935wme.39.2023.07.10.08.35.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 08:35:22 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 324141FFBB;
 Mon, 10 Jul 2023 16:35:22 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Viresh Kumar <viresh.kumar@linaro.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Erik Schilling <erik.schilling@linaro.org>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>, Fam Zheng <fam@euphon.net>,
 virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v3 00/20] virtio: add vhost-user-generic,
 reduce c&p and support standalone
Date: Mon, 10 Jul 2023 16:35:02 +0100
Message-Id: <20230710153522.3469097-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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
(mostly) the same thing. This series attempts to fix that by defining
a new base class (vhost-user-base) which is used by a generic
vhost-user-device implementation. Then the rng, gpio and i2c
vhost-user devices become simple specialisations of the common base
defining the ID, number of queues and potentially the config handling.

However as of v3 we go a bit further and introduce a new protocol
feature called F_STANDALONE which adds some messages to vhost-user
that allow the daemon to fully advertise its capabilities.

Example
=======

Using the vhost-device-rng built from this branch (draft PR):

  https://github.com/rust-vmm/vhost-device/pull/394

You can start QEMU with an even simpler command line:

  -chardev socket,id=vus,path=/tmp/vus.sock0 \
  -device vhost-user-device-pci,chardev=vus \
  -d trace:vhost_\*,trace:vhost_user\*

which doesn't specify any queues or config space but gets it from the
daemon as it starts up. This does involve a bit of shuffling around in
the guts of the vhost code so currently it is RFC status.

Anything for 8.1?
=================

mst,

I don't know if you want to cherry pick anything up to and including:

  hw/virtio: derive vhost-user-i2c from vhost-user-base

which is at least a cleanup. However I'm on holiday for the next 3 or
so weeks so it's perfectly ok to leave this as 8.2 material if you
want.

Alex.

Alex Bennée (20):
  include: attempt to document device_class_set_props
  include/hw: document the device_class_set_parent_* fns
  hw/virtio: fix typo in VIRTIO_CONFIG_IRQ_IDX comments
  include/hw/virtio: document virtio_notify_config
  include/hw/virtio: add kerneldoc for virtio_init
  include/hw/virtio: document some more usage of notifiers
  virtio: add vhost-user-base and a generic vhost-user-device
  virtio: add PCI stub for vhost-user-device
  hw/virtio: derive vhost-user-rng from vhost-user-device
  hw/virtio: add config support to vhost-user-device
  hw/virtio: derive vhost-user-gpio from vhost-user-device
  hw/virtio: derive vhost-user-i2c from vhost-user-base
  docs/system: add a basic enumeration of vhost-user devices
  docs/interop: define STANDALONE protocol feature for vhost-user
  hw/virtio: move vhost_user_init earlier
  hw/virtio: move virtq initialisation into internal helper
  hw/virtio: push down allocation responsibility for vhost_dev->vqs
  hw/virtio: validate F_STANDALONE also supports other protocol features
  hw/virtio: probe backend for specs if it supports it
  hw/virtio: allow vhost-user-device to be driven by backend

 docs/interop/vhost-user.rst            |  39 +++
 docs/system/devices/vhost-user-rng.rst |   2 +
 docs/system/devices/vhost-user.rst     |  41 +++
 include/hw/qdev-core.h                 |  36 +++
 include/hw/virtio/vhost-user-blk.h     |   1 -
 include/hw/virtio/vhost-user-device.h  |  46 +++
 include/hw/virtio/vhost-user-gpio.h    |  23 +-
 include/hw/virtio/vhost-user-i2c.h     |  18 +-
 include/hw/virtio/vhost-user-rng.h     |  11 +-
 include/hw/virtio/vhost.h              |  21 ++
 include/hw/virtio/virtio.h             |  21 ++
 backends/vhost-user.c                  |   1 -
 hw/block/vhost-user-blk.c              |   7 +-
 hw/display/vhost-user-gpu.c            |   4 +-
 hw/net/virtio-net.c                    |   4 +-
 hw/scsi/vhost-scsi.c                   |   2 -
 hw/scsi/vhost-user-scsi.c              |   6 -
 hw/virtio/vdpa-dev.c                   |   9 +-
 hw/virtio/vhost-user-device-pci.c      |  71 +++++
 hw/virtio/vhost-user-device.c          | 396 ++++++++++++++++++++++++
 hw/virtio/vhost-user-fs.c              |   5 +-
 hw/virtio/vhost-user-gpio.c            | 400 ++-----------------------
 hw/virtio/vhost-user-i2c.c             | 271 +----------------
 hw/virtio/vhost-user-rng.c             | 277 ++---------------
 hw/virtio/vhost-user.c                 |  84 ++++++
 hw/virtio/vhost-vsock-common.c         |   4 +-
 hw/virtio/vhost.c                      |  70 +++--
 hw/virtio/virtio-crypto.c              |   4 +-
 hw/virtio/meson.build                  |  20 +-
 29 files changed, 898 insertions(+), 996 deletions(-)
 create mode 100644 include/hw/virtio/vhost-user-device.h
 create mode 100644 hw/virtio/vhost-user-device-pci.c
 create mode 100644 hw/virtio/vhost-user-device.c

-- 
2.39.2


