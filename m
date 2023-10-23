Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED1D7D3614
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 14:05:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qutfB-0005D6-IP; Mon, 23 Oct 2023 08:04:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qutf4-0005Cj-N6
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 08:04:00 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qutf2-0001u0-J3
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 08:03:58 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40839807e82so18334175e9.0
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 05:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698062631; x=1698667431; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0zthSL1JcThw35kIc/x8MAVw7jIY2hkjTwBTgdREXbw=;
 b=WpwvCZIFmrZriFs0wGMgOnEcqvDf1QyaEyWD5ER9j9whZeH0I0rkBHJHXfx6bS87kt
 q04FsABhvKW/jwgZ7ru2V8C5HnN/rIljOgiHYsiLQf14SMmcv4zadXzYTpakfdP8xtKA
 lZftw3r3JrhllybclEvd03ew/eRjXF6nVxOARKtuuFhvF6v41w7K4qxZNSdk/b8d9dXm
 +SG0uRzgEen+vJHZbjqYP+W+iYqjUhxNSOWLeO44yVSzbyLkXGLY03hAcB+G6odlov1H
 XB4F75HyNk2gysPet69AUM7fs9HM+mKhz1D9Sabc+SW0Mv2lIPolTOTdKMJW4OvrZ1En
 Uftw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698062631; x=1698667431;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0zthSL1JcThw35kIc/x8MAVw7jIY2hkjTwBTgdREXbw=;
 b=dsfkE/nk2u3XIem4aVUm4BmckgU3SG9piYVXs7dpeYUZ65M+uM9m1xT4zPGFwzkLOI
 oQ+npyjOe+YdrWKvYdm0dQFz+VtclnWxp4EujhKYuxsehld2b0Zsf4LxWpfZ3CZDY0qk
 pNgp7xnhhfIy4hdsrAF81AB0L9R8C2C9cGp/KYXDXg/QpHULpLZmpH3xsLTDMHD+XzYi
 t1jl8zaRIlNBaA3Qy9s+F2E4MEDYF2kBIUlF0VVsw96rFyM3WkYfXLTnN8CTylqVSD68
 32JTxbpEB9AlzrmJ8o/IzSYY2lxqD+MLz3mo9dVuQ5jsNf+8bGiD4fEtr0Ly7oWbB7ZW
 X88A==
X-Gm-Message-State: AOJu0YzjIvPO644Ty+hgEN1u2F+O/oM3wpA4finqhcwnvSx0zK3Q0yoA
 Bvq/Lzd2Ixtjjyy8GJFJuE8aJqFD9rOl4qbRwcU=
X-Google-Smtp-Source: AGHT+IHQsXChybrgV0ZrwMCSar/jD+bodlMtpDVH2p8nElnTae+8GVXlU4jv54rifRbJKo6OlkX8Jg==
X-Received: by 2002:a05:600c:46d1:b0:3fe:1fd9:bedf with SMTP id
 q17-20020a05600c46d100b003fe1fd9bedfmr8309723wmo.11.1698062631398; 
 Mon, 23 Oct 2023 05:03:51 -0700 (PDT)
Received: from localhost.localdomain (adsl-69.109.242.226.tellas.gr.
 [109.242.226.69]) by smtp.gmail.com with ESMTPSA id
 p12-20020a05600c418c00b0040773c69fc0sm13819506wmh.11.2023.10.23.05.03.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 05:03:50 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
	"Gerd Hoffmann" <kraxel@redhat.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Igor Skalkin" <Igor.Skalkin@opensynergy.com>,
 "Anton Yakovlev" <Anton.Yakovlev@opensynergy.com>,
 "Paolo Bonzini" <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Marcel Apfelbaum" <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Eduardo Habkost" <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?= <DirtY.iCE.hu@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Mark Cave-Ayland" <mark.cave-ayland@ilande.co.uk>,
 "Stefano Garzarella" <sgarzare@redhat.com>
Subject: [PATCH v13 00/11] Add VIRTIO sound card
Date: Mon, 23 Oct 2023 15:03:17 +0300
Message-Id: <cover.1698062525.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32a.google.com
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

This patch series adds an audio device implementing the recent virtio
sound spec (1.2) and a corresponding PCI wrapper device.

v13 can be found online at:

https://gitlab.com/epilys/qemu/-/tree/virtio-snd-v13

Ref e7fb941cf7636fdff40cbdcdcd660dec5f15ca3c

Main differences with v12 patch series [^v12]:

- Fixed device aliases (thanks Volker Rümelin <vr_qemu@t-online.de>)

v11[^v11] -> v12[^v12]
======================

- Moved devices from hw/virtio under hw/audio.

v10[^v10] -> v11[^v11]
======================

- Rebased against upstream, which has minor changes to the AUD_* API.
- Fixed noise in playback because of invalid bounds when accessing the
  audio data in the VirtQueueElement.
- Refactor invalid I/O message queue flushing into separate function.
- Removed attempt to write unwritten bytes to QEMU sound backend when
  flushing: it should only happen when the stream STARTs.
- Set latency_bytes to buffer size when returning TX I/O message because
  it happens immediately after writing the last bytes to the QEMU
  backend, therefore there might be up to <buffer size> bytes to be
  played before all the buffer data has finished playing.
