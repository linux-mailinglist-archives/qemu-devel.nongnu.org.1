Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81EDB7CF4A2
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 12:06:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtPtl-0004Hh-Fx; Thu, 19 Oct 2023 06:05:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qtPti-0004HC-K0
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 06:04:58 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qtPtf-00039p-5V
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 06:04:57 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-507c5249d55so3224783e87.3
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 03:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697709892; x=1698314692; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+JG26xVIG/welpgP2Z7phWQDVgc+NAbnYlDOSgYpntU=;
 b=egIiaWwcPeU+0bka4d4t9rew/Cozd6RvRuB9lK8WWAi/LUphB1UwSJksQ7/5Hy6HXE
 Rpq8xbKOYJGPfAZD7cFK/SHdsBtT4QCIebshUVN3aOdkLgXUeWgcAeLEXgV2aAW7Doxe
 xIwfYxM8UcCcnD8WFWkuCgNohHVPK+B2jZDtXaJGe3cMQvewT/I7uJyq5MFN68ngDIjk
 YeCj2TDwe+dBdGt7PqFubW6s9gyF8gNsvLLUD/81QBvjaLVANJgE4NWBzAYbfh4YtjHt
 lXzovZImN8FN7nTe7kMNruvuSzXI9jnWZUCR3j1v8//AIjJsKjLZDAaYxq/aJUl7gvwV
 CfVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697709892; x=1698314692;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+JG26xVIG/welpgP2Z7phWQDVgc+NAbnYlDOSgYpntU=;
 b=dZlrnZU0KGaiNXTU4LNC9ZdC1P/EL9f1RTd+p6xeTHoOgO5kkOpqzA4jnmvqPUv/Ip
 tFigusbeNcg7fpUDuEXyEP/7Q6C327sIEibTQY9X8enh+m1gYsTuknEdWzBwpZOMd4Hd
 m2T1CNApDaEl0UM3PmcEHSLoc6jqoD7Z1fQGWO1nuMH8F2OmA8mIpzkZD2otW7RRXfut
 eZf1uTXV7MMHOneW0v03DoCxVUcnGcW6Aj/0d16TIH2GnCC7+tagTnvv2EyaVvZRKKbW
 x9xNxXBgiwoEY7HEykSEfTK20Ux3YPWjJIHO7Id7NfNvuB85hWzHrT0t97tsRbjZ7J4L
 jQ2w==
X-Gm-Message-State: AOJu0Yzw2O4n/8sFPdylcX73KvadVbX38HG9geSq/M7gVGOn4UDeMgOB
 iHxdt5yXZCtvVTuxmy9/jZC8mxyNQLotux5UlXY=
X-Google-Smtp-Source: AGHT+IFtvLgv8bfdXeQQkPviQN6+KeSu2oe5Dt8qoPhVmtFsrxw7uRRthQYGS6fwL62LOuzfgdvAlA==
X-Received: by 2002:a05:6512:201b:b0:507:9ef2:fb1c with SMTP id
 a27-20020a056512201b00b005079ef2fb1cmr1087094lfb.2.1697709892331; 
 Thu, 19 Oct 2023 03:04:52 -0700 (PDT)
Received: from localhost.localdomain (adsl-141.37.6.162.tellas.gr.
 [37.6.162.141]) by smtp.gmail.com with ESMTPSA id
 d13-20020a5d538d000000b003232d122dbfsm4110307wrv.66.2023.10.19.03.04.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 03:04:51 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
	"Gerd Hoffmann" <kraxel@redhat.com>
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
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
Subject: [PATCH v12 00/11] Add VIRTIO sound card
Date: Thu, 19 Oct 2023 13:03:44 +0300
Message-Id: <cover.1697709630.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lf1-x130.google.com
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

v12 can be found online at:

https://gitlab.com/epilys/qemu/-/tree/virtio-snd-v12

Ref c660c8427853d90784a89b6f3b0c31e19cc3be95

Main differences with v11 patch series [^v11]:

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

Emmanouil Pitsidianakis (11):
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
 system/qdev-monitor.c              |    1 +
 10 files changed, 1824 insertions(+)
 create mode 100644 docs/system/devices/virtio-snd.rst
 create mode 100644 hw/audio/virtio-snd-pci.c
 create mode 100644 hw/audio/virtio-snd.c
 create mode 100644 include/hw/audio/virtio-snd.h


base-commit: deaca3fd30d3a8829160f8d3705d65ad83176800
-- 
2.39.2


