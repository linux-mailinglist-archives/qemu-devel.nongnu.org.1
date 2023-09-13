Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F94F79E0E4
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 09:36:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgKPN-0007Sb-DF; Wed, 13 Sep 2023 03:35:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qgKP0-0007FS-IQ
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 03:35:13 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qgKOy-0001z5-2q
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 03:35:10 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-401bbfc05fcso71309465e9.3
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 00:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694590506; x=1695195306; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ex2wYhsS71++plSwD4vywQfTwawR7Om/B/i5Q+QelHk=;
 b=O9LKkuXI1PPhUN1yYs+0nrOhSEVVonfPvAsO+YZL14cvZixpnI/UORmYdllFPAOKjp
 QfbS1LUkAJikhB7r7EoQ+LHsY7xm5QMo1FuDwefG0dkKDvsv+r40jx8kUMYdym9zM8Mu
 MTaBM4FMVh9OFE+gSF7WqRnIRb+nA6FwjFUnhDFMv2aEmPm80iULuWyYDxpxX8Y9GfU6
 N8Cif+ciXR/qJhseycIOHEyqAT8U2FiGi0KcesiqD7FjghmuIbYPCQwDWD7Dkv1UxOKG
 Ix9iHAS+SAJbQx1BfHFovnOygccPM0MAEIFeU46on65yD5yDYUtZzuhr8CAAqqsDBjvn
 VhWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694590506; x=1695195306;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ex2wYhsS71++plSwD4vywQfTwawR7Om/B/i5Q+QelHk=;
 b=IK+u1kUVPyJ0ZpgF5c5pQ3pTzq4mJQVcB7iEHWrwItbV7Ayr72bPnlOpSljChHb8hy
 dyM1IDBRiMI1/oAhQhpg2xVOjaOyFRhBLMKu3ptKWlCkz8vHj5Uwb1yjUc4ltOgN1Erq
 ugRYme4P2qCxsE3nFzLhUO46asOlwm/RmijhmTtpXe71vOe8JYcbbw4GE+rxLqOs8YCG
 OtGe5HYJLj8VriFxm2x/pe30Kr3rEoI0pqxW6gPOOlBBt0uKMK1O/EpwrEpGzAxZ4Sqp
 09wSkda+9b5+JBbsgCTQrB1HcsZJ2NBh5kzgD3yAF/2L0HrttVSo4405xhwnBGRkv/80
 T0HQ==
X-Gm-Message-State: AOJu0YxZ+VF7Yr4luaxVbmujKUyl4MZfeMg6c8V+C3tZTnuhRrWIdvMU
 /rTb7DZytvMD7mbu3TJvtq19VhEFUFY503IBbwA=
X-Google-Smtp-Source: AGHT+IGuse0UPOk8SI1M7KaoyP5hKqpJ9KoHxZ10njbKCyIgkmUmBes32wvd6jo1J5qqQ5rEZqYbXw==
X-Received: by 2002:adf:ebcd:0:b0:31a:d4d0:6e98 with SMTP id
 v13-20020adfebcd000000b0031ad4d06e98mr1238267wrn.8.1694590506395; 
 Wed, 13 Sep 2023 00:35:06 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 l16-20020a5d5270000000b0031c6ae19e27sm14701671wrc.99.2023.09.13.00.35.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Sep 2023 00:35:05 -0700 (PDT)
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Mark Cave-Ayland" <mark.cave-ayland@ilande.co.uk>
Subject: [PATCH v9 12/12] docs/system: add basic virtio-snd documentation
Date: Wed, 13 Sep 2023 10:33:19 +0300
Message-Id: <0a1db7cf6ea5f69bd55e4b5a669916a5cf379f76.1694588927.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1694588927.git.manos.pitsidianakis@linaro.org>
References: <cover.1694588927.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32d.google.com
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


