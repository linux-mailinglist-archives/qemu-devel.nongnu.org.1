Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E2A7BD7CA
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 12:00:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpn3B-0006Un-WE; Mon, 09 Oct 2023 05:59:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qpn39-0006UM-5l
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 05:59:44 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qpn37-000818-Fs
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 05:59:42 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40684f53d11so43277015e9.1
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 02:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696845579; x=1697450379; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1XLFDaMHZCEg2LGyweqzWt7sDWsIdqiMwYyFkHjOtX4=;
 b=t6vZ9usaakMjR77XECn9ycoUlHn0XWY0J9rs4UOTZnrEptc0ofcBDKVTSLMxshaY8U
 ZBm0qiqoaCh4tEu+t26nTWPaqnaBj8fXp6ClO6HFXYU/EarXYKCxzP5KKAApASNDlp3m
 Rf28XVSHjf3GWLIgWixwOorpM+72NAnI1UlKhQSc+bQdYspj31XCG0yCxa0kZNECtoKE
 wN3qGzqGDDtL0VbUqi09mx7lUYJJHeXu1QWaPvKim1XkegknLnZex3MCzK6sPRKYtRs6
 zgt+AXCX31Lc+BQlEix/LG5RHCl14quKE/qWQ15ES7AAMf/zsBSIXtIwS1rE+hrl5dU+
 AsGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696845579; x=1697450379;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1XLFDaMHZCEg2LGyweqzWt7sDWsIdqiMwYyFkHjOtX4=;
 b=hTjtbBqGkmeDVr7/w0uVaO29CdE1+aytt+aPXyx2t3DgoAIJ9dTJXvyo1Co0zHNjbo
 tmiMtAplqbCIsC7pSSuXriM6U6L/BK/bO8GJtZJabHCfqvuA0ool/BWU+U7Rr52u47I3
 Wnx9Fg2z6faCoUcAbKiUc+7Nj7P/eNJTXc6ouCxt7tvdBxQDDtB2J36JK1jXL1vnFt1Y
 sKQVOgf9AS3OJyxKEkadk50Z3eWw7CJiO7CEvVd+zetg5gROPUvIJYz2xNOm+fbBSrak
 91E+YpAHR+OoWt40gmA5hLEsKDx7bRYgs+yCBPvjJUu97SWZixSZyBkc3ovkinEMAt9u
 QdsQ==
X-Gm-Message-State: AOJu0YxwbX6PnMm1EZ4tu/unDd6ph3nFH9VU6E/DEg1rk4KGNgVzBmrP
 h4HZ9wxdQRSOV63ZQE7IpErNBw==
X-Google-Smtp-Source: AGHT+IGHYUdEOfm45pzic6CETuCYCJKY7fov3+QQ2Ea1RiAh3YP8DX0RtqZknlnjubpDzKbxXc3pLA==
X-Received: by 2002:a5d:440f:0:b0:320:a4e:6b83 with SMTP id
 z15-20020a5d440f000000b003200a4e6b83mr13384658wrq.31.1696845579277; 
 Mon, 09 Oct 2023 02:59:39 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 d12-20020a5d538c000000b0032769103ae9sm9123739wrv.69.2023.10.09.02.59.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Oct 2023 02:59:38 -0700 (PDT)
Received: from zen.linaroharston (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 28FFD1FFBB;
 Mon,  9 Oct 2023 10:59:38 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Erik Schilling <erik.schilling@linaro.org>, Fam Zheng <fam@euphon.net>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Viresh Kumar <viresh.kumar@linaro.org>, virtio-fs@redhat.com,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Markus Armbruster <armbru@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v4 0/6] virtio: cleanup vhost-user-generic and reduce c&p
Date: Mon,  9 Oct 2023 10:59:31 +0100
Message-Id: <20231009095937.195728-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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

I've dropped the F_TRANSPORT work from this series to keep this small
and ready to merge. The changes for F_TRANSPORT are a bit more
invasive and still need a bit of debugging but I wanted to get this
stuff merged now.

Alex Bennée (5):
  virtio: split into vhost-user-base and vhost-user-device
  hw/virtio: derive vhost-user-rng from vhost-user-base
  hw/virtio: derive vhost-user-gpio from vhost-user-base
  hw/virtio: derive vhost-user-i2c from vhost-user-base
  docs/system: add a basic enumeration of vhost-user devices

Manos Pitsidianakis (1):
  hw/virtio: add vhost-user-snd and virtio-snd-pci devices

 docs/system/devices/vhost-user-rng.rst |   2 +
 docs/system/devices/vhost-user.rst     |  41 +++
 include/hw/virtio/vhost-user-base.h    |  49 +++
 include/hw/virtio/vhost-user-gpio.h    |  23 +-
 include/hw/virtio/vhost-user-i2c.h     |  14 +-
 include/hw/virtio/vhost-user-rng.h     |  11 +-
 include/hw/virtio/vhost-user-snd.h     |  26 ++
 hw/virtio/vhost-user-base.c            | 348 +++++++++++++++++++++
 hw/virtio/vhost-user-device-pci.c      |  10 +-
 hw/virtio/vhost-user-device.c          | 335 +-------------------
 hw/virtio/vhost-user-gpio.c            | 407 ++-----------------------
 hw/virtio/vhost-user-i2c.c             | 272 +----------------
 hw/virtio/vhost-user-rng.c             | 278 ++---------------
 hw/virtio/vhost-user-snd-pci.c         |  75 +++++
 hw/virtio/vhost-user-snd.c             |  67 ++++
 hw/virtio/Kconfig                      |   5 +
 hw/virtio/meson.build                  |  25 +-
 17 files changed, 705 insertions(+), 1283 deletions(-)
 create mode 100644 include/hw/virtio/vhost-user-base.h
 create mode 100644 include/hw/virtio/vhost-user-snd.h
 create mode 100644 hw/virtio/vhost-user-base.c
 create mode 100644 hw/virtio/vhost-user-snd-pci.c
 create mode 100644 hw/virtio/vhost-user-snd.c

-- 
2.39.2


