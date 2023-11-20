Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF177F0B73
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 05:38:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r4w2U-0000CO-9j; Sun, 19 Nov 2023 23:37:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leo.yan@linaro.org>)
 id 1r4w2S-0000Bq-DZ
 for qemu-devel@nongnu.org; Sun, 19 Nov 2023 23:37:36 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <leo.yan@linaro.org>)
 id 1r4w2Q-000398-Cy
 for qemu-devel@nongnu.org; Sun, 19 Nov 2023 23:37:35 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6cb9dd2ab56so374064b3a.3
 for <qemu-devel@nongnu.org>; Sun, 19 Nov 2023 20:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700455052; x=1701059852; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Inz4zYuY3MEw7YVVxuPhOcABGXtKvBqlQyTklQkUAvk=;
 b=YIhTNVxZCCoibASHoFtWVNjHV38nfeA7JmEClTAed6S5X6g1sGrkEwM2v5nJ8heQk5
 4hq8D4U/C7tZLGqrd7f22jBeBazSbuPegNclAl0Ap47Y13/qzphy9Zm0HRZIj2pVBpqV
 4WL9NQ2IhPC0d2dA+qkNh8Lk90YaOfpYmNbcEtCx3yb3RCAa/5yCmW8dkWcOwWN/CERo
 3ErMRV8H+0H1oIf21mCmy4yNaxrXZ5TxivbhGAdR/+FdUdVBLOzPOo+V99BOC6pliIMZ
 IZN2pckI0Z1AMZKqm8PoZkkhhJEunMoboLIFjd1kzL62BSwEQY7lTdUGZj+Hu96eh7nV
 jh4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700455052; x=1701059852;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Inz4zYuY3MEw7YVVxuPhOcABGXtKvBqlQyTklQkUAvk=;
 b=t1IBgryVqOKnUckui3FgrO9a5NIKNdVdFt5+/1tfX2c2zyd/wc3MO7isG5QWzK/5JL
 dgz8SqP94LAkHsoMX0YON4VsJIdAbqlmtlrlbpzXLZK6SJu/yBzBulGpWbDjzGLZGoVe
 UrFKZ9sL9ibpfjCnvhAxa6uL2PYg1EAOBkP52s/ucT8RYCnbCg8Sj6YLjcguaQb/dynS
 OH0rOjU2vdOq5BeHpr7PpjFte9k+SzOMXPRtDJ7DSWte7QSOhTkD7zOFW6sWP4ZQLA/6
 PiIvSpKzAw4i6bw5AIYLoBjbro97MPGZZNo+jPDF+nrRA0lW/RCBJngKWCMF/Nq7Kqt2
 128A==
X-Gm-Message-State: AOJu0Yy+nHtLmBj9qV9n8TmfAuSmecLZngBSHcfOX4eLdiQA2W9jEKaQ
 dzm6SMvO57SpnOXb49o1x7QIUZMxo5pziim5oJL5TCxSJYOS1w==
X-Google-Smtp-Source: AGHT+IGNBWb5snHXbQeXcOxlfJNFoPrTPvStl3eSzEiyOxs/pbvJSVzieLbtmCFskVSCczv0Go5H0A==
X-Received: by 2002:a05:6a00:c87:b0:6cb:8c5e:6bec with SMTP id
 a7-20020a056a000c8700b006cb8c5e6becmr1931004pfv.9.1700455052003; 
 Sun, 19 Nov 2023 20:37:32 -0800 (PST)
Received: from leoy-yangtze.lan (211-75-219-202.hinet-ip.hinet.net.
 [211.75.219.202]) by smtp.gmail.com with ESMTPSA id
 s41-20020a056a0017a900b006926d199fdcsm5035991pfg.190.2023.11.19.20.37.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Nov 2023 20:37:30 -0800 (PST)
From: Leo Yan <leo.yan@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 0/4] virtio: Refactor vhost input stub
Date: Mon, 20 Nov 2023 12:37:17 +0800
Message-Id: <20231120043721.50555-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=leo.yan@linaro.org; helo=mail-pf1-x42f.google.com
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

This series is to refactor vhost stub vhost-user-input.

Since vhost input stub requires set_config() callback for communication
event configurations between the backend and the guest, patch 01 is a
preparison for support set_config() callback in vhost-user-base.

The patch 02 is to add documentation for vhost-user-input.

The patch 03 is to move virtio input stub from the input folder to the
virtio folder.

The patch 04 derives vhost-user-input from vhost-user-base.  We reuse
the common code from vhhost-user-base as possible and the input stub is
simplized significantly.

This patch set has been tested with the backend daemon:

  # ./build/contrib/vhost-user-input/vhost-user-input \
		     -p /dev/input/event20 -s /tmp/input.sock

The series is based on "[PATCH v8 0/7] virtio: cleanup
vhost-user-generic and reduce c&p" which introduces vhost-user-base.
Based-on: <20231107180752.3458672-1-alex.bennee@linaro.org>

Changes from v2:
- Created reference for shared memory object and updated
  vhost-user-input.rst respectively. (Marc-André)

Changes from v1:
- Fixed typo in vhost-user-input.rst.
- Updated MAINTAINERS for new added input document and
  changing folder for vhost-user-input.c. (Manos)


Leo Yan (4):
  hw/virtio: Support set_config() callback in vhost-user-base
  docs/system: Add vhost-user-input documentation
  hw/virtio: Move vhost-user-input into virtio folder
  hw/virtio: derive vhost-user-input from vhost-user-base

 MAINTAINERS                              |   3 +-
 docs/system/device-emulation.rst         |   1 +
 docs/system/devices/vhost-user-input.rst |  45 ++++++++
 docs/system/devices/vhost-user.rst       |   4 +-
 hw/input/meson.build                     |   1 -
 hw/input/vhost-user-input.c              | 136 -----------------------
 hw/virtio/meson.build                    |   4 +-
 hw/virtio/vhost-user-base.c              |  17 +++
 hw/virtio/vhost-user-input-pci.c         |   3 -
 hw/virtio/vhost-user-input.c             |  58 ++++++++++
 include/hw/virtio/virtio-input.h         |   6 +-
 11 files changed, 132 insertions(+), 146 deletions(-)
 create mode 100644 docs/system/devices/vhost-user-input.rst
 delete mode 100644 hw/input/vhost-user-input.c
 create mode 100644 hw/virtio/vhost-user-input.c

-- 
2.39.2


