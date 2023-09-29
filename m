Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED49F7B345A
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 16:11:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmECG-0000iA-UY; Fri, 29 Sep 2023 10:10:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qmECE-0000gx-Lq
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 10:10:22 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qmEC8-0004Zd-Kj
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 10:10:22 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-31c5cac3ae2so13513909f8f.3
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 07:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695996612; x=1696601412; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=meHDN0oOPKm9Oa/5/fpc+y7vAS4OIWvBNytYsm6ntxM=;
 b=r4/LambGD27VUbrpNc4X3SFVhpodZkBxQXLiZyDKi/bhByXMtfw6qiEKqCjDMWMzle
 eu9sj1B5GLx8sY6Dl9SA+LcQG/bqKdOR2/nOeKrEnM36pF3ta1PTZZGooYu04MrYeYsI
 pNTPdb+4EmWlIM8XuUzpUyZ6XBrLhx9KuSMprbjSBB7ruRBoKGn3Z4Uw02EYdeSn/5gr
 D7vif+8pQXNd7QbAmqjtTp2vHJO9EMOCzE6GxLmdinb7Jd5IVkWtxEjPQsRtwOzqVAQ+
 OIyQ1mv1n8rFQ5dT4cKu5xICh08sZuS74BplPQwM0TCCvNJDBYPEqmsAM/i1hO32sbWL
 0IjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695996612; x=1696601412;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=meHDN0oOPKm9Oa/5/fpc+y7vAS4OIWvBNytYsm6ntxM=;
 b=sLoD/6lAA2s1PP3k2kF3sWBVeGWLMPU1+YlMMi+0mmWH/KkSR15++l7tZ4eMSc03Wf
 gEfenBsHIekdp7fyfn1waIaBq23hs7BuXwJhKOn80HbT1Jyr4M+4jeM4gy347hpIMzJG
 l5mw4lgmNNAFkTZ+Idzqr4W7bel/j57lz0T9yLLX6nGyQl5PiM8yrtYdI+wlYWZf5GqQ
 feRMr1Rl6HOYFz4n07UFZgJ2F+F8rliGQXBiNdVVrY5izdNMrBc7j6WN09/3cHJHxXEX
 9dJDdgFdXTudWmdM9PFyFOGRCemumuWeRxJbVfRQs/Rl40nr86KnEE6HmU/yuodjW9yq
 J42g==
X-Gm-Message-State: AOJu0Yysb/CTVYsCDzZzWxT1KNsM7TcO6gHx0yn3vLL95xWTnPLMCvPX
 oZswcZxRNXOX8F4B8gEG9uCvcNxcLBsrMcC2HuM=
X-Google-Smtp-Source: AGHT+IEUTYbga+ChPI2GDng1x3uIEgNVksW1G8VBLFaaCGHYVXSoPxrFCjrzxsS21VFChSs8x5c5DQ==
X-Received: by 2002:a05:6000:1b0c:b0:319:790e:3bc5 with SMTP id
 f12-20020a0560001b0c00b00319790e3bc5mr3207602wrz.41.1695996612638; 
 Fri, 29 Sep 2023 07:10:12 -0700 (PDT)
Received: from localhost.localdomain (adsl-98.37.6.1.tellas.gr. [37.6.1.98])
 by smtp.gmail.com with ESMTPSA id
 y20-20020a7bcd94000000b004030e8ff964sm1505232wmj.34.2023.09.29.07.10.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Sep 2023 07:10:12 -0700 (PDT)
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
Subject: [PATCH v10 11/11] docs/system: add basic virtio-snd documentation
Date: Fri, 29 Sep 2023 17:08:31 +0300
Message-Id: <b720e00121878cb91c9690fd1f9ca609b9484346.1695996196.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1695996196.git.manos.pitsidianakis@linaro.org>
References: <cover.1695996196.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 MAINTAINERS                        |  1 +
 docs/system/device-emulation.rst   |  1 +
 docs/system/devices/virtio-snd.rst | 49 ++++++++++++++++++++++++++++++
 3 files changed, 51 insertions(+)
 create mode 100644 docs/system/devices/virtio-snd.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index 81ca61e90b..7c5a47bed5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2246,6 +2246,7 @@ M: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
 S: Supported
 F: hw/virtio/virtio-snd*.c
 F: include/hw/virtio/virtio-snd.h
+F: docs/system/devices/virtio-snd.rst
 
 nvme
 M: Keith Busch <kbusch@kernel.org>
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


