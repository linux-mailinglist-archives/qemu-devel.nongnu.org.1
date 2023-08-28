Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC2378B8BD
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 21:57:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaiLh-00038m-9f; Mon, 28 Aug 2023 15:56:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qaiLc-0002w7-W7
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 15:56:29 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qaiLa-0005Qf-Os
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 15:56:28 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-31dcf18f9e2so779310f8f.0
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 12:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693252585; x=1693857385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ex2wYhsS71++plSwD4vywQfTwawR7Om/B/i5Q+QelHk=;
 b=ya+ZRGFqfv4mhJGjqRN5Yj1HADs8jWRa5SaETeW5TlpzLdHorXSVik9BBJPMU875Kt
 pBqrVSs8YGuY8dbd6OHLsMrhG//3bRu+kfQIYrPklqpQXCSBHHLy/WoYoQ8vcgKDiKfC
 uLFq8FQcxRTPj2UdTJEABBvYKiLwjx6fQywC8gJDml+Wl5SFFAK99sdTeyRI+q63fbn2
 eZnUqNqyY6GDUyOchP5NFqMy00hFJzqGc2cX7m5ZU/GkGWX7dGkt+eK6HC9bbsEcQKAY
 Jnjq1+dHx9Njm2wKqmMIYGR0sHBr5B8faAo6LArUOYzrC2ZqwG0Mp0uPfRI4AVMAJ/lM
 fNMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693252585; x=1693857385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ex2wYhsS71++plSwD4vywQfTwawR7Om/B/i5Q+QelHk=;
 b=SpiLhKYjLVZk4qNgzndeDbiqQdZOUULoNp8yiSTUUiUWN+0VsJmxmIBkeVyp7wykmV
 X4FVk2scrJqDcNWnGVA4CzSgnQpZ1YXPMNhg3PELl+0gF13vfqV5RIYp1k2H+pQ6uEwd
 WbhaNC53Ouv/j7FBn4nxLwOa87OWrguPiv3QgPkKJ0mTrIUzdc6Oz1Dm2JViL6ffXgDK
 2KFDp7ULf6LpnZgOWT+J32gFNuKUjzxyG81NG7ydN3pBW9jeA3WrZaw10yS7w0tlMOKs
 30Fz52rPs5+ke0HiaRFq+bzQ9rpWvSF+cKRBSP1TddvpAXtElC6x5UgXWXPJeC7sXisw
 fnoQ==
X-Gm-Message-State: AOJu0YySAPvY81GPtSIK1K95hI/ElF64JHfUVLyIhNbMbn67JRTR9Tw2
 +u4B8kLp8UV+JdRSpwYAEA/pZ1bVP2bADCP1Od8=
X-Google-Smtp-Source: AGHT+IHlgUhv9kkTm8KOrbpL/jhwzpnkUr0C8nJq46NzDkQsR/Jd6CdADciVF1hq9Uef01nCb5dKdw==
X-Received: by 2002:a5d:4492:0:b0:319:8dd4:fa62 with SMTP id
 j18-20020a5d4492000000b003198dd4fa62mr20087896wrq.53.1693252585107; 
 Mon, 28 Aug 2023 12:56:25 -0700 (PDT)
Received: from localhost.localdomain (adsl-194.37.6.2.tellas.gr. [37.6.2.194])
 by smtp.gmail.com with ESMTPSA id
 l9-20020a056000022900b0031c8a43712asm7529717wrz.69.2023.08.28.12.56.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 12:56:24 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Igor Skalkin" <Igor.Skalkin@opensynergy.com>,
 "Anton Yakovlev" <Anton.Yakovlev@opensynergy.com>,
 "Paolo Bonzini" <pbonzini@redhat.com>, "Gerd Hoffmann" <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Marcel Apfelbaum" <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Eduardo Habkost" <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?= <DirtY.iCE.hu@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v8 12/12] docs/system: add basic virtio-snd documentation
Date: Mon, 28 Aug 2023 22:55:09 +0300
Message-Id: <69eb5f4fbae731f5fc05dea8a5f4b656e0de127f.1693252037.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1693252037.git.manos.pitsidianakis@linaro.org>
References: <cover.1693252037.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42b.google.com
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

This commit adds basic documentation for using virtio-snd.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 docs/system/device-emulation.rst   |  1 +
 docs/system/devices/virtio-snd.rst | 49 ++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)
 create mode 100644 docs/system/devices/virtio-snd.rst

diff --git a/docs/system/device-emulation.rst b/docs/system/device-emulation.rst
index 4491c4cbf7..dae19446e5 100644
--- a/docs/system/device-emulation.rst
+++ b/docs/system/device-emulation.rst
@@ -92,6 +92,7 @@ Emulated Devices
    devices/usb.rst
    devices/vhost-user.rst
    devices/virtio-pmem.rst
+   devices/virtio-snd.rst
    devices/vhost-user-rng.rst
    devices/canokey.rst
    devices/usb-u2f.rst
diff --git a/docs/system/devices/virtio-snd.rst b/docs/system/devices/virtio-snd.rst
new file mode 100644
index 0000000000..2a9187fd70
--- /dev/null
+++ b/docs/system/devices/virtio-snd.rst
@@ -0,0 +1,49 @@
+virtio sound
+============
+
+This document explains the setup and usage of the Virtio sound device.
+The Virtio sound device is a paravirtualized sound card device.
+
+Linux kernel support
+--------------------
+
+Virtio sound requires a guest Linux kernel built with the
+``CONFIG_SND_VIRTIO`` option.
+
+Description
+-----------
+
+Virtio sound implements capture and playback from inside a guest using the
+configured audio backend of the host machine.
+
+Device properties
+-----------------
+
+The Virtio sound device can be configured with the following properties:
+
+ * ``jacks`` number of physical jacks (Unimplemented).
+ * ``streams`` number of PCM streams. At the moment, no stream configuration is supported: the first one will always be a playback stream, an optional second will always be a capture stream. Adding more will cycle stream directions from playback to capture.
+ * ``chmaps`` number of channel maps (Unimplemented).
+
+All streams are stereo and have the default channel positions ``Front left, right``.
+
+Examples
+--------
+
+Add an audio device and an audio backend at once with ``-audio`` and ``model=virtio``:
+
+ * pulseaudio: ``-audio driver=pa,model=virtio``
+   or ``-audio driver=pa,model=virtio,server=/run/user/1000/pulse/native``
+ * sdl: ``-audio driver=sdl,model=virtio``
+ * coreaudio: ``-audio driver=coreaudio,model=virtio``
+
+etc.
+
+To specifically add virtualized sound devices, you have to specify a PCI device
+and an audio backend listed with ``-audio driver=help`` that works on your host
+machine, e.g.:
+
+::
+
+  -device virtio-sound-pci,audiodev=my_audiodev \
+  -audiodev alsa,id=my_audiodev
-- 
2.39.2