- Addressed [^v10] review comments:
  - Refactored VirtIOSoundPCMBuffer return code into a function instead
    of using goto labels in output/input audio callbacks. (Suggested by
    <philmd@linaro.org>)

v9[^v9] -> v10[^v10]
====================

- Addressed [^v9] review comments.
- Copy buffer data just before playing it on the host instead of when
  the IO message arrives. This in most cases takes care of the buffer
  not being populated with data from the guest application when it
  firsts arrives.

v8[^v8] -> v9[^v9]
==================

- Addressed [^v8] review comments.
- Add cpu_to_le32(_) and le32_to_cpu(_) conversions for messages from/to
  the guest according to the virtio spec.
- Inlined some functions and types to reduce review complexity.
- Corrected the replies to IO messages; now both Playback and Capture
  work correctly for me. (If you hear cracks in pulseaudio+guest, try
  pipewire+guest).

v7[^v7] -> v8[^v8]
==================

- Addressed [^v7] review comments.
  Functions that were called from more than one place for code re-use
  are not created until they are actually needed.
- Fixed cases where block->offset was not respected in Playback

v6[^v6] -> v7[^v7]
==================

- Removed minor stale/duplicate code.
- Addressed [^v6] review comments.
  Notably, the audio driver name is now `virtio` instead of
  `virtio-sound`.
- Fixed some invalid pointer logic.
- Fixed minor typos and updated documentation.

v5[^v5] -> v6[^v6]
==================

- Free any existing PCM stream resources before allocating a new one.
- Add docs.

v4[^v4] -> v5[^v5]
==================

- Use ERRP_GUARD() to propagate errors.
- Use virtio_add_feature() instead of XORing constants.
- Use %zu format specifier for size_t.

v3[^v3] -> v4[^v4]
==================

- Addressed review style comments.
- Split patches for easier review.

v2[^v2] -> v3[^v3]
==================

- Addressed review comments.

v1[^v1] -> v2[^v2]
==================

- Split virtio-snd and virtio-snd-pci devices to two commits
- Added audio capture support

Previously:

[^v12]:
https://lore.kernel.org/qemu-devel/cover.1697709630.git.manos.pitsidianakis@linaro.org/
[^v11]:
https://lore.kernel.org/qemu-devel/cover.1696935992.git.manos.pitsidianakis@linaro.org/
[^v10]:
https://lore.kernel.org/qemu-devel/cover.1695996196.git.manos.pitsidianakis@linaro.org/
[^v9]:
https://lore.kernel.org/qemu-devel/cover.1694588927.git.manos.pitsidianakis@linaro.org/
[^v8]:
https://lore.kernel.org/qemu-devel/cover.1693252037.git.manos.pitsidianakis@linaro.org/
[^v7]:
https://lore.kernel.org/qemu-devel/cover.1692731646.git.manos.pitsidianakis@linaro.org/
[^v6]:
https://lore.kernel.org/qemu-devel/cover.1692089917.git.manos.pitsidianakis@linaro.org/
[^v5]:
https://lore.kernel.org/qemu-devel/cover.1690626150.git.manos.pitsidianakis@linaro.org/
[^v4]:
https://lore.kernel.org/qemu-devel/cover.1689857559.git.manos.pitsidianakis@linaro.org/
[^v3]:
https://lore.kernel.org/qemu-devel/cover.1689692765.git.manos.pitsidianakis@linaro.org/
[^v2]:
https://lore.kernel.org/qemu-devel/cover.1686238728.git.manos.pitsidianakis@linaro.org/
[^v1]:
https://lore.kernel.org/qemu-devel/20230526204845.673031-1-manos.pitsidianakis@linaro.org/

Manos Pitsidianakis (11):
  Add virtio-sound device stub
  Add virtio-sound-pci device
  virtio-sound: handle control messages and streams
  virtio-sound: handle VIRTIO_SND_R_PCM_INFO request
  virtio-sound: handle VIRTIO_SND_R_PCM_{START,STOP}
  virtio-sound: handle VIRTIO_SND_R_PCM_SET_PARAMS
  virtio-sound: handle VIRTIO_SND_R_PCM_PREPARE
  virtio-sound: handle VIRTIO_SND_R_PCM_RELEASE
  virtio-sound: implement audio output (TX)
  virtio-sound: implement audio capture (RX)
  docs/system: add basic virtio-snd documentation

 MAINTAINERS                        |    9 +
 docs/system/device-emulation.rst   |    1 +
 docs/system/devices/virtio-snd.rst |   49 +
 hw/audio/Kconfig                   |    5 +
 hw/audio/meson.build               |    2 +
 hw/audio/trace-events              |   20 +
 hw/audio/virtio-snd-pci.c          |   93 ++
 hw/audio/virtio-snd.c              | 1409 ++++++++++++++++++++++++++++
 include/hw/audio/virtio-snd.h      |  235 +++++
 system/qdev-monitor.c              |    2 +
 10 files changed, 1825 insertions(+)
 create mode 100644 docs/system/devices/virtio-snd.rst
 create mode 100644 hw/audio/virtio-snd-pci.c
 create mode 100644 hw/audio/virtio-snd.c
 create mode 100644 include/hw/audio/virtio-snd.h


base-commit: 384dbdda94c0bba55bf186cccd3714bbb9b737e9
-- 
2.39.2


