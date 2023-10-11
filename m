Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFF37C5700
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 16:37:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqaK2-00019M-Bg; Wed, 11 Oct 2023 10:36:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qqaJz-00018C-5h
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:36:23 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qqaJx-0005oP-BJ
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:36:22 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3247cefa13aso6282148f8f.1
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 07:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697034979; x=1697639779; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ufC+dD4Md7A3Zyn0mFl7NjM0gBjP2OM76JBiL0XIFTA=;
 b=AuiB7DZU9qlwZMRuEONJvDSA+nML65rVX8DlgpTXWImWvbUV+Ih2glKDslUGPWP8su
 T/1mmxUAWrpJ5qWcmudObcdSTwvCadotOkZmv+vGg7d/9XnEdQBuJl2C2QVXXj8U1LhS
 Ypn7LjcD4l1xFrT/gSTGdvt6NOZxMsmwv2matkH0Le6Fag/lIIQ31lXIFyUNcWCOYBqB
 BshLpzCOlshHgfCFquh0j+BPRWJv2YTULh6TyDPaqcUjYON8e2LiVUxvdHYGSVYosBz2
 UGeM7DjjfuFqUqUOZE/VNHOXd3yIdFLrUNjeWxYMa8ijqvjkRRfqoKBL7yzxo7HuZOqd
 P6ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697034979; x=1697639779;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ufC+dD4Md7A3Zyn0mFl7NjM0gBjP2OM76JBiL0XIFTA=;
 b=YYJYzzOSr8MFekqZwJ1QuiuI1VM0C/m8GK5Mry902WQdLb++9h/F2ht4Sy8XIzdG9T
 09RYzJKYcEXDg/cTBm0VnjIVCA410Jm7sMJ3oydavmg5U3jSw9df19eH7FV+reDs3YCc
 tDPBkvCcGF1JMldL9hc7VYksRbw+B/WqOYATbtlm4Tgj+KwUkaNQ+9ywq60PS9sxwZ4v
 X+A3wenMVftALEx/EjzoEqPseHM+brvt0vnywFPuCyFjlFvISESP0AdtXUZo8YpOMhVt
 xIMGooRvzxZX69vBPQDkX2NqK7rrXLKM3BNIrrECV4uNAoZipYi/IEtmnU3nl1kIk0MB
 4Gqw==
X-Gm-Message-State: AOJu0Yxm7Q1xP7pgtT/AndynQU+vQ6x1Uv44RG3J/tyFDIFGYM4pvNBk
 Ogf28bjVHUJ98Iib7rbMXCZMGMOn6AEL2odjB6M=
X-Google-Smtp-Source: AGHT+IFixuiyrXL/KosL2gSt6U6TvT2/Iew3TGKNaikPZOFH7ravNQb+GoYSXt2Tdv8ToPFal3ZHbA==
X-Received: by 2002:a5d:48cb:0:b0:322:707e:a9fd with SMTP id
 p11-20020a5d48cb000000b00322707ea9fdmr16920177wrs.34.1697034979447; 
 Wed, 11 Oct 2023 07:36:19 -0700 (PDT)
Received: from localhost.localdomain (adsl-26.37.6.0.tellas.gr. [37.6.0.26])
 by smtp.gmail.com with ESMTPSA id
 n8-20020a5d4208000000b003253523d767sm15599869wrq.109.2023.10.11.07.36.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 07:36:18 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Google-Original-From: Manos Pitsidianakis <manos@pitsidianak.is>
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
 "Mark Cave-Ayland" <mark.cave-ayland@ilande.co.uk>,
 "Stefano Garzarella" <sgarzare@redhat.com>
Subject: [PATCH v11 11/11] docs/system: add basic virtio-snd documentation
Date: Wed, 11 Oct 2023 17:34:56 +0300
Message-Id: <885b01fe272541fdab5583780d4c3a59bfd8e734.1696935992.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1696935992.git.manos.pitsidianakis@linaro.org>
References: <cover.1696935992.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>

This commit adds basic documentation for using virtio-snd.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 MAINTAINERS                              |  1 +
 docs/system/device-emulation.rst         |  1 +
 docs/system/devices/virtio-snd.rst (new) | 49 ++++++++++++++++++++++++
 3 files changed, 51 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 701f12026a..a32e512a61 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2259,6 +2259,7 @@ M: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
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
@@ -79,20 +79,21 @@ in a PCI slot to the exclusive use of the guest.
 Emulated Devices
 ~~~~~~~~~~~~~~~~
 
 .. toctree::
    :maxdepth: 1
 
    devices/can.rst
    devices/ccid.rst
    devices/cxl.rst
    devices/ivshmem.rst
    devices/keyboard.rst
    devices/net.rst
    devices/nvme.rst
    devices/usb.rst
    devices/vhost-user.rst
    devices/virtio-pmem.rst
+   devices/virtio-snd.rst
    devices/vhost-user-rng.rst
    devices/canokey.rst
    devices/usb-u2f.rst
    devices/igb.rst
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


