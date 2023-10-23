Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B667D3617
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 14:05:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qutgK-00062p-B4; Mon, 23 Oct 2023 08:05:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qutg4-0005hy-16
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 08:05:00 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qutg0-000234-Uv
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 08:04:59 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2c50cd16f3bso45130991fa.2
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 05:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698062694; x=1698667494; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tKVK/4/eu9JM7iQFa4YhCyu8AE+xNtq+qwGY5QZJ+tc=;
 b=KgxZZ8U1aJsSvwscL22b/Z+xup7YvMPcOKbZlpDLTVguPEmf5ViwfjPq8eDh4enCzG
 vPYXyrLIr12X719XflOJZesSAwts1bRYuegsL23osiK9e0zo7LRlCYcdi6GRSH9BzabJ
 +tD+715GXBz4amWYGIECWymy7fJFuMQFJMmS3WCogkT+Ggwpi5RsKCgjP3PcR+8a1Dzn
 dIksGWYMwhiiAgBbo6BhrKc2XdwFpTHX7JvZsoH+Flt4xLbHECTdffpnDvscJLkq8TML
 eWLDn5LCS/senQJ/2umXFsIzd6rzmroTIsOBSv2iXUO3X14P/A3yyCn9HiJOu63D5/3p
 xTwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698062694; x=1698667494;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tKVK/4/eu9JM7iQFa4YhCyu8AE+xNtq+qwGY5QZJ+tc=;
 b=k3bOvsDUHibaYvry6ExypomZKc4xEU6OPwhPUJAneLHv1WJqAQCZko/UrBxgDYIML/
 Vvn7gF4QXifzP4vHokrrVe53BS4wZ3Ca00GkKZALfQrEwpZN8KAOo2XxqGQwhagdoW8V
 Z8+PCRbQRaeF5fblvL5Zd26kFCrNIjKwpgnWIfbykEPAFS80PH5KLUQDn58ZEOr93RUV
 dQClCX2U+rfleQzHY4HrAy7AAVHJOrE9baNCf8/npVMXWviDgsvd8/lNsTVIB9aQ1HQl
 eBnebz/B1gdA0zuxaQZBmRXsegI873fMJT6zh8B9y/yNjTXGpgMoP5maIi8zCXnRPzxJ
 Yuzg==
X-Gm-Message-State: AOJu0Yx74KL+Ridazvdop2udU7BJVqzMQfeTcDXidmG81VIFHyslDiI+
 7NEL0W/EayBHkoQqsiBTCS6BidKd2Emhu79MBTw=
X-Google-Smtp-Source: AGHT+IEPKipknQD1PyBiiTdKLwaP8Z1Ir9l4hoSoKaOdbVNLQmsobv2JMaMICU46tZtW50DmpWf31w==
X-Received: by 2002:a2e:a7cc:0:b0:2c5:fb9:49b6 with SMTP id
 x12-20020a2ea7cc000000b002c50fb949b6mr8812299ljp.10.1698062694149; 
 Mon, 23 Oct 2023 05:04:54 -0700 (PDT)
Received: from localhost.localdomain (adsl-69.109.242.226.tellas.gr.
 [109.242.226.69]) by smtp.gmail.com with ESMTPSA id
 p12-20020a05600c418c00b0040773c69fc0sm13819506wmh.11.2023.10.23.05.04.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 05:04:53 -0700 (PDT)
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
Subject: [PATCH v13 11/11] docs/system: add basic virtio-snd documentation
Date: Mon, 23 Oct 2023 15:03:28 +0300
Message-Id: <e7fb941cf7636fdff40cbdcdcd660dec5f15ca3c.1698062525.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1698062525.git.manos.pitsidianakis@linaro.org>
References: <cover.1698062525.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lj1-x236.google.com
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

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
---
 MAINTAINERS                        |  1 +
 docs/system/device-emulation.rst   |  1 +
 docs/system/devices/virtio-snd.rst | 49 ++++++++++++++++++++++++++++++
 3 files changed, 51 insertions(+)
 create mode 100644 docs/system/devices/virtio-snd.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index 07e07f6b7a..e60a9b742b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2289,6 +2289,7 @@ S: Supported
 F: hw/audio/virtio-snd.c
 F: hw/audio/virtio-snd-pci.c
 F: include/hw/audio/virtio-snd.h
+F: docs/system/devices/virtio-snd.rst
 
 nvme
 M: Keith Busch <kbusch@kernel.org>
diff --git a/docs/system/device-emulation.rst b/docs/system/device-emulation.rst
index 1167f3a9f2..d1f3277cb0 100644
--- a/docs/system/device-emulation.rst
+++ b/docs/system/device-emulation.rst
@@ -93,6 +93,7 @@ Emulated Devices
    devices/vhost-user.rst
    devices/virtio-gpu.rst
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


